From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/2] reset: support "--mixed --intent-to-add" mode
Date: Tue,  4 Feb 2014 09:20:09 +0700
Message-ID: <1391480409-25727-2-git-send-email-pclouds@gmail.com>
References: <CACsJy8BXGZ+1Oqrpcky5JPCtZRwvxmxhXGfuEqY9Ct4Pt8FmJg@mail.gmail.com>
 <1391480409-25727-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 04 03:20:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAVcm-0001tG-Og
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 03:20:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753966AbaBDCUZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Feb 2014 21:20:25 -0500
Received: from mail-pa0-f42.google.com ([209.85.220.42]:42243 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753686AbaBDCUZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 21:20:25 -0500
Received: by mail-pa0-f42.google.com with SMTP id kl14so7919080pab.1
        for <git@vger.kernel.org>; Mon, 03 Feb 2014 18:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=/dxOpmSUZguFEGPozuhY+L0jsrno04pmOonIZCqNHAE=;
        b=QXXNDVchuJT9QOpts/FhcO9HqBE0nYuu+ZTJ9KG1J4OlpL+1/D8F/NbOm8GVN5Zov4
         ydMp3gE5RBVtQ3KIFyxfuuPF6yfGON8YiIWuSGL5bvl/ORhdIwDEWyZaweVZoSxzwqqB
         yxpMfmQySU1JOGhmq103g1pqTZKMzXe7Bv4iJE6IKS8cnFz3IG+sIv5loEs1I4ZPCXVQ
         pdSNHtyBfeWAA8kZAu/K6uaL7z0IgkImvUuqWqSAijZIbSyOV/bvuELkMVIEIrQaMHH7
         5jGkJ0vDpjxWH68Xz2UNvQf8j2ihUJZNd91N0cduJdSOIUwnX+fOjSQY7h30Tq28nWpj
         l7wQ==
X-Received: by 10.66.11.202 with SMTP id s10mr41417557pab.86.1391480424478;
        Mon, 03 Feb 2014 18:20:24 -0800 (PST)
Received: from lanh ([115.73.225.58])
        by mx.google.com with ESMTPSA id qf7sm158464860pac.14.2014.02.03.18.20.21
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 03 Feb 2014 18:20:23 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 04 Feb 2014 09:20:22 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1391480409-25727-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241507>

When --mixed is used, entries could be removed from index if the
target ref does not have them. When "reset" is used in preparation for
commit spliting (in a dirty worktree), it could be hard to track what
files to be added back. The new option --intent-to-add simplifies it
by marking all removed files intent-to-add.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-reset.txt |  5 ++++-
 builtin/reset.c             | 19 +++++++++++++++++--
 cache.h                     |  1 +
 read-cache.c                |  9 +++++++++
 t/t7102-reset.sh            |  9 +++++++++
 5 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index f445cb3..a077ba0 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 [verse]
 'git reset' [-q] [<tree-ish>] [--] <paths>...
 'git reset' (--patch | -p) [<tree-ish>] [--] [<paths>...]
-'git reset' [--soft | --mixed | --hard | --merge | --keep] [-q] [<comm=
it>]
+'git reset' [--soft | --mixed [-N] | --hard | --merge | --keep] [-q] [=
<commit>]
=20
 DESCRIPTION
 -----------
@@ -60,6 +60,9 @@ section of linkgit:git-add[1] to learn how to operate=
 the `--patch` mode.
 	Resets the index but not the working tree (i.e., the changed files
 	are preserved but not marked for commit) and reports what has not
 	been updated. This is the default action.
++
+If `-N` is specified, removed paths are marked as intent-to-add (see
+linkgit:git-add[1]).
=20
 --hard::
 	Resets the index and working tree. Any changes to tracked files in th=
e
diff --git a/builtin/reset.c b/builtin/reset.c
index 6004803..f34eab4 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -116,6 +116,7 @@ static void update_index_from_diff(struct diff_queu=
e_struct *q,
 		struct diff_options *opt, void *data)
 {
 	int i;
+	int *intent_to_add =3D data;
=20
 	for (i =3D 0; i < q->nr; i++) {
 		struct diff_filespec *one =3D q->queue[i]->one;
@@ -128,13 +129,20 @@ static void update_index_from_diff(struct diff_qu=
eue_struct *q,
 				    one->path);
 			add_cache_entry(ce, ADD_CACHE_OK_TO_ADD |
 				ADD_CACHE_OK_TO_REPLACE);
+		} else if (*intent_to_add) {
+			int pos =3D cache_name_pos(one->path, strlen(one->path));
+			if (pos < 0)
+				die(_("%s does not exist in index"),
+				    one->path);
+			set_intent_to_add(&the_index, active_cache[pos]);
 		} else
 			remove_file_from_cache(one->path);
 	}
 }
