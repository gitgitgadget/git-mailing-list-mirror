From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 2/4] move show_pack_info() were it belongs
Date: Tue, 24 Jun 2008 23:18:17 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806242317150.2979@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 05:19:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBLXQ-0001sK-4G
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 05:19:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754794AbYFYDSU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 23:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754296AbYFYDST
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 23:18:19 -0400
Received: from relais.videotron.ca ([24.201.245.36]:31318 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754012AbYFYDST (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 23:18:19 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K3000IFO16H9BA0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 24 Jun 2008 23:18:18 -0400 (EDT)
X-X-Sender: nico@xanadu.home
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86202>


This is called when verify_pack() has its verbose argument set, and
verbose in this context makes sense only for the actual 'git verify-pack'
command.  Therefore let's move show_pack_info() to builtin-verify-pack.c
instead and remove useless verbose argument from verify_pack().

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 builtin-fsck.c        |    2 +-
 builtin-verify-pack.c |   63 ++++++++++++++++++++++++++++++++++++++++++++++-
 http-push.c           |    2 +-
 http-walker.c         |    2 +-
 pack-check.c          |   66 +------------------------------------------------
 pack.h                |    2 +-
 6 files changed, 67 insertions(+), 70 deletions(-)

diff --git a/builtin-fsck.c b/builtin-fsck.c
index 78a6e1f..b0f9648 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -585,7 +585,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 		prepare_packed_git();
 		for (p = packed_git; p; p = p->next)
 			/* verify gives error messages itself */
-			verify_pack(p, 0);
+			verify_pack(p);
 
 		for (p = packed_git; p; p = p->next) {
 			uint32_t j, num;
diff --git a/builtin-verify-pack.c b/builtin-verify-pack.c
index 4c515a0..222c39e 100644
--- a/builtin-verify-pack.c
+++ b/builtin-verify-pack.c
@@ -2,6 +2,58 @@
 #include "cache.h"
 #include "pack.h"
 
+
+#define MAX_CHAIN 50
+
+static void show_pack_info(struct packed_git *p)
+{
+	uint32_t nr_objects, i, chain_histogram[MAX_CHAIN+1];
+
+	nr_objects = p->num_objects;
+	memset(chain_histogram, 0, sizeof(chain_histogram));
+
+	for (i = 0; i < nr_objects; i++) {
+		const unsigned char *sha1;
+		unsigned char base_sha1[20];
+		const char *type;
+		unsigned long size;
+		unsigned long store_size;
+		off_t offset;
+		unsigned int delta_chain_length;
+
+		sha1 = nth_packed_object_sha1(p, i);
+		if (!sha1)
+			die("internal error pack-check nth-packed-object");
+		offset = nth_packed_object_offset(p, i);
+		type = packed_object_info_detail(p, offset, &size, &store_size,
+						 &delta_chain_length,
+						 base_sha1);
+		printf("%s ", sha1_to_hex(sha1));
+		if (!delta_chain_length)
+			printf("%-6s %lu %lu %"PRIuMAX"\n",
+			       type, size, store_size, (uintmax_t)offset);
+		else {
+			printf("%-6s %lu %lu %"PRIuMAX" %u %s\n",
+			       type, size, store_size, (uintmax_t)offset,
+			       delta_chain_length, sha1_to_hex(base_sha1));
+			if (delta_chain_length <= MAX_CHAIN)
+				chain_histogram[delta_chain_length]++;
+			else
+				chain_histogram[0]++;
+		}
+	}
+
+	for (i = 0; i <= MAX_CHAIN; i++) {
+		if (!chain_histogram[i])
+			continue;
+		printf("chain length = %d: %d object%s\n", i,
+		       chain_histogram[i], chain_histogram[i] > 1 ? "s" : "");
+	}
+	if (chain_histogram[0])
+		printf("chain length > %d: %d object%s\n", MAX_CHAIN,
+		       chain_histogram[0], chain_histogram[0] > 1 ? "s" : "");
+}
+
 static int verify_one_pack(const char *path, int verbose)
 {
 	char arg[PATH_MAX];
@@ -41,7 +93,16 @@ static int verify_one_pack(const char *path, int verbose)
 		return error("packfile %s not found.", arg);
 
 	install_packed_git(pack);
-	err = verify_pack(pack, verbose);
+	err = verify_pack(pack);
+
+	if (verbose) {
+		if (err)
+			printf("%s: bad\n", pack->pack_name);
+		else {
+			show_pack_info(pack);
+			printf("%s: ok\n", pack->pack_name);
+		}
+	}
 
 	return err;
 }
diff --git a/http-push.c b/http-push.c
index 665712a..2cd068a 100644
--- a/http-push.c
+++ b/http-push.c
@@ -783,7 +783,7 @@ static void finish_request(struct transfer_request *request)
 					lst = &((*lst)->next);
 				*lst = (*lst)->next;
 
-				if (!verify_pack(target, 0))
+				if (!verify_pack(target))
 					install_packed_git(target);
 				else
 					remote->can_update_info_refs = 0;
diff --git a/http-walker.c b/http-walker.c
index 99f397e..51c18f2 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -795,7 +795,7 @@ static int fetch_pack(struct walker *walker, struct alt_base *repo, unsigned cha
 		lst = &((*lst)->next);
 	*lst = (*lst)->next;
 
-	if (verify_pack(target, 0))
+	if (verify_pack(target))
 		return -1;
 	install_packed_git(target);
 
diff --git a/pack-check.c b/pack-check.c
index d6dbd4b..5f02a65 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -96,62 +96,7 @@ static int verify_packfile(struct packed_git *p,
 	return err;
 }
 
-
-#define MAX_CHAIN 50
-
-static void show_pack_info(struct packed_git *p)
-{
-	uint32_t nr_objects, i, chain_histogram[MAX_CHAIN+1];
-
-	nr_objects = p->num_objects;
-	memset(chain_histogram, 0, sizeof(chain_histogram));
-
-	for (i = 0; i < nr_objects; i++) {
-		const unsigned char *sha1;
-		unsigned char base_sha1[20];
-		const char *type;
-		unsigned long size;
-		unsigned long store_size;
-		off_t offset;
-		unsigned int delta_chain_length;
-
-		sha1 = nth_packed_object_sha1(p, i);
-		if (!sha1)
-			die("internal error pack-check nth-packed-object");
-		offset = find_pack_entry_one(sha1, p);
-		if (!offset)
-			die("internal error pack-check find-pack-entry-one");
-
-		type = packed_object_info_detail(p, offset, &size, &store_size,
-						 &delta_chain_length,
-						 base_sha1);
-		printf("%s ", sha1_to_hex(sha1));
-		if (!delta_chain_length)
-			printf("%-6s %lu %lu %"PRIuMAX"\n",
-			       type, size, store_size, (uintmax_t)offset);
-		else {
-			printf("%-6s %lu %lu %"PRIuMAX" %u %s\n",
-			       type, size, store_size, (uintmax_t)offset,
-			       delta_chain_length, sha1_to_hex(base_sha1));
-			if (delta_chain_length <= MAX_CHAIN)
-				chain_histogram[delta_chain_length]++;
-			else
-				chain_histogram[0]++;
-		}
-	}
-
-	for (i = 0; i <= MAX_CHAIN; i++) {
-		if (!chain_histogram[i])
-			continue;
-		printf("chain length = %d: %d object%s\n", i,
-		       chain_histogram[i], chain_histogram[i] > 1 ? "s" : "");
-	}
-	if (chain_histogram[0])
-		printf("chain length > %d: %d object%s\n", MAX_CHAIN,
-		       chain_histogram[0], chain_histogram[0] > 1 ? "s" : "");
-}
-
-int verify_pack(struct packed_git *p, int verbose)
+int verify_pack(struct packed_git *p)
 {
 	off_t index_size;
 	const unsigned char *index_base;
@@ -177,14 +122,5 @@ int verify_pack(struct packed_git *p, int verbose)
 	err |= verify_packfile(p, &w_curs);
 	unuse_pack(&w_curs);
 
-	if (verbose) {
-		if (err)
-			printf("%s: bad\n", p->pack_name);
-		else {
-			show_pack_info(p);
-			printf("%s: ok\n", p->pack_name);
-		}
-	}
-
 	return err;
 }
diff --git a/pack.h b/pack.h
index b31b376..465071c 100644
--- a/pack.h
+++ b/pack.h
@@ -57,7 +57,7 @@ struct pack_idx_entry {
 
 extern char *write_idx_file(char *index_name, struct pack_idx_entry **objects, int nr_objects, unsigned char *sha1);
 
-extern int verify_pack(struct packed_git *, int);
+extern int verify_pack(struct packed_git *);
 extern void fixup_pack_header_footer(int, unsigned char *, const char *, uint32_t);
 extern char *index_pack_lockfile(int fd);
 
-- 
1.5.6.56.g29b0d
