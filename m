From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH/RFC] core.precomposeunicode is true by default
Date: Sat, 27 Jul 2013 03:21:31 +0200
Message-ID: <201307270321.32398.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, tboegi@web.de
X-From: git-owner@vger.kernel.org Sat Jul 27 03:22:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2tD5-0003S0-1S
	for gcvg-git-2@plane.gmane.org; Sat, 27 Jul 2013 03:22:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757963Ab3G0BVx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Jul 2013 21:21:53 -0400
Received: from mout.web.de ([212.227.17.11]:53021 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756230Ab3G0BVv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Jul 2013 21:21:51 -0400
Received: from appes.localnet ([195.67.191.23]) by smtp.web.de (mrweb102)
 with ESMTPA (Nemesis) id 0MRUBA-1UejZN3ZGK-00ScVU for <git@vger.kernel.org>;
 Sat, 27 Jul 2013 03:21:50 +0200
X-Provags-ID: V03:K0:VMJ4+bo83oi6InwBCaomIv2wkcyzODhFQMpqaaaqFPq5vdepoe+
 TRIhgpAyc26tRNH9NiLScBfORGdH6i0fXH4Kc6n1Eox/olINfvOqWRYl2G2PNKNIt+eSR1t
 q4HFf6e2cSoANF3AShnX+26CLeVCA93Zik4WqhsucrWvKD+FjlS1gq/al4v2a+prPsVLvYG
 cWjV95PAo+UQeg6WiXm1Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231221>

When core.precomposeunicode was introduced, it was set to false
by default, to be compatible with older versions of Git.

Whenever UTF-8 file names are used in a mixed environment,
the Mac OS users need to find out that this configuration exist
and set it to true manually.

There is no measurable performance impact between false and true.
A smoother workflow can be achieved for new Git users,
so change the default to true:

- Remove the auto-sensing
- Rename the internal variable into precompose_unicode,
  and set it to 1 meaning true.
- Adjust and clean up test cases

The configuration core.precomposeunicode is still supported.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 Documentation/config.txt     |  2 +-
 builtin/init-db.c            |  1 -
 cache.h                      |  2 +-
 compat/precompose_utf8.c     | 28 ++--------------------------
 compat/precompose_utf8.h     |  1 -
 config.c                     |  2 +-
 environment.c                |  2 +-
 git-compat-util.h            |  1 -
 t/t0050-filesystem.sh        |  1 +
 t/t3910-mac-os-precompose.sh | 14 --------------
 t/t7400-submodule-basic.sh   |  1 -
 11 files changed, 7 insertions(+), 48 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e0b923f..abe4cfa 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -240,7 +240,7 @@ core.precomposeunicode::
 	This option is only used by Mac OS implementation of Git.
 	When core.precomposeunicode=3Dtrue, Git reverts the unicode decomposi=
tion
 	of filenames done by Mac OS. This is useful when sharing a repository
-	between Mac OS and Linux or Windows.
+	between Mac OS and Linux or Windows. True by default.
 	(Git for Windows 1.7.10 or higher is needed, or Git under cygwin 1.7)=
=2E
 	When false, file names are handled fully transparent by Git,
 	which is backward compatible with older versions of Git.
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 78aa387..08854d5 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -290,7 +290,6 @@ static int create_default_files(const char *templat=
e_path)
 		strcpy(path + len, "CoNfIg");
 		if (!access(path, F_OK))
 			git_config_set("core.ignorecase", "true");
-		probe_utf8_pathname_composition(path, len);
 	}
=20
 	return reinit;
diff --git a/cache.h b/cache.h
index 4c606ce..abb2cad 100644
--- a/cache.h
+++ b/cache.h
@@ -593,7 +593,7 @@ extern int read_replace_refs;
 extern int fsync_object_files;
 extern int core_preload_index;
 extern int core_apply_sparse_checkout;