=20
 static int read_from_tree(const struct pathspec *pathspec,
-			  unsigned char *tree_sha1)
+			  unsigned char *tree_sha1,
+			  int intent_to_add)
 {
 	struct diff_options opt;
=20
@@ -142,6 +150,7 @@ static int read_from_tree(const struct pathspec *pa=
thspec,
 	copy_pathspec(&opt.pathspec, pathspec);
 	opt.output_format =3D DIFF_FORMAT_CALLBACK;
 	opt.format_callback =3D update_index_from_diff;
+	opt.format_callback_data =3D &intent_to_add;
=20
 	if (do_diff_cache(tree_sha1, &opt))
 		return 1;
@@ -258,6 +267,7 @@ int cmd_reset(int argc, const char **argv, const ch=
ar *prefix)
 	const char *rev;
 	unsigned char sha1[20];
 	struct pathspec pathspec;
+	int intent_to_add =3D 0;
 	const struct option options[] =3D {
 		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
 		OPT_SET_INT(0, "mixed", &reset_type,
@@ -270,6 +280,8 @@ int cmd_reset(int argc, const char **argv, const ch=
ar *prefix)
 		OPT_SET_INT(0, "keep", &reset_type,
 				N_("reset HEAD but keep local changes"), KEEP),
 		OPT_BOOL('p', "patch", &patch_mode, N_("select hunks interactively")=
),
+		OPT_BOOL('N', "intent-to-add", &intent_to_add,
+				N_("record only the fact that removed paths will be added later"))=
,
 		OPT_END()
 	};
=20
@@ -327,6 +339,9 @@ int cmd_reset(int argc, const char **argv, const ch=
ar *prefix)
 		die(_("%s reset is not allowed in a bare repository"),
 		    _(reset_type_names[reset_type]));
=20
+	if (intent_to_add && reset_type !=3D MIXED)
+		die(_("-N can only be used with --mixed"));
+
 	/* Soft reset does not touch the index file nor the working tree
 	 * at all, but requires them in a good order.  Other resets reset
 	 * the index file to the tree object we are switching to. */
@@ -338,7 +353,7 @@ int cmd_reset(int argc, const char **argv, const ch=
ar *prefix)
 		int newfd =3D hold_locked_index(lock, 1);
 		if (reset_type =3D=3D MIXED) {
 			int flags =3D quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN;
-			if (read_from_tree(&pathspec, sha1))
+			if (read_from_tree(&pathspec, sha1, intent_to_add))
 				return 1;
 			refresh_index(&the_index, flags, NULL, NULL,
 				      _("Unstaged changes after reset:"));
diff --git a/cache.h b/cache.h
index dc040fb..9d5e09e 100644
--- a/cache.h
+++ b/cache.h
@@ -479,6 +479,7 @@ extern void rename_index_entry_at(struct index_stat=
e *, int pos, const char *new
 extern int remove_index_entry_at(struct index_state *, int pos);
 extern void remove_marked_cache_entries(struct index_state *istate);
 extern int remove_file_from_index(struct index_state *, const char *pa=
th);
+extern int set_intent_to_add(struct index_state *, struct cache_entry =
*);
 #define ADD_CACHE_VERBOSE 1
 #define ADD_CACHE_PRETEND 2
 #define ADD_CACHE_IGNORE_ERRORS	4
diff --git a/read-cache.c b/read-cache.c
index 33dd676..dc160a3 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -587,6 +587,15 @@ static void record_intent_to_add(struct cache_entr=
y *ce)
 	hashcpy(ce->sha1, sha1);
 }
=20
+int set_intent_to_add(struct index_state *istate, struct cache_entry *=
ce)
+{
+	record_intent_to_add(ce);
+	ce->ce_flags |=3D CE_INTENT_TO_ADD;
+	cache_tree_invalidate_path(istate->cache_tree, ce->name);
+	istate->cache_changed =3D 1;
+	return 0;
+}
+
 int add_to_index(struct index_state *istate, const char *path, struct =
stat *st, int flags)
 {
 	int size, namelen, was_same;
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index 8d4b50d..642920a 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -535,4 +535,13 @@ test_expect_success 'reset with paths accepts tree=
' '
 	git diff HEAD --exit-code
 '
=20
+test_expect_success 'reset -N keeps removed files as intent-to-add' '
+	echo new-file >new-file &&
+	git add new-file &&
+	git reset -N HEAD &&
+	git diff --name-only >actual &&
+	echo new-file >expect &&
+	test_cmp expect actual
+'
+
 test_done
--=20
1.8.5.2.240.g8478abd
