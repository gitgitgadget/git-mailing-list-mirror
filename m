From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 2/4] pack v4: add v4_size to struct delta_base_cache_entry
Date: Mon, 16 Sep 2013 00:42:05 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1309160034270.20709@syhkavp.arg>
References: <1378982284-7848-1-git-send-email-pclouds@gmail.com>
 <1378982284-7848-2-git-send-email-pclouds@gmail.com>
 <alpine.LFD.2.03.1309130913510.20709@syhkavp.arg>
 <CACsJy8DrxQqvKyAH0trd1nDbFTL2Gq7k5O-shK4j8W6PMirNYw@mail.gmail.com>
 <alpine.LFD.2.03.1309132155540.20709@syhkavp.arg>
 <alpine.LFD.2.03.1309132351310.20709@syhkavp.arg>
 <CACsJy8CrEwt+WiE9_0CU-TqMCJtNgzouc3e=ifQR=5r+GRXUPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 16 06:42:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLQdf-0002Jc-KF
	for gcvg-git-2@plane.gmane.org; Mon, 16 Sep 2013 06:42:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752132Ab3IPEmH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Sep 2013 00:42:07 -0400
Received: from relais.videotron.ca ([24.201.245.36]:33696 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751962Ab3IPEmG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Sep 2013 00:42:06 -0400
Received: from xanadu.home ([70.83.209.44]) by VL-VM-MR001.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MT700MYEBQ5SSA0@VL-VM-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 16 Sep 2013 00:42:05 -0400 (EDT)
In-reply-to: <CACsJy8CrEwt+WiE9_0CU-TqMCJtNgzouc3e=ifQR=5r+GRXUPQ@mail.gmail.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234826>

On Sun, 15 Sep 2013, Duy Nguyen wrote:

> On Sat, Sep 14, 2013 at 11:22 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
> > The cache is currently updated by the caller.  The caller may ask for a
> > copy of 2 entries from a base object, but that base object may itself
> > copy those objects from somewhere else in a larger chunk.
> >
> > Let's consider this example:
> >
> > tree A
> > ------
> > 0 (0) copy 2 entries from tree B starting at entry 0
> > 1 (2) copy 1 entry from tree B starting at entry 3
> >
> > tree B
> > ------
> > 0 (0) copy 6 entries from tree C starting at entry 0
> > 1 (6) entry "foo.txt"
> > 2 (7) entry "bar.txt"
> >
> > Right now, the code calls decode_entries() to decode 2 entries from tree
> > B but those entries are part of a copy from tree C.  When that call
> > returns, the cache is updated as if tree B entry #2 would start at
> > offset 1 but this is wrong because offset 0 in tree B covers 6 entries
> > and therefore offset 1 is for entry #6.
> >
> > So this needs a rethink.
> 
> I've given it some thought and see no simple/efficient way do it when
> 2+ depth is involved. Ideally tree A should refer to tree C directly
> for the first two entries, but in general we can't enforce that a copy
> sequence must refer to non-copy sequences only. Caching flattened tree
> B up until the 6th entry may help, but then there's no need to cache
> offsets anymore because we could just cache tree A..

Well... for the case where tree A should refer to tree C directly, that 
should be optimized by packv4-create/pack-objects.

But as far as my offset cache is concerned, I came around to rethink it.
I managed to write decent and logical code this time.
The speed-up is significant even without any tuning.  Here it is:

commit aa43ec18956a2c835112f086a0a59d7fbc35a021
Author: Nicolas Pitre <nico@fluxnic.net>
Date:   Fri Sep 13 20:56:31 2013 -0400

    packv4-parse.c: add tree offset caching
    
    It is a common pattern to see a tree object copy a few entries from another
    tree object, possibly from a non zero offset, then provide a few entries
    of its own just to go back to the previous tree object to copy some more
    entries.  Each time this happens, the tree object being copied has to be
    parsed from the beginning over again up to the desired offset which is
    rather wasteful.
    
    Let's introduce a tree offset cache to record the entry position and offset
    when tree parsing stops so a subsequent copy from the same tree object
    can be resumed without having to start from the beginning all the time.
    
    Without doing further tuning on this cache, performing "git rev-list --all
    --objects | wc -l" on my copy of git.git went from 14.5s down to 6.6s.
    
    Signed-off-by: Nicolas Pitre <nico@fluxnic.net>

diff --git a/packv4-parse.c b/packv4-parse.c
index 38c22b0..b8af702 100644
--- a/packv4-parse.c
+++ b/packv4-parse.c
@@ -378,6 +378,40 @@ static int copy_canonical_tree_entries(struct packed_git *p, off_t offset,
 	return 0;
 }
 
+/* ordering is so that member alignment takes the least amount of space */
+struct pv4_tree_cache {
+	off_t base_offset;
+	off_t offset;
+	off_t last_copy_base;
+	struct packed_git *p;
+	unsigned int pos;
+	unsigned int nb_entries;
+};
+
+#define CACHE_SIZE 256
+static struct pv4_tree_cache pv4_tree_cache[CACHE_SIZE];
+
+static struct pv4_tree_cache *get_tree_offset_cache(struct packed_git *p, off_t base_offset)
+{
+	struct pv4_tree_cache *c;
+	unsigned long hash;
+
+	hash = (unsigned long)p + (unsigned long)base_offset;
+	hash += (hash >> 8) + (hash >> 16);
+	hash %= CACHE_SIZE;
+
+	c = &pv4_tree_cache[hash];
+	if (c->p != p || c->base_offset != base_offset) {
+		c->p = p;
+		c->base_offset = base_offset;
+		c->offset = 0;
+		c->last_copy_base = 0;
+		c->pos = 0;
+		c->nb_entries = 0;
+	}
+	return c;
+}
+
 static int tree_entry_prefix(unsigned char *buf, unsigned long size,
 			     const unsigned char *path, int path_len,
 			     unsigned mode)
@@ -405,39 +439,72 @@ static int tree_entry_prefix(unsigned char *buf, unsigned long size,
 }
 
 static int decode_entries(struct packed_git *p, struct pack_window **w_curs,
-			  off_t offset, unsigned int start, unsigned int count,
-			  unsigned char **dstp, unsigned long *sizep,
-			  int parse_hdr)
+			  off_t obj_offset, unsigned int start, unsigned int count,
+			  unsigned char **dstp, unsigned long *sizep)
 {
 	unsigned long avail;
-	unsigned int nb_entries;
 	const unsigned char *src, *scp;
-	off_t copy_objoffset = 0;
+	unsigned int curpos;
+	off_t offset, copy_objoffset;
+	struct pv4_tree_cache *c;
+
+	c = get_tree_offset_cache(p, obj_offset);
+	if (count && start < c->nb_entries && start >= c->pos &&
+	    count <= c->nb_entries - start) {
+		offset = c->offset;
+		copy_objoffset = c->last_copy_base;
+		curpos = c->pos;
+		start -= curpos;
+		src = NULL;
+		avail = 0;
+	} else {
+		unsigned int nb_entries;
 
-	src = use_pack(p, w_curs, offset, &avail);
-	scp = src;
+		src = use_pack(p, w_curs, obj_offset, &avail);
+		scp = src;
 
-	if (parse_hdr) {
 		/* we need to skip over the object header */
 		while (*scp & 128)
 			if (++scp - src >= avail - 20)
 				return -1;
+
 		/* is this a canonical tree object? */
-		if ((*scp & 0xf) == OBJ_TREE)
+		if ((*scp & 0xf) == OBJ_TREE) {
+			offset = obj_offset + (scp - src);
 			return copy_canonical_tree_entries(p, offset,
 							   start, count,
 							   dstp, sizep);
+		}
+
 		/* let's still make sure this is actually a pv4 tree */
 		if ((*scp++ & 0xf) != OBJ_PV4_TREE)
 			return -1;
-	}
 
-	nb_entries = decode_varint(&scp);
-	if (scp == src || start > nb_entries || count > nb_entries - start)
-		return -1;
-	offset += scp - src;
-	avail -= scp - src;
-	src = scp;
+		nb_entries = decode_varint(&scp);
+		if (!count)
+			count = nb_entries;
+		if (!nb_entries || start > nb_entries ||
+		    count > nb_entries - start)
+			return -1;
+
+		curpos = 0;
+		copy_objoffset = 0;
+		offset = obj_offset + scp - src;
+		avail -= scp - src;
+		src = scp;
+
+		/*
+		 * If this is a partial copy, let's (re)initialize a cache
+		 * entry to speed things up if the remaining of this tree
+		 * is needed in the future.
+		 */
+		if (start + count < nb_entries) {
+			c->offset = offset;
+			c->pos = 0;
+			c->nb_entries = nb_entries;
+			c->last_copy_base = 0;
+		}
+	}
 
 	while (count) {
 		unsigned int what;
@@ -464,6 +531,7 @@ static int decode_entries(struct packed_git *p, struct pack_window **w_curs,
 			else
 				while (*scp++ & 128);
 			start--;
+			curpos++;
 		} else if (!(what & 1) && start == 0) {
 			/*
 			 * This is an actual tree entry to recreate.
@@ -485,6 +553,7 @@ static int decode_entries(struct packed_git *p, struct pack_window **w_curs,
 			*dstp += len + 20;
 			*sizep -= len + 20;
 			count--;
+			curpos++;
 		} else if (what & 1) {
 			/*
 			 * Copy from another tree object.
@@ -522,25 +591,34 @@ static int decode_entries(struct packed_git *p, struct pack_window **w_curs,
 						nth_packed_object_offset(p, index - 1);
 				}
 			}
-			if (!copy_objoffset)
-				return -1;
 			copy_count >>= 1;
+			if (!copy_count || !copy_objoffset)
+				return -1;
 
 			if (start >= copy_count) {
 				start -= copy_count;
+				curpos += copy_count;
 			} else {
 				int ret;
+
 				copy_count -= start;
 				copy_start += start;
-				start = 0;
-				if (copy_count > count)
+				if (copy_count > count) {
 					copy_count = count;
-				count -= copy_count;
-				ret = decode_entries(p, w_curs,
-					copy_objoffset, copy_start, copy_count,
-					dstp, sizep, 1);
+					count = 0;
+					scp = src;
+				} else {
+					count -= copy_count;
+					curpos += start + copy_count;
+					start = 0;
+				}
+
+				ret = decode_entries(p, w_curs, copy_objoffset,
+						     copy_start, copy_count,
+						     dstp, sizep);
 				if (ret)
 					return ret;
+
 				/* force pack window readjustment */
 				avail = scp - src;
 			}
@@ -551,27 +629,30 @@ static int decode_entries(struct packed_git *p, struct pack_window **w_curs,
 		src = scp;
 	}
 
+	/*
+	 * Update the cache if we didn't run through the entire tree.
+	 * We have to "get" it again as a recursion into decode_entries()
+	 * could have invalidated what we obtained initially.
+	 */
+	c = get_tree_offset_cache(p, obj_offset);
+	if (curpos < c->nb_entries) {
+		c->pos = curpos;
+		c->offset = offset;
+		c->last_copy_base = copy_objoffset;
+	}
+						
 	return 0;
 }
 
 void *pv4_get_tree(struct packed_git *p, struct pack_window **w_curs,
-		   off_t offset, unsigned long size)
+		   off_t obj_offset, unsigned long size)
 {
-	unsigned long avail;
-	unsigned int nb_entries;
 	unsigned char *dst, *dcp;
-	const unsigned char *src, *scp;
 	int ret;
 
-	src = use_pack(p, w_curs, offset, &avail);
-	scp = src;
-	nb_entries = decode_varint(&scp);
-	if (scp == src)
-		return NULL;
-
 	dst = xmallocz(size);
 	dcp = dst;
-	ret = decode_entries(p, w_curs, offset, 0, nb_entries, &dcp, &size, 0);
+	ret = decode_entries(p, w_curs, obj_offset, 0, 0, &dcp, &size);
 	if (ret < 0 || size != 0) {
 		free(dst);
 		return NULL;
diff --git a/packv4-parse.h b/packv4-parse.h
index d674a3f..b437159 100644
--- a/packv4-parse.h
+++ b/packv4-parse.h
@@ -20,6 +20,6 @@ const unsigned char *get_sha1ref(struct packed_git *p,
 void *pv4_get_commit(struct packed_git *p, struct pack_window **w_curs,
 		     off_t offset, unsigned long size);
 void *pv4_get_tree(struct packed_git *p, struct pack_window **w_curs,
-		   off_t offset, unsigned long size);
+		   off_t obj_offset, unsigned long size);
 
 #endif
diff --git a/sha1_file.c b/sha1_file.c
index 038e22e..e98eb8b 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2178,7 +2178,7 @@ void *unpack_entry(struct packed_git *p, off_t obj_offset,
 		type -= 8;
 		break;
 	case OBJ_PV4_TREE:
-		data = pv4_get_tree(p, &w_curs, curpos, size);
+		data = pv4_get_tree(p, &w_curs, obj_offset, size);
 		type -= 8;
 		break;
 	case OBJ_COMMIT:


Nicolas
