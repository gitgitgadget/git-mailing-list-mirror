From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 03/32] git_snpath(): retire and replace with strbuf_git_path()
Date: Sun, 28 Sep 2014 08:22:17 +0700
Message-ID: <1411867366-3821-4-git-send-email-pclouds@gmail.com>
References: <xmqqk34r9z3r.fsf@gitster.dls.corp.google.com>
 <1411867366-3821-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 28 03:23:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XY3Cj-00027h-Gk
	for gcvg-git-2@plane.gmane.org; Sun, 28 Sep 2014 03:23:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752807AbaI1BXI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Sep 2014 21:23:08 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:42285 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751267AbaI1BXH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Sep 2014 21:23:07 -0400
Received: by mail-pd0-f180.google.com with SMTP id fp1so1216571pdb.39
        for <git@vger.kernel.org>; Sat, 27 Sep 2014 18:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Fb0OOe9EKmE1zak+43d4hxDqcrst0fpUBHeboaaWa5g=;
        b=gzuUf+WbHT0lpMrqgubc1h4xZaKi6sXDx2GQUq+uk2bCotJ/Va2b29ONF3I44vbH+Q
         vnGOhSihAtbJdcAgq4Jo/HqkqVavGY/w6e8dFVzMC4eXg1rmuXMTx0gnXpetahbbgBfy
         xi3ZZiE7DeWFPiGlFwZ9WNx6EJr/pkfva8bFhd1207vJS84uTacr+LupzyMoQHVlZmEO
         F5QlRTgiQ0F+q2YnLVoMx1/3DcywyIgylmRjDxmTS+RtIHTJPmtTZJoqykEnN7ndgP1k
         tYr9ETu20laz9ILDAQinifcNuTFZo3pv6U10+7BYIazBZolG01rdJguf0IByk/LmIfQP
         G9oA==
X-Received: by 10.68.115.48 with SMTP id jl16mr46938529pbb.78.1411867386645;
        Sat, 27 Sep 2014 18:23:06 -0700 (PDT)
Received: from lanh ([115.73.212.224])
        by mx.google.com with ESMTPSA id nq11sm8569538pdb.17.2014.09.27.18.23.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Sep 2014 18:23:05 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 28 Sep 2014 08:23:09 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1411867366-3821-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257562>

In the previous patch, git_snpath() is modified to allocate a new
strbuf buffer because vsnpath() needs that. But that makes it
awkward because git_snpath() receives a pre-allocated buffer from
outside and has to copy data back. Rename it to strbuf_git_path()
and make it receive strbuf directly.

Using git_path() in update_refs_for_switch() which used to call
git_snpath() is safe because that function and all of its callers do
not keep any pointer to the round-robin buffer pool allocated by
get_pathname().

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/checkout.c | 13 +++++----
 cache.h            |  4 +--
 path.c             | 11 ++------
 refs.c             | 78 +++++++++++++++++++++++++++++++++-------------=
