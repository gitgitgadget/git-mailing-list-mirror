From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH] abspath.c: use PATH_MAX in real_path_internal()
Date: Fri, 18 Jul 2014 17:08:45 +0200
Message-ID: <53C9387D.4090504@web.de>
References: <1405601143-31354-1-git-send-email-pclouds@gmail.com> <53C80265.5030903@web.de> <53C8562C.4000304@gmail.com> <CACsJy8D5X5svApB9edHK+1EaGi+q2ZRSOvyDYaDieVV2psgZPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 17:09:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X89mg-0007BV-Rb
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jul 2014 17:09:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761164AbaGRPJP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Jul 2014 11:09:15 -0400
Received: from mout.web.de ([212.227.15.14]:60600 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756803AbaGRPJO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2014 11:09:14 -0400
Received: from [192.168.178.27] ([79.250.167.186]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0LsQ9o-1WO7ft3g1Q-0121Od; Fri, 18 Jul 2014 17:08:58
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <CACsJy8D5X5svApB9edHK+1EaGi+q2ZRSOvyDYaDieVV2psgZPg@mail.gmail.com>
X-Provags-ID: V03:K0:sSGBETZP9PglSoPVh4kKRtlpxS+sg0i8pAovOLZ8s1YcNNRp26j
 oXYxjcLCgwghMsclXVVyFXpJD3yC9UAjGrRnpNSJnZsSWO2DCclhSB8PmejJUAwey84dhSv
 ur1PLv5WCPv+Bqyo/5SxvG5QTXJMlHrR2B/j/TgEtD3goOSrxTXfTqQa09UOQn6kU1U0YNu
 9KIYEiZxe/BSngzmdNURw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253821>

Am 18.07.2014 12:49, schrieb Duy Nguyen:
> On Fri, Jul 18, 2014 at 6:03 AM, Karsten Blees <karsten.blees@gmail.c=
om> wrote:
>> Am 17.07.2014 19:05, schrieb Ren=C3=A9 Scharfe:
>>> Am 17.07.2014 14:45, schrieb Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy:
>> [...]
>>> "These routines have traditionally been used by programs to save th=
e
>>> name of a working directory for the purpose of returning to it. A m=
uch
>>> faster and less error-prone method of accomplishing this is to open=
 the
>>> current directory (.) and use the fchdir(2) function to return."
>>>
>>
>> fchdir() is part of the POSIX-XSI extension, as is realpath(). So wh=
y not
>> use realpath() directly (which would also be thread-safe)?
>=20
> But realpath still needs a given buffer (of PATH_MAX at least again).
> Unless you pass a NULL pointer as "resolved_name", then Linux can
> allocate the buffer but that's implementation specific [1]. I guess w=
e
> can make a wrapper "git_getcwd" that returns a new buffer. The defaul=
t
> implementation returns one of PATH_MAX chars, certain platforms like
> Linux can use realpath (or something else) to return a longer path?
>=20
> [1] http://pubs.opengroup.org/onlinepubs/009695399/functions/realpath=
=2Ehtml

realpath() can be used to implement the whole of real_path_internal(),
IIUC, so there would be no need to change the current directory anymore=
=2E

The realpath(3) manpage for Linux mentions that behaviour of realpath()
with resolved_path being NULL is not standardized by POSIX.1-2001 but
by POSIX.1-2008.  At least Linux, OpenBSD and FreeBSD seem to support
that, based on their manpages.  Here's the standard doc:

http://pubs.opengroup.org/onlinepubs/9699919799/functions/realpath.html

>> For non-XSI-compliant platforms, we could keep the current implement=
ation.
>> Or re-implement a thread-safe version, e.g. applying resolve_symlink=
() from
>> lockfile.c to all path components.
>>
>>
>> If I may bother you with the Windows point of view:
>>
>> There is no fchdir(), and I'm pretty sure open(".") won't work eithe=
r.
>>
>> fchdir() could be emulated using GetFileInformationByHandleEx(FileNa=
meInfo).
>> realpath() is pretty much what GetFinalPathNameByHandle() does. Howe=
ver,
>> both of these APIs require Windows Vista.
>>
>> Opening a handle to a directory can be done using FILE_FLAG_BACKUP_S=
EMANTICS,
>> which AFAICT MSVCRT.dll's open() implementation does _not_ do (could=
 be
>> emulated in our mingw_open() wrapper, though).
>>
>> ...lots of work for little benefit, I would think.
>>
>=20
> We could wrap this "get cwd, cd back" pattern as well. So "save_cwd"
> returns an opaque pointer, "go_back" takes the pointer, (f)chdir back
> and free the pointer if needed. On platforms that support fchdir, it
> can be used, else we fall back to chdir. I think there are only four
> places that follow this pattern, here, setup.c (.git discovery), git.=
c
> (restore_env) and unix-socket.c. Enough call sites to make it worth
> the effort?

On a cursory look I didn't find any more potential users.  Something
like this?  Applying it to setup.c looks difficult to impossible,
though.

---
 Makefile          |  8 ++++++++
 abspath.c         | 10 ++++++----
 cache.h           |  1 +
 git.c             |  9 +++++----
 save-cwd-fchdir.c | 25 +++++++++++++++++++++++++
 save-cwd.c        | 22 ++++++++++++++++++++++
 save-cwd.h        |  3 +++
 unix-socket.c     | 11 ++++++-----
 8 files changed, 76 insertions(+), 13 deletions(-)
 create mode 100644 save-cwd-fchdir.c
 create mode 100644 save-cwd.c
 create mode 100644 save-cwd.h

diff --git a/Makefile b/Makefile
index 840057c..ecf3129 100644
--- a/Makefile
+++ b/Makefile
@@ -32,6 +32,8 @@ all::
 #
 # Define HAVE_ALLOCA_H if you have working alloca(3) defined in that h=
eader.
 #
+# Define HAVE_FCHDIR if you have fchdir(2).
+#
 # Define NO_CURL if you do not have libcurl installed.  git-http-fetch=
 and
 # git-http-push are not built, and you cannot use http:// and https://
 # transports (neither smart nor dumb).
@@ -1118,6 +1120,12 @@ ifdef HAVE_ALLOCA_H
 	BASIC_CFLAGS +=3D -DHAVE_ALLOCA_H
 endif
=20
+ifdef HAVE_FCHDIR
+	COMPAT_OBJS +=3D save-cwd-fchdir.o
+else
+	COMPAT_OBJS +=3D save-cwd.o
+endif
+
 ifdef NO_CURL
 	BASIC_CFLAGS +=3D -DNO_CURL
 	REMOTE_CURL_PRIMARY =3D
diff --git a/abspath.c b/abspath.c
index ca33558..f49bacc 100644
--- a/abspath.c
+++ b/abspath.c
@@ -41,7 +41,7 @@ static const char *real_path_internal(const char *pat=
h, int die_on_error)
 	 * here so that we can chdir() back to it at the end of the
 	 * function:
 	 */
-	char cwd[1024] =3D "";
+	struct saved_cwd *cwd =3D NULL;
=20
 	int buf_index =3D 1;
=20
@@ -80,7 +80,9 @@ static const char *real_path_internal(const char *pat=
h, int die_on_error)
 		}
