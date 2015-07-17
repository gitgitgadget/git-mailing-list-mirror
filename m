From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 10/18] rerere: explain the primary codepath
Date: Fri, 17 Jul 2015 15:24:32 -0700
Message-ID: <1437171880-21590-11-git-send-email-gitster@pobox.com>
References: <1435730699-9124-1-git-send-email-gitster@pobox.com>
 <1437171880-21590-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 18 00:25:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGE40-00049A-GM
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jul 2015 00:25:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756180AbbGQWZA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 18:25:00 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:36679 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756171AbbGQWY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 18:24:58 -0400
Received: by pdjr16 with SMTP id r16so69016609pdj.3
        for <git@vger.kernel.org>; Fri, 17 Jul 2015 15:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=eNyN/mjHblreU2/gGbB3P0+pNJ/r7E1PW16q0kw73po=;
        b=wkVK10vnox/p/xgepGUOYT4JQb/as4603yszZVD7SaC9FClwk5FtyA0Lqhr0fwLiZ3
         OwcsdqkQkJFvMFA15gXoMsHtzRUmzrk9lG23ar9r3gC1RveJqZOE1uAoItSp4EYiO8o7
         lW1nqjtHcrCPTw/lM+E8QW3kSNzH66lYeQwmpCpEbQEfbugsR5WlrT53ZSIxy637r5qb
         hHL4clNxHM6XIkAvVjsxuJwupDiXzcCeAehWnka8brFXVAc+gaW2y5FJUyobdGLLf+3I
         1PCA3LRVP7uot5zXtXdDUER6UUJi/D/ZlK3eT5pT5x04z4Lk8FFnvV2NxdBqy+WvSqUH
         Al3A==
X-Received: by 10.70.129.232 with SMTP id nz8mr33976162pdb.159.1437171898470;
        Fri, 17 Jul 2015 15:24:58 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:902a:e9ec:1aae:aea2])
        by smtp.gmail.com with ESMTPSA id kw5sm12384428pab.29.2015.07.17.15.24.57
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 17 Jul 2015 15:24:57 -0700 (PDT)
X-Mailer: git-send-email 2.5.0-rc2-340-g0cccc16
In-Reply-To: <1437171880-21590-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274115>

Explain the internals of rerere as in-code comments, while
sprinkling "NEEDSWORK" comment to highlight iffy bits and
questionable assumptions.

This one covers the codepath reached from rerere(), the primary
interface to the subsystem.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 rerere.c | 95 +++++++++++++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 82 insertions(+), 13 deletions(-)

diff --git a/rerere.c b/rerere.c
index d54bdb2..3d9c33b 100644
--- a/rerere.c
+++ b/rerere.c
@@ -199,6 +199,21 @@ static int is_cmarker(char *buf, int marker_char, int marker_size)
 	return isspace(*buf);
 }
 
