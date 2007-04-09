From: Nicolas Pitre <nico@cam.org>
Subject: Re: support for large packs and 64-bit offsets
Date: Mon, 09 Apr 2007 15:46:38 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704091542400.28181@xanadu.home>
References: <11760951973172-git-send-email-nico@cam.org>
 <20070409171925.GS5436@spearce.org>
 <Pine.LNX.4.64.0704091059240.6730@woody.linux-foundation.org>
 <alpine.LFD.0.98.0704091417490.28181@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Apr 10 02:27:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hazp7-0000WP-31
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 21:46:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753437AbXDITql (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Apr 2007 15:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753468AbXDITqk
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 15:46:40 -0400
Received: from relais.videotron.ca ([24.201.245.36]:59869 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753437AbXDITqj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2007 15:46:39 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JG8008S2XLQWBY0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 09 Apr 2007 15:46:39 -0400 (EDT)
In-reply-to: <alpine.LFD.0.98.0704091417490.28181@xanadu.home>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44091>

On Mon, 9 Apr 2007, Nicolas Pitre wrote:

> >  - force a mode where a random smattering of index entries are done using 
> >    64-bit notation (even if they obviously won't need the high 33 bits)
> 
> That could be achieved with an additional criteria, like the offset's 
> LSB value which should be pretty random.
> 
> Once Junio merges the series in a branch of its own, we could have a 
> separate patch not in that branch that simply forces those features on 
> in branch 'next'.

Something like this, although I suppose this might require a more 
permanent solution for the test suite:

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 8cf2871..8d20ea9 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -607,8 +607,12 @@ static void write_index_file(off_t last_obj_offset)
 	uint32_t array[256];
 	uint32_t index_version;
 
+#if 0
 	/* if last object's offset is >= 2^31 we should use index V2 */
 	index_version = (last_obj_offset >> 31) ? 2 : 1;
+#else
+	index_version = 2;
+#endif
 
 	/* index versions 2 and above need a header */
 	if (index_version >= 2) {
@@ -664,8 +668,15 @@ static void write_index_file(off_t last_obj_offset)
 		list = sorted_by_sha;
 		for (i = 0; i < nr_objects; i++) {
 			struct object_entry *entry = *list++;
+#if 0
 			uint32_t offset = (entry->offset <= 0x7fffffff) ?
 				entry->offset : (0x80000000 | nr_large_offset++);
+#else
+			/* force some offsets to the 64-bit table for testing */
+			uint32_t offset =
+				(!(entry->offset & 1) && entry->offset <= 0x7fffffff) ?
+				entry->offset : (0x80000000 | nr_large_offset++);
+#endif
 			offset = htonl(offset);
 			sha1write(f, &offset, 4);
 		}
@@ -675,7 +686,11 @@ static void write_index_file(off_t last_obj_offset)
 		while (nr_large_offset) {
 			struct object_entry *entry = *list++;
 			uint64_t offset = entry->offset;
+#if 0
 			if (offset > 0x7fffffff) {
+#else
+			if (offset & 1 || offset > 0x7fffffff) {
+#endif
 				uint32_t split[2];
 				split[0]        = htonl(offset >> 32);
 				split[1] = htonl(offset & 0xffffffff);
diff --git a/index-pack.c b/index-pack.c
index a833f64..1e6db2b 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -718,8 +718,13 @@ static const char *write_index_file(const char *index_name, unsigned char *sha1)
 		die("unable to create %s: %s", index_name, strerror(errno));
 	f = sha1fd(fd, index_name);
 
+#if 0
 	/* if last object's offset is >= 2^31 we should use index V2 */
 	index_version = (objects[nr_objects-1].offset >> 31) ? 2 : 1;
+#else
+	/* force v2 always on for testing */
+	index_version = 2;
+#endif
 
 	/* index versions 2 and above need a header */
 	if (index_version >= 2) {
@@ -779,8 +784,15 @@ static const char *write_index_file(const char *index_name, unsigned char *sha1)
 		list = sorted_by_sha;
 		for (i = 0; i < nr_objects; i++) {
 			struct object_entry *obj = *list++;
+#if 0
 			uint32_t offset = (obj->offset <= 0x7fffffff) ?
 				obj->offset : (0x80000000 | nr_large_offset++);
+#else
+			/* force some offsets to the 64-bit table for testing */
+			uint32_t offset =
+				(!(obj->offset & 1) && obj->offset <= 0x7fffffff) ?
+				obj->offset : (0x80000000 | nr_large_offset++);
+#endif
 			offset = htonl(offset);
 			sha1write(f, &offset, 4);
 		}
@@ -790,7 +802,11 @@ static const char *write_index_file(const char *index_name, unsigned char *sha1)
 		while (nr_large_offset) {
 			struct object_entry *obj = *list++;
 			uint64_t offset = obj->offset;
+#if 0
 			if (offset > 0x7fffffff) {
+#else
+			if (offset & 1 || offset > 0x7fffffff) {
+#endif
 				uint32_t split[2];
 				split[0]	= htonl(offset >> 32);
 				split[1] = htonl(offset & 0xffffffff);
