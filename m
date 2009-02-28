From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/6] has_sha1_pack(): refactor "pretend these packs do not
 exist" interface
Date: Sat, 28 Feb 2009 01:15:07 -0800
Message-ID: <cd673c1f17228d272c4b7f81fbb28bc31cf0cac6.1235812035.git.gitster@pobox.com>
References: <cover.1235812035.git.gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 28 10:17:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdLK9-0001wI-RU
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 10:17:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756138AbZB1JPu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2009 04:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756131AbZB1JPs
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Feb 2009 04:15:48 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58388 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755073AbZB1JPZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Feb 2009 04:15:25 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 40E3028C9
	for <git@vger.kernel.org>; Sat, 28 Feb 2009 04:15:23 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4C27228C8 for
 <git@vger.kernel.org>; Sat, 28 Feb 2009 04:15:22 -0500 (EST)
X-Mailer: git-send-email 1.6.2.rc2.99.g9f3bb
In-Reply-To: <cover.1235812035.git.gitster@pobox.com>
X-Pobox-Relay-ID: 5414E8EC-0578-11DE-AA28-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111760>

Most of the callers of this function except only one pass NULL to its last
parameter, ignore_packed.

Introduce has_sha1_kept_pack() function that has the function signature
and the semantics of this function, and convert the sole caller that does
not pass NULL to call this new function.

All other callers and has_sha1_pack() lose the ignore_packed parameter.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-count-objects.c |    2 +-
 builtin-fsck.c          |    2 +-
 builtin-prune-packed.c  |    2 +-
 cache.h                 |    3 ++-
 diff.c                  |    2 +-
 revision.c              |    3 ++-
 sha1_file.c             |   32 +++++++++++++++++++++++++-------
 7 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/builtin-count-objects.c b/builtin-count-objects.c
index 91b5487..c095e8d 100644
--- a/builtin-count-objects.c
+++ b/builtin-count-objects.c
@@ -61,7 +61,7 @@ static void count_objects(DIR *d, char *path, int len, int verbose,
 		hex[40] = 0;
 		if (get_sha1_hex(hex, sha1))
 			die("internal error");
-		if (has_sha1_pack(sha1, NULL))
+		if (has_sha1_pack(sha1))
 			(*packed_loose)++;
 	}
 }
