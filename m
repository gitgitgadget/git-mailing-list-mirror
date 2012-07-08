From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v8] git on Mac OS and precomposed unicode
Date: Sun, 8 Jul 2012 15:02:09 +0200
Message-ID: <201207081502.10424.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 08 15:02:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Snr8Q-0003zE-3g
	for gcvg-git-2@plane.gmane.org; Sun, 08 Jul 2012 15:02:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650Ab2GHNCc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Jul 2012 09:02:32 -0400
Received: from mout.web.de ([212.227.15.3]:63230 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751615Ab2GHNC3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Jul 2012 09:02:29 -0400
Received: from appes.localnet ([194.22.188.61]) by smtp.web.de (mrweb101) with
 ESMTPA (Nemesis) id 0Md4xS-1SWsTY1wxO-00IgHm; Sun, 08 Jul 2012 15:02:26 +0200
X-Provags-ID: V02:K0:3Dt+sh7T6uxgI6ABt4EJ3uaqPAng+aiFtZJAZ0p7jZz
 4M2wc68XGLRm4YEOKTNU0kPW+iaXNXTRKGV74qgcQ50ewGDf6R
 zqTj4t3je1+vD/6FR//hCsIVmcslCTxGrcxhRot3fxevNg4Vqr
 2tBbXPwsZoVKpuIs4G3O7tCDyqkkVhtB6f3+MYlX9z2GAeVObq
 udApowD8jNv7Mi8MU26lA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201176>

Mac OS X mangles file names containing unicode on file systems HFS+,
VFAT or SAMBA.  When a file using unicode code points outside ASCII
is created on a HFS+ drive, the file name is converted into
decomposed unicode and written to disk. No conversion is done if
the file name is already decomposed unicode.

Calling open("\xc3\x84", ...) with a precomposed "=C3=84" yields the sa=
me
result as open("\x41\xcc\x88",...) with a decomposed "=C3=84".

As a consequence, readdir() returns the file names in decomposed
unicode, even if the user expects precomposed unicode.  Unlike on
HFS+, Mac OS X files on a VFAT drive (e.g. an USB drive), in
precomposed unicode, but readdir() still returns file names in
decomposed unicode.  When a git repository is stored on a network
share using SAMBA, file names are send over the wire and written to
disk on the remote system in precomposed unicode, but Mac OS X
readdir() returns decomposed unicode to be compatible with its
behaviour on HFS+ and VFAT.

The unicode decomposition causes many problems:

- The names "git add" and other commands get from the end user may
  often be precomposed form (the decomposed form is not easily input
  from the keyboard), but when the commands read from the filesystem
  to see what it is going to update the index with already is on the
  filesystem, readdir() will give decomposed form, which is different.

- Similarly "git log", "git mv" and all other commands that need to
  compare pathnames found on the command line (often but not always
  precomposed form; a command line input resulting from globbing may
  be in decomposed) with pathnames found in the tree objects (should
  be precomposed form to be compatible with other systems and for
  consistency in general).

- The same for names stored in the index, which should be
  precomposed, that may need to be compared with the names read from
  readdir().

NFS mounted from Linux is fully transparent and does not suffer from
the above.

As Mac OS X treats precomposed and decomposed file names as equal,
we can

 - wrap readdir() on Mac OS X to return the precomposed form, and

 - normalize decomposed form given from the command line also to the
   precomposed form,

to ensure that all pathnames used in Git are always in the
precomposed form.  This behaviour can be requested by setting
"core.precomposedunicode" configuration variable to true.

The code in compat/precomposed_utf8.c implements basically 4 new
functions: precomposed_utf8_opendir(), precomposed_utf8_readdir(),
precomposed_utf8_closedir() and precompose_argv().  The first three
are to wrap opendir(3), readdir(3), and closedir(3) functions.

The argv[] conversion allows to use the TAB filename completion done
by the shell on command line.  It tolerates other tools which use
readdir() to feed decomposed file names into git.

When creating a new git repository with "git init" or "git clone",
"core.precomposedunicode" will be set "false".

The user needs to activate this feature manually.  She typically
sets core.precomposedunicode to "true" on HFS and VFAT, or file
systems mounted via SAMBA.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---

Thanks to Junio for the comments

Changes since 7v:
 Code is 3% easier to read:
   s/precomposed/precompomsed/
   s/__PRECOMPOSED_UNICODE_[H]C__/PRECOMPOSE_UNICODE_[CH]/

  Documentation/config.txt:
   clarified what happens when core.precomposeunicode =3D=3D false:
    -	When false, file names are handled fully transparent by git, whic=
h means
    -	that file names are stored as decomposed unicode in the repositor=
y.
    +	When false, file names are handled fully transparent by git,
    +	which is backward compatible with older versions of git.
   s/Git for Windows/msysGit 1.7.10/Git for Windows 1.7.10 or higher/

 Documentation/config.txt     |   9 ++
 Makefile                     |   3 +
 builtin/init-db.c            |   1 +
 cache.h                      |   1 +
 compat/precompose_utf8.c     | 190 +++++++++++++++++++++++++++++++++++=
++++++++
 compat/precompose_utf8.h     |  45 ++++++++++
 config.c                     |   5 ++
 environment.c                |   1 +
 git-compat-util.h            |   9 ++
 parse-options.c              |   1 +
 t/t3910-mac-os-precompose.sh | 164 +++++++++++++++++++++++++++++++++++=
++
 utf8.c                       |  26 +++---
 utf8.h                       |   1 +
 13 files changed, 446 insertions(+), 10 deletions(-)
 create mode 100644 compat/precompose_utf8.c
 create mode 100644 compat/precompose_utf8.h
 create mode 100755 t/t3910-mac-os-precompose.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0bcea8a..e6a50fa 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -211,6 +211,15 @@ The default is false, except linkgit:git-clone[1] =
or linkgit:git-init[1]
 will probe and set core.ignorecase true if appropriate when the reposi=
tory
 is created.
=20
+core.precomposeunicode::
+	This option is only used by Mac OS implementation of git.
+	When core.precomposeunicode=3Dtrue, git reverts the unicode decomposi=
tion
+	of filenames done by Mac OS. This is useful when sharing a repository
+	between Mac OS and Linux or Windows.
+	(Git for Windows 1.7.10 or higher is needed, or git under cygwin 1.7)=
=2E
+	When false, file names are handled fully transparent by git,
+	which is backward compatible with older versions of git.
+
 core.trustctime::
 	If false, the ctime differences between the index and the
 	working tree are ignored; useful when the inode change time
diff --git a/Makefile b/Makefile
index cba9f77..d55484f 100644
--- a/Makefile
+++ b/Makefile
@@ -605,6 +605,7 @@ LIB_H +=3D compat/bswap.h
 LIB_H +=3D compat/cygwin.h
 LIB_H +=3D compat/mingw.h
 LIB_H +=3D compat/obstack.h
+LIB_H +=3D compat/precompose_utf8.h
 LIB_H +=3D compat/terminal.h
 LIB_H +=3D compat/win32/dirent.h
 LIB_H +=3D compat/win32/poll.h
@@ -998,6 +999,8 @@ ifeq ($(uname_S),Darwin)
 	NO_MEMMEM =3D YesPlease
 	USE_ST_TIMESPEC =3D YesPlease
 	HAVE_DEV_TTY =3D YesPlease
+	COMPAT_OBJS +=3D compat/precompose_utf8.o
+	BASIC_CFLAGS +=3D -DPRECOMPOSE_UNICODE
 endif
 ifeq ($(uname_S),SunOS)
 	NEEDS_SOCKET =3D YesPlease
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 0dacb8b..244fb7f 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -290,6 +290,7 @@ static int create_default_files(const char *templat=
e_path)
 		strcpy(path + len, "CoNfIg");
 		if (!access(path, F_OK))
 			git_config_set("core.ignorecase", "true");
+		probe_utf8_pathname_composition(path, len);
 	}
