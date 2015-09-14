From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/7] rerere: split conflict ID further
Date: Mon, 14 Sep 2015 16:57:24 -0700
Message-ID: <1442275050-30497-2-git-send-email-gitster@pobox.com>
References: <1442275050-30497-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 01:57:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zbdcw-0006Ad-6D
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 01:57:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752069AbbINX5f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2015 19:57:35 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33579 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751625AbbINX5d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2015 19:57:33 -0400
Received: by pacex6 with SMTP id ex6so157663720pac.0
        for <git@vger.kernel.org>; Mon, 14 Sep 2015 16:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=zlebrsstGGAMkbZoX53lRTIhUCBgjOtNEdZQpsCdYsU=;
        b=mEJJZrCSdgGDyevNAdZO77e/lWz8BjzqAThpfp3jv8zJArTusK7EOrCMsSVhlD25nm
         RNiOhkfRM//q9xKHM/oCrHyFekJp8QisbIDr5gUlrnmrkLX6Ma7hbf1PSO53Jo6J1UA2
         VZwf2r/9jTDBKmWixyCA8wKdDIQ+AeiJclDSPRSGeTqKBnLuUi6fp0rKZwB57qjBXXDi
         Jdul4TUpZYBpxUV6pL84uHLeff1N3GDvfb5fuRaZLwohyHhP7NFM2zJ0+PswV7t/oVB6
         ZiOoVtpbwZgiwKlW9RQfbbW74GABEOAcQJg+3WUj1rT5J2I1cXwD8Z6BbfmBr7EYRQG4
         5XXw==
X-Received: by 10.66.248.72 with SMTP id yk8mr40512453pac.112.1442275053113;
        Mon, 14 Sep 2015 16:57:33 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:1935:6a7f:d949:928e])
        by smtp.gmail.com with ESMTPSA id co4sm18256842pbb.91.2015.09.14.16.57.32
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 14 Sep 2015 16:57:32 -0700 (PDT)
X-Mailer: git-send-email 2.6.0-rc2-164-gdcd5d00
In-Reply-To: <1442275050-30497-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277877>

The plan is to keep assigning the backward compatible conflict ID
based on the hash of the (normalized) text of conflicts, keep using
that conflict ID as the directory name under $GIT_DIR/rr-cache/, but
allow each conflicted path to use a separate "variant" to record
resolutions, i.e. having more than one <preimage,postimage> pairs
under $GIT_DIR/rr-cache/$ID/ directory.  As the first step in that
direction, separate the shared "conflict ID" out of the rerere_id
structure.

The plan is to keep information per $ID in rerere_dir, that can be
shared among rerere_id that is per conflicted path.

When we are done with rerere(), which can be directly called from
other programs like "git apply", "git commit" and "git merge", the
shared rerere_dir structures can be freed entirely, so they are not
reference-counted and they are not freed when we release rerere_id's
that reference them.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 rerere.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 rerere.h |  3 ++-
 2 files changed, 58 insertions(+), 6 deletions(-)

diff --git a/rerere.c b/rerere.c
index 9bef24f..a5d8a06 100644
--- a/rerere.c
+++ b/rerere.c
@@ -8,6 +8,7 @@
 #include "ll-merge.h"
 #include "attr.h"
 #include "pathspec.h"
+#include "sha1-lookup.h"
 
 #define RESOLVED 0
 #define PUNTED 1
@@ -22,6 +23,23 @@ static int rerere_autoupdate;
 
 static char *merge_rr_path;
 
+static int rerere_dir_nr;
+static int rerere_dir_alloc;
+
+static struct rerere_dir {
+	unsigned char sha1[20];
+} **rerere_dir;
+
+static void free_rerere_dirs(void)
+{
+	int i;
+	for (i = 0; i < rerere_dir_nr; i++)
+		free(rerere_dir[i]);
+	free(rerere_dir);
+	rerere_dir_nr = rerere_dir_alloc = 0;
+	rerere_dir = NULL;
+}
+
 static void free_rerere_id(struct string_list_item *item)
 {
 	free(item->util);
@@ -29,7 +47,7 @@ static void free_rerere_id(struct string_list_item *item)
 
 static const char *rerere_id_hex(const struct rerere_id *id)
 {
-	return id->hex;
+	return sha1_to_hex(id->collection->sha1);
 }
 
 const char *rerere_path(const struct rerere_id *id, const char *file)
@@ -40,6 +58,37 @@ const char *rerere_path(const struct rerere_id *id, const char *file)
 	return git_path("rr-cache/%s/%s", rerere_id_hex(id), file);
 }
 
+static const unsigned char *rerere_dir_sha1(size_t i, void *table)
+{
+	struct rerere_dir **rr_dir = table;
+	return rr_dir[i]->sha1;
+}
+
+static struct rerere_dir *find_rerere_dir(const char *hex)
+{
+	unsigned char sha1[20];
+	struct rerere_dir *rr_dir;
+	int pos;
+
+	if (get_sha1_hex(hex, sha1))
+		return NULL; /* BUG */
+	pos = sha1_pos(sha1, rerere_dir, rerere_dir_nr, rerere_dir_sha1);
+	if (pos < 0) {
+		rr_dir = xmalloc(sizeof(*rr_dir));
+		hashcpy(rr_dir->sha1, sha1);
+		pos = -1 - pos;
+
+		/* Make sure the array is big enough ... */
+		ALLOC_GROW(rerere_dir, rerere_dir_nr + 1, rerere_dir_alloc);
+		/* ... and add it in. */
+		rerere_dir_nr++;
+		memmove(rerere_dir + pos + 1, rerere_dir + pos,
+			(rerere_dir_nr - pos - 1) * sizeof(*rerere_dir));
+		rerere_dir[pos] = rr_dir;
+	}
+	return rerere_dir[pos];
+}
+
 static int has_rerere_resolution(const struct rerere_id *id)
 {
 	struct stat st;
@@ -50,7 +99,7 @@ static int has_rerere_resolution(const struct rerere_id *id)
 static struct rerere_id *new_rerere_id_hex(char *hex)
 {
 	struct rerere_id *id = xmalloc(sizeof(*id));
-	strcpy(id->hex, hex);
+	id->collection = find_rerere_dir(hex);
 	return id;
 }
 
@@ -810,12 +859,14 @@ int setup_rerere(struct string_list *merge_rr, int flags)
 int rerere(int flags)
 {
 	struct string_list merge_rr = STRING_LIST_INIT_DUP;
-	int fd;
+	int fd, status;
 
 	fd = setup_rerere(&merge_rr, flags);
 	if (fd < 0)
 		return 0;
-	return do_plain_rerere(&merge_rr, fd);
+	status = do_plain_rerere(&merge_rr, fd);
+	free_rerere_dirs();
+	return status;
 }
 
 static int rerere_forget_one_path(const char *path, struct string_list *rr)
@@ -900,7 +951,7 @@ int rerere_forget(struct pathspec *pathspec)
 static struct rerere_id *dirname_to_id(const char *name)
 {
 	static struct rerere_id id;
-	strcpy(id.hex, name);
+	id.collection = find_rerere_dir(name);
 	return &id;
 }
 
diff --git a/rerere.h b/rerere.h
index ce545d0..faf5a23 100644
--- a/rerere.h
+++ b/rerere.h
@@ -15,8 +15,9 @@ struct pathspec;
  */
 extern void *RERERE_RESOLVED;
 
+struct rerere_dir;
 struct rerere_id {
-	char hex[41];
+	struct rerere_dir *collection;
 };
 
 extern int setup_rerere(struct string_list *, int);
-- 
2.6.0-rc2-164-gdcd5d00
