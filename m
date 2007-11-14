From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Don't allow fast-import tree delta chains to exceed maximum depth
Date: Tue, 13 Nov 2007 23:48:42 -0500
Message-ID: <20071114044842.GA6876@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 05:49:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsABo-0001MV-Py
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 05:49:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757456AbXKNEss (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 23:48:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757586AbXKNEsr
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 23:48:47 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:51678 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756918AbXKNEsq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 23:48:46 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IsAAx-00012N-Qq; Tue, 13 Nov 2007 23:48:31 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C061C20FBAE; Tue, 13 Nov 2007 23:48:42 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64947>

Brian Downing noticed fast-import can produce tree depths of up
to 6,035 objects and even deeper.  Long delta chains can create
very small packfiles but cause problems during repacking as git
needs to unpack each tree to count the reachable blobs.

What's happening here is the active branch cache isn't big enough.
We're swapping out the branch and thus recycling the tree information
(struct tree_content) back into the free pool.  When we later reload
the tree we set the delta_depth to 0 but we kept the tree we just
reloaded as a delta base.

So if the tree we reloaded was already at the maximum depth we
wouldn't know it and make the new tree a delta.  Multiply the
number of times the branch cache has to swap out the tree times
max_depth (10) and you get the maximum delta depth of a tree created
by fast-import.  In Brian's case above the active branch cache had
to swap the branch out 603/604 times during this import to produce
a tree with a delta depth of 6035.

Acked-by: Brian Downing <bdowning@lavos.net>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 Junio, this patch is against maint.  It will apply cleanly to maint
 but is also crafted to ensure it should apply to next with git-am -3.
 Its a real bug that's lasted a long time in fast-import.  I think
 it is maint material.

 My fast-import tree is quite behind yours so I would appreciate
 it if you could apply this to your own tree instead of trying to
 fetch things from me.  Thanks.

 fast-import.c |   17 ++++++++++++-----
 1 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index c07e3d8..7544949 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -154,13 +154,16 @@ Format of STDIN stream:
 
 #define PACK_ID_BITS 16
 #define MAX_PACK_ID ((1<<PACK_ID_BITS)-1)
+#define DEPTH_BITS 13
+#define MAX_DEPTH ((1<<DEPTH_BITS)-1)
 
 struct object_entry
 {
 	struct object_entry *next;
 	uint32_t offset;
-	unsigned type : TYPE_BITS;
-	unsigned pack_id : PACK_ID_BITS;
+	uint32_t type : TYPE_BITS,
+		pack_id : PACK_ID_BITS,
+		depth : DEPTH_BITS;
 	unsigned char sha1[20];
 };
 
@@ -1105,7 +1108,7 @@ static int store_object(
 		unsigned pos = sizeof(hdr) - 1;
 
 		delta_count_by_type[type]++;
-		last->depth++;
+		e->depth = ++last->depth++;
 
 		hdrlen = encode_header(OBJ_OFS_DELTA, deltalen, hdr);
 		write_or_die(pack_data->pack_fd, hdr, hdrlen);
@@ -1117,6 +1120,7 @@ static int store_object(
 		write_or_die(pack_data->pack_fd, hdr + pos, sizeof(hdr) - pos);
 		pack_size += sizeof(hdr) - pos;
 	} else {
+		e->depth = 0;
 		if (last)
 			last->depth = 0;
 		hdrlen = encode_header(type, datlen, hdr);
@@ -1181,7 +1185,7 @@ static void load_tree(struct tree_entry *root)
 	if (myoe && myoe->pack_id != MAX_PACK_ID) {
 		if (myoe->type != OBJ_TREE)
 			die("Not a tree: %s", sha1_to_hex(sha1));
-		t->delta_depth = 0;
+		t->delta_depth = myoe->depth;
 		buf = gfi_unpack_entry(myoe, &size);
 	} else {
 		enum object_type type;
@@ -2347,8 +2351,11 @@ int main(int argc, const char **argv)
 		}
 		else if (!prefixcmp(a, "--max-pack-size="))
 			max_packsize = strtoumax(a + 16, NULL, 0) * 1024 * 1024;
-		else if (!prefixcmp(a, "--depth="))
+		else if (!prefixcmp(a, "--depth=")) {
 			max_depth = strtoul(a + 8, NULL, 0);
+			if (max_depth > MAX_DEPTH)
+				die("--depth cannot exceed %u", MAX_DEPTH);
+		}
 		else if (!prefixcmp(a, "--active-branches="))
 			max_active_branches = strtoul(a + 18, NULL, 0);
 		else if (!prefixcmp(a, "--import-marks="))
-- 
1.5.3.5.1728.g34b3e
