From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 1/3] commit_tree(): add a new author parameter
Date: Wed, 10 Sep 2008 22:10:31 +0200
Message-ID: <11d30964e7de652a790f5362f0b49e2a19de17ee.1221077214.git.vmiklos@frugalware.org>
References: <cover.1221077214.git.vmiklos@frugalware.org>
Cc: Russell King <rmk@arm.linux.org.uk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 10 22:11:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdW2U-0003is-24
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 22:11:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752305AbYIJUKl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 16:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752213AbYIJUKk
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 16:10:40 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:36728 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876AbYIJUKf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 16:10:35 -0400
Received: from vmobile.example.net (dsl5401CEA5.pool.t-online.hu [84.1.206.165])
	by yugo.frugalware.org (Postfix) with ESMTPA id 3932C149C5E;
	Wed, 10 Sep 2008 22:10:33 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 6D00984C9; Wed, 10 Sep 2008 22:10:33 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.1
In-Reply-To: <cover.1221077214.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1221077214.git.vmiklos@frugalware.org>
References: <cover.1221077214.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95551>

In case it's NULL, it is still determined automatically, but now you
have the ability to specify one yourself.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 builtin-commit-tree.c |    9 ++++++---
 builtin-merge.c       |    4 ++--
 builtin.h             |    3 ++-
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/builtin-commit-tree.c b/builtin-commit-tree.c
index 8a5ba4c..33c0e82 100644
--- a/builtin-commit-tree.c
+++ b/builtin-commit-tree.c
@@ -46,7 +46,8 @@ static const char commit_utf8_warn[] =
 "variable i18n.commitencoding to the encoding your project uses.\n";
 
 int commit_tree(const char *msg, unsigned char *tree,
-		struct commit_list *parents, unsigned char *ret)
+		struct commit_list *parents, unsigned char *ret,
+		const char *author)
 {
 	int result;
 	int encoding_is_utf8;
@@ -74,7 +75,9 @@ int commit_tree(const char *msg, unsigned char *tree,
 	}
 
 	/* Person/date information */
-	strbuf_addf(&buffer, "author %s\n", git_author_info(IDENT_ERROR_ON_NO_NAME));
+	if (!author)
+		author = git_author_info(IDENT_ERROR_ON_NO_NAME);
+	strbuf_addf(&buffer, "author %s\n", author);
 	strbuf_addf(&buffer, "committer %s\n", git_committer_info(IDENT_ERROR_ON_NO_NAME));
 	if (!encoding_is_utf8)
 		strbuf_addf(&buffer, "encoding %s\n", git_commit_encoding);
@@ -123,7 +126,7 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 	if (strbuf_read(&buffer, 0, 0) < 0)
 		die("git commit-tree: read returned %s", strerror(errno));
 
-	if (!commit_tree(buffer.buf, tree_sha1, parents, commit_sha1)) {
+	if (!commit_tree(buffer.buf, tree_sha1, parents, commit_sha1, NULL)) {
 		printf("%s\n", sha1_to_hex(commit_sha1));
 		return 0;
 	}
diff --git a/builtin-merge.c b/builtin-merge.c
index 9ad9791..4a8ec60 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -691,7 +691,7 @@ static int merge_trivial(void)
 	parent->next = xmalloc(sizeof(struct commit_list *));
 	parent->next->item = remoteheads->item;
 	parent->next->next = NULL;
-	commit_tree(merge_msg.buf, result_tree, parent, result_commit);
+	commit_tree(merge_msg.buf, result_tree, parent, result_commit, NULL);
 	finish(result_commit, "In-index merge");
 	drop_save();
 	return 0;
@@ -720,7 +720,7 @@ static int finish_automerge(struct commit_list *common,
 	}
 	free_commit_list(remoteheads);
 	strbuf_addch(&merge_msg, '\n');
-	commit_tree(merge_msg.buf, result_tree, parents, result_commit);
+	commit_tree(merge_msg.buf, result_tree, parents, result_commit, NULL);
 	strbuf_addf(&buf, "Merge made by %s.", wt_strategy);
 	finish(result_commit, buf.buf);
 	strbuf_release(&buf);
diff --git a/builtin.h b/builtin.h
index e67cb20..8893b3c 100644
--- a/builtin.h
+++ b/builtin.h
@@ -17,7 +17,8 @@ extern int read_line_with_nul(char *buf, int size, FILE *file);
 extern int fmt_merge_msg(int merge_summary, struct strbuf *in,
 	struct strbuf *out);
 extern int commit_tree(const char *msg, unsigned char *tree,
-		struct commit_list *parents, unsigned char *ret);
+		struct commit_list *parents, unsigned char *ret,
+		const char *author);
 extern int check_pager_config(const char *cmd);
 
 extern int cmd_add(int argc, const char **argv, const char *prefix);
-- 
1.6.0.1
