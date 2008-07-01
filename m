From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 13/14] git-commit-tree: make it usable from other builtins
Date: Tue,  1 Jul 2008 04:37:49 +0200
Message-ID: <1b74bb93e518a906b0067d182fb29279baff3b25.1214879690.git.vmiklos@frugalware.org>
References: <cover.1214879690.git.vmiklos@frugalware.org>
 <9201d4e13e574c10b1674cf1f6da23a44a73f8b2.1214879690.git.vmiklos@frugalware.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Olivier Marin <dkr@freesurf.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 01 04:38:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDVlX-0004mN-62
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 04:38:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754315AbYGAChw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 22:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754285AbYGAChv
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 22:37:51 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:44504 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753400AbYGACht (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 22:37:49 -0400
Received: from vmobile.example.net (catv-5062e651.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTP id EF24F1DDC5C;
	Tue,  1 Jul 2008 04:37:46 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id CC84D1A990B; Tue,  1 Jul 2008 04:37:50 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.1
In-Reply-To: <9201d4e13e574c10b1674cf1f6da23a44a73f8b2.1214879690.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1214879690.git.vmiklos@frugalware.org>
References: <cover.1214879690.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86983>

Move all functionality (except option parsing) from cmd_commit_tree() to
commit_tree(), so that other builtins can use it without a child
process.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 builtin-commit-tree.c |   71 ++++++++++++++++++++++++++++--------------------
 builtin.h             |    4 +++
 2 files changed, 45 insertions(+), 30 deletions(-)

diff --git a/builtin-commit-tree.c b/builtin-commit-tree.c
index 3881f6c..7a9a309 100644
--- a/builtin-commit-tree.c
+++ b/builtin-commit-tree.c
@@ -45,41 +45,19 @@ static const char commit_utf8_warn[] =
 "You may want to amend it after fixing the message, or set the config\n"
 "variable i18n.commitencoding to the encoding your project uses.\n";
 
-int cmd_commit_tree(int argc, const char **argv, const char *prefix)
+int commit_tree(const char *msg, unsigned char *tree,
+		struct commit_list *parents, unsigned char *ret)
 {
-	int i;
-	struct commit_list *parents = NULL;
-	unsigned char tree_sha1[20];
-	unsigned char commit_sha1[20];
-	struct strbuf buffer;
 	int encoding_is_utf8;
+	struct strbuf buffer;
 
-	git_config(git_default_config, NULL);
-
-	if (argc < 2)
-		usage(commit_tree_usage);
-	if (get_sha1(argv[1], tree_sha1))
-		die("Not a valid object name %s", argv[1]);
-
-	check_valid(tree_sha1, OBJ_TREE);
-	for (i = 2; i < argc; i += 2) {
-		unsigned char sha1[20];
-		const char *a, *b;
-		a = argv[i]; b = argv[i+1];
-		if (!b || strcmp(a, "-p"))
-			usage(commit_tree_usage);
-
-		if (get_sha1(b, sha1))
-			die("Not a valid object name %s", b);
-		check_valid(sha1, OBJ_COMMIT);
-		new_parent(lookup_commit(sha1), &parents);
-	}
+	check_valid(tree, OBJ_TREE);
 
 	/* Not having i18n.commitencoding is the same as having utf-8 */
 	encoding_is_utf8 = is_encoding_utf8(git_commit_encoding);
 
 	strbuf_init(&buffer, 8192); /* should avoid reallocs for the headers */
-	strbuf_addf(&buffer, "tree %s\n", sha1_to_hex(tree_sha1));
+	strbuf_addf(&buffer, "tree %s\n", sha1_to_hex(tree));
 
 	/*
 	 * NOTE! This ordering means that the same exact tree merged with a
@@ -102,14 +80,47 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 	strbuf_addch(&buffer, '\n');
 
 	/* And add the comment */
-	if (strbuf_read(&buffer, 0, 0) < 0)
-		die("git-commit-tree: read returned %s", strerror(errno));
+	strbuf_addstr(&buffer, msg);
 
 	/* And check the encoding */
 	if (encoding_is_utf8 && !is_utf8(buffer.buf))
 		fprintf(stderr, commit_utf8_warn);
 
-	if (!write_sha1_file(buffer.buf, buffer.len, commit_type, commit_sha1)) {
+	return write_sha1_file(buffer.buf, buffer.len, commit_type, ret);
+}
+
+int cmd_commit_tree(int argc, const char **argv, const char *prefix)
+{
+	int i;
+	struct commit_list *parents = NULL;
+	unsigned char tree_sha1[20];
+	unsigned char commit_sha1[20];
+	struct strbuf buffer = STRBUF_INIT;
+
+	git_config(git_default_config, NULL);
+
+	if (argc < 2)
+		usage(commit_tree_usage);
+	if (get_sha1(argv[1], tree_sha1))
+		die("Not a valid object name %s", argv[1]);
+
+	for (i = 2; i < argc; i += 2) {
+		unsigned char sha1[20];
+		const char *a, *b;
+		a = argv[i]; b = argv[i+1];
+		if (!b || strcmp(a, "-p"))
+			usage(commit_tree_usage);
+
+		if (get_sha1(b, sha1))
+			die("Not a valid object name %s", b);
+		check_valid(sha1, OBJ_COMMIT);
+		new_parent(lookup_commit(sha1), &parents);
+	}
+
+	if (strbuf_read(&buffer, 0, 0) < 0)
+		die("git-commit-tree: read returned %s", strerror(errno));
+
+	if (!commit_tree(buffer.buf, tree_sha1, parents, commit_sha1)) {
 		printf("%s\n", sha1_to_hex(commit_sha1));
 		return 0;
 	}
diff --git a/builtin.h b/builtin.h
index 2b01fea..05ee56f 100644
--- a/builtin.h
+++ b/builtin.h
@@ -3,6 +3,8 @@
 
 #include "git-compat-util.h"
 #include "strbuf.h"
+#include "cache.h"
+#include "commit.h"
 
 extern const char git_version_string[];
 extern const char git_usage_string[];
@@ -14,6 +16,8 @@ extern void prune_packed_objects(int);
 extern int read_line_with_nul(char *buf, int size, FILE *file);
 extern int fmt_merge_msg(int merge_summary, struct strbuf *in,
 	struct strbuf *out);
+extern int commit_tree(const char *msg, unsigned char *tree,
+		struct commit_list *parents, unsigned char *ret);
 
 extern int cmd_add(int argc, const char **argv, const char *prefix);
 extern int cmd_annotate(int argc, const char **argv, const char *prefix);
-- 
1.5.6.1