--------
 refs.h             |  2 +-
 5 files changed, 61 insertions(+), 47 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index d402d7a..220f80e 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -588,18 +588,21 @@ static void update_refs_for_switch(const struct c=
heckout_opts *opts,
 		if (opts->new_orphan_branch) {
 			if (opts->new_branch_log && !log_all_ref_updates) {
 				int temp;
-				char log_file[PATH_MAX];
-				const char *ref_name =3D mkpath("refs/heads/%s", opts->new_orphan_=
branch);
+				struct strbuf log_file =3D STRBUF_INIT;
+				int ret;
+				const char *ref_name;
=20
+				ref_name =3D mkpath("refs/heads/%s", opts->new_orphan_branch);
 				temp =3D log_all_ref_updates;
 				log_all_ref_updates =3D 1;
-				if (log_ref_setup(ref_name, log_file, sizeof(log_file))) {
+				ret =3D log_ref_setup(ref_name, &log_file);
+				log_all_ref_updates =3D temp;
+				strbuf_release(&log_file);
+				if (ret) {
 					fprintf(stderr, _("Can not do reflog for '%s'\n"),
 					    opts->new_orphan_branch);
-					log_all_ref_updates =3D temp;
 					return;
 				}
-				log_all_ref_updates =3D temp;
 			}
 		}
 		else
diff --git a/cache.h b/cache.h
index 2e4d88f..f487c0e 100644
--- a/cache.h
+++ b/cache.h
@@ -697,8 +697,8 @@ extern int check_repository_format(void);
=20
 extern char *mksnpath(char *buf, size_t n, const char *fmt, ...)
 	__attribute__((format (printf, 3, 4)));
-extern char *git_snpath(char *buf, size_t n, const char *fmt, ...)
-	__attribute__((format (printf, 3, 4)));
+extern void strbuf_git_path(struct strbuf *sb, const char *fmt, ...)
+	__attribute__((format (printf, 2, 3)));
 extern char *git_pathdup(const char *fmt, ...)
 	__attribute__((format (printf, 1, 2)));
 extern char *mkpathdup(const char *fmt, ...)
diff --git a/path.c b/path.c
index a7ceea2..47753aa 100644
--- a/path.c
+++ b/path.c
@@ -70,19 +70,12 @@ static void vsnpath(struct strbuf *buf, const char =
*fmt, va_list args)
 	strbuf_cleanup_path(buf);
 }
=20
-char *git_snpath(char *buf, size_t n, const char *fmt, ...)
+void strbuf_git_path(struct strbuf *sb, const char *fmt, ...)
 {
-	struct strbuf sb =3D STRBUF_INIT;
 	va_list args;
 	va_start(args, fmt);
-	vsnpath(&sb, fmt, args);
+	vsnpath(sb, fmt, args);
 	va_end(args);
-	if (sb.len >=3D n)
-		strlcpy(buf, bad_path, n);
-	else
-		memcpy(buf, sb.buf, sb.len + 1);
-	strbuf_release(&sb);
-	return buf;
 }
=20
 char *git_pathdup(const char *fmt, ...)
diff --git a/refs.c b/refs.c
index f616adc..3cefbd3 100644
--- a/refs.c
+++ b/refs.c
@@ -1400,10 +1400,12 @@ static const char *handle_missing_loose_ref(con=
st char *refname,
 /* This function needs to return a meaningful errno on failure */
 const char *resolve_ref_unsafe(const char *refname, unsigned char *sha=
1, int reading, int *flag)
 {
+	struct strbuf sb_path =3D STRBUF_INIT;
 	int depth =3D MAXDEPTH;
 	ssize_t len;
 	char buffer[256];
 	static char refname_buffer[256];
+	const char *ret;
=20
 	if (flag)
 		*flag =3D 0;
@@ -1414,17 +1416,19 @@ const char *resolve_ref_unsafe(const char *refn=
ame, unsigned char *sha1, int rea
 	}
=20
 	for (;;) {
-		char path[PATH_MAX];
+		const char *path;
 		struct stat st;
 		char *buf;
 		int fd;
=20
 		if (--depth < 0) {
 			errno =3D ELOOP;
-			return NULL;
+			goto fail;
 		}
=20
-		git_snpath(path, sizeof(path), "%s", refname);
+		strbuf_reset(&sb_path);
+		strbuf_git_path(&sb_path, "%s", refname);
+		path =3D sb_path.buf;
=20
 		/*
 		 * We might have to loop back here to avoid a race
@@ -1438,10 +1442,11 @@ const char *resolve_ref_unsafe(const char *refn=
ame, unsigned char *sha1, int rea
 	stat_ref:
 		if (lstat(path, &st) < 0) {
 			if (errno =3D=3D ENOENT)
-				return handle_missing_loose_ref(refname, sha1,
-								reading, flag);
+				ret =3D handle_missing_loose_ref(refname, sha1,
+							       reading, flag);
 			else
-				return NULL;
+				ret =3D NULL;
+			goto done;
 		}
=20
 		/* Follow "normalized" - ie "refs/.." symlinks by hand */
@@ -1452,7 +1457,7 @@ const char *resolve_ref_unsafe(const char *refnam=
e, unsigned char *sha1, int rea
 					/* inconsistent with lstat; retry */
 					goto stat_ref;
 				else
-					return NULL;
+					goto fail;
 			}
 			buffer[len] =3D 0;
 			if (starts_with(buffer, "refs/") &&
@@ -1468,7 +1473,7 @@ const char *resolve_ref_unsafe(const char *refnam=
e, unsigned char *sha1, int rea
 		/* Is it a directory? */
 		if (S_ISDIR(st.st_mode)) {
 			errno =3D EISDIR;
-			return NULL;
+			goto fail;
 		}
=20
 		/*
@@ -1481,14 +1486,15 @@ const char *resolve_ref_unsafe(const char *refn=
ame, unsigned char *sha1, int rea
 				/* inconsistent with lstat; retry */
 				goto stat_ref;
 			else
-				return NULL;
+				goto fail;
 		}
+
 		len =3D read_in_full(fd, buffer, sizeof(buffer)-1);
 		if (len < 0) {
 			int save_errno =3D errno;
 			close(fd);
 			errno =3D save_errno;
-			return NULL;
+			goto fail;
 		}
 		close(fd);
 		while (len && isspace(buffer[len-1]))
@@ -1508,9 +1514,10 @@ const char *resolve_ref_unsafe(const char *refna=
me, unsigned char *sha1, int rea
 				if (flag)
 					*flag |=3D REF_ISBROKEN;
 				errno =3D EINVAL;
-				return NULL;
+				goto fail;
 			}
-			return refname;
+			ret =3D refname;
+			goto done;
 		}
 		if (flag)
 			*flag |=3D REF_ISSYMREF;
@@ -1521,10 +1528,15 @@ const char *resolve_ref_unsafe(const char *refn=
ame, unsigned char *sha1, int rea
 			if (flag)
 				*flag |=3D REF_ISBROKEN;
 			errno =3D EINVAL;
-			return NULL;
+			goto fail;
 		}
 		refname =3D strcpy(refname_buffer, buf);
 	}
+fail:
+	ret =3D NULL;
+done:
+	strbuf_release(&sb_path);
+	return ret;
 }
=20
 char *resolve_refdup(const char *ref, unsigned char *sha1, int reading=
, int *flag)
@@ -2832,51 +2844,51 @@ static int copy_msg(char *buf, const char *msg)
 }
=20
 /* This function must set a meaningful errno on failure */
-int log_ref_setup(const char *refname, char *logfile, int bufsize)
+int log_ref_setup(const char *refname, struct strbuf *logfile)
 {
 	int logfd, oflags =3D O_APPEND | O_WRONLY;
=20
-	git_snpath(logfile, bufsize, "logs/%s", refname);
+	strbuf_git_path(logfile, "logs/%s", refname);
 	if (log_all_ref_updates &&
 	    (starts_with(refname, "refs/heads/") ||
 	     starts_with(refname, "refs/remotes/") ||
 	     starts_with(refname, "refs/notes/") ||
 	     !strcmp(refname, "HEAD"))) {
-		if (safe_create_leading_directories(logfile) < 0) {
+		if (safe_create_leading_directories(logfile->buf) < 0) {
 			int save_errno =3D errno;
-			error("unable to create directory for %s", logfile);
+			error("unable to create directory for %s", logfile->buf);
 			errno =3D save_errno;
 			return -1;
 		}
 		oflags |=3D O_CREAT;
 	}
=20
-	logfd =3D open(logfile, oflags, 0666);
+	logfd =3D open(logfile->buf, oflags, 0666);
 	if (logfd < 0) {
 		if (!(oflags & O_CREAT) && errno =3D=3D ENOENT)
 			return 0;
=20
 		if ((oflags & O_CREAT) && errno =3D=3D EISDIR) {
-			if (remove_empty_directories(logfile)) {
+			if (remove_empty_directories(logfile->buf)) {
 				int save_errno =3D errno;
 				error("There are still logs under '%s'",
-				      logfile);
+				      logfile->buf);
 				errno =3D save_errno;
 				return -1;
 			}
-			logfd =3D open(logfile, oflags, 0666);
+			logfd =3D open(logfile->buf, oflags, 0666);
 		}
=20
 		if (logfd < 0) {
 			int save_errno =3D errno;
-			error("Unable to append to %s: %s", logfile,
+			error("Unable to append to %s: %s", logfile->buf,
 			      strerror(errno));
 			errno =3D save_errno;
 			return -1;
 		}
 	}
=20
-	adjust_shared_perm(logfile);
+	adjust_shared_perm(logfile->buf);
 	close(logfd);
 	return 0;
 }
@@ -2887,20 +2899,22 @@ static int log_ref_write(const char *refname, c=
onst unsigned char *old_sha1,
 	int logfd, result, written, oflags =3D O_APPEND | O_WRONLY;
 	unsigned maxlen, len;
 	int msglen;
-	char log_file[PATH_MAX];
+	struct strbuf sb_log_file =3D STRBUF_INIT;
+	const char *log_file;
 	char *logrec;
 	const char *committer;
=20
 	if (log_all_ref_updates < 0)
 		log_all_ref_updates =3D !is_bare_repository();
=20
-	result =3D log_ref_setup(refname, log_file, sizeof(log_file));
+	result =3D log_ref_setup(refname, &sb_log_file);
 	if (result)
-		return result;
+		goto done;
+	log_file =3D sb_log_file.buf;
=20
 	logfd =3D open(log_file, oflags);
 	if (logfd < 0)
-		return 0;
+		goto done;
 	msglen =3D msg ? strlen(msg) : 0;
 	committer =3D git_committer_info(0);
 	maxlen =3D strlen(committer) + msglen + 100;
@@ -2918,15 +2932,19 @@ static int log_ref_write(const char *refname, c=
onst unsigned char *old_sha1,
 		close(logfd);
 		error("Unable to append to %s", log_file);
 		errno =3D save_errno;
-		return -1;
+		result =3D -1;
+		goto done;
 	}
 	if (close(logfd)) {
 		int save_errno =3D errno;
 		error("Unable to append to %s", log_file);
 		errno =3D save_errno;
-		return -1;
+		result =3D -1;
+		goto done;
 	}
-	return 0;
+done:
+	strbuf_release(&sb_log_file);
+	return result;
 }
=20
 int is_branch(const char *refname)
diff --git a/refs.h b/refs.h
index 10fc3a2..c990a85 100644
--- a/refs.h
+++ b/refs.h
@@ -203,7 +203,7 @@ extern int write_ref_sha1(struct ref_lock *lock, co=
nst unsigned char *sha1, cons
 /*
  * Setup reflog before using. Set errno to something meaningful on fai=
lure.
  */
-int log_ref_setup(const char *refname, char *logfile, int bufsize);
+int log_ref_setup(const char *refname, struct strbuf *logfile);
=20
 /** Reads log for the value of ref during at_time. **/
 extern int read_ref_at(const char *refname, unsigned long at_time, int=
 cnt,
--=20
2.1.0.rc0.78.gc0d8480
