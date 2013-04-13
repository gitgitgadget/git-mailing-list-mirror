From: Lukas Fleischer <git@cryptocrack.de>
Subject: [PATCH v2 1/3] Add public function read_blob_data_from_index_path()
Date: Sat, 13 Apr 2013 15:28:30 +0200
Message-ID: <1365859712-8400-1-git-send-email-git@cryptocrack.de>
References: <1365787573-597-1-git-send-email-git@cryptocrack.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 13 15:28:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UR0Vi-00028h-P6
	for gcvg-git-2@plane.gmane.org; Sat, 13 Apr 2013 15:28:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753491Ab3DMN2i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Apr 2013 09:28:38 -0400
Received: from elnino.cryptocrack.de ([46.165.227.75]:28364 "EHLO
	elnino.cryptocrack.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753131Ab3DMN2h (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Apr 2013 09:28:37 -0400
Received: from localhost (p57B40B0C.dip.t-dialin.net [87.180.11.12])
	by elnino.cryptocrack.de (OpenSMTPD) with ESMTP id eb153e07
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128)
	for <git@vger.kernel.org>; Sat, 13 Apr 2013 15:28:33 +0200 (CEST)
X-Mailer: git-send-email 1.8.2.675.gda3bb24.dirty
In-Reply-To: <1365787573-597-1-git-send-email-git@cryptocrack.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221062>

* Make the read_index_data() function public, rename it to
  read_blob_data_from_index_path() and move it from attr.c to
  read-cache.c.

* Add a use_index parameter to specify a custom index_state since we are
  no longer enable to access the static use_index variable from attr.c.

This allows for reusing the function in convert.c later.

Signed-off-by: Lukas Fleischer <git@cryptocrack.de>
---
 attr.c       | 35 +----------------------------------
 cache.h      |  1 +
 read-cache.c | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 36 insertions(+), 34 deletions(-)

diff --git a/attr.c b/attr.c
index 689bc2a..08347b6 100644
--- a/attr.c
+++ b/attr.c
@@ -381,46 +381,13 @@ static struct attr_stack *read_attr_from_file(const char *path, int macro_ok)
 	return res;
 }
 
-static void *read_index_data(const char *path)
-{
-	int pos, len;
-	unsigned long sz;
-	enum object_type type;
-	void *data;
-	struct index_state *istate = use_index ? use_index : &the_index;
-
-	len = strlen(path);
-	pos = index_name_pos(istate, path, len);
-	if (pos < 0) {
-		/*
-		 * We might be in the middle of a merge, in which
-		 * case we would read stage #2 (ours).
-		 */
-		int i;
-		for (i = -pos - 1;
-		     (pos < 0 && i < istate->cache_nr &&
-		      !strcmp(istate->cache[i]->name, path));
-		     i++)
-			if (ce_stage(istate->cache[i]) == 2)
-				pos = i;
-	}
-	if (pos < 0)
-		return NULL;
-	data = read_sha1_file(istate->cache[pos]->sha1, &type, &sz);
-	if (!data || type != OBJ_BLOB) {
-		free(data);
-		return NULL;
-	}
-	return data;
-}
-
 static struct attr_stack *read_attr_from_index(const char *path, int macro_ok)
 {
 	struct attr_stack *res;
 	char *buf, *sp;
 	int lineno = 0;
 
-	buf = read_index_data(path);
+	buf = read_blob_data_from_index_path(path, use_index);
 	if (!buf)
 		return NULL;
 
diff --git a/cache.h b/cache.h
index ba5a47c..2a206aa 100644
--- a/cache.h
+++ b/cache.h
@@ -471,6 +471,7 @@ extern int add_file_to_index(struct index_state *, const char *path, int flags);
 extern struct cache_entry *make_cache_entry(unsigned int mode, const unsigned char *sha1, const char *path, int stage, int refresh);
 extern int ce_same_name(struct cache_entry *a, struct cache_entry *b);
 extern int index_name_is_other(const struct index_state *, const char *, int);
+extern void *read_blob_data_from_index_path(const char *path, struct index_state *use_index);
 
 /* do stat comparison even if CE_VALID is true */
 #define CE_MATCH_IGNORE_VALID		01
diff --git a/read-cache.c b/read-cache.c
index 5a9704f..964ae26 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1899,3 +1899,37 @@ int index_name_is_other(const struct index_state *istate, const char *name,
 	}
 	return 1;
 }
+
+void *read_blob_data_from_index_path(const char *path,
+				     struct index_state *use_index)
+{
+	int pos, len;
+	unsigned long sz;
+	enum object_type type;
+	void *data;
+	struct index_state *istate = use_index ? use_index : &the_index;
+
+	len = strlen(path);
+	pos = index_name_pos(istate, path, len);
+	if (pos < 0) {
+		/*
+		 * We might be in the middle of a merge, in which
+		 * case we would read stage #2 (ours).
+		 */
+		int i;
+		for (i = -pos - 1;
+		     (pos < 0 && i < istate->cache_nr &&
+		      !strcmp(istate->cache[i]->name, path));
+		     i++)
+			if (ce_stage(istate->cache[i]) == 2)
+				pos = i;
+	}
+	if (pos < 0)
+		return NULL;
+	data = read_sha1_file(istate->cache[pos]->sha1, &type, &sz);
+	if (!data || type != OBJ_BLOB) {
+		free(data);
+		return NULL;
+	}
+	return data;
+}
-- 
1.8.2.675.gda3bb24.dirty
