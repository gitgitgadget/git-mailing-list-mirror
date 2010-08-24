From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 26/32] Add upload-narrow-base command
Date: Wed, 25 Aug 2010 08:20:16 +1000
Message-ID: <1282688422-7738-27-git-send-email-pclouds@gmail.com>
References: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 25 00:24:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo1uS-00030j-2H
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 00:24:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756153Ab0HXWXt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Aug 2010 18:23:49 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:39216 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755438Ab0HXWXr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 18:23:47 -0400
Received: by pzk26 with SMTP id 26so2825440pzk.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 15:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=qcQ386gpo2EsDmFGoPgJ2cDc3ms1Kxte4t14yNbwjrg=;
        b=MTulYQ5Y3kaQINdDRi7yRe1Q303orWXHrHoutiGhYYb+uxvQGF76ggu1dhvW2FHiKe
         c0OKOeN5fctzIvWYeYXXnA1TPDdkTzrZnyHf+0z0dFA94qSlhEHmK1T8LViackSqdo2t
         s5I+5wVKnkNThIPY1eZwgC5MmRD6KC4pmcnL8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=r1i6Vsu++z23/WolGPbBrC7hD5rNGR4GvmdrPOp7JKMtUCtIjPCZoksmK0CQB2teeP
         6kjzbDZME7AHHyabyV0DiXyyybHb82Nn3lIGWTtNV83HWpedonK7F1wOO/4YKd/WQdlg
         TEgZJ8hpw4exQe4oPLcr5tpkrUeExCRdM/tD0=
Received: by 10.142.245.4 with SMTP id s4mr6172881wfh.202.1282688626799;
        Tue, 24 Aug 2010 15:23:46 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id 33sm642508wfg.9.2010.08.24.15.23.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Aug 2010 15:23:45 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Wed, 25 Aug 2010 08:23:39 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154371>

A narrow repo only has enough trees within a given subtree. That would
mean even a trivial three-way merge is impossible because it needs
full tree walk.

On the other hand, doing merge remotely is non-sense because conflicts
can happen, and there would be no index on remote side for people to
inspect/resolve conflicts. Such a merge in narrow repo would be
splitted into two phases: 3-way trivial merge for everything outside
narrow tree, and real merge within narrow tree.

The first phase is done in server by this command. Given two commits,
it will do 3-way merge and return result trees of the merge (no blob
should be created because this is trivial merge). No new objects will
be stored in server after this operation.

=46or local repo, parent trees of narrow tree should be enough for
join_narrow_tree() to do its job. But because remote side does not
store any result objects, in order to push a merge, we would need to
send all necessary trees that the remote side does not have.

=46or this reason, upload-narrow-base would return a pack of all new
trees (those that are not in either merge parents). It is expected
that git client would push all these trees back to server when it does
a push.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Makefile                     |    1 +
 builtin.h                    |    1 +
 builtin/upload-narrow-base.c |  215 ++++++++++++++++++++++++++++++++++=
++++++++
 git.c                        |    1 +
 4 files changed, 218 insertions(+), 0 deletions(-)
 create mode 100644 builtin/upload-narrow-base.c

diff --git a/Makefile b/Makefile
index 54c435e..7b33a0e 100644
--- a/Makefile
+++ b/Makefile
@@ -737,6 +737,7 @@ BUILTIN_OBJS +=3D builtin/update-index.o
 BUILTIN_OBJS +=3D builtin/update-ref.o
 BUILTIN_OBJS +=3D builtin/update-server-info.o
 BUILTIN_OBJS +=3D builtin/upload-archive.o
+BUILTIN_OBJS +=3D builtin/upload-narrow-base.o
 BUILTIN_OBJS +=3D builtin/var.o
 BUILTIN_OBJS +=3D builtin/verify-pack.o
 BUILTIN_OBJS +=3D builtin/verify-tag.o