=20
 	return reinit;
diff --git a/cache.h b/cache.h
index 506d157..697f0d1 100644
--- a/cache.h
+++ b/cache.h
@@ -562,6 +562,7 @@ extern int read_replace_refs;
 extern int fsync_object_files;
 extern int core_preload_index;
 extern int core_apply_sparse_checkout;
+extern int precomposed_unicode;
=20
 enum branch_track {
 	BRANCH_TRACK_UNSPECIFIED =3D -1,
diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
new file mode 100644
index 0000000..d40d1b3
--- /dev/null
+++ b/compat/precompose_utf8.c
@@ -0,0 +1,190 @@
+/*
+ * Converts filenames from decomposed unicode into precomposed unicode=
=2E
+ * Used on MacOS X.
+*/
+
+
+#define PRECOMPOSE_UNICODE_C
+
+#include "cache.h"
+#include "utf8.h"
+#include "precompose_utf8.h"
+
+typedef char *iconv_ibp;
+const static char *repo_encoding =3D "UTF-8";
+const static char *path_encoding =3D "UTF-8-MAC";
+
+
+static size_t has_utf8(const char *s, size_t maxlen, size_t *strlen_c)
+{
+	const uint8_t *utf8p =3D (const uint8_t*) s;
+	size_t strlen_chars =3D 0;
+	size_t ret =3D 0;
+
+	if ((!utf8p) || (!*utf8p)) {
+		return 0;
+	}
+
+	while((*utf8p) && maxlen) {
+		if (*utf8p & 0x80)
+			ret++;
+		strlen_chars++;
+		utf8p++;
+		maxlen--;
+	}
+	if (strlen_c)
+		*strlen_c =3D strlen_chars;
+
+	return ret;
+}
+
+
+void probe_utf8_pathname_composition(char *path, int len)
+{
+	const static char *auml_nfc =3D "\xc3\xa4";
+	const static char *auml_nfd =3D "\x61\xcc\x88";
+	int output_fd;
+	if (precomposed_unicode !=3D -1)
+		return; /* We found it defined in the global config, respect it */
+	path[len] =3D 0;
+	strcpy(path + len, auml_nfc);
+	output_fd =3D open(path, O_CREAT|O_EXCL|O_RDWR, 0600);
+	if (output_fd >=3D0) {
+		close(output_fd);
+		path[len] =3D 0;
+		strcpy(path + len, auml_nfd);
+		/* Indicate to the user, that we can configure it to true */
+		if (0 =3D=3D access(path, R_OK))
+			git_config_set("core.precomposeunicode", "false");
+			/* To be backward compatible, set precomposed_unicode to 0 */
+		precomposed_unicode =3D 0;
+		path[len] =3D 0;
+		strcpy(path + len, auml_nfc);
+		unlink(path);
+	}
+}
+
+
+void precompose_argv(int argc, const char **argv)
+{
+	int i =3D 0;
+	const char *oldarg;
+	char *newarg;
+	iconv_t ic_precompose;
+
+	if (precomposed_unicode !=3D 1)
+		return;
+
+	ic_precompose =3D iconv_open(repo_encoding, path_encoding);
+	if (ic_precompose =3D=3D (iconv_t) -1)
+		return;
+
+	while (i < argc) {
+		size_t namelen;
+		oldarg =3D argv[i];
+		if (has_utf8(oldarg, (size_t)-1, &namelen)) {
+			newarg =3D reencode_string_iconv(oldarg, namelen, ic_precompose);
+			if (newarg)
+				argv[i] =3D newarg;
+		}
+		i++;
+	}
+	iconv_close(ic_precompose);
+}
+
+
+PREC_DIR *precompose_utf8_opendir(const char *dirname)
+{
+	PREC_DIR *prec_dir =3D xmalloc(sizeof(PREC_DIR));
+	prec_dir->dirent_nfc =3D xmalloc(sizeof(dirent_prec_psx));
+	prec_dir->dirent_nfc->max_name_len =3D sizeof(prec_dir->dirent_nfc->d=
_name);
+
+	prec_dir->dirp =3D opendir(dirname);
+	if (!prec_dir->dirp) {
+		free(prec_dir->dirent_nfc);
+		free(prec_dir);
+		return NULL;
+	} else {
+		int ret_errno =3D errno;
+		prec_dir->ic_precompose =3D iconv_open(repo_encoding, path_encoding)=
;
+		/* if iconv_open() fails, die() in readdir() if needed */
+		errno =3D ret_errno;
+	}
+
+	return prec_dir;
+}
+
+struct dirent_prec_psx *precompose_utf8_readdir(PREC_DIR *prec_dir)
+{
+	struct dirent *res;
+	res =3D readdir(prec_dir->dirp);
+	if (res) {
+		size_t namelenz =3D strlen(res->d_name) + 1; /* \0 */
+		size_t new_maxlen =3D namelenz;
+
+		int ret_errno =3D errno;
+
+		if (new_maxlen > prec_dir->dirent_nfc->max_name_len) {
+			size_t new_len =3D sizeof(dirent_prec_psx) + new_maxlen -
+				sizeof(prec_dir->dirent_nfc->d_name);
+
+			prec_dir->dirent_nfc =3D xrealloc(prec_dir->dirent_nfc, new_len);
+			prec_dir->dirent_nfc->max_name_len =3D new_maxlen;
+		}
+
+		prec_dir->dirent_nfc->d_ino  =3D res->d_ino;
+		prec_dir->dirent_nfc->d_type =3D res->d_type;
+
+		if ((precomposed_unicode =3D=3D 1) && has_utf8(res->d_name, (size_t)=
-1, NULL)) {
+			if (prec_dir->ic_precompose =3D=3D (iconv_t)-1) {
+				die("iconv_open(%s,%s) failed, but needed:\n"
+						"    precomposed unicode is not supported.\n"
+						"    If you wnat to use decomposed unicode, run\n"
+						"    \"git config core.precomposeunicode false\"\n",
+						repo_encoding, path_encoding);
+			} else {
+				iconv_ibp	cp =3D (iconv_ibp)res->d_name;
+				size_t inleft =3D namelenz;
+				char *outpos =3D &prec_dir->dirent_nfc->d_name[0];
+				size_t outsz =3D prec_dir->dirent_nfc->max_name_len;
+				size_t cnt;
+				errno =3D 0;
+				cnt =3D iconv(prec_dir->ic_precompose, &cp, &inleft, &outpos, &out=
sz);
+				if (errno || inleft) {
+					/*
+					 * iconv() failed and errno could be E2BIG, EILSEQ, EINVAL, EBADF
+					 * MacOS X avoids illegal byte sequemces.
+					 * If they occur on a mounted drive (e.g. NFS) it is not worth to
+					 * die() for that, but rather let the user see the original name
+					*/
+					namelenz =3D 0; /* trigger strlcpy */
+				}
+			}
+		}
+		else
+			namelenz =3D 0;
+
+		if (!namelenz)
+			strlcpy(prec_dir->dirent_nfc->d_name, res->d_name,
+							prec_dir->dirent_nfc->max_name_len);
+
+		errno =3D ret_errno;
+		return prec_dir->dirent_nfc;
+	}
+	return NULL;
+}
+
+
+int precompose_utf8_closedir(PREC_DIR *prec_dir)
+{
+	int ret_value;
+	int ret_errno;
+	ret_value =3D closedir(prec_dir->dirp);
+	ret_errno =3D errno;
+	if (prec_dir->ic_precompose !=3D (iconv_t)-1)
+		iconv_close(prec_dir->ic_precompose);
+	free(prec_dir->dirent_nfc);
+	free(prec_dir);
+	errno =3D ret_errno;
+	return ret_value;
+}
diff --git a/compat/precompose_utf8.h b/compat/precompose_utf8.h
new file mode 100644
index 0000000..3b73585
--- /dev/null
+++ b/compat/precompose_utf8.h
@@ -0,0 +1,45 @@
+#ifndef PRECOMPOSE_UNICODE_H
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <dirent.h>
+#include <iconv.h>
+
+
+typedef struct dirent_prec_psx {
+	ino_t d_ino;            /* Posix */
+	size_t max_name_len;    /* See below */
+	unsigned char d_type;   /* available on all systems git runs on */
+
+	/*
+	 * See http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/diren=
t.h.html
+	 * NAME_MAX + 1 should be enough, but some systems have
+	 * NAME_MAX=3D255 and strlen(d_name) may return 508 or 510
+	 * Solution: allocate more when needed, see precompose_utf8_readdir()
+	 */
+	char   d_name[NAME_MAX+1];
+} dirent_prec_psx;
+
+
+typedef struct {
+	iconv_t ic_precompose;
+	DIR *dirp;
+	struct dirent_prec_psx *dirent_nfc;
+} PREC_DIR;
+
+void precompose_argv(int argc, const char **argv);
+void probe_utf8_pathname_composition(char *, int);
+
+PREC_DIR *precompose_utf8_opendir(const char *dirname);
+struct dirent_prec_psx *precompose_utf8_readdir(PREC_DIR *dirp);
+int precompose_utf8_closedir(PREC_DIR *dirp);
+
+#ifndef PRECOMPOSE_UNICODE_C
+#define dirent dirent_prec_psx
+#define opendir(n) precompose_utf8_opendir(n)
+#define readdir(d) precompose_utf8_readdir(d)
+#define closedir(d) precompose_utf8_closedir(d)
+#define DIR PREC_DIR
+#endif /* PRECOMPOSE_UNICODE_C */
+
+#define  PRECOMPOSE_UNICODE_H
+#endif /* PRECOMPOSE_UNICODE_H */
diff --git a/config.c b/config.c
index 71ef171..eaef3b6 100644
--- a/config.c
+++ b/config.c
@@ -758,6 +758,11 @@ static int git_default_core_config(const char *var=
, const char *value)
 		return 0;
 	}
