From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 06/21] git p4 test: use client_view in t9806
Date: Fri, 28 Sep 2012 08:04:10 -0400
Message-ID: <1348833865-6093-7-git-send-email-pw@padd.com>
References: <1348833865-6093-1-git-send-email-pw@padd.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 28 14:06:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THZL7-0001uu-Rm
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 14:06:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755582Ab2I1MGd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2012 08:06:33 -0400
Received: from honk.padd.com ([74.3.171.149]:34963 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751315Ab2I1MGc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 08:06:32 -0400
Received: from arf.padd.com (unknown [50.55.148.232])
	by honk.padd.com (Postfix) with ESMTPSA id 4CF0B5AF2;
	Fri, 28 Sep 2012 05:06:32 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 8D33B31413; Fri, 28 Sep 2012 08:06:26 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.1.457.g468b3ef
In-Reply-To: <1348833865-6093-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206563>

Use the standard client_view function from lib-git-p4.sh
instead of building one by hand.  This requires a bit of
rework, using the current value of $P4CLIENT for the client
name.  It also reorganizes the test to isolate changes to
$P4CLIENT and $cli in a subshell.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/lib-git-p4.sh           |  4 ++--
 t/t9806-git-p4-options.sh | 50 ++++++++++++++++++++++-------------------------
 2 files changed, 25 insertions(+), 29 deletions(-)

diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index 890ee60..d558dd0 100644
--- a/t/lib-git-p4.sh
+++ b/t/lib-git-p4.sh
@@ -116,8 +116,8 @@ marshal_dump() {
 client_view() {
 	(
 		cat <<-EOF &&
-		Client: client
-		Description: client
+		Client: $P4CLIENT
+		Description: $P4CLIENT
 		Root: $cli
 		View:
 		EOF
diff --git a/t/t9806-git-p4-options.sh b/t/t9806-git-p4-options.sh
index fa40cc8..37ca30a 100755
--- a/t/t9806-git-p4-options.sh
+++ b/t/t9806-git-p4-options.sh
@@ -126,37 +126,33 @@ test_expect_success 'clone --use-client-spec' '
 		exec >/dev/null &&
 		test_must_fail git p4 clone --dest="$git" --use-client-spec
 	) &&
-	cli2=$(test-path-utils real_path "$TRASH_DIRECTORY/cli2") &&
+	# build a different client
+	cli2="$TRASH_DIRECTORY/cli2" &&
 	mkdir -p "$cli2" &&
 	test_when_finished "rmdir \"$cli2\"" &&
-	(
-		cd "$cli2" &&
-		p4 client -i <<-EOF
-		Client: client2
-		Description: client2
-		Root: $cli2
-		View: //depot/sub/... //client2/bus/...
-		EOF
-	) &&
-	P4CLIENT=client2 &&
 	test_when_finished cleanup_git &&
-	git p4 clone --dest="$git" --use-client-spec //depot/... &&
-	(
-		cd "$git" &&
-		test_path_is_file bus/dir/f4 &&
-		test_path_is_missing file1
-	) &&
-	cleanup_git &&
-
-	# same thing again, this time with variable instead of option
 	(
-		cd "$git" &&
-		git init &&
-		git config git-p4.useClientSpec true &&
-		git p4 sync //depot/... &&
-		git checkout -b master p4/master &&
-		test_path_is_file bus/dir/f4 &&
-		test_path_is_missing file1
+		# group P4CLIENT and cli changes in a sub-shell
+		P4CLIENT=client2 &&
+		cli="$cli2" &&
+		client_view "//depot/sub/... //client2/bus/..." &&
+		git p4 clone --dest="$git" --use-client-spec //depot/... &&
+		(
+			cd "$git" &&
+			test_path_is_file bus/dir/f4 &&
+			test_path_is_missing file1
+		) &&
+		cleanup_git &&
+		# same thing again, this time with variable instead of option
+		(
+			cd "$git" &&
+			git init &&
+			git config git-p4.useClientSpec true &&
+			git p4 sync //depot/... &&
+			git checkout -b master p4/master &&
+			test_path_is_file bus/dir/f4 &&
+			test_path_is_missing file1
+		)
 	)
 '
 
-- 
1.7.12.1.403.g28165e1
