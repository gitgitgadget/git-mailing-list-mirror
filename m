From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 7/9] pack-objects: make in_pack_header_size a variable of its
 own
Date: Mon, 16 Apr 2007 12:31:31 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704161231080.4504@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 16 18:31:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdU76-00014C-Hx
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 18:31:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030869AbXDPQbd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 12:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030868AbXDPQbc
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 12:31:32 -0400
Received: from relais.videotron.ca ([24.201.245.36]:64612 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030866AbXDPQbc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 12:31:32 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JGL00HSHN8J00G0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 16 Apr 2007 12:31:31 -0400 (EDT)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44672>

It currently aliases delta_size on the principle that reused deltas won't
go through the whole delta matching loop hence delta_size was unused.
This is not true if given delta doesn't find its base in the pack though.
But we need that information even for whole object data reuse.

Well in short the current state looks awful and is prone to bugs.  It just
works fine now because try_delta() tests trg_entry->delta before using
trg_entry->delta_size, but that is a bit subtle and I was wondering for a
while why things just worked fine... even if I'm guilty of having
introduced this abomination myself in the first place.

Let's do the sensible thing instead with no ambiguity, which is to have
a separate variable for in_pack_header_size.  This might even help future
optimizations.

While at it, let's reorder some struct object_entry members so they all
align well with their own width, regardless of the architecture or the
size of off_t.  Some memory saving is to be expected with this alone.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 builtin-pack-objects.c |   26 ++++++++++++--------------
 1 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 7af1776..7100a76 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -22,28 +22,26 @@ git-pack-objects [{ -q | --progress | --all-progress }] \n\
 
 struct object_entry {
 	unsigned char sha1[20];
+	uint32_t crc32;		/* crc of raw pack data for this object */
+	off_t offset;		/* offset into the final pack file */
 	unsigned long size;	/* uncompressed size */
-	off_t offset;	/* offset into the final pack file;
-				 * nonzero if already written.
-				 */
-	unsigned int depth;	/* delta depth */
 	unsigned int hash;	/* name hint hash */
-	enum object_type type;
-	enum object_type in_pack_type;	/* could be delta */
-	unsigned long delta_size;	/* delta data size (uncompressed) */
-#define in_pack_header_size delta_size	/* only when reusing pack data */
-	struct object_entry *delta;	/* delta base object */
+	unsigned int depth;	/* delta depth */
 	struct packed_git *in_pack; 	/* already in pack */
 	off_t in_pack_offset;
+	struct object_entry *delta;	/* delta base object */
 	struct object_entry *delta_child; /* deltified objects who bases me */
 	struct object_entry *delta_sibling; /* other deltified objects who
 					     * uses the same base as me
 					     */
-	int preferred_base;	/* we do not pack this, but is encouraged to
-				 * be used as the base objectto delta huge
-				 * objects against.
-				 */
-	uint32_t crc32;		/* crc of raw pack data for this object */
+	unsigned long delta_size;	/* delta data size (uncompressed) */
+	enum object_type type;
+	enum object_type in_pack_type;	/* could be delta */
+	unsigned char in_pack_header_size;
+	unsigned char preferred_base; /* we do not pack this, but is available
+				       * to be used as the base objectto delta
+				       * objects against.
+				       */
 };
 
 /*
-- 
1.5.1.1.781.g65e8