=20
+	if (!strcmp(var, "core.precomposeunicode")) {
+		precomposed_unicode =3D git_config_bool(var, value);
+		return 0;
+	}
+
 	/* Add other config variables here and to Documentation/config.txt. *=
/
 	return 0;
 }
diff --git a/environment.c b/environment.c
index 669e498..85edd7f 100644
--- a/environment.c
+++ b/environment.c
@@ -58,6 +58,7 @@ char *notes_ref_name;
 int grafts_replace_parents =3D 1;
 int core_apply_sparse_checkout;
 int merge_log_config =3D -1;
+int precomposed_unicode =3D -1; /* see probe_utf8_pathname_composition=
() */
 struct startup_info *startup_info;
 unsigned long pack_size_limit_cfg;
=20
diff --git a/git-compat-util.h b/git-compat-util.h
index 5bd9ad7..35b095e 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -153,6 +153,15 @@
 #endif
 #endif
=20
+/* used on Mac OS X */
+#ifdef PRECOMPOSE_UNICODE
+#include "compat/precompose_utf8.h"
+#else
+#define precompose_str(in,i_nfd2nfc)
+#define precompose_argv(c,v)
+#define probe_utf8_pathname_composition(a,b)
+#endif
+
 #ifndef NO_LIBGEN_H
 #include <libgen.h>
 #else
