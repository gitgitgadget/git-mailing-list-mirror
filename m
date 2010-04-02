From: Jeff King <peff@peff.net>
Subject: [PATCH 3/7] make commit_tree a library function
Date: Thu, 1 Apr 2010 20:05:23 -0400
Message-ID: <20100402000523.GC16462@coredump.intra.peff.net>
References: <20100402000159.GA15101@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 02 02:05:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxUOL-0008Nk-Ii
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 02:05:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759049Ab0DBAFh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Apr 2010 20:05:37 -0400
Received: from peff.net ([208.65.91.99]:33414 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759045Ab0DBAFf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Apr 2010 20:05:35 -0400
Received: (qmail 5175 invoked by uid 107); 2 Apr 2010 00:06:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 01 Apr 2010 20:06:10 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Apr 2010 20:05:23 -0400
Content-Disposition: inline
In-Reply-To: <20100402000159.GA15101@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143764>

Until now, this has been part of the commit-tree builtin.
However, it is already used by other builtins (like commit,
merge, and notes), and it would be useful to access it from
library code.

The check_valid helper has to come along, too, but is given
a more library-ish name of "assert_sha1_type".

Otherwise, the code is unchanged. There are still a few
rough edges for a library function, like printing the utf8
warning to stderr, but we can address those if and when they
come up as inappropriate.

Signed-off-by: Jeff King <peff@peff.net>
---
I'm not inclined to try lib-ifying it any more, as it would just feel
like code churn. It's not as if we aren't calling it from all over
already, so this is really just about moving it out of builtin/.

 builtin.h             |    3 --
 builtin/commit-tree.c |   70 +------------------------------------------------
 cache.h               |    2 +
 commit.c              |   55 ++++++++++++++++++++++++++++++++++++++
 commit.h              |    4 +++
 sha1_file.c           |   10 +++++++
 6 files changed, 72 insertions(+), 72 deletions(-)

diff --git a/builtin.h b/builtin.h
index 464588b..5c887ef 100644
--- a/builtin.h
+++ b/builtin.h
@@ -16,9 +16,6 @@ extern const char *help_unknown_cmd(const char *cmd);
 extern void prune_packed_objects(int);
 extern int fmt_merge_msg(int merge_summary, struct strbuf *in,
 	struct strbuf *out);
-extern int commit_tree(const char *msg, unsigned char *tree,
-		struct commit_list *parents, unsigned char *ret,
-		const char *author);
 extern int commit_notes(struct notes_tree *t, const char *msg);
 
 struct notes_rewrite_cfg {
diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index 90dac34..87f0591 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -9,19 +9,6 @@
 #include "builtin.h"
 #include "utf8.h"
 
-/*
- * FIXME! Share the code with "write-tree.c"
- */
-static void check_valid(unsigned char *sha1, enum object_type expect)
-{
-	enum object_type type = sha1_object_info(sha1, NULL);
-	if (type < 0)
-		die("%s is not a valid object", sha1_to_hex(sha1));
-	if (type != expect)
-		die("%s is not a valid '%s' object", sha1_to_hex(sha1),
-		    typename(expect));
-}
-
 static const char commit_tree_usage[] = "git commit-tree <sha1> [-p <sha1>]* < changelog";
 
 static void new_parent(struct commit *parent, struct commit_list **parents_p)
@@ -38,61 +25,6 @@ static void new_parent(struct commit *parent, struct commit_list **parents_p)
 	commit_list_insert(parent, parents_p);
 }
 
-static const char commit_utf8_warn[] =
-"Warning: commit message does not conform to UTF-8.\n"
-"You may want to amend it after fixing the message, or set the config\n"
-"variable i18n.commitencoding to the encoding your project uses.\n";
-
-int commit_tree(const char *msg, unsigned char *tree,
-		struct commit_list *parents, unsigned char *ret,
-		const char *author)
-{
-	int result;
-	int encoding_is_utf8;
-	struct strbuf buffer;
-
-	check_valid(tree, OBJ_TREE);
-
-	/* Not having i18n.commitencoding is the same as having utf-8 */
-	encoding_is_utf8 = is_encoding_utf8(git_commit_encoding);
-
-	strbuf_init(&buffer, 8192); /* should avoid reallocs for the headers */
-	strbuf_addf(&buffer, "tree %s\n", sha1_to_hex(tree));
-
-	/*
-	 * NOTE! This ordering means that the same exact tree merged with a
-	 * different order of parents will be a _different_ changeset even
-	 * if everything else stays the same.
-	 */
-	while (parents) {
-		struct commit_list *next = parents->next;
-		strbuf_addf(&buffer, "parent %s\n",
-			sha1_to_hex(parents->item->object.sha1));
-		free(parents);
-		parents = next;
-	}
-
-	/* Person/date information */
-	if (!author)
-		author = git_author_info(IDENT_ERROR_ON_NO_NAME);
-	strbuf_addf(&buffer, "author %s\n", author);
-	strbuf_addf(&buffer, "committer %s\n", git_committer_info(IDENT_ERROR_ON_NO_NAME));
-	if (!encoding_is_utf8)
-		strbuf_addf(&buffer, "encoding %s\n", git_commit_encoding);
-	strbuf_addch(&buffer, '\n');
-
-	/* And add the comment */
-	strbuf_addstr(&buffer, msg);
-
-	/* And check the encoding */
-	if (encoding_is_utf8 && !is_utf8(buffer.buf))
-		fprintf(stderr, commit_utf8_warn);
-
-	result = write_sha1_file(buffer.buf, buffer.len, commit_type, ret);
-	strbuf_release(&buffer);
-	return result;
-}
-
 int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 {
 	int i;
@@ -117,7 +49,7 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 
 		if (get_sha1(b, sha1))
 			die("Not a valid object name %s", b);
-		check_valid(sha1, OBJ_COMMIT);
+		assert_sha1_type(sha1, OBJ_COMMIT);
 		new_parent(lookup_commit(sha1), &parents);
 	}
 
diff --git a/cache.h b/cache.h
index 5eb0573..bfc4d82 100644
--- a/cache.h
+++ b/cache.h
@@ -718,6 +718,8 @@ extern int has_loose_object_nonlocal(const unsigned char *sha1);
 
 extern int has_pack_index(const unsigned char *sha1);
 
+extern void assert_sha1_type(const unsigned char *sha1, enum object_type expect);
+
 extern const signed char hexval_table[256];
 static inline unsigned int hexval(unsigned char c)
 {
diff --git a/commit.c b/commit.c
index 731191e..e9b0750 100644
--- a/commit.c
+++ b/commit.c
@@ -790,3 +790,58 @@ struct commit_list *reduce_heads(struct commit_list *heads)
 	free(other);
 	return result;
 }
+
+static const char commit_utf8_warn[] =
+"Warning: commit message does not conform to UTF-8.\n"
+"You may want to amend it after fixing the message, or set the config\n"
+"variable i18n.commitencoding to the encoding your project uses.\n";
+
+int commit_tree(const char *msg, unsigned char *tree,
+		struct commit_list *parents, unsigned char *ret,
+		const char *author)
+{
+	int result;
+	int encoding_is_utf8;
+	struct strbuf buffer;
+
+	assert_sha1_type(tree, OBJ_TREE);
+
+	/* Not having i18n.commitencoding is the same as having utf-8 */
+	encoding_is_utf8 = is_encoding_utf8(git_commit_encoding);
+
+	strbuf_init(&buffer, 8192); /* should avoid reallocs for the headers */
+	strbuf_addf(&buffer, "tree %s\n", sha1_to_hex(tree));
+
+	/*
+	 * NOTE! This ordering means that the same exact tree merged with a
+	 * different order of parents will be a _different_ changeset even
+	 * if everything else stays the same.
+	 */
+	while (parents) {
+		struct commit_list *next = parents->next;
+		strbuf_addf(&buffer, "parent %s\n",
+			sha1_to_hex(parents->item->object.sha1));
+		free(parents);
+		parents = next;
+	}
+
+	/* Person/date information */
+	if (!author)
+		author = git_author_info(IDENT_ERROR_ON_NO_NAME);
+	strbuf_addf(&buffer, "author %s\n", author);
+	strbuf_addf(&buffer, "committer %s\n", git_committer_info(IDENT_ERROR_ON_NO_NAME));
+	if (!encoding_is_utf8)
+		strbuf_addf(&buffer, "encoding %s\n", git_commit_encoding);
+	strbuf_addch(&buffer, '\n');
+
+	/* And add the comment */
+	strbuf_addstr(&buffer, msg);
+
+	/* And check the encoding */
+	if (encoding_is_utf8 && !is_utf8(buffer.buf))
+		fprintf(stderr, commit_utf8_warn);
+
+	result = write_sha1_file(buffer.buf, buffer.len, commit_type, ret);
+	strbuf_release(&buffer);
+	return result;
+}
diff --git a/commit.h b/commit.h
index 3cf5166..2b7fd89 100644
--- a/commit.h
+++ b/commit.h
@@ -158,4 +158,8 @@ static inline int single_parent(struct commit *commit)
 
 struct commit_list *reduce_heads(struct commit_list *heads);
 
+extern int commit_tree(const char *msg, unsigned char *tree,
+		struct commit_list *parents, unsigned char *ret,
+		const char *author);
+
 #endif /* COMMIT_H */
diff --git a/sha1_file.c b/sha1_file.c
index ff65328..28c056e 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2516,3 +2516,13 @@ int read_pack_header(int fd, struct pack_header *header)
 		return PH_ERROR_PROTOCOL;
 	return 0;
 }
+
+void assert_sha1_type(const unsigned char *sha1, enum object_type expect)
+{
+	enum object_type type = sha1_object_info(sha1, NULL);
+	if (type < 0)
+		die("%s is not a valid object", sha1_to_hex(sha1));
+	if (type != expect)
+		die("%s is not a valid '%s' object", sha1_to_hex(sha1),
+		    typename(expect));
+}
-- 
1.7.0.4.299.gba9d4
