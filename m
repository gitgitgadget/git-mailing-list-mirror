From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [RFC] i18n.pathencoding
Date: Sat, 1 Sep 2012 08:11:33 +0200
Message-ID: <201209010811.33994.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 01 08:12:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7gwc-0004dr-F4
	for gcvg-git-2@plane.gmane.org; Sat, 01 Sep 2012 08:12:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751924Ab2IAGM1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Sep 2012 02:12:27 -0400
Received: from mout.web.de ([212.227.17.12]:55826 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751860Ab2IAGLn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Sep 2012 02:11:43 -0400
Received: from appes.localnet ([195.67.191.22]) by smtp.web.de (mrweb103) with
 ESMTPA (Nemesis) id 0M6mTI-1TUjcW03iW-00wKGu; Sat, 01 Sep 2012 08:11:41 +0200
X-Provags-ID: V02:K0:/3NJ8LOW2MVT309i35mWYyhHvNeA9lsnsci2A2oxkCj
 BJ84LYBBR52hlzfM0OHh+38iPCUKiLplmIFsLmxgrtkO6dEOeY
 1SregZ6sB4UxxS1K5yiC9zuDDBAqWJ6O0GyOPuqVJMDwWGuK0f
 VfUYLa14ZFAkKvsXan0hHqLO3aJJXB6RITKatmey4ux7+QGU4d
 Go3K7Ok9s8eUtjb0he/UA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204617>

Allow path names to be encoded in UTF-8 in the repository
and checkout out as e.g. ISO-8859-1 in the working tree.

Introduce a config variable i18n.pathEncoding.
If empty, no re-encoding of path names is done.

Add t3911 to test encoding back and forth

The re-encoding is done in compat/reencode_pathname.c,
where all file system functions like open(), stat(),
readdir() are re-defined.

reencode_pathname.c includes all functionality from
precompose_utf8.c, which should be removed

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
Please read this as an RFC, so there several limitations:

 compat/reencode_pathname.h defines struct dirent_psx with d_name[2].
   This is done to test renc_pn_readdir() in compat/reencode_pathname.c

 test case t1450 failes even on one of my linux machines. At first glan=
ce
  it looks as the same failure which has been sometimes observed on Mac=
 OS X.

 compat/precompose_utf8.[ch] had been integrated into reencode_pathname=
=2E[ch],
  and should be removed.

 The patch should work on v7.1.12, it's not tested against latest maste=
r=20

 Comments are welcome.


 Documentation/config.txt      |  10 +
 Makefile                      |  11 +-
 builtin/init-db.c             |   3 +
 cache.h                       |   1 +
 compat/reencode_pathname.c    | 441 ++++++++++++++++++++++++++++++++++=
++++++++
 compat/reencode_pathname.h    |  72 +++++++
 config.c                      |   3 +
 environment.c                 |   1 +
 git-compat-util.h             |  20 +-
 parse-options.c               |   2 +-
 t/t3911-i18n-filename-8859.sh | 251 ++++++++++++++++++++++++
 wt-status.c                   |  21 +-
 12 files changed, 827 insertions(+), 9 deletions(-)
 create mode 100644 compat/reencode_pathname.c
 create mode 100644 compat/reencode_pathname.h
 create mode 100755 t/t3911-i18n-filename-8859.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index a95e5a4..d633d54 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1442,6 +1442,16 @@ i18n.logOutputEncoding::
 	Character encoding the commit messages are converted to when
 	running 'git log' and friends.
=20
+i18n.pathEncoding::
+	This option is only used by some implementations of git.
+	When "git init" sets core.supportspathencoding to true,
+	i18n.pathEncoding can be set to re-encode path names when
+	a working tree is checked out.
+	Path names may be e.g. encoded in ISO-8859-1 and are stored as
+	UTF-8 encoded in the repository.
+	When not set, the encoding of path names is the same in working tree
+	and the repository.
+
 imap::
 	The configuration variables in the 'imap' section are described
 	in linkgit:git-imap-send[1].
diff --git a/Makefile b/Makefile
index 6b0c961..141562e 100644
--- a/Makefile
+++ b/Makefile
@@ -143,6 +143,9 @@ all::
 #
 # Define NEEDS_LIBICONV if linking with libc is not enough (Darwin).
 #
+# Define PATH_ENCODING if the encoding of file names
+# differs from the encoding in the git repo
+#
 # Define NEEDS_SOCKET if linking with libc is not enough (SunOS,
 # Patrick Mauritz).
 #
@@ -595,6 +598,7 @@ LIB_H +=3D compat/bswap.h
 LIB_H +=3D compat/cygwin.h
 LIB_H +=3D compat/mingw.h
 LIB_H +=3D compat/obstack.h
+LIB_H +=3D compat/reencode_pathname.h
 LIB_H +=3D compat/precompose_utf8.h
 LIB_H +=3D compat/terminal.h
 LIB_H +=3D compat/win32/dirent.h
@@ -932,6 +936,7 @@ ifeq ($(uname_S),OSF1)
 	NO_NSEC =3D YesPlease
 endif
 ifeq ($(uname_S),Linux)
+	PATH_ENCODING =3D YesPlease
 	NO_STRLCPY =3D YesPlease
 	NO_MKSTEMPS =3D YesPlease
 	HAVE_PATHS_H =3D YesPlease
@@ -999,7 +1004,7 @@ ifeq ($(uname_S),Darwin)
 	NO_MEMMEM =3D YesPlease
 	USE_ST_TIMESPEC =3D YesPlease
 	HAVE_DEV_TTY =3D YesPlease
-	COMPAT_OBJS +=3D compat/precompose_utf8.o
+	COMPAT_OBJS +=3D compat/reencode_pathname.o
 	BASIC_CFLAGS +=3D -DPRECOMPOSE_UNICODE
 endif
 ifeq ($(uname_S),SunOS)
@@ -1591,6 +1596,10 @@ ifdef FREAD_READS_DIRECTORIES
 	COMPAT_CFLAGS +=3D -DFREAD_READS_DIRECTORIES
 	COMPAT_OBJS +=3D compat/fopen.o
 endif
+ifdef PATH_ENCODING
+	COMPAT_CFLAGS +=3D -DPATH_ENCODING
+	COMPAT_OBJS +=3D compat/reencode_pathname.o
+endif
 ifdef NO_SYMLINK_HEAD
 	BASIC_CFLAGS +=3D -DNO_SYMLINK_HEAD
 endif
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 244fb7f..f159d43 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -291,6 +291,9 @@ static int create_default_files(const char *templat=
e_path)
 		if (!access(path, F_OK))
 			git_config_set("core.ignorecase", "true");
 		probe_utf8_pathname_composition(path, len);
+#ifdef PATH_ENCODING
+		git_config_set("core.supportspathencoding", "true");
+#endif
 	}
