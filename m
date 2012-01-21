From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH V4] git on Mac OS and precomposed unicode
Date: Sat, 21 Jan 2012 20:36:56 +0100
Message-ID: <201201212036.57632.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 21 20:37:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RogkO-0003gg-Eh
	for gcvg-git-2@lo.gmane.org; Sat, 21 Jan 2012 20:37:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111Ab2AUThE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Jan 2012 14:37:04 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:45336 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751046Ab2AUThB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Jan 2012 14:37:01 -0500
Received: from moweb001.kundenserver.de (moweb001.kundenserver.de [172.19.20.114])
	by fmmailgate02.web.de (Postfix) with ESMTP id B0A3B1C0573B0
	for <git@vger.kernel.org>; Sat, 21 Jan 2012 20:36:59 +0100 (CET)
Received: from maxi.localnet ([194.22.188.61]) by smtp.web.de (mrweb001) with
 ESMTPA (Nemesis) id 0MAMTy-1RumMD1jdC-00B5gO; Sat, 21 Jan 2012 20:36:59 +0100
X-Provags-ID: V02:K0:v9VTnUjuVIJtbNM1i7lGZ5QkGUVoM/Rx9/6LyNnA4Rb
 ap4Kaxaf7dQUIkT4toXUrLWmaacH7w5r9RJR0kwksIqds+RMG3
 +3G+ogtCVGitJE2K+FlI6tAXOWXGn/WSKnFRKb0P69VNrQemai
 NNIA20GJa3Dhh264PCCmUG4DrhHMlGRCE/eXab9Xl83Q1yJk1a
 zNQyDhuJdZ2CZ5acVXygg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188930>

Allow git on Mac OS to store file names in the index in precomposed uni=
code,
while the file system uses decomposed unicode.

The problem:
When a file called "LATIN CAPITAL LETTER A WITH DIAERESIS"
(in utf-8 encoded as 0xc3 0x84) is created, the Mac OS filesystem
converts "precomposed unicode" into "decomposed unicode".
This means that readdir() will return 0x41 0xcc 0x88.

Git under Mac OS reverts the unicode decomposition of filenames.

This is useful when pulling/pushing from repositories containing utf-8
encoded filenames using precomposed utf-8 like Linux or Windows (*).

It allows sharing git repositories stored on a VFAT file system
(e.g. a USB stick), and mounted network share using samba.

* (Not all Windows versions support UTF-8 yet:
   Msysgit needs the unicode branch, cygwin supports UTF-8 since 1.7)

A new confguration variable is added: "core.precomposedunicode"

If set to false, git behaves exactly as older versions of git.
When a new git version is installed and there is a repository
where the configuration "core.precomposedunicode" is not present,
the new git is backward compatible.

The code in compat/precomposed_utf8.c implements basically 4 new functi=
ons:
precomposed_utf8_opendir(), precomposed_utf8_readdir(),
precomposed_utf8_closedir() precompose_argv()

In order to prevent that ever a file name in decomposed unicode is ente=
ring
the index, a "brute force" attempt is taken:
all arguments into git (argv[1]..argv[n]) are converted into
precomposed unicode.
This is done in git.c by calling precompose_argv().
This function is actually a #define, and it is only defined under Mac O=
S.
Nothing is converted on any other OS.

Auto sensing:
When creating a new git repository with "git init" or "git clone",
"core.precomposedunicode" will be set "false".

The user needs to activate this feature manually.
She typically sets core.precomposedunicode to "true" on HFS and VFAT,
or file systems mounted via SAMBA onto a Linux box.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 Documentation/config.txt     |    9 ++
 Makefile                     |    3 +
 builtin/init-db.c            |    2 +
 compat/precomposed_utf8.c    |  208 ++++++++++++++++++++++++++++++++++=
++++++++
 compat/precomposed_utf8.h    |   30 ++++++
 git-compat-util.h            |    9 ++
 git.c                        |    1 +
 t/t3910-mac-os-precompose.sh |  117 +++++++++++++++++++++++
 8 files changed, 379 insertions(+), 0 deletions(-)
 create mode 100644 compat/precomposed_utf8.c
 create mode 100644 compat/precomposed_utf8.h
 create mode 100755 t/t3910-mac-os-precompose.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2959390..29ba4b0 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -175,6 +175,15 @@ The default is false, except linkgit:git-clone[1] =
