From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] mingw: introduce the 'core.hideDotFiles' setting
Date: Wed, 4 May 2016 16:40:45 +0200 (CEST)
Message-ID: <17d30bb680a0452efd7b3c4f42e2f94478a86273.1462372716.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Erik Faye-Lund <kusmabite@googlemail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 04 16:41:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axxzO-0003Zr-Ru
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 16:41:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754015AbcEDOlG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 10:41:06 -0400
Received: from mout.gmx.net ([212.227.17.22]:59519 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754431AbcEDOlC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 10:41:02 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MJSuF-1avU4U27X1-0033K1; Wed, 04 May 2016 16:40:45
 +0200
X-X-Sender: virtualbox@virtualbox
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:nYWNUpJPV33NSgErg8YpVrHRo2l/1FN7F8lcXiIv5k3jPPtv1ZD
 tzBo+7VeNbJ+r7aVjN8u0al5Z/rhajtNjOXnvPl7TRsGJuKk1UQFv8jtCksTZNjnNNkcU2R
 7tKZStNJVl5xNwOvL/jtRKJ0rejENekySj450qguXkGZ8QloRmOPHTPXvGqLrpNb33ggqOh
 xRHTVvMvLRZkmcCgkxPGg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZTlIII2dXdI=:HlpPdWWsoVq/a75IsYVJFS
 +1rPIQexyUFI7PX+JO17ekq3v6v1dt4KbTZ/xc4iuDzdae9tOW0VGMjSj6OAbpffM5L5I+e5P
 iyuOh65s5EryTGjyUc5i0Q5Rp/Pg62Kwk7qh2o23GWgcO8/n2Kbd3r2lkAV1152hLrEVpLu8c
 NElMyST1rOzcNFsk2zfBNFka19XrAEOYN4i+FwcAyG7gUY1poA7U/I7MJnEmR8kWPowsdCQvx
 rago8w3LLTkjo6FF9AHjRYiZjhR06HT/aqUskXcFaXmrZ2JOTYn4nfPAlSzWAf3ALfXCAZani
 MbAa+0xmDZMp3Y3zJqiyP06dns94PwXzVwWxo2u7LXMRyRrqsJc2UeSuH4/Aa9N2xc4GHOoGI
 pocnDLO8KOAda3U6riD2O3RFAQyMNEulFiEoS1EUNQsau+MVtGaRdzwFM7EcSQk88NqEu12Pz
 gemjTL2/0ZgFZMabZ9QSZUPO4r+AOXSTDmU2THRnojF5QgGWfxaAes3mcS9F6MaSRcxU2x82Q
 aIeCfS4z6OLUKbIR1v6e77BFbXx7c3Tehrt5nmCVjxIqbEc9IVUmX0ew9hzT7bdtP4QkUCkDb
 T9pkPTCMRnR+MGrRMJege/V7zMxV56gExCMKPUsqQbemyrPWROtBCbdafFTOAUigTAHLwXntc
 UeVqFEjipTAwVJch8upbZjZlIb/jHhTd6PiAB1N/ZCjxbQ/fRToHZVNbGyrZ/tkliPkS7PQKB
 ehZj99XkDFoLqBgKj5wLNinxoB24I4At7CPGO12LDTXkJ9TPbS60mMbOAjOHSr+r2jWzSs6l 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293549>

From: Erik Faye-Lund <kusmabite@googlemail.com>

On Unix (and Linux) it is common that files and directories whose names
start with a dot are not shown by default. This convention is used by Git:
the .git/ directory should be left alone by regular users, and only
accessed through Git itself.

On Windows, no such convention exists. Instead, there is an explicit flag
to mark files or directories as hidden.

In the early days, Git for Windows did not mark the .git/ directory (or
for that matter, any file or directory whose name starts with a dot)
hidden. This lead to quite a bit of confusion, and even loss of data.

Consequently, Git for Windows introduced the core.hideDotFiles setting,
with three possible values: true, false, and dotGitOnly, defaulting to
marking only the .git/ directory as hidden.

The rationale: users do not need to access .git/ directly, and indeed (as
was demonstrated) should not really see that directory, either. However,
not all dot files should be hidden, as e.g. Eclipse does not show them
(and the user would therefore be unable to add, say, a .gitattributes
file).

In over five years since the last attempt to bring this patch into core
Git, this patch has served Git for Windows' users well: no single report
indicated problems with the hidden .git/ directory, and the stream of
problems caused by the previously non-hidden .git/ directory simply
stopped.

Initial-Test-By: Pat Thoyts <patthoyts@users.sourceforge.net>
Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Let's try this again (I will not point you to the previous
	submission, out of personal embarrassment).

	This patch has served us so well in the Git for Windows project
	that there is little sense in hiding it from core Git.

 Documentation/config.txt |  6 ++++++
 builtin/init-db.c        |  1 +
 cache.h                  |  7 +++++++
 compat/mingw.c           | 38 ++++++++++++++++++++++++++++++++++++++
 config.c                 |  8 ++++++++
 environment.c            |  1 +
 git-compat-util.h        |  4 ++++
 t/t0001-init.sh          | 30 ++++++++++++++++++++++++++++++
 8 files changed, 95 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 42d2b50..a9f599d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -269,6 +269,12 @@ See linkgit:git-update-index[1].
 +
 The default is true (when core.filemode is not specified in the config file).
 
