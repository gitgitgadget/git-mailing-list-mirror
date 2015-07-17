From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 17/18] rerere: use "struct rerere_id" instead of "char *" for conflict ID
Date: Fri, 17 Jul 2015 15:24:39 -0700
Message-ID: <1437171880-21590-18-git-send-email-gitster@pobox.com>
References: <1435730699-9124-1-git-send-email-gitster@pobox.com>
 <1437171880-21590-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 18 00:25:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGE4U-0004PK-L6
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jul 2015 00:25:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754785AbbGQWZa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 18:25:30 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36227 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756196AbbGQWZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 18:25:09 -0400
Received: by pachj5 with SMTP id hj5so67477498pac.3
        for <git@vger.kernel.org>; Fri, 17 Jul 2015 15:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=Tg3PL1zocNewsL2h8x9r9qutlU+Njq65aDPAHV1t0HE=;
        b=k0xR8Jz7rmF7FJQU/12Ep55ZsfuZPk3IHVkpwDBUmlXGCGQlQmXguhePfXfoAlvj8c
         XQNnB6Qs2uSbMr9dEVnWR3dJCf0/62yAk0hZGaCfnue43yA8Lv0AzSQGrNVETcIZiTVW
         XpD0XrH3yvczz5XtZDN/KZayiRpGcspRBSxLT3WAY9RMavrr2gpL9vGI0/T4PGbydZRv
         iKMdKGVdi15i+bCuNqKEqP44M0mZCLx5x9aY/RcMxFutrqQmrGo6GXVk5w4f4zKS9iMU
         qHlJe0+L2jFM5VdCEBjmV72N+kwuzR/3fV40fj+MQ8Ny/obMcUzuo1wXQy2DKkbtaDJQ
         zQbQ==
X-Received: by 10.68.186.2 with SMTP id fg2mr33732433pbc.90.1437171908464;
        Fri, 17 Jul 2015 15:25:08 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:902a:e9ec:1aae:aea2])
        by smtp.gmail.com with ESMTPSA id i4sm12321668pdk.74.2015.07.17.15.25.07
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 17 Jul 2015 15:25:07 -0700 (PDT)
X-Mailer: git-send-email 2.5.0-rc2-340-g0cccc16
In-Reply-To: <1437171880-21590-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274122>

This gives a thin abstraction between the conflict ID that is a hash
value obtained by inspecting the conflicts and the name of the
directory under $GIT_DIR/rr-cache/, in which the previous resolution
is recorded to be replayed.  The plan is to make sure that the
presense of the directory does not imply the presense of a previous
resolution and vice-versa, and later allow us to have more than one
pair of <preimage, postimage> for a given conflict ID.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/rerere.c |  2 +-
 rerere.c         | 99 +++++++++++++++++++++++++++++++++++++++++---------------
 rerere.h         | 12 ++++++-
 3 files changed, 85 insertions(+), 28 deletions(-)

diff --git a/builtin/rerere.c b/builtin/rerere.c
index 81730bb..fd229a7 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -103,7 +103,7 @@ int cmd_rerere(int argc, const char **argv, const char *prefix)
 	} else if (!strcmp(argv[0], "diff"))
 		for (i = 0; i < merge_rr.nr; i++) {
 			const char *path = merge_rr.items[i].string;
-			const char *id = (const char *)merge_rr.items[i].util;
+			const struct rerere_id *id = merge_rr.items[i].util;
 			diff_two(rerere_path(id, "preimage"), path, path, path);
 		}
 	else
diff --git a/rerere.c b/rerere.c
index e68469a..469d8a8 100644
--- a/rerere.c
+++ b/rerere.c
@@ -22,17 +22,43 @@ static int rerere_autoupdate;
 
 static char *merge_rr_path;
 
-const char *rerere_path(const char *id, const char *file)
+static void free_rerere_id(struct string_list_item *item)
 {
-	return git_path("rr-cache/%s/%s", id, file);
+	free(item->util);
+}
+
+static const char *rerere_id_hex(const struct rerere_id *id)
+{
+	return id->hex;
+}
+
+const char *rerere_path(const struct rerere_id *id, const char *file)
+{
+	if (file)
+		return git_path("rr-cache/%s/%s", rerere_id_hex(id), file);
+	else
+		return git_path("rr-cache/%s", rerere_id_hex(id));
 }
 
-static int has_rerere_resolution(const char *id)
+static int has_rerere_resolution(const struct rerere_id *id)
 {
 	struct stat st;
+
 	return !stat(rerere_path(id, "postimage"), &st);
 }
 
