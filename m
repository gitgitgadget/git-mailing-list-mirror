From: drafnel@gmail.com
Subject: [PATCH 1/3] packed_git: convert pack_local flag into generic bit mask
Date: Sun,  2 Nov 2008 10:31:15 -0600
Message-ID: <6141358.1225643400587.JavaMail.teamon@b303.teamon.com>
References: <14536526.1225596838300.JavaMail.teamon@b301.teamon.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, nico@cam.org, spearce@spearce.org,
	Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 02 17:31:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwfrT-0000oU-Bd
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 17:31:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753680AbYKBQaE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 11:30:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753688AbYKBQaE
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 11:30:04 -0500
Received: from mailproxy03.teamon.com ([64.85.68.139]:38151 "EHLO
	b303.teamon.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753679AbYKBQaD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 11:30:03 -0500
Received: from b303.teamon.com (localhost [127.0.0.1])
	by b303.teamon.com (8.11.7 DSN_MOD/8.11.7) with ESMTP id mA2GU0K15042;
	Sun, 2 Nov 2008 16:30:00 GMT
X-Mailer: git-send-email 1.6.0.2.588.g3102
In-Reply-To: <14536526.1225596838300.JavaMail.teamon@b301.teamon.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99850>

From: Brandon Casey <drafnel@gmail.com>

This converts the pack_local flag of the packed_git structure into a generic
bit mask and introduces a PACK_LOCAL mask and an ispacklocal() access macro.

So instead of this:

   if (p->pack_local)
      do_something

you would do this:

   if (ispacklocal(p))
      do_something

This is in preparation for adding a flag indicating whether a .keep file is
present.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 builtin-count-objects.c |    2 +-
 builtin-gc.c            |    2 +-
 builtin-pack-objects.c  |    2 +-
 cache.h                 |    5 ++++-
 pack-redundant.c        |    4 ++--
 server-info.c           |    4 ++--
 sha1_file.c             |    5 +++--
 7 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/builtin-count-objects.c b/builtin-count-objects.c
index ab35b65..3f981d6 100644
--- a/builtin-count-objects.c
+++ b/builtin-count-objects.c
@@ -108,7 +108,7 @@ int cmd_count_objects(int argc, const char **argv, const char *prefix)
 		if (!packed_git)
 			prepare_packed_git();
 		for (p = packed_git; p; p = p->next) {
-			if (!p->pack_local)
+			if (!ispacklocal(p))
 				continue;
 			if (open_pack_index(p))
 				continue;
diff --git a/builtin-gc.c b/builtin-gc.c
index 7af65bb..0473158 100644
--- a/builtin-gc.c
+++ b/builtin-gc.c
@@ -135,7 +135,7 @@ static int too_many_packs(void)
 		size_t len;
 		int keep;
 
-		if (!p->pack_local)
+		if (!ispacklocal(p))
 			continue;
 		len = strlen(p->pack_name);
 		if (PATH_MAX <= len + 1)
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 59c30d1..6a8b9bf 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -701,7 +701,7 @@ static int add_object_entry(const unsigned char *sha1, enum object_type type,
 				break;
 			if (incremental)
 				return 0;
-			if (local && !p->pack_local)
+			if (local && !ispacklocal(p))
 				return 0;
 		}
 	}
diff --git a/cache.h b/cache.h
index b0edbf9..0cb9350 100644
--- a/cache.h
+++ b/cache.h
@@ -679,12 +679,15 @@ extern struct packed_git {
 	int index_version;
 	time_t mtime;
 	int pack_fd;
-	int pack_local;
+	unsigned int flags;
 	unsigned char sha1[20];
 	/* something like ".git/objects/pack/xxxxx.pack" */
 	char pack_name[FLEX_ARRAY]; /* more */
 } *packed_git;
 
+#define PACK_LOCAL	1
+#define ispacklocal(p) ((p)->flags & PACK_LOCAL)
+
 struct pack_entry {
 	off_t offset;
 	unsigned char sha1[20];
diff --git a/pack-redundant.c b/pack-redundant.c
index 25b81a4..964f18f 100644
--- a/pack-redundant.c
+++ b/pack-redundant.c
@@ -544,7 +544,7 @@ static struct pack_list * add_pack(struct packed_git *p)
 	unsigned long off = 0, step;
 	const unsigned char *base;
 
-	if (!p->pack_local && !(alt_odb || verbose))
+	if (!ispacklocal(p) && !(alt_odb || verbose))
 		return NULL;
 
 	l.pack = p;
@@ -562,7 +562,7 @@ static struct pack_list * add_pack(struct packed_git *p)
 	}
 	/* this list will be pruned in cmp_two_packs later */
 	l.unique_objects = llist_copy(l.all_objects);
-	if (p->pack_local)
+	if (ispacklocal(p))
 		return pack_list_insert(&local_packs, &l);
 	else
 		return pack_list_insert(&altodb_packs, &l);
diff --git a/server-info.c b/server-info.c
index c1c073b..2eb20f5 100644
--- a/server-info.c
+++ b/server-info.c
@@ -168,14 +168,14 @@ static void init_pack_info(const char *infofile, int force)
 		/* we ignore things on alternate path since they are
 		 * not available to the pullers in general.
 		 */
-		if (!p->pack_local)
+		if (!ispacklocal(p))
 			continue;
 		i++;
 	}
 	num_pack = i;
 	info = xcalloc(num_pack, sizeof(struct pack_info *));
 	for (i = 0, p = packed_git; p; p = p->next) {
-		if (!p->pack_local)
+		if (!ispacklocal(p))
 			continue;
 		info[i] = xcalloc(1, sizeof(struct pack_info));
 		info[i]->p = p;
diff --git a/sha1_file.c b/sha1_file.c
index ab2b520..e4141c9 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -851,7 +851,8 @@ struct packed_git *add_packed_git(const char *path, int path_len, int local)
 	 * actually mapping the pack file.
 	 */
 	p->pack_size = st.st_size;
-	p->pack_local = local;
+	if (local)
+		p->flags |= PACK_LOCAL;
 	p->mtime = st.st_mtime;
 	if (path_len < 40 || get_sha1_hex(path + path_len - 40, p->sha1))
 		hashclr(p->sha1);
@@ -941,7 +942,7 @@ static int sort_pack(const void *a_, const void *b_)
 	 * remote ones could be on a network mounted filesystem.
 	 * Favor local ones for these reasons.
 	 */
-	st = a->pack_local - b->pack_local;
+	st = ispacklocal(a) - ispacklocal(b);
 	if (st)
 		return -st;
 
-- 
1.6.0.2.588.g3102
