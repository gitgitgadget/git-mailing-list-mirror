From: Timur Sufiev <timur@iris-comp.ru>
Subject: [PATCH 1/4] Add routines for filenames encoding <local encoding> <-> UTF-8
Date: Tue, 27 Oct 2009 16:54:00 +0300
Message-ID: <1256651643-18382-1-git-send-email-timur@iris-comp.ru>
Cc: Timur Sufiev <timur@iris-comp.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 27 15:03:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2meM-00053H-Ct
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 15:03:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755458AbZJ0ODL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2009 10:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755423AbZJ0ODJ
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 10:03:09 -0400
Received: from [195.93.180.178] ([195.93.180.178]:52020 "EHLO
	mail.iris-comp.ru" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1755428AbZJ0ODF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2009 10:03:05 -0400
Received: from localhost (unknown [80.90.116.82])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.iris-comp.ru (Postfix) with ESMTPSA id 77298ADE9;
	Tue, 27 Oct 2009 16:54:38 +0300 (MSK)
X-Mailer: git-send-email 1.6.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131336>

The point is to make Git aware of filenames local encoding and make it
keep all filenames in UTF-8 internally. If
`i18n.filenameslocalencoding' option was set via git-config to a
correct <codepage> encoding, 2 things should be done:

1. Translate all filenames read by READDIR from <codepage> into UTF-8.

2. Translate all filenames passed to IO-routines from UTF-8 into
<codepage>.

Signed-off-by: Timur Sufiev <timur@iris-comp.ru>
---
 cache.h       |    1 +
 config.c      |    3 ++
 environment.c |    1 +
 io-i18n.c     |   82 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 87 insertions(+), 0 deletions(-)
 create mode 100644 io-i18n.c

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
index 0000000..4dcc2db
--- /dev/null
+++ b/io-i18n.c
@@ -0,0 +1,82 @@
+#include "utf8.h"
+#include "cache.h"
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
+static char *filename_to_utf8(const char *filename)
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
-- 
1.6.5.1
