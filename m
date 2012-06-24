From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [RFC/PATCH v5] git on Mac OS and precomposed unicode
Date: Sun, 24 Jun 2012 17:47:05 +0200
Message-ID: <201206241747.06525.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 24 17:47:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sip2B-00079j-HR
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jun 2012 17:47:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751947Ab2FXPr1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Jun 2012 11:47:27 -0400
Received: from mout.web.de ([212.227.17.11]:60984 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751520Ab2FXPr0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Jun 2012 11:47:26 -0400
Received: from appes.localnet ([194.22.188.61]) by smtp.web.de (mrweb101) with
 ESMTPA (Nemesis) id 0LfAoO-1S7WDc15ya-00otq4; Sun, 24 Jun 2012 17:47:25 +0200
X-Provags-ID: V02:K0:fMZ1d4AKxwxThkb8vHQQp7VHEvCR1+4RRw9XA6eQoUY
 PM0r++qpHhDcSSoeRU3hqdmqroymYhgN2X2ubuBZ73yqIYLQGN
 ncUAX+ZK2JuVNEpamhmZe6kFm/t5HxdROVNPNhpfeCXB+Rpr37
 FwWpyZwVrD0PLqfWYzN5rRHChJDBXTQREAWhlIDKJlpLd0XfBr
 NHxyDdy4mFfoJcrxh9fPQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200534>

The problem:
Mac OS X may manipulate file names containing unicode on file systems
HFS+, VFAT or SAMBA.

When a file using unicode code points outside ASCII is created on a HFS=
+ drive,
the file name is converted into decomposed unicode and written to disk.
No conversion is done if the file name is already decomposed unicode.

Calling open("\xc3\x84", ...) whith a precomposed "=C3=84" yields the s=
ame
result as open("\x41\xcc\x88",...) with a decomposed "=C3=84".

This precomposition is done for all file system calls like
creat(), open(), fopen(), stat/lstat() etc.

The result is that readdir() will return the file names in decomposed u=
nicode,
even if the user expects precomposed unicode.

In opposite to HFS+ stores Mac OS X  files on a VFAT drive (e.g. an USB=
 drive),
in precomposed unicode, but readdir() returns file names in decomposed =
unicode.

When a git repository is stored on a network share using SAMBA, file na=
mes are
send over the wire and written to disk on the remote system in precompo=
sed
unicode.
To be compatible with HFS+ and VFAT returns Mac OS X readdir()
decomposed unicode.

NFS mounted from Linux is fully transparent and does not need all this.

Summary:
filenames which are unicode equivalent in their precomposed or decompos=
ed
form are folded onto the same file system object.
Calling readdir() returns always the decomposed form.

The unicode decomposition creates some problems:
- "git add" needs the decomposed form on the command line,
  so that the file name is picked up when readdir() is called
  to build a list of files on disk.
- The decomposed form is not (easily) available on the keyboard.
  To work around this, a wildcard could be used in "git add":
  Instead of using "git add M=C3=A4rchen.txt" the user needs to enter
  "git add M*rchen", "git add M<TAB>" or "git add *".
- "git log", "git mv" and all other commands needs the decomposed form
  to find the file name which is stored as decomposed in the index.
- The file names are stored in decomposed unicode in the index, but
  precomposed on disk.
    This makes it impossible to use this repository under e.g.
    Linux or Windows:
    All files appear to be deleted in the decomposed form and
    untracked in the precomposed form.

Knowing that Mac OS X writes file names as precomposed to disk,
and treats precomposed and decomposed file names as equal, git under Ma=
c OS X
can be improved to revert the unicode decomposition of file names.

A new confguration variable is added: "core.precomposedunicode"

If set to false, git behaves exactly as older versions of git.
When a new git version is installed and there is a repository
where the configuration "core.precomposedunicode" is not present,
the new git is backward compatible.

If set to true, git allows forces the index to only use precomposed uni=
code.

The code in compat/precomposed_utf8.c implements basically 4 new functi=
ons:
precomposed_utf8_opendir(), precomposed_utf8_readdir(),
precomposed_utf8_closedir() precompose_argv()

As theere are only precomposed unicode file names in the index,
and precomposed and decomposed are treated as equal by the OS,
all arguments into git (argv[1]..argv[n]) are converted into
precomposed unicode.
This is done in parse-options.c by calling precompose_argv().
This function is actually a #define, and it is only defined under Mac O=
S.
Nothing is converted on any other OS.

The argv[] conversion allows to use the TAB filename completion done by=
 the
shell on command line.
It tolerates other tools which use readdir() to feed decomposed file na=
mes
into git.

Auto sensing:
When creating a new git repository with "git init" or "git clone",
"core.precomposedunicode" will be set "false".

The user needs to activate this feature manually.
She typically sets core.precomposedunicode to "true" on HFS and VFAT,
or file systems mounted via SAMBA onto a Linux box.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 Documentation/config.txt     |   9 ++
 Makefile                     |   3 +
 builtin/init-db.c            |   2 +
 cache.h                      |   1 +
 compat/precomposed_utf8.c    | 200 +++++++++++++++++++++++++++++++++++=
++++++++
 compat/precomposed_utf8.h    |  30 +++++++
 config.c                     |   5 ++
 environment.c                |   1 +
 git-compat-util.h            |   9 ++
 parse-options.c              |   1 +
 t/t3910-mac-os-precompose.sh | 128 +++++++++++++++++++++++++++
 11 files changed, 389 insertions(+)
 create mode 100644 compat/precomposed_utf8.c
 create mode 100644 compat/precomposed_utf8.h
 create mode 100755 t/t3910-mac-os-precompose.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 915cb5a..8e4a6a8 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -210,6 +210,15 @@ The default is false, except linkgit:git-clone[1] =
or linkgit:git-init[1]
 will probe and set core.ignorecase true if appropriate when the reposi=
tory
 is created.
=20
+core.precomposedunicode::
+	This option is only used by Mac OS implementation of git.
+	When core.precomposedunicode=3Dtrue, git reverts the unicode decompos=
ition
+	of filenames done by Mac OS. This is useful when sharing a repository
+	between Mac OS and Linux or	Windows.
+	(Git for Windows/msysGit 1.7.10 is needed, or git under cygwin 1.7).
+	When false, file names are handled fully transparent by git, which me=
ans
+	that file names are stored as decomposed unicode in the	repository.
+
 core.trustctime::
 	If false, the ctime differences between the index and the
 	working tree are ignored; useful when the inode change time
diff --git a/Makefile b/Makefile
index f62ca2a..55ceb10 100644
--- a/Makefile
+++ b/Makefile
@@ -607,6 +607,7 @@ LIB_H +=3D compat/bswap.h
 LIB_H +=3D compat/cygwin.h
 LIB_H +=3D compat/mingw.h
 LIB_H +=3D compat/obstack.h
+LIB_H +=3D compat/precomposed_utf8.h
 LIB_H +=3D compat/terminal.h
 LIB_H +=3D compat/win32/dirent.h
 LIB_H +=3D compat/win32/poll.h
@@ -1000,6 +1001,8 @@ ifeq ($(uname_S),Darwin)
 	NO_MEMMEM =3D YesPlease
 	USE_ST_TIMESPEC =3D YesPlease
 	HAVE_DEV_TTY =3D YesPlease
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
diff --git a/cache.h b/cache.h
index 06413e1..bc69166 100644
--- a/cache.h
+++ b/cache.h
@@ -560,6 +560,7 @@ extern int read_replace_refs;
 extern int fsync_object_files;
 extern int core_preload_index;
 extern int core_apply_sparse_checkout;
+extern int mac_os_precomposed_unicode;
=20
 enum branch_track {
 	BRANCH_TRACK_UNSPECIFIED =3D -1,
diff --git a/compat/precomposed_utf8.c b/compat/precomposed_utf8.c
new file mode 100644
index 0000000..f510f21
--- /dev/null
+++ b/compat/precomposed_utf8.c
@@ -0,0 +1,200 @@
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
+	if (mac_os_precomposed_unicode !=3D -1)
+		return; /* We found it defined in the global config, respect it */
+	path[len] =3D 0;
+	strcpy(path + len, auml_nfc);
+	output_fd =3D open(path, O_CREAT|O_EXCL|O_RDWR, 0600);
+	if (output_fd >=3D0) {
+		close(output_fd);
+		path[len] =3D 0;
+		strcpy(path + len, auml_nfd);
+		/* Indicate the the user, that we can configure it to true */
+		if (0 =3D=3D access(path, R_OK))
+			git_config_set("core.precomposedunicode", "false");
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
+	if (mac_os_precomposed_unicode !=3D 1)
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
+	if (res && (mac_os_precomposed_unicode =3D=3D 1) && has_utf8(res->d_n=
ame, (size_t)-1, &namelen)) {
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
diff --git a/config.c b/config.c
index 71ef171..50d4c0e 100644
--- a/config.c
+++ b/config.c
@@ -758,6 +758,11 @@ static int git_default_core_config(const char *var=
, const char *value)
 		return 0;
 	}
=20
+	if (!strcmp(var, "core.precomposedunicode")) {
+		mac_os_precomposed_unicode =3D git_config_bool(var, value);
+		return 0;
+	}
+
 	/* Add other config variables here and to Documentation/config.txt. *=
/
 	return 0;
 }
diff --git a/environment.c b/environment.c
index 669e498..200a04f 100644
--- a/environment.c
+++ b/environment.c
@@ -58,6 +58,7 @@ char *notes_ref_name;
 int grafts_replace_parents =3D 1;
 int core_apply_sparse_checkout;
 int merge_log_config =3D -1;
+int mac_os_precomposed_unicode =3D -1; /* see probe_utf8_pathname_comp=
osition() */
 struct startup_info *startup_info;
 unsigned long pack_size_limit_cfg;
=20
diff --git a/git-compat-util.h b/git-compat-util.h
index 5bd9ad7..600fa9e 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -153,6 +153,15 @@
 #endif
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
index 0000000..b40f1c1
--- /dev/null
+++ b/t/t3910-mac-os-precompose.sh
@@ -0,0 +1,128 @@
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
+	test_expect_success "detect if nfd needed" '
+		precomposedunicode=3D`git config core.precomposedunicode` &&
+		test "$precomposedunicode" =3D false &&
+		git config core.precomposedunicode true
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
+	# Test if the global core.precomposedunicode stops autosensing
+	# Must be the last test case
+	test_expect_success "respect git config --global core.precomposedunic=
ode" '
+		git config --global core.precomposedunicode true &&
+		rm -rf .git &&
+		git init &&
+		precomposedunicode=3D`git config core.precomposedunicode` &&
+		test "$precomposedunicode" =3D "true"
+	'
+else
+	 say "Skipping nfc/nfd tests"
+fi
+
+test_done
--=20
1.7.11.1.30.g00c4fee
