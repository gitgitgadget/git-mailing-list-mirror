From: Pete Wyckoff <pw@padd.com>
Subject: [PATCHv2 06/21] git p4 test: use client_view in t9806
Date: Sat, 26 Jan 2013 22:11:09 -0500
Message-ID: <1359256284-5660-7-git-send-email-pw@padd.com>
References: <1359256284-5660-1-git-send-email-pw@padd.com>
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 27 04:13:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzIgn-00054f-T2
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 04:13:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755497Ab3A0DN3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2013 22:13:29 -0500
Received: from honk.padd.com ([74.3.171.149]:58704 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755361Ab3A0DN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2013 22:13:28 -0500
Received: from arf.padd.com (unknown [50.52.174.88])
	by honk.padd.com (Postfix) with ESMTPSA id 137CA2F3F;
	Sat, 26 Jan 2013 19:13:28 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 62CD822838; Sat, 26 Jan 2013 22:13:24 -0500 (EST)
X-Mailer: git-send-email 1.8.1.1.517.gf5c753f
In-Reply-To: <1359256284-5660-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214656>

Use the standard client_view function from lib-git-p4.sh
instead of building one by hand.  This requires a bit of
rework, using the current value of $P4CLIENT for the client
name.  It also reorganizes the test to isolate changes to
$P4CLIENT and $cli in a subshell.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/lib-git-p4.sh           |  4 ++--
 t/t9806-git-p4-options.sh | 49 ++++++++++++++++++++---------------------------
 2 files changed, 23 insertions(+), 30 deletions(-)

diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index b1dbded..c5d1f4d 100644
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
index 4f077ee..564fc80 100755
--- a/t/t9806-git-p4-options.sh
+++ b/t/t9806-git-p4-options.sh
@@ -214,40 +214,33 @@ test_expect_success 'clone --use-client-spec' '
 		exec >/dev/null &&
 		test_must_fail git p4 clone --dest="$git" --use-client-spec
 	) &&
+	# build a different client
 	cli2=$(test-path-utils real_path "$TRASH_DIRECTORY/cli2") &&
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
 	test_when_finished cleanup_git &&
 	(
+		# group P4CLIENT and cli changes in a sub-shell
 		P4CLIENT=client2 &&
-		git p4 clone --dest="$git" --use-client-spec //depot/...
-	) &&
-	(
-		cd "$git" &&
-		test_path_is_file bus/dir/f4 &&
-		test_path_is_missing file1
-	) &&
-	cleanup_git &&
-
-	# same thing again, this time with variable instead of option
-	(
-		cd "$git" &&
-		git init &&
-		git config git-p4.useClientSpec true &&
-		P4CLIENT=client2 &&
-		git p4 sync //depot/... &&
-		git checkout -b master p4/master &&
-		test_path_is_file bus/dir/f4 &&
-		test_path_is_missing file1
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
1.8.1.1.460.g6fa8886
