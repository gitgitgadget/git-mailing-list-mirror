From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] tutorial: Use "git remote add"
Date: Fri, 12 Jan 2007 13:58:25 -0800
Message-ID: <7virfbrjpa.fsf@assigned-by-dhcp.cox.net>
References: <87sleg31av.fsf@gmail.com>
	<7vmz4ot7x5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 12 22:58:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5UPv-0003Pp-Dr
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 22:58:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161099AbXALV62 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 12 Jan 2007 16:58:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161108AbXALV62
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 16:58:28 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:59899 "EHLO
	fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161099AbXALV61 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Jan 2007 16:58:27 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070112215827.TUGO25875.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>;
          Fri, 12 Jan 2007 16:58:27 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id AMxb1W00A1kojtg0000000; Fri, 12 Jan 2007 16:57:35 -0500
To: Santi =?iso-8859-1?Q?B=E9jar?= <sbejar@gmail.com>
In-Reply-To: <7vmz4ot7x5.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 12 Jan 2007 10:29:58 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36716>

Junio C Hamano <junkio@cox.net> writes:

> Santi B=E9jar <sbejar@gmail.com> writes:
>
>> @@ -285,10 +285,12 @@ at /home/bob/myrepo.  She does this with:
>> =20
>>  ------------------------------------------------
>>  $ cd /home/alice/project
>> -$ git pull /home/bob/myrepo master
>> +$ git remote add bob /home/bob/myrepo
>> +$ git pull bob master
>>  ------------------------------------------------
>
> I'd prefer to leave this as is, because I think ad-hoc
> promiscous pull shows the distributed nature of git better, and
> add a new step after that to teach "remote add", telling the
> user that "having to use longhand every time is tiresome, so
> there is a nifty way to define a shorthand for a remote
> repository you interact with often".

I'm thinking about committing something like this on top of
yours (commentary interspersed in the diff so you cannot apply
without enhanced git-apply).

diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
index 4b7eba3..7770b57 100644
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -285,12 +285,10 @@ at /home/bob/myrepo.  She does this with:
=20
 ------------------------------------------------
 $ cd /home/alice/project
-$ git remote add bob /home/bob/myrepo
-$ git pull bob master
+$ git pull /home/bob/myrepo master
 ------------------------------------------------
=20
-First it adds the "remote" Bob's repository with the name "bob" and
-then it merges the changes from Bob's "master" branch into Alice's
+This merges the changes from Bob's "master" branch into Alice's
 current branch.  If Alice has made her own changes in the meantime,
 then she may need to manually fix any conflicts.  (Note that the
 "master" argument in the above command is actually unnecessary, as it
|
| This hunk essentially reverts your change to this section.
|
@@ -299,14 +297,27 @@ is the default.)
 The "pull" command thus performs two operations: it fetches changes
 from a remote branch, then merges them into the current branch.
=20
-You can perform the first operation alone using the "git fetch"
-command without merging them with her own branch, using:
+When you are working in a small closely knit group, it is not
+unusual to interact with the same repository over and over
+again.  By defining 'remote' repository shorthand, you can make
+it easier:
+
+------------------------------------------------
+$ git remote add bob /home/bob/myrepo
+------------------------------------------------
+
+With this, you can perform the first operation alone using the
+"git fetch" command without merging them with her own branch,
+using:
=20
 -------------------------------------
 $ git fetch bob
 -------------------------------------
=20
-which fetches the changes from Bob's branches.  Then
+Unlike the longhand form, when Alice fetches from Bob using a
+remote repository shorthand set up with `git remote`, what was
+fetched is stored in a remote tracking branch, in this case
+`bob/master`.  So after this:
=20
 -------------------------------------
 $ git log -p master..bob/master
|
| And highlight that with the shorthand defined you will get
| remote tracking branches for free (the original form doesn't
| clutter your refs/remotes/).
|
@@ -315,28 +326,22 @@ $ git log -p master..bob/master
 shows a list of all the changes that Bob made since he branched from
 Alice's master branch.
=20
-After examining those changes, and possibly fixing things, Alice
-could pull the changes into her master branch:
+After examining those changes, Alice
+could merge the changes into her master branch:
|=20
| No way Alice can _fix_ things -- the original was wrong to begin
| with from the workflow point of view, but now this uses remote
| tracking branch that Alice cannot even checkout and modify.
|=20
 -------------------------------------
-$ git checkout master
-$ git pull . remotes/bob/master
+$ git merge bob/master
 -------------------------------------
=20
-The last command is a pull from the "bob/master" branch in Alice's
-own repository.
-
-Alice could also perform both steps at once with:
+This `merge` can also be done by 'pulling from her own remote
+tracking branch', like this:
=20
 -------------------------------------
-$ git pull bob
+$ git pull . remotes/bob/master
 -------------------------------------
=20
-This is just like the "git pull bob master" that we saw
-before, except that it also stores the unmerged changes from bob's
-master branch in bob/master before merging them into Alice's
-current branch.  Note that git pull always merges into the current
-branch, regardless of what else is given on the commandline.
+Note that git pull always merges into the current branch,
+regardless of what else is given on the commandline.
=20
 Later, Bob can update his repo with Alice's latest changes using
=20
