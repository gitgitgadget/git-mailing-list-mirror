From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 5/9] longest_ancestor_length(): explicitly filter list before loop
Date: Sat, 29 Sep 2012 08:15:58 +0200
Message-ID: <1348899362-4057-6-git-send-email-mhagger@alum.mit.edu>
References: <1348899362-4057-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 29 08:16:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THqLy-0002Qb-OJ
	for gcvg-git-2@plane.gmane.org; Sat, 29 Sep 2012 08:16:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758415Ab2I2GQd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2012 02:16:33 -0400
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:48225 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758098Ab2I2GQa (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Sep 2012 02:16:30 -0400
X-AuditID: 12074414-b7f846d0000008b8-32-5066923de106
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id AE.04.02232.D3296605; Sat, 29 Sep 2012 02:16:30 -0400 (EDT)
Received: from michael.fritz.box (p57A246BE.dip.t-dialin.net [87.162.70.190])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q8T6G742026219
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 29 Sep 2012 02:16:28 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1348899362-4057-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsUixO6iqGs3KS3AYMEMZouuK91MFg29V5gt
	jp6ysLi9Yj6zxfp3V5kdWD3+vv/A5LFz1l12j4uXlD0+b5ILYInitklKLCkLzkzP07dL4M7Y
	tXI3Y8EVgYp1+5MbGCfwdjFyckgImEg8n/yADcIWk7hwbz2QzcUhJHCZUWLno10sEM5ZJomL
	1xezg1SxCehKLOppZgKxRQTUJCa2HQIrYhaYxCjRs+EBWJGwQKhEW89BRhCbRUBVYuO2ZlYQ
	m1fAWeLUjrPMEOsUJX58XwNmcwq4SPzumQ5WIwRU82jvHdYJjLwLGBlWMcol5pTm6uYmZuYU
	pybrFicn5uWlFula6OVmluilppRuYoQEksgOxiMn5Q4xCnAwKvHwah1PDRBiTSwrrsw9xCjJ
	waQkyvt5QlqAEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRHejGKgct6UxMqq1KJ8mJQ0B4uSOO+3
	xep+QgLpiSWp2ampBalFMFkZDg4lCV7DiUBDBYtS01Mr0jJzShDSTBycIIILZAMP0AZbkELe
	4oLE3OLMdIiiU4yKUuK8IiAJAZBERmke3ABYzL9iFAf6R5hXCKSKB5gu4LpfAQ1mAhq8dFMS
	yOCSRISUVAOjitMUlqsfwr7MrV25X8Q4ZkKtM3PKd32+xxynvpurWyq6a4fdqdq1S1TVNW7V
	RY21SrH8KxcYf819K/00WC+88uICLaMXsn/OSzq9C3Z8FBkRL1CkHH/R1z7lNmcUL9OiYuFz
	WYufBqRdtFnmt/bE1Qtz/7/9Gb87foaRYguj9BPvl4HXTK4osRRnJBpqMRcVJwIA 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206638>

Separate the step of filtering and normalizing elements of the
prefixes list from the iteration that looks for the longest prefix.
This will help keep the function testable after we not only normalize
the paths, but also convert them into real paths.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 path.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/path.c b/path.c
index f455e8e..b255a74 100644
--- a/path.c
+++ b/path.c
@@ -568,6 +568,24 @@ int normalize_path_copy(char *dst, const char *src)
 	return 0;
 }
 
+static int normalize_path_callback(struct string_list_item *item, void *cb_data)
+{
+	char buf[PATH_MAX+1];
+	const char *ceil = item->string;
+	int len = strlen(ceil);
+
+	if (len == 0 || len > PATH_MAX || !is_absolute_path(ceil))
+		return 0;
+	if (normalize_path_copy(buf, ceil) < 0)
+		return 0;
+	len = strlen(buf);
+	if (len > 0 && buf[len-1] == '/')
+		buf[--len] = '\0';
+	free(item->string);
+	item->string = xstrdup(buf);
+	return 1;
+}
+
 /*
  * path = Canonical absolute path
  * prefix_list = Colon-separated list of absolute paths
@@ -584,27 +602,19 @@ int normalize_path_copy(char *dst, const char *src)
 int longest_ancestor_length(const char *path, const char *prefix_list)
 {
 	struct string_list prefixes = STRING_LIST_INIT_DUP;
-	char buf[PATH_MAX+1];
 	int i, max_len = -1;
 
 	if (prefix_list == NULL || !strcmp(path, "/"))
 		return -1;
 
 	string_list_split(&prefixes, prefix_list, PATH_SEP, -1);
+	filter_string_list(&prefixes, 0, normalize_path_callback, NULL);
 
 	for (i = 0; i < prefixes.nr; i++) {
 		const char *ceil = prefixes.items[i].string;
 		int len = strlen(ceil);
 
-		if (len == 0 || len > PATH_MAX || !is_absolute_path(ceil))
-			continue;
-		if (normalize_path_copy(buf, ceil) < 0)
-			continue;
-		len = strlen(buf);
-		if (len > 0 && buf[len-1] == '/')
-			buf[--len] = '\0';
-
-		if (!strncmp(path, buf, len) &&
+		if (!strncmp(path, ceil, len) &&
 		    path[len] == '/' &&
 		    len > max_len) {
 			max_len = len;
-- 
1.7.11.3