diff --git a/parse-options.c b/parse-options.c
index ab70c29..c1c66bd 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -476,6 +476,7 @@ int parse_options(int argc, const char **argv, cons=
t char *prefix,
 		usage_with_options(usagestr, options);
 	}
=20
+	precompose_argv(argc, argv);
 	return parse_options_end(&ctx);
 }
=20
diff --git a/t/t3910-mac-os-precompose.sh b/t/t3910-mac-os-precompose.s=
h
new file mode 100755
index 0000000..88b7a20
--- /dev/null
+++ b/t/t3910-mac-os-precompose.sh
@@ -0,0 +1,164 @@
+#!/bin/sh
+#
+# Copyright (c) 2012 Torsten B=C3=B6gershausen
+#
+
+test_description=3D'utf-8 decomposed (nfd) converted to precomposed (n=
fc)'
+
+. ./test-lib.sh
+
+Adiarnfc=3D`printf '\303\204'`
+Adiarnfd=3D`printf 'A\314\210'`
+
+# check if the feature is compiled in
+mkdir junk &&
+>junk/"$Adiarnfc" &&
+case "$(cd junk && echo *)" in
+	"$Adiarnfd")
+	test_nfd=3D1
+	;;
+	*)	;;
+esac
+rm -rf junk
+
+
+if test "$test_nfd"
+then
+	# create more utf-8 variables
+	Odiarnfc=3D`printf '\303\226'`
+	Odiarnfd=3D`printf 'O\314\210'`
+	AEligatu=3D`printf '\303\206'`
+	Invalidu=3D`printf '\303\377'`
+
+
+	#Create a string with 255 bytes (decomposed)
+	Alongd=3D$Adiarnfd$Adiarnfd$Adiarnfd$Adiarnfd$Adiarnfd$Adiarnfd$Adiar=
nfd #21 Byte
+	Alongd=3D$Alongd$Alongd$Alongd                                       =
    #63 Byte
