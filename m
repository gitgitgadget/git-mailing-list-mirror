From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] sha1_file: remove recursion in packed_object_info
Date: Tue, 19 Mar 2013 23:08:13 +0100
Message-ID: <c5fc1d2040544965ad3cc09e7b82b6013f06b7fa.1363729774.git.trast@student.ethz.ch>
References: <7v1ubbjmq7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Zager <szager@google.com>, <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 19 23:08:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UI4iC-000324-3k
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 23:08:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934157Ab3CSWIX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 18:08:23 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:3570 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933133Ab3CSWIW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 18:08:22 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 19 Mar
 2013 23:08:14 +0100
Received: from pctrast.v.cablecom.net (46.126.8.85) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 19 Mar
 2013 23:08:18 +0100
X-Mailer: git-send-email 1.8.2.490.g25051b0
In-Reply-To: <7v1ubbjmq7.fsf@alter.siamese.dyndns.org>
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218559>

packed_object_info() and packed_delta_info() were mutually recursive.
The former would handle ordinary types and defer deltas to the latter;
the latter would use the former to resolve the delta base.

This arrangement, however, leads to trouble with threaded index-pack
and long delta chains on platforms where thread stacks are small, as
happened on OS X (512kB thread stacks by default) with the chromium
repo.

The task of the two functions is not all that hard to describe without
any recursion, however.  It proceeds in three steps:

- determine the representation type and size, based on the outermost
  object (delta or not)

- follow through the delta chain, if any

- determine the object type from what is found at the end of the delta
  chain

The only complication stems from the error recovery.  If parsing fails
at any step, we want to mark that object (within the pack) as bad and
try getting the corresponding SHA1 from elsewhere.  If that also
fails, we want to repeat this process back up the delta chain until we
find a reasonable solution or conclude that there is no way to
reconstruct the object.  (This is conveniently checked by t5303.)

To achieve that within the pack, we keep track of the entire delta
chain in a stack.  When things go sour, we process that stack from the
top, marking entries as bad and attempting to re-resolve by sha1.  To
avoid excessive malloc(), the stack starts out with a small
stack-allocated array.  The choice of 64 is based on the default of
pack.depth, which is 50, in the hope that it covers "most" delta
chains without any need for malloc().

It's much harder to make the actual re-resolving by sha1 nonrecursive,
so we skip that.  If you can't afford *that* recursion, your
corruption problems are more serious than your stack size problems.

Reported-by: Stefan Zager <szager@google.com>
Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <trast@student.ethz.ch> writes:
> 
> > Actually scratch that again.  It *is* a stack overflow, except that this
> > is a thread stack, for which the OS X defaults are 512kB apparently, as
> > opposed to 2MB on linux.
> > ...
> > And indeed the following patch fixes it.  Sounds like the delta
> > unpacking needs a rewrite to support stackless operation.  Sigh.
> 
> Yikes.  Thanks for digging it to the bottom.

So here's a nonrecursive version.  Dijkstra is probably turning over
in his grave as we speak.

I *think* I actually got it right.  It passes tests in any case. ;-)

The sad part is, after all the effort it still bombs out in the same
place because of the very similar recursion in unpack_entry().  I'll
save that for another day.


 sha1_file.c | 132 +++++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 81 insertions(+), 51 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 16967d3..54e92a2 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1639,50 +1639,6 @@ static off_t get_delta_base(struct packed_git *p,
 	return base_offset;
 }
 
