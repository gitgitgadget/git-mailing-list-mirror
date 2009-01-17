From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH/RFC v3bis 1/2] sha1_name: implement @{-N} syntax for N-th last checked out
Date: Sat, 17 Jan 2009 14:40:20 +0100
Message-ID: <1232199621-31072-1-git-send-email-trast@student.ethz.ch>
References: <200901171438.22504.trast@student.ethz.ch>
Cc: Junio C Hamano <junio@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Johan Herland <johan@herland.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 17 14:41:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOBQn-0005AP-35
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 14:41:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756326AbZAQNkU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 08:40:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754874AbZAQNkU
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 08:40:20 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:24164 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754775AbZAQNkS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 08:40:18 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 17 Jan 2009 14:40:16 +0100
Received: from localhost.localdomain ([84.75.148.62]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 17 Jan 2009 14:40:16 +0100
X-Mailer: git-send-email 1.6.1.315.g92577
In-Reply-To: <200901171438.22504.trast@student.ethz.ch>
X-OriginalArrivalTime: 17 Jan 2009 13:40:16.0107 (UTC) FILETIME=[215933B0:01C978A9]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106050>

Implements a new syntax @{-N} that parses the reflog for the N-th last
interesting 'checkout: moving from $branch to $new' entry and
substitutes $branch.  Here, "interesting" is defined as $branch !=
$new.  We then substitute the real branch name for the parse.

For example:

  git checkout foo
  git checkout bar
  git checkout master
  git checkout master   # did not move, so doesn't count
  git rev-parse @{-1}   # same as bar
  git rev-parse @{-2}   # same as foo
  git rev-parse @{-2}~3 # same as foo~3

Thanks to Junio for much of the code.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/git-rev-parse.txt |    3 +
 cache.h                         |    1 +
 sha1_name.c                     |   99 +++++++++++++++++++++++++++++++++++++-
 t/t1505-rev-parse-last.sh       |   71 ++++++++++++++++++++++++++++
 4 files changed, 171 insertions(+), 3 deletions(-)
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
diff --git a/cache.h b/cache.h
index 8e1af26..0dd9168 100644
--- a/cache.h
+++ b/cache.h
@@ -663,6 +663,7 @@ static inline unsigned int hexval(unsigned char c)
 extern const char *resolve_ref(const char *path, unsigned char *sha1, int, int *);
 extern int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref);
 extern int dwim_log(const char *str, int len, unsigned char *sha1, char **ref);
+extern int interpret_nth_last_branch(const char *str, struct strbuf *);
 
 extern int refname_match(const char *abbrev_name, const char *full_name, const char **rules);
 extern const char *ref_rev_parse_rules[];
diff --git a/sha1_name.c b/sha1_name.c
index 159c2ab..9e1538e 100644
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
@@ -674,6 +684,89 @@ static int get_sha1_oneline(const char *prefix, unsigned char *sha1)
 	return retval;
 }
 
+struct grab_nth_branch_switch_cbdata {
+	int counting;
+	int nth;
+	struct strbuf *buf;
+};
+
+static int grab_nth_branch_switch(unsigned char *osha1, unsigned char *nsha1,
+				  const char *email, unsigned long timestamp, int tz,
+				  const char *message, void *cb_data)
+{
+	struct grab_nth_branch_switch_cbdata *cb = cb_data;
+	const char *match = NULL, *target = NULL;
+	size_t len;
+
+	if (!prefixcmp(message, "checkout: moving from ")) {
+		match = message + strlen("checkout: moving from ");
+		if ((target = strstr(match, " to ")) != NULL)
+			target += 4;
+	}
+
+	if (!match)
+		return 0;
+
+	len = target - match - 4;
+	if (target[len] == '\n' && !strncmp(match, target, len))
+		return 0;
+
+	if (cb->counting) {
+		cb->nth++;
+		return 0;
+	}
+
+	if (cb->nth-- <= 0) {
+		strbuf_reset(cb->buf);
+		strbuf_add(cb->buf, match, len);
+		return 1;
+	}
+	return 0;
+}
+
+/*
+ * This reads "@{-N}" syntax, finds the name of the Nth previous
+ * branch we were on, and places the name of the branch in the given
+ * buf and returns the number of characters parsed if successful.
+ *
+ * If the input is not of the accepted format, it returns a negative
+ * number to signal an error.
+ *
+ * If the input was ok but there are not N branch switches in the
+ * reflog, it returns 0.
+ */
+int interpret_nth_last_branch(const char *name, struct strbuf *buf)
+{
+	int nth;
+	struct grab_nth_branch_switch_cbdata cb;
+	const char *brace;
+	char *num_end;
+
+	if (name[0] != '@' || name[1] != '{' || name[2] != '-')
+		return -1;
+	brace = strchr(name, '}');
+	if (!brace)
+		return -1;
+	nth = strtol(name+3, &num_end, 10);
+	if (num_end != brace)
+		return -1;
+
+	cb.counting = 1;
+	cb.nth = 0;
+	cb.buf = buf;
+	for_each_reflog_ent("HEAD", grab_nth_branch_switch, &cb);
+
+	if (cb.nth < nth)
+		return 0;
+
+	cb.counting = 0;
+	cb.nth -= nth;
+	cb.buf = buf;
+	for_each_reflog_ent("HEAD", grab_nth_branch_switch, &cb);
+
+	return brace-name+1;
+}
+
 /*
  * This is like "get_sha1_basic()", except it allows "sha1 expressions",
  * notably "xyz^" for "parent of xyz"
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
