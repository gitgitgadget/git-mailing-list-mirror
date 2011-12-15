From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 2/3] Convert commit_tree() to take strbuf as message
Date: Thu, 15 Dec 2011 20:47:22 +0700
Message-ID: <1323956843-5326-2-git-send-email-pclouds@gmail.com>
References: <1323871699-8839-2-git-send-email-pclouds@gmail.com>
 <1323956843-5326-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Miles Bader <miles@gnu.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 15 14:47:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbBem-0002rv-9p
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 14:47:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758824Ab1LONrZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Dec 2011 08:47:25 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33385 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758718Ab1LONrX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2011 08:47:23 -0500
Received: by mail-iy0-f174.google.com with SMTP id h11so2819700iae.19
        for <git@vger.kernel.org>; Thu, 15 Dec 2011 05:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=8Fjan+mcyEb65t6KM6Ifvje76bxveY1ptX8+a0AAOKA=;
        b=Mx+g1qhSN5MMEta6/V8ND6FjSK39JhqJd43bSCVSWy9cI3UNSYiC6f5a7HK9aDCqmn
         zKk7UehPuo9/h6Shqmlj1hiDvjPUSZBaCxUkkCiHmNGHAVkudC+qNOv+VBb493TJXMlW
         xf0Z+wzmyGDLOREc7VY2rfuCY0k9/DAgPyEhU=
Received: by 10.43.49.66 with SMTP id uz2mr2547900icb.9.1323956843577;
        Thu, 15 Dec 2011 05:47:23 -0800 (PST)
Received: from tre ([115.74.57.162])
        by mx.google.com with ESMTPS id h9sm21267237ibh.11.2011.12.15.05.47.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 15 Dec 2011 05:47:22 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Thu, 15 Dec 2011 20:47:33 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1323956843-5326-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187208>

Because strbuf provides message length, we can create commits that
include NULs.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/commit-tree.c |    2 +-
 builtin/commit.c      |    2 +-
 builtin/merge.c       |    4 ++--
 builtin/notes.c       |    4 ++--
 commit.c              |    4 ++--
 commit.h              |    2 +-
 notes-cache.c         |    5 ++++-
 notes-merge.c         |   10 ++++++----
 notes-merge.h         |    2 +-
 9 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index d083795..0895861 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -56,7 +56,7 @@ int cmd_commit_tree(int argc, const char **argv, cons=
t char *prefix)
 	if (strbuf_read(&buffer, 0, 0) < 0)
 		die_errno("git commit-tree: failed to read");
=20
-	if (commit_tree(buffer.buf, tree_sha1, parents, commit_sha1, NULL)) {
+	if (commit_tree(&buffer, tree_sha1, parents, commit_sha1, NULL)) {
 		strbuf_release(&buffer);
 		return 1;
 	}
diff --git a/builtin/commit.c b/builtin/commit.c
index 8f2bebe..849151e 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1483,7 +1483,7 @@ int cmd_commit(int argc, const char **argv, const=
 char *prefix)
 		exit(1);
 	}
