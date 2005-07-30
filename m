From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-applymbox: allow retrying after fixing up.
Date: Fri, 29 Jul 2005 19:11:33 -0700
Message-ID: <7vy87p6o16.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Jul 30 04:19:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DygwS-00020H-QA
	for gcvg-git@gmane.org; Sat, 30 Jul 2005 04:19:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262769AbVG3CTD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jul 2005 22:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262802AbVG3CNT
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jul 2005 22:13:19 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:8360 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S262928AbVG3CLf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2005 22:11:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050730021123.MGLK8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 29 Jul 2005 22:11:23 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

After failing to apply a patch, when operating under -q (query)
flag, give the user an opportunity to fix up the patch in a
separate window and retry.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 tools/git-applymbox |   56 +++++++++++++++++++++++++++++++++++++--------------
 1 files changed, 41 insertions(+), 15 deletions(-)

2b1077125e629c316905ae480ab4f8699332b7f7
diff --git a/tools/git-applymbox b/tools/git-applymbox
--- a/tools/git-applymbox
+++ b/tools/git-applymbox
@@ -9,7 +9,7 @@
 ## You give it a mbox-format collection of emails, and it will try to
 ## apply them to the kernel using "applypatch"
 ##
-## applymbox [ -c .dotest/msg-number ] [ -q ] mail_archive [Signoff_file]"
+## applymbox [ -q ] (-c .dotest/msg-number | mail_archive) [Signoff_file]"
 ##
 ## The patch application may fail in the middle.  In which case:
 ## (1) look at .dotest/patch and fix it up to apply
@@ -35,29 +35,55 @@ case "$continue" in
 	rm -rf .dotest
 	mkdir .dotest
 	git-mailsplit "$1" .dotest || exit 1
+	shift
 esac
 
 case "$query_apply" in
 t)	touch .dotest/.query_apply
 esac
 
-for i in .dotest/0*
+signoff="$1"
+set x .dotest/0*
+shift
+while case "$#" in 0) break;; esac
 do
-	case "$resume,$continue" in
-	f,$i)	resume=t;;
-	f,*)	continue;;
-	*)
-		git-mailinfo .dotest/msg .dotest/patch <$i >.dotest/info || exit 1
-		git-stripspace < .dotest/msg > .dotest/msg-clean
-		;;
-	esac
-	git-applypatch .dotest/msg-clean .dotest/patch .dotest/info "$2"
-	ret=$?
-	if [ $ret -ne 0 ]; then
+    i="$1" 
+    case "$resume,$continue" in
+    f,$i)	resume=t;;
+    f,*)	continue;;
+    *)
+	    git-mailinfo .dotest/msg .dotest/patch <$i >.dotest/info || exit 1
+	    git-stripspace < .dotest/msg > .dotest/msg-clean
+	    ;;
+    esac
+    while :; # for fixing up and retry
+    do
+	git-applypatch .dotest/msg-clean .dotest/patch .dotest/info "$signoff"
+	case "$?" in
+	0 | 2 )
 		# 2 is a special exit code from applypatch to indicate that
 	    	# the patch wasn't applied, but continue anyway 
-		[ $ret -ne 2 ] && exit $ret
-	fi
+		;;
+	*)
+		ret=$?
+		if test -f .dotest/.query_apply
+		then
+			echo >&2 "* Patch failed."
+			echo >&2 "* You could fix it up in your editor and"
+			echo >&2 "  retry.  If you want to do so, say yes here"
+			echo >&2 "  AFTER fixing .dotest/patch up."
+			echo >&2 -n "Retry [y/N]? "
+			read yesno
+			case "$yesno" in
+			[Yy]*)
+				continue ;;
+		        esac
+		fi
+		exit $ret
+	esac
+	break
+    done
+    shift
 done
 # return to pristine
 rm -fr .dotest
