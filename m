From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 08/16] tempfile: add several functions for creating temporary files
Date: Mon, 10 Aug 2015 11:47:43 +0200
Message-ID: <c4da9c1988388b25d2c140b4dbd9c39a212790d9.1439198011.git.mhagger@alum.mit.edu>
References: <cover.1439198011.git.mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 11:48:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOjh1-00021w-3L
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 11:48:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754745AbbHJJsP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 05:48:15 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:63301 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754703AbbHJJsH (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Aug 2015 05:48:07 -0400
X-AuditID: 1207440e-f79516d0000012b3-c7-55c87355638b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 4B.1B.04787.55378C55; Mon, 10 Aug 2015 05:48:05 -0400 (EDT)
Received: from michael.fritz.box (p4FC97D4D.dip0.t-ipconnect.de [79.201.125.77])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t7A9lsww021057
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 10 Aug 2015 05:48:04 -0400
X-Mailer: git-send-email 2.5.0
In-Reply-To: <cover.1439198011.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsUixO6iqBtafCLUoHeDvEXXlW4mi4beK8wW
	T+beZba4vWI+swOLx9/3H5g8Hr7qYve4eEnZ4/MmuQCWKG6bpMSSsuDM9Dx9uwTujGnH9zAX
	3NGvaJp/i7mB8bJaFyMnh4SAicTRDd8YIWwxiQv31rN1MXJxCAlcZpR4Ov8oC4Rzgkni9rrz
	LCBVbAK6Eot6mplAbBEBNYmJbYfA4swC6RInFrSD2cICYRLX98wFs1kEVCWubrvACmLzCkRJ
	tN0/DLSNA2ibnMSCC+kgYU4BC4ntjRvASoQEzCUezzvPPoGRdwEjwypGucSc0lzd3MTMnOLU
	ZN3i5MS8vNQiXWO93MwSvdSU0k2MkPDh28HYvl7mEKMAB6MSD++MzcdDhVgTy4orcw8xSnIw
	KYnyWuSfCBXiS8pPqcxILM6ILyrNSS0+xCjBwawkwhufAZTjTUmsrEotyodJSXOwKInzqi1R
	9xMSSE8sSc1OTS1ILYLJynBwKEnwyhcBNQoWpaanVqRl5pQgpJk4OEGGc0mJFKfmpaQWJZaW
	ZMSDIiO+GBgbICkeoL12IO28xQWJuUBRiNZTjLoca2bfX8skxJKXn5cqJc77pxCoSACkKKM0
	D24FLFm8YhQH+liYtxFkFA8w0cBNegW0hAlkSSDYkpJEhJRUA+My3y6et15Gx902v5heXbW2
	81Bnqa7p6cPeXy34WxfuzuKvt/oo5Vvx0JLj2G5WqetLQtb4bu2YHPeww9/a0dLpgJfnShdF
	+YzERSFrYye+Fc2dPzOSh1t552uh1puCdRzvww5/PbNL+P2GKQVBH6aFuxinHVLV 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275592>

Add several functions for creating temporary files with
automatically-generated names, analogous to mkstemps(), but also
arranging for the files to be deleted on program exit.

The functions are named according to a pattern depending how they
operate. They will be used to replace many places in the code where
temporary files are created and cleaned up ad-hoc.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 tempfile.c | 53 ++++++++++++++++++++++++++++++++++
 tempfile.h | 96 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 149 insertions(+)

diff --git a/tempfile.c b/tempfile.c
index d840f04..0b5d8ce 100644
--- a/tempfile.c
+++ b/tempfile.c
@@ -137,6 +137,59 @@ int create_tempfile(struct tempfile *tempfile, const char *path)
 	return tempfile->fd;
 }
 