+static struct rerere_id *new_rerere_id_hex(char *hex)
+{
+	struct rerere_id *id = xmalloc(sizeof(*id));
+	strcpy(id->hex, hex);
+	return id;
+}
+
+static struct rerere_id *new_rerere_id(unsigned char *sha1)
+{
+	return new_rerere_id_hex(sha1_to_hex(sha1));
+}
+
 /*
  * $GIT_DIR/MERGE_RR file is a collection of records, each of which is
  * "conflict ID", a HT and pathname, terminated with a NUL, and is
@@ -50,6 +76,7 @@ static void read_rr(struct string_list *rr)
 	while (!strbuf_getwholeline(&buf, in, '\0')) {
 		char *path;
 		unsigned char sha1[20];
+		struct rerere_id *id;
 
 		/* There has to be the hash, tab, path and then NUL */
 		if (buf.len < 42 || get_sha1_hex(buf.buf, sha1))
@@ -59,8 +86,8 @@ static void read_rr(struct string_list *rr)
 			die("corrupt MERGE_RR");
 		buf.buf[40] = '\0';
 		path = buf.buf + 41;
-
-		string_list_insert(rr, path)->util = xstrdup(buf.buf);
+		id = new_rerere_id_hex(buf.buf);
+		string_list_insert(rr, path)->util = id;
 	}
 	strbuf_release(&buf);
 	fclose(in);
@@ -73,12 +100,15 @@ static int write_rr(struct string_list *rr, int out_fd)
 	int i;
 	for (i = 0; i < rr->nr; i++) {
 		struct strbuf buf = STRBUF_INIT;
+		struct rerere_id *id;
 
 		assert(rr->items[i].util != RERERE_RESOLVED);
-		if (!rr->items[i].util)
+
+		id = rr->items[i].util;
+		if (!id)
 			continue;
 		strbuf_addf(&buf, "%s\t%s%c",
-			    (char *)rr->items[i].util,
+			    rerere_id_hex(id),
 			    rr->items[i].string, 0);
 		if (write_in_full(out_fd, buf.buf, buf.len) != buf.len)
 			die("unable to write rerere record");
@@ -521,7 +551,7 @@ int rerere_remaining(struct string_list *merge_rr)
 			struct string_list_item *it;
 			it = string_list_lookup(merge_rr, (const char *)e->name);
 			if (it != NULL) {
-				free(it->util);
+				free_rerere_id(it);
 				it->util = RERERE_RESOLVED;
 			}
 		}
@@ -539,7 +569,7 @@ int rerere_remaining(struct string_list *merge_rr)
  * Returns 0 for successful replay of recorded resolution, or non-zero
  * for failure.
  */
-static int merge(const char *id, const char *path)
+static int merge(const struct rerere_id *id, const char *path)
 {
 	int ret;
 	mmfile_t cur = {NULL, 0}, base = {NULL, 0}, other = {NULL, 0};
@@ -573,8 +603,8 @@ static int merge(const char *id, const char *path)
 		 */
 		if (utime(rerere_path(id, "postimage"), NULL) < 0)
 			warning("failed utime() on %s: %s",
-					rerere_path(id, "postimage"),
-					strerror(errno));
+				rerere_path(id, "postimage"),
+				strerror(errno));
 
 		/* Update "path" with the resolution */
 		f = fopen(path, "w");
