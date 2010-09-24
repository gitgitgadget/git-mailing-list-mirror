From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: [PATCH v3 3/3] blame,cat-file --textconv: Don't assume mode is ``S_IFREF | 0664''
Date: Fri, 24 Sep 2010 22:24:10 +0400
Message-ID: <dd8686e9a7966ad3bd6c58b000b3959c33aedb02.1285351816.git.kirr@landau.phys.spbu.ru>
References: <cover.1285351816.git.kirr@landau.phys.spbu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	=?UTF-8?q?Cl=C3=A9ment=20Poulain?= 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>,
	Kirill Smelkov <kirr@landau.phys.spbu.ru>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 24 20:23:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzCw3-0003LJ-7W
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 20:23:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382Ab0IXSWu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Sep 2010 14:22:50 -0400
Received: from landau.phys.spbu.ru ([195.19.235.38]:58619 "EHLO
	landau.phys.spbu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932322Ab0IXSWs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 14:22:48 -0400
Received: by landau.phys.spbu.ru (Postfix, from userid 506)
	id 5C100FF723; Fri, 24 Sep 2010 22:22:47 +0400 (MSD)
Received: from kirr by landau.phys.spbu.ru with local (Exim 4.72)
	(envelope-from <kirr@roro3.zxlink>)
	id 1OzCwl-0001UO-VE; Fri, 24 Sep 2010 22:24:35 +0400
X-Mailer: git-send-email 1.7.3.rc2
In-Reply-To: <cover.1285351816.git.kirr@landau.phys.spbu.ru>
In-Reply-To: <cover.1285351816.git.kirr@landau.phys.spbu.ru>
References: <cover.1285351816.git.kirr@landau.phys.spbu.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157033>

Instead get the mode from either worktree, index, .git, or origin
entries when blaming and pass it to textconv_object() as context.

The reason to do it is not to run textconv filters on symlinks.

Cc: Axel Bonnet <axel.bonnet@ensimag.imag.fr>
Cc: Cl=C3=A9ment Poulain <clement.poulain@ensimag.imag.fr>
Cc: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Cc: Jeff King <peff@peff.net>
Signed-off-by: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Reviewed-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
---

v3:

 o Reviewed-by: Matthieu

v2:

 o Thanks to Matthieu and Jeff got a bit more sure I'm not doing stupid=
 things,
   so
 o My XXX were removed, and the patch is no longer an RFC

 builtin.h                    |    2 +-
 builtin/blame.c              |   33 ++++++++++++++++++++++-----------
 builtin/cat-file.c           |    2 +-
 sha1_name.c                  |    2 ++
 t/t8006-blame-textconv.sh    |    6 ++----
 t/t8007-cat-file-textconv.sh |    6 ++----
 6 files changed, 30 insertions(+), 21 deletions(-)

diff --git a/builtin.h b/builtin.h
index 0398d24..9bf69ee 100644
--- a/builtin.h
+++ b/builtin.h
@@ -35,7 +35,7 @@ void finish_copy_notes_for_rewrite(struct notes_rewri=
te_cfg *c);
=20
 extern int check_pager_config(const char *cmd);
=20
-extern int textconv_object(const char *path, const unsigned char *sha1=
, char **buf, unsigned long *buf_size);
+extern int textconv_object(const char *path, unsigned mode, const unsi=
gned char *sha1, char **buf, unsigned long *buf_size);
=20
 extern int cmd_add(int argc, const char **argv, const char *prefix);
 extern int cmd_annotate(int argc, const char **argv, const char *prefi=
x);
diff --git a/builtin/blame.c b/builtin/blame.c
index 1015354..f5fccc1 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -83,6 +83,7 @@ struct origin {
 	struct commit *commit;
 	mmfile_t file;
 	unsigned char blob_sha1[20];
+	unsigned mode;
 	char path[FLEX_ARRAY];
 };
=20
@@ -92,6 +93,7 @@ struct origin {
  * Return 1 if the conversion succeeds, 0 otherwise.
  */
 int textconv_object(const char *path,
+		    unsigned mode,
 		    const unsigned char *sha1,
 		    char **buf,
 		    unsigned long *buf_size)
@@ -100,7 +102,7 @@ int textconv_object(const char *path,
 	struct userdiff_driver *textconv;
=20
 	df =3D alloc_filespec(path);
-	fill_filespec(df, sha1, S_IFREG | 0664);
+	fill_filespec(df, sha1, mode);
 	textconv =3D get_textconv(df);
 	if (!textconv) {
 		free_filespec(df);
@@ -125,7 +127,7 @@ static void fill_origin_blob(struct diff_options *o=
pt,
=20
 		num_read_blob++;
 		if (DIFF_OPT_TST(opt, ALLOW_TEXTCONV) &&
-		    textconv_object(o->path, o->blob_sha1, &file->ptr, &file_size))
+		    textconv_object(o->path, o->mode, o->blob_sha1, &file->ptr, &fil=
e_size))
 			;
 		else
 			file->ptr =3D read_sha1_file(o->blob_sha1, &type, &file_size);
@@ -313,21 +315,23 @@ static struct origin *get_origin(struct scoreboar=
d *sb,
  * for an origin is also used to pass the blame for the entire file to
  * the parent to detect the case where a child's blob is identical to
  * that of its parent's.
+ *
+ * This also fills origin->mode for corresponding tree path.
  */
-static int fill_blob_sha1(struct origin *origin)
+static int fill_blob_sha1_and_mode(struct origin *origin)
 {
-	unsigned mode;
 	if (!is_null_sha1(origin->blob_sha1))
 		return 0;
 	if (get_tree_entry(origin->commit->object.sha1,
 			   origin->path,
-			   origin->blob_sha1, &mode))
+			   origin->blob_sha1, &origin->mode))
 		goto error_out;
 	if (sha1_object_info(origin->blob_sha1, NULL) !=3D OBJ_BLOB)
 		goto error_out;
 	return 0;
  error_out:
 	hashclr(origin->blob_sha1);
+	origin->mode =3D S_IFINVALID;
 	return -1;
 }
=20
@@ -360,12 +364,14 @@ static struct origin *find_origin(struct scoreboa=
rd *sb,
 			/*
 			 * If the origin was newly created (i.e. get_origin
 			 * would call make_origin if none is found in the
-			 * scoreboard), it does not know the blob_sha1,
+			 * scoreboard), it does not know the blob_sha1/mode,
 			 * so copy it.  Otherwise porigin was in the
-			 * scoreboard and already knows blob_sha1.
+			 * scoreboard and already knows blob_sha1/mode.
 			 */
-			if (porigin->refcnt =3D=3D 1)
+			if (porigin->refcnt =3D=3D 1) {
 				hashcpy(porigin->blob_sha1, cached->blob_sha1);
+				porigin->mode =3D cached->mode;
+			}
 			return porigin;
 		}
 		/* otherwise it was not very useful; free it */
@@ -400,6 +406,7 @@ static struct origin *find_origin(struct scoreboard=
 *sb,
 		/* The path is the same as parent */
 		porigin =3D get_origin(sb, parent, origin->path);
 		hashcpy(porigin->blob_sha1, origin->blob_sha1);
+		porigin->mode =3D origin->mode;
 	} else {
 		/*
 		 * Since origin->path is a pathspec, if the parent
@@ -425,6 +432,7 @@ static struct origin *find_origin(struct scoreboard=
 *sb,
 		case 'M':
 			porigin =3D get_origin(sb, parent, origin->path);
 			hashcpy(porigin->blob_sha1, p->one->sha1);
+			porigin->mode =3D p->one->mode;
 			break;
 		case 'A':
 		case 'T':
@@ -444,6 +452,7 @@ static struct origin *find_origin(struct scoreboard=
 *sb,
=20
 		cached =3D make_origin(porigin->commit, porigin->path);
 		hashcpy(cached->blob_sha1, porigin->blob_sha1);
+		cached->mode =3D porigin->mode;
 		parent->util =3D cached;
 	}
 	return porigin;
@@ -486,6 +495,7 @@ static struct origin *find_rename(struct scoreboard=
 *sb,
 		    !strcmp(p->two->path, origin->path)) {
 			porigin =3D get_origin(sb, parent, p->one->path);
 			hashcpy(porigin->blob_sha1, p->one->sha1);
+			porigin->mode =3D p->one->mode;
 			break;
 		}
 	}
@@ -1099,6 +1109,7 @@ static int find_copy_in_parent(struct scoreboard =
*sb,
=20
 			norigin =3D get_origin(sb, parent, p->one->path);
 			hashcpy(norigin->blob_sha1, p->one->sha1);
+			norigin->mode =3D p->one->mode;
 			fill_origin_blob(&sb->revs->diffopt, norigin, &file_p);
 			if (!file_p.ptr)
 				continue;
@@ -2075,7 +2086,7 @@ static struct commit *fake_working_tree_commit(st=
ruct diff_options *opt,
 		switch (st.st_mode & S_IFMT) {
 		case S_IFREG:
 			if (DIFF_OPT_TST(opt, ALLOW_TEXTCONV) &&
-			    textconv_object(read_from, null_sha1, &buf.buf, &buf_len))
+			    textconv_object(read_from, mode, null_sha1, &buf.buf, &buf_len)=
)
 				buf.len =3D buf_len;
 			else if (strbuf_read_file(&buf, read_from, st.st_size) !=3D st.st_s=
ize)
 				die_errno("cannot open or read '%s'", read_from);
@@ -2455,11 +2466,11 @@ parse_done:
 	}
 	else {
 		o =3D get_origin(&sb, sb.final, path);
-		if (fill_blob_sha1(o))
+		if (fill_blob_sha1_and_mode(o))
 			die("no such path %s in %s", path, final_commit_name);
=20
 		if (DIFF_OPT_TST(&sb.revs->diffopt, ALLOW_TEXTCONV) &&
-		    textconv_object(path, o->blob_sha1, (char **) &sb.final_buf,
+		    textconv_object(path, o->mode, o->blob_sha1, (char **) &sb.final=
_buf,
 				    &sb.final_buf_size))
 			;
 		else
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 76ec3fe..94632db 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -143,7 +143,7 @@ static int cat_one_file(int opt, const char *exp_ty=
pe, const char *obj_name)
 			die("git cat-file --textconv %s: <object> must be <sha1:path>",
 			    obj_name);
=20
-		if (!textconv_object(obj_context.path, sha1, &buf, &size))
+		if (!textconv_object(obj_context.path, obj_context.mode, sha1, &buf,=
 &size))
 			die("git cat-file --textconv: unable to run textconv on %s",
 			    obj_name);
 		break;
diff --git a/sha1_name.c b/sha1_name.c
index 7b7e617..4458fe8 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1068,6 +1068,7 @@ int get_sha1_with_context_1(const char *name, uns=
igned char *sha1,
 		struct cache_entry *ce;
 		int pos;
 		if (namelen > 2 && name[1] =3D=3D '/')
+			/* don't need mode for commit */
 			return get_sha1_oneline(name + 2, sha1);
 		if (namelen < 3 ||
 		    name[2] !=3D ':' ||
@@ -1095,6 +1096,7 @@ int get_sha1_with_context_1(const char *name, uns=
igned char *sha1,
 				break;
 			if (ce_stage(ce) =3D=3D stage) {
 				hashcpy(sha1, ce->sha1);
+				oc->mode =3D ce->ce_mode;
 				return 0;
 			}
 			pos++;
diff --git a/t/t8006-blame-textconv.sh b/t/t8006-blame-textconv.sh
index 7d42e96..400d9f1 100755
--- a/t/t8006-blame-textconv.sh
+++ b/t/t8006-blame-textconv.sh
@@ -90,8 +90,7 @@ test_expect_success 'blame with --no-textconv (on sym=
link)' '
 	test_cmp expected result
 '
=20
-# fails with '...symlink.bin is not "binary" file'
-test_expect_failure 'blame --textconv (on symlink)' '
+test_expect_success 'blame --textconv (on symlink)' '
 	git blame --textconv symlink.bin >blame &&
 	find_blame <blame >result &&
 	test_cmp expected result
@@ -110,8 +109,7 @@ EOF
 	GIT_AUTHOR_NAME=3DNumber4 git commit -a -m Fourth --date=3D"2010-01-0=
1 23:00:00"
 '
=20
-# fails with '...symlink.bin is not "binary" file'
-test_expect_failure 'blame on last commit (-C -C, symlink)' '
+test_expect_success 'blame on last commit (-C -C, symlink)' '
 	git blame -C -C three.bin >blame &&
 	find_blame <blame >result &&
 	cat >expected <<\EOF &&
diff --git a/t/t8007-cat-file-textconv.sh b/t/t8007-cat-file-textconv.s=
h
index f747c05..40e4af5 100755
--- a/t/t8007-cat-file-textconv.sh
+++ b/t/t8007-cat-file-textconv.sh
@@ -77,8 +77,7 @@ test_expect_success 'cat-file without --textconv (sym=
link)' '
 '
=20
=20
-# fails because cat-file tries to run converter on symlink.bin
-test_expect_failure 'cat-file --textconv on index (symlink)' '
+test_expect_success 'cat-file --textconv on index (symlink)' '
 	! git cat-file --textconv :symlink.bin 2>result &&
 	cat >expected <<\EOF &&
 fatal: git cat-file --textconv: unable to run textconv on :symlink.bin
@@ -86,8 +85,7 @@ EOF
 	test_cmp expected result
 '
=20
-# fails because cat-file tries to run converter on symlink.bin
-test_expect_failure 'cat-file --textconv on HEAD (symlink)' '
+test_expect_success 'cat-file --textconv on HEAD (symlink)' '
 	! git cat-file --textconv HEAD:symlink.bin 2>result &&
 	cat >expected <<EOF &&
 fatal: git cat-file --textconv: unable to run textconv on HEAD:symlink=
=2Ebin
--=20
1.7.3.rc2
