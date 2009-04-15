From: Andreas Ericsson <ae@op5.se>
Subject: [PATCH] fetch: Strip usernames from url's before storing them
Date: Wed, 15 Apr 2009 14:16:56 +0200
Message-ID: <1239797816-24582-1-git-send-email-ae@op5.se>
Cc: Andreas Ericsson <ae@op5.se>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 15 14:18:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lu44b-0006FE-QV
	for gcvg-git-2@gmane.org; Wed, 15 Apr 2009 14:18:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757642AbZDOMRF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2009 08:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753353AbZDOMRD
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 08:17:03 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:37604 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752394AbZDOMRB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2009 08:17:01 -0400
Received: by fxm2 with SMTP id 2so2873814fxm.37
        for <git@vger.kernel.org>; Wed, 15 Apr 2009 05:16:59 -0700 (PDT)
Received: by 10.86.83.2 with SMTP id g2mr116489fgb.34.1239797819438;
        Wed, 15 Apr 2009 05:16:59 -0700 (PDT)
Received: from localhost.localdomain ([212.112.174.166])
        by mx.google.com with ESMTPS id 4sm10882603fgg.0.2009.04.15.05.16.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 15 Apr 2009 05:16:58 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.rc0.2.g7cd31
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116607>

When pulling from a remote, the full URL including username
is by default added to the commit message. Since it adds
very little value but could be used by malicious people to
glean valid usernames (with matching hostnames), we're far
better off just stripping the username before storing the
remote URL locally.

Signed-off-by: Andreas Ericsson <ae@op5.se>
---
 builtin-fetch.c |   48 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index 3c998ea..47fba00 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -289,7 +289,48 @@ static int update_local_ref(struct ref *ref,
 	}
 }
 
-static int store_updated_refs(const char *url, const char *remote_name,
+/*
+ * strip username information from the url
+ * This will allocate a new string, or return its argument
+ * if no stripping is necessary.
+ *
+ * The url's we want to catch are the following:
+ *   ssh://[user@]host.xz[:port]/path/to/repo.git/
+ *   [user@]host.xz:/path/to/repo.git/
+ *   http[s]://[user[:password]@]host.xz/path/to/repo.git
+ *
+ * Although git doesn't currently support giving the password
+ * to http url's on the command-line, it's easier to catch
+ * that case too than it is to cater for it specially.
+ */
+static char *anonymize_url(const char *url)
+{
+	char *anon_url;
+	const char *at_sign = strchr(url, '@');
+	size_t prefix_len = 0;
+
+	if (!at_sign)
+		return strdup(url);
+
+	if (!prefixcmp(url, "ssh://"))
+		prefix_len = strlen("ssh://");
+	else if (!prefixcmp(url, "http://"))
+		prefix_len = strlen("http://");
+	else if (!prefixcmp(url, "https://"))
+		prefix_len = strlen("https://");
+	else if (!strchr(at_sign + 1, ':'))
+		return strdup(url);
+
+	anon_url = xcalloc(1, 1 + prefix_len +
+			   ((unsigned long)at_sign - (unsigned long)url));
+	if (prefix_len)
+		memcpy(anon_url, url, prefix_len);
+	memcpy(anon_url + prefix_len, at_sign + 1, strlen(at_sign + 1));
+
+	return anon_url;
+}
+
+static int store_updated_refs(const char *raw_url, const char *remote_name,
 		struct ref *ref_map)
 {
 	FILE *fp;
@@ -298,11 +339,13 @@ static int store_updated_refs(const char *url, const char *remote_name,
 	char note[1024];
 	const char *what, *kind;
 	struct ref *rm;
-	char *filename = git_path("FETCH_HEAD");
+	char *url, *filename = git_path("FETCH_HEAD");
 
 	fp = fopen(filename, "a");
 	if (!fp)
 		return error("cannot open %s: %s\n", filename, strerror(errno));
+
+	url = anonymize_url(raw_url);
 	for (rm = ref_map; rm; rm = rm->next) {
 		struct ref *ref = NULL;
 
@@ -376,6 +419,7 @@ static int store_updated_refs(const char *url, const char *remote_name,
 				fprintf(stderr, " %s\n", note);
 		}
 	}
+	free(url);
 	fclose(fp);
 	if (rc & 2)
 		error("some local refs could not be updated; try running\n"
-- 
1.6.3.rc0.2.g7cd31