@@ -631,7 +661,7 @@ static void do_rerere_one_path(struct string_list_item *rr_item,
 			       struct string_list *update)
 {
 	const char *path = rr_item->string;
-	const char *id = (const char *)rr_item->util;
+	const struct rerere_id *id = rr_item->util;
 
 	/* Is there a recorded resolution we could attempt to apply? */
 	if (has_rerere_resolution(id)) {
@@ -651,7 +681,7 @@ static void do_rerere_one_path(struct string_list_item *rr_item,
 	} else {
 		return;
 	}
-	free(rr_item->util);
+	free_rerere_id(rr_item);
 	rr_item->util = NULL;
 }
 
@@ -670,10 +700,10 @@ static int do_plain_rerere(struct string_list *rr, int fd)
 	 * initial run would catch all and register their preimages.
 	 */
 	for (i = 0; i < conflict.nr; i++) {
+		struct rerere_id *id;
 		unsigned char sha1[20];
-		char *id;
-		int ret;
 		const char *path = conflict.items[i].string;
+		int ret;
 
 		if (string_list_has_string(rr, path))
 			continue;
@@ -686,7 +716,8 @@ static int do_plain_rerere(struct string_list *rr, int fd)
 		ret = handle_file(path, sha1, NULL);
 		if (ret < 1)
 			continue;
-		id = xstrdup(sha1_to_hex(sha1));
+
+		id = new_rerere_id(sha1);
 		string_list_insert(rr, path)->util = id;
 
 		/*
@@ -697,7 +728,7 @@ static int do_plain_rerere(struct string_list *rr, int fd)
 		 * NEEDSWORK: make sure "gc" does not remove
 		 * preimage without removing the directory.
 		 */
-		if (mkdir_in_gitdir(git_path("rr-cache/%s", id)))
+		if (mkdir_in_gitdir(rerere_path(id, NULL)))
 			continue;
 
 		/*
@@ -779,7 +810,7 @@ int rerere(int flags)
 static int rerere_forget_one_path(const char *path, struct string_list *rr)
 {
 	const char *filename;
-	char *id;
+	struct rerere_id *id;
 	unsigned char sha1[20];
 	int ret;
 	struct string_list_item *item;
@@ -793,7 +824,7 @@ static int rerere_forget_one_path(const char *path, struct string_list *rr)
 		return error("Could not parse conflict hunks in '%s'", path);
 
 	/* Nuke the recorded resolution for the conflict */
-	id = xstrdup(sha1_to_hex(sha1));
+	id = new_rerere_id(sha1);
 	filename = rerere_path(id, "postimage");
 	if (unlink(filename))
 		return (errno == ENOENT
@@ -813,7 +844,7 @@ static int rerere_forget_one_path(const char *path, struct string_list *rr)
 	 * conflict when the user is done.
 	 */
 	item = string_list_insert(rr, path);
-	free(item->util);
+	free_rerere_id(item);
 	item->util = id;
 	fprintf(stderr, "Forgot resolution for %s\n", path);
 	return 0;
@@ -850,22 +881,38 @@ int rerere_forget(struct pathspec *pathspec)
 /*
  * Garbage collection support
  */
-static time_t rerere_created_at(const char *id)
+
+/*
+ * Note that this is not reentrant but is used only one-at-a-time
+ * so it does not matter right now.
+ */
+static struct rerere_id *dirname_to_id(const char *name)
+{
+	static struct rerere_id id;
+	strcpy(id.hex, name);
+	return &id;
+}
+
+static time_t rerere_created_at(const char *dir_name)
 {
 	struct stat st;
+	struct rerere_id *id = dirname_to_id(dir_name);
+
 	return stat(rerere_path(id, "preimage"), &st) ? (time_t) 0 : st.st_mtime;
 }
 
-static time_t rerere_last_used_at(const char *id)
+static time_t rerere_last_used_at(const char *dir_name)
 {
 	struct stat st;
+	struct rerere_id *id = dirname_to_id(dir_name);
+
 	return stat(rerere_path(id, "postimage"), &st) ? (time_t) 0 : st.st_mtime;
 }
 
 /*
  * Remove the recorded resolution for a given conflict ID
  */
-static void unlink_rr_item(const char *id)
+static void unlink_rr_item(struct rerere_id *id)
 {
 	unlink(rerere_path(id, "thisimage"));
 	unlink(rerere_path(id, "preimage"));
@@ -875,7 +922,7 @@ static void unlink_rr_item(const char *id)
 	 * assume that we already have preimage recorded in
 	 * do_plain_rerere()?
 	 */
-	rmdir(git_path("rr-cache/%s", id));
+	rmdir(rerere_path(id, NULL));
 }
 
 void rerere_gc(struct string_list *rr)
@@ -914,7 +961,7 @@ void rerere_gc(struct string_list *rr)
 	closedir(dir);
 	/* ... and then remove them one-by-one */
 	for (i = 0; i < to_remove.nr; i++)
-		unlink_rr_item(to_remove.items[i].string);
+		unlink_rr_item(dirname_to_id(to_remove.items[i].string));
 	string_list_clear(&to_remove, 0);
 }
 
@@ -930,7 +977,7 @@ void rerere_clear(struct string_list *merge_rr)
 	int i;
 
 	for (i = 0; i < merge_rr->nr; i++) {
-		const char *id = (const char *)merge_rr->items[i].util;
+		struct rerere_id *id = merge_rr->items[i].util;
 		if (!has_rerere_resolution(id))
 			unlink_rr_item(id);
 	}
diff --git a/rerere.h b/rerere.h
index f998eba..ce545d0 100644
--- a/rerere.h
+++ b/rerere.h
@@ -15,9 +15,19 @@ struct pathspec;
  */
 extern void *RERERE_RESOLVED;
 
+struct rerere_id {
+	char hex[41];
+};
+
 extern int setup_rerere(struct string_list *, int);
 extern int rerere(int);
-extern const char *rerere_path(const char *id, const char *file);
+/*
+ * Given the conflict ID and the name of a "file" used for replaying
+ * the recorded resolution (e.g. "preimage", "postimage"), return the
+ * path to that filesystem entity.  With "file" specified with NULL,
+ * return the path to the directory that houses these files.
+ */
+extern const char *rerere_path(const struct rerere_id *, const char *file);
 extern int rerere_forget(struct pathspec *);
 extern int rerere_remaining(struct string_list *);
 extern void rerere_clear(struct string_list *);
-- 
2.5.0-rc2-340-g0cccc16