=20
 		if (*buf) {
-			if (!*cwd && !getcwd(cwd, sizeof(cwd))) {
+			if (!cwd)
+				cwd =3D save_cwd();
+			if (!cwd) {
 				if (die_on_error)
 					die_errno("Could not get current working directory");
 				else
@@ -142,8 +144,8 @@ static const char *real_path_internal(const char *p=
ath, int die_on_error)
 	retval =3D buf;
 error_out:
 	free(last_elem);
-	if (*cwd && chdir(cwd))
-		die_errno("Could not change back to '%s'", cwd);
+	if (cwd && restore_cwd(cwd))
+		die_errno("Could not change back to the original working directory")=
;
=20
 	return retval;
 }
diff --git a/cache.h b/cache.h
index 92fc9f1..5b4e9cd 100644
--- a/cache.h
+++ b/cache.h
@@ -7,6 +7,7 @@
 #include "advice.h"
 #include "gettext.h"
 #include "convert.h"
+#include "save-cwd.h"
=20
 #include SHA1_HEADER
 #ifndef git_SHA_CTX
diff --git a/git.c b/git.c
index 5b6c761..946cc82 100644
--- a/git.c
+++ b/git.c
@@ -20,7 +20,7 @@ const char git_more_info_string[] =3D
=20
 static struct startup_info git_startup_info;
 static int use_pager =3D -1;
-static char orig_cwd[PATH_MAX];
+static struct saved_cwd *orig_cwd;
 static const char *env_names[] =3D {
 	GIT_DIR_ENVIRONMENT,
 	GIT_WORK_TREE_ENVIRONMENT,
@@ -36,7 +36,8 @@ static void save_env(void)
 	if (saved_environment)
 		return;
 	saved_environment =3D 1;
-	if (!getcwd(orig_cwd, sizeof(orig_cwd)))
+	orig_cwd =3D save_cwd();
+	if (!orig_cwd)
 		die_errno("cannot getcwd");
 	for (i =3D 0; i < ARRAY_SIZE(env_names); i++) {
 		orig_env[i] =3D getenv(env_names[i]);
@@ -48,8 +49,8 @@ static void save_env(void)
 static void restore_env(void)
 {
 	int i;
-	if (*orig_cwd && chdir(orig_cwd))
-		die_errno("could not move to %s", orig_cwd);
+	if (orig_cwd && restore_cwd(orig_cwd))
+		die_errno("could not move to the original working directory");
 	for (i =3D 0; i < ARRAY_SIZE(env_names); i++) {
 		if (orig_env[i])
 			setenv(env_names[i], orig_env[i], 1);
diff --git a/save-cwd-fchdir.c b/save-cwd-fchdir.c
new file mode 100644
index 0000000..5327932
--- /dev/null
+++ b/save-cwd-fchdir.c
@@ -0,0 +1,25 @@
+#include "cache.h"
+
+struct saved_cwd {
+	int cwd_fd;
+};
+
+struct saved_cwd *save_cwd(void)
+{
+	struct saved_cwd *cwd =3D xmalloc(sizeof(*cwd));
+	cwd->cwd_fd =3D open(".", O_RDONLY);
+	if (cwd->cwd_fd < 0) {
+		free(cwd);
+		return NULL;
+	}
+	return cwd;
+}
+
+int restore_cwd(struct saved_cwd *cwd)
+{
+	int rc =3D fchdir(cwd->cwd_fd);
+	if (!rc)
+		rc =3D close(cwd->cwd_fd);
+	free(cwd);
+	return rc;
+}
diff --git a/save-cwd.c b/save-cwd.c
new file mode 100644
index 0000000..1864e9f
--- /dev/null
+++ b/save-cwd.c
@@ -0,0 +1,22 @@
+#include "cache.h"
+
+struct saved_cwd {
+	char cwd[PATH_MAX];
+};
+
+struct saved_cwd *save_cwd(void)
+{
+	struct saved_cwd *cwd =3D xmalloc(sizeof(*cwd));
+	if (!getcwd(cwd->cwd, sizeof(cwd->cwd))) {
+		free(cwd);
+		return NULL;
+	}
+	return cwd;
+}
+
+int restore_cwd(struct saved_cwd *cwd)
+{
+	int rc =3D chdir(cwd->cwd);
+	free(cwd);
+	return rc;
+}
diff --git a/save-cwd.h b/save-cwd.h
new file mode 100644
index 0000000..1087ed3
--- /dev/null
+++ b/save-cwd.h
@@ -0,0 +1,3 @@
+struct saved_cwd;
+struct saved_cwd *save_cwd(void);
+int restore_cwd(struct saved_cwd *);
diff --git a/unix-socket.c b/unix-socket.c
index 01f119f..65d92f2 100644
--- a/unix-socket.c
+++ b/unix-socket.c
@@ -18,19 +18,19 @@ static int chdir_len(const char *orig, int len)
 }
=20
 struct unix_sockaddr_context {
-	char orig_dir[PATH_MAX];
+	struct saved_cwd *orig_dir;
 };
=20
 static void unix_sockaddr_cleanup(struct unix_sockaddr_context *ctx)
 {
-	if (!ctx->orig_dir[0])
+	if (!ctx->orig_dir)
 		return;
 	/*
 	 * If we fail, we can't just return an error, since we have
 	 * moved the cwd of the whole process, which could confuse calling
 	 * code.  We are better off to just die.
 	 */
-	if (chdir(ctx->orig_dir) < 0)
+	if (restore_cwd(ctx->orig_dir))
 		die("unable to restore original working directory");
 }
=20
@@ -39,7 +39,7 @@ static int unix_sockaddr_init(struct sockaddr_un *sa,=
 const char *path,
 {
 	int size =3D strlen(path) + 1;
=20
-	ctx->orig_dir[0] =3D '\0';
+	ctx->orig_dir =3D NULL;
 	if (size > sizeof(sa->sun_path)) {
 		const char *slash =3D find_last_dir_sep(path);
 		const char *dir;
@@ -57,7 +57,8 @@ static int unix_sockaddr_init(struct sockaddr_un *sa,=
 const char *path,
 			return -1;
 		}
=20
-		if (!getcwd(ctx->orig_dir, sizeof(ctx->orig_dir))) {
+		ctx->orig_dir =3D save_cwd();
+		if (!ctx->orig_dir) {
 			errno =3D ENAMETOOLONG;
 			return -1;
 		}
--=20
2.0.2
