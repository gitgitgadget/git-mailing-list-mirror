From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 5/9] Use uint32_t for all packed object counts.
Date: Tue, 6 Mar 2007 20:44:19 -0500
Message-ID: <20070307014419.GF26482@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Mar 07 02:46:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOlEE-00070d-JZ
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 02:46:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161186AbXCGBoc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 20:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161184AbXCGBo3
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 20:44:29 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:49212 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161179AbXCGBoY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 20:44:24 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HOlCM-0003pd-D4; Tue, 06 Mar 2007 20:44:11 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9361720FBAE; Tue,  6 Mar 2007 20:44:19 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41643>

As we permit up to 2^32-1 objects in a single packfile we cannot
use a signed int to represent the object offset within a packfile,
after 2^31-1 objects we will start seeing negative indexes and
error out or compute bad addresses within the mmap'd index.

This is a minor cleanup that does not introduce any significant
logic changes.  It is roach free.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-fsck.c |    2 +-
 cache.h        |    4 ++--
 pack-check.c   |    8 ++++----
 sha1_file.c    |   10 +++++-----
 sha1_name.c    |    6 +++---
 5 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/builtin-fsck.c b/builtin-fsck.c
index 6abf498..39cfc32 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -632,7 +632,7 @@ int cmd_fsck(int argc, char **argv, const char *prefix)
 			verify_pack(p, 0);
 
 		for (p = packed_git; p; p = p->next) {
-			int num = num_packed_objects(p);
+			uint32_t i, num = num_packed_objects(p);
 			for (i = 0; i < num; i++) {
 				unsigned char sha1[20];
 				nth_packed_object_sha1(p, i, sha1);
diff --git a/cache.h b/cache.h
index f3d7538..63a093b 100644
--- a/cache.h
+++ b/cache.h
@@ -425,8 +425,8 @@ extern void pack_report(void);
 extern unsigned char* use_pack(struct packed_git *, struct pack_window **, unsigned long, unsigned int *);
 extern void unuse_pack(struct pack_window **);
 extern struct packed_git *add_packed_git(char *, int, int);
-extern int num_packed_objects(const struct packed_git *p);
-extern int nth_packed_object_sha1(const struct packed_git *, int, unsigned char*);
+extern uint32_t num_packed_objects(const struct packed_git *p);
+extern int nth_packed_object_sha1(const struct packed_git *, uint32_t, unsigned char*);
 extern unsigned long find_pack_entry_one(const unsigned char *, struct packed_git *);
 extern void *unpack_entry(struct packed_git *, unsigned long, enum object_type *, unsigned long *);
 extern unsigned long unpack_object_header_gently(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
diff --git a/pack-check.c b/pack-check.c
index f248ac8..7c82f67 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -9,7 +9,8 @@ static int verify_packfile(struct packed_git *p,
 	SHA_CTX ctx;
 	unsigned char sha1[20];
 	unsigned long offset = 0, pack_sig = p->pack_size - 20;
-	int nr_objects, err, i;
+	uint32_t nr_objects, i;
+	int err;
 
 	/* Note that the pack header checks are actually performed by
 	 * use_pack when it first opens the pack file.  If anything
@@ -40,7 +41,7 @@ static int verify_packfile(struct packed_git *p,
 	 * we do not do scan-streaming check on the pack file.
 	 */
 	nr_objects = num_packed_objects(p);
-	for (i = err = 0; i < nr_objects; i++) {
+	for (i = 0, err = 0; i < nr_objects; i++) {
 		unsigned char sha1[20];
 		void *data;
 		enum object_type type;
@@ -74,8 +75,7 @@ static int verify_packfile(struct packed_git *p,
 
 static void show_pack_info(struct packed_git *p)
 {
-	int nr_objects, i;
-	unsigned int chain_histogram[MAX_CHAIN];
+	uint32_t nr_objects, i, chain_histogram[MAX_CHAIN];
 
 	nr_objects = num_packed_objects(p);
 	memset(chain_histogram, 0, sizeof(chain_histogram));
diff --git a/sha1_file.c b/sha1_file.c
index b17a828..54ffa7c 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -437,7 +437,7 @@ static int check_packed_git_idx(const char *path,
 	void *idx_map;
 	uint32_t *index;
 	unsigned long idx_size;
-	int nr, i;
+	uint32_t nr, i;
 	int fd = open(path, O_RDONLY);
 	struct stat st;
 	if (fd < 0)
@@ -472,7 +472,7 @@ static int check_packed_git_idx(const char *path,
 
 	nr = 0;
 	for (i = 0; i < 256; i++) {
-		unsigned int n = ntohl(index[i]);
+		uint32_t n = ntohl(index[i]);
 		if (n < nr) {
 			munmap(idx_map, idx_size);
 			return error("non-monotonic index %s", path);
@@ -1339,17 +1339,17 @@ void *unpack_entry(struct packed_git *p, unsigned long obj_offset,
 	return data;
 }
 
-int num_packed_objects(const struct packed_git *p)
+uint32_t num_packed_objects(const struct packed_git *p)
 {
 	/* See check_packed_git_idx() */
 	return (p->index_size - 20 - 20 - 4*256) / 24;
 }
 
-int nth_packed_object_sha1(const struct packed_git *p, int n,
+int nth_packed_object_sha1(const struct packed_git *p, uint32_t n,
 			   unsigned char* sha1)
 {
 	void *index = p->index_base + 256;
-	if (n < 0 || num_packed_objects(p) <= n)
+	if (num_packed_objects(p) <= n)
 		return -1;
 	hashcpy(sha1, (unsigned char *) index + (24 * n) + 4);
 	return 0;
diff --git a/sha1_name.c b/sha1_name.c
index 0781477..31812d3 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -76,10 +76,10 @@ static int find_short_packed_object(int len, const unsigned char *match, unsigne
 
 	prepare_packed_git();
 	for (p = packed_git; p && found < 2; p = p->next) {
-		unsigned num = num_packed_objects(p);
-		unsigned first = 0, last = num;
+		uint32_t num = num_packed_objects(p);
+		uint32_t first = 0, last = num;
 		while (first < last) {
-			unsigned mid = (first + last) / 2;
+			uint32_t mid = (first + last) / 2;
 			unsigned char now[20];
 			int cmp;
 
-- 
1.5.0.3.863.gf0989
