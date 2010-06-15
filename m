From: Axel Bonnet <axel.bonnet@ensimag.imag.fr>
Subject: [PATCH v2 2/3] textconv: support for blame
Date: Tue, 15 Jun 2010 15:58:48 +0200
Message-ID: <1276610328-28532-1-git-send-email-axel.bonnet@ensimag.imag.fr>
References: <7vfx0p9wlm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	=?UTF-8?q?Cl=C3=A9ment=20Poulain?= 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 15 15:59:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOWg0-0005Sc-IM
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 15:59:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757682Ab0FON7e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Jun 2010 09:59:34 -0400
Received: from mx2.imag.fr ([129.88.30.17]:39588 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753128Ab0FON7c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jun 2010 09:59:32 -0400
Received: from ensikerberos.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o5FDpRig016450
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Tue, 15 Jun 2010 15:51:27 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensikerberos.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id o5FDxUZm022115;
	Tue, 15 Jun 2010 15:59:30 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id o5FDxU1C028959;
	Tue, 15 Jun 2010 15:59:30 +0200
Received: (from bonneta@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id o5FDxUtu028958;
	Tue, 15 Jun 2010 15:59:30 +0200
X-Mailer: git-send-email 1.6.6.7.ga5fe3
In-Reply-To: <7vfx0p9wlm.fsf@alter.siamese.dyndns.org>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 15 Jun 2010 15:51:27 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o5FDpRig016450
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: axel.bonnet@ensimag.imag.fr
MailScanner-NULL-Check: 1277214687.84274@oLT1euv/cy2+NyZjg2a0ig
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149187>

This patches enables to perform textconv with blame if a textconv drive=
r is
available for the file.

The main task is performed by the textconv_object function which prepar=
es
diff_filespec and if possible converts the file using diff textconv API=
=2E
Only regular files are converted, so the mode of diff_filespec is faked=
=2E

Textconv conversion is enabled by default (equivalent to the option
--textconv), since blaming binary files is useless in most cases.
The option --no-textconv is used to disable textconv conversion.

The declarations of several functions are modified to give access to a
diff_options, in order to know whether the textconv option is activated=
 or not.

Signed-off-by: Axel Bonnet <axel.bonnet@ensimag.imag.fr>
Signed-off-by: Cl=C3=A9ment Poulain <clement.poulain@ensimag.imag.fr>
Signed-off-by: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
---

The problem with cast between size_t and unsigned long is fixed.
The style problem with the case is fixed.

 builtin/blame.c |   86 ++++++++++++++++++++++++++++++++++++++++++++++-=
--------
 1 files changed, 72 insertions(+), 14 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 8506286..5b61067 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -20,6 +20,7 @@
 #include "mailmap.h"
 #include "parse-options.h"
 #include "utf8.h"
+#include "userdiff.h"
=20
 static char blame_usage[] =3D "git blame [options] [rev-opts] [rev] [-=
-] file";
=20
@@ -86,16 +87,49 @@ struct origin {
 };
=20
 /*
+ * Prepare diff_filespec and convert it using diff textconv API
+ * if the textconv driver exists.
+ * Return 1 if the conversion succeeds, 0 otherwise.
+ */
+static int textconv_object(const char *path,
+			   const unsigned char *sha1,
+			   char **buf,
+			   unsigned long *buf_size)
+{
+	struct diff_filespec *df;
+	struct userdiff_driver *textconv;
+
+	df =3D alloc_filespec(path);
+	fill_filespec(df, sha1, S_IFREG | 0664);
+	textconv =3D get_textconv(df);
+	if (!textconv) {
+		free_filespec(df);
+		return 0;
+	}
+
+	*buf_size =3D fill_textconv(textconv, df, buf);
+	free_filespec(df);
+	return 1;
+}
+
+/*
  * Given an origin, prepare mmfile_t structure to be used by the
  * diff machinery
  */
-static void fill_origin_blob(struct origin *o, mmfile_t *file)
+static void fill_origin_blob(struct diff_options *opt,
+			     struct origin *o, mmfile_t *file)
 {
 	if (!o->file.ptr) {
 		enum object_type type;
 		num_read_blob++;
-		file->ptr =3D read_sha1_file(o->blob_sha1, &type,
-					   (unsigned long *)(&(file->size)));
+
+		if (DIFF_OPT_TST(opt, ALLOW_TEXTCONV) &&
+		    textconv_object(o->path, o->blob_sha1, &file->ptr,
+				    (unsigned long *)(&file->size)))
+			;
+		else
+			file->ptr =3D read_sha1_file(o->blob_sha1, &type,
+						   (unsigned long *)(&(file->size)));
 		if (!file->ptr)
 			die("Cannot read blob %s for path %s",
 			    sha1_to_hex(o->blob_sha1),
@@ -282,7 +316,6 @@ static struct origin *get_origin(struct scoreboard =
*sb,
 static int fill_blob_sha1(struct origin *origin)
 {
 	unsigned mode;
-
 	if (!is_null_sha1(origin->blob_sha1))
 		return 0;
 	if (get_tree_entry(origin->commit->object.sha1,
@@ -741,8 +774,8 @@ static int pass_blame_to_parent(struct scoreboard *=
sb,
 	if (last_in_target < 0)
 		return 1; /* nothing remains for this target */
=20
-	fill_origin_blob(parent, &file_p);
-	fill_origin_blob(target, &file_o);
+	fill_origin_blob(&sb->revs->diffopt, parent, &file_p);
+	fill_origin_blob(&sb->revs->diffopt, target, &file_o);
 	num_get_patch++;
=20
 	memset(&xpp, 0, sizeof(xpp));
@@ -922,7 +955,7 @@ static int find_move_in_parent(struct scoreboard *s=
b,
 	if (last_in_target < 0)
 		return 1; /* nothing remains for this target */
=20
-	fill_origin_blob(parent, &file_p);
+	fill_origin_blob(&sb->revs->diffopt, parent, &file_p);
 	if (!file_p.ptr)
 		return 0;
=20
@@ -1063,7 +1096,7 @@ static int find_copy_in_parent(struct scoreboard =
*sb,
=20
 			norigin =3D get_origin(sb, parent, p->one->path);
 			hashcpy(norigin->blob_sha1, p->one->sha1);
-			fill_origin_blob(norigin, &file_p);
+			fill_origin_blob(&sb->revs->diffopt, norigin, &file_p);
 			if (!file_p.ptr)
 				continue;
=20
@@ -1983,6 +2016,16 @@ static int git_blame_config(const char *var, con=
st char *value, void *cb)
 		blame_date_mode =3D parse_date_format(value);
 		return 0;
 	}
+
+	switch (userdiff_config(var, value)) {
+	case 0:
+		break;
+	case -1:
+		return -1;
+	default:
+		return 0;
+	}
+
 	return git_default_config(var, value, cb);
 }
=20
@@ -1990,7 +2033,9 @@ static int git_blame_config(const char *var, cons=
t char *value, void *cb)
  * Prepare a dummy commit that represents the work tree (or staged) it=
em.
  * Note that annotating work tree item never works in the reverse.
  */
-static struct commit *fake_working_tree_commit(const char *path, const=
 char *contents_from)
+static struct commit *fake_working_tree_commit(struct diff_options *op=
t,
+					       const char *path,
+					       const char *contents_from)
 {
 	struct commit *commit;
 	struct origin *origin;
@@ -2018,6 +2063,7 @@ static struct commit *fake_working_tree_commit(co=
nst char *path, const char *con
 	if (!contents_from || strcmp("-", contents_from)) {
 		struct stat st;
 		const char *read_from;
+		unsigned long buf_len;
=20
 		if (contents_from) {
 			if (stat(contents_from, &st) < 0)
@@ -2030,10 +2076,14 @@ static struct commit *fake_working_tree_commit(=
const char *path, const char *con
 			read_from =3D path;
 		}
 		mode =3D canon_mode(st.st_mode);
+
 		switch (st.st_mode & S_IFMT) {
 		case S_IFREG:
-			if (strbuf_read_file(&buf, read_from, st.st_size) !=3D st.st_size)
-				die_errno("cannot open or read '%s'", read_from);
+			if (DIFF_OPT_TST(opt, ALLOW_TEXTCONV) &&
+			    textconv_object(read_from, null_sha1, &buf.buf, &buf_len))
+				buf.len =3D buf_len;
+			else if (strbuf_read_file(&buf, read_from, st.st_size) !=3D st.st_s=
ize)
+				 die_errno("cannot open or read '%s'", read_from);
 			break;
 		case S_IFLNK:
 			if (strbuf_readlink(&buf, read_from, st.st_size) < 0)
@@ -2248,6 +2298,7 @@ int cmd_blame(int argc, const char **argv, const =
char *prefix)
 	git_config(git_blame_config, NULL);
 	init_revisions(&revs, NULL);
 	revs.date_mode =3D blame_date_mode;
+	DIFF_OPT_SET(&revs.diffopt, ALLOW_TEXTCONV);
=20
 	save_commit_buffer =3D 0;
 	dashdash_pos =3D 0;
@@ -2384,7 +2435,8 @@ parse_done:
 		 * or "--contents".
 		 */
 		setup_work_tree();
-		sb.final =3D fake_working_tree_commit(path, contents_from);
+		sb.final =3D fake_working_tree_commit(&sb.revs->diffopt,
+						    path, contents_from);
 		add_pending_object(&revs, &(sb.final->object), ":");
 	}
 	else if (contents_from)
@@ -2411,8 +2463,14 @@ parse_done:
 		if (fill_blob_sha1(o))
 			die("no such path %s in %s", path, final_commit_name);
=20
-		sb.final_buf =3D read_sha1_file(o->blob_sha1, &type,
-					      &sb.final_buf_size);
+		if (DIFF_OPT_TST(&sb.revs->diffopt, ALLOW_TEXTCONV) &&
+		    textconv_object(path, o->blob_sha1, (char **) &sb.final_buf,
+				    &sb.final_buf_size))
+			;
+		else
+			sb.final_buf =3D read_sha1_file(o->blob_sha1, &type,
+						      &sb.final_buf_size);
+
 		if (!sb.final_buf)
 			die("Cannot read blob %s for path %s",
 			    sha1_to_hex(o->blob_sha1),
--=20
1.6.6.7.ga5fe3
