From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Emit base objects of a delta chain when the delta is
 output.
Date: Tue, 28 Jun 2005 17:49:27 -0700
Message-ID: <7vll4uoulk.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0506271755140.19755@ppc970.osdl.org>
	<20050627235857.GA21533@64m.dyndns.org>
	<Pine.LNX.4.58.0506272016420.19755@ppc970.osdl.org>
	<20050628103852.GB21533@64m.dyndns.org>
	<Pine.LNX.4.58.0506280921480.19755@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 29 02:46:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnQis-0002zk-Ao
	for gcvg-git@gmane.org; Wed, 29 Jun 2005 02:46:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262407AbVF2AxD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Jun 2005 20:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262391AbVF2AwV
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jun 2005 20:52:21 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:58573 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S262407AbVF2At3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2005 20:49:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050629004927.HZQV22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 28 Jun 2005 20:49:27 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> While adding a new object to a pack file is _possible_ (you add it to the
LT> end of the pack-file, and re-generate the index file), I would strongly
LT> suggest against it for several reasons:

OK, people have convinced me not to dream on ;-).

LT> Btw, I'm not claiming that my current pack format is "optimal" of course.  
LT> For example, while I write all objects in recency order, right now that
LT> means that if a recent object has been written as a delta that depends on
LT> an older one, I actually write the delta first (correct) but I won't write
LT> the older object until its recency ordering (wrong).

I agree.  

How does this one look?  Lightly tested by packing, unpacking
without -n and fsck'ing, not unpacking but placing it under
.git/objects/pack and running fsck with --full, all using the
current GIT repo.

------------
Deltas are useless by themselves and when you use them you need
to get to their base objects.  A base object should inherit
recency from the most recent deltified object that is based on
it and that is what this patch teaches git-pack-objects.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
cd /opt/packrat/playpen/public/in-place/git/git.junio/
jit-diff
# - master: Use enhanced diff_delta() in the similarity estimator.
# + (working tree)
diff --git a/pack-objects.c b/pack-objects.c
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -118,6 +118,23 @@ static unsigned long write_object(struct
 	return hdrlen + datalen;
 }
 
+static unsigned long write_one(struct sha1file *f,
+			       struct object_entry *e,
+			       unsigned long offset)
+{
+	if (e->offset)
+		/* offset starts from header size and cannot be zero
+		 * if it is written already.
+		 */
+		return offset;
+	e->offset = offset;
+	offset += write_object(f, e);
+	/* if we are delitified, write out its base object. */
+	if (e->delta)
+		offset = write_one(f, e->delta, offset);
+	return offset;
+}
+
 static void write_pack_file(void)
 {
 	int i;
@@ -135,11 +152,9 @@ static void write_pack_file(void)
 	hdr.hdr_entries = htonl(nr_objects);
 	sha1write(f, &hdr, sizeof(hdr));
 	offset = sizeof(hdr);
-	for (i = 0; i < nr_objects; i++) {
-		struct object_entry *entry = objects + i;
-		entry->offset = offset;
-		offset += write_object(f, entry);
-	}
+	for (i = 0; i < nr_objects; i++)
+		offset = write_one(f, objects + i, offset);
+
 	sha1close(f, pack_file_sha1, 1);
 	mb = offset >> 20;
 	offset &= 0xfffff;

Compilation finished at Tue Jun 28 17:43:31
