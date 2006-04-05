From: Junio C Hamano <junkio@cox.net>
Subject: Re: How should I handle binary file with GIT
Date: Wed, 05 Apr 2006 11:34:55 -0700
Message-ID: <7vslor27n4.fsf@assigned-by-dhcp.cox.net>
References: <20060405073022.13054.qmail@web25806.mail.ukl.yahoo.com>
	<7v3bgs4exz.fsf@assigned-by-dhcp.cox.net> <e10mn9$cjs$1@sea.gmane.org>
	<Pine.LNX.4.64.0604051131010.2550@localhost.localdomain>
	<86wte4rq3d.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 05 20:35:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FRCqL-00077n-1t
	for gcvg-git@gmane.org; Wed, 05 Apr 2006 20:35:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbWDESe6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Apr 2006 14:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbWDESe6
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Apr 2006 14:34:58 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:55217 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751327AbWDESe6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Apr 2006 14:34:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060405183456.VUYW20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 5 Apr 2006 14:34:56 -0400
To: merlyn@stonehenge.com (Randal L. Schwartz)
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18444>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

> I think the issue is related to being able to cherry-pick and merge
> when binaries are involved.  I've been worried about that myself.
> How well are binaries supported these days for all the operations
> we're taking for granted?  When is a "diff" expected to be a real
> "diff" and not just "binary files differ"?

First of all, binary files are handled by cherry-pick and merge
without needing to involve "diff"+"patch" (which is not so
useful for binary files anyway).  They use 3-way read-tree merge
which compares the object names and leave the index unmerged if
there are conflicting changes, so you should be able to sort it
out by running up to three "git-cat-file blob $sha1".

What involves "diff"+"patch" are rebases and processing mailed-in
patches as in the example by the original poster.

In our diff output, we record the blob object name of preimage
and postimage, along with filemode, on the "index" line.
git-apply does not do anything with it by default, but if:

 - --binary flag is given,

 - the postimage blob is already available locally, and,

 - the file the patch is being applied to is the same as the
   recorded preimage,

then the file is _replaced_ with the postimage.

This is good enough for git-rebase (which uses format-patch
piped to am) and is safe (we do not "apply delta" -- only
replace when the file "being patched" matches the recorded
preimage).  It does not do any good for transferring a postimage
that the person who applies the patch does not yet have.

I think "applying delta" to a binary file is not very useful
thing to do.  Depending on the nature of the file being patched,
it may produce a perfectly good result, but verifying if the
result makes sense by the end user and hand-fixing it if does
not, which can be done for text files, is near impossible for
binary files.  "replace with postimage only when you are
applying to the same preimage" rule would be the only practical,
sane thing.

If we wanted to use the patch+diff (i.e. "format-patch,
send-email, and then am" workflow) to transfer new version of
binary files to a recipient, which I think is useful in some
projects, the sanest way to handle this is probably to add
Nico's delta, going from preimage to postimage, encoded for
safer transport, to our diff output.  For safety and sanity, we
will not "apply" the patch unless the patched file exactly
matches the preimage that is recorded in the diff, and as long
as the recipient has the preimage, such a patch would be able to
reproduce the postimage and hopefully be smaller than
transferring the whole thing.

We've been trying to keep our diff output reversible (e.g. we
show what the filemode of the preimage is), so if we take the
above route, it probably should record deltas for both going
from preimage to postimage _and_ going the other way (unless
xdelta can be applied in-reverse, which I do not think is the
case).

Of course, to be _completely_ generic, you could include both
compressed then uuencoded preimage and postimage, and let the
recipient sort it out.  An advantage of that approach is that
the applicability of such a "patch" improves as the tools to
apply it improve, after the patch was originally generated.  I
however think that is only a theoretical advantage, not a very
practical one.