or linkgit:git-init[1]
 will probe and set core.ignorecase true if appropriate when the reposi=
tory
 is created.
=20
+core.precomposedunicode::
+	This option is only used by Mac OS implementation of git.
+	When core.precomposedunicode=3Dtrue,
+	git reverts the unicode decomposition of filenames done by Mac OS.
+	This is useful when pulling/pushing from repositories containing utf-=
8
+	encoded filenames using precomposed unicode (like Linux).
+	When false, file names are handled fully transparent by git.
+	If in doubt, keep core.precomposedunicode=3Dfalse.
+
 core.trustctime::
 	If false, the ctime differences between the index and the
 	working tree are ignored; useful when the inode change time
diff --git a/Makefile b/Makefile
index b21d2f1..a912b45 100644
--- a/Makefile
+++ b/Makefile
@@ -519,6 +519,7 @@ LIB_H +=3D compat/bswap.h
 LIB_H +=3D compat/cygwin.h
 LIB_H +=3D compat/mingw.h
 LIB_H +=3D compat/obstack.h
+LIB_H +=3D compat/precomposed_utf8.h
 LIB_H +=3D compat/win32/pthread.h
 LIB_H +=3D compat/win32/syslog.h
 LIB_H +=3D compat/win32/poll.h
@@ -884,6 +885,8 @@ ifeq ($(uname_S),Darwin)
 	endif
 	NO_MEMMEM =3D YesPlease
 	USE_ST_TIMESPEC =3D YesPlease
+	COMPAT_OBJS +=3D compat/precomposed_utf8.o
+	BASIC_CFLAGS +=3D -DPRECOMPOSED_UNICODE
 endif
 ifeq ($(uname_S),SunOS)
 	NEEDS_SOCKET =3D YesPlease
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 0dacb8b..06953df 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -290,6 +290,8 @@ static int create_default_files(const char *templat=
e_path)
 		strcpy(path + len, "CoNfIg");
 		if (!access(path, F_OK))
 			git_config_set("core.ignorecase", "true");
+
+		probe_utf8_pathname_composition(path, len);
 	}
=20
 	return reinit;
