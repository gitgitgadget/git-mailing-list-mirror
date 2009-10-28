From: Timur Sufiev <timur@iris-comp.ru>
Subject: [PATCH I18N filenames v2 1/3] Add IO-wrappers for filenames encoding <local encoding> <-> UTF-8
Date: Wed, 28 Oct 2009 21:01:38 +0300
Message-ID: <1256752900-2615-1-git-send-email-timur@iris-comp.ru>
Cc: Timur Sufiev <timur@iris-comp.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 28 19:02:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3CqM-0005ni-VU
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 19:01:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752125AbZJ1SBp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 14:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751992AbZJ1SBp
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 14:01:45 -0400
Received: from [195.93.180.178] ([195.93.180.178]:58939 "EHLO
	mail.iris-comp.ru" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751857AbZJ1SBo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 14:01:44 -0400
Received: from localhost (unknown [80.90.116.82])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.iris-comp.ru (Postfix) with ESMTPSA id A1957E997;
	Wed, 28 Oct 2009 21:01:42 +0300 (MSK)
X-Mailer: git-send-email 1.6.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131486>

The point is to make Git aware of filenames local encoding and make it
keep all filenames in UTF-8 internally. If
`i18n.filenameslocalencoding' option was set via git-config to a
correct <codepage> encoding, 2 things should be done:

1. Translate all filenames read by READDIR from <codepage> into UTF-8.

2. Translate all filenames passed to IO-routines from UTF-8 into
<codepage>.

This patch provides:

1. Routines for reencoding filenames from local encoding into UTF-8
and back (taking `i18n.filenameslocalencoding' into consideration).

2. I18N-wrappers around OPENDIR, READDIR, OPEN, FOPEN, STAT, LSTAT,
CHMOD, LINK AND UNLINK.

3. Makes `git-config' support `i18n.filenameslocalencoding' option.

Signed-off-by: Timur Sufiev <timur@iris-comp.ru>
---
 Makefile      |    2 +
 cache.h       |    1 +
 config.c      |    3 +
 environment.c |    1 +
 io-i18n.c     |  231 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 io-i18n.h     |   33 ++++++++
 6 files changed, 271 insertions(+), 0 deletions(-)
 create mode 100644 io-i18n.c
 create mode 100644 io-i18n.h

diff --git a/Makefile b/Makefile
index 42b7d60..ac8e807 100644
--- a/Makefile
+++ b/Makefile
@@ -459,6 +459,7 @@ LIB_H += tree-walk.h
 LIB_H += unpack-trees.h
 LIB_H += userdiff.h
 LIB_H += utf8.h
+LIB_H += io-i18n.h
 LIB_H += wt-status.h
 
 LIB_OBJS += abspath.o
@@ -562,6 +563,7 @@ LIB_OBJS += unpack-trees.o
 LIB_OBJS += usage.o
 LIB_OBJS += userdiff.o
 LIB_OBJS += utf8.o
+LIB_OBJS += io-i18n.o
 LIB_OBJS += walker.o
 LIB_OBJS += wrapper.o
 LIB_OBJS += write_or_die.o
diff --git a/cache.h b/cache.h
index 96840c7..7f19f7a 100644
--- a/cache.h
+++ b/cache.h
@@ -919,6 +919,7 @@ extern int user_ident_explicitly_given;
 
 extern const char *git_commit_encoding;
 extern const char *git_log_output_encoding;
+extern const char *git_filenames_local_encoding;
 extern const char *git_mailmap_file;
 
 /* IO helper functions */
diff --git a/config.c b/config.c
index c644061..2be6531 100644
--- a/config.c
+++ b/config.c
@@ -539,6 +539,9 @@ static int git_default_i18n_config(const char *var, const char *value)
 	if (!strcmp(var, "i18n.logoutputencoding"))
 		return git_config_string(&git_log_output_encoding, var, value);
 
+	if (!strcmp(var, "i18n.filenameslocalencoding"))
+	     return git_config_string(&git_filenames_local_encoding, var, value);
+
 	/* Add other config variables here and to Documentation/config.txt. */
 	return 0;
 }
