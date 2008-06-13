From: Avery Pennarun <apenwarr@gmail.com>
Subject: [PATCH v2 3/3] filter-branch --blob-filter: add tests.
Date: Thu, 12 Jun 2008 20:52:24 -0400
Message-ID: <1213318344-26013-3-git-send-email-apenwarr@gmail.com>
References: <1213318344-26013-1-git-send-email-apenwarr@gmail.com>
 <1213318344-26013-2-git-send-email-apenwarr@gmail.com>
Cc: gitster@pobox.com, Avery Pennarun <apenwarr@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 03:04:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6xiG-0006N4-Fu
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 03:04:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758306AbYFMBDL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 21:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758293AbYFMBDK
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 21:03:10 -0400
Received: from host.237.101.mtl.cablemodem.vdn.ca ([206.223.237.101]:33079
	"EHLO insight.mtl.versabanq.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757968AbYFMBDF (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jun 2008 21:03:05 -0400
Received: by insight.mtl.versabanq.com (Postfix, from userid 1000)
	id 39478E7C535; Thu, 12 Jun 2008 20:52:24 -0400 (EDT)
X-Mailer: git-send-email 1.5.6.rc2.29.g4717e
In-Reply-To: <1213318344-26013-2-git-send-email-apenwarr@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84819>

Signed-off-by: Avery Pennarun <apenwarr@gmail.com>
---
 t/t7003-filter-branch-blob.sh |   94 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 94 insertions(+), 0 deletions(-)
 create mode 100755 t/t7003-filter-branch-blob.sh

diff --git a/t/t7003-filter-branch-blob.sh b/t/t7003-filter-branch-blob.sh
new file mode 100755
index 0000000..f18031e
--- /dev/null
+++ b/t/t7003-filter-branch-blob.sh
@@ -0,0 +1,94 @@
+#!/bin/sh
+
+test_description='git-filter-branch --blob-filter'
+. ./test-lib.sh
+
+make_commit () {
+	echo -n "$2" >"$1"
+	git add "$1"
+	git commit -a -m "$1"
+}
+
+match_file() {
+	f="$(cat "$1")"
+	echo "'$f'" = "'$2'"
+	test "$f" = "$2"
+}
+
+myfilter() {
+	git-filter-branch --blob-filter 'case "$GIT_BLOB_PATH" in '"$1"') echo -n REPLACEMENT;; *) cat;; esac' HEAD &&
+	rm -rf .git/refs/original
+}
+
+test_expect_success 'setup' '
+	make_commit A "textA" &&
+	make_commit "Space file" "Space text" &&
+	make_commit B.txt "textB" &&
+	make_commit C.jpg "jpgC" &&
+	git checkout -b caching &&
+	make_commit AA "textA" &&
+	make_commit A "textA2" &&
+	git checkout -b renames master &&
+	mkdir dir &&
+	rm -f B.txt &&
+	make_commit dir/B.jpg "textB" &&
+	rm -f C.jpg &&
+	make_commit dir/C.txt "jpgC"
+'
+
+test_expect_success 'rewrite all' '
+	git checkout -b rewrite1 master &&
+	git-filter-branch --blob-filter echo\ -n\ \$GIT_BLOB_PATH HEAD
+	rm -rf .git/refs/original
+'
+
+test_expect_success 'rewrite all - result' '
+	match_file A "A" &&
+	match_file "Space file" "Space file" &&
+	match_file B.txt "B.txt" &&
+	match_file C.jpg "C.jpg"
+'
+
+countfilter() {
+	rm -f counter
+	export P="$PWD"
+	git-filter-branch --blob-filter 'echo tick >>$P/counter; echo -n $GIT_BLOB_PATH' HEAD &&
+	rm -rf .git/refs/original
+}
+
+test_expect_success 'caching' '
+	git checkout -b rewrite1b caching &&
+	countfilter
+'
+
+test_expect_success 'caching - result' '
+	match_file A "A" &&
+	match_file AA "AA" &&
+	match_file B.txt "B.txt" &&
+	match_file C.jpg "C.jpg" &&
+	test "$(cat counter | wc -l)" = 6
+'
+
+test_expect_success 'rewrite .txt only' '
+	git checkout -b rewrite2 master &&
+	myfilter \*.txt
+'
+
+test_expect_success 'rewrite .txt only - result' '
+	match_file A "textA" &&
+	match_file B.txt "REPLACEMENT" &&
+	match_file C.jpg "jpgC"
+'
+
+test_expect_success 'rewrite with renames' '
+	git checkout -b rewrite3 renames &&
+	myfilter \*.txt
+'
+
+test_expect_success 'rewrite with renames - result' '
+	match_file A "textA" &&
+	match_file dir/B.jpg "textB" &&
+	match_file dir/C.txt "REPLACEMENT"
+'
+
+test_done
-- 
1.5.6.rc2.29.g4717e
