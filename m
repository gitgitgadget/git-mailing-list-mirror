From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH/RFC v4 3/5] sha1_name: support @{-N} syntax in get_sha1()
Date: Sat, 17 Jan 2009 17:09:55 +0100
Message-ID: <1232208597-29249-4-git-send-email-trast@student.ethz.ch>
References: <alpine.DEB.1.00.0901171602340.3586@pacific.mpi-cbg.de>
 <1232208597-29249-1-git-send-email-trast@student.ethz.ch>
 <1232208597-29249-2-git-send-email-trast@student.ethz.ch>
 <1232208597-29249-3-git-send-email-trast@student.ethz.ch>
Cc: Junio C Hamano <junio@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Johan Herland <johan@herland.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 17 17:12:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LODm6-0001dD-Af
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 17:11:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762523AbZAQQKL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 11:10:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760458AbZAQQKI
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 11:10:08 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:7146 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757135AbZAQQJ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 11:09:56 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 17 Jan 2009 17:09:51 +0100
Received: from localhost.localdomain ([84.75.148.62]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 17 Jan 2009 17:09:51 +0100
X-Mailer: git-send-email 1.6.1.315.g92577
In-Reply-To: <1232208597-29249-3-git-send-email-trast@student.ethz.ch>
X-OriginalArrivalTime: 17 Jan 2009 16:09:51.0988 (UTC) FILETIME=[0763F340:01C978BE]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106077>

Let get_sha1() parse the @{-N} syntax, with docs and tests.

Note that while @{-1}^2, @{-2}~5 and such are supported, @{-1}@{1} is
currently not allowed.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/git-rev-parse.txt |    3 ++
 sha1_name.c                     |   16 +++++++--
 t/t1505-rev-parse-last.sh       |   71 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 87 insertions(+), 3 deletions(-)
 create mode 100755 t/t1505-rev-parse-last.sh

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 2921da3..3ccef2f 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -212,6 +212,9 @@ when you run 'git-merge'.
   reflog of the current branch. For example, if you are on the
   branch 'blabla', then '@\{1\}' means the same as 'blabla@\{1\}'.
 
+* The special construct '@\{-<n>\}' means the <n>th branch checked out
+  before the current one.
+
 * A suffix '{caret}' to a revision parameter means the first parent of
   that commit object.  '{caret}<n>' means the <n>th parent (i.e.
   'rev{caret}'
diff --git a/sha1_name.c b/sha1_name.c
index 34e39db..9e1538e 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -297,6 +297,8 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
 	return logs_found;
 }
 
+static int get_sha1_1(const char *name, int len, unsigned char *sha1);
+
 static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 {
 	static const char *warning = "warning: refname '%.*s' is ambiguous.\n";
@@ -307,7 +309,7 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 	if (len == 40 && !get_sha1_hex(str, sha1))
 		return 0;
 
-	/* basic@{time or number} format to query ref-log */
+	/* basic@{time or number or -number} format to query ref-log */
 	reflog_len = at = 0;
 	if (str[len-1] == '}') {
 		for (at = 0; at < len - 1; at++) {
@@ -324,6 +326,16 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 		return -1;
 
 	if (!len && reflog_len) {
+		struct strbuf buf = STRBUF_INIT;
+		int ret;
+		/* try the @{-N} syntax for n-th checkout */
+		ret = interpret_nth_last_branch(str+at, &buf);
+		if (ret > 0) {
+			/* substitute this branch name and restart */
+			return get_sha1_1(buf.buf, buf.len, sha1);
+		} else if (ret == 0) {
+			return -1;
+		}
 		/* allow "@{...}" to mean the current branch reflog */
 		refs_found = dwim_ref("HEAD", 4, sha1, &real_ref);
 	} else if (reflog_len)
@@ -379,8 +391,6 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 	return 0;
 }
 
-static int get_sha1_1(const char *name, int len, unsigned char *sha1);
-
 static int get_parent(const char *name, int len,
 		      unsigned char *result, int idx)
 {
diff --git a/t/t1505-rev-parse-last.sh b/t/t1505-rev-parse-last.sh
new file mode 100755
index 0000000..1e49dd2
--- /dev/null
+++ b/t/t1505-rev-parse-last.sh
@@ -0,0 +1,71 @@
+#!/bin/sh
+
+test_description='test @{-N} syntax'
+
+. ./test-lib.sh
+
+
+make_commit () {
+	echo "$1" > "$1" &&
+	git add "$1" &&
+	git commit -m "$1"
+}
+
+
+test_expect_success 'setup' '
+
+	make_commit 1 &&
+	git branch side &&
+	make_commit 2 &&
+	make_commit 3 &&
+	git checkout side &&
+	make_commit 4 &&
+	git merge master &&
+	git checkout master
+
+'
+
+# 1 -- 2 -- 3 master
+#  \         \
+#   \         \
+#    --- 4 --- 5 side
+#
+# and 'side' should be the last branch
+
+git log --graph --all --pretty=oneline --decorate
+
+test_rev_equivalent () {
+
+	git rev-parse "$1" > expect &&
+	git rev-parse "$2" > output &&
+	test_cmp expect output
+
+}
+
+test_expect_success '@{-1} works' '
+	test_rev_equivalent side @{-1}
+'
+
+test_expect_success '@{-1}~2 works' '
+	test_rev_equivalent side~2 @{-1}~2
+'
+
+test_expect_success '@{-1}^2 works' '
+	test_rev_equivalent side^2 @{-1}^2
+'
+
+test_expect_failure '@{-1}@{1} works' '
+	test_rev_equivalent side@{1} @{-1}@{1}
+'
+
+test_expect_success '@{-2} works' '
+	test_rev_equivalent master @{-2}
+'
+
+test_expect_success '@{-3} fails' '
+	test_must_fail git rev-parse @{-3}
+'
+
+test_done
+
+
-- 
1.6.1.315.g92577
