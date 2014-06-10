From: Jeff King <peff@peff.net>
Subject: [PATCH 01/17] commit_tree: take a pointer/len pair rather than a
 const strbuf
Date: Tue, 10 Jun 2014 17:36:52 -0400
Message-ID: <20140610213652.GA19147@sigill.intra.peff.net>
References: <20140610213509.GA26979@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 10 23:37:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuTj0-00025D-9L
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 23:36:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753469AbaFJVgy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 17:36:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:41348 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752302AbaFJVgx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 17:36:53 -0400
Received: (qmail 19255 invoked by uid 102); 10 Jun 2014 21:36:53 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 10 Jun 2014 16:36:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jun 2014 17:36:52 -0400
Content-Disposition: inline
In-Reply-To: <20140610213509.GA26979@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251244>

While strbufs are pretty common throughout our code, it is
more flexible for functions to take a pointer/len pair than
a strbuf. It's easy to turn a strbuf into such a pair (by
dereferencing its members), but less easy to go the other
way (you can strbuf_attach, but that has implications about
memory ownership).

This patch teaches commit_tree (and its associated callers
and sub-functions) to take such a pair for the commit
message rather than a strbuf.  This makes passing the buffer
around slightly more verbose, but means we can get rid of
some dangerous strbuf_attach calls in the next patch.

Signed-off-by: Jeff King <peff@peff.net>
---
Sadly, the diffstat is not +x/-x. Rewrapping the longer lines
gave us a few extra lines.

 builtin/commit-tree.c |  4 ++--
 builtin/commit.c      |  4 ++--
 builtin/merge.c       |  8 ++++----
 commit.c              | 12 +++++++-----
 commit.h              |  6 ++++--
 notes-cache.c         |  2 +-
 notes-merge.c         |  6 ++++--
 notes-utils.c         |  7 ++++---
 notes-utils.h         |  2 +-
 9 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index 987a4c3..8a66c74 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -123,8 +123,8 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 			die_errno("git commit-tree: failed to read");
 	}
 
-	if (commit_tree(&buffer, tree_sha1, parents, commit_sha1,
-			NULL, sign_commit)) {
+	if (commit_tree(buffer.buf, buffer.len, tree_sha1, parents,
+			commit_sha1, NULL, sign_commit)) {
 		strbuf_release(&buffer);
 		return 1;
 	}
diff --git a/builtin/commit.c b/builtin/commit.c
index 99c2044..ef300f1 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1731,8 +1731,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		append_merge_tag_headers(parents, &tail);
 	}
 
-	if (commit_tree_extended(&sb, active_cache_tree->sha1, parents, sha1,
-				 author_ident.buf, sign_commit, extra)) {
+	if (commit_tree_extended(sb.buf, sb.len, active_cache_tree->sha1,
+			 parents, sha1, author_ident.buf, sign_commit, extra)) {
 		rollback_index_files();
 		die(_("failed to write commit object"));
 	}
diff --git a/builtin/merge.c b/builtin/merge.c
index 428ca24..b49c310 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -852,8 +852,8 @@ static int merge_trivial(struct commit *head, struct commit_list *remoteheads)
 	parent->next->item = remoteheads->item;
 	parent->next->next = NULL;
 	prepare_to_commit(remoteheads);
-	if (commit_tree(&merge_msg, result_tree, parent, result_commit, NULL,
-			sign_commit))
+	if (commit_tree(merge_msg.buf, merge_msg.len, result_tree, parent,
+			result_commit, NULL, sign_commit))
 		die(_("failed to write commit object"));
 	finish(head, remoteheads, result_commit, "In-index merge");
 	drop_save();
@@ -877,8 +877,8 @@ static int finish_automerge(struct commit *head,
 		commit_list_insert(head, &parents);
 	strbuf_addch(&merge_msg, '\n');
 	prepare_to_commit(remoteheads);
-	if (commit_tree(&merge_msg, result_tree, parents, result_commit,
-			NULL, sign_commit))
+	if (commit_tree(merge_msg.buf, merge_msg.len, result_tree, parents,
+			result_commit, NULL, sign_commit))
 		die(_("failed to write commit object"));
 	strbuf_addf(&buf, "Merge made by the '%s' strategy.", wt_strategy);
 	finish(head, remoteheads, result_commit, buf.buf);
diff --git a/commit.c b/commit.c
index f479331..bd3d5af 100644
--- a/commit.c
+++ b/commit.c
@@ -1344,7 +1344,8 @@ void free_commit_extra_headers(struct commit_extra_header *extra)
 	}
 }
 
