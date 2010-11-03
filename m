From: Kevin Ballard <kevin@sb.org>
Subject: [PATCHv3 1/2] submodule: preserve all arguments exactly when recursing
Date: Tue,  2 Nov 2010 23:26:24 -0700
Message-ID: <1288765585-80823-1-git-send-email-kevin@sb.org>
References: <20101103053827.GD10631@burratino>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Kevin Ballard <kevin@sb.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 03 07:26:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDWnu-00089n-OU
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 07:26:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753033Ab0KCG0e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 02:26:34 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:41812 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752563Ab0KCG0c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 02:26:32 -0400
Received: by pvb32 with SMTP id 32so90746pvb.19
        for <git@vger.kernel.org>; Tue, 02 Nov 2010 23:26:32 -0700 (PDT)
Received: by 10.142.136.14 with SMTP id j14mr6693425wfd.57.1288765592283;
        Tue, 02 Nov 2010 23:26:32 -0700 (PDT)
Received: from localhost.localdomain ([69.170.160.74])
        by mx.google.com with ESMTPS id x18sm12711702wfa.11.2010.11.02.23.26.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Nov 2010 23:26:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.2.200.g862e8
In-Reply-To: <20101103053827.GD10631@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160587>

Shell variables only hold strings, not lists of parameters,
so $orig_args after

        orig_args="$@"

fails to remember where each parameter starts and ends, if
some include whitespace.  So

        git submodule update \
                --reference='/var/lib/common objects.git' \
                --recursive --init

becomes

        git submodule update --reference=/var/lib/common \
                objects.git --recursive --init

in the inner repositories.  Use "git rev-parse --sq-quote" to
save parameters in quoted form ready for evaluation by the
shell, avoiding this problem.

Helped-By: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Kevin Ballard <kevin@sb.org>
---
This version introduces a test using --reference.
It also uses the nice description written by Jonathan
and it stops unnecessarily quoting the results of
the call to $(git rev-parse --sq-quote "$@")
 git-submodule.sh             |    8 ++++----
 t/t7407-submodule-foreach.sh |   16 ++++++++++++++++
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 9ebbab7..4d2bb37 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -374,7 +374,7 @@ cmd_init()
 cmd_update()
 {
 	# parse $args after "submodule ... update".
-	orig_args="$@"
+	orig_args=$(git rev-parse --sq-quote "$@")
 	while test $# -ne 0
 	do
 		case "$1" in
@@ -500,7 +500,7 @@ cmd_update()
 
 		if test -n "$recursive"
 		then
-			(clear_local_git_env; cd "$path" && cmd_update $orig_args) ||
+			(clear_local_git_env; cd "$path" && eval cmd_update "$orig_args") ||
 			die "Failed to recurse into submodule path '$path'"
 		fi
 	done
@@ -733,7 +733,7 @@ cmd_summary() {
 cmd_status()
 {
 	# parse $args after "submodule ... status".
-	orig_args="$@"
+	orig_args=$(git rev-parse --sq-quote "$@")
 	while test $# -ne 0
 	do
 		case "$1" in
@@ -790,7 +790,7 @@ cmd_status()
 				prefix="$displaypath/"
 				clear_local_git_env
 				cd "$path" &&
-				cmd_status $orig_args
+				eval cmd_status "$orig_args"
 			) ||
 			die "Failed to recurse into submodule path '$path'"
 		fi
diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index 905a8ba..15d420f 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -238,4 +238,20 @@ test_expect_success 'use "git clone --recursive" to checkout all submodules' '
 	test -d clone4/nested1/nested2/nested3/submodule/.git
 '
 
+test_expect_success 'test "update --recursive" with a flag with spaces' '
+	git clone super "common objects" &&
+	git clone super clone5 &&
+	(
+		cd clone5 &&
+		test ! -d nested1/.git &&
+		git submodule update --init --recursive --reference="$(dirname "$PWD")/common objects" &&
+		test -d nested1/.git &&
+		test -d nested1/nested2/.git &&
+		test -d nested1/nested2/nested3/.git &&
+		test -f nested1/.git/objects/info/alternates &&
+		test -f nested1/nested2/.git/objects/info/alternates &&
+		test -f nested1/nested2/nested3/.git/objects/info/alternates
+	)
+'
+
 test_done
-- 
1.7.3.2.200.g862e8