+	Alongd=3D$Alongd$Alongd$Alongd$Alongd$Adiarnfd                       =
    #255 Byte
+
+	#Create a string with 254 bytes (precomposed)
+	Alongc=3D$AEligatu$AEligatu$AEligatu$AEligatu$AEligatu #10 Byte
+	Alongc=3D$Alongc$Alongc$Alongc$Alongc$Alongc           #50 Byte
+	Alongc=3D$Alongc$Alongc$Alongc$Alongc$Alongc           #250 Byte
+	Alongc=3D$Alongc$AEligatu$AEligatu                     #254 Byte
+
+	test_expect_success "detect if nfd needed" '
+		precomposeunicode=3D`git config core.precomposeunicode` &&
+		test "$precomposeunicode" =3D false &&
+		git config core.precomposeunicode true
+	'
+	test_expect_success "setup" '
+		>x &&
+		git add x &&
+		git commit -m "1st commit" &&
+		git rm x &&
+		git commit -m "rm x"
+	'
+	test_expect_success "setup case mac" '
+		git checkout -b mac_os
+	'
+	# This will test nfd2nfc in readdir()
+	test_expect_success "add file Adiarnfc" '
+		echo f.Adiarnfc >f.$Adiarnfc &&
+		git add f.$Adiarnfc &&
+		git commit -m "add f.$Adiarnfc"
+	'
+	# This will test nfd2nfc in git stage()
+	test_expect_success "stage file d.Adiarnfd/f.Adiarnfd" '
+		mkdir d.$Adiarnfd &&
+		echo d.$Adiarnfd/f.$Adiarnfd >d.$Adiarnfd/f.$Adiarnfd &&
+		git stage d.$Adiarnfd/f.$Adiarnfd &&
+		git commit -m "add d.$Adiarnfd/f.$Adiarnfd"
+	'
+	test_expect_success "add link Adiarnfc" '
+		ln -s d.$Adiarnfd/f.$Adiarnfd l.$Adiarnfc &&
+		git add l.$Adiarnfc &&
+		git commit -m "add l.Adiarnfc"
+	'
+	# This will test git log
+	test_expect_success "git log f.Adiar" '
+		git log f.$Adiarnfc > f.Adiarnfc.log &&
+		git log f.$Adiarnfd > f.Adiarnfd.log &&
+		test -s f.Adiarnfc.log &&
+		test -s f.Adiarnfd.log &&
+		test_cmp f.Adiarnfc.log f.Adiarnfd.log &&
+		rm f.Adiarnfc.log f.Adiarnfd.log
+	'
+	# This will test git ls-files
+	test_expect_success "git lsfiles f.Adiar" '
+		git ls-files f.$Adiarnfc > f.Adiarnfc.log &&
+		git ls-files f.$Adiarnfd > f.Adiarnfd.log &&
+		test -s f.Adiarnfc.log &&
+		test -s f.Adiarnfd.log &&
+		test_cmp f.Adiarnfc.log f.Adiarnfd.log &&
+		rm f.Adiarnfc.log f.Adiarnfd.log
+	'
+	# This will test git mv
+	test_expect_success "git mv" '
+		git mv f.$Adiarnfd f.$Odiarnfc &&
+		git mv d.$Adiarnfd d.$Odiarnfc &&
+		git mv l.$Adiarnfd l.$Odiarnfc &&
+		git commit -m "mv Adiarnfd Odiarnfc"
+	'
+	# Files can be checked out as nfc
+	# And the link has been corrected from nfd to nfc
+	test_expect_success "git checkout nfc" '
+		rm f.$Odiarnfc &&
+		git checkout f.$Odiarnfc
+	'
+	# Make it possible to checkout files with their NFD names
+	test_expect_success "git checkout file nfd" '
+		rm -f f.* &&
+		git checkout f.$Odiarnfd
+	'
+	# Make it possible to checkout links with their NFD names
+	test_expect_success "git checkout link nfd" '
+		rm l.* &&
+		git checkout l.$Odiarnfd
+	'
+	test_expect_success "setup case mac2" '
+		git checkout master &&
+		git reset --hard &&
+		git checkout -b mac_os_2
+	'
+	# This will test nfd2nfc in git commit
+	test_expect_success "commit file d2.Adiarnfd/f.Adiarnfd" '
+		mkdir d2.$Adiarnfd &&
+		echo d2.$Adiarnfd/f.$Adiarnfd >d2.$Adiarnfd/f.$Adiarnfd &&
+		git add d2.$Adiarnfd/f.$Adiarnfd &&
+		git commit -m "add d2.$Adiarnfd/f.$Adiarnfd" -- d2.$Adiarnfd/f.$Adia=
rnfd
+	'
+	test_expect_success "setup for long decomposed filename" '
+		git checkout master &&
+		git reset --hard &&
+		git checkout -b mac_os_long_nfd_fn
+	'
+	test_expect_success "Add long decomposed filename" '
+		echo longd >$Alongd &&
+		git add * &&
+		git commit -m "Long filename"
+	'
+	test_expect_success "setup for long precomposed filename" '
+		git checkout master &&
+		git reset --hard &&
+		git checkout -b mac_os_long_nfc_fn
+	'
+	test_expect_success "Add long precomposed filename" '
+		echo longc >$Alongc &&
+		git add * &&
+		git commit -m "Long filename"
+	'
+	# Test if the global core.precomposeunicode stops autosensing
+	# Must be the last test case
+	test_expect_success "respect git config --global core.precomposeunico=
de" '
+		git config --global core.precomposeunicode true &&
+		rm -rf .git &&
+		git init &&
+		precomposeunicode=3D`git config core.precomposeunicode` &&
+		test "$precomposeunicode" =3D "true"
+	'
+else
+	 say "Skipping nfc/nfd tests"
+fi
+
+test_done
diff --git a/utf8.c b/utf8.c
index 8acbc66..a544f15 100644
--- a/utf8.c
+++ b/utf8.c
@@ -433,19 +433,12 @@ int is_encoding_utf8(const char *name)
 #else
 	typedef char * iconv_ibp;
 #endif