-int commit_tree(const struct strbuf *msg, const unsigned char *tree,
+int commit_tree(const char *msg, size_t msg_len,
+		const unsigned char *tree,
 		struct commit_list *parents, unsigned char *ret,
 		const char *author, const char *sign_commit)
 {
@@ -1352,7 +1353,7 @@ int commit_tree(const struct strbuf *msg, const unsigned char *tree,
 	int result;
 
 	append_merge_tag_headers(parents, &tail);
-	result = commit_tree_extended(msg, tree, parents, ret,
+	result = commit_tree_extended(msg, msg_len, tree, parents, ret,
 				      author, sign_commit, extra);
 	free_commit_extra_headers(extra);
 	return result;
@@ -1473,7 +1474,8 @@ static const char commit_utf8_warn[] =
 "You may want to amend it after fixing the message, or set the config\n"
 "variable i18n.commitencoding to the encoding your project uses.\n";
 
-int commit_tree_extended(const struct strbuf *msg, const unsigned char *tree,
+int commit_tree_extended(const char *msg, size_t msg_len,
+			 const unsigned char *tree,
 			 struct commit_list *parents, unsigned char *ret,
 			 const char *author, const char *sign_commit,
 			 struct commit_extra_header *extra)
@@ -1484,7 +1486,7 @@ int commit_tree_extended(const struct strbuf *msg, const unsigned char *tree,
 
 	assert_sha1_type(tree, OBJ_TREE);
 
-	if (memchr(msg->buf, '\0', msg->len))
+	if (memchr(msg, '\0', msg_len))
 		return error("a NUL byte in commit log message not allowed.");
 
 	/* Not having i18n.commitencoding is the same as having utf-8 */
@@ -1523,7 +1525,7 @@ int commit_tree_extended(const struct strbuf *msg, const unsigned char *tree,
 	strbuf_addch(&buffer, '\n');
 
 	/* And add the comment */
-	strbuf_addbuf(&buffer, msg);
+	strbuf_add(&buffer, msg, msg_len);
 
 	/* And check the encoding */
 	if (encoding_is_utf8 && !verify_utf8(&buffer))
diff --git a/commit.h b/commit.h
index a9f177b..1cb55ae 100644
--- a/commit.h
+++ b/commit.h
@@ -261,11 +261,13 @@ struct commit_extra_header {
 extern void append_merge_tag_headers(struct commit_list *parents,
 				     struct commit_extra_header ***tail);
 
-extern int commit_tree(const struct strbuf *msg, const unsigned char *tree,
+extern int commit_tree(const char *msg, size_t msg_len,
+		       const unsigned char *tree,
 		       struct commit_list *parents, unsigned char *ret,
 		       const char *author, const char *sign_commit);
 
-extern int commit_tree_extended(const struct strbuf *msg, const unsigned char *tree,
+extern int commit_tree_extended(const char *msg, size_t msg_len,
+				const unsigned char *tree,
 				struct commit_list *parents, unsigned char *ret,
 				const char *author, const char *sign_commit,
 				struct commit_extra_header *);
diff --git a/notes-cache.c b/notes-cache.c
index 97dfd63..4ad0799 100644
--- a/notes-cache.c
+++ b/notes-cache.c
@@ -59,7 +59,7 @@ int notes_cache_write(struct notes_cache *c)
 		return -1;
 	strbuf_attach(&msg, c->validity,
 		      strlen(c->validity), strlen(c->validity) + 1);
-	if (commit_tree(&msg, tree_sha1, NULL, commit_sha1, NULL, NULL) < 0)
+	if (commit_tree(msg.buf, msg.len, tree_sha1, NULL, commit_sha1, NULL, NULL) < 0)
 		return -1;
 	if (update_ref("update notes cache", c->tree.ref, commit_sha1, NULL,
 		       0, UPDATE_REFS_QUIET_ON_ERR) < 0)
diff --git a/notes-merge.c b/notes-merge.c
index 94a1a8a..9d94210 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -644,7 +644,8 @@ int notes_merge(struct notes_merge_options *o,
 		struct commit_list *parents = NULL;
 		commit_list_insert(remote, &parents); /* LIFO order */
 		commit_list_insert(local, &parents);
-		create_notes_commit(local_tree, parents, &o->commit_msg,
+		create_notes_commit(local_tree, parents,
+				    o->commit_msg.buf, o->commit_msg.len,
 				    result_sha1);
 	}
 
@@ -720,7 +721,8 @@ int notes_merge_commit(struct notes_merge_options *o,
 	}
 
 	strbuf_attach(&sb_msg, msg, strlen(msg), strlen(msg) + 1);
-	create_notes_commit(partial_tree, partial_commit->parents, &sb_msg,
+	create_notes_commit(partial_tree, partial_commit->parents,
+			    sb_msg.buf, sb_msg.len,
 			    result_sha1);
 	if (o->verbosity >= 4)
 		printf("Finalized notes merge commit: %s\n",
diff --git a/notes-utils.c b/notes-utils.c
index a0b1d7b..b64dc1b 100644
--- a/notes-utils.c
+++ b/notes-utils.c
@@ -4,7 +4,8 @@
 #include "notes-utils.h"
 
 void create_notes_commit(struct notes_tree *t, struct commit_list *parents,
-			 const struct strbuf *msg, unsigned char *result_sha1)
+			 const char *msg, size_t msg_len,
+			 unsigned char *result_sha1)
 {
 	unsigned char tree_sha1[20];
 
@@ -25,7 +26,7 @@ void create_notes_commit(struct notes_tree *t, struct commit_list *parents,
 		/* else: t->ref points to nothing, assume root/orphan commit */
 	}
 
-	if (commit_tree(msg, tree_sha1, parents, result_sha1, NULL, NULL))
+	if (commit_tree(msg, msg_len, tree_sha1, parents, result_sha1, NULL, NULL))
 		die("Failed to commit notes tree to database");
 }
 
@@ -46,7 +47,7 @@ void commit_notes(struct notes_tree *t, const char *msg)
 	if (buf.buf[buf.len - 1] != '\n')
 		strbuf_addch(&buf, '\n'); /* Make sure msg ends with newline */
 
-	create_notes_commit(t, NULL, &buf, commit_sha1);
+	create_notes_commit(t, NULL, buf.buf, buf.len, commit_sha1);
 	strbuf_insert(&buf, 0, "notes: ", 7); /* commit message starts at index 7 */
 	update_ref(buf.buf, t->ref, commit_sha1, NULL, 0,
 		   UPDATE_REFS_DIE_ON_ERR);
diff --git a/notes-utils.h b/notes-utils.h
index 564e30c..890ddb3 100644
--- a/notes-utils.h
+++ b/notes-utils.h
@@ -15,7 +15,7 @@
  * The resulting commit SHA1 is stored in result_sha1.
  */
 void create_notes_commit(struct notes_tree *t, struct commit_list *parents,
-			 const struct strbuf *msg, unsigned char *result_sha1);
+			 const char *msg, size_t msg_len, unsigned char *result_sha1);
 
 void commit_notes(struct notes_tree *t, const char *msg);
 
-- 
2.0.0.729.g520999f
