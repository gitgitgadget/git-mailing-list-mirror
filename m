From: Elijah Newren <newren@gmail.com>
Subject: RFC: How to handle merge-recursive corner cases?
Date: Wed, 29 Sep 2010 13:16:49 -0600
Message-ID: <AANLkTimwUQafGDrjxWrfU9uY1uKoFLJhxYs=vssOPqdf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 29 21:16:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P129A-0003IP-Si
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 21:16:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754731Ab0I2TQv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Sep 2010 15:16:51 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51230 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754662Ab0I2TQu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Sep 2010 15:16:50 -0400
Received: by fxm4 with SMTP id 4so190072fxm.19
        for <git@vger.kernel.org>; Wed, 29 Sep 2010 12:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=eDUS/pcJ7b+HEWxx708aX0PSu5QddSfBf3EWfdQOvSk=;
        b=unB2EaCrTdFgcLBfsoKJyXCVXZkSs1vzy9nFb/ypr82xMaPbB0Crpa7N35JOPpXZKt
         ncyWIGfKtk1m8jL0akVLTc4o5sPhLzjhg7qmQ0sheXhf0gXGGSU5Ez6jSJNTvHKki5Lk
         jXUkDow5RRjxewIBR4ECMu7iLfosTr/faHkJA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=mm+SlhS1V4ZfifYCPl24d7/7IglBUsL0k5oD0MOdLtxalTNrFucdqltbbvZUJdyDm3
         yuIrTtK02/fgLBY8ZsP2R8JQsgUwolV6+61tP0aJgzS198AwDfUn7Gu0jKoQNqyRwZvS
         omfUuL7iegbjhy7LkfGJawWxsDIqiOlpsEwcM=
Received: by 10.223.118.14 with SMTP id t14mr2333313faq.79.1285787809229; Wed,
 29 Sep 2010 12:16:49 -0700 (PDT)
Received: by 10.223.119.209 with HTTP; Wed, 29 Sep 2010 12:16:49 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157591>

Hi,

Sorry for the lengthy email, but I'm still working on my patch series
auditing merge-recursive corner cases, and I've run into criss-cross
merges that I don't know how to solve.  In some cases, even the
'right' answer (in terms of what unmerged entries the index should
contain when there are conflicts) isn't entirely clear to me, much
less how to implement it.  I'm hoping someone else has some bright
ideas.

The basic setup is the following:
#      B   D
#      o---o
#     / \ / \
#  A o   X   ? F
#     \ / \ /
#      o---o
#      C   E
In other words, there

Let's start with a simple though very contrived case that will
illustrate issues later, namely a repository with exactly one file
named 'file', with the following contents at different points in
history:

Commit A: file has contents 'A\n'
Commit B: file has contents 'B\n'
Commit C: file has contents 'C\n'
Commit D: file has contents 'D\n'
Commit E: file has the following 5 lines in it:
<<<<<<< Temporary merge branch 1
C
=======
B
>>>>>>> Temporary merge branch 2

Now, if we try to merge D & E, clearly there should be a conflict.
But git merges cleanly, giving file the contents 'D\n'.  The reason
for this is that git notices there are two merge bases, B & C, tries
to merge them in-core, notices the conflict, stores the 3-way merged
contents as the version of 'file' in the new virtual ancestor, and
then does a three-way merge between that virtual ancestor and D & E.
Since the contents of 'file' match between the virtual ancestor and E,
the contents of file from D are selected as the merge resolution.
It's wrong, but the only way to fix it is to somehow have an entry in
the virtual ancestor tree where the conflict region(s) of file are
guaranteed to not match the corresponding content locations of file
for either D or E.  (Perhaps by adding random content on the line
after the ='s?)

Given the extremely contrived nature of this example, perhaps we don't
care.  But the basic problem that we need some kind of entry in the
virtual ancestor that makes sense for a conflict case can come up in
other less-contrived scenarios.  For example, with directory/file
conflicts...

Let's look at a slightly more complicated example, a repository with
up to three files: 'junk', 'a' and 'a/file':

Commit A: Only 'junk' exists
Commit B: Adds file 'a'
Commit C: Adds file 'a/file'
Commit D: Merges B & C, keeping 'a' and deleting 'a/file'
Commit E: Merges B & C, deleting 'a' but keeping 'a/file'

Now, merging D & E should result in a (directory/file) conflict, with
both 'a' and 'a/file' left in the index (at stages 2 and 3 -- what, if
anything, exists at stage 1 is unclear to me) and both 'a/file' and
'a~<branch>' existing in the working copy.  But how/if that happens,
depends on the virtual ancestor created when merging B & C in-core.
Possibilities:

Possibility 1: Virtual ancestor somehow contains both 'a' and 'a/file'
(currently impossible in git, since this virtual ancestor is written
as a tree and there's code to prevent writing trees with D/F
conflicts).  This would mean that 'a' is unchanged between the virtual
ancestor and D and thus should be deleted as in E.  Also, 'a/file' is
unchanged between the virtual ancestor and E and thus should be
deleted as in D.  So we get a clean merge without either 'a' or
'a/file' present.  Bad.

Possibility 2: Virtual ancestor contains 'a' but not 'a/file'.  This
means the virtual ancestor matches commit D exactly, so git can
cleanly merge by just selecting the contents of E.  Bad.

Possibility 3: Virtual ancestor contains 'a/file' but not 'a'.  Like
possibility 2, in reverse: this time the merge is clean having the
contents of D.  Bad.

Possibility 4: Virtual ancestor contains neither 'a' nor 'a/file'.
This case will correctly detect an (add/add) conflict of the
directory/file variety.  Stage 1 will be empty, but stages 2 and 3
will have the appropriate contents.


So possibility 4 sounds great, right?  Let's say we use that
algorithm, but now we have a different situation:
Commits A, B, C, & D: all as above
Commit E2: Merges B & C, keeping a slightly modified version of 'a'
and deleting 'a/file'.

Merging D & E2 should be clean, with 'a/file' being removed (since
both D and E2 removed it) and the slightly modified version of 'a'
from E2 appearing in the result (since 'a' is unmodified in D).
However, having the virtual ancestor contain neither 'a' nor 'a/file'
will cause an add/add conflict when merging D & E2.  Bad.


The only way out of this that I see (and I'm hoping I'm just missing
something), is a modification of possibility 1: make the virtual
ancestor contain both 'a' and 'a/file', but with both files modified
somehow to ensure they don't match the contents of D, E, or E2 (maybe
by appending some random data? something extremely unlikely to match
the contents of the file in any of D, E, or E2 such as a timestamp?).
That would result in merging D & E giving the appropriate conflict
(detected as a modify/delete), and merging D & E2 to go cleanly so
long as the modification of 'a' in E2 didn't appear near the random
modification of 'a' in the virtual ancestor.


Ugh.  Seems like a mess.  Anyone have any bright ideas?

Elijah
