From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 1/6] git-p4: test client view handling
Date: Mon,  2 Jan 2012 18:05:49 -0500
Message-ID: <1325545554-16540-2-git-send-email-pw@padd.com>
References: <1325545554-16540-1-git-send-email-pw@padd.com>
Cc: Gary Gibbons <ggibbons@perforce.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 03 00:06:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RhqxS-0006LO-B3
	for gcvg-git-2@lo.gmane.org; Tue, 03 Jan 2012 00:06:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753459Ab2ABXGT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jan 2012 18:06:19 -0500
Received: from honk.padd.com ([74.3.171.149]:43656 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752335Ab2ABXGR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jan 2012 18:06:17 -0500
Received: from arf.padd.com (unknown [50.55.144.134])
	by honk.padd.com (Postfix) with ESMTPSA id 1B0821C7E;
	Mon,  2 Jan 2012 15:06:17 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 49E6F667D7; Mon,  2 Jan 2012 18:06:14 -0500 (EST)
X-Mailer: git-send-email 1.7.8.1.409.g3e338
In-Reply-To: <1325545554-16540-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187844>

Test many aspects of processing p4 client views with the
git-p4 option --use-client-spec.  16 out of 22 tests are
currently broken.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/t9809-git-p4-client-view.sh |  290 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 290 insertions(+), 0 deletions(-)
 create mode 100755 t/t9809-git-p4-client-view.sh

diff --git a/t/t9809-git-p4-client-view.sh b/t/t9809-git-p4-client-view.sh
new file mode 100755
index 0000000..4259fb3
--- /dev/null
+++ b/t/t9809-git-p4-client-view.sh
@@ -0,0 +1,290 @@
+#!/bin/sh
+
+test_description='git-p4 client view'
+
+. ./lib-git-p4.sh
+
+test_expect_success 'start p4d' '
+	start_p4d
+'
+
+#
+# Construct a client with this list of View lines
+#
+client_view() {
+	(
+		cat <<-EOF &&
+		Client: client
+		Description: client
+		Root: $cli
+		View:
+		EOF
+		for arg ; do
+			printf "\t$arg\n"
+		done
+	) | p4 client -i
+}
+
+#
+# Verify these files exist, exactly.  Caller creates
+# a list of files in file "files".
+#
+check_files_exist() {
+	ok=0 &&
+	num=${#@} &&
+	for arg ; do
+		test_path_is_file "$arg" &&
+		ok=$(($ok + 1))
+	done &&
+	test $ok -eq $num &&
+	test_line_count = $num files
+}
+
+#
+# Sync up the p4 client, make sure the given files (and only
+# those) exist.
+#
+client_verify() {
+	(
+		cd "$cli" &&
+		p4 sync &&
+		find . -type f ! -name files >files &&
+		check_files_exist "$@"
+	)
+}
+
+#
+# Make sure the named files, exactly, exist.
+#
+git_verify() {
+	(
+		cd "$git" &&
+		git ls-files >files &&
+		check_files_exist "$@"
+	)
+}
+
+# //depot
+#   - dir1
+#     - file11
+#     - file12
+#   - dir2
+#     - file21
+#     - file22
+test_expect_success 'init depot' '
+	(
+		cd "$cli" &&
+		for d in 1 2 ; do
+			mkdir -p dir$d &&
+			for f in 1 2 ; do
+				echo dir$d/file$d$f >dir$d/file$d$f &&
+				p4 add dir$d/file$d$f &&
+				p4 submit -d "dir$d/file$d$f"
+			done
+		done &&
+		find . -type f ! -name files >files &&
+		check_files_exist dir1/file11 dir1/file12 \
+				  dir2/file21 dir2/file22
+	)
+'
+
+# double % for printf
+test_expect_failure 'unsupported view wildcard %%n' '
+	client_view "//depot/%%%%1/sub/... //client/sub/%%%%1/..." &&
+	test_when_finished cleanup_git &&
+	test_must_fail "$GITP4" clone --use-client-spec --dest="$git" //depot
+'
+
+test_expect_failure 'unsupported view wildcard *' '
+	client_view "//depot/*/bar/... //client/*/bar/..." &&
+	test_when_finished cleanup_git &&
+	test_must_fail "$GITP4" clone --use-client-spec --dest="$git" //depot
+'
+
+test_expect_success 'wildcard ... only supported at end of spec' '
+	client_view "//depot/.../file11 //client/.../file11" &&
+	test_when_finished cleanup_git &&
+	test_must_fail "$GITP4" clone --use-client-spec --dest="$git" //depot
+'
+
+test_expect_failure 'basic map' '
+	client_view "//depot/dir1/... //client/cli1/..." &&
+	files="cli1/file11 cli1/file12" &&
+	client_verify $files &&
+	test_when_finished cleanup_git &&
+	"$GITP4" clone --use-client-spec --dest="$git" //depot &&
+	git_verify $files
+'
+
+test_expect_failure 'client view with no mappings' '
+	client_view &&
+	client_verify &&
+	test_when_finished cleanup_git &&
+	"$GITP4" clone --use-client-spec --dest="$git" //depot &&
+	git_verify
+'
+
+test_expect_failure 'single file map' '
+	client_view "//depot/dir1/file11 //client/file11" &&
+	files="file11" &&
+	client_verify $files &&
+	test_when_finished cleanup_git &&
+	"$GITP4" clone --use-client-spec --dest="$git" //depot &&
+	git_verify $files
+'
+
+test_expect_failure 'later mapping takes precedence (entire repo)' '
+	client_view "//depot/dir1/... //client/cli1/..." \
+		    "//depot/... //client/cli2/..." &&
+	files="cli2/dir1/file11 cli2/dir1/file12
+	       cli2/dir2/file21 cli2/dir2/file22" &&
+	client_verify $files &&
+	test_when_finished cleanup_git &&
+	"$GITP4" clone --use-client-spec --dest="$git" //depot &&
+	git_verify $files
+'
+
+test_expect_failure 'later mapping takes precedence (partial repo)' '
+	client_view "//depot/dir1/... //client/..." \
+		    "//depot/dir2/... //client/..." &&
+	files="file21 file22" &&
+	client_verify $files &&
+	test_when_finished cleanup_git &&
+	"$GITP4" clone --use-client-spec --dest="$git" //depot &&
+	git_verify $files
+'
+
+# Reading the view backwards,
+#   dir2 goes to cli12
+#   dir1 cannot go to cli12 since it was filled by dir2
+#   dir1 also does not go to cli3, since the second rule
+#     noticed that it matched, but was already filled
+test_expect_failure 'depot path matching rejected client path' '
+	client_view "//depot/dir1/... //client/cli3/..." \
+		    "//depot/dir1/... //client/cli12/..." \
+		    "//depot/dir2/... //client/cli12/..." &&
+	files="cli12/file21 cli12/file22" &&
+	client_verify $files &&
+	test_when_finished cleanup_git &&
+	"$GITP4" clone --use-client-spec --dest="$git" //depot &&
+	git_verify $files
+'
+
+# since both have the same //client/..., the exclusion
+# rule keeps everything out
+test_expect_failure 'exclusion wildcard, client rhs same (odd)' '
+	client_view "//depot/... //client/..." \
+		    "-//depot/dir2/... //client/..." &&
+	client_verify &&
+	test_when_finished cleanup_git &&
+	"$GITP4" clone --use-client-spec --dest="$git" //depot &&
+	git_verify
+'
+
+test_expect_success 'exclusion wildcard, client rhs different (normal)' '
+	client_view "//depot/... //client/..." \
+		    "-//depot/dir2/... //client/dir2/..." &&
+	files="dir1/file11 dir1/file12" &&
+	client_verify $files &&
+	test_when_finished cleanup_git &&
+	"$GITP4" clone --use-client-spec --dest="$git" //depot &&
+	git_verify $files
+'
+
+test_expect_failure 'exclusion single file' '
+	client_view "//depot/... //client/..." \
+		    "-//depot/dir2/file22 //client/file22" &&
+	files="dir1/file11 dir1/file12 dir2/file21" &&
+	client_verify $files &&
+	test_when_finished cleanup_git &&
+	"$GITP4" clone --use-client-spec --dest="$git" //depot &&
+	git_verify $files
+'
+
+test_expect_failure 'overlay wildcard' '
+	client_view "//depot/dir1/... //client/cli/..." \
+		    "+//depot/dir2/... //client/cli/...\n" &&
+	files="cli/file11 cli/file12 cli/file21 cli/file22" &&
+	client_verify $files &&
+	test_when_finished cleanup_git &&
+	"$GITP4" clone --use-client-spec --dest="$git" //depot &&
+	git_verify $files
+'
+
+test_expect_failure 'overlay single file' '
+	client_view "//depot/dir1/... //client/cli/..." \
+		    "+//depot/dir2/file21 //client/cli/file21" &&
+	files="cli/file11 cli/file12 cli/file21" &&
+	client_verify $files &&
+	test_when_finished cleanup_git &&
+	"$GITP4" clone --use-client-spec --dest="$git" //depot &&
+	git_verify $files
+'
+
+test_expect_failure 'exclusion with later inclusion' '
+	client_view "//depot/... //client/..." \
+		    "-//depot/dir2/... //client/dir2/..." \
+		    "//depot/dir2/... //client/dir2incl/..." &&
+	files="dir1/file11 dir1/file12 dir2incl/file21 dir2incl/file22" &&
+	client_verify $files &&
+	test_when_finished cleanup_git &&
+	"$GITP4" clone --use-client-spec --dest="$git" //depot &&
+	git_verify $files
+'
+
+test_expect_failure 'quotes on rhs only' '
+	client_view "//depot/dir1/... \"//client/cdir 1/...\"" &&
+	client_verify "cdir 1/file11" "cdir 1/file12" &&
+	test_when_finished cleanup_git &&
+	"$GITP4" clone --use-client-spec --dest="$git" //depot &&
+	git_verify "cdir 1/file11" "cdir 1/file12"
+'
+
+#
+# Rename directories to test quoting in depot-side mappings
+# //depot
+#    - "dir 1"
+#       - file11
+#       - file12
+#    - "dir 2"
+#       - file21
+#       - file22
+#
+test_expect_success 'rename files to introduce spaces' '
+	client_view "//depot/... //client/..." &&
+	client_verify dir1/file11 dir1/file12 \
+		      dir2/file21 dir2/file22 &&
+	(
+		cd "$cli" &&
+		p4 open dir1/... &&
+		p4 move dir1/... "dir 1"/... &&
+		p4 open dir2/... &&
+		p4 move dir2/... "dir 2"/... &&
+		p4 submit -d "rename with spaces"
+	) &&
+	client_verify "dir 1/file11" "dir 1/file12" \
+		      "dir 2/file21" "dir 2/file22"
+'
+
+test_expect_failure 'quotes on lhs only' '
+	client_view "\"//depot/dir 1/...\" //client/cdir1/..." &&
+	files="cdir1/file11 cdir1/file12" &&
+	client_verify $files &&
+	test_when_finished cleanup_git &&
+	"$GITP4" clone --use-client-spec --dest="$git" //depot &&
+	client_verify $files
+'
+
+test_expect_failure 'quotes on both sides' '
+	client_view "\"//depot/dir 1/...\" \"//client/cdir 1/...\"" &&
+	client_verify "cdir 1/file11" "cdir 1/file12" &&
+	test_when_finished cleanup_git &&
+	"$GITP4" clone --use-client-spec --dest="$git" //depot &&
+	git_verify "cdir 1/file11" "cdir 1/file12"
+'
+
+test_expect_success 'kill p4d' '
+	kill_p4d
+'
+
+test_done
-- 
1.7.8.1.407.gd70cb
