From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 16/18] rerere: call conflict-ids IDs
Date: Fri, 17 Jul 2015 15:24:38 -0700
Message-ID: <1437171880-21590-17-git-send-email-gitster@pobox.com>
References: <1435730699-9124-1-git-send-email-gitster@pobox.com>
 <1437171880-21590-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 18 00:25:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGE4f-0004UC-Hz
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jul 2015 00:25:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756194AbbGQWZj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 18:25:39 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:34137 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756190AbbGQWZH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 18:25:07 -0400
Received: by pdbbh15 with SMTP id bh15so22525629pdb.1
        for <git@vger.kernel.org>; Fri, 17 Jul 2015 15:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=B0mKjqGSDyoZLmOU5oF5twYAuOBlwUJlQrWQCbyx2Ng=;
        b=Q0wF0f5lbhfJVMg9ToIQhzkNXWlBPTJTOMEQuhBCkqsCedTI5ybNuon/GZXDLpS8UG
         3ziUynZ4MXvwDjpHEse2c1ypBYVjHLpaunQO3V9fOvEGfe+EtOqx9o8SkIg5LHeNZljk
         3e7RfnITZC7EdgDm2yOU4a5nhoS7IEvcbKWrvrltbaQQfsSCTtipOoFiRVfLPabMM+q0
         41D7Kb6/NZvrnYn4H6G9ZF9Uen3rBwx3wwcnW8aeZbXgxk7cCMJRG2wHry177FAowk0d
         ShxWlmLPO9PzO68ML6UvAzuTBLCD3aIkBSY5zb7kRZyouajiFm5kXUXEDnogsW6HOedC
         aT2A==
X-Received: by 10.66.140.98 with SMTP id rf2mr34365214pab.138.1437171906692;
        Fri, 17 Jul 2015 15:25:06 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:902a:e9ec:1aae:aea2])
        by smtp.gmail.com with ESMTPSA id zx1sm12294099pbb.73.2015.07.17.15.25.06
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 17 Jul 2015 15:25:06 -0700 (PDT)
X-Mailer: git-send-email 2.5.0-rc2-340-g0cccc16
In-Reply-To: <1437171880-21590-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274126>

Most places we call conflict IDs "name" and some others we call them
"hex"; update all of them to "id".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/rerere.c |  4 +--
 rerere.c         | 76 ++++++++++++++++++++++++++++----------------------------
 rerere.h         |  2 +-
 3 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/builtin/rerere.c b/builtin/rerere.c
index 98eb8c5..81730bb 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -103,8 +103,8 @@ int cmd_rerere(int argc, const char **argv, const char *prefix)
 	} else if (!strcmp(argv[0], "diff"))
 		for (i = 0; i < merge_rr.nr; i++) {
 			const char *path = merge_rr.items[i].string;
-			const char *name = (const char *)merge_rr.items[i].util;
-			diff_two(rerere_path(name, "preimage"), path, path, path);
+			const char *id = (const char *)merge_rr.items[i].util;
+			diff_two(rerere_path(id, "preimage"), path, path, path);
 		}
 	else
 		usage_with_options(rerere_usage, options);
diff --git a/rerere.c b/rerere.c
index 30bdfeb..e68469a 100644
--- a/rerere.c
+++ b/rerere.c
@@ -22,15 +22,15 @@ static int rerere_autoupdate;
 
 static char *merge_rr_path;
 
-const char *rerere_path(const char *hex, const char *file)
+const char *rerere_path(const char *id, const char *file)
 {
-	return git_path("rr-cache/%s/%s", hex, file);
+	return git_path("rr-cache/%s/%s", id, file);
 }
 
-static int has_rerere_resolution(const char *hex)
+static int has_rerere_resolution(const char *id)
 {
 	struct stat st;
-	return !stat(rerere_path(hex, "postimage"), &st);
+	return !stat(rerere_path(id, "postimage"), &st);
 }
 
 /*
@@ -530,7 +530,7 @@ int rerere_remaining(struct string_list *merge_rr)
 }
 
 /*
- * Find the conflict identified by "name"; the change between its
+ * Find the conflict identified by "id"; the change between its
  * "preimage" (i.e. a previous contents with conflict markers) and its
  * "postimage" (i.e. the corresponding contents with conflicts
  * resolved) may apply cleanly to the contents stored in "path", i.e.
@@ -539,7 +539,7 @@ int rerere_remaining(struct string_list *merge_rr)
  * Returns 0 for successful replay of recorded resolution, or non-zero
  * for failure.
  */
