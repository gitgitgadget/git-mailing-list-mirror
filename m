From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 06/14] tempfile: add several functions for creating temporary files
Date: Mon,  8 Jun 2015 11:07:37 +0200
Message-ID: <a922fa6cfcc948d541b638d99e2413865ff051e2.1433751986.git.mhagger@alum.mit.edu>
References: <cover.1433751986.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 08 11:08:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1t2U-0002UY-08
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 11:08:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752813AbbFHJIK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 05:08:10 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:48282 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752716AbbFHJIB (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jun 2015 05:08:01 -0400
X-AuditID: 12074412-f79066d000000bc5-06-55755b6fe4a9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 70.02.03013.F6B55755; Mon,  8 Jun 2015 05:07:59 -0400 (EDT)
Received: from michael.fritz.box (p4FC977B6.dip0.t-ipconnect.de [79.201.119.182])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t5897ojU010669
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 8 Jun 2015 05:07:58 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1433751986.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsUixO6iqJsfXRpqsHuLrkXXlW4mi4beK8wW
	t1fMZ7b40dLD7MDi8ff9ByaPZ717GD0uXlL2+LxJLoAlitsmKbGkLDgzPU/fLoE74+6nA8wF
	b4wq+vZuZ2lgnKfZxcjJISFgIrFu+0I2CFtM4sK99UA2F4eQwGVGidtfbzNDOCeYJBY+fMQC
	UsUmoCuxqKeZCcQWEXCUOPHgOiuIzSzgILH5cyMjiC0sECxxsOUuM4jNIqAq8ebNfLANvAJR
	EquetzJCbJOTOH/8J1gNp4CFxK+vu4BmcgAtM5f4MZd1AiPvAkaGVYxyiTmlubq5iZk5xanJ
	usXJiXl5qUW6Znq5mSV6qSmlmxgh4SO0g3H9SblDjAIcjEo8vAcWlYQKsSaWFVfmHmKU5GBS
	EuX9GFEaKsSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmEl8kCKMebklhZlVqUD5OS5mBREuf9uVjd
	T0ggPbEkNTs1tSC1CCYrw8GhJMFrHgXUKFiUmp5akZaZU4KQZuLgBBnOJSVSnJqXklqUWFqS
	EQ+KjPhiYGyApHiA9jaAtPMWFyTmAkUhWk8x6nL8uNS4mEmIJS8/L1VKnDcPpEgApCijNA9u
	BSxZvGIUB/pYmHczSBUPMNHATXoFtIQJaMn3r8UgS0oSEVJSDYwOM17LPsjZbsslZ/7kl3/0
	9cfmnRy2ojMKWbxuhn598e/i81ea/T8/O16+1TmBZ/2tylN/cusWTgsv92HNb5VkuvKr686E
	WImt9148rfWxWlmkaRWZNKneyn361Me/wvd1RaZ0tR94L5LxvWTpL6aoraanBGJ5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270997>

Add several functions for creating temporary files with
automatically-generated names, analogous to mkstemps(), but also
arranging for the files to be deleted on program exit.

The functions are named according to a pattern depending how they
operate. They will be used to replace many places in the code where
temporary files are created and cleaned up ad-hoc.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 tempfile.c | 55 ++++++++++++++++++++++++++++++++++-
 tempfile.h | 96 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 150 insertions(+), 1 deletion(-)

diff --git a/tempfile.c b/tempfile.c
index f76bc07..890075f 100644
--- a/tempfile.c
+++ b/tempfile.c
@@ -48,7 +48,7 @@ static void register_tempfile_object(struct tempfile *tempfile, const char *path
 		tempfile->fp = NULL;
 		tempfile->active = 0;
 		tempfile->owner = 0;
-		strbuf_init(&tempfile->filename, strlen(path));
+		strbuf_init(&tempfile->filename, 0);
 		tempfile->next = tempfile_list;
 		tempfile_list = tempfile;
 		tempfile->on_list = 1;
@@ -82,6 +82,59 @@ int create_tempfile(struct tempfile *tempfile, const char *path)
 	return tempfile->fd;
 }
 
+int mks_tempfile_sm(struct tempfile *tempfile,
+		    const char *template, int suffixlen, int mode)
+{
+	register_tempfile_object(tempfile, template);
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
+	register_tempfile_object(tempfile, template);
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
index f83deac..6276156 100644
--- a/tempfile.h
+++ b/tempfile.h
@@ -145,6 +145,102 @@ struct tempfile {
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
2.1.4
