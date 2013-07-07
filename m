From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 07/22] dir.c: use index api
Date: Sun,  7 Jul 2013 10:11:45 +0200
Message-ID: <1373184720-29767-8-git-send-email-t.gummerer@gmail.com>
References: <1373184720-29767-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@inf.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pclouds@gmail.com, robin.rosenberg@dewire.com, t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 07 10:13:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uvk5g-0005xI-QE
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 10:13:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751961Ab3GGINB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 04:13:01 -0400
Received: from mail-ea0-f182.google.com ([209.85.215.182]:57653 "EHLO
	mail-ea0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751843Ab3GGIMr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 04:12:47 -0400
Received: by mail-ea0-f182.google.com with SMTP id d10so2276198eaj.41
        for <git@vger.kernel.org>; Sun, 07 Jul 2013 01:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=DTkOtdAqRrnyJGyUGL3pUVnu9ZXjOzTE3uiMnEkFKoA=;
        b=JtVSq+q9qxrt53M2qGV/oFV/4t9Ao5SB0kitdw0eufJK5t4FO2XwXuDpd119HlmD0M
         TSDDzHTMm+he4rctwxO1mGnAjnDB7hdv9L/z+duz4yU2cgQxY6oSljuEEYiaICVxJCqL
         1KBg0JC/7nyD+753CtVFGCAf1Zoa5iRzPIgHga7s8tYNgS0PchupgzsDPkMSPRb7iAue
         RDmu6qprpjuye0qHooa9BxK71mK/ExV2KJtxk7RRNJH6ifuWxEoEbGsVQUdcEUHdIx4u
         PV7fkq0gZitgueAamfZY7BcjI0wjiP2MXE60zxToZyphwrZbo12OmCsj/clxUsyc78/z
         JKyQ==
X-Received: by 10.14.95.69 with SMTP id o45mr19638251eef.48.1373184766518;
        Sun, 07 Jul 2013 01:12:46 -0700 (PDT)
Received: from localhost (host252-23-dynamic.0-87-r.retail.telecomitalia.it. [87.0.23.252])
        by mx.google.com with ESMTPSA id b3sm30705229eev.10.2013.07.07.01.12.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 07 Jul 2013 01:12:45 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.453.g1dfc63d
In-Reply-To: <1373184720-29767-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229737>

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 dir.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/dir.c b/dir.c
index 897c874..f4919ba 100644
--- a/dir.c
+++ b/dir.c
@@ -468,19 +468,19 @@ void add_exclude(const char *string, const char *base,
 
 static void *read_skip_worktree_file_from_index(const char *path, size_t *size)
 {
-	int pos, len;
+	int len;
 	unsigned long sz;
 	enum object_type type;
 	void *data;
 	struct index_state *istate = &the_index;
+	struct cache_entry *ce;
 
 	len = strlen(path);
-	pos = index_name_pos(istate, path, len);
-	if (pos < 0)
+	if (!get_index_entry_by_name(istate, path, len, &ce))
 		return NULL;
-	if (!ce_skip_worktree(istate->cache[pos]))
+	if (!ce_skip_worktree(ce))
 		return NULL;
-	data = read_sha1_file(istate->cache[pos]->sha1, &type, &sz);
+	data = read_sha1_file(ce->sha1, &type, &sz);
 	if (!data || type != OBJ_BLOB) {
 		free(data);
 		return NULL;
@@ -968,16 +968,13 @@ static enum exist_status directory_exists_in_index_icase(const char *dirname, in
  */
 static enum exist_status directory_exists_in_index(const char *dirname, int len)
 {
-	int pos;
+	struct cache_entry *ce;
 
 	if (ignore_case)
 		return directory_exists_in_index_icase(dirname, len);
 
-	pos = cache_name_pos(dirname, len);
-	if (pos < 0)
-		pos = -pos-1;
-	while (pos < active_nr) {
-		struct cache_entry *ce = active_cache[pos++];
+	get_cache_entry_by_name(dirname, len, &ce);
+	while (ce) {
 		unsigned char endchar;
 
 		if (strncmp(ce->name, dirname, len))
@@ -989,6 +986,7 @@ static enum exist_status directory_exists_in_index(const char *dirname, int len)
 			return index_directory;
 		if (!endchar && S_ISGITLINK(ce->ce_mode))
 			return index_gitdir;
+		ce = next_cache_entry(ce);
 	}
 	return index_nonexistent;
 }
@@ -1114,7 +1112,6 @@ static int exclude_matches_pathspec(const char *path, int len,
 
 static int get_index_dtype(const char *path, int len)
 {
-	int pos;
 	struct cache_entry *ce;
 
 	ce = cache_name_exists(path, len, 0);
@@ -1131,18 +1128,18 @@ static int get_index_dtype(const char *path, int len)
 	}
 
 	/* Try to look it up as a directory */
-	pos = cache_name_pos(path, len);
-	if (pos >= 0)
+	if (get_cache_entry_by_name(path, len, &ce));
 		return DT_UNKNOWN;
-	pos = -pos-1;
-	while (pos < active_nr) {
-		ce = active_cache[pos++];
+
+	while (ce) {
 		if (strncmp(ce->name, path, len))
 			break;
 		if (ce->name[len] > '/')
 			break;
-		if (ce->name[len] < '/')
+		if (ce->name[len] < '/') {
+			ce = next_cache_entry(ce);
 			continue;
+		}
 		if (!ce_uptodate(ce))
 			break;	/* continue? */
 		return DT_DIR;
-- 
1.8.3.453.g1dfc63d
