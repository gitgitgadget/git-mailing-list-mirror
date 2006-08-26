From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH 3/5] Cleanup unpack_entry_gently and friends to use type_name array.
Date: Sat, 26 Aug 2006 04:11:36 -0400
Message-ID: <20060826081136.GE22343@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 26 10:11:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGtGZ-0002zY-VB
	for gcvg-git@gmane.org; Sat, 26 Aug 2006 10:11:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422860AbWHZILk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Aug 2006 04:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964924AbWHZILk
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Aug 2006 04:11:40 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:20417 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S964922AbWHZILj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Aug 2006 04:11:39 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GGtGS-0007CT-5j; Sat, 26 Aug 2006 04:11:36 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6CFC420FB7F; Sat, 26 Aug 2006 04:11:36 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26038>

[PATCH 3/5] Cleanup unpack_entry_gently and friends to use type_name array.

This change allows combining all of the non-delta entries into a
single case, as well as to remove an unnecessary local variable
in unpack_entry_gently.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 sha1_file.c |   34 ++++++----------------------------
 1 files changed, 6 insertions(+), 28 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index fd3e01b..b580cee 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -996,16 +996,10 @@ void packed_object_info_detail(struct pa
 	}
 	switch (kind) {
 	case OBJ_COMMIT:
-		strcpy(type, commit_type);
-		break;
 	case OBJ_TREE:
-		strcpy(type, tree_type);
-		break;
 	case OBJ_BLOB:
-		strcpy(type, blob_type);
-		break;
 	case OBJ_TAG:
-		strcpy(type, tag_type);
+		strcpy(type, type_names[kind]);
 		break;
 	default:
 		die("corrupted pack file %s containing object of kind %d",
@@ -1036,16 +1030,10 @@ static int packed_object_info(struct pac
 		unuse_packed_git(p);
 		return retval;
 	case OBJ_COMMIT:
-		strcpy(type, commit_type);
-		break;
 	case OBJ_TREE:
-		strcpy(type, tree_type);
-		break;
 	case OBJ_BLOB:
-		strcpy(type, blob_type);
-		break;
 	case OBJ_TAG:
-		strcpy(type, tag_type);
+		strcpy(type, type_names[kind]);
 		break;
 	default:
 		die("corrupted pack file %s containing object of kind %d",
@@ -1143,33 +1131,23 @@ void *unpack_entry_gently(struct pack_en
 	unsigned long offset, size, left;
 	unsigned char *pack;
 	enum object_type kind;
-	void *retval;
 
 	offset = unpack_object_header(p, entry->offset, &kind, &size);
 	pack = (unsigned char *) p->pack_base + offset;
 	left = p->pack_size - offset;
 	switch (kind) {
 	case OBJ_DELTA:
-		retval = unpack_delta_entry(pack, size, left, type, sizep, p);
-		return retval;
+		return unpack_delta_entry(pack, size, left, type, sizep, p);
 	case OBJ_COMMIT:
-		strcpy(type, commit_type);
-		break;
 	case OBJ_TREE:
-		strcpy(type, tree_type);
-		break;
 	case OBJ_BLOB:
-		strcpy(type, blob_type);
-		break;
 	case OBJ_TAG:
-		strcpy(type, tag_type);
-		break;
+		strcpy(type, type_names[kind]);
+		*sizep = size;
+		return unpack_compressed_entry(pack, size, left);
 	default:
 		return NULL;
 	}
-	*sizep = size;
-	retval = unpack_compressed_entry(pack, size, left);
-	return retval;
 }
 
 int num_packed_objects(const struct packed_git *p)
-- 
1.4.2.g6580