-char *reencode_string(const char *in, const char *out_encoding, const =
char *in_encoding)
+char *reencode_string_iconv(const char *in, size_t insz, iconv_t conv)
 {
-	iconv_t conv;
-	size_t insz, outsz, outalloc;
+	size_t outsz, outalloc;
 	char *out, *outpos;
 	iconv_ibp cp;
=20
-	if (!in_encoding)
-		return NULL;
-	conv =3D iconv_open(out_encoding, in_encoding);
-	if (conv =3D=3D (iconv_t) -1)
-		return NULL;
-	insz =3D strlen(in);
 	outsz =3D insz;
 	outalloc =3D outsz + 1; /* for terminating NUL */
 	out =3D xmalloc(outalloc);
@@ -459,7 +452,6 @@ char *reencode_string(const char *in, const char *o=
ut_encoding, const char *in_e
 			size_t sofar;
 			if (errno !=3D E2BIG) {
 				free(out);
-				iconv_close(conv);
 				return NULL;
 			}
 			/* insz has remaining number of bytes.
@@ -478,6 +470,20 @@ char *reencode_string(const char *in, const char *=
out_encoding, const char *in_e
 			break;
 		}
 	}
+	return out;
+}
+
+char *reencode_string(const char *in, const char *out_encoding, const =
char *in_encoding)
+{
+	iconv_t conv;
+	char *out;
+
+	if (!in_encoding)
+		return NULL;
+	conv =3D iconv_open(out_encoding, in_encoding);
+	if (conv =3D=3D (iconv_t) -1)
+		return NULL;
+	out =3D reencode_string_iconv(in, strlen(in), conv);
 	iconv_close(conv);
 	return out;
 }
diff --git a/utf8.h b/utf8.h
index 81f2c82..3c0ae76 100644
--- a/utf8.h
+++ b/utf8.h
@@ -14,6 +14,7 @@ int strbuf_add_wrapped_bytes(struct strbuf *buf, cons=
t char *data, int len,
 			     int indent, int indent2, int width);
=20
 #ifndef NO_ICONV
+char *reencode_string_iconv(const char *in, size_t insz, iconv_t conv)=
;
 char *reencode_string(const char *in, const char *out_encoding, const =
char *in_encoding);
 #else
 #define reencode_string(a,b,c) NULL
--=20
1.7.11.1.47.ge34cb30
