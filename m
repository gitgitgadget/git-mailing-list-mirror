From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 1/9] close another possibility for propagating pack corruption
Date: Wed, 29 Oct 2008 19:02:44 -0400
Message-ID: <1225321372-6570-2-git-send-email-nico@cam.org>
References: <1225321372-6570-1-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 30 00:05:57 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvK6r-0004tU-7P
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 00:05:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754892AbYJ2XDJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 19:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756905AbYJ2XDH
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 19:03:07 -0400
Received: from relais.videotron.ca ([24.201.245.36]:39112 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754883AbYJ2XDE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 19:03:04 -0400
Received: from localhost.localdomain ([66.131.194.97])
 by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K9I00DV4W0SZRE0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 29 Oct 2008 19:02:53 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.3.757.g01be.dirty
In-reply-to: <1225321372-6570-1-git-send-email-nico@cam.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99422>

Abstract
--------

With index v2 we have a per object CRC to allow quick and safe reuse of
pack data when repacking.  this, however, doesn't currently prevent a
stealth corruption from being propagated into a new pack when _not_
reusing pack data as demonstrated by the modification to t5302 included
here.

The Context
-----------

The Git database is all checksumed with SHA1 hashes.  Any kind of
corruption can be confirmed by verifying this per object hash against
corresponding data.  However this can be costly to perform systematically
and therefore this check is often not performed at run time when
accessing the object database.

First, the loose object format is entirely compressed with zlib which
already provide a CRC verification of its own when inflating data.  Any
disk corruption would be caught already in this case.

Then, packed objects are also compressed with zlib but only for their
actual payload.  The object headers and delta base references are not
deflated for obvious performance reasons, however this leave them
vulnerable to potentially undetected disk corruptions.  Object types
are often validated against the expected type when they're requested,
and deflated size must always match the size recorded in the object header,
so those cases are pretty much covered as well.

Where corruptions could go unnoticed is in the delta base reference.
Of course, in the OBJ_REF_DELTA case,  the odds for a SHA1 reference to
get corrupted so it actually matches the SHA1 of another object with the
same size (the delta header stores the expected size of the base object
to apply against) are virtually zero.  In the OBJ_OFS_DELTA case, the
reference is a pack offset which would have to match the start boundary
of a different base object but still with the same size, and although this
is relatively much more "probable" than in the OBJ_REF_DELTA case, the
probability is also about zero in absolute terms.  Still, the possibility
exists as demonstrated in t5302 and is certainly greater than a SHA1
collision, especially in the OBJ_OFS_DELTA case which is now the default
when repacking.

Again, repacking by reusing existing pack data is OK since the per object
CRC provided by index v2 guards against any such corruptions. What t5302
failed to test is a full repack in such case.

The Solution
------------

As unlikely as this kind of stealth corruption can be in practice, it
certainly isn't acceptable to propagate it into a freshly created pack.
But, because this is so unlikely, we don't want to pay the run time cost
associated with extra validation checks all the time either.  Furthermore,
consequences of such corruption in anything but repacking should be rather
visible, and even if it could be quite unpleasant, it still has far less
severe consequences than actively creating bad packs.

So the best compromize is to check packed object CRC when unpacking
objects, and only during the compression/writing phase of a repack, and
only when not streaming the result.  The cost of this is minimal (less
than 1% CPU time), and visible only with a full repack.

Someone with a stats background could provide an objective evaluation of
this, but I suspect that it's bad RAM that has more potential for data
corruptions at this point, even in those cases where this extra check
is not performed.  Still, it is best to prevent a known hole for
corruption when recreating object data into a new pack.

What about the streamed pack case?  Well, any client receiving a pack
must always consider that pack as untrusty and perform full validation
anyway, hence no such stealth corruption could be propagated to remote
repositoryes already.  It is therefore worthless doing local validation
in that case.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 builtin-pack-objects.c |   12 ++++++++++++
 sha1_file.c            |   15 +++++++++++++++
 t/t5302-pack-index.sh  |    3 ++-
 3 files changed, 29 insertions(+), 1 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 59c30d1..0366277 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1689,6 +1689,8 @@ static int add_ref_tag(const char *path, const unsigned char *sha1, int flag, vo
 	return 0;
 }
 
+extern int do_check_packed_object_crc;
+
 static void prepare_pack(int window, int depth)
 {
 	struct object_entry **delta_list;
@@ -1697,6 +1699,16 @@ static void prepare_pack(int window, int depth)
 
 	get_object_details();
 
+	/*
+	 * If we're locally repacking then we need to be doubly careful
+	 * from now on in order to make sure no stealth corruption gets
+	 * propagated to the new pack.  Clients receiving streamed packs
+	 * should validate everything they get anyway so no need to incure
+	 * the additional cost here in that case.
+	 */
+	if (!pack_to_stdout)
+		do_check_packed_object_crc = 1;
+
 	if (!nr_objects || !window || !depth)
 		return;
 
diff --git a/sha1_file.c b/sha1_file.c
index ab2b520..88d9cf3 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1694,6 +1694,8 @@ static void *unpack_delta_entry(struct packed_git *p,
 	return result;
 }
 
+int do_check_packed_object_crc;
+
 void *unpack_entry(struct packed_git *p, off_t obj_offset,
 		   enum object_type *type, unsigned long *sizep)
 {
@@ -1701,6 +1703,19 @@ void *unpack_entry(struct packed_git *p, off_t obj_offset,
 	off_t curpos = obj_offset;
 	void *data;
 
+	if (do_check_packed_object_crc && p->index_version > 1) {
+		struct revindex_entry *revidx = find_pack_revindex(p, obj_offset);
+		unsigned long len = revidx[1].offset - obj_offset;
+		if (check_pack_crc(p, &w_curs, obj_offset, len, revidx->nr)) {
+			const unsigned char *sha1 =
+				nth_packed_object_sha1(p, revidx->nr);
+			error("bad packed object CRC for %s",
+			      sha1_to_hex(sha1));
+			mark_bad_packed_object(p, sha1);
+			return NULL;
+		}
+	}
+
 	*type = unpack_object_header(p, &w_curs, &curpos, sizep);
 	switch (*type) {
 	case OBJ_OFS_DELTA:
diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
index b0b0fda..884e242 100755
--- a/t/t5302-pack-index.sh
+++ b/t/t5302-pack-index.sh
@@ -196,7 +196,8 @@ test_expect_success \
 
 test_expect_success \
     '[index v2] 5) pack-objects refuses to reuse corrupted data' \
-    'test_must_fail git pack-objects test-5 <obj-list'
+    'test_must_fail git pack-objects test-5 <obj-list &&
+     test_must_fail git pack-objects --no-reuse-object test-6 <obj-list'
 
 test_expect_success \
     '[index v2] 6) verify-pack detects CRC mismatch' \
-- 
1.6.0.3.757.g01be.dirty