=20
 	return reinit;
diff --git a/cache.h b/cache.h
index 67f28b4..8023767 100644
--- a/cache.h
+++ b/cache.h
@@ -1160,6 +1160,7 @@ extern int user_ident_sufficiently_given(void);
 extern const char *git_commit_encoding;
 extern const char *git_log_output_encoding;
 extern const char *git_mailmap_file;
+extern const char *wt_path_encoding;
=20
 /* IO helper functions */
 extern void maybe_flush_or_die(FILE *, const char *);
diff --git a/compat/reencode_pathname.c b/compat/reencode_pathname.c
new file mode 100644
index 0000000..3bdc776
--- /dev/null
+++ b/compat/reencode_pathname.c
@@ -0,0 +1,441 @@
+/*
+ * Converts pathnames from one encoding into another.
+ * The pathnames are stored as UTF-8 in the repository,
+ * and might be checkout out as e.g. ISO-8859-1 in the working tree
+ *
+ * On MacOS X decomposed unicode is converted into precomposed unicode=
=2E
+ */
+
+#define REENCODE_PATHNAME_C
+#include "cache.h"
+#include "utf8.h"
+#include "reencode_pathname.h"
+
+#if defined(OLD_ICONV) || (defined(__sun__) && !defined(_XPG6))
+	typedef const char *iconv_ibp;
+#else
+	typedef char *iconv_ibp;
+#endif
+
+const static char *repo_path_encoding =3D "UTF-8";
+
+static iconv_t iconv_open_or_die(const char *tocode, const char *fromc=
ode)
+{
+	iconv_t my_iconv;
+	my_iconv =3D iconv_open(tocode, fromcode);
+	if (my_iconv =3D=3D (iconv_t) -1)
+		die_errno(_("iconv_open(%s,%s) failed"), tocode, fromcode);
+	return my_iconv;
+}
+
+static size_t has_non_ascii(const char *s, size_t maxlen, size_t *strl=
en_c)
+{
+	const uint8_t *ptr =3D (const uint8_t *)s;
+	size_t strlen_chars =3D 0;
+	size_t ret =3D 0;
+
+	if (!ptr || !*ptr)
+		return 0;
+
+	while (*ptr && maxlen) {
+		if (*ptr & 0x80)
+			ret++;
+		strlen_chars++;
+		ptr++;
+		maxlen--;
+	}
+	if (strlen_c)
+		*strlen_c =3D strlen_chars;
+
+	return ret;
+}
+
+#ifdef PRECOMPOSE_UNICODE
+void probe_utf8_pathname_composition(char *path, int len)
+{
+	static const char *auml_nfc =3D "\xc3\xa4";
+	static const char *auml_nfd =3D "\x61\xcc\x88";
+	int output_fd;
+	if (precomposed_unicode !=3D -1)
+		return; /* We found it defined in the global config, respect it */
+	strcpy(path + len, auml_nfc);
+	output_fd =3D open(path, O_CREAT|O_EXCL|O_RDWR, 0600);
+	if (output_fd >=3D 0) {
+		close(output_fd);
+		strcpy(path + len, auml_nfd);
+		/* Indicate to the user, that we can configure it to true */
+		if (!access(path, R_OK))
+			git_config_set("core.precomposeunicode", "false");
+		/* To be backward compatible, set precomposed_unicode to 0 */
+		precomposed_unicode =3D 0;
+		strcpy(path + len, auml_nfc);
+		if (unlink(path))
+			die_errno(_("failed to unlink '%s'"), path);
+	}
+}
+#endif
+
+void reencode_argv(int argc, const char **argv)
+{
+	int i =3D 0;
+	const char *oldarg;
+	char *newarg;
+	iconv_t ic_wt_to_repo;
+
+#ifdef PRECOMPOSE_UNICODE
+	if (precomposed_unicode =3D=3D 1)
+		wt_path_encoding =3D "UTF-8-MAC";
+#endif
+
+	if (!wt_path_encoding || !*wt_path_encoding)
+		return;
+
+	ic_wt_to_repo =3D iconv_open_or_die(repo_path_encoding, wt_path_encod=
ing);
+
+	while (i < argc) {
+		size_t namelen;
+		oldarg =3D argv[i];
+		if (has_non_ascii(oldarg, (size_t)-1, &namelen)) {
+			newarg =3D reencode_string_iconv(oldarg, namelen, ic_wt_to_repo);
+			if (newarg)
+				argv[i] =3D newarg;
+		}
+		i++;
+	}
+	iconv_close(ic_wt_to_repo);
+}
+
+#ifdef PATH_ENCODING
+char *str_repo2worktree(const char *in)
+{
+	int olderrno =3D errno;
+	char *retvalue =3D NULL;
+	size_t inlen;
+
+	if (!wt_path_encoding || !*wt_path_encoding)
+		return NULL;
+
+	if (!in)
+		die("str_repo2worktree in =3D=3D NULL\n");
+
+	if (has_non_ascii(in, (size_t)-1, &inlen)) {
+		iconv_t my_iconv_repo2worktree;
+		my_iconv_repo2worktree =3D iconv_open_or_die(wt_path_encoding,
+																							 repo_path_encoding);
+
+		retvalue =3D reencode_string_iconv(in, inlen, my_iconv_repo2worktree=
);
+		iconv_close(my_iconv_repo2worktree);
+		if (retvalue)
+			errno =3D olderrno;
+	} else
+		errno =3D olderrno;
+
+	return retvalue;
+}
+
+char *str_worktree2repolen(const char *in, size_t insz)
+{
+	char *retvalue =3D NULL;
+	size_t inlen;
+	if (!wt_path_encoding || !*wt_path_encoding)
+		return NULL;
+
+	if (has_non_ascii(in, insz, &inlen)) {
+	int olderrno =3D errno;
+		iconv_t my_iconv_worktree2repo;
+		my_iconv_worktree2repo =3D iconv_open_or_die(repo_path_encoding,
+																							 wt_path_encoding);
+		retvalue =3D reencode_string_iconv(in, insz, my_iconv_worktree2repo)=
;
+		iconv_close(my_iconv_worktree2repo);
+		if (retvalue)
+			errno =3D olderrno;
+	}
+	return retvalue;
+}
+
+char *str_worktree2repo(const char *in)
+{
+	return str_worktree2repolen(in, strlen(in));
+}
+#endif
+
+#define RENC_PN_DECL_SAVERRNO_PATH1(path) \
+	int olderrno =3D errno; \
+	const char *path1_enc =3D path; \
+	char *path1_malloc_wt_encoded =3D NULL
+
+#define RENC_PN_DECL_PATH2(path) \
+	const char *path2_enc =3D path; \
+	char *path2_malloc_wt_encoded =3D NULL
+
+
+#define RENC_PN_CONV_PATH1(path, erroret) \
+	errno=3D0; \
+	path1_malloc_wt_encoded =3D str_repo2worktree(path); \
+	if (!path1_malloc_wt_encoded && errno) { \
+		return erroret; \
+	} \
+	if (path1_malloc_wt_encoded) \
+		path1_enc =3D path1_malloc_wt_encoded; \
+	errno =3D olderrno;
+
+#define RENC_PN_CONV_PATH2(path) \
+	errno=3D0; \
+	path2_malloc_wt_encoded =3D str_repo2worktree(path); \
+	if (!path2_malloc_wt_encoded && errno) { \
+		return -1; \
+	} \
+	if (path2_malloc_wt_encoded) \
+		path2_enc =3D path2_malloc_wt_encoded; \
+	errno =3D olderrno;
+
+
+RENC_FN_DIR *renc_pn_opendir(const char *dirname)
+{
+	RENC_PN_DECL_SAVERRNO_PATH1(dirname);
+	RENC_FN_DIR *renc_pn_dir =3D xmalloc(sizeof(RENC_FN_DIR));
+
+#ifdef PRECOMPOSE_UNICODE
+	if (precomposed_unicode =3D=3D 1)
+		wt_path_encoding =3D "UTF-8-MAC";
+#endif
+
+	renc_pn_dir->dirent_utf8 =3D xmalloc(sizeof(dirent_psx));
+	renc_pn_dir->dirent_utf8->max_name_len =3D sizeof(renc_pn_dir->dirent=
_utf8->d_name);
+
+	RENC_PN_CONV_PATH1(dirname, NULL);
+
+	renc_pn_dir->dirp =3D opendir(path1_enc);
+	olderrno =3D errno;
+	if (!renc_pn_dir->dirp) {
+		free(path1_malloc_wt_encoded);
+		free(renc_pn_dir->dirent_utf8);
+		free(renc_pn_dir);
+		return NULL;
+	} else
+		renc_pn_dir->ic_wt_to_repo =3D (iconv_t)-1;
+
+	free(path1_malloc_wt_encoded);
+	errno =3D olderrno;
+	return renc_pn_dir;
+}
+
+struct dirent_psx *renc_pn_readdir(RENC_FN_DIR *renc_pn_dir)
+{
+	struct dirent *res;
+	res =3D readdir(renc_pn_dir->dirp);
+	if (res) {
+		size_t namelenz =3D strlen(res->d_name) + 1; /* \0 */
+		size_t new_len_needed =3D 0;
+		int ret_errno =3D errno;
+
+		renc_pn_dir->dirent_utf8->d_ino	 =3D res->d_ino;
+		renc_pn_dir->dirent_utf8->d_type =3D res->d_type;
+	do {
+		 if (new_len_needed > renc_pn_dir->dirent_utf8->max_name_len) {
+				size_t new_len =3D sizeof(dirent_psx) + new_len_needed -
+					sizeof(renc_pn_dir->dirent_utf8->d_name);
+
+				renc_pn_dir->dirent_utf8 =3D xrealloc(renc_pn_dir->dirent_utf8, ne=
w_len);
+				renc_pn_dir->dirent_utf8->max_name_len =3D new_len_needed;
+			}
+
+			if (wt_path_encoding && has_non_ascii(res->d_name, (size_t)-1, NULL=
)) {
+				iconv_ibp cp =3D (iconv_ibp)res->d_name;
+				size_t inleft =3D namelenz;
+				char *outpos =3D &renc_pn_dir->dirent_utf8->d_name[0];
+				size_t outsz =3D renc_pn_dir->dirent_utf8->max_name_len;
+				errno =3D 0;
+				if (renc_pn_dir->ic_wt_to_repo =3D=3D (iconv_t)-1)
+					renc_pn_dir->ic_wt_to_repo =3D iconv_open_or_die(repo_path_encodi=
ng,
+																												 wt_path_encoding);
+				if (-1 !=3D iconv(renc_pn_dir->ic_wt_to_repo,
+												&cp, &inleft,	&outpos, &outsz))
+					break; /* Conversion OK, we are done */
+				if (errno =3D=3D E2BIG) {
+					char *tmp =3D reencode_string_iconv(res->d_name, namelenz,
+																						renc_pn_dir->ic_wt_to_repo);
+					if (tmp) {
+						new_len_needed =3D strlen(tmp) + 1; /* \0 */
+						free(tmp);
+					}
+				} else {
+					/*
+					 * iconv() failed and errno could be EILSEQ, EINVAL, EBADF
+					 * In general we avoid illegal byte sequences.
+					 * If they occur on a mounted drive (e.g. NFS) it is not worth to
+					 * die() for that, but rather let the user see the original name
+					 */
+					namelenz =3D 0; /* trigger strlcpy */
+				}
+			} else {
+				if (namelenz > renc_pn_dir->dirent_utf8->max_name_len)
+					new_len_needed =3D namelenz; /* need to re-allocate */
+				else
+					namelenz =3D 0;	 /* trigger strlcpy */
+			}
+		} while (new_len_needed > renc_pn_dir->dirent_utf8->max_name_len);
+
+		if (!namelenz)
+			strlcpy(renc_pn_dir->dirent_utf8->d_name, res->d_name,
+							renc_pn_dir->dirent_utf8->max_name_len);
+
+		errno =3D ret_errno;
+		return renc_pn_dir->dirent_utf8;
+	}
+	return NULL;
+}
+
+int renc_pn_closedir(RENC_FN_DIR *renc_pn_dir)
+{
+	int ret_value;
+	int ret_errno;
+	ret_value =3D closedir(renc_pn_dir->dirp);
+	ret_errno =3D errno;
+	if (renc_pn_dir->ic_wt_to_repo !=3D (iconv_t)-1)
+		iconv_close(renc_pn_dir->ic_wt_to_repo);
+	free(renc_pn_dir->dirent_utf8);
+	free(renc_pn_dir);
+	errno =3D ret_errno;
+	return ret_value;
+}
+
+int renc_pn_mkdir(const char *path, mode_t mode)
+{
+	RENC_PN_DECL_SAVERRNO_PATH1(path);
+	int ret;
+
+	RENC_PN_CONV_PATH1(path, -1);
+
+	ret =3D mkdir(path1_enc, mode);
+	free(path1_malloc_wt_encoded);
+	return ret;
+}
+
+int renc_pn_lstat(const char *path, struct stat *buf)
+{
+	RENC_PN_DECL_SAVERRNO_PATH1(path);
+	int ret;
+
+	RENC_PN_CONV_PATH1(path, -1);
+
+	ret =3D lstat(path1_enc, buf);
+
+	free(path1_malloc_wt_encoded);
+	return ret;
+}
+
+int renc_pn_stat(const char *path, struct stat *buf)
+{
+	RENC_PN_DECL_SAVERRNO_PATH1(path);
+	int ret;
+
+	RENC_PN_CONV_PATH1(path, -1);
+
+	ret =3D stat(path1_enc, buf);
+
+	free(path1_malloc_wt_encoded);
+	return ret;
+}
+
+int renc_pn_open(const char *path, int oflag, ...	 )
+{
+	RENC_PN_DECL_SAVERRNO_PATH1(path);
+	va_list params;
+	int mode;
+	int ret;
+
+	va_start(params, oflag);
+	mode =3D va_arg(params, int);
+	va_end(params);
+
+	RENC_PN_CONV_PATH1(path, -1);
+
+	ret =3D open(path1_enc, oflag, mode);
+
+	free(path1_malloc_wt_encoded);
+	return ret;
+}
+
+int renc_pn_unlink(const char *path)
+{
+	RENC_PN_DECL_SAVERRNO_PATH1(path);
+	int ret;
+
+	RENC_PN_CONV_PATH1(path, -1);
+
+	ret =3D unlink(path1_enc);
+	free(path1_malloc_wt_encoded);
+	return ret;
+}
+
+FILE *renc_pn_fopen(const char *path, const char *mode)
+{
+	RENC_PN_DECL_SAVERRNO_PATH1(path);
+	FILE *ret;
+
+	RENC_PN_CONV_PATH1(path,NULL);
+
+	ret =3D fopen(path1_enc,mode);
+	free(path1_malloc_wt_encoded);
+	return ret;
+}
+
+
+ssize_t renc_pn_readlink(const char *path, char *buf, size_t bufsiz)
+{
+	RENC_PN_DECL_SAVERRNO_PATH1(path);
+	ssize_t ret;
+
+	RENC_PN_CONV_PATH1(path, -1);
+
+	ret =3D readlink(path1_enc, buf, bufsiz);
+
+	if (ret > 0) {
+		char *new_buf =3D NULL;
+		errno =3D 0;
+		new_buf =3D str_worktree2repolen(buf, ret);
+		if (new_buf) {
+			size_t newlen =3D strlen(new_buf);
+			if (newlen > bufsiz)
+				newlen =3D bufsiz;
+			memcpy(buf, new_buf, newlen);
+			ret =3D newlen;
+			free(new_buf);
+		} else if (!errno)
+			errno =3D olderrno;
+	}
+	free(path1_malloc_wt_encoded);
+	return ret;
+}
+
+int renc_pn_symlink(const char *oldname, const char *newname)
+{
+	RENC_PN_DECL_SAVERRNO_PATH1(oldname);
+	RENC_PN_DECL_PATH2(newname);
+	int ret;
+
+	RENC_PN_CONV_PATH1(oldname, -1);
+	RENC_PN_CONV_PATH2(newname);
+
+	ret =3D symlink(path1_enc, path2_enc);
+	free(path1_malloc_wt_encoded);
+	free(path2_malloc_wt_encoded);
+	return ret;
+}
+
+int renc_pn_rename(const char *oldname, const char *newname)
+{
+	RENC_PN_DECL_SAVERRNO_PATH1(oldname);
+	RENC_PN_DECL_PATH2(newname);
+	int ret;
+
+	RENC_PN_CONV_PATH1(oldname, -1);
+	RENC_PN_CONV_PATH2(newname);
+
+	ret =3D rename(path1_enc, path2_enc);
+	free(path1_malloc_wt_encoded);
+	free(path2_malloc_wt_encoded);
+
+	return ret;
+}
diff --git a/compat/reencode_pathname.h b/compat/reencode_pathname.h
new file mode 100644
index 0000000..9300ba4
--- /dev/null
+++ b/compat/reencode_pathname.h
@@ -0,0 +1,70 @@
+#ifndef REENCODE_PATHNAME_H
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <dirent.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <iconv.h>
+
+typedef struct dirent_psx {
+	ino_t d_ino;            /* Posix */
+	size_t max_name_len;    /* See below */
+	unsigned char d_type;   /* available on all systems git runs on */
+
+	/*
+	 * See http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/diren=
t.h.html
+	 * NAME_MAX + 1 should be enough, but some systems have
+	 * NAME_MAX=3D255 and strlen(d_name) may return 508 or 510
+	 * Solution: allocate more when needed, see renc_pn_readdir()
+	 */
+	char   d_name[/* NAME_MAX */ 1+1];
+} dirent_psx;
+
+typedef struct {
+	iconv_t ic_wt_to_repo;
+	DIR *dirp;
+	struct dirent_psx *dirent_utf8;
+} RENC_FN_DIR;
+
+void reencode_argv(int argc, const char **argv);
+void probe_utf8_pathname_composition(char *, int);
+
+RENC_FN_DIR *renc_pn_opendir(const char *dirname);
+struct dirent_psx *renc_pn_readdir(RENC_FN_DIR *dirp);
+int renc_pn_closedir(RENC_FN_DIR *dirp);
+
+#ifdef PATH_ENCODING
+char* str_repo2worktree(const char *in);
+int renc_pn_mkdir(const char *path, mode_t mode);
+int renc_pn_lstat(const char *path, struct stat *buf);
+int renc_pn_stat(const char *path, struct stat *buf);
+int renc_pn_open(const char *path, int oflag, ...  );
+int renc_pn_unlink(const char *path);
+FILE *renc_pn_fopen(const char *path, const char *mode);
+ssize_t renc_pn_readlink(const char *path, char *buf, size_t bufsiz);
+int renc_pn_symlink(const char *oldname, const char *newname);
+int renc_pn_rename(const char *oldname, const char *newname);
+#endif
+
+#ifndef REENCODE_PATHNAME_C
+#define opendir(n) renc_pn_opendir(n)
+#define readdir(d) renc_pn_readdir(d)
+#define closedir(d) renc_pn_closedir(d)
+#define dirent dirent_psx
+#define DIR RENC_FN_DIR
+
+#ifdef PATH_ENCODING
+#define mkdir(a,b) renc_pn_mkdir((a),(b))
+#define lstat(a,b) renc_pn_lstat((a),(b))
+#define stat(a,b) renc_pn_stat((a),(b))
+#define open renc_pn_open
+#define unlink renc_pn_unlink
+#define fopen(a,b) renc_pn_fopen((a),(b))
+#define readlink(a,b,c) renc_pn_readlink(a,b,c)
+#define symlink(a,b) renc_pn_symlink(a,b)
+#define rename(a,b) renc_pn_rename(a,b)
+#endif
+
+#endif  /* REENCODE_PATHNAME_C */
+#define  REENCODE_PATHNAME_H
+#endif /* REENCODE_PATHNAME_H */
diff --git a/config.c b/config.c
index 2b706ea..d591c09 100644
--- a/config.c
+++ b/config.c
@@ -775,6 +775,9 @@ static int git_default_i18n_config(const char *var,=
 const char *value)
 	if (!strcmp(var, "i18n.logoutputencoding"))
 		return git_config_string(&git_log_output_encoding, var, value);
