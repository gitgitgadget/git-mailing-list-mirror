From: eacousineau <eacousineau@gmail.com>
Subject: [PATCH] submodule foreach: Added in --post-order=<command> and adjusted code per Jens Lehmann's suggestions
Date: Fri, 12 Apr 2013 23:04:25 -0500
Message-ID: <1365825865-12858-1-git-send-email-eacousineau@gmail.com>
References: <515B3C0E.9000802@web.de>
Cc: eacousineau <eacousineau@gmail.com>
To: jens.lehmann@web.de, phil.hord@gmail.com, gitster@pobox.com,
	hvoigt@hvoigt.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 13 06:04:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQrhu-0007mV-71
	for gcvg-git-2@plane.gmane.org; Sat, 13 Apr 2013 06:04:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751575Ab3DMEEu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Apr 2013 00:04:50 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:55018 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755Ab3DMEEt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Apr 2013 00:04:49 -0400
Received: by mail-ie0-f174.google.com with SMTP id aq17so4145674iec.33
        for <git@vger.kernel.org>; Fri, 12 Apr 2013 21:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=R1DfqxWlhk8h2WaluF9sN0fD7VvvNOX4ch+dPX4DOXI=;
        b=vmhkYeG0UdfUpIAXFCCHwD678XunVidSWdK5Hko59KWhe1JrTpo1Jl41H9nI28uHGy
         l0usff/Sj01Y3nYnTxArUOB/3QeSoez3DeUSRSOp59Hy/c5bwE3nTp3Cn30FjQ3bozti
         reITeTMmgIlBA5t0wAlVgqSPMJrYlOnNbE1k4vYHvxmXxu+e6GUNxKmX7TbxRk38zZjb
         kyb1grfcqMBCbH5mjfpOr3vENBeGuIEVlea32jfPSwIZffOl6Yw0JYLQJYou4Hzq24Yn
         edLw96U1A1zFc24BiCUiTCQrrosPRlO37smOPsJzWp624M8twkGrTv370xuoQ5Wh8aLI
         VPDQ==
X-Received: by 10.50.128.47 with SMTP id nl15mr828093igb.5.1365825889004;
        Fri, 12 Apr 2013 21:04:49 -0700 (PDT)
Received: from localhost.localdomain ([199.30.163.2])
        by mx.google.com with ESMTPS id dy5sm1712959igc.1.2013.04.12.21.04.46
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 12 Apr 2013 21:04:48 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.390.gd4ee029
In-Reply-To: <515B3C0E.9000802@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221044>

Signed-off-by: eacousineau <eacousineau@gmail.com>
---
I see what you meant by the extra variables, so I've fixed that so the
original flags aren't needed with recursion. Also updated it to not
print the entering command if there is only a post-order command.

Examples:

$ git submodule foreach --recursive --post-order 'echo Goodbye' "echo \"'ello\""
Entering 'b'
'ello
Entering 'b/d'
'ello
Leaving 'b/d'
Goodbye
Leaving 'b'
Goodbye
Entering 'c'
'ello
Leaving 'c'
Goodbye

$ git submodule foreach --recursive --post-order :
Leaving 'b/d'
Leaving 'b'
Leaving 'c'

 git-submodule.sh | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 79bfaac..e08a724 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -11,7 +11,7 @@ USAGE="[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <re
    or: $dashless [--quiet] deinit [-f|--force] [--] <path>...
    or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--rebase] [--reference <repository>] [--merge] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
-   or: $dashless [--quiet] foreach [--recursive] <command>
+   or: $dashless [--quiet] foreach [--recursive] [--post-order <command>] <command>
    or: $dashless [--quiet] sync [--recursive] [--] [<path>...]"
 OPTIONS_SPEC=
 . git-sh-setup
@@ -449,6 +449,15 @@ cmd_foreach()
 		--recursive)
 			recursive=1
 			;;
+		--post-order)
+			test "$#" = "1" && usage
+			post_order="$2"
+			shift
+			;;
+		--post-order=*)
+			# Will skip empty commands
+			post_order=${1#*=}
+			;;
 		-*)
 			usage
 			;;
@@ -471,7 +480,9 @@ cmd_foreach()
 		die_if_unmatched "$mode"
 		if test -e "$sm_path"/.git
 		then
-			say "$(eval_gettext "Entering '\$prefix\$sm_path'")"
+			enter_msg="$(eval_gettext "Entering '\$prefix\$sm_path'")"
+			leave_msg="$(eval_gettext "Leaving '\$prefix\$sm_path'")"
+			die_msg="$(eval_gettext "Stopping at '\$sm_path'; script returned non-zero status.")"
 			name=$(module_name "$sm_path")
 			(
 				prefix="$prefix$sm_path/"
@@ -479,13 +490,23 @@ cmd_foreach()
 				# we make $path available to scripts ...
 				path=$sm_path
 				cd "$sm_path" &&
-				eval "$@" &&
+				if test $# -gt 0 -o -z "$post_order"
+				then
+					say "$enter_msg" &&
+					eval "$@" || die "$die_msg"
+				fi &&
 				if test -n "$recursive"
 				then
-					cmd_foreach "--recursive" "$@"
+					# subshell will use parent-scoped values
+					cmd_foreach "$@"
+				fi &&
+				if test -n "$post_order"
+				then
+					say "$leave_msg" &&
+					eval "$post_order" || die "$die_msg"
 				fi
 			) <&3 3<&- ||
-			die "$(eval_gettext "Stopping at '\$sm_path'; script returned non-zero status.")"
+			die "$die_msg"
 		fi
 	done
 }
-- 
1.8.2.1.390.gd4ee029
