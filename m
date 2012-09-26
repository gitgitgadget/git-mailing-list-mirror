From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 4/8] longest_ancestor_length(): explicitly filter list before loop
Date: Wed, 26 Sep 2012 21:34:46 +0200
Message-ID: <1348688090-13648-5-git-send-email-mhagger@alum.mit.edu>
References: <1348688090-13648-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 26 21:35:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGxOh-0004jo-Fv
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 21:35:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758330Ab2IZTfh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2012 15:35:37 -0400
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:52589 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758316Ab2IZTfd (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Sep 2012 15:35:33 -0400
X-AuditID: 1207440f-b7fde6d00000095c-08-506359058add
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 06.8E.02396.50953605; Wed, 26 Sep 2012 15:35:33 -0400 (EDT)
Received: from michael.berlin.jpk.com (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q8QJZFfi010704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 26 Sep 2012 15:35:31 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1348688090-13648-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsUixO6iqMsamRxgcOEYj0XXlW4mi4beK8wW
	R09ZWNxeMZ/ZYv27q8wOrB5/339g8tg56y67x8VLyh6fN8kFsERx2yQllpQFZ6bn6dslcGec
	b37KUtAvWDGl9xVLA+MB3i5GDg4JAROJ3vdcXYycQKaYxIV769m6GLk4hAQuM0q8nXqcBcI5
	wyTx7fRPZpAqNgFdiUU9zUwgtoiAmsTEtkNgRcwCkxglejY8YAdJCAsESfzZ8xTMZhFQlXi6
	/SYriM0r4CJx6t8CZoh1ihI/vq8BszkFXCW+bLjABmILAdUcfnWLeQIj7wJGhlWMcok5pbm6
	uYmZOcWpybrFyYl5ealFuiZ6uZkleqkppZsYIYHEv4Oxa73MIUYBDkYlHl4Ph+QAIdbEsuLK
	3EOMkhxMSqK81mFAIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8z7KSAoR4UxIrq1KL8mFS0hws
	SuK86kvU/YQE0hNLUrNTUwtSi2CyMhwcShK8GhFAQwWLUtNTK9Iyc0oQ0kwcnCCCC2QDD9CG
	cJBC3uKCxNzizHSIolOMilLivHYgCQGQREZpHtwAWMy/YhQH+keYNxakigeYLuC6XwENZgIa
	vHQTyOnFJYkIKakGxsm3GqfkfdPYazu9jtNbdVopD1/R9cKpd8XDb+wMvvCdaUkn30/DfLVa
	pfYJ7sWVahN+M6gFqGYai/raFB/96tB/i/XMyZDoo4677We90H/9/Fcje+3WD4m3Trx4Z/bm
	5Zf2H4cuXc1cvfHdYQFL5Vr9r9fVNTz4t5xbuPfFyqS802c3vp0t+lWJpTgj0VCL 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206435>

Separate the step of filtering and normalizing elements of the
prefixes list from the iteration that looks for the longest prefix.
This will help keep the function testable after we not only normalize
the paths, but also convert them into real paths.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 path.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/path.c b/path.c
index 969bc17..6da7029 100644
--- a/path.c
+++ b/path.c
@@ -568,6 +568,25 @@ int normalize_path_copy(char *dst, const char *src)
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
+	memcpy(buf, ceil, len+1);
+	if (normalize_path_copy(buf, buf) < 0)
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
@@ -584,28 +603,19 @@ int normalize_path_copy(char *dst, const char *src)
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
-		memcpy(buf, ceil, len+1);
-		if (normalize_path_copy(buf, buf) < 0)
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