=20
-	if (commit_tree(sb.buf, active_cache_tree->sha1, parents, sha1,
+	if (commit_tree(&sb, active_cache_tree->sha1, parents, sha1,
 			author_ident.buf)) {
 		rollback_index_files();
 		die(_("failed to write commit object"));
diff --git a/builtin/merge.c b/builtin/merge.c
index 27576c0..e066bf1 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -913,7 +913,7 @@ static int merge_trivial(struct commit *head)
 	parent->next->item =3D remoteheads->item;
 	parent->next->next =3D NULL;
 	prepare_to_commit();
-	if (commit_tree(merge_msg.buf, result_tree, parent, result_commit, NU=
LL))
+	if (commit_tree(&merge_msg, result_tree, parent, result_commit, NULL)=
)
 		die(_("failed to write commit object"));
 	finish(head, result_commit, "In-index merge");
 	drop_save();
@@ -945,7 +945,7 @@ static int finish_automerge(struct commit *head,
 	strbuf_addch(&merge_msg, '\n');
 	prepare_to_commit();
 	free_commit_list(remoteheads);
-	if (commit_tree(merge_msg.buf, result_tree, parents, result_commit, N=
ULL))
+	if (commit_tree(&merge_msg, result_tree, parents, result_commit, NULL=
))
 		die(_("failed to write commit object"));
 	strbuf_addf(&buf, "Merge made by the '%s' strategy.", wt_strategy);
 	finish(head, result_commit, buf.buf);
diff --git a/builtin/notes.c b/builtin/notes.c
index f8e437d..5e32548 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -301,12 +301,12 @@ void commit_notes(struct notes_tree *t, const cha=
r *msg)
 		return; /* don't have to commit an unchanged tree */
=20
 	/* Prepare commit message and reflog message */
-	strbuf_addstr(&buf, "notes: "); /* commit message starts at index 7 *=
/
 	strbuf_addstr(&buf, msg);
 	if (buf.buf[buf.len - 1] !=3D '\n')
 		strbuf_addch(&buf, '\n'); /* Make sure msg ends with newline */
=20
-	create_notes_commit(t, NULL, buf.buf + 7, commit_sha1);
+	create_notes_commit(t, NULL, &buf, commit_sha1);
+	strbuf_insert(&buf, 0, "notes: ", 7); /* commit message starts at ind=
ex 7 */
 	update_ref(buf.buf, t->ref, commit_sha1, NULL, 0, DIE_ON_ERR);
=20
 	strbuf_release(&buf);
diff --git a/commit.c b/commit.c
index 73b7e00..0a214a6 100644
--- a/commit.c
+++ b/commit.c
@@ -845,7 +845,7 @@ static const char commit_utf8_warn[] =3D
 "You may want to amend it after fixing the message, or set the config\=
n"
 "variable i18n.commitencoding to the encoding your project uses.\n";
=20
-int commit_tree(const char *msg, unsigned char *tree,
+int commit_tree(const struct strbuf *msg, unsigned char *tree,
 		struct commit_list *parents, unsigned char *ret,
 		const char *author)
 {
@@ -884,7 +884,7 @@ int commit_tree(const char *msg, unsigned char *tre=
e,
 	strbuf_addch(&buffer, '\n');
=20
 	/* And add the comment */
-	strbuf_addstr(&buffer, msg);
+	strbuf_addbuf(&buffer, msg);
=20
 	/* And check the encoding */
 	if (encoding_is_utf8 && !is_utf8(buffer.buf))
diff --git a/commit.h b/commit.h
index 009b113..5cf46b2 100644
--- a/commit.h
+++ b/commit.h
@@ -181,7 +181,7 @@ static inline int single_parent(struct commit *comm=
it)
=20
 struct commit_list *reduce_heads(struct commit_list *heads);
=20
-extern int commit_tree(const char *msg, unsigned char *tree,
+extern int commit_tree(const struct strbuf *msg, unsigned char *tree,
 		struct commit_list *parents, unsigned char *ret,
 		const char *author);
=20
diff --git a/notes-cache.c b/notes-cache.c
index 4c8984e..bea013e 100644
--- a/notes-cache.c
+++ b/notes-cache.c
@@ -48,6 +48,7 @@ int notes_cache_write(struct notes_cache *c)
 {
 	unsigned char tree_sha1[20];
 	unsigned char commit_sha1[20];
+	struct strbuf msg =3D STRBUF_INIT;
=20
 	if (!c || !c->tree.initialized || !c->tree.ref || !*c->tree.ref)
 		return -1;
@@ -56,7 +57,9 @@ int notes_cache_write(struct notes_cache *c)
=20
 	if (write_notes_tree(&c->tree, tree_sha1))
 		return -1;
-	if (commit_tree(c->validity, tree_sha1, NULL, commit_sha1, NULL) < 0)
+	strbuf_attach(&msg, c->validity,
+		      strlen(c->validity), strlen(c->validity) + 1);
+	if (commit_tree(&msg, tree_sha1, NULL, commit_sha1, NULL) < 0)
 		return -1;
 	if (update_ref("update notes cache", c->tree.ref, commit_sha1, NULL,
 		       0, QUIET_ON_ERR) < 0)
diff --git a/notes-merge.c b/notes-merge.c
index ce10aac..b5a36ac 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -530,7 +530,7 @@ static int merge_from_diffs(struct notes_merge_opti=
ons *o,
 }
=20
 void create_notes_commit(struct notes_tree *t, struct commit_list *par=
ents,
-			 const char *msg, unsigned char *result_sha1)
+			 const struct strbuf *msg, unsigned char *result_sha1)
 {
 	unsigned char tree_sha1[20];
=20
@@ -668,7 +668,7 @@ int notes_merge(struct notes_merge_options *o,
 		struct commit_list *parents =3D NULL;
 		commit_list_insert(remote, &parents); /* LIFO order */
 		commit_list_insert(local, &parents);
-		create_notes_commit(local_tree, parents, o->commit_msg.buf,
+		create_notes_commit(local_tree, parents, &o->commit_msg,
 				    result_sha1);
 	}
=20
@@ -695,7 +695,8 @@ int notes_merge_commit(struct notes_merge_options *=
o,
 	struct dir_struct dir;
 	char *path =3D xstrdup(git_path(NOTES_MERGE_WORKTREE "/"));
 	int path_len =3D strlen(path), i;
-	const char *msg =3D strstr(partial_commit->buffer, "\n\n");
+	char *msg =3D strstr(partial_commit->buffer, "\n\n");
+	struct strbuf sb_msg =3D STRBUF_INIT;
=20
 	if (o->verbosity >=3D 3)
 		printf("Committing notes in notes merge worktree at %.*s\n",
@@ -733,7 +734,8 @@ int notes_merge_commit(struct notes_merge_options *=
o,
 				sha1_to_hex(obj_sha1), sha1_to_hex(blob_sha1));
 	}
=20
-	create_notes_commit(partial_tree, partial_commit->parents, msg,
+	strbuf_attach(&sb_msg, msg, strlen(msg), strlen(msg) + 1);
+	create_notes_commit(partial_tree, partial_commit->parents, &sb_msg,
 			    result_sha1);
 	if (o->verbosity >=3D 4)
 		printf("Finalized notes merge commit: %s\n",
diff --git a/notes-merge.h b/notes-merge.h
index 168a672..0c11b17 100644
--- a/notes-merge.h
+++ b/notes-merge.h
@@ -37,7 +37,7 @@ void init_notes_merge_options(struct notes_merge_opti=
ons *o);
  * The resulting commit SHA1 is stored in result_sha1.
  */
 void create_notes_commit(struct notes_tree *t, struct commit_list *par=
ents,
-			 const char *msg, unsigned char *result_sha1);
+			 const struct strbuf *msg, unsigned char *result_sha1);
=20
 /*
  * Merge notes from o->remote_ref into o->local_ref
--=20
1.7.8.36.g69ee2