+core.hideDotFiles::
+	(Windows-only) If true (which is the default), mark newly-created
+	directories and files whose name starts with a dot as hidden.
+	If 'dotGitOnly', only the .git/ directory is hidden, but no other
+	files starting with a dot.
+
 core.ignoreCase::
 	If true, this option enables various workarounds to enable
 	Git to work better on filesystems that are not case sensitive,
diff --git a/builtin/init-db.c b/builtin/init-db.c
index b2d8d40..c4269ac 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -370,6 +370,7 @@ int init_db(const char *template_dir, unsigned int flags)
 	check_repository_format();
 
 	reinit = create_default_files(template_dir);
+	mark_as_git_dir(get_git_dir());
 
 	create_object_directory();
 
diff --git a/cache.h b/cache.h
index fd728f0..a8e9a62 100644
--- a/cache.h
+++ b/cache.h
@@ -700,6 +700,13 @@ extern int ref_paranoia;
 extern char comment_line_char;
 extern int auto_comment_line_char;
 
+enum hide_dotfiles_type {
+	HIDE_DOTFILES_FALSE = 0,
+	HIDE_DOTFILES_TRUE,
+	HIDE_DOTFILES_DOTGITONLY,
+};
+extern enum hide_dotfiles_type hide_dotfiles;
+
 enum branch_track {
 	BRANCH_TRACK_UNSPECIFIED = -1,
 	BRANCH_TRACK_NEVER = 0,
diff --git a/compat/mingw.c b/compat/mingw.c
index 0413d5c..8b8b01c 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -286,6 +286,33 @@ int mingw_rmdir(const char *pathname)
 	return ret;
 }
 
+static inline int needs_hiding(const char *path)
+{
+	return hide_dotfiles == HIDE_DOTFILES_TRUE &&
+		starts_with(basename((char*)path), ".");
+}
+
+static int make_hidden(const wchar_t *path)
+{
+	DWORD attribs = GetFileAttributesW(path);
+	if (SetFileAttributesW(path, FILE_ATTRIBUTE_HIDDEN | attribs))
+		return 0;
+	errno = err_win_to_posix(GetLastError());
+	return -1;
+}
+
+void mingw_mark_as_git_dir(const char *dir)
+{
+	wchar_t wdir[MAX_PATH];
+	if (hide_dotfiles != HIDE_DOTFILES_FALSE && !is_bare_repository())
+		if (xutftowcs_path(wdir, dir) < 0 || make_hidden(wdir))
+			warning("Failed to make '%s' hidden", dir);
+	git_config_set("core.hideDotFiles",
+		hide_dotfiles == HIDE_DOTFILES_FALSE ? "false" :
+		(hide_dotfiles == HIDE_DOTFILES_DOTGITONLY ?
+		 "dotGitOnly" : "true"));
+}
+
 int mingw_mkdir(const char *path, int mode)
 {
 	int ret;
@@ -293,6 +320,8 @@ int mingw_mkdir(const char *path, int mode)
 	if (xutftowcs_path(wpath, path) < 0)
 		return -1;
 	ret = _wmkdir(wpath);
+	if (!ret && needs_hiding(path))
+		return make_hidden(wpath);
 	return ret;
 }
 
@@ -319,6 +348,9 @@ int mingw_open (const char *filename, int oflags, ...)
 		if (attrs != INVALID_FILE_ATTRIBUTES && (attrs & FILE_ATTRIBUTE_DIRECTORY))
 			errno = EISDIR;
 	}
