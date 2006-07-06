From: Junio C Hamano <junkio@cox.net>
Subject: Re: git reset --hard include/linux/config.h
Date: Wed, 05 Jul 2006 19:45:59 -0700
Message-ID: <7vhd1va1so.fsf@assigned-by-dhcp.cox.net>
References: <20060705165801.GA11822@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 06 04:46:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FyJsU-0003ci-4I
	for gcvg-git@gmane.org; Thu, 06 Jul 2006 04:46:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965138AbWGFCqD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Jul 2006 22:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965139AbWGFCqC
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Jul 2006 22:46:02 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:32652 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S965138AbWGFCqA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jul 2006 22:46:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060706024600.ZCKQ985.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 5 Jul 2006 22:46:00 -0400
To: Sam Ravnborg <sam@ravnborg.org>
In-Reply-To: <20060705165801.GA11822@mars.ravnborg.org> (Sam Ravnborg's
	message of "Wed, 5 Jul 2006 18:58:01 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23369>

Sam Ravnborg <sam@ravnborg.org> writes:

> Now git reset is maybe supposed to work on commit level only, but it
> would have been nice if it erroroed out when it saw an argument that
> it did not know about. In this case I assume git reset used
> "include/linux/config.h" as <commitish>.

There is an attempt to have that check, but obviously it is
busted.  Thanks for noticing.

Maybe something like this is needed instead.

-- >8 --
git-reset: complain and exit upon seeing an unknown parameter.

The check to use "rev-parse --verify" was defeated by the use of
"--default HEAD".  "git reset --hard bogus-committish" just
defaulted to reset to the HEAD without complaining.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
diff --git a/git-reset.sh b/git-reset.sh
index 46451d0..5c02240 100755
--- a/git-reset.sh
+++ b/git-reset.sh
@@ -17,7 +17,11 @@ case "$1" in
         usage ;;
 esac
 
-rev=$(git-rev-parse --verify --default HEAD "$@") || exit
+case $# in
+0) rev=HEAD ;;
+1) rev=$(git-rev-parse --verify "$1") || exit ;;
+*) usage ;;
+esac
 rev=$(git-rev-parse --verify $rev^0) || exit
 
 # We need to remember the set of paths that _could_ be left