+/*
+ * Read contents a file with conflicts, normalize the conflicts
+ * by (1) discarding the common ancestor version in diff3-style,
+ * (2) reordering our side and their side so that whichever sorts
+ * alphabetically earlier comes before the other one, while
+ * computing the "conflict ID", which is just an SHA-1 hash of
+ * one side of the conflict, NUL, the other side of the conflict,
+ * and NUL concatenated together.
+ *
+ * Return the number of conflict hunks found.
+ *
+ * NEEDSWORK: the logic and theory of operation behind this conflict
+ * normalization may deserve to be documented somewhere, perhaps in
+ * Documentation/technical/rerere.txt.
+ */
 static int handle_path(unsigned char *sha1, struct rerere_io *io, int marker_size)
 {
 	git_SHA_CTX ctx;
@@ -269,6 +284,10 @@ static int handle_path(unsigned char *sha1, struct rerere_io *io, int marker_siz
 	return hunk_no;
 }
 
+/*
+ * Scan the path for conflicts, do the "handle_path()" thing above, and
+ * return the number of conflict hunks found.
+ */
 static int handle_file(const char *path, unsigned char *sha1, const char *output)
 {
 	int hunk_no = 0;
@@ -506,29 +525,54 @@ int rerere_remaining(struct string_list *merge_rr)
 	return 0;
 }
 
+/*
+ * Find the conflict identified by "name"; the change between its
+ * "preimage" (i.e. a previous contents with conflict markers) and its
+ * "postimage" (i.e. the corresponding contents with conflicts
+ * resolved) may apply cleanly to the contents stored in "path", i.e.
+ * the conflict this time around.
+ *
+ * Returns 0 for successful replay of recorded resolution, or non-zero
+ * for failure.
+ */
 static int merge(const char *name, const char *path)
 {
 	int ret;
 	mmfile_t cur = {NULL, 0}, base = {NULL, 0}, other = {NULL, 0};
 	mmbuffer_t result = {NULL, 0};
 
+	/*
+	 * Normalize the conflicts in path and write it out to
+	 * "thisimage" temporary file.
+	 */
 	if (handle_file(path, NULL, rerere_path(name, "thisimage")) < 0)
 		return 1;
 
 	if (read_mmfile(&cur, rerere_path(name, "thisimage")) ||
-			read_mmfile(&base, rerere_path(name, "preimage")) ||
-			read_mmfile(&other, rerere_path(name, "postimage"))) {
+	    read_mmfile(&base, rerere_path(name, "preimage")) ||
+	    read_mmfile(&other, rerere_path(name, "postimage"))) {
 		ret = 1;
 		goto out;
 	}
+
+	/*
+	 * A three-way merge. Note that this honors user-customizable
+	 * low-level merge driver settings.
+	 */
 	ret = ll_merge(&result, path, &base, NULL, &cur, "", &other, "", NULL);
 	if (!ret) {
 		FILE *f;
 
+		/*
+		 * A successful replay of recorded resolution.
+		 * Mark that "postimage" was used to help gc.
+		 */
 		if (utime(rerere_path(name, "postimage"), NULL) < 0)
 			warning("failed utime() on %s: %s",
 					rerere_path(name, "postimage"),
 					strerror(errno));
+
+		/* Update "path" with the resolution */
 		f = fopen(path, "w");
 		if (!f)
 			return error("Could not open %s: %s", path,
@@ -581,41 +625,61 @@ static int do_plain_rerere(struct string_list *rr, int fd)
 	find_conflict(&conflict);
 
 	/*
-	 * MERGE_RR records paths with conflicts immediately after merge
-	 * failed.  Some of the conflicted paths might have been hand resolved
-	 * in the working tree since then, but the initial run would catch all
-	 * and register their preimages.
+	 * MERGE_RR records paths with conflicts immediately after
+	 * merge failed.  Some of the conflicted paths might have been
+	 * hand resolved in the working tree since then, but the
+	 * initial run would catch all and register their preimages.
 	 */
-
 	for (i = 0; i < conflict.nr; i++) {
 		const char *path = conflict.items[i].string;
 		if (!string_list_has_string(rr, path)) {
 			unsigned char sha1[20];
 			char *hex;
 			int ret;
+
+			/*
+			 * Ask handle_file() to scan and assign a
+			 * conflict ID.  No need to write anything out
+			 * yet.
+			 */
 			ret = handle_file(path, sha1, NULL);
 			if (ret < 1)
 				continue;
 			hex = xstrdup(sha1_to_hex(sha1));
 			string_list_insert(rr, path)->util = hex;
+
+			/*
+			 * If the directory does not exist, create
+			 * it.  mkdir_in_gitdir() will fail with
+			 * EEXIST if there already is one.
+			 *
+			 * NEEDSWORK: make sure "gc" does not remove
+			 * preimage without removing the directory.
+			 */
 			if (mkdir_in_gitdir(git_path("rr-cache/%s", hex)))
 				continue;
+
+			/*
+			 * We are the first to encounter this
+			 * conflict.  Ask handle_file() to write the
+			 * normalized contents to the "preimage" file.
+			 */
 			handle_file(path, NULL, rerere_path(hex, "preimage"));
 			fprintf(stderr, "Recorded preimage for '%s'\n", path);
 		}
 	}
 
 	/*
-	 * Now some of the paths that had conflicts earlier might have been
-	 * hand resolved.  Others may be similar to a conflict already that
-	 * was resolved before.
+	 * Some of the paths that had conflicts earlier might have
+	 * been resolved by the user.  Others may be similar to a
+	 * conflict already that was resolved before.
 	 */
-
 	for (i = 0; i < rr->nr; i++) {
 		int ret;
 		const char *path = rr->items[i].string;
 		const char *name = (const char *)rr->items[i].util;
 
+		/* Is there a recorded resolution we could attempt to apply? */
 		if (has_rerere_resolution(name)) {
 			if (merge(name, path))
 				continue;
@@ -629,13 +693,13 @@ static int do_plain_rerere(struct string_list *rr, int fd)
 			goto mark_resolved;
 		}
 
-		/* Let's see if we have resolved it. */
+		/* Let's see if the user has resolved it. */
 		ret = handle_file(path, NULL, NULL);
 		if (ret)
 			continue;
 
-		fprintf(stderr, "Recorded resolution for '%s'.\n", path);
 		copy_file(rerere_path(name, "postimage"), path, 0666);
+		fprintf(stderr, "Recorded resolution for '%s'.\n", path);
 	mark_resolved:
 		free(rr->items[i].util);
 		rr->items[i].util = NULL;
@@ -689,6 +753,11 @@ int setup_rerere(struct string_list *merge_rr, int flags)
 	return fd;
 }
 
+/*
+ * The main entry point that is called internally from codepaths that
+ * perform mergy operations, possibly leaving conflicted index entries
+ * and working tree files.
+ */
 int rerere(int flags)
 {
 	struct string_list merge_rr = STRING_LIST_INIT_DUP;
-- 
2.5.0-rc2-340-g0cccc16
