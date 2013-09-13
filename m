From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 2/4] pack v4: add v4_size to struct delta_base_cache_entry
Date: Fri, 13 Sep 2013 09:27:43 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1309130913510.20709@syhkavp.arg>
References: <1378982284-7848-1-git-send-email-pclouds@gmail.com>
 <1378982284-7848-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_x4pjFT9ywF3fZZ+SM2MOFA)"
Cc: git@vger.kernel.org
To: =?VISCII?Q?Nguy=ADn_Th=E1i_Ng=F7c_Duy?= <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 13 15:34:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKTWO-0007eA-VB
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 15:34:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934074Ab3IMNev (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Sep 2013 09:34:51 -0400
Received: from relais.videotron.ca ([24.201.245.36]:61499 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757792Ab3IMN1w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Sep 2013 09:27:52 -0400
Received: from xanadu.home ([70.83.209.44]) by VL-VM-MR005.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MT200B3ZG27IK20@VL-VM-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 13 Sep 2013 09:27:44 -0400 (EDT)
In-reply-to: <1378982284-7848-2-git-send-email-pclouds@gmail.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234752>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_x4pjFT9ywF3fZZ+SM2MOFA)
Content-type: TEXT/PLAIN; charset=UTF-8
Content-transfer-encoding: 8BIT

On Thu, 12 Sep 2013, Nguyễn Thái Ngọc Duy wrote:

> The intention is to store flat v4 trees in delta base cache to avoid
> repeatedly expanding copy sequences in v4 trees. When the user needs
> to unpack a v4 tree and the tree is found in the cache, the tree will
> be converted back to canonical format. Future tree_desc interface may
> skip canonical format and read v4 trees directly.
> 
> For that to work we need to keep track of v4 tree size after all copy
> sequences are expanded, which is the purpose of this new field.

Hmmm.... I think this is going in a wrong direction.

If we want a cache for pv4 objects, it would be best to keep it separate 
from the current delta cache in sha1_file.c for code maintainability 
reasons.  I'd suggest creating another cache in packv4-parse.c instead.

Yet, pavkv4 tree walking shouldn't need a cache since there is nothing 
to expand in the end.  Entries should be advanced one by one as they are 
needed.  Granted when converting back to a canonical object we need all 
of them, but eventually this shouldn't be the main mode of operation.

However I can see that, as you say, the same base object is repeatedly 
referenced.  This means that we need to parse it over and over again 
just to find the right offset where the needed entries start.  We 
probably end up skipping over the first entries in a tree object 
multiple times.  And that would be true even when the core code learns 
to walk pv4 trees directly.

So here's the beginning of a tree offset cache to mitigate this problem.  
It is incomplete as the cache function is not implemented, etc.  But 
that should give you the idea.


diff --git a/packv4-parse.c b/packv4-parse.c
index ae3e6a5..39b4f31 100644
--- a/packv4-parse.c
+++ b/packv4-parse.c
@@ -339,9 +339,9 @@ void *pv4_get_commit(struct packed_git *p, struct pack_window **w_curs,
 	return dst;
 }
 
-static int copy_canonical_tree_entries(struct packed_git *p, off_t offset,
-				       unsigned int start, unsigned int count,
-				       unsigned char **dstp, unsigned long *sizep)
+static off_t copy_canonical_tree_entries(struct packed_git *p, off_t offset,
+				unsigned int start, unsigned int count,
+				unsigned char **dstp, unsigned long *sizep)
 {
 	void *data;
 	const unsigned char *from, *end;
@@ -369,13 +369,19 @@ static int copy_canonical_tree_entries(struct packed_git *p, off_t offset,
 
 	if (end - from > *sizep) {
 		free(data);
-		return -1;
+		return 0;
 	}
 	memcpy(*dstp, from, end - from);
 	*dstp += end - from;
 	*sizep -= end - from;
 	free(data);
-	return 0;
+
+
+	/*
+	 * We won't cache this tree's current offset so let's just
+	 * indicate success with a non-zero return value.
+	 */
+	return 1;
 }
 
 static int tree_entry_prefix(unsigned char *buf, unsigned long size,
@@ -404,39 +410,56 @@ static int tree_entry_prefix(unsigned char *buf, unsigned long size,
 	return len;
 }
 
-static int decode_entries(struct packed_git *p, struct pack_window **w_curs,
-			  off_t offset, unsigned int start, unsigned int count,
-			  unsigned char **dstp, unsigned long *sizep, int hdr)
+static off_t decode_entries(struct packed_git *p, struct pack_window **w_curs,
+			off_t offset, unsigned int start, unsigned int count,
+			unsigned char **dstp, unsigned long *sizep, int hdr)
 {
-	unsigned long avail;
-	unsigned int nb_entries;
+	unsigned long avail = 0;
 	const unsigned char *src, *scp;
 	off_t copy_objoffset = 0;
 
-	src = use_pack(p, w_curs, offset, &avail);
-	scp = src;
-
 	if (hdr) {
+		unsigned int nb_entries;
+
+		src = use_pack(p, w_curs, offset, &avail);
+		scp = src;
+
 		/* we need to skip over the object header */
 		while (*scp & 128)
 			if (++scp - src >= avail - 20)
-				return -1;
+				return 0;
+
 		/* is this a canonical tree object? */
 		if ((*scp & 0xf) == OBJ_TREE)
 			return copy_canonical_tree_entries(p, offset,
 							   start, count,
 							   dstp, sizep);
+
 		/* let's still make sure this is actually a pv4 tree */
 		if ((*scp++ & 0xf) != OBJ_PV4_TREE)
-			return -1;
-	}
+			return 0;
+
+		nb_entries = decode_varint(&scp);
+		if (scp == src || start > nb_entries ||
+		    count > nb_entries - start)
+			return 0;
+
+		/*
+		 * If this is a partial copy, let's create a cache entry
+		 * to speed things up if the remaining of the tree is needed in
+		 * the future.
+		 */
+		if (start + count < nb_entries) {
+			c = get_tree_offset_cache(p, offset);
+			c->offset = offset + scp - src;
+			c->pos = 0;
+			c->nb_entries = nb_entries;
+		}
 
-	nb_entries = decode_varint(&scp);
-	if (scp == src || start > nb_entries || count > nb_entries - start)
-		return -1;
-	offset += scp - src;
-	avail -= scp - src;
-	src = scp;
+		offset += scp - src;
+		avail -= scp - src;
+		src = scp;
+	}
 
 	while (count) {
 		unsigned int what;
@@ -444,13 +467,13 @@ static int decode_entries(struct packed_git *p, struct pack_window **w_curs,
 		if (avail < 20) {
 			src = use_pack(p, w_curs, offset, &avail);
 			if (avail < 20)
-				return -1;
+				return 0;
 		}
 		scp = src;
 
 		what = decode_varint(&scp);
 		if (scp == src)
-			return -1;
+			return 0;
 
 		if (!(what & 1) && start != 0) {
 			/*
@@ -474,12 +497,12 @@ static int decode_entries(struct packed_git *p, struct pack_window **w_curs,
 			path = get_pathref(p, what >> 1, &pathlen);
 			sha1 = get_sha1ref(p, &scp);
 			if (!path || !sha1)
-				return -1;
+				return 0;
 			mode = (path[0] << 8) | path[1];
 			len = tree_entry_prefix(*dstp, *sizep,
 						path + 2, pathlen - 2, mode);
 			if (!len || len + 20 > *sizep)
-				return -1;
+				return 0;
 			hashcpy(*dstp + len, sha1);
 			*dstp += len + 20;
 			*sizep -= len + 20;
@@ -493,7 +516,7 @@ static int decode_entries(struct packed_git *p, struct pack_window **w_curs,
 			copy_start = what >> 1;
 			copy_count = decode_varint(&scp);
 			if (!copy_count)
-				return -1;
+				return 0;
 
 			/*
 			 * The LSB of copy_count is a flag indicating if
@@ -522,24 +545,41 @@ static int decode_entries(struct packed_git *p, struct pack_window **w_curs,
 				}
 			}
 			if (!copy_objoffset)
-				return -1;
+				return 0;
 			copy_count >>= 1;
 
 			if (start >= copy_count) {
 				start -= copy_count;
 			} else {
-				int ret;
+				off_t ret;
 				copy_count -= start;
 				copy_start += start;
 				start = 0;
 				if (copy_count > count)
 					copy_count = count;
 				count -= copy_count;
-				ret = decode_entries(p, w_curs,
-					copy_objoffset, copy_start, copy_count,
-					dstp, sizep, 1);
-				if (ret)
-					return ret;
+
+				c = get_tree_offset_cache(p, copy_objoffset);
+				if (c->offset &&
+				    copy_start >= c->pos &&
+				    copy_start < c->nb_entries &&
+				    copy_count <= c->nb_entries - copy_start) {
+					copy_start -= c->pos;
+					ret = decode_entries(
+							p, w_curs, c->offset,
+							copy_start, copy_count,
+							dstp, sizep, 0);
+					if (ret && c->pos + copy_count < c->nb_entries) {
+						c->offset = ret;
+						c->pos += copy_start + copy_count;
+					}
+				} else
+					ret = decode_entries(
+							p, w_curs, copy_objoffset,
+							copy_start, copy_count,
+							dstp, sizep, 1);
+				if (!ret)
+					return 0;
 				/* force pack window readjustment */
 				avail = scp - src;
 			}
@@ -550,7 +590,7 @@ static int decode_entries(struct packed_git *p, struct pack_window **w_curs,
 		src = scp;
 	}
 
-	return 0;
+	return offset;
 }
 
 void *pv4_get_tree(struct packed_git *p, struct pack_window **w_curs,
@@ -560,7 +600,7 @@ void *pv4_get_tree(struct packed_git *p, struct pack_window **w_curs,
 	unsigned int nb_entries;
 	unsigned char *dst, *dcp;
 	const unsigned char *src, *scp;
-	int ret;
+	off_t ret;
 
 	src = use_pack(p, w_curs, offset, &avail);
 	scp = src;
@@ -571,7 +611,7 @@ void *pv4_get_tree(struct packed_git *p, struct pack_window **w_curs,
 	dst = xmallocz(size);
 	dcp = dst;
 	ret = decode_entries(p, w_curs, offset, 0, nb_entries, &dcp, &size, 0);
-	if (ret < 0 || size != 0) {
+	if (ret == 0 || size != 0) {
 		free(dst);
 		return NULL;
 	}

--Boundary_(ID_x4pjFT9ywF3fZZ+SM2MOFA)--
