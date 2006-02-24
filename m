From: Junio C Hamano <junkio@cox.net>
Subject: Re: FYI: git-am allows creation of empty commits.
Date: Thu, 23 Feb 2006 21:56:29 -0800
Message-ID: <7v1wxtgv02.fsf@assigned-by-dhcp.cox.net>
References: <m1slqahyxt.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 24 06:56:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCVwU-0000mI-Hw
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 06:56:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750887AbWBXF4e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 00:56:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751843AbWBXF4e
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 00:56:34 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:8674 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750887AbWBXF4d (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2006 00:56:33 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060224055254.QHXX20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 24 Feb 2006 00:52:54 -0500
To: ebiederm@xmission.com (Eric W. Biederman)
In-Reply-To: <m1slqahyxt.fsf@ebiederm.dsl.xmission.com> (Eric W. Biederman's
	message of "Thu, 23 Feb 2006 08:33:50 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16683>

ebiederm@xmission.com (Eric W. Biederman) writes:

> After fixing it up and doing all of my edits I occasionally forget
> the git-update-index step, before calling git-am --resolved.  This
> proceeds along it's merry way and creates an empty commit.

Certainly a safty measure is missing here.  Thanks for
noticing.  How about something like this?

---
diff --git a/git-am.sh b/git-am.sh
index 85ecada..6730813 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -300,10 +300,16 @@ do
 	    } >"$dotest/final-commit"
 	    ;;
 	*)
-		case "$resolved,$interactive" in
-		tt)
-			# This is used only for interactive view option.
+		case "$resolved" in
+		t)
+			# This is used for interactive view option, but
+			# also we should see if the user really did
+			# something...
 			git-diff-index -p --cached HEAD >"$dotest/patch"
+			test -s "$dotest/patch" || {
+				echo "You said resolved, but there is no change in the index..."
+				stop_here $this
+			}
 			;;
 		esac
 	esac
