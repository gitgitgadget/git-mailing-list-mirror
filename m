From: Timur Sufiev <timur@iris-comp.ru>
Subject: [PATCH 2/4] Add I18N-wrappers for low-level IO-routines
Date: Tue, 27 Oct 2009 16:54:01 +0300
Message-ID: <1256651643-18382-2-git-send-email-timur@iris-comp.ru>
References: <1256651643-18382-1-git-send-email-timur@iris-comp.ru>
Cc: Timur Sufiev <timur@iris-comp.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 27 15:03:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2meM-00053H-T1
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 15:03:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755460AbZJ0ODM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2009 10:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755428AbZJ0ODL
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 10:03:11 -0400
Received: from [195.93.180.178] ([195.93.180.178]:52021 "EHLO
	mail.iris-comp.ru" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1755432AbZJ0ODF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2009 10:03:05 -0400
Received: from localhost (unknown [80.90.116.82])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.iris-comp.ru (Postfix) with ESMTPSA id C75D6E999;
	Tue, 27 Oct 2009 16:54:39 +0300 (MSK)
X-Mailer: git-send-email 1.6.5.1
In-Reply-To: <1256651643-18382-1-git-send-email-timur@iris-comp.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Timur Sufiev <timur@iris-comp.ru>
---
 Makefile  |    2 +
 io-i18n.c |  129 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 io-i18n.h |   23 +++++++++++
 3 files changed, 154 insertions(+), 0 deletions(-)
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
diff --git a/io-i18n.c b/io-i18n.c
index 4dcc2db..9d89ac3 100644
--- a/io-i18n.c
+++ b/io-i18n.c
@@ -1,3 +1,4 @@
+#include "io-i18n.h"
 #include "utf8.h"
 #include "cache.h"
 
@@ -80,3 +81,131 @@ char *filename_to_local(const char *filename)
 	return NULL;
 #endif
 }
+
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
+int open_i18n(const char *filename, int flags, mode_t mode)
+{
+	int ret;
+	char *out = filename_to_local(filename);
+
+	if (out != NULL) {
+		ret = open(out, flags, mode);
+		free(out);
+	} else
+		ret = open(filename, flags, mode);
+	return ret;
+}
+
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
+
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
diff --git a/io-i18n.h b/io-i18n.h
new file mode 100644
index 0000000..c386e20
--- /dev/null
+++ b/io-i18n.h
@@ -0,0 +1,23 @@
+#ifndef GIT_IO_I18N_H
+#define GIT_IO_I18N_H
+
+#define _FILE_OFFSET_BITS 64
+
+#include <sys/stat.h>
+#include <dirent.h>
+#include <stdio.h>
+
+#define DEFAULT_OPEN_MODE 0
+
+char *filename_to_local (const char* filename);
+int stat_i18n(const char *filename, struct stat *buf);
+int lstat_i18n(const char *filename, struct stat *buf);
+DIR* opendir_i18n(const char *dirname);
+struct dirent *readdir_i18n(DIR *dirstream);
+int open_i18n(const char *filename, int flags, mode_t mode);
+FILE *fopen_i18n(const char *filename, const char *opentype);
+int chmod_i18n(const char *filename, mode_t mode);
+int link_i18n(const char *oldname, const char *newname);
+int unlink_i18n(const char *filename);
+
+#endif /* GIT_IO_I18N_H */
-- 
1.6.5.1
