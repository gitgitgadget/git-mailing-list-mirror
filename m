From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 2/3] builtin-commit: use commit_tree()
Date: Wed, 10 Sep 2008 22:10:32 +0200
Message-ID: <2984711bae2f0777b210ed04210693ac02164519.1221077214.git.vmiklos@frugalware.org>
References: <cover.1221077214.git.vmiklos@frugalware.org>
 <11d30964e7de652a790f5362f0b49e2a19de17ee.1221077214.git.vmiklos@frugalware.org>
Cc: Russell King <rmk@arm.linux.org.uk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 10 22:12:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdW2U-0003is-QF
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 22:11:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752315AbYIJUKm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 16:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752304AbYIJUKl
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 16:10:41 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:36733 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752196AbYIJUKf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 16:10:35 -0400
Received: from vmobile.example.net (dsl5401CEA5.pool.t-online.hu [84.1.206.165])
	by yugo.frugalware.org (Postfix) with ESMTPA id 3EA3E149C60;
	Wed, 10 Sep 2008 22:10:33 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id B5B8E84CA; Wed, 10 Sep 2008 22:10:33 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.1
In-Reply-To: <11d30964e7de652a790f5362f0b49e2a19de17ee.1221077214.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1221077214.git.vmiklos@frugalware.org>
References: <cover.1221077214.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95552>

First, it adds less code than removes, second this allows us to use
recuce_heads() for parents, so that the parents of a merge will be
always the same with or without a conflict.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 builtin-commit.c |   63 ++++++++++++------------------------------------------
 1 files changed, 14 insertions(+), 49 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 8165bb3..ad055ea 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -670,11 +670,11 @@ static int prepare_to_commit(const char *index_file, const char *prefix)
  * Find out if the message starting at position 'start' in the strbuf
  * contains only whitespace and Signed-off-by lines.
  */
-static int message_is_empty(struct strbuf *sb, int start)
+static int message_is_empty(struct strbuf *sb)
 {
 	struct strbuf tmpl;
 	const char *nl;
-	int eol, i;
+	int eol, i, start = 0;
 
 	if (cleanup_mode == CLEANUP_NONE && sb->len)
 		return 0;
@@ -929,34 +929,14 @@ static const char commit_utf8_warn[] =
 "You may want to amend it after fixing the message, or set the config\n"
 "variable i18n.commitencoding to the encoding your project uses.\n";
 
-static void add_parent(struct strbuf *sb, const unsigned char *sha1)
-{
-	struct object *obj = parse_object(sha1);
-	const char *parent = sha1_to_hex(sha1);
-	const char *cp;
-
-	if (!obj)
-		die("Unable to find commit parent %s", parent);
-	if (obj->type != OBJ_COMMIT)
-		die("Parent %s isn't a proper commit", parent);
-
-	for (cp = sb->buf; cp && (cp = strstr(cp, "\nparent ")); cp += 8) {
-		if (!memcmp(cp + 8, parent, 40) && cp[48] == '\n') {
-			error("duplicate parent %s ignored", parent);
-			return;
-		}
-	}
-	strbuf_addf(sb, "parent %s\n", parent);
-}
-
 int cmd_commit(int argc, const char **argv, const char *prefix)
 {
-	int header_len;
 	struct strbuf sb;
 	const char *index_file, *reflog_msg;
 	char *nl, *p;
 	unsigned char commit_sha1[20];
 	struct ref_lock *ref_lock;
+	struct commit_list *parents = NULL, **pptr = &parents;
 
 	git_config(git_commit_config, NULL);
 
@@ -971,13 +951,6 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		return 1;
 	}
 
-	/*
-	 * The commit object
-	 */
-	strbuf_init(&sb, 0);
-	strbuf_addf(&sb, "tree %s\n",
-		    sha1_to_hex(active_cache_tree->sha1));
-
 	/* Determine parents */
 	if (initial_commit) {
 		reflog_msg = "commit (initial)";
@@ -991,13 +964,13 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 			die("could not parse HEAD commit");
 
 		for (c = commit->parents; c; c = c->next)
-			add_parent(&sb, c->item->object.sha1);
+			pptr = &commit_list_insert(c->item, pptr)->next;
 	} else if (in_merge) {
 		struct strbuf m;
 		FILE *fp;
 
 		reflog_msg = "commit (merge)";
-		add_parent(&sb, head_sha1);
+		pptr = &commit_list_insert(lookup_commit(head_sha1), pptr)->next;
 		strbuf_init(&m, 0);
 		fp = fopen(git_path("MERGE_HEAD"), "r");
 		if (fp == NULL)
@@ -1007,24 +980,18 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 			unsigned char sha1[20];
 			if (get_sha1_hex(m.buf, sha1) < 0)
 				die("Corrupt MERGE_HEAD file (%s)", m.buf);
-			add_parent(&sb, sha1);
+			pptr = &commit_list_insert(lookup_commit(sha1), pptr)->next;
 		}
 		fclose(fp);
 		strbuf_release(&m);
 	} else {
 		reflog_msg = "commit";
-		strbuf_addf(&sb, "parent %s\n", sha1_to_hex(head_sha1));
+		pptr = &commit_list_insert(lookup_commit(head_sha1), pptr)->next;
 	}
-
-	strbuf_addf(&sb, "author %s\n",
-		    fmt_ident(author_name, author_email, author_date, IDENT_ERROR_ON_NO_NAME));
-	strbuf_addf(&sb, "committer %s\n", git_committer_info(IDENT_ERROR_ON_NO_NAME));
-	if (!is_encoding_utf8(git_commit_encoding))
-		strbuf_addf(&sb, "encoding %s\n", git_commit_encoding);
-	strbuf_addch(&sb, '\n');
+	parents = reduce_heads(parents);
 
 	/* Finally, get the commit message */
-	header_len = sb.len;
+	strbuf_init(&sb, 0);
 	if (strbuf_read_file(&sb, git_path(commit_editmsg), 0) < 0) {
 		rollback_index_files();
 		die("could not read commit message");
@@ -1037,16 +1004,15 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 
 	if (cleanup_mode != CLEANUP_NONE)
 		stripspace(&sb, cleanup_mode == CLEANUP_ALL);
-	if (sb.len < header_len || message_is_empty(&sb, header_len)) {
+	if (message_is_empty(&sb)) {
 		rollback_index_files();
 		fprintf(stderr, "Aborting commit due to empty commit message.\n");
 		exit(1);
 	}
-	strbuf_addch(&sb, '\0');
-	if (is_encoding_utf8(git_commit_encoding) && !is_utf8(sb.buf))
-		fprintf(stderr, commit_utf8_warn);
 
-	if (write_sha1_file(sb.buf, sb.len - 1, commit_type, commit_sha1)) {
+	if (commit_tree(sb.buf, active_cache_tree->sha1, parents, commit_sha1,
+			fmt_ident(author_name, author_email, author_date,
+				IDENT_ERROR_ON_NO_NAME))) {
 		rollback_index_files();
 		die("failed to write commit object");
 	}
@@ -1055,12 +1021,11 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 					   initial_commit ? NULL : head_sha1,
 					   0);
 
-	nl = strchr(sb.buf + header_len, '\n');
+	nl = strchr(sb.buf, '\n');
 	if (nl)
 		strbuf_setlen(&sb, nl + 1 - sb.buf);
 	else
 		strbuf_addch(&sb, '\n');
-	strbuf_remove(&sb, 0, header_len);
 	strbuf_insert(&sb, 0, reflog_msg, strlen(reflog_msg));
 	strbuf_insert(&sb, strlen(reflog_msg), ": ", 2);
 
-- 
1.6.0.1