diff --git a/compat/precomposed_utf8.c b/compat/precomposed_utf8.c
new file mode 100644
index 0000000..285fb45
--- /dev/null
+++ b/compat/precomposed_utf8.c
@@ -0,0 +1,208 @@
+#define __PRECOMPOSED_UNICODE_C__
+
+#include "../cache.h"
+#include "../utf8.h"
+#include <stdlib.h>
+#include <string.h>
+#include <stdio.h>
+#include <stdint.h>
+#include "precomposed_utf8.h"
+
+static int mac_os_precomposed_unicode;
+const static char *repo_encoding =3D "UTF-8";
+const static char *path_encoding =3D "UTF-8-MAC";
+
+
+/* Code borrowed from utf8.c */
+#if defined(OLD_ICONV) || (defined(__sun__) && !defined(_XPG6))
+	typedef const char * iconv_ibp;
+#else
+	typedef char * iconv_ibp;
+#endif
+
+static char *reencode_string_iconv(const char *in, size_t insz, iconv_=
t conv)
+{
+	size_t outsz, outalloc;
+	char *out, *outpos;
+	iconv_ibp cp;
+
+	outsz =3D insz;
+	outalloc =3D outsz + 1; /* for terminating NUL */
+	out =3D xmalloc(outalloc);
+	outpos =3D out;
+	cp =3D (iconv_ibp)in;
+
+	while (1) {
+		size_t cnt =3D iconv(conv, &cp, &insz, &outpos, &outsz);
+
+		if (cnt =3D=3D -1) {
+			size_t sofar;
+			if (errno !=3D E2BIG) {
+				free(out);
+				return NULL;
+			}
+			/* insz has remaining number of bytes.
+			 * since we started outsz the same as insz,
+			 * it is likely that insz is not enough for
+			 * converting the rest.
+			 */
+			sofar =3D outpos - out;
+			outalloc =3D sofar + insz * 2 + 32;
+			out =3D xrealloc(out, outalloc);
+			outpos =3D out + sofar;
+			outsz =3D outalloc - sofar - 1;
+		}
+		else {
+			*outpos =3D '\0';
+			break;
+		}
+	}
+	return out;
+}
+
+static size_t has_utf8(const char *s, size_t maxlen, size_t *strlen_c)
+{
+	const uint8_t *utf8p =3D (const uint8_t*) s;
+	size_t strlen_chars =3D 0;
+	size_t ret =3D 0;
+
+	if ((!utf8p) || (!*utf8p))
+		return 0;
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
+	path[len] =3D 0;
+	strcpy(path + len, auml_nfc);
+	output_fd =3D open(path, O_CREAT|O_EXCL|O_RDWR, 0600);
+	if (output_fd >=3D0) {
+		close(output_fd);
+		path[len] =3D 0;
+		strcpy(path + len, auml_nfd);
+		if (0 =3D=3D access(path, R_OK))
+			git_config_set("core.precomposedunicode", "false");
+		path[len] =3D 0;
+		strcpy(path + len, auml_nfc);
+		unlink(path);
+	}
+}
+
+
+static int precomposed_unicode_config(const char *var, const char *val=
ue, void *cb)
+{
+	if (!strcasecmp(var, "core.precomposedunicode")) {
+		mac_os_precomposed_unicode =3D git_config_bool(var, value);
+		return 0;
+	}
+	return 1;
+}
+
+void precompose_argv(int argc, const char **argv)
+{
+	int i =3D 0;
+	const char *oldarg;
+	char *newarg;
+	iconv_t ic_precompose;
+
+	git_config(precomposed_unicode_config, NULL);
+	if (!mac_os_precomposed_unicode)
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
+PRECOMPOSED_UTF_DIR * precomposed_utf8_opendir(const char *dirname)
+{
+	PRECOMPOSED_UTF_DIR *precomposed_utf8_dir;
+	precomposed_utf8_dir =3D xmalloc(sizeof(PRECOMPOSED_UTF_DIR));
+
+	precomposed_utf8_dir->dirp =3D opendir(dirname);
+	if (!precomposed_utf8_dir->dirp) {
+		free(precomposed_utf8_dir);
+		return NULL;
+	}
+	precomposed_utf8_dir->ic_precompose =3D iconv_open(repo_encoding, pat=
h_encoding);
+	if (precomposed_utf8_dir->ic_precompose =3D=3D (iconv_t) -1) {
+		closedir(precomposed_utf8_dir->dirp);
+		free(precomposed_utf8_dir);
+		return NULL;
+	}
+
+	return precomposed_utf8_dir;
+}
+
+struct dirent * precomposed_utf8_readdir(PRECOMPOSED_UTF_DIR *precompo=
sed_utf8_dirp)
+{
+	struct dirent *res;
+	size_t namelen =3D 0;
+
+	res =3D readdir(precomposed_utf8_dirp->dirp);
+	if (res && mac_os_precomposed_unicode && has_utf8(res->d_name, (size_=
t)-1, &namelen)) {
+		int ret_errno =3D errno;
+		size_t outsz =3D sizeof(precomposed_utf8_dirp->dirent_nfc.d_name) - =
1; /* one for \0 */
+		char *outpos =3D precomposed_utf8_dirp->dirent_nfc.d_name;
+		iconv_ibp cp;
+		size_t cnt;
+		size_t insz =3D namelen;
+		cp =3D (iconv_ibp)res->d_name;
+
+		/* Copy all data except the name */
+		memcpy(&precomposed_utf8_dirp->dirent_nfc, res,
+		       sizeof(precomposed_utf8_dirp->dirent_nfc)-sizeof(precomposed_=
utf8_dirp->dirent_nfc.d_name));
+		errno =3D 0;
+
+		cnt =3D iconv(precomposed_utf8_dirp->ic_precompose, &cp, &insz, &out=
pos, &outsz);
+		if (cnt < sizeof(precomposed_utf8_dirp->dirent_nfc.d_name) -1) {
+			*outpos =3D 0;
+			errno =3D ret_errno;
+			return &precomposed_utf8_dirp->dirent_nfc;
+		}
+		errno =3D ret_errno;
+	}
+	return res;
+}
+
+
+int precomposed_utf8_closedir(PRECOMPOSED_UTF_DIR *precomposed_utf8_di=
rp)
+{
+	int ret_value;
+	int ret_errno;
+	ret_value =3D closedir(precomposed_utf8_dirp->dirp);
+	ret_errno =3D errno;
+	if (precomposed_utf8_dirp->ic_precompose !=3D (iconv_t)-1)
+		iconv_close(precomposed_utf8_dirp->ic_precompose);
+	free(precomposed_utf8_dirp);
+	errno =3D ret_errno;
+	return ret_value;
+}
diff --git a/compat/precomposed_utf8.h b/compat/precomposed_utf8.h
new file mode 100644
index 0000000..79e65e7
--- /dev/null
+++ b/compat/precomposed_utf8.h
@@ -0,0 +1,30 @@
+#ifndef __PRECOMPOSED_UNICODE_H__
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <dirent.h>
+#include <iconv.h>
+
+
+typedef struct {
+	iconv_t ic_precompose;
+	DIR *dirp;
+	struct dirent dirent_nfc;
+} PRECOMPOSED_UTF_DIR;
+
+char *precompose_str(const char *in, iconv_t ic_precompose);
+void precompose_argv(int argc, const char **argv);
+void probe_utf8_pathname_composition(char *, int);
+
+PRECOMPOSED_UTF_DIR *precomposed_utf8_opendir(const char *dirname);
+struct dirent *precomposed_utf8_readdir(PRECOMPOSED_UTF_DIR *dirp);
+int precomposed_utf8_closedir(PRECOMPOSED_UTF_DIR *dirp);
+
+#ifndef __PRECOMPOSED_UNICODE_C__
+#define opendir(n) precomposed_utf8_opendir(n)
+#define readdir(d) precomposed_utf8_readdir(d)
+#define closedir(d) precomposed_utf8_closedir(d)
+#define DIR PRECOMPOSED_UTF_DIR
+#endif /* __PRECOMPOSED_UNICODE_C__ */
+
+#define  __PRECOMPOSED_UNICODE_H__
+#endif /* __PRECOMPOSED_UNICODE_H__ */
diff --git a/git-compat-util.h b/git-compat-util.h
index 230e198..8911743 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -153,6 +153,15 @@
 #include "compat/msvc.h"
 #endif
=20
+/* used on Mac OS X */
+#ifdef PRECOMPOSED_UNICODE
+#include "compat/precomposed_utf8.h"
+#else
+#define precompose_str(in,i_nfd2nfc)
+#define precompose_argv(c,v)
+#define probe_utf8_pathname_composition(a,b)
+#endif
+
 #ifndef NO_LIBGEN_H
 #include <libgen.h>
 #else
diff --git a/git.c b/git.c
index 8e34903..265db96 100644
--- a/git.c
+++ b/git.c
@@ -298,6 +298,7 @@ static int run_builtin(struct cmd_struct *p, int ar=
gc, const char **argv)
 		    startup_info->have_repository) /* get_git_dir() may set up repo,=
 avoid that */
 			trace_repo_setup(prefix);
 	}
+	precompose_argv(argc, argv);
 	commit_pager_choice();
=20
 	if (!help && p->option & NEED_WORK_TREE)
diff --git a/t/t3910-mac-os-precompose.sh b/t/t3910-mac-os-precompose.s=
h
new file mode 100755
index 0000000..ba3d83c
--- /dev/null
+++ b/t/t3910-mac-os-precompose.sh
@@ -0,0 +1,117 @@
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
+Odiarnfc=3D`printf '\303\226'`
+Adiarnfd=3D`printf 'A\314\210'`
+Odiarnfd=3D`printf 'O\314\210'`
+
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
+if test "$test_nfd"
+then
+	test_expect_success "detect if nfd needed" '
+		precomposedunicode=3D`git config  core.precomposedunicode` &&
+		test "$precomposedunicode" =3D false &&
+		git config  core.precomposedunicode true
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
+else
+	 say "Skipping nfc/nfd tests"
+fi
+
+test_done
--=20
1.7.8.rc0.43.gb49a8