=20
+	if (!strcmp(var, "i18n.pathencoding"))
+		return git_config_string(&wt_path_encoding, var, value);
+
 	/* Add other config variables here and to Documentation/config.txt. *=
/
 	return 0;
 }
diff --git a/environment.c b/environment.c
index 85edd7f..ba81575 100644
--- a/environment.c
+++ b/environment.c
@@ -59,6 +59,7 @@ int grafts_replace_parents =3D 1;
 int core_apply_sparse_checkout;
 int merge_log_config =3D -1;
 int precomposed_unicode =3D -1; /* see probe_utf8_pathname_composition=
() */
+const char *wt_path_encoding =3D NULL;
 struct startup_info *startup_info;
 unsigned long pack_size_limit_cfg;
=20
diff --git a/git-compat-util.h b/git-compat-util.h
index 35b095e..877b060 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -153,13 +153,21 @@
 #endif
 #endif
=20
-/* used on Mac OS X */
-#ifdef PRECOMPOSE_UNICODE
-#include "compat/precompose_utf8.h"
+#if defined(PATH_ENCODING) || defined(PRECOMPOSE_UNICODE)
+#include "compat/reencode_pathname.h"
 #else
-#define precompose_str(in,i_nfd2nfc)
-#define precompose_argv(c,v)
-#define probe_utf8_pathname_composition(a,b)
+#define reencode_argv(c,v)
+#endif
+
+/* needed for Mac OS X */
+#ifndef PRECOMPOSE_UNICODE
+#define probe_utf8_pathname_composition(a,b);
+#endif
+
+#ifndef PATH_ENCODING
+#define str_worktree2repolen(in, insz) (NULL)
+#define str_repo2worktree(in) (NULL)
+#define str_worktree2repo(in) (NULL)
 #endif
