From: Nicolas Pitre <nico@cam.org>
Subject: Re: How to replace a single corrupt, packed object?
Date: Sun, 10 Aug 2008 22:55:22 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0808102146050.22892@xanadu.home>
References: <alpine.DEB.1.00.0808081639490.24820@pacific.mpi-cbg.de.mpi-cbg.de>
 <0BF03F86-8E4E-46D2-9B04-4385CEBD6902@ai.rug.nl>
 <20080808161937.GC9152@spearce.org>
 <90E12BC7-1950-41DF-8BE5-C6B63CE060D9@ai.rug.nl>
 <alpine.DEB.1.00.0808081841290.24820@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Pieter de Bie <pdebie@ai.rug.nl>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 11 04:56:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSNaD-0000OH-N5
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 04:56:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753824AbYHKCz2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 22:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753807AbYHKCz2
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 22:55:28 -0400
Received: from relais.videotron.ca ([24.201.245.36]:9794 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753429AbYHKCz1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 22:55:27 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K5F006OC1GARPF0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 10 Aug 2008 22:55:23 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.DEB.1.00.0808081841290.24820@pacific.mpi-cbg.de.mpi-cbg.de>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91912>

On Fri, 8 Aug 2008, Johannes Schindelin wrote:

> In any case, the pack is too large for me to let my computer repack 
> everything, when only one object needs repacking.

By that you mean you cannot/don't want to use repack -f, right?

There _could_ be a way to hack pack-objects so not to reuse bad objects.  
However I don't want that to impact the code too much for an 
event that hopefully should almost never happens, especially if using -f 
does work around it already.

Well, let's see.

[...]

OK, here's what the patch to allow repacking without -f and still using 
redundant objects in presence of pack corruption might look like.  
Please tell me if that works for you.

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 2dadec1..88e73f3 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -277,6 +277,7 @@ static unsigned long write_object(struct sha1file *f,
 				 */
 
 	if (!to_reuse) {
+		no_reuse:
 		if (!usable_delta) {
 			buf = read_sha1_file(entry->idx.sha1, &type, &size);
 			if (!buf)
@@ -364,14 +365,28 @@ static unsigned long write_object(struct sha1file *f,
 			reused_delta++;
 		}
 		hdrlen = encode_header(type, entry->size, header);
+
 		offset = entry->in_pack_offset;
 		revidx = find_pack_revindex(p, offset);
 		datalen = revidx[1].offset - offset;
 		if (!pack_to_stdout && p->index_version > 1 &&
-		    check_pack_crc(p, &w_curs, offset, datalen, revidx->nr))
-			die("bad packed object CRC for %s", sha1_to_hex(entry->idx.sha1));
+		    check_pack_crc(p, &w_curs, offset, datalen, revidx->nr)) {
+			error("bad packed object CRC for %s", sha1_to_hex(entry->idx.sha1));
+			if (entry->delta)
+				reused_delta--;
+			goto no_reuse;
+		}
+
 		offset += entry->in_pack_header_size;
 		datalen -= entry->in_pack_header_size;
+		if (!pack_to_stdout && p->index_version == 1 &&
+		    check_pack_inflate(p, &w_curs, offset, datalen, entry->size)) {
+			die("corrupt packed object for %s", sha1_to_hex(entry->idx.sha1));
+			if (entry->delta)
+				reused_delta--;
+			goto no_reuse;
+		}
+
 		if (type == OBJ_OFS_DELTA) {
 			off_t ofs = entry->idx.offset - entry->delta->idx.offset;
 			unsigned pos = sizeof(dheader) - 1;
@@ -394,10 +409,6 @@ static unsigned long write_object(struct sha1file *f,
 				return 0;
 			sha1write(f, header, hdrlen);
 		}
-
-		if (!pack_to_stdout && p->index_version == 1 &&
-		    check_pack_inflate(p, &w_curs, offset, datalen, entry->size))
-			die("corrupt packed object for %s", sha1_to_hex(entry->idx.sha1));
 		copy_pack_data(f, p, &w_curs, offset, datalen);
 		unuse_pack(&w_curs);
 		reused++;


Nicolas
