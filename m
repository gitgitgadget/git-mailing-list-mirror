From: Vicent Marti <tanoku@gmail.com>
Subject: [PATCH 04/16] pack-objects: make `pack_name_hash` global
Date: Tue, 25 Jun 2013 01:23:01 +0200
Message-ID: <1372116193-32762-5-git-send-email-tanoku@gmail.com>
References: <1372116193-32762-1-git-send-email-tanoku@gmail.com>
Cc: Vicent Marti <tanoku@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 25 01:23:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrG71-00037D-MB
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 01:23:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752064Ab3FXXXv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 19:23:51 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:60449 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752005Ab3FXXXs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 19:23:48 -0400
Received: by mail-wi0-f175.google.com with SMTP id m6so182463wiv.8
        for <git@vger.kernel.org>; Mon, 24 Jun 2013 16:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=j6b+OV9Y90v2JhVIEZ7l8QnPMtsBjKaVD7mPbUnxKGg=;
        b=TLlRevz+KDrdCYpu1WS94d6u5Ok/zMqIgiqwpMijtsGuJVL2iG9LTnQcO7GE+3Yk29
         FBfAKaJ7Fdo6kJtkSAaDCsIrq5xBzRRdMdL4kXxFGy1iUcaN2j/iKQPN57+CPV0zqjL1
         4pHzDPzeTiLyh09gQA2NxWGOhislc3fG+mJwkF5fLElTuO5NszKH+WxOt3ydKZVgYb61
         Ue0Gsoo+Qv+NbgufA2EnKgshVPzXoQt+yJ2TvBXB6R0vkOez7w2dLThpZjGF+2NiZjbh
         AvIFKqpJpneU1+rgWS5KikekpID6AhF+MM/yTPltIUFDfV3MJES5si0TRYrMigvXmub5
         TdfA==
X-Received: by 10.194.20.97 with SMTP id m1mr18096664wje.31.1372116226715;
        Mon, 24 Jun 2013 16:23:46 -0700 (PDT)
Received: from localhost.localdomain (212.Red-81-32-36.dynamicIP.rima-tde.net. [81.32.36.212])
        by mx.google.com with ESMTPSA id x13sm593766wib.3.2013.06.24.16.23.44
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 24 Jun 2013 16:23:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1372116193-32762-1-git-send-email-tanoku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228921>

The hash function used by `builtin/pack-objects.c` to efficiently find
delta bases when packing can be of interest for other parts of Git that
also have to deal with delta bases.
---
 builtin/pack-objects.c |   24 ++----------------------
 cache.h                |    2 ++
 sha1_file.c            |   20 ++++++++++++++++++++
 3 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index fc12df8..b7cab18 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -854,26 +854,6 @@ static struct object_entry *locate_object_entry(const unsigned char *sha1)
 	return NULL;
 }
 
-static unsigned name_hash(const char *name)
-{
-	unsigned c, hash = 0;
-
-	if (!name)
-		return 0;
-
-	/*
-	 * This effectively just creates a sortable number from the
-	 * last sixteen non-whitespace characters. Last characters
-	 * count "most", so things that end in ".c" sort together.
-	 */
-	while ((c = *name++) != 0) {
-		if (isspace(c))
-			continue;
-		hash = (hash >> 2) + (c << 24);
-	}
-	return hash;
-}
-
 static void setup_delta_attr_check(struct git_attr_check *check)
 {
 	static struct git_attr *attr_delta;
@@ -977,7 +957,7 @@ static int add_object_entry_1(const unsigned char *sha1, enum object_type type,
 static int add_object_entry(const unsigned char *sha1, enum object_type type,
 			    const char *name, int exclude)
 {
-	if (add_object_entry_1(sha1, type, name_hash(name), exclude, NULL, 0)) {
+	if (add_object_entry_1(sha1, type, pack_name_hash(name), exclude, NULL, 0)) {
 		struct object_entry *entry = objects[nr_objects - 1];
 
 		if (name && no_try_delta(name))
@@ -1186,7 +1166,7 @@ static void add_preferred_base_object(const char *name)
 {
 	struct pbase_tree *it;
 	int cmplen;
-	unsigned hash = name_hash(name);
+	unsigned hash = pack_name_hash(name);
 
 	if (!num_preferred_base || check_pbase_path(hash))
 		return;
diff --git a/cache.h b/cache.h
index a29645e..95ef14d 100644
--- a/cache.h
+++ b/cache.h
@@ -653,6 +653,8 @@ extern char *sha1_pack_index_name(const unsigned char *sha1);
 extern const char *find_unique_abbrev(const unsigned char *sha1, int);
 extern const unsigned char null_sha1[20];
 
+extern uint32_t pack_name_hash(const char *name);
+
 static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
 {
 	int i;
diff --git a/sha1_file.c b/sha1_file.c
index 371e295..44c7bca 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -60,6 +60,26 @@ static struct cached_object empty_tree = {
 	0
 };
 
+uint32_t pack_name_hash(const char *name)
+{
+	unsigned c, hash = 0;
+
+	if (!name)
+		return 0;
+
+	/*
+	 * This effectively just creates a sortable number from the
+	 * last sixteen non-whitespace characters. Last characters
+	 * count "most", so things that end in ".c" sort together.
+	 */
+	while ((c = *name++) != 0) {
+		if (isspace(c))
+			continue;
+		hash = (hash >> 2) + (c << 24);
+	}
+	return hash;
+}
+
 static struct packed_git *last_found_pack;
 
 static struct cached_object *find_cached_object(const unsigned char *sha1)
-- 
1.7.9.5
