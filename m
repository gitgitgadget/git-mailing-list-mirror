From: Kevin Ballard <kevin@sb.org>
Subject: [PATCH 2/2] submodule: only preserve flags across recursive status/update invocations
Date: Tue,  2 Nov 2010 21:34:42 -0700
Message-ID: <1288758882-77286-2-git-send-email-kevin@sb.org>
References: <1288758882-77286-1-git-send-email-kevin@sb.org>
Cc: Junio C Hamano <gitster@pobox.com>, Kevin Ballard <kevin@sb.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 03 05:35:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDV46-0002Wa-GI
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 05:35:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266Ab0KCEe7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 00:34:59 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:37565 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182Ab0KCEe5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 00:34:57 -0400
Received: by mail-pw0-f46.google.com with SMTP id 3so83909pwj.19
        for <git@vger.kernel.org>; Tue, 02 Nov 2010 21:34:57 -0700 (PDT)
Received: by 10.142.211.16 with SMTP id j16mr606095wfg.283.1288758897237;
        Tue, 02 Nov 2010 21:34:57 -0700 (PDT)
Received: from localhost.localdomain ([69.170.160.74])
        by mx.google.com with ESMTPS id w42sm12496476wfh.15.2010.11.02.21.34.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Nov 2010 21:34:56 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.2.200.ga1bd
In-Reply-To: <1288758882-77286-1-git-send-email-kevin@sb.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160573>

Recursive invocations of submodule update/status preserve all arguments
in the recursive invocation. This tends to cause undesired behavior when
those arguments include the name of a submodule, as it tries to recurse
into a nested submodule with the same name rather than recursing into all
child submodules of the named submodule.

This commit changes the argument preservation to only preserve flags.
When specifying a submodule name on the command-line, all child submodules
of that named submodule will be recursed into correctly, and it will not
attempt to recurse into a phantom nested submodule with the same name
as its parent.

Signed-off-by: Kevin Ballard <kevin@sb.org>
---
This commit was inspired by my coworker, who tried to run `git submodule
update --recursive molecules` (where molecules is the name of a submodule)
and received the rather unexpected error

  error: pathspec 'molecules' did not match any file(s) known to git.
  Did you forget to 'git add'?

 git-submodule.sh             |   21 +++++++++------------
 t/t7407-submodule-foreach.sh |   19 +++++++++++++++++++
 2 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index ec7a5e4..52c693c 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -407,41 +407,35 @@ cmd_init()
 cmd_update()
 {
 	# parse $args after "submodule ... update".
-	orig_args="$(quote_words "$@")"
+	orig_flags=
 	while test $# -ne 0
 	do
 		case "$1" in
 		-q|--quiet)
-			shift
 			GIT_QUIET=1
 			;;
 		-i|--init)
 			init=1
-			shift
 			;;
 		-N|--no-fetch)
-			shift
 			nofetch=1
 			;;
 		-r|--rebase)
-			shift
 			update="rebase"
 			;;
 		--reference)
 			case "$2" in '') usage ;; esac
 			reference="--reference=$2"
-			shift 2
+			orig_flags="$orig_flags $(quote_words "$1")"
+			shift
 			;;
 		--reference=*)
 			reference="$1"
-			shift
 			;;
 		-m|--merge)
-			shift
 			update="merge"
 			;;
 		--recursive)
-			shift
 			recursive=1
 			;;
 		--)
@@ -455,6 +449,8 @@ cmd_update()
 			break
 			;;
 		esac
+		orig_flags="$orig_flags $(quote_words "$1")"
+		shift
 	done
 
 	if test -n "$init"
@@ -533,7 +529,7 @@ cmd_update()
 
 		if test -n "$recursive"
 		then
-			eval "set - $orig_args"
+			eval "set - $orig_flags"
 			(clear_local_git_env; cd "$path" && cmd_update "$@") ||
 			die "Failed to recurse into submodule path '$path'"
 		fi
@@ -767,7 +763,7 @@ cmd_summary() {
 cmd_status()
 {
 	# parse $args after "submodule ... status".
-	orig_args="$(quote_words "$@")"
+	orig_flags=
 	while test $# -ne 0
 	do
 		case "$1" in
@@ -791,6 +787,7 @@ cmd_status()
 			break
 			;;
 		esac
+		orig_flags="$orig_flags $(quote_words "$1")"
 		shift
 	done
 
@@ -822,7 +819,7 @@ cmd_status()
 		then
 			(
 				prefix="$displaypath/"
-				eval "set - $orig_args"
+				eval "set - $orig_flags"
 				clear_local_git_env
 				cd "$path" &&
 				cmd_status "$@"
diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index 905a8ba..2d5a855 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -238,4 +238,23 @@ test_expect_success 'use "git clone --recursive" to checkout all submodules' '
 	test -d clone4/nested1/nested2/nested3/submodule/.git
 '
 
+test_expect_success 'use "update --recursive nested1" to checkout all submodules rooted in nested1' '
+	git clone super clone5 &&
+	(
+		cd clone5 &&
+		test ! -d sub1/.git &&
+		test ! -d sub2/.git &&
+		test ! -d sub3/.git &&
+		test ! -d nested1/.git &&
+		git submodule update --init --recursive -- nested1 &&
+		test ! -d sub1/.git &&
+		test ! -d sub2/.git &&
+		test ! -d sub3/.git &&
+		test -d nested1/.git &&
+		test -d nested1/nested2/.git &&
+		test -d nested1/nested2/nested3/.git &&
+		test -d nested1/nested2/nested3/submodule/.git
+	)
+'
+
 test_done
-- 
1.7.3.2.200.ga1bd
