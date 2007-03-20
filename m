From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] don't ever allow SHA1 collisions to exist by fetching a pack
Date: Tue, 20 Mar 2007 15:32:35 -0400 (EDT)
Message-ID: <alpine.LFD.0.83.0703201508190.18328@xanadu.home>
References: <20070320053813.GC29288@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Mar 20 20:32:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTk4k-00058v-9N
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 20:32:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752595AbXCTTci (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Mar 2007 15:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752601AbXCTTci
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 15:32:38 -0400
Received: from relais.videotron.ca ([24.201.245.36]:27742 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752595AbXCTTch (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2007 15:32:37 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JF700MZ4VMC0DD0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 20 Mar 2007 15:32:36 -0400 (EDT)
In-reply-to: <20070320053813.GC29288@spearce.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42758>

Waaaaaaay back Git was considered to be secure as it never overwrote
an object it already had.  This was ensured by always unpacking the
packfile received over the network (both in fetch and receive-pack)
and our already existing logic to not create a loose object for an
object we already have.

Lately however we keep "large-ish" packfiles on both fetch and push
by running them through index-pack instead of unpack-objects.  This
would let an attacker perform a birthday attack. 

How?  Assume the attacker knows a SHA-1 that has two different
data streams.  He knows the client is likely to have the "good"
one.  So he sends the "evil" variant to the other end as part of
a "large-ish" packfile.  The recipient keeps that packfile, and
indexes it.  Now since this is a birthday attack there is a SHA-1
collision; two objects exist in the repository with the same SHA-1.
They have *very* different data streams.  One of them is "evil".

Currently the poor recipient cannot tell the two objects apart,
short of by examining the timestamp of the packfiles.  But lets
say the recipient repacks before he realizes he's been attacked.
We may wind up packing the "evil" version of the object, and deleting
the "good" one.  This is made *even more likely* by Junio's recent
rearrange_packed_git patch (b867092f).

It is extremely unlikely for a SHA1 collisions to occur, but if it
ever happens with a remote (hence untrusted) object we simply must
not let the fetch succeed.

Normally received packs should not contain objects we already have.
But when they do we must ensure duplicated objects with the same SHA1
actually contain the same data.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

Explanation text for the log message shamelessly stolen from Shawn's 
email on this issue.

I also provided a test for this otherwise it might never get exercised.

diff --git a/index-pack.c b/index-pack.c
index b405864..4effb2d 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -345,7 +345,8 @@ static int find_delta_children(const union delta_base *base,
 }
 
 static void sha1_object(const void *data, unsigned long size,
-			enum object_type type, unsigned char *sha1)
+			enum object_type type, unsigned char *sha1,
+			int test_for_collision)
 {
 	SHA_CTX ctx;
 	char header[50];
@@ -367,6 +368,18 @@ static void sha1_object(const void *data, unsigned long size,
 	SHA1_Update(&ctx, header, header_size);
 	SHA1_Update(&ctx, data, size);
 	SHA1_Final(sha1, &ctx);
+
+	if (test_for_collision && has_sha1_file(sha1)) {
+		void *has_data;
+		enum object_type has_type;
+		unsigned long has_size;
+		has_data = read_sha1_file(sha1, &has_type, &has_size);
+		if (!has_data)
+			die("cannot read existing object %s", sha1_to_hex(sha1));
+		if (size != has_size || type != has_type ||
+		    memcmp(data, has_data, size) != 0)
+			die("SHA1 COLLISION FOUND WITH %s !", sha1_to_hex(sha1));
+	}
 }
 
 static void resolve_delta(struct object_entry *delta_obj, void *base_data,
@@ -387,7 +400,7 @@ static void resolve_delta(struct object_entry *delta_obj, void *base_data,
 	free(delta_data);
 	if (!result)
 		bad_object(delta_obj->offset, "failed to apply delta");
-	sha1_object(result, result_size, type, delta_obj->sha1);
+	sha1_object(result, result_size, type, delta_obj->sha1, 1);
 	nr_resolved_deltas++;
 
 	hashcpy(delta_base.sha1, delta_obj->sha1);
@@ -444,7 +457,7 @@ static void parse_pack_objects(unsigned char *sha1)
 			delta->obj_no = i;
 			delta++;
 		} else
-			sha1_object(data, obj->size, obj->type, obj->sha1);
+			sha1_object(data, obj->size, obj->type, obj->sha1, 1);
 		free(data);
 		if (verbose)
 			percent = display_progress(i+1, nr_objects, percent);
@@ -565,7 +578,7 @@ static void append_obj_to_pack(void *buf,
 	write_or_die(output_fd, header, n);
 	obj[1].offset = obj[0].offset + n;
 	obj[1].offset += write_compressed(output_fd, buf, size);
-	sha1_object(buf, size, type, obj->sha1);
+	sha1_object(buf, size, type, obj->sha1, 0);
 }
 
 static int delta_pos_compare(const void *_a, const void *_b)
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index eacb1e9..75e7276 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -255,4 +255,14 @@ test_expect_success \
 
      :'
 
+test_expect_success \
+    'fake a SHA1 hash collision' \
+    'test -f	.git/objects/c8/2de19312b6c3695c0c18f70709a6c535682a67 &&
+     cp -f	.git/objects/9d/235ed07cd19811a6ceb342de82f190e49c9f68 \
+		.git/objects/c8/2de19312b6c3695c0c18f70709a6c535682a67'
+
+test_expect_failure \
+    'make sure index-pack detects the SHA1 collision' \
+    'git-index-pack -o bad.idx test-3.pack'
+
 test_done