+int mks_tempfile_sm(struct tempfile *tempfile,
+		    const char *template, int suffixlen, int mode)
+{
+	prepare_tempfile_object(tempfile);
+
+	strbuf_add_absolute_path(&tempfile->filename, template);
+	tempfile->fd = git_mkstemps_mode(tempfile->filename.buf, suffixlen, mode);
+	if (tempfile->fd < 0) {
+		strbuf_reset(&tempfile->filename);
+		return -1;
+	}
+	tempfile->owner = getpid();
+	tempfile->active = 1;
+	return tempfile->fd;
+}
+
+int mks_tempfile_tsm(struct tempfile *tempfile,
+		     const char *template, int suffixlen, int mode)
+{
+	const char *tmpdir;
+
+	prepare_tempfile_object(tempfile);
+
+	tmpdir = getenv("TMPDIR");
+	if (!tmpdir)
+		tmpdir = "/tmp";
+
+	strbuf_addf(&tempfile->filename, "%s/%s", tmpdir, template);
+	tempfile->fd = git_mkstemps_mode(tempfile->filename.buf, suffixlen, mode);
+	if (tempfile->fd < 0) {
+		strbuf_reset(&tempfile->filename);
+		return -1;
+	}
+	tempfile->owner = getpid();
+	tempfile->active = 1;
+	return tempfile->fd;
+}
+
+int xmks_tempfile_m(struct tempfile *tempfile, const char *template, int mode)
+{
+	int fd;
+	struct strbuf full_template = STRBUF_INIT;
+
+	strbuf_add_absolute_path(&full_template, template);
+	fd = mks_tempfile_m(tempfile, full_template.buf, mode);
+	if (fd < 0)
+		die_errno("Unable to create temporary file '%s'",
+			  full_template.buf);
+
+	strbuf_release(&full_template);
+	return fd;
+}
+
 FILE *fdopen_tempfile(struct tempfile *tempfile, const char *mode)
 {
 	if (!tempfile->active)
diff --git a/tempfile.h b/tempfile.h
index bcc229f..a30e12c 100644
--- a/tempfile.h
+++ b/tempfile.h
@@ -92,6 +92,102 @@ struct tempfile {
  */
 extern int create_tempfile(struct tempfile *tempfile, const char *path);
 
+
+/*
+ * mks_tempfile functions
+ *
+ * The following functions attempt to create and open temporary files
+ * with names derived automatically from a template, in the manner of
+ * mkstemps(), and arrange for them to be deleted if the program ends
+ * before they are deleted explicitly. There is a whole family of such
+ * functions, named according to the following pattern:
+ *
+ *     x?mks_tempfile_t?s?m?()
+ *
+ * The optional letters have the following meanings:
+ *
+ *   x - die if the temporary file cannot be created.
+ *
+ *   t - create the temporary file under $TMPDIR (as opposed to
+ *       relative to the current directory). When these variants are
+ *       used, template should be the pattern for the filename alone,
+ *       without a path.
+ *
+ *   s - template includes a suffix that is suffixlen characters long.
+ *
+ *   m - the temporary file should be created with the specified mode
+ *       (otherwise, the mode is set to 0600).
+ *
+ * None of these functions modify template. If the caller wants to
+ * know the (absolute) path of the file that was created, it can be
+ * read from tempfile->filename.
+ *
+ * On success, the functions return a file descriptor that is open for
+ * writing the temporary file. On errors, they return -1 and set errno
+ * appropriately (except for the "x" variants, which die() on errors).
+ */
+
+/* See "mks_tempfile functions" above. */
+extern int mks_tempfile_sm(struct tempfile *tempfile,
+			   const char *template, int suffixlen, int mode);
+
+/* See "mks_tempfile functions" above. */
+static inline int mks_tempfile_s(struct tempfile *tempfile,
+				 const char *template, int suffixlen)
+{
+	return mks_tempfile_sm(tempfile, template, suffixlen, 0600);
+}
+
+/* See "mks_tempfile functions" above. */
+static inline int mks_tempfile_m(struct tempfile *tempfile,
+				 const char *template, int mode)
+{
+	return mks_tempfile_sm(tempfile, template, 0, mode);
+}
+
+/* See "mks_tempfile functions" above. */
+static inline int mks_tempfile(struct tempfile *tempfile,
+			       const char *template)
+{
+	return mks_tempfile_sm(tempfile, template, 0, 0600);
+}
+
+/* See "mks_tempfile functions" above. */
+extern int mks_tempfile_tsm(struct tempfile *tempfile,
+			    const char *template, int suffixlen, int mode);
+
+/* See "mks_tempfile functions" above. */
+static inline int mks_tempfile_ts(struct tempfile *tempfile,
+				  const char *template, int suffixlen)
+{
+	return mks_tempfile_tsm(tempfile, template, suffixlen, 0600);
+}
+
+/* See "mks_tempfile functions" above. */
+static inline int mks_tempfile_tm(struct tempfile *tempfile,
+				  const char *template, int mode)
+{
+	return mks_tempfile_tsm(tempfile, template, 0, mode);
+}
+
+/* See "mks_tempfile functions" above. */
+static inline int mks_tempfile_t(struct tempfile *tempfile,
+				 const char *template)
+{
+	return mks_tempfile_tsm(tempfile, template, 0, 0600);
+}
+
+/* See "mks_tempfile functions" above. */
+extern int xmks_tempfile_m(struct tempfile *tempfile,
+			   const char *template, int mode);
+
+/* See "mks_tempfile functions" above. */
+static inline int xmks_tempfile(struct tempfile *tempfile,
+				const char *template)
+{
+	return xmks_tempfile_m(tempfile, template, 0600);
+}
+
 /*
  * Associate a stdio stream with the temporary file (which must still
  * be open). Return `NULL` (*without* deleting the file) on error. The
-- 
2.5.0
