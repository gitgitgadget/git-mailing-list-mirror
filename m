From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 2/2] Implement a simple delta_base cache
Date: Sat, 17 Mar 2007 21:13:57 -0400 (EDT)
Message-ID: <alpine.LFD.0.83.0703172053020.18328@xanadu.home>
References: <Pine.LNX.4.64.0703151747110.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703151941090.4998@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0703151955440.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703151955150.4998@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0703160913361.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703160920030.13402@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0703160934070.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703161216510.13732@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0703161636520.3910@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703161722360.3910@woody.linux-foundation.org>
 <alpine.LFD.0.83.0703162257560.18328@xanadu.home>
 <Pine.LNX.4.64.0703171044550.4964@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703171232180.4964@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703171242180.4964@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703171420420.4964@woody.linux-foundation.org>
 <7vfy83qyxh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Mar 18 02:14:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSjyD-0002Jo-MC
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 02:14:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752951AbXCRBOA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Mar 2007 21:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752957AbXCRBOA
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Mar 2007 21:14:00 -0400
Received: from relais.videotron.ca ([24.201.245.36]:45075 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752951AbXCRBN7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2007 21:13:59 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JF2004Z3RF90V50@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 17 Mar 2007 21:13:58 -0400 (EDT)
In-reply-to: <7vfy83qyxh.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42462>

On Sat, 17 Mar 2007, Junio C Hamano wrote:

> When unpacking a depth-3 deltified object A, the code finds the
> target object A (which is a delta), ask for its base B and put B
> in the cache after using it to reconstitute A.  While doing so,
> the first-generation base B is also a delta so its base C (which
> is a non-delta) is found and placed in the cache.  When A is
> returned, the cache has B and C.  If you ask for B at this
> point, we read the delta, pick up its base C from the cache,
> apply, and return while putting C back in the cache.  If you ask
> for A after that, we do not read from the cache, although it is
> available.
> 
> Which feels a bit wasteful at first sight, and we *could* make
> read_packed_sha1() also steal from the cache, but after thinking
> about it a bit, I am not sure if it is worth it.  The contract
> between read_packed_sha1() and read_sha1_file() and its callers
> is that the returned data belongs to the caller and it is a
> responsibility for the caller to free the buffer, and also the
> caller is free to modify it, so stealing from the cache from
> that codepath means an extra allocation and memcpy.

So?

A malloc() + memcpy() will always be faster than mmap() + malloc() + 
inflate().  If the data is already there it is certainly better to copy 
it straight away.

With the patch below I can do 'git log drivers/scsi/ > /dev/null' about 
7% faster.  I bet it might be even more on those platforms with bad 
mmap() support.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
diff --git a/sha1_file.c b/sha1_file.c
index a7e3a2a..ee64865 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1372,7 +1372,7 @@ static unsigned long pack_entry_hash(struct packed_git *p, off_t base_offset)
 }
 
 static void *cache_or_unpack_entry(struct packed_git *p, off_t base_offset,
-	unsigned long *base_size, enum object_type *type)
+	unsigned long *base_size, enum object_type *type, int keep_cache)
 {
 	void *ret;
 	unsigned long hash = pack_entry_hash(p, base_offset);
@@ -1384,7 +1384,13 @@ static void *cache_or_unpack_entry(struct packed_git *p, off_t base_offset,
 	return unpack_entry(p, base_offset, type, base_size);
 
 found_cache_entry:
-	ent->data = NULL;
+	if (!keep_cache)
+		ent->data = NULL;
+	else {
+		ret = xmalloc(ent->size + 1);
+		memcpy(ret, ent->data, ent->size);
+		((char *)ret)[ent->size] = 0;
+	}
 	*type = ent->type;
 	*base_size = ent->size;
 	return ret;
@@ -1418,7 +1424,7 @@ static void *unpack_delta_entry(struct packed_git *p,
 	off_t base_offset;
 
 	base_offset = get_delta_base(p, w_curs, &curpos, *type, obj_offset);
-	base = cache_or_unpack_entry(p, base_offset, &base_size, type);
+	base = cache_or_unpack_entry(p, base_offset, &base_size, type, 0);
 	if (!base)
 		die("failed to read delta base object"
 		    " at %"PRIuMAX" from %s",
@@ -1615,7 +1621,7 @@ static void *read_packed_sha1(const unsigned char *sha1,
 	if (!find_pack_entry(sha1, &e, NULL))
 		return NULL;
 	else
-		return unpack_entry(e.p, e.offset, type, size);
+		return cache_or_unpack_entry(e.p, e.offset, size, type, 1);
 }
 
 /*
