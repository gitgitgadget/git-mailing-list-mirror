From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 13/16] Update commit_tree() interface to take base tree too
Date: Sat, 31 Jul 2010 23:18:22 +0700
Message-ID: <1280593105-22015-14-git-send-email-pclouds@gmail.com>
References: <1280593105-22015-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 01 04:39:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfOSd-000391-3q
	for gcvg-git-2@lo.gmane.org; Sun, 01 Aug 2010 04:39:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755460Ab0HACj3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Jul 2010 22:39:29 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:50084 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753090Ab0HACj2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jul 2010 22:39:28 -0400
Received: by mail-px0-f174.google.com with SMTP id 14so977684pxi.19
        for <git@vger.kernel.org>; Sat, 31 Jul 2010 19:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=LrjgX/7jxKKXBUVCO41GnLLe1+0z91K9hC5S2++NFh0=;
        b=Vi47NsW3Xjl6mmjZKlqbANS37xraIRuz2Ib2nsmQ0i0aTFKt/FSMlZi3NLsPFgUcNF
         CQrkyB61IA0MEqbXaHi3v4lirxY7bwhY3w3uUznGPeLzq6Qp6hNuhYH0l/OC4o6Y0lGT
         6cDxTRlmLGmI2LUobyBGmfJEZO+VIYCer6waQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=PkorP0y+uzIUye2Mu1JnNx8bov/BnSnAqoQK5cHQ7MRVTS6Q1F3X0o35DKnrmDLNDk
         V64vnCiUfZk5bjGQ3lOAIzGpwK1dhLzOAE6OcBIe+II070sKmrFS0BSWg2aCfl7XDfpD
         UQ0hBH4MkLHyPSEi31mB3d2ImWBPsJzp1oWus=
Received: by 10.114.110.2 with SMTP id i2mr4809128wac.193.1280630368140;
        Sat, 31 Jul 2010 19:39:28 -0700 (PDT)
Received: from dektop ([119.12.238.118])
        by mx.google.com with ESMTPS id d38sm7702598wam.20.2010.07.31.19.39.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 31 Jul 2010 19:39:27 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Sat, 31 Jul 2010 23:20:20 +0700
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1280593105-22015-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152360>

In subtree mode, you work on a narrowed trees. You make narrowed
commits. If you want to push upstream, you would need to put your
updated subtree back to the full tree again. Otherwise upstream would
complain you delete all trees but your subtree, not good.

In order to do that, commit_tree() now takes the base tree SHA-1. With
that, it can create upstream-compatible commits. It does not now,
though.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/commit-tree.c |    2 +-
 builtin/commit.c      |    2 +-
 builtin/merge.c       |    4 ++--
 builtin/notes.c       |    2 +-
 commit.c              |    2 +-
 commit.h              |    2 +-
 notes-cache.c         |    2 +-
 7 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index 87f0591..88a6833 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -56,7 +56,7 @@ int cmd_commit_tree(int argc, const char **argv, cons=
t char *prefix)
 	if (strbuf_read(&buffer, 0, 0) < 0)
 		die_errno("git commit-tree: failed to read");
=20
-	if (!commit_tree(buffer.buf, tree_sha1, parents, commit_sha1, NULL)) =
{
+	if (!commit_tree(buffer.buf, tree_sha1, NULL, parents, commit_sha1, N=
ULL)) {
 		printf("%s\n", sha1_to_hex(commit_sha1));
 		return 0;
 	}
diff --git a/builtin/commit.c b/builtin/commit.c
index 2bb30c0..6b4c678 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1350,7 +1350,7 @@ int cmd_commit(int argc, const char **argv, const=
 char *prefix)
 		exit(1);
 	}
=20
-	if (commit_tree(sb.buf, active_cache_tree->sha1, parents, commit_sha1=
,
+	if (commit_tree(sb.buf, active_cache_tree->sha1, NULL, parents, commi=
t_sha1,
 			fmt_ident(author_name, author_email, author_date,
 				IDENT_ERROR_ON_NO_NAME))) {
 		rollback_index_files();
diff --git a/builtin/merge.c b/builtin/merge.c
index 37ce4f5..8745b54 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -779,7 +779,7 @@ static int merge_trivial(void)
 	parent->next =3D xmalloc(sizeof(*parent->next));
 	parent->next->item =3D remoteheads->item;
 	parent->next->next =3D NULL;
-	commit_tree(merge_msg.buf, result_tree, parent, result_commit, NULL);
+	commit_tree(merge_msg.buf, result_tree, NULL, parent, result_commit, =
NULL);
 	finish(result_commit, "In-index merge");
 	drop_save();
 	return 0;
@@ -808,7 +808,7 @@ static int finish_automerge(struct commit_list *com=
mon,
 	}
 	free_commit_list(remoteheads);
 	strbuf_addch(&merge_msg, '\n');
-	commit_tree(merge_msg.buf, result_tree, parents, result_commit, NULL)=
;
+	commit_tree(merge_msg.buf, result_tree, NULL, parents, result_commit,=
 NULL);
 	strbuf_addf(&buf, "Merge made by %s.", wt_strategy);
 	finish(result_commit, buf.buf);
 	strbuf_release(&buf);
diff --git a/builtin/notes.c b/builtin/notes.c
index 190005f..8d574eb 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -303,7 +303,7 @@ int commit_notes(struct notes_tree *t, const char *=
msg)
 		hashclr(prev_commit);
 		parent =3D NULL;
 	}
-	if (commit_tree(buf.buf + 7, tree_sha1, parent, new_commit, NULL))
+	if (commit_tree(buf.buf + 7, tree_sha1, NULL, parent, new_commit, NUL=
L))
 		die("Failed to commit notes tree to database");
=20
 	/* Update notes ref with new commit */
diff --git a/commit.c b/commit.c
index d1e30b2..7121631 100644
--- a/commit.c
+++ b/commit.c
@@ -811,7 +811,7 @@ static const char commit_utf8_warn[] =3D
 "You may want to amend it after fixing the message, or set the config\=
n"
 "variable i18n.commitencoding to the encoding your project uses.\n";
=20
-int commit_tree(const char *msg, unsigned char *tree,
+int commit_tree(const char *msg, unsigned char *tree, unsigned char *b=
ase_tree,
 		struct commit_list *parents, unsigned char *ret,
 		const char *author)
 {
diff --git a/commit.h b/commit.h
index d8c01ea..7c34368 100644
--- a/commit.h
+++ b/commit.h
@@ -166,7 +166,7 @@ static inline int single_parent(struct commit *comm=
it)
=20
 struct commit_list *reduce_heads(struct commit_list *heads);
=20
-extern int commit_tree(const char *msg, unsigned char *tree,
+extern int commit_tree(const char *msg, unsigned char *tree, unsigned =
char *base_tree,
 		struct commit_list *parents, unsigned char *ret,
 		const char *author);
=20
diff --git a/notes-cache.c b/notes-cache.c
index dee6d62..96afb25 100644
--- a/notes-cache.c
+++ b/notes-cache.c
@@ -56,7 +56,7 @@ int notes_cache_write(struct notes_cache *c)
=20
 	if (write_notes_tree(&c->tree, tree_sha1))
 		return -1;
-	if (commit_tree(c->validity, tree_sha1, NULL, commit_sha1, NULL) < 0)
+	if (commit_tree(c->validity, tree_sha1, NULL, NULL, commit_sha1, NULL=
) < 0)
 		return -1;
 	if (update_ref("update notes cache", c->tree.ref, commit_sha1, NULL,
 		       0, QUIET_ON_ERR) < 0)
--=20
1.7.1.rc1.69.g24c2f7
