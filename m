From: Axel Bonnet <axel.bonnet@ensimag.imag.fr>
Subject: [RFC/PATCH 3/4] textconv: support for blame
Date: Thu,  3 Jun 2010 12:47:17 +0200
Message-ID: <1275562038-7468-4-git-send-email-axel.bonnet@ensimag.imag.fr>
References: <1275562038-7468-1-git-send-email-axel.bonnet@ensimag.imag.fr>
 <1275562038-7468-2-git-send-email-axel.bonnet@ensimag.imag.fr>
 <1275562038-7468-3-git-send-email-axel.bonnet@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	=?UTF-8?q?Cl=C3=A9ment=20Poulain?= 
	<clement.poulain@ensimag.imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 03 12:55:48 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OK85S-0007RZ-15
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 12:55:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752004Ab0FCKzk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jun 2010 06:55:40 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: from mx1.imag.fr ([129.88.30.5]:48537 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751675Ab0FCKzj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jun 2010 06:55:39 -0400
X-Greylist: delayed 415 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Jun 2010 06:55:39 EDT
Received: from ensikerberos.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o53AfKnB028110
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Thu, 3 Jun 2010 12:41:20 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensikerberos.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id o53AmiY9023209;
	Thu, 3 Jun 2010 12:48:44 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id o53AmiAC008488;
	Thu, 3 Jun 2010 12:48:44 +0200
Received: (from bonneta@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id o53Ami0S008487;
	Thu, 3 Jun 2010 12:48:44 +0200
X-Mailer: git-send-email 1.6.6.7.ga5fe3
In-Reply-To: <1275562038-7468-3-git-send-email-axel.bonnet@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 03 Jun 2010 12:41:20 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o53AfKnB028110
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: axel.bonnet@ensimag.imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148306>

This patches enables to perform textconv with blame if a textconv drive=
r
is available for the file.

The main task is performed by the textconv_object function which
prepares diff_filespec and if possible converts the file using diff
textconv API.

Textconv conversion is enabled by default (equivalent to the option
--textconv), since blaming binary files is useless in most cases.
The option --no-textconv is used to disable textconv conversion.

The declaration of fill_blob_sha1 declaration is modified to get back
the mode the function was getting.

Signed-off-by: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
Signed-off-by: Cl=C3=A9ment Poulain <clement.poulain@ensimag.imag.fr>
Signed-off-by: Axel Bonnet <axel.bonnet@ensimag.imag.fr>
---
 builtin/blame.c |   74 ++++++++++++++++++++++++++++++++++++++++++++++-=
-------
 1 files changed, 63 insertions(+), 11 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 63b497c..4679fd9 100644
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
@@ -86,17 +87,57 @@ struct origin {
 };
=20
 /*
+ * Prepare diff_filespec and convert it using diff textconv API
+ * if the textconv driver exists.
+ * Return 1 if the conversion succeeds, 0 otherwise.
+ */
+static int textconv_object(const char *path,
+			   const unsigned char *sha1,
+			   unsigned short mode,
+			   struct strbuf *buf)
+{
+	struct diff_filespec *df;
+
+	df =3D alloc_filespec(path);
+	fill_filespec(df, sha1, mode);
+	get_textconv(df);
+
+	if (!df->driver|| !df->driver->textconv) {
+		free_filespec(df);
+		return 0;
+	}
+
+	buf->len =3D fill_textconv(df->driver, df, &buf->buf);
+	buf->alloc =3D 1;
+	free_filespec(df);
+	return 1;
+}
+
+/*
  * Given an origin, prepare mmfile_t structure to be used by the
  * diff machinery
  */
 static void fill_origin_blob(struct diff_options opt,
 			     struct origin *o, mmfile_t *file)
 {
+	unsigned mode;
+
 	if (!o->file.ptr) {
+		struct strbuf buf =3D STRBUF_INIT;
 		enum object_type type;
 		num_read_blob++;
-		file->ptr =3D read_sha1_file(o->blob_sha1, &type,
-					   (unsigned long *)(&(file->size)));
+
+		get_tree_entry(o->commit->object.sha1,
+			       o->path,
+			       o->blob_sha1, &mode);
+		if (DIFF_OPT_TST(&opt, ALLOW_TEXTCONV) &&
+		    textconv_object(o->path, o->blob_sha1, mode, &buf))
+			file->ptr =3D strbuf_detach(&buf, (size_t *) &file->size);
+		else
+			file->ptr =3D read_sha1_file(o->blob_sha1, &type,
+						   (unsigned long *)(&(file->size)));
+		strbuf_release(&buf);
+
 		if (!file->ptr)
 			die("Cannot read blob %s for path %s",
 			    sha1_to_hex(o->blob_sha1),
@@ -280,15 +321,13 @@ static struct origin *get_origin(struct scoreboar=
d *sb,
  * the parent to detect the case where a child's blob is identical to
  * that of its parent's.
  */
-static int fill_blob_sha1(struct origin *origin)
+static int fill_blob_sha1(struct origin *origin, unsigned *mode)
 {
-	unsigned mode;
-
 	if (!is_null_sha1(origin->blob_sha1))
 		return 0;
 	if (get_tree_entry(origin->commit->object.sha1,
 			   origin->path,
-			   origin->blob_sha1, &mode))
+			   origin->blob_sha1, mode))
 		goto error_out;
 	if (sha1_object_info(origin->blob_sha1, NULL) !=3D OBJ_BLOB)
 		goto error_out;
@@ -2033,10 +2072,13 @@ static struct commit *fake_working_tree_commit(=
struct diff_options opt,
 			read_from =3D path;
 		}
 		mode =3D canon_mode(st.st_mode);
+
 		switch (st.st_mode & S_IFMT) {
 		case S_IFREG:
-			if (strbuf_read_file(&buf, read_from, st.st_size) !=3D st.st_size)
-				die_errno("cannot open or read '%s'", read_from);
+			if (!DIFF_OPT_TST(&opt, ALLOW_TEXTCONV) ||
+			    !textconv_object(read_from, null_sha1, mode, &buf))
+				if (strbuf_read_file(&buf, read_from, st.st_size) !=3D st.st_size)
+					die_errno("cannot open or read '%s'", read_from);
 			break;
 		case S_IFLNK:
 			if (strbuf_readlink(&buf, read_from, st.st_size) < 0)
@@ -2249,8 +2291,10 @@ int cmd_blame(int argc, const char **argv, const=
 char *prefix)
 	int cmd_is_annotate =3D !strcmp(argv[0], "annotate");
=20
 	git_config(git_blame_config, NULL);
+	git_config(git_diff_ui_config, NULL);
 	init_revisions(&revs, NULL);
 	revs.date_mode =3D blame_date_mode;
+	DIFF_OPT_SET(&revs.diffopt, ALLOW_TEXTCONV);
=20
 	save_commit_buffer =3D 0;
 	dashdash_pos =3D 0;
@@ -2411,12 +2455,20 @@ parse_done:
 		sb.final_buf_size =3D o->file.size;
 	}
 	else {
+		struct strbuf buf =3D STRBUF_INIT;
+		unsigned mode;
 		o =3D get_origin(&sb, sb.final, path);
-		if (fill_blob_sha1(o))
+		if (fill_blob_sha1(o, &mode))
 			die("no such path %s in %s", path, final_commit_name);
=20
-		sb.final_buf =3D read_sha1_file(o->blob_sha1, &type,
-					      &sb.final_buf_size);
+		if (DIFF_OPT_TST(&sb.revs->diffopt, ALLOW_TEXTCONV) &&
+		    textconv_object(path, o->blob_sha1, mode, &buf))
+			sb.final_buf=3D strbuf_detach(&buf, (size_t *) &sb.final_buf_size);
+		else
+			sb.final_buf =3D read_sha1_file(o->blob_sha1, &type,
+						      &sb.final_buf_size);
+
+		strbuf_release(&buf);
 		if (!sb.final_buf)
 			die("Cannot read blob %s for path %s",
 			    sha1_to_hex(o->blob_sha1),
--=20
1.6.6.7.ga5fe3
