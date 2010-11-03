From: Kevin Ballard <kevin@sb.org>
Subject: [PATCHv2 2/2] submodule: only preserve flags across recursive status/update invocations
Date: Tue,  2 Nov 2010 22:05:40 -0700
Message-ID: <1288760740-10075-2-git-send-email-kevin@sb.org>
References: <5BE96A08-B8AB-4041-ABF2-7095EB5DD585@sb.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Kevin Ballard <kevin@sb.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 03 06:05:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDVXp-0001IH-2f
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 06:05:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844Ab0KCFFx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 01:05:53 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:36325 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751696Ab0KCFFv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 01:05:51 -0400
Received: by pwj3 with SMTP id 3so89635pwj.19
        for <git@vger.kernel.org>; Tue, 02 Nov 2010 22:05:50 -0700 (PDT)
Received: by 10.142.139.8 with SMTP id m8mr5810318wfd.208.1288760750872;
        Tue, 02 Nov 2010 22:05:50 -0700 (PDT)
Received: from localhost.localdomain ([69.170.160.74])
        by mx.google.com with ESMTPS id q13sm12558580wfc.17.2010.11.02.22.05.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Nov 2010 22:05:50 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.2.200.g479de
In-Reply-To: <5BE96A08-B8AB-4041-ABF2-7095EB5DD585@sb.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160578>

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
I'm tempted to make this commit also omit the --reference flag in recursive
calls to cmd_update, as I don't believe it makes sense to use --reference
in conjunction with --recursive, but it may be a better idea to simply
produce an error if both flags are used together.
 git-submodule.sh             |   19 ++++++++-----------
 t/t7407-submodule-foreach.sh |   19 +++++++++++++++++++
 2 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 543554b..4fd8982 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -374,41 +374,35 @@ cmd_init()
 cmd_update()
 {
 	# parse $args after "submodule ... update".
-	orig_args="$(git rev-parse --sq-quote "$@")"
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
+			orig_flags="$orig_flags $(git rev-parse --sq-quote "$1")"
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
@@ -422,6 +416,8 @@ cmd_update()
 			break
 			;;
 		esac
+		orig_flags="$orig_flags $(git rev-parse --sq-quote "$1")"
+		shift
 	done
 
 	if test -n "$init"
@@ -500,7 +496,7 @@ cmd_update()
 
 		if test -n "$recursive"
 		then
-			(clear_local_git_env; cd "$path" && eval cmd_update "$orig_args") ||
+			(clear_local_git_env; cd "$path" && eval cmd_update "$orig_flags") ||
 			die "Failed to recurse into submodule path '$path'"
 		fi
 	done
@@ -733,7 +729,7 @@ cmd_summary() {
 cmd_status()
 {
 	# parse $args after "submodule ... status".
-	orig_args="$(git rev-parse --sq-quote "$@")"
+	orig_flags=
 	while test $# -ne 0
 	do
 		case "$1" in
@@ -757,6 +753,7 @@ cmd_status()
 			break
 			;;
 		esac
+		orig_flags="$orig_flags $(git rev-parse --sq-quote "$1")"
 		shift
 	done
 
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
1.7.3.2.200.g479de
