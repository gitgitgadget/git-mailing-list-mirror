From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 03/34] git_snpath(): retire and replace with strbuf_git_path()
Date: Sun, 30 Nov 2014 15:24:28 +0700
Message-ID: <1417335899-27307-4-git-send-email-pclouds@gmail.com>
References: <1417335899-27307-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 30 09:25:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xuzp4-00077C-8Z
	for gcvg-git-2@plane.gmane.org; Sun, 30 Nov 2014 09:25:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751943AbaK3IZe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Nov 2014 03:25:34 -0500
Received: from mail-pa0-f45.google.com ([209.85.220.45]:49357 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846AbaK3IZd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2014 03:25:33 -0500
Received: by mail-pa0-f45.google.com with SMTP id lj1so9093720pab.18
        for <git@vger.kernel.org>; Sun, 30 Nov 2014 00:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=OyyGB4yRE+x2gaJPRNwzXDdREvm3L7DEZmfehZqWTpI=;
        b=XxqqJcWfhizuPl5QxKlHWe59wdKpHbzVoBKz91uZvOR2UG62/v64LI5XJ9NQN7qKtn
         wHucKMof1xJW4mtmj6Al38rL3tU5WtmvUnOQuDYgyzDIk5Lgik3P8BcTkAEZGB24/wqx
         FT6qqzcx4n7ivSXSXq2B3fZumyL0DL3Z/k+B0FODgOVNx/y9sE3Cvv80McCsKPJLBTr/
         1I2yIoJSATyvQ29sF3yj3wCsW9gmbwkkRqd0dKOf5ryCvr10vj9tcqSnkThjktEbk/sh
         vS15MWMP/K8m6FwY1lxpOBclIt11XTjGXHuZks7SovtFKlyQ6G7gGTg/fAM1noCQ62z5
         lftw==
X-Received: by 10.70.134.10 with SMTP id pg10mr88574541pdb.47.1417335933140;
        Sun, 30 Nov 2014 00:25:33 -0800 (PST)
Received: from lanh ([115.73.247.22])
        by mx.google.com with ESMTPSA id r3sm14335893pds.57.2014.11.30.00.25.28
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Nov 2014 00:25:32 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 30 Nov 2014 15:25:31 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1417335899-27307-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260390>

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
---
 builtin/checkout.c | 13 ++++++++-----
 cache.h            |  4 ++--
 path.c             | 11 ++---------
 refs.c             | 51 ++++++++++++++++++++++++++++++++++++++++++----=
-----
 refs.h             |  2 +-
 5 files changed, 55 insertions(+), 26 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index c600ec1..195aca7 100644
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
index dbee0a3..56643cf 100644
--- a/cache.h
+++ b/cache.h
@@ -679,8 +679,8 @@ extern int check_repository_format(void);
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
index 23617e0..5ed991b 100644
--- a/refs.c
+++ b/refs.c
@@ -1444,7 +1444,11 @@ static int resolve_missing_loose_ref(const char =
*refname,
 }
=20
 /* This function needs to return a meaningful errno on failure */
-const char *resolve_ref_unsafe(const char *refname, int resolve_flags,=
 unsigned char *sha1, int *flags)
+static const char *resolve_ref_unsafe_1(const char *refname,
+					int resolve_flags,
+					unsigned char *sha1,
+					int *flags,
+					struct strbuf *sb_path)
 {
 	int depth =3D MAXDEPTH;
 	ssize_t len;
@@ -1475,7 +1479,7 @@ const char *resolve_ref_unsafe(const char *refnam=
e, int resolve_flags, unsigned
 		bad_name =3D 1;
 	}
 	for (;;) {
-		char path[PATH_MAX];
+		const char *path;
 		struct stat st;
 		char *buf;
 		int fd;
@@ -1485,7 +1489,9 @@ const char *resolve_ref_unsafe(const char *refnam=
e, int resolve_flags, unsigned
 			return NULL;
 		}
=20
-		git_snpath(path, sizeof(path), "%s", refname);
+		strbuf_reset(sb_path);
+		strbuf_git_path(sb_path, "%s", refname);
+		path =3D sb_path->buf;
=20
 		/*
 		 * We might have to loop back here to avoid a race
@@ -1612,6 +1618,16 @@ const char *resolve_ref_unsafe(const char *refna=
me, int resolve_flags, unsigned
 	}
 }
=20
+const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
+			       unsigned char *sha1, int *flags)
+{
+	struct strbuf sb_path =3D STRBUF_INIT;
+	const char *ret =3D resolve_ref_unsafe_1(refname, resolve_flags,
+					       sha1, flags, &sb_path);
+	strbuf_release(&sb_path);
+	return ret;
+}
+
 char *resolve_refdup(const char *ref, int resolve_flags, unsigned char=
 *sha1, int *flags)
 {
 	const char *ret =3D resolve_ref_unsafe(ref, resolve_flags, sha1, flag=
s);
@@ -2941,11 +2957,15 @@ static int copy_msg(char *buf, const char *msg)
 }
=20
 /* This function must set a meaningful errno on failure */
-int log_ref_setup(const char *refname, char *logfile, int bufsize)
+int log_ref_setup(const char *refname, struct strbuf *sb_logfile)
 {
 	int logfd, oflags =3D O_APPEND | O_WRONLY;
+	char *logfile;
=20
-	git_snpath(logfile, bufsize, "logs/%s", refname);
+	strbuf_git_path(sb_logfile, "logs/%s", refname);
+	logfile =3D sb_logfile->buf;
+	/* make sure the rest of the function can't change "logfile" */
+	sb_logfile =3D NULL;
 	if (log_all_ref_updates &&
 	    (starts_with(refname, "refs/heads/") ||
 	     starts_with(refname, "refs/remotes/") ||
@@ -2990,22 +3010,26 @@ int log_ref_setup(const char *refname, char *lo=
gfile, int bufsize)
 	return 0;
 }
=20
-static int log_ref_write(const char *refname, const unsigned char *old=
_sha1,
-			 const unsigned char *new_sha1, const char *msg)
+static int log_ref_write_1(const char *refname, const unsigned char *o=
ld_sha1,
+			   const unsigned char *new_sha1, const char *msg,
+			   struct strbuf *sb_log_file)
 {
 	int logfd, result, written, oflags =3D O_APPEND | O_WRONLY;
 	unsigned maxlen, len;
 	int msglen;
-	char log_file[PATH_MAX];
+	const char *log_file;
 	char *logrec;
 	const char *committer;
=20
 	if (log_all_ref_updates < 0)
 		log_all_ref_updates =3D !is_bare_repository();
=20
-	result =3D log_ref_setup(refname, log_file, sizeof(log_file));
+	result =3D log_ref_setup(refname, sb_log_file);
 	if (result)
 		return result;
+	log_file =3D sb_log_file->buf;
+	/* make sure the rest of the function can't change "log_file" */
+	sb_log_file =3D NULL;
=20
 	logfd =3D open(log_file, oflags);
 	if (logfd < 0)
@@ -3038,6 +3062,15 @@ static int log_ref_write(const char *refname, co=
nst unsigned char *old_sha1,
 	return 0;
 }
=20
+static int log_ref_write(const char *refname, const unsigned char *old=
_sha1,
+			 const unsigned char *new_sha1, const char *msg)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	int ret =3D log_ref_write_1(refname, old_sha1, new_sha1, msg, &sb);
+	strbuf_release(&sb);
+	return ret;
+}
+
 int is_branch(const char *refname)
 {
 	return !strcmp(refname, "HEAD") || starts_with(refname, "refs/heads/"=
);
diff --git a/refs.h b/refs.h
index 2bc3556..1f88220 100644
--- a/refs.h
+++ b/refs.h
@@ -210,7 +210,7 @@ extern void unlock_ref(struct ref_lock *lock);
 /*
  * Setup reflog before using. Set errno to something meaningful on fai=
lure.
  */
-int log_ref_setup(const char *refname, char *logfile, int bufsize);
+int log_ref_setup(const char *refname, struct strbuf *logfile);
=20
 /** Reads log for the value of ref during at_time. **/
 extern int read_ref_at(const char *refname, unsigned int flags,
--=20
2.1.0.rc0.78.gc0d8480
