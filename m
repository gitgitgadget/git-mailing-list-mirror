From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [BUG] fast-import producing very deep tree deltas
Date: Tue, 13 Nov 2007 04:27:21 -0500
Message-ID: <20071113092721.GD14735@spearce.org>
References: <20071112110354.GP6212@lavos.net> <20071113085307.GC14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Brian Downing <bdowning@lavos.net>
X-From: git-owner@vger.kernel.org Tue Nov 13 10:27:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Irs3Z-0005ZR-Lj
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 10:27:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbXKMJ10 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 04:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbXKMJ10
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 04:27:26 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:59542 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328AbXKMJ1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 04:27:25 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Irs3F-0005cw-B4; Tue, 13 Nov 2007 04:27:21 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id AA8B720FBAE; Tue, 13 Nov 2007 04:27:21 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20071113085307.GC14735@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64773>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> Brian Downing <bdowning@lavos.net> wrote:
> > I've happened upon a case where fast-import produces deep tree deltas.
> > How deep?  Really deep.  6035 entries deep to be precise for this case:
> > 
> >     depths: count 135970 total 120567366 min 0 max 6035 mean 886.72 median 3 std_dev 1653.48
> > 
> >     27b8a20bdf39fecd917e8401d3499013e49449d0 tree   32 99609547 6035 0000000000000000000000000000000000000000
> > 
> > This was with git-fast-import from 'next' as of a couple days ago,
> > run with the default options (no --depth passed in).
> > 
> > Needless to say the pack that resulted was just about useless.  Trying to
> > repack it resulted in the "counting objects" phase running at about five
> > objects per second.

Brian, does this fix it?

--8>--
From ff39dd457564b9198344e0cc785afa8cac05b486 Mon Sep 17 00:00:00 2001
From: Shawn O. Pearce <spearce@spearce.org>
Date: Tue, 13 Nov 2007 04:26:24 -0500
Subject: [PATCH] Don't allow fast-import tree delta chains to exceed maximum depth
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org

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

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 fast-import.c |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index f93d7d6..215f1e7 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -153,13 +153,16 @@ Format of STDIN stream:
 
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
 
@@ -1084,6 +1087,7 @@ static int store_object(
 
 		delta_count_by_type[type]++;
 		last->depth++;
+		e->depth = last->depth;
 
 		hdrlen = encode_header(OBJ_OFS_DELTA, deltalen, hdr);
 		write_or_die(pack_data->pack_fd, hdr, hdrlen);
@@ -1097,6 +1101,7 @@ static int store_object(
 	} else {
 		if (last)
 			last->depth = 0;
+		e->depth = 0;
 		hdrlen = encode_header(type, dat->len, hdr);
 		write_or_die(pack_data->pack_fd, hdr, hdrlen);
 		pack_size += hdrlen;
@@ -1160,7 +1165,7 @@ static void load_tree(struct tree_entry *root)
 	if (myoe && myoe->pack_id != MAX_PACK_ID) {
 		if (myoe->type != OBJ_TREE)
 			die("Not a tree: %s", sha1_to_hex(sha1));
-		t->delta_depth = 0;
+		t->delta_depth = myoe->depth;
 		buf = gfi_unpack_entry(myoe, &size);
 	} else {
 		enum object_type type;
@@ -2289,8 +2294,11 @@ int main(int argc, const char **argv)
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
1.5.3.5.1661.gcbf0

-- 
Shawn.