diff --git a/builtin-fsck.c b/builtin-fsck.c
index 30971ce..491375d 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -158,7 +158,7 @@ static void check_reachable_object(struct object *obj)
 	 * do a full fsck
 	 */
 	if (!obj->parsed) {
-		if (has_sha1_pack(obj->sha1, NULL))
+		if (has_sha1_pack(obj->sha1))
 			return; /* it is in pack - forget about it */
 		printf("missing %s %s\n", typename(obj->type), sha1_to_hex(obj->sha1));
 		errors_found |= ERROR_REACHABLE;
diff --git a/builtin-prune-packed.c b/builtin-prune-packed.c
index 10cb8df..2d5b2cd 100644
--- a/builtin-prune-packed.c
+++ b/builtin-prune-packed.c
@@ -23,7 +23,7 @@ static void prune_dir(int i, DIR *dir, char *pathname, int len, int opts)
 		memcpy(hex+2, de->d_name, 38);
 		if (get_sha1_hex(hex, sha1))
 			continue;
-		if (!has_sha1_pack(sha1, NULL))
+		if (!has_sha1_pack(sha1))
 			continue;
 		memcpy(pathname + len, de->d_name, 38);
 		if (opts & DRY_RUN)
diff --git a/cache.h b/cache.h
index 42f2f27..c1539bf 100644
--- a/cache.h
+++ b/cache.h
@@ -565,7 +565,8 @@ extern int check_sha1_signature(const unsigned char *sha1, void *buf, unsigned l
 
 extern int move_temp_to_file(const char *tmpfile, const char *filename);
 
-extern int has_sha1_pack(const unsigned char *sha1, const char **ignore);
+extern int has_sha1_pack(const unsigned char *sha1);
+extern int has_sha1_kept_pack(const unsigned char *sha1, const char **ignore);
 extern int has_sha1_file(const unsigned char *sha1);
 extern int has_loose_object_nonlocal(const unsigned char *sha1);
 
diff --git a/diff.c b/diff.c
index f91f256..a34d26c 100644
--- a/diff.c
+++ b/diff.c
@@ -1743,7 +1743,7 @@ static int reuse_worktree_file(const char *name, const unsigned char *sha1, int
 	 * objects however would tend to be slower as they need
 	 * to be individually opened and inflated.
 	 */
-	if (!FAST_WORKING_DIRECTORY && !want_file && has_sha1_pack(sha1, NULL))
+	if (!FAST_WORKING_DIRECTORY && !want_file && has_sha1_pack(sha1))
 		return 0;
 
 	len = strlen(name);
diff --git a/revision.c b/revision.c
index 45fd7a3..746eeed 100644
--- a/revision.c
+++ b/revision.c
@@ -1485,7 +1485,8 @@ enum commit_action simplify_commit(struct rev_info *revs, struct commit *commit)
 {
 	if (commit->object.flags & SHOWN)
 		return commit_ignore;
-	if (revs->unpacked && has_sha1_pack(commit->object.sha1, revs->ignore_packed))
+	if (revs->unpacked &&
+	    has_sha1_kept_pack(commit->object.sha1, revs->ignore_packed))
 		return commit_ignore;
 	if (revs->show_all)
 		return commit_show;
diff --git a/sha1_file.c b/sha1_file.c
index 88035a0..ac4375d 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1874,7 +1874,8 @@ int matches_pack_name(struct packed_git *p, const char *name)
 	return 0;
 }
 
-static int find_pack_entry(const unsigned char *sha1, struct pack_entry *e, const char **ignore_packed)
+static int find_pack_ent(const unsigned char *sha1, struct pack_entry *e,
+			 const char **ignore_packed)
 {
 	static struct packed_git *last_found = (void *)1;
 	struct packed_git *p;
@@ -1934,6 +1935,17 @@ static int find_pack_entry(const unsigned char *sha1, struct pack_entry *e, cons
 	return 0;
 }
 
+static int find_pack_entry(const unsigned char *sha1, struct pack_entry *e)
+{
+	return find_pack_ent(sha1, e, NULL);
+}
+
+static int find_kept_pack_entry(const unsigned char *sha1, struct pack_entry *e,
+				const char **ignore_packed)
+{
+	return find_pack_ent(sha1, e, ignore_packed);
+}
+
 struct packed_git *find_sha1_pack(const unsigned char *sha1,
 				  struct packed_git *packs)
 {
@@ -1975,7 +1987,7 @@ int sha1_object_info(const unsigned char *sha1, unsigned long *sizep)
 	struct pack_entry e;
 	int status;
 
-	if (!find_pack_entry(sha1, &e, NULL)) {
+	if (!find_pack_entry(sha1, &e)) {
 		/* Most likely it's a loose object. */
 		status = sha1_loose_object_info(sha1, sizep);
 		if (status >= 0)
@@ -1983,7 +1995,7 @@ int sha1_object_info(const unsigned char *sha1, unsigned long *sizep)
 
 		/* Not a loose object; someone else may have just packed it. */
 		reprepare_packed_git();
-		if (!find_pack_entry(sha1, &e, NULL))
+		if (!find_pack_entry(sha1, &e))
 			return status;
 	}
 	return packed_object_info(e.p, e.offset, sizep);
@@ -1995,7 +2007,7 @@ static void *read_packed_sha1(const unsigned char *sha1,
 	struct pack_entry e;
 	void *data;
 
-	if (!find_pack_entry(sha1, &e, NULL))
+	if (!find_pack_entry(sha1, &e))
 		return NULL;
 	data = cache_or_unpack_entry(e.p, e.offset, size, type, 1);
 	if (!data) {
@@ -2395,17 +2407,23 @@ int has_pack_file(const unsigned char *sha1)
 	return 1;
 }
 
-int has_sha1_pack(const unsigned char *sha1, const char **ignore_packed)
+int has_sha1_pack(const unsigned char *sha1)
+{
+	struct pack_entry e;
+	return find_pack_entry(sha1, &e);
+}
+
+int has_sha1_kept_pack(const unsigned char *sha1, const char **ignore_packed)
 {
 	struct pack_entry e;
-	return find_pack_entry(sha1, &e, ignore_packed);
+	return find_kept_pack_entry(sha1, &e, ignore_packed);
 }
 
 int has_sha1_file(const unsigned char *sha1)
 {
 	struct pack_entry e;
 
-	if (find_pack_entry(sha1, &e, NULL))
+	if (find_pack_entry(sha1, &e))
 		return 1;
 	return has_loose_object(sha1);
 }
-- 
1.6.2.rc2.99.g9f3bb
