From: Kevin Ballard <kevin@sb.org>
Subject: [PATCHv3 2/2] submodule: only preserve flags across recursive status/update invocations
Date: Tue,  2 Nov 2010 23:26:25 -0700
Message-ID: <1288765585-80823-2-git-send-email-kevin@sb.org>
References: <20101103053827.GD10631@burratino>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Kevin Ballard <kevin@sb.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 03 07:26:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDWnv-00089n-8Z
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 07:26:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753071Ab0KCG0g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 02:26:36 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:57592 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752788Ab0KCG0d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 02:26:33 -0400
Received: by pwj3 with SMTP id 3so104169pwj.19
        for <git@vger.kernel.org>; Tue, 02 Nov 2010 23:26:33 -0700 (PDT)
Received: by 10.142.44.7 with SMTP id r7mr6745546wfr.114.1288765593309;
        Tue, 02 Nov 2010 23:26:33 -0700 (PDT)
Received: from localhost.localdomain ([69.170.160.74])
        by mx.google.com with ESMTPS id x18sm12711702wfa.11.2010.11.02.23.26.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Nov 2010 23:26:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.2.200.g862e8
In-Reply-To: <20101103053827.GD10631@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160588>

Recursive invocations of submodule update/status preserve all arguments,
so executing

        git submodule update --recursive -- foo

attempts to recursively update a submodule named "foo".

Naturally, this fails as one cannot have an infinitely-deep stack of
submodules each containing a submodule named "foo". The desired behavior
is instead to update foo and then recursively update all submodules
inside of foo.

This commit accomplishes that by only saving the flags for use in the
recursive invocation.

Signed-off-by: Kevin Ballard <kevin@sb.org>
---
As suggested by Jonathan Nieder, I've included a test for
`git submodule status --cached --recursive -- nested` to verify
that the flags are preserved but the paths aren't.
 git-submodule.sh             |   19 ++++++++-----------
 t/t7407-submodule-foreach.sh |   34 ++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 11 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 4d2bb37..4fd8982 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -374,41 +374,35 @@ cmd_init()
 cmd_update()
 {
 	# parse $args after "submodule ... update".
-	orig_args=$(git rev-parse --sq-quote "$@")
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
-	orig_args=$(git rev-parse --sq-quote "$@")
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
index 15d420f..d8ad250 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -226,6 +226,21 @@ test_expect_success 'test "status --recursive"' '
 	test_cmp expect actual
 '
 
+sed -e "/nested1 /s/.*/+$nested1sha1 nested1 (file2~1)/;/sub[1-3]/d" < expect > expect2
+mv -f expect2 expect
+
+test_expect_success 'ensure "status --cached --recursive" preserves the --cached flag' '
+	(
+		cd clone3 &&
+		(
+			cd nested1 &&
+			test_commit file2
+		) &&
+		git submodule status --cached --recursive -- nested1 > ../actual
+	) &&
+	test_cmp expect actual
+'
+
 test_expect_success 'use "git clone --recursive" to checkout all submodules' '
 	git clone --recursive super clone4 &&
 	test -d clone4/.git &&
@@ -254,4 +269,23 @@ test_expect_success 'test "update --recursive" with a flag with spaces' '
 	)
 '
 
+test_expect_success 'use "update --recursive nested1" to checkout all submodules rooted in nested1' '
+	git clone super clone6 &&
+	(
+		cd clone6 &&
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
1.7.3.2.200.g862e8