=20
 #ifndef NO_LIBGEN_H
diff --git a/parse-options.c b/parse-options.c
index c1c66bd..5840c18 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -476,7 +476,7 @@ int parse_options(int argc, const char **argv, cons=
t char *prefix,
 		usage_with_options(usagestr, options);
 	}
=20
-	precompose_argv(argc, argv);
+	reencode_argv(argc, argv);
 	return parse_options_end(&ctx);
 }
=20
diff --git a/t/t3911-i18n-filename-8859.sh b/t/t3911-i18n-filename-8859=
=2Esh
new file mode 100755
index 0000000..aa2be57
--- /dev/null
+++ b/t/t3911-i18n-filename-8859.sh
@@ -0,0 +1,251 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Torsten B=C3=B6gershausen
+#
+
+test_description=3D'file system encodings UTF-8 ISO8859-1'
+
+. ./test-lib.sh
+
+fname_UTF_8=3D`printf '\303\206\302\242'`
+fname_ISO8859_1=3D`printf '\306\242'`
+Euro_utf8=3D`printf '\342\202\254'`
+supportspathencoding=3D`git config core.supportspathencoding` || :
+
+
+add_file_dir_link() {
+	local bname=3D$1
+	local fname=3D$2
+	test_expect_success "add file $fname.f $bname" '
+		git checkout master &&
+		git checkout -b add_f_$bname &&
+		>$fname.f &&
+		git add $fname.f &&
+		git commit -m "add fname"
+	'
+
+	test_expect_success "add dir $fname.d $bname" '
+		git checkout master &&
+		git checkout -b add_d_$bname &&
+		mkdir $fname.d &&
+		touch $fname.d/$fname.f &&
+		git add $fname.d/$fname.f &&
+		git commit -m "add fname.d/fname"
+	'
+
+	i=3D0
+	for src in x $fname; do
+		for dst in x $fname; do
+			test_expect_success "add link $dst.l->$src.f on branch add_l_${i}_$=
bname" '
+				git checkout master &&
+				git checkout -b add_l_${i}_$bname &&
+				ln -s $src.f $dst.l &&
+				git add $dst.l &&
+				git commit -m "add fname.l $i"
+			'
+			i=3D$(($i+1))
+		done
+	done
+}
+
+test_expect_success "setup add rm x" '
+	>x &&
+	git add x &&
+	git commit -m "1st commit" &&
+	git rm x &&
+	git commit -m "rm x"
+'
+
+#combinations to be tested:
+# UTF-8     -> ISO8859-1
+# ISO8859-1 -> UTF-8
+
+if test "$supportspathencoding"
+then
+	srcencodings=3D"ISO8859-1 UTF-8"
+	for srcenc in $srcencodings
+	do
+		case $srcenc in
+		ISO8859-1)
+			dstenc=3DUTF-8
+		;;
+		UTF-8)
+			dstenc=3DISO8859-1
+		;;
+		UTF-8-MAC)
+			dstenc=3DUTF-8
+		;;
+		*)
+			echo >&2 "Wrong encoding $srcenc"
+			exit 1
+		;;
+		esac
+		eval fname_src=3D\$fname_$(echo $srcenc | sed -e 's/-/_/g' -e 's/_MA=
C//')
+		eval fname_dst=3D\$fname_$(echo $dstenc | sed -e 's/-/_/g')
+		test_expect_success "setup $srcenc" '
+			git checkout master &&
+			git config i18n.pathencoding $srcenc
+		'
+		add_file_dir_link $srcenc $fname_src
+
+		test_expect_success "setup $dstenc" '
+			git checkout master &&
+			echo "git checkout Master" >&2
+			ls -l >&2
+			git config i18n.pathencoding $dstenc
+		'
+
+		test_expect_success "checkout file $dstenc (was $srcenc)" '
+			git checkout add_f_$srcenc
+		'
+
+		test_expect_success "exists file $dstenc (was $srcenc)" '
+			test -f $fname_dst.f
+		'
+
+		test_expect_success "log file $dstenc (was $srcenc)" '
+			git log $fname_dst.f
+		'
+
+		test_expect_success "git mv" '
+			git checkout -b mv_file_$srcenc &&
+			git mv $fname_dst.f XX.f &&
+			git commit -m "git mv fname_dst.f XX.f"
+		'
+
+		test_expect_success "checkout dir $dstenc (was $srcenc)" '
+			git checkout add_d_$srcenc
+		'
+
+		test_expect_success "exist dir $dstenc (was $srcenc)" '
+			test -d $fname_dst.d
+		'
+
+		test_expect_success "log dir $dstenc (was $srcenc)" '
+			git log $fname_dst.d
+		'
+
+		i=3D0
+		for src in x $fname_dst; do
+			for dst in x $fname_dst; do
+				test_expect_success "checkout link $dst.l->$src.f branch add_l_${i=
}_$srcenc" '
+					git checkout add_l_${i}_$srcenc
+				'
+				test_expect_success "exist link $dst.l->$src.f branch add_l_${i}_$=
srcenc" '
+					test -L $dst.l
+				'
+				test_expect_success "log link $dst.l->$src.f branch add_l_${i}_$sr=
cenc" '
+					git log $dst.l
+				'
+				test_expect_success "readlink $dst.l->$src.f branch add_l_${i}_$sr=
cenc" '
+					echo "$src.f" >expect &&
+					readlink "$dst.l" > actual &&
+					test_cmp expect actual &&
+					rm expect actual
+				'
+				i=3D$(($i+1))
+			done
+		done
+	done
+	# Make sure that Euro sign can NOT be checked out in 8859
+	#fname_src=3DEuro
+	test_expect_success "setup UTF-8" '
+		git checkout master &&
+		git config i18n.pathencoding UTF-8
+	'
+	add_file_dir_link Euro $Euro_utf8
+
+	test_expect_success "setup ISO8859-1" '
+		git checkout master &&
+		rm -rf * &&
+		git config i18n.pathencoding ISO8859-1
+	'
+	test_expect_success "checkout file Euro branch add_f_Euro" '
+		git checkout add_f_Euro
+		echo *  >actual &&
+		echo "*" >expect &&
+		test_cmp expect actual &&
+		rm expect actual
+	'
+
+	test_expect_success "checkout dir Euro branch add_d_Euro" '
+		rm -rf * &&
+		test_must_fail git checkout add_d_Euro
+	'
+
+	test_expect_success "Cleanup" '
+		git config i18n.pathencoding UTF-8 &&
+		git checkout master &&
+		rm -rf * &&
+		git reset --hard &&
+		git config i18n.pathencoding ISO8859-1
+	'
+
+	test_expect_success "checkout link Euro.l->x.f branch add_l_1_Euro" '
+		! git checkout add_l_1_Euro
+	'
+
+	test_expect_success "No link Euro.l->x.f" '
+		echo *  >actual &&
+		echo "*" >expect &&
+		test_cmp expect actual &&
+		rm expect actual
+	'
+
+	test_expect_success "Cleanup after Euro.l->x.f" '
+		git config i18n.pathencoding UTF-8 &&
+		git checkout master &&
+		rm -rf * &&
+		git reset --hard &&
+		git config i18n.pathencoding ISO8859-1
+	'
+
+	# Checkoing out a soft link pointing to a filename outside
+	# 8859-1 should fail
+	test_expect_failure "checkout link x.l->Euro.f branch add_l_2_Euro" '
+		! git checkout add_l_2_Euro
+	'
+
+	test_expect_success "No link x.f->Euro.l" '
+		echo *  >actual &&
+		echo "*" >expect &&
+		test_cmp expect actual &&
+		rm expect actual
+	'
+
+	test_expect_success "Cleanup after link x.l->Euro.f branch" '
+		git config i18n.pathencoding UTF-8 &&
+		git checkout master &&
+		rm -rf * &&
+		git reset --hard &&
+		git config i18n.pathencoding ISO8859-1
+	'
+
+	test_expect_success "checkout link Euro.l->Euro.f branch add_l_3_Euro=
" '
+		! git checkout add_l_3_Euro
+	'
+
+	test_expect_success "No link Euro.l->Euro.f" '
+		echo *  >actual &&
+		echo "*" >expect &&
+		test_cmp expect actual &&
+		rm expect actual
+	'
+
+else
+	test_expect_success "setup 8859" '
+		git config i18n.pathencoding ISO8859-1 &&
+		git checkout -b add_file_8859 &&
+		> $fname_src.f &&
+		git add $fname_src.f &&
+		git commit -m "add fname_src" &&
+		git config i18n.pathencoding UTF-8 &&
+		rm -rf * &&
+		git reset --hard
+	'
+	test_expect_success "Silent support of pathencoding" '
+		test_must_fail test -f $fname_UTF_8.f
+	'
+fi
+
+test_done
diff --git a/wt-status.c b/wt-status.c
index c110cbc..1590caa 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -233,7 +233,26 @@ static void wt_status_print_trailer(struct wt_stat=
us *s)
 	status_printf_ln(s, color(WT_STATUS_HEADER, s), "");
 }
=20
-#define quote_path quote_path_relative
+#ifdef PATH_ENCODING
+char *quote_path_repo2worktree(const char *in, int len,
+			  struct strbuf *out, const char *prefix)
+{
+	const char *in_encoded =3D in;
+	char *in_worktree_encoded =3D str_repo2worktree(in);
+	char *ret;
+	(void)len;
+
+	if (in_worktree_encoded)
+		in_encoded =3D in_worktree_encoded;
+	ret =3D quote_path_relative(in_encoded , -1, out, prefix);
+	free(in_worktree_encoded);
+	return ret;
+
+}
+	#define quote_path quote_path_repo2worktree
+#else
+	#define quote_path quote_path_relative
+#endif
=20
 static void wt_status_print_unmerged_data(struct wt_status *s,
 					  struct string_list_item *it)
--=20
1.7.12