-static int merge(const char *name, const char *path)
+static int merge(const char *id, const char *path)
 {
 	int ret;
 	mmfile_t cur = {NULL, 0}, base = {NULL, 0}, other = {NULL, 0};
@@ -549,12 +549,12 @@ static int merge(const char *name, const char *path)
 	 * Normalize the conflicts in path and write it out to
 	 * "thisimage" temporary file.
 	 */
-	if (handle_file(path, NULL, rerere_path(name, "thisimage")) < 0)
+	if (handle_file(path, NULL, rerere_path(id, "thisimage")) < 0)
 		return 1;
 
-	if (read_mmfile(&cur, rerere_path(name, "thisimage")) ||
-	    read_mmfile(&base, rerere_path(name, "preimage")) ||
-	    read_mmfile(&other, rerere_path(name, "postimage"))) {
+	if (read_mmfile(&cur, rerere_path(id, "thisimage")) ||
+	    read_mmfile(&base, rerere_path(id, "preimage")) ||
+	    read_mmfile(&other, rerere_path(id, "postimage"))) {
 		ret = 1;
 		goto out;
 	}
@@ -571,9 +571,9 @@ static int merge(const char *name, const char *path)
 		 * A successful replay of recorded resolution.
 		 * Mark that "postimage" was used to help gc.
 		 */
-		if (utime(rerere_path(name, "postimage"), NULL) < 0)
+		if (utime(rerere_path(id, "postimage"), NULL) < 0)
 			warning("failed utime() on %s: %s",
-					rerere_path(name, "postimage"),
+					rerere_path(id, "postimage"),
 					strerror(errno));
 
 		/* Update "path" with the resolution */
@@ -631,11 +631,11 @@ static void do_rerere_one_path(struct string_list_item *rr_item,
 			       struct string_list *update)
 {
 	const char *path = rr_item->string;
-	const char *name = (const char *)rr_item->util;
+	const char *id = (const char *)rr_item->util;
 
 	/* Is there a recorded resolution we could attempt to apply? */
-	if (has_rerere_resolution(name)) {
-		if (merge(name, path))
+	if (has_rerere_resolution(id)) {
+		if (merge(id, path))
 			return; /* failed to replay */
 
 		if (rerere_autoupdate)
@@ -646,7 +646,7 @@ static void do_rerere_one_path(struct string_list_item *rr_item,
 				path);
 	} else if (!handle_file(path, NULL, NULL)) {
 		/* The user has resolved it. */
-		copy_file(rerere_path(name, "postimage"), path, 0666);
+		copy_file(rerere_path(id, "postimage"), path, 0666);
 		fprintf(stderr, "Recorded resolution for '%s'.\n", path);
 	} else {
 		return;
@@ -671,7 +671,7 @@ static int do_plain_rerere(struct string_list *rr, int fd)
 	 */
 	for (i = 0; i < conflict.nr; i++) {
 		unsigned char sha1[20];
-		char *hex;
+		char *id;
 		int ret;
 		const char *path = conflict.items[i].string;
 
@@ -686,8 +686,8 @@ static int do_plain_rerere(struct string_list *rr, int fd)
 		ret = handle_file(path, sha1, NULL);
 		if (ret < 1)
 			continue;
-		hex = xstrdup(sha1_to_hex(sha1));
-		string_list_insert(rr, path)->util = hex;
+		id = xstrdup(sha1_to_hex(sha1));
+		string_list_insert(rr, path)->util = id;
 
 		/*
 		 * If the directory does not exist, create
@@ -697,7 +697,7 @@ static int do_plain_rerere(struct string_list *rr, int fd)
 		 * NEEDSWORK: make sure "gc" does not remove
 		 * preimage without removing the directory.
 		 */
-		if (mkdir_in_gitdir(git_path("rr-cache/%s", hex)))
+		if (mkdir_in_gitdir(git_path("rr-cache/%s", id)))
 			continue;
 
 		/*
@@ -705,7 +705,7 @@ static int do_plain_rerere(struct string_list *rr, int fd)
 		 * conflict.  Ask handle_file() to write the
 		 * normalized contents to the "preimage" file.
 		 */
-		handle_file(path, NULL, rerere_path(hex, "preimage"));
+		handle_file(path, NULL, rerere_path(id, "preimage"));
 		fprintf(stderr, "Recorded preimage for '%s'\n", path);
 	}
 
@@ -779,7 +779,7 @@ int rerere(int flags)
 static int rerere_forget_one_path(const char *path, struct string_list *rr)
 {
 	const char *filename;
-	char *hex;
+	char *id;
 	unsigned char sha1[20];
 	int ret;
 	struct string_list_item *item;
@@ -793,8 +793,8 @@ static int rerere_forget_one_path(const char *path, struct string_list *rr)
 		return error("Could not parse conflict hunks in '%s'", path);
 
 	/* Nuke the recorded resolution for the conflict */
-	hex = xstrdup(sha1_to_hex(sha1));
-	filename = rerere_path(hex, "postimage");
+	id = xstrdup(sha1_to_hex(sha1));
+	filename = rerere_path(id, "postimage");
 	if (unlink(filename))
 		return (errno == ENOENT
 			? error("no remembered resolution for %s", path)
@@ -805,7 +805,7 @@ static int rerere_forget_one_path(const char *path, struct string_list *rr)
 	 * conflict in the working tree, run us again to record
 	 * the postimage.
 	 */
-	handle_cache(path, sha1, rerere_path(hex, "preimage"));
+	handle_cache(path, sha1, rerere_path(id, "preimage"));
 	fprintf(stderr, "Updated preimage for '%s'\n", path);
 
 	/*
@@ -814,7 +814,7 @@ static int rerere_forget_one_path(const char *path, struct string_list *rr)
 	 */
 	item = string_list_insert(rr, path);
 	free(item->util);
-	item->util = hex;
+	item->util = id;
 	fprintf(stderr, "Forgot resolution for %s\n", path);
 	return 0;
 }
@@ -850,32 +850,32 @@ int rerere_forget(struct pathspec *pathspec)
 /*
  * Garbage collection support
  */
-static time_t rerere_created_at(const char *name)
+static time_t rerere_created_at(const char *id)
 {
 	struct stat st;
-	return stat(rerere_path(name, "preimage"), &st) ? (time_t) 0 : st.st_mtime;
+	return stat(rerere_path(id, "preimage"), &st) ? (time_t) 0 : st.st_mtime;
 }
 
-static time_t rerere_last_used_at(const char *name)
+static time_t rerere_last_used_at(const char *id)
 {
 	struct stat st;
-	return stat(rerere_path(name, "postimage"), &st) ? (time_t) 0 : st.st_mtime;
+	return stat(rerere_path(id, "postimage"), &st) ? (time_t) 0 : st.st_mtime;
 }
 
 /*
  * Remove the recorded resolution for a given conflict ID
  */
-static void unlink_rr_item(const char *name)
+static void unlink_rr_item(const char *id)
 {
-	unlink(rerere_path(name, "thisimage"));
-	unlink(rerere_path(name, "preimage"));
-	unlink(rerere_path(name, "postimage"));
+	unlink(rerere_path(id, "thisimage"));
+	unlink(rerere_path(id, "preimage"));
+	unlink(rerere_path(id, "postimage"));
 	/*
 	 * NEEDSWORK: what if this rmdir() fails?  Wouldn't we then
 	 * assume that we already have preimage recorded in
 	 * do_plain_rerere()?
 	 */
-	rmdir(git_path("rr-cache/%s", name));
+	rmdir(git_path("rr-cache/%s", id));
 }
 
 void rerere_gc(struct string_list *rr)
@@ -930,9 +930,9 @@ void rerere_clear(struct string_list *merge_rr)
 	int i;
 
 	for (i = 0; i < merge_rr->nr; i++) {
-		const char *name = (const char *)merge_rr->items[i].util;
-		if (!has_rerere_resolution(name))
-			unlink_rr_item(name);
+		const char *id = (const char *)merge_rr->items[i].util;
+		if (!has_rerere_resolution(id))
+			unlink_rr_item(id);
 	}
 	unlink_or_warn(git_path("MERGE_RR"));
 }
diff --git a/rerere.h b/rerere.h
index 2956c2e..f998eba 100644
--- a/rerere.h
+++ b/rerere.h
@@ -17,7 +17,7 @@ extern void *RERERE_RESOLVED;
 
 extern int setup_rerere(struct string_list *, int);
 extern int rerere(int);
-extern const char *rerere_path(const char *hex, const char *file);
+extern const char *rerere_path(const char *id, const char *file);
 extern int rerere_forget(struct pathspec *);
 extern int rerere_remaining(struct string_list *);
 extern void rerere_clear(struct string_list *);
-- 
2.5.0-rc2-340-g0cccc16