diff --git a/environment.c b/environment.c
index 5de6837..b101f7b 100644
--- a/environment.c
+++ b/environment.c
@@ -24,6 +24,7 @@ int warn_ambiguous_refs = 1;
 int repository_format_version;
 const char *git_commit_encoding;
 const char *git_log_output_encoding;
+const char *git_filenames_local_encoding;
 int shared_repository = PERM_UMASK;
 const char *apply_default_whitespace;
 const char *apply_default_ignorewhitespace;
diff --git a/io-i18n.c b/io-i18n.c
new file mode 100644
index 0000000..ed88a68
--- /dev/null
+++ b/io-i18n.c
@@ -0,0 +1,231 @@
+#include <stdarg.h>
+#include <stddef.h>
+#include "utf8.h"
+#include "cache.h"
+#include "io-i18n.h"
+
+inline static int is_string_ascii(const char *str)
+{
+	int is_ascii = 1;
+
+	for (; *str && is_ascii; str++)
+		is_ascii &= isascii(*str);
+
+	return is_ascii;
+}
+
+char *filename_to_utf8(const char *filename)
+{
+	char *out;
+
+	if (is_string_ascii(filename))
+		return NULL;
+
+#ifndef NO_ICONV
+	if (git_filenames_local_encoding && !is_utf8(filename)) {
+		out = reencode_string(filename,
+				      "utf-8", git_filenames_local_encoding);
+#ifdef DEBUG_I18N
+		fprintf(stderr, "Local -> UTF8 encoding: <%s> -> <%s>\n",
+			filename, out);
+#endif
+		return out;
+	} else if (git_filenames_local_encoding && is_utf8(filename)) {
+#ifdef DEBUG_I18N
+		fprintf(stderr,
+			"Filename <%s> is already utf8-encoded, doing nothing...\n",
+			filename);
+#endif
+		return NULL;
+	} else {
+#ifdef DEBUG_I18N
+		fprintf(stderr, "No local encoding set, doing nothing...\n");
+#endif
+		return NULL;
+	}
+#else /* #ifdef NO_ICONV */
+	warning("No iconv support, doing nothing...\n");
+	return NULL;
+#endif
+}
+
+char *filename_to_local(const char *filename)
+{
+	char *out;
+
+	if (is_string_ascii(filename))
+		return NULL;
+
+#ifndef NO_ICONV
+	if (git_filenames_local_encoding && is_utf8(filename)) {
+		out = reencode_string(filename,
+				      git_filenames_local_encoding, "utf-8");
+#ifdef DEBUG_I18N
+		fprintf(stderr, "UTF8 -> local encoding: <%s> -> <%s>\n",
+			filename, out);
+#endif
+		return out;
+	} else if (git_filenames_local_encoding && !is_utf8(filename)) {
+#ifdef DEBUG_I18N
+		fprintf(stderr,
+			"Filename <%s> is already local-encoded, doing nothing...\n",
+			filename);
+#endif
+		return NULL;
+	} else {
+#ifdef DEBUG_I18N
+		fprintf(stderr, "No local encoding set, doing nothing...\n");
+#endif
+		return NULL;
+	}
+#else /* #ifdef NO_ICONV */
+	warning("No iconv support, doing nothing...\n");
+	return NULL;
+#endif
+}
+
+#undef stat
+int stat_i18n(const char *filename, struct stat *buf)
+{
+	int ret;
+	char *out = filename_to_local(filename);
+
+	if (out != NULL) {
+		ret = stat(out, buf);
+		free(out);
+	} else
+		ret = stat(filename, buf);
+	return ret;
+}
+
+#undef lstat
+int lstat_i18n(const char *filename, struct stat *buf)
+{
+
+	int ret;
+	char *out = filename_to_local(filename);
+
+	if (out != NULL) {
+		ret = lstat(out, buf);
+		free(out);
+	} else
+		ret = lstat(filename, buf);
+	return ret;
+}
+
+#undef link
+int link_i18n(const char *oldname, const char *newname)
+{
+	char *old_out = filename_to_local(oldname);
+	char *new_out = filename_to_local(newname);
+	int ret = link(old_out ? old_out : oldname,
+		       new_out ? new_out : newname);
+
+	if (old_out)
+		free(old_out);
+	if (new_out)
+		free(new_out);
+	return ret;
+}
+
+#undef open
+int open_i18n(const char *filename, int flags, ...)
+{
+	int ret;
+	mode_t mode = 0;
+	char *out = filename_to_local(filename);
+
+	if ( flags & O_CREAT ) {
+		va_list ap;
+
+		va_start(ap, flags);
+		mode = va_arg(ap, int);
+		va_end(ap);
+	}
+
+	if (out != NULL) {
+		ret = open(out, flags, mode);
+		free(out);
+	} else
+		ret = open(filename, flags, mode);
+	return ret;
+}
+
+#undef unlink
+int unlink_i18n(const char *filename)
+{
+	char *out = filename_to_local(filename);
+	int ret;
+
+	if (out) {
+		ret = unlink(out);
+		free(out);
+	} else
+		ret = unlink(filename);
+	return ret;
+}
+
+#undef readdir
+struct dirent *readdir_i18n(DIR * dirstream)
+{
+	struct dirent *de = readdir(dirstream);
+
+	if (de) {
+		char *out = filename_to_utf8(de->d_name);
+
+		if (out) {
+			int len = strlen(out);
+			if (len >= NAME_MAX) {
+				warning("readdir_i18n: converted dir entry name length exceeds NAME_MAX and will be truncated\n");
+				len = NAME_MAX - 1;
+			}
+			memcpy(de->d_name, out, len);
+			de->d_name[len] = '\0';
+			free(out);
+		}
+		return de;
+	} else
+		return NULL;
+}
+
+#undef opendir
+DIR *opendir_i18n(const char *dirname)
+{
+	DIR *dir;
+	char *out = filename_to_local(dirname);
+
+	if (out != NULL) {
+		dir = opendir(out);
+		free(out);
+	} else
+		dir = opendir(dirname);
+	return dir;
+}
+
+#undef fopen
+FILE *fopen_i18n(const char *filename, const char *opentype)
+{
+	FILE *file;
+	char *out = filename_to_local(filename);
+
+	if (out != NULL) {
+		file = fopen(out, opentype);
+		free(out);
+	} else
+		file = fopen(filename, opentype);
+	return file;
+}
+
+#undef chmod
+int chmod_i18n(const char *filename, mode_t mode)
+{
+	int ret;
+	char *out = filename_to_local(filename);
+
+	if (out != NULL) {
+		ret = chmod(out, mode);
+		free(out);
+	} else
+		ret = chmod(filename, mode);
+	return ret;
+}
diff --git a/io-i18n.h b/io-i18n.h
new file mode 100644
index 0000000..2369d31
--- /dev/null
+++ b/io-i18n.h
@@ -0,0 +1,33 @@
+#ifndef GIT_IO_I18N_H
+#define GIT_IO_I18N_H
+
+#define _FILE_OFFSET_BITS 64
+
+#include <sys/stat.h>
+#include <dirent.h>
+#include <stdio.h>
+#include <unistd.h>
+
+char *filename_to_local (const char* filename);
+char *filename_to_utf8(const char *filename);
+int stat_i18n(const char *filename, struct stat *buf);
+int lstat_i18n(const char *filename, struct stat *buf);
+DIR* opendir_i18n(const char *dirname);
+struct dirent *readdir_i18n(DIR *dirstream);
+int open_i18n(const char *filename, int flags, ...);
+FILE *fopen_i18n(const char *filename, const char *opentype);
+int chmod_i18n(const char *filename, mode_t mode);
+int link_i18n(const char *oldname, const char *newname);
+int unlink_i18n(const char *filename);
+
+#define opendir(a) opendir_i18n(a)
+#define fopen(a, b) fopen_i18n(a, b)
+#define chmod(a, b) chmod_i18n(a, b)
+#define open open_i18n
+#define stat(a, b) stat_i18n(a, b)
+#define lstat(a, b) lstat_i18n(a, b)
+#define readdir(a) readdir_i18n(a)
+#define unlink(a) unlink_i18n(a)
+#define link(a, b) link_i18n(a, b)
+
+#endif /* GIT_IO_I18N_H */
-- 
1.6.5.1
