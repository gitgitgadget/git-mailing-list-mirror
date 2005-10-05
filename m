From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fall back to three-way merge when applying a patch.
Date: Tue, 04 Oct 2005 23:58:27 -0700
Message-ID: <7vslvg1mcs.fsf@assigned-by-dhcp.cox.net>
References: <7vd5mk7pv6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0510042155090.31407@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 05 08:59:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EN3EX-0005FI-1o
	for gcvg-git@gmane.org; Wed, 05 Oct 2005 08:58:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932561AbVJEG6a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Oct 2005 02:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932560AbVJEG6a
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Oct 2005 02:58:30 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:64661 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932558AbVJEG63 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2005 02:58:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051005065818.ESPS29333.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 5 Oct 2005 02:58:18 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510042155090.31407@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 4 Oct 2005 21:56:58 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9702>

Linus Torvalds <torvalds@osdl.org> writes:

> For example, I use git-applypatch _only_ through git-applymbox. Ie 
> non-interactively. I definitely do _not_ want it to try random other trees 
> unless I tell it to, especially when applying a series of 175 patches in 
> one go.

My understanding of your workflow, from reading your earlier
posts to the git list, is:

 * Read bunch of mails -- mostly concentrating on the
   description in the log message and skimming the code -- while
   saving the worthy patches into a 'to-apply' mbox.

 * Review 'to-aplly' mbox again, perhaps excluding not-so-good
   ones.  When you need to fix log messages, that is done in
   this step.

 * Run git-applymbox on the surviving messages in a batch mode,
   processing 175 patches in one go.

What is your workflow after seeing that the 47th patch among 175
patches fails to apply?  I understand you run git-applymbox
without -q, so it immediately fails and exits there.  You would
have split mails, numbered from 0001 to 0175 in the .dotest
directory, with msg, patch and info files from the mail 0047
left behind.

I presume that, if the conflict/fuzz is manageably small, you
would hand edit the file 0047 to make the diff part to apply
cleanly, and then run 'git-applymbox -c .dotest/0047'.  I
would understand you would be able to resume and process the
rest 128 patches this way.

Once you mentioned that if the conflict is too great you would
apply the patch to an old version that the patch sender based
her work on, and merge using git (this was the direct
inspiration of the change to git-applypatch).

What I am wondering is how that step fits in your workflow.  Do
you do this by the following sequence?

 * Temporarily switch to a new throwaway branch for merge from
   the known old version with 'git checkout -b test v2.6.12';

 * 'git apply --index <.dotest/patch' to apply the patch, and
   perhaps 'git commit -F .dotest/msg';

 * Switch back to the master branch with 'git checkout master';

 * Merge them with 'git resolve master test <some message>',
   which may leave conflicts, in which case you would hand
   resolve, and say 'git commit -F .dotest/msg'.  Then 'git
   branch -d test' to get rid of the throwaway branch.

 * Resume the patch application with 'git-applymbox -c
   .dotest/0048'.

Well, I just noticed that it is not even immediately obvious
that the 47th of the 175 patches failed to apply from the
git-applymbox batch output (it shows how I do not process really
many patches myself X-<).  Is there anything I can do to improve
this?  For example, after git-applypatch exits with 0 exit
status we could remove the split mail file, like this:

------------
diff --git a/git-applymbox.sh b/git-applymbox.sh
--- a/git-applymbox.sh
+++ b/git-applymbox.sh
@@ -82,7 +82,11 @@ do
     do
 	git-applypatch .dotest/msg-clean .dotest/patch .dotest/info "$signoff"
 	case "$?" in
-	0 | 2 )
+	0)
+		# Remove the cleanly applied one to reduce clutter.
+		rm -f .dotest/$i
+		;;
+	2)
 		# 2 is a special exit code from applypatch to indicate that
 	    	# the patch wasn't applied, but continue anyway 
 		;;
------------

Or it may not matter at all if your "after failure" workflow is
very different from what I've been imagining.  This is the
primarily reason why I would like to understand your workflow
better.
