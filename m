From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 06/10] pack-objects: learn about pack index version 2
Date: Mon, 09 Apr 2007 10:54:57 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704091051430.28181@xanadu.home>
References: <11760951973172-git-send-email-nico@cam.org>
 <11760951973319-git-send-email-nico@cam.org>
 <11760951993458-git-send-email-nico@cam.org>
 <11760951993225-git-send-email-nico@cam.org>
 <11760951993409-git-send-email-nico@cam.org>
 <11760952002687-git-send-email-nico@cam.org>
 <11760952002410-git-send-email-nico@cam.org>
 <7vabxi6rkv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 09 17:06:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HavKH-0005JD-Js
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 16:58:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933827AbXDIO4d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Apr 2007 10:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933795AbXDIOzH
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 10:55:07 -0400
Received: from relais.videotron.ca ([24.201.245.36]:33347 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933782AbXDIOzA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2007 10:55:00 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JG8003EJK3NWF60@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 09 Apr 2007 10:55:00 -0400 (EDT)
In-reply-to: <7vabxi6rkv.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44053>

On Sun, 8 Apr 2007, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > Support for large packs exceeding 31 bits in size won't impose an index
> > size bloat for packs within that range that don't need a 64-bit offset.
> > And because newer objects which are likely to be the most frequently used
> > are located at the beginning of the pack, they won't pay the 64-bit offset
> > lookup at run time either even if the pack is large.
> >
> > Right now an index version 2 is created only when the biggest offset in a
> > pack reaches 31 bits.  It might be a good idea to always use index version
> > 2 eventually to benefit from the CRC32 it contains when reusing pack data
> > while repacking.
> > ...
> > @@ -582,6 +602,18 @@ static void write_index_file(void)
> >  	struct object_entry **list = sorted_by_sha;
> >  	struct object_entry **last = list + nr_result;
> >  	uint32_t array[256];
> > +	uint32_t index_version;
> > +
> > +	/* if last object's offset is >= 2^31 we should use index V2 */
> > +	index_version = (objects[nr_result-1].offset >> 31) ? 2 : 1;
> 
> Although write_pack_file() iterates objects[] array in the
> ascending order of index and calls write_one() for each of them,
> in the presense of "we write base object before delta" rule, is
> it always true that the last object in the objects[] array has
> the largest offset?

Oops, indeed it is not.  It is true in the index-pack but not here.

Please could you amend this patch with the following:

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index c7e0a42..8cf2871 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -548,11 +548,11 @@ static off_t write_one(struct sha1file *f,
 	return offset + size;
 }
 
-static void write_pack_file(void)
+static off_t write_pack_file(void)
 {
 	uint32_t i;
 	struct sha1file *f;
-	off_t offset;
+	off_t offset, last_obj_offset = 0;
 	struct pack_header hdr;
 	unsigned last_percent = 999;
 	int do_progress = progress;
@@ -575,6 +575,7 @@ static void write_pack_file(void)
 	if (!nr_result)
 		goto done;
 	for (i = 0; i < nr_objects; i++) {
+		last_obj_offset = offset;
 		offset = write_one(f, objects + i, offset);
 		if (do_progress) {
 			unsigned percent = written * 100 / nr_result;
@@ -592,9 +593,11 @@ static void write_pack_file(void)
 	if (written != nr_result)
 		die("wrote %u objects while expecting %u", written, nr_result);
 	sha1close(f, pack_file_sha1, 1);
+
+	return last_obj_offset;
 }
 
-static void write_index_file(void)
+static void write_index_file(off_t last_obj_offset)
 {
 	uint32_t i;
 	struct sha1file *f = sha1create("%s-%s.%s", base_name,
@@ -605,7 +608,7 @@ static void write_index_file(void)
 	uint32_t index_version;
 
 	/* if last object's offset is >= 2^31 we should use index V2 */
-	index_version = (objects[nr_result-1].offset >> 31) ? 2 : 1;
+	index_version = (last_obj_offset >> 31) ? 2 : 1;
 
 	/* index versions 2 and above need a header */
 	if (index_version >= 2) {
@@ -1769,6 +1772,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (reuse_cached_pack(object_list_sha1))
 		;
 	else {
+		off_t last_obj_offset;
 		if (nr_result)
 			prepare_pack(window, depth);
 		if (progress == 1 && pack_to_stdout) {
@@ -1778,9 +1782,9 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			signal(SIGALRM, SIG_IGN );
 			progress_update = 0;
 		}
-		write_pack_file();
+		last_obj_offset = write_pack_file();
 		if (!pack_to_stdout) {
-			write_index_file();
+			write_index_file(last_obj_offset);
 			puts(sha1_to_hex(object_list_sha1));
 		}
 	}

Nicolas