diff --git a/builtin.h b/builtin.h
index ed6ee26..0383328 100644
--- a/builtin.h
+++ b/builtin.h
@@ -131,6 +131,7 @@ extern int cmd_update_index(int argc, const char **=
argv, const char *prefix);
 extern int cmd_update_ref(int argc, const char **argv, const char *pre=
fix);
 extern int cmd_update_server_info(int argc, const char **argv, const c=
har *prefix);
 extern int cmd_upload_archive(int argc, const char **argv, const char =
*prefix);
+extern int cmd_upload_narrow_base(int argc, const char **argv, const c=
har *prefix);
 extern int cmd_upload_tar(int argc, const char **argv, const char *pre=
fix);
 extern int cmd_var(int argc, const char **argv, const char *prefix);
 extern int cmd_verify_tag(int argc, const char **argv, const char *pre=
fix);
diff --git a/builtin/upload-narrow-base.c b/builtin/upload-narrow-base.=
c
new file mode 100644
index 0000000..f31f03e
--- /dev/null
+++ b/builtin/upload-narrow-base.c
@@ -0,0 +1,215 @@
+#include "cache.h"
+#include "builtin.h"
+#include "cache-tree.h"
+#include "diff.h"
+#include "diffcore.h"
+#include "commit.h"
+#include "revision.h"
+#include "unpack-trees.h"
+#include "pkt-line.h"
+#include "pack.h"
+#include "transport.h"
+#include "sideband.h"
+
+const char *narrow_prefix;
+
+#define PARENT1		(1u<<16)
+#define PARENT2		(1u<<17)
+
+static void write_object(struct tree *t,
+			 const char *base,
+			 struct simple_pack *pack)
+{
+	struct name_entry entry;
+	struct tree *subtree;
+	struct tree_desc desc;
+	enum object_type type;
+	unsigned long size;
+	int len =3D 0;
+	void *buffer;
+	char *path =3D xmalloc(PATH_MAX);
+
+	if (base) {
+		len =3D strlen(base);
+		memcpy(path, base, len);
+		path[len++] =3D '/';
+	}
+
+	buffer =3D read_sha1_file(t->object.sha1, &type, &size);
+	if (!buffer || type !=3D OBJ_TREE)
+		die("%s is not a tree", sha1_to_hex(t->object.sha1));
+
+	init_tree_desc(&desc, buffer, size);
+	while (tree_entry(&desc, &entry)) {
+		if (!S_ISDIR(entry.mode))
+			continue;
+
+		subtree =3D lookup_tree(entry.sha1);
+		strcpy(path+len, entry.path);
+		if (!strcmp(path, narrow_prefix))
+			;
+		else if (!prefixcmp(narrow_prefix, path) && /* subtree predecessor *=
/
+			 narrow_prefix[strlen(path)] =3D=3D '/')
+			;
+		else if (!(subtree->object.flags & (PARENT1 | PARENT2))) {
+			subtree->object.flags |=3D TMP_MARK; /* non recursive */
+			write_object_to_pack(pack, entry.sha1, subtree->buffer,
+					     subtree->size, OBJ_TREE);
+		}
+
+		write_object(subtree, path, pack);
+	}
+	free(path);
+	free(buffer);
+}
+
+static int read_tree_trivial(struct tree *trees[3])
+{
+	int i;
+	struct tree_desc t[3];
+	struct unpack_trees_options opts;
+
+	memset(&opts, 0, sizeof(opts));
+	opts.head_idx =3D 2;
+	opts.src_index =3D &the_index;
+	opts.dst_index =3D &the_index;
+	opts.merge =3D 1;
+	opts.fn =3D threeway_merge;
+	cache_tree_free(&active_cache_tree);
+	for (i =3D 0; i < 3; i++) {
+		parse_tree(trees[i]);
+		init_tree_desc(t+i, trees[i]->buffer, trees[i]->size);
+	}
+	if (unpack_trees(3, t, &opts))
+		return -1;
+	return 0;
+}
+
+static int create_tree_object(const void *buf, unsigned long len,
+			      const char *type, unsigned char *sha1)
+{
+	struct tree *t;
+	if (type !=3D tree_type)
+		die("Invalid type %s", type);
+	hash_sha1_file(buf, len, tree_type, sha1);
+	t =3D lookup_tree(sha1);
+	if (!t->object.parsed) {
+		t->buffer =3D xmalloc(len);
+		memcpy(t->buffer, buf, len);
+		t->size =3D len;
+		t->object.parsed =3D 1;
+	}
+	return 0;
+}
+
+int cmd_upload_narrow_base(int argc, const char **argv, const char *pr=
efix)
+{
+	char buf[LARGE_PACKET_MAX];
+	unsigned char sha1[2][20];
+	struct tree *t[3];
+	struct commit_list *common;
+	struct simple_pack pack;
+	int i, len;
+
+	strcpy(buf, argv[1]); /* enter-repo smudges its argument */
+
+	if (!enter_repo(buf, 0))
+		die("'%s' does not appear to be a git repository", buf);
+
+	len =3D packet_read_line(0, buf, sizeof(buf));
+	if (!len)
+		die("narrow-merge: narrow-tree missing");
+	if (!prefixcmp(buf, "narrow-tree ")) {
+		narrow_prefix =3D xstrdup(buf+12);
+		len =3D strlen(narrow_prefix);
+		if (!len)
+			die("narrow-merge: empty narrow-tree");
+		if (narrow_prefix[len-1] =3D=3D '/')
+			die("narrow-merge: trailing slash not allowed %s", narrow_prefix);
+	}
+	else
+		die("narrow-merge: invalid narrow-tree %s", buf);
+
+	for (i =3D 0; i < 2; i++) {
+		len =3D packet_read_line(0, buf, sizeof(buf));
+		if (!len)
+			die("narrow-merge: parent missing");
+		if (!prefixcmp(buf, "parent ")) {
+			if (get_sha1_hex(buf+7, sha1[i]))
+				die("narrow-merge: invalid SHA1 %s", buf);
+			if (!lookup_commit_reference(sha1[i]))
+				return 1;
+		}
+		else
+			die("narrow-merge: invalid parent %s", buf);
+	}
+	len =3D packet_read_line(0, buf, sizeof(buf));
+	if (len)
+		die("narrow-merge: expected a flush");
+
+	common =3D get_merge_bases(lookup_commit(sha1[0]),
+				 lookup_commit(sha1[1]),
+				 1);
+	if (!common || common->next)
+		die("narrow-merge: no common or too many common found, can't merge")=
;
+
+	t[0] =3D common->item->tree;
+	t[1] =3D lookup_commit(sha1[0])->tree;
+	t[2] =3D lookup_commit(sha1[1])->tree;
+
+	/* Three way merge to index */
+	discard_index(&the_index);
+	if (read_tree_trivial(t))
+		die("narrow-merge: non trivial merge");
+
+	/* Make sure merge is good (no conflicts outside subtree) */
+	len =3D strlen(narrow_prefix);
+	for (i =3D 0; i < the_index.cache_nr; i++) {
+		struct cache_entry *ce =3D the_index.cache[i];
+
+		/*
+		 * No staged entries within subtree, prefer stage 1:
+		 * (the goal is no staged entries, the content is
+		 * not really important as subtree client must do
+		 * a real merge within subtree)
+		 * stage 0: move on
+		 * stage 1: turn it to stage 0,
+		 * stage 2: mark CE_REMOVE
+		 */
+		if (!prefixcmp(ce->name, narrow_prefix) &&
+		    ce->name[len] =3D=3D '/') {
+			switch (ce_stage(ce)) {
+			case 1: ce->ce_flags &=3D ~CE_STAGEMASK; break;
+			case 2: ce->ce_flags |=3D CE_REMOVE; break;
+			}
+			continue;
+		}
+		if (ce_stage(ce))
+			die("git upload-pack: unmerged entry %s", ce->name);
+	}
+
+	/* Generate trees in memory */
+	the_index.cache_tree =3D cache_tree();
+	if (cache_tree_update_fn(the_index.cache_tree,
+				 the_index.cache,
+				 the_index.cache_nr,
+				 create_tree_object,
+				 0, 0))
+		die("narrow-merge: error generating trees");
+
+	/* Everything is OK. Send root SHA-1 */
+	packet_write(1, "ACK %s\n", sha1_to_hex(the_index.cache_tree->sha1));
+
+	/* Traverse and send only missing trees */
+	memset(&pack, 0, sizeof(pack));
+	pack.fd =3D 1;
+	create_pack(&pack);
+
+	t[0] =3D lookup_tree(the_index.cache_tree->sha1);
+	set_tree_marks(t[1], PARENT1);
+	set_tree_marks(t[2], PARENT2);
+	write_object(t[0], NULL, &pack);
+
+	close_pack(&pack);
+	return 0;
+}
diff --git a/git.c b/git.c
index f37028b..edb379f 100644
--- a/git.c
+++ b/git.c
@@ -392,6 +392,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "update-ref", cmd_update_ref, RUN_SETUP },
 		{ "update-server-info", cmd_update_server_info, RUN_SETUP },
 		{ "upload-archive", cmd_upload_archive },
+		{ "upload-narrow-base", cmd_upload_narrow_base },
 		{ "var", cmd_var },
 		{ "verify-tag", cmd_verify_tag, RUN_SETUP },
 		{ "version", cmd_version },
--=20
1.7.1.rc1.69.g24c2f7
