From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH 2/3] real_path: do not assume '/' is the path seperator
Date: Fri, 27 May 2011 18:00:39 +0200
Message-ID: <1306512040-1468-3-git-send-email-kusmabite@gmail.com>
References: <1306512040-1468-1-git-send-email-kusmabite@gmail.com>
Cc: gitster@pobox.com, johannes.schindelin@gmx.de,
	j.sixt@viscovery.net, Theo Niessink <theo@taletn.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 27 18:01:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPzTD-0000SD-BV
	for gcvg-git-2@lo.gmane.org; Fri, 27 May 2011 18:01:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756056Ab1E0QAx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2011 12:00:53 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:34670 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755674Ab1E0QAw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2011 12:00:52 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so679469ewy.19
        for <git@vger.kernel.org>; Fri, 27 May 2011 09:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=UdxyuJyoJ6TrXtace1sXzvVRfJyKJjCLCsHPyXbXggE=;
        b=fyujfxwuLGLsXdSyF8NRStlenWFfwHbLdGruDUABWrF+qB0mn3sWSPmnt1LHN6FDoF
         Z+pek7qi3M1m/vElKGBIqsphimlzEvr7nr3fOuOENxN1BMnwDSsO/NQi5ZSswwB1u3zB
         b92xC6ALiEggzbpgIIdUqFrglZX8n/nzNdGaU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=mtzcoe6YW9Z8AmzNevVT0wDUf6bHpheL+XFRHF9JuyTjau/LaV3sKWf0v8DbFqkg1y
         cMztCG2qcn24HTP8T2k3am6LLgpDhziZ5vAIaCX1ciIJpJVhiUai/+oIWmyMvD5fdIeX
         s8b6RHKdB8mARQx+L8xHNrWsOA8M7Xg5GNnuo=
Received: by 10.213.98.201 with SMTP id r9mr859563ebn.42.1306512051786;
        Fri, 27 May 2011 09:00:51 -0700 (PDT)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id 10sm1339270een.15.2011.05.27.09.00.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 27 May 2011 09:00:50 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.3775.ga8770a
In-Reply-To: <1306512040-1468-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174627>

From: Theo Niessink <theo@taletn.com>

real_path currently assumes it's input had '/' as path seperator.
This assumption does not hold true for the code-path from
prefix_path (on Windows), where real_path can be called before
normalize_path_copy.

Fix real_path so it doesn't make this assumption. Create a helper
function to reverse-search for the last path-seperator in a string.

Signed-off-by: Theo Niessink <theo@taletn.com>
Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 abspath.c         |    4 ++--
 compat/mingw.h    |    9 +++++++++
 git-compat-util.h |    4 ++++
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/abspath.c b/abspath.c
index 3005aed..01858eb 100644
--- a/abspath.c
+++ b/abspath.c
@@ -40,7 +40,7 @@ const char *real_path(const char *path)
 
 	while (depth--) {
 		if (!is_directory(buf)) {
-			char *last_slash = strrchr(buf, '/');
+			char *last_slash = find_last_dir_sep(buf);
 			if (last_slash) {
 				*last_slash = '\0';
 				last_elem = xstrdup(last_slash + 1);
@@ -65,7 +65,7 @@ const char *real_path(const char *path)
 			if (len + strlen(last_elem) + 2 > PATH_MAX)
 				die ("Too long path name: '%s/%s'",
 						buf, last_elem);
-			if (len && buf[len-1] != '/')
+			if (len && !is_dir_sep(buf[len-1]))
 				buf[len++] = '/';
 			strcpy(buf + len, last_elem);
 			free(last_elem);
diff --git a/compat/mingw.h b/compat/mingw.h
index 62eccd3..b188776 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -297,6 +297,15 @@ int winansi_fprintf(FILE *stream, const char *format, ...) __attribute__((format
 
 #define has_dos_drive_prefix(path) (isalpha(*(path)) && (path)[1] == ':')
 #define is_dir_sep(c) ((c) == '/' || (c) == '\\')
+static inline char *mingw_find_last_dir_sep(const char *path)
+{
+	char *ret = NULL;
+	for (; *path; ++path)
+		if (is_dir_sep(*path))
+			ret = (char *)path;
+	return ret;
+}
+#define find_last_dir_sep mingw_find_last_dir_sep
 #define PATH_SEP ';'
 #define PRIuMAX "I64u"
 
diff --git a/git-compat-util.h b/git-compat-util.h
index 40498b3..08d58f1 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -215,6 +215,10 @@ extern char *gitbasename(char *);
 #define is_dir_sep(c) ((c) == '/')
 #endif
 
+#ifndef find_last_dir_sep
+#define find_last_dir_sep(path) strrchr(path, '/')
+#endif
+
 #if __HP_cc >= 61000
 #define NORETURN __attribute__((noreturn))
 #define NORETURN_PTR
-- 
1.7.5.3.3.g435ff