-extern int precomposed_unicode;
+extern int precompose_unicode;
=20
 /*
  * The character that begins a commented line in user-editable file
diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
index 7980abd..5396b91 100644
--- a/compat/precompose_utf8.c
+++ b/compat/precompose_utf8.c
@@ -36,30 +36,6 @@ static size_t has_non_ascii(const char *s, size_t ma=
xlen, size_t *strlen_c)
 }
=20
=20
-void probe_utf8_pathname_composition(char *path, int len)
-{
-	static const char *auml_nfc =3D "\xc3\xa4";
-	static const char *auml_nfd =3D "\x61\xcc\x88";
-	int output_fd;
-	if (precomposed_unicode !=3D -1)
-		return; /* We found it defined in the global config, respect it */
-	strcpy(path + len, auml_nfc);
-	output_fd =3D open(path, O_CREAT|O_EXCL|O_RDWR, 0600);
-	if (output_fd >=3D 0) {
-		close(output_fd);
-		strcpy(path + len, auml_nfd);
-		/* Indicate to the user, that we can configure it to true */
-		if (!access(path, R_OK))
-			git_config_set("core.precomposeunicode", "false");
-		/* To be backward compatible, set precomposed_unicode to 0 */
-		precomposed_unicode =3D 0;
-		strcpy(path + len, auml_nfc);
-		if (unlink(path))
-			die_errno(_("failed to unlink '%s'"), path);
-	}
-}
-
-
 void precompose_argv(int argc, const char **argv)
 {
 	int i =3D 0;
@@ -67,7 +43,7 @@ void precompose_argv(int argc, const char **argv)
 	char *newarg;
 	iconv_t ic_precompose;
=20
-	if (precomposed_unicode !=3D 1)
+	if (!precompose_unicode)
 		return;
=20
 	ic_precompose =3D iconv_open(repo_encoding, path_encoding);
@@ -130,7 +106,7 @@ struct dirent_prec_psx *precompose_utf8_readdir(PRE=
C_DIR *prec_dir)
 		prec_dir->dirent_nfc->d_ino  =3D res->d_ino;
 		prec_dir->dirent_nfc->d_type =3D res->d_type;
=20
-		if ((precomposed_unicode =3D=3D 1) && has_non_ascii(res->d_name, (si=
ze_t)-1, NULL)) {
+		if (precompose_unicode && has_non_ascii(res->d_name, (size_t)-1, NUL=
L)) {
 			if (prec_dir->ic_precompose =3D=3D (iconv_t)-1) {
 				die("iconv_open(%s,%s) failed, but needed:\n"
 						"    precomposed unicode is not supported.\n"
diff --git a/compat/precompose_utf8.h b/compat/precompose_utf8.h
index 3b73585..488f81d 100644
--- a/compat/precompose_utf8.h
+++ b/compat/precompose_utf8.h
@@ -27,7 +27,6 @@ typedef struct {
 } PREC_DIR;
=20
 void precompose_argv(int argc, const char **argv);
-void probe_utf8_pathname_composition(char *, int);
=20
 PREC_DIR *precompose_utf8_opendir(const char *dirname);
 struct dirent_prec_psx *precompose_utf8_readdir(PREC_DIR *dirp);
diff --git a/config.c b/config.c
index e13a7b6..c181767 100644
--- a/config.c
+++ b/config.c
@@ -827,7 +827,7 @@ static int git_default_core_config(const char *var,=
 const char *value)
 	}
=20
 	if (!strcmp(var, "core.precomposeunicode")) {
-		precomposed_unicode =3D git_config_bool(var, value);
+		precompose_unicode =3D git_config_bool(var, value);
 		return 0;
 	}
=20
diff --git a/environment.c b/environment.c
index 0cb67b2..b98f14b 100644
--- a/environment.c
+++ b/environment.c
@@ -58,7 +58,7 @@ char *notes_ref_name;
 int grafts_replace_parents =3D 1;
 int core_apply_sparse_checkout;
 int merge_log_config =3D -1;
-int precomposed_unicode =3D -1; /* see probe_utf8_pathname_composition=
() */
+int precompose_unicode =3D 1; /* default: true */
 struct startup_info *startup_info;
 unsigned long pack_size_limit_cfg;
=20
diff --git a/git-compat-util.h b/git-compat-util.h
index cc4ba4d..3f6f27c 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -185,7 +185,6 @@ typedef unsigned long uintptr_t;
 #else
 #define precompose_str(in,i_nfd2nfc)
 #define precompose_argv(c,v)
-#define probe_utf8_pathname_composition(a,b)
 #endif
=20
 #ifdef NEEDS_CLIPPED_WRITE
diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
index 05d78d2..6b3cedc 100755
--- a/t/t0050-filesystem.sh
+++ b/t/t0050-filesystem.sh
@@ -91,6 +91,7 @@ test_expect_failure CASE_INSENSITIVE_FS 'add (with di=
fferent case)' '
 test_expect_success "setup unicode normalization tests" '
 	test_create_repo unicode &&
 	cd unicode &&
+	git config core.precomposeunicode false &&
 	touch "$aumlcdiar" &&
 	git add "$aumlcdiar" &&
 	git commit -m initial &&
diff --git a/t/t3910-mac-os-precompose.sh b/t/t3910-mac-os-precompose.s=
h
index 5fe57c5..b853d6a 100755
--- a/t/t3910-mac-os-precompose.sh
+++ b/t/t3910-mac-os-precompose.sh
@@ -34,11 +34,6 @@ Alongc=3D$Alongc$Alongc$Alongc$Alongc$Alongc        =
   #50 Byte
 Alongc=3D$Alongc$Alongc$Alongc$Alongc$Alongc           #250 Byte
 Alongc=3D$Alongc$AEligatu$AEligatu                     #254 Byte
=20
-test_expect_success "detect if nfd needed" '
-	precomposeunicode=3D`git config core.precomposeunicode` &&
-	test "$precomposeunicode" =3D false &&
-	git config core.precomposeunicode true
-'
 test_expect_success "setup" '
 	>x &&
 	git add x &&
@@ -140,14 +135,5 @@ test_expect_success "Add long precomposed filename=
" '
 	git add * &&
 	git commit -m "Long filename"
 '
-# Test if the global core.precomposeunicode stops autosensing
-# Must be the last test case
-test_expect_success "respect git config --global core.precomposeunicod=
e" '
-	git config --global core.precomposeunicode true &&
-	rm -rf .git &&
-	git init &&
-	precomposeunicode=3D`git config core.precomposeunicode` &&
-	test "$precomposeunicode" =3D "true"
-'
=20
 test_done
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 5ee97b0..f0f8cde 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -958,7 +958,6 @@ test_expect_success 'submodule with UTF-8 name' '
 		git add sub &&
 		git commit -m "init sub"
 	) &&
-	test_config core.precomposeunicode true &&
 	git submodule add ./"$svname" &&
 	git submodule >&2 &&
 	test -n "$(git submodule | grep "$svname")"
--=20
1.8.3
