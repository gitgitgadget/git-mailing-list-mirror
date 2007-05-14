From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: Re: [RFC] Optimize diff-delta.c
Date: Mon, 14 May 2007 22:43:17 +0200
Message-ID: <11791753973509-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon May 14 22:43:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnhOG-0007JU-EM
	for gcvg-git@gmane.org; Mon, 14 May 2007 22:43:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755673AbXENUnW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 16:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756106AbXENUnW
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 16:43:22 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:37768 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755673AbXENUnU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 16:43:20 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 933377A9D81D;
	Mon, 14 May 2007 22:43:18 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JWAGs54d5kae; Mon, 14 May 2007 22:43:17 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id D20FC73820C1; Mon, 14 May 2007 22:43:17 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47289>

git-pack-objects: cache small deltas between big objects

---
On Mon, 14 May 2007, Nicolas Pitre wrote:
> > I did some tests on differenent machines:
> > 
> > - attached patch
> >    Total 6452 (delta 4581), reused 1522 (delta 0)
> >    11354.38user 5451.60system 4:40:09elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
> >    0inputs+0outputs (0major+1371504762minor)pagefaults 0swaps
> >    =>75 MB pack size
> 
> This is quite weird.  I wonder what might cause such a large difference 
> in pack size.
> 
> Your first patch is probably faster due to the use of memcmp() which is 
> certainly highly optimized, more than the comparison loop we have.  It 
> is unfortunate that there is no library function to find the number of 
> identical bytes between two buffers.  Or is there some?

As far as I know, no.

> But the size difference?  That has certainly something to do with your 
> data set since your patch makes no significant difference on the git.git 
> nor the Linux kernel repos.  Would it be possible for me to have a copy 
> of your repo for further analysis?

I generate my repository by dumping a database. A script dumps a
few tables with mysqldump into per table files and commits them.
The dump file of each tables uses the one insert per line syntax, so 
nearly all lines of a file share a >=27 bytes prefix. A diffstat to 
the previous commit typically shows, that some 
hundred lines are added at the end of each file.

A statistic of dropped hash table entries of the first thousand objects 
in create_delta_index shows, that up to 41 % are dropped, eg:
Dropping: 3404731 of 8540915 (39.86 %)
Dropping: 3397330 of 8525886 (39.85 %)
Dropping: 3388813 of 8509648 (39.82 %)
Dropping: 3381134 of 8494317 (39.80 %)
Dropping: 3381128 of 8494294 (39.80 %)
Dropping: 3375786 of 8483589 (39.79 %)
Dropping: 3369725 of 8472206 (39.77 %)
Dropping: 3364377 of 8460707 (39.76 %)
Dropping: 3358120 of 8447813 (39.75 %)
Dropping: 3351482 of 8435015 (39.73 %)
Dropping: 3351481 of 8435007 (39.73 %)
Dropping: 3351478 of 8435000 (39.73 %)
Dropping: 3346193 of 8424055 (39.72 %)
Dropping: 3339952 of 8410503 (39.71 %)
Dropping: 3334324 of 8398253 (39.70 %)
Dropping: 3370085 of 8384362 (40.19 %)
Dropping: 3362979 of 8369151 (40.18 %)
Dropping: 3354905 of 8353432 (40.16 %)

So the current code will probably not always find the best match. As
my last patch can match nearly the whole file after finding a match,
the missing entries will not have a big influence.

As a side effect, my last patch increased the total running time and
minor page faults compared to the orignal version. I can not explain,
why this happens. The deltifing phase needs to read and uncompress the
same data. The only difference I can image, is, that different objects are selected
as delta base for the writing phase, which require more reading time (eg. because
they are bigger or have a longer delta chain in their current pack file).

As a large amount of CPU time is spent in writing the pack file (reading
all blobs again and applying the delta chain, computing the
delta_index and recomputing the delta) and the deltas are small, 
I tried to cache the deltas from try_delta,
if the compared blobs are big (and therefore the delta operation is
expensive):

- my last patch + this patch
  Total 6452 (delta 4581), reused 1522 (delta 0)
  4176.04user 322.10system 1:14:58elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
  0inputs+0outputs (0major+83869085minor)pagefaults 0swaps
  => 75MB

 builtin-pack-objects.c |   35 +++++++++++++++++++++++++----------
 1 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 966f843..fe19272 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -35,6 +35,7 @@ struct object_entry {
 	struct object_entry *delta_sibling; /* other deltified objects who
 					     * uses the same base as me
 					     */
+	void *delta_data;	/* cached delta (uncompressed) */
 	unsigned long delta_size;	/* delta data size (uncompressed) */
 	enum object_type type;
 	enum object_type in_pack_type;	/* could be delta */
@@ -445,17 +446,24 @@ static unsigned long write_object(struct sha1file *f,
 	}
 
 	if (!to_reuse) {
-		buf = read_sha1_file(entry->sha1, &type, &size);
-		if (!buf)
-			die("unable to read %s", sha1_to_hex(entry->sha1));
-		if (size != entry->size)
-			die("object %s size inconsistency (%lu vs %lu)",
-			    sha1_to_hex(entry->sha1), size, entry->size);
-		if (entry->delta) {
-			buf = delta_against(buf, size, entry);
+		if (entry->delta_data) {
+			buf = entry->delta_data;
 			size = entry->delta_size;
 			obj_type = (allow_ofs_delta && entry->delta->offset) ?
-				OBJ_OFS_DELTA : OBJ_REF_DELTA;
+					OBJ_OFS_DELTA : OBJ_REF_DELTA;
+		} else {
+			buf = read_sha1_file(entry->sha1, &type, &size);
+			if (!buf)
+				die("unable to read %s", sha1_to_hex(entry->sha1));
+			if (size != entry->size)
+				die("object %s size inconsistency (%lu vs %lu)",
+				    sha1_to_hex(entry->sha1), size, entry->size);
+			if (entry->delta) {
+				buf = delta_against(buf, size, entry);
+				size = entry->delta_size;
+				obj_type = (allow_ofs_delta && entry->delta->offset) ?
+					OBJ_OFS_DELTA : OBJ_REF_DELTA;
+			}
 		}
 		/*
 		 * The object header is a byte of 'type' followed by zero or
@@ -1359,10 +1367,17 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 	if (!delta_buf)
 		return 0;
 
+	if (trg_entry->delta_data)
+		free (trg_entry->delta_data);
+	trg_entry->delta_data = 0;
 	trg_entry->delta = src_entry;
 	trg_entry->delta_size = delta_size;
 	trg_entry->depth = src_entry->depth + 1;
-	free(delta_buf);
+	/* cache delta, if objects are large enough compared to delta size */
+	if ((src_size >> 20) + (trg_size >> 21) > (delta_size >> 10))
+		trg_entry->delta_data = delta_buf;
+	else
+		free(delta_buf);
 	return 1;
 }
 
-- 
1.5.1.4.g01b3