-/* forward declaration for a mutually recursive function */
-static int packed_object_info(struct packed_git *p, off_t offset,
-			      unsigned long *sizep, int *rtype);
-
-static int packed_delta_info(struct packed_git *p,
-			     struct pack_window **w_curs,
-			     off_t curpos,
-			     enum object_type type,
-			     off_t obj_offset,
-			     unsigned long *sizep)
-{
-	off_t base_offset;
-
-	base_offset = get_delta_base(p, w_curs, &curpos, type, obj_offset);
-	if (!base_offset)
-		return OBJ_BAD;
-	type = packed_object_info(p, base_offset, NULL, NULL);
-	if (type <= OBJ_NONE) {
-		struct revindex_entry *revidx;
-		const unsigned char *base_sha1;
-		revidx = find_pack_revindex(p, base_offset);
-		if (!revidx)
-			return OBJ_BAD;
-		base_sha1 = nth_packed_object_sha1(p, revidx->nr);
-		mark_bad_packed_object(p, base_sha1);
-		type = sha1_object_info(base_sha1, NULL);
-		if (type <= OBJ_NONE)
-			return OBJ_BAD;
-	}
-
-	/* We choose to only get the type of the base object and
-	 * ignore potentially corrupt pack file that expects the delta
-	 * based on a base with a wrong size.  This saves tons of
-	 * inflate() calls.
-	 */
-	if (sizep) {
-		*sizep = get_size_from_delta(p, w_curs, curpos);
-		if (*sizep == 0)
-			type = OBJ_BAD;
-	}
-
-	return type;
-}
-
 int unpack_object_header(struct packed_git *p,
 			 struct pack_window **w_curs,
 			 off_t *curpos,
@@ -1709,6 +1665,25 @@ int unpack_object_header(struct packed_git *p,
 	return type;
 }
 
+static int retry_bad_packed_offset(struct packed_git *p, off_t obj_offset)
+{
+	int type;
+	struct revindex_entry *revidx;
+	const unsigned char *sha1;
+	revidx = find_pack_revindex(p, obj_offset);
+	if (!revidx)
+		return OBJ_BAD;
+	sha1 = nth_packed_object_sha1(p, revidx->nr);
+	mark_bad_packed_object(p, sha1);
+	type = sha1_object_info(sha1, NULL);
+	if (type <= OBJ_NONE)
+		return OBJ_BAD;
+	return type;
+}
+
+
+#define POI_STACK_PREALLOC 64
+
 static int packed_object_info(struct packed_git *p, off_t obj_offset,
 			      unsigned long *sizep, int *rtype)
 {
@@ -1716,31 +1691,86 @@ static int packed_object_info(struct packed_git *p, off_t obj_offset,
 	unsigned long size;
 	off_t curpos = obj_offset;
 	enum object_type type;
+	off_t small_poi_stack[POI_STACK_PREALLOC];
+	off_t *poi_stack = small_poi_stack;
+	int poi_stack_nr = 0, poi_stack_alloc = POI_STACK_PREALLOC;
 
 	type = unpack_object_header(p, &w_curs, &curpos, &size);
+
 	if (rtype)
 		*rtype = type; /* representation type */
 
+	if (sizep) {
+		if (type == OBJ_OFS_DELTA || type == OBJ_REF_DELTA) {
+			off_t tmp_pos = curpos;
+			get_delta_base(p, &w_curs, &tmp_pos, type, obj_offset);
+			*sizep = get_size_from_delta(p, &w_curs, tmp_pos);
+			if (*sizep == 0) {
+				type = OBJ_BAD;
+				goto out;
+			}
+		} else {
+			*sizep = size;
+		}
+	}
+
+	while (type == OBJ_OFS_DELTA || type == OBJ_REF_DELTA) {
+		off_t base_offset;
+		/* Push the object we're going to leave behind */
+		if (poi_stack_nr >= poi_stack_alloc && poi_stack == small_poi_stack) {
+			poi_stack_alloc = alloc_nr(poi_stack_nr);
+			poi_stack = xmalloc(sizeof(off_t)*poi_stack_alloc);
+			memcpy(poi_stack, small_poi_stack, sizeof(off_t)*poi_stack_nr);
+		} else {
+			ALLOC_GROW(poi_stack, poi_stack_nr+1, poi_stack_alloc);
+		}
+		poi_stack[poi_stack_nr++] = obj_offset;
+		/* If parsing the base offset fails, just unwind */
+		base_offset = get_delta_base(p, &w_curs, &curpos, type, obj_offset);
+		if (!base_offset)
+			goto unwind;
+		curpos = obj_offset = base_offset;
+		type = unpack_object_header(p, &w_curs, &curpos, &size);
+		if (type <= OBJ_NONE) {
+			/* If getting the base itself fails, we first
+			 * retry the base, otherwise unwind */
+			type = retry_bad_packed_offset(p, base_offset);
+			if (type > OBJ_NONE)
+				goto out;
+			goto unwind;
+		}
+	}
+
 	switch (type) {
-	case OBJ_OFS_DELTA:
-	case OBJ_REF_DELTA:
-		type = packed_delta_info(p, &w_curs, curpos,
-					 type, obj_offset, sizep);
-		break;
+	case OBJ_BAD:
 	case OBJ_COMMIT:
 	case OBJ_TREE:
 	case OBJ_BLOB:
 	case OBJ_TAG:
-		if (sizep)
-			*sizep = size;
 		break;
 	default:
 		error("unknown object type %i at offset %"PRIuMAX" in %s",
 		      type, (uintmax_t)obj_offset, p->pack_name);
 		type = OBJ_BAD;
 	}
+
+out:
+	if (poi_stack != small_poi_stack)
+		free(poi_stack);
 	unuse_pack(&w_curs);
 	return type;
+
+unwind:
+	while (poi_stack_nr) {
+		obj_offset = poi_stack[poi_stack_nr--];
+		type = retry_bad_packed_offset(p, obj_offset);
+		if (type > OBJ_NONE)
+			goto out;
+	}
+	if (poi_stack != small_poi_stack)
+		free(poi_stack);
+	unuse_pack(&w_curs);
+	return OBJ_BAD;
 }
 
 static void *unpack_compressed_entry(struct packed_git *p,
-- 
1.8.2.490.g25051b0