+	if ((oflags & O_CREAT) && fd >= 0 && needs_hiding(filename) &&
+	    make_hidden(wfilename))
+		warning("Could not mark '%s' as hidden.", filename);
 	return fd;
 }
 
@@ -350,6 +382,7 @@ int mingw_fgetc(FILE *stream)
 #undef fopen
 FILE *mingw_fopen (const char *filename, const char *otype)
 {
+	int hide = needs_hiding(filename) && access(filename, F_OK);
 	FILE *file;
 	wchar_t wfilename[MAX_PATH], wotype[4];
 	if (filename && !strcmp(filename, "/dev/null"))
@@ -358,11 +391,14 @@ FILE *mingw_fopen (const char *filename, const char *otype)
 		xutftowcs(wotype, otype, ARRAY_SIZE(wotype)) < 0)
 		return NULL;
 	file = _wfopen(wfilename, wotype);
+	if (file && hide && make_hidden(wfilename))
+		warning("Could not mark '%s' as hidden.", filename);
 	return file;
 }
 
 FILE *mingw_freopen (const char *filename, const char *otype, FILE *stream)
 {
+	int hide = needs_hiding(filename) && access(filename, F_OK);
 	FILE *file;
 	wchar_t wfilename[MAX_PATH], wotype[4];
 	if (filename && !strcmp(filename, "/dev/null"))
@@ -371,6 +407,8 @@ FILE *mingw_freopen (const char *filename, const char *otype, FILE *stream)
 		xutftowcs(wotype, otype, ARRAY_SIZE(wotype)) < 0)
 		return NULL;
 	file = _wfreopen(wfilename, wotype, stream);
+	if (file && hide && make_hidden(wfilename))
+		warning("Could not mark '%s' as hidden.", filename);
 	return file;
 }
 
diff --git a/config.c b/config.c
index 10b5c95..1b44d46 100644
--- a/config.c
+++ b/config.c
@@ -912,6 +912,14 @@ static int git_default_core_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.hidedotfiles")) {
+		if (value && !strcasecmp(value, "dotgitonly"))
+			hide_dotfiles = HIDE_DOTFILES_DOTGITONLY;
+		else
+			hide_dotfiles = git_config_bool(var, value);
+		return 0;
+	}
+
 	/* Add other config variables here and to Documentation/config.txt. */
 	return 0;
 }
diff --git a/environment.c b/environment.c
index 57acb2f..96160a7 100644
--- a/environment.c
+++ b/environment.c
@@ -63,6 +63,7 @@ int core_apply_sparse_checkout;
 int merge_log_config = -1;
 int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
 unsigned long pack_size_limit_cfg;
+enum hide_dotfiles_type hide_dotfiles = HIDE_DOTFILES_DOTGITONLY;
 
 #ifndef PROTECT_HFS_DEFAULT
 #define PROTECT_HFS_DEFAULT 0
diff --git a/git-compat-util.h b/git-compat-util.h
index 1f8b5f3..ea007e4 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1042,4 +1042,8 @@ struct tm *git_gmtime_r(const time_t *, struct tm *);
 #define getc_unlocked(fh) getc(fh)
 #endif
 
+#ifndef mark_as_git_dir
+#define mark_as_git_dir(x) /* noop */
+#endif
+
 #endif
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index a5b9e7a..a6fdd5e 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -354,4 +354,34 @@ test_expect_success SYMLINKS 're-init to move gitdir symlink' '
 	test_path_is_dir realgitdir/refs
 '
 
+# Tests for the hidden file attribute on windows
+is_hidden () {
+	# Use the output of `attrib`, ignore the absolute path
+	case "$(attrib "$1")" in *H*?:*) return 0;; esac
+	return 1
+}
+
+test_expect_success MINGW '.git hidden' '
+	rm -rf newdir &&
+	(
+		unset GIT_DIR GIT_WORK_TREE
+		mkdir newdir &&
+		cd newdir &&
+		git init &&
+		is_hidden .git
+	) &&
+	check_config newdir/.git false unset
+'
+
+test_expect_success MINGW 'bare git dir not hidden' '
+	rm -rf newdir &&
+	(
+		unset GIT_DIR GIT_WORK_TREE GIT_CONFIG
+		mkdir newdir &&
+		cd newdir &&
+		git --bare init
+	) &&
+	! is_hidden newdir
+'
+
 test_done
-- 
2.8.1.306.gff998f2
