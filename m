From: Wang Hui <Hui.Wang@windriver.com>
Subject: [PATCH v2 3/5] sha1_file: improve directories comparison method
Date: Tue, 6 Sep 2011 18:24:03 +0800
Message-ID: <1315304645-12009-4-git-send-email-Hui.Wang@windriver.com>
References: <1315304645-12009-1-git-send-email-Hui.Wang@windriver.com>
 <1315304645-12009-2-git-send-email-Hui.Wang@windriver.com>
 <1315304645-12009-3-git-send-email-Hui.Wang@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
To: <gitster@pobox.com>, <git@vger.kernel.org>, <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Tue Sep 06 12:24:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0spK-00044q-EM
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 12:24:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754139Ab1IFKYO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 06:24:14 -0400
Received: from mail.windriver.com ([147.11.1.11]:61507 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754133Ab1IFKYL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2011 06:24:11 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id p86ANsN0005033
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 6 Sep 2011 03:23:54 -0700 (PDT)
Received: from localhost.localdomain (128.224.163.220) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
 14.1.255.0; Tue, 6 Sep 2011 03:23:53 -0700
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1315304645-12009-3-git-send-email-Hui.Wang@windriver.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180790>

From: Hui Wang <Hui.Wang@windriver.com>

In the past, to check if two directory paths are same, we use memcmp()
to directly compare their path strings, this method can't get an
accurate result if paths include ".." or "." or redundant slash, e.g.
current dir is /, "/a/b/c", "/a/b//c/d/e/../.." and "./a/b/f/../c"
should be the same dir, but current method will identify they are
different.

Now add a global function is_same_directory() to replace the old
memcmp() method, this function will change two input paths to real
path first, then normalized them and compare them.

Signed-off-by: Hui Wang <Hui.Wang@windriver.com>
---
 abspath.c   |   26 ++++++++++++++++++++++++++
 cache.h     |    1 +
 sha1_file.c |    4 ++--
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/abspath.c b/abspath.c
index 3005aed..7717f06 100644
--- a/abspath.c
+++ b/abspath.c
@@ -138,3 +138,29 @@ const char *absolute_path(const char *path)
 	}
 	return buf;
 }
+
+/* Compare two directories, if they are the same dir, return 1, otherwise
+ * return 0.
+ *
+ * The input path can be relative or absolute one, before the comparison, they
+ * will be changed to real path first, then be normalized to remove .. and
+ * redundant slash, in the end, we will compare two real and normalized paths.
+ */
+int is_same_directory(const char *dir1, const char *dir2)
+{
+	const char *real_path1, *real_path2;
+	char norm_path1[PATH_MAX], norm_path2[PATH_MAX];
+
+	real_path1 = real_path(dir1);
+	if (normalize_path_copy(norm_path1, real_path1))
+		return 0;
+
+	real_path2 = real_path(dir2);
+	if (normalize_path_copy(norm_path2, real_path2))
+		return 0;
+
+	if (strlen(norm_path1) != strlen(norm_path2))
+		return 0;
+
+	return !memcmp(norm_path1, norm_path2, strlen(norm_path1));
+}
diff --git a/cache.h b/cache.h
index e11cf6a..70056b5 100644
--- a/cache.h
+++ b/cache.h
@@ -758,6 +758,7 @@ int longest_ancestor_length(const char *path, const char *prefix_list);
 char *strip_path_suffix(const char *path, const char *suffix);
 int daemon_avoid_alias(const char *path);
 int offset_1st_component(const char *path);
+int is_same_directory(const char *dir1, const char *dir2);
 
 /* object replacement */
 #define READ_SHA1_FILE_REPLACE 1
diff --git a/sha1_file.c b/sha1_file.c
index 5940d84..18f7fb3 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -286,12 +286,12 @@ static int link_alt_odb_entry(const char * entry, int len, const char * relative
 	 * thing twice, or object directory itself.
 	 */
 	for (alt = alt_odb_list; alt; alt = alt->next) {
-		if (!memcmp(ent->base, alt->base, pfxlen)) {
+		if (is_same_directory(ent->base, alt->base)) {
 			free(ent);
 			return -1;
 		}
 	}
-	if (!memcmp(ent->base, objdir, pfxlen)) {
+	if (is_same_directory(ent->base, objdir)) {
 		free(ent);
 		return -1;
 	}
-- 
1.6.3.1
