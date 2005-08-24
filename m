From: Junio C Hamano <junkio@cox.net>
Subject: Re: Fix git-rev-parse breakage
Date: Wed, 24 Aug 2005 11:52:43 -0700
Message-ID: <7v4q9fdv5w.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0508231908170.3317@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 24 20:53:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E80Mn-00015E-G1
	for gcvg-git@gmane.org; Wed, 24 Aug 2005 20:52:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbVHXSwu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Aug 2005 14:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbVHXSwu
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Aug 2005 14:52:50 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:32667 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751385AbVHXSwt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2005 14:52:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050824185245.YJYI3209.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 24 Aug 2005 14:52:45 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508231908170.3317@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 23 Aug 2005 19:17:37 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7720>

Linus Torvalds <torvalds@osdl.org> writes:

> The --flags cleanup caused problems: we used to depend on the fact that 
> "revs_only" magically suppressed flags, adn that assumption was broken by 
> the recent fixes.
>
> It wasn't a good assumption in the first place, so instead of 
> re-introducing it, let's just get rid of it.
>
> This makes "--revs-only" imply "--no-flags".

I was taking a look at this once again after noticing that I
haven't taking any action on it.  But now I am a bit confused
reading the above.  The first two paragraphs tells me
"--revs-only implied --no-flags and we used to depend on it, but
that is not a right thing so get rid of that assumption" (which
I agree is a good change", and the last sentense says
opposite...

And the code makes --revs-only imply --no-flags.

Here is my thinking, requesting for a sanity check.

* git-whatchanged wants to use it to tell rev-list arguments
  from rev-tree arguments.  You _do_ want to pick --max-count=10
  or --merge-order in this case, and --revs-only implying
  --no-flags would make this impossible.

* git-log-script uses it once to make sure it has one commit to
  start at, and lacks --no-flags by mistake.

* git-bisect uses it to validate the parameter is a valid ref,
  but does not use --verify.

This trivial patch fixes the latter two.

---
diff --git a/git-log-script b/git-log-script
--- a/git-log-script
+++ b/git-log-script
@@ -1,4 +1,4 @@
 #!/bin/sh
-revs=$(git-rev-parse --revs-only --default HEAD "$@") || exit
+revs=$(git-rev-parse --revs-only --no-flags --default HEAD "$@") || exit
 [ "$revs" ] || die "No HEAD ref"
 git-rev-list --pretty $(git-rev-parse --default HEAD "$@") | LESS=-S ${PAGER:-less}

diff --git a/git-bisect-script b/git-bisect-script
--- a/git-bisect-script
+++ b/git-bisect-script
@@ -67,7 +67,7 @@ bisect_good() {
 	bisect_autostart
         case "$#" in
 	0)    revs=$(git-rev-parse --verify HEAD) || exit ;;
-	*)    revs=$(git-rev-parse --revs-only "$@") || exit ;;
+	*)    revs=$(git-rev-parse --revs-only --verify "$@") || exit ;;
 	esac
 	for rev in $revs
 	do
