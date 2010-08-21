From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH] fix >4GiB source delta assertion failure
Date: Sat, 21 Aug 2010 01:00:13 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1008202349500.622@xanadu.home>
References: <20100721231635.GA6387@LK-Perkele-V2.elisa-laajakaista.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 21 07:00:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmgC4-0002wm-3h
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 07:00:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099Ab0HUFAP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Aug 2010 01:00:15 -0400
Received: from relais.videotron.ca ([24.201.245.36]:12243 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777Ab0HUFAO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Aug 2010 01:00:14 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0L7H001JRKKD33E0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 21 Aug 2010 01:00:13 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20100721231635.GA6387@LK-Perkele-V2.elisa-laajakaista.fi>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154110>

When people try insane things such as delta-compressing 4GiB files, they
get this assertion:

diff-delta.c:285: create_delta_index: Assertion `packed_entry - (struct index_entry *)mem == entries' failed.

This happens because:

1) the 'entries' variable is an unsigned int

2) it is assigned with entries = (bufsize - 1) / RABIN_WINDOW
   (that itself is not a problem unless bufsize > 4G * RABIN_WINDOW)

3) the buffer is indexed from top to bottom starting at
   "data = buffer + entries * RABIN_WINDOW" and the multiplication
   here does indeed overflows, making the resulting top of the buffer 
   much lower than expected.

This makes the number of actually produced index entries smaller than 
what was computed initially, hence the assertion.

Furthermore, the current delta encoding format cannot represent offsets
into a reference buffer with more than 32 bits anyway.  So let's just 
limit the number of entries to what the delta format can encode.

Reported-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---
diff --git a/diff-delta.c b/diff-delta.c
index 464ac3f..73acf8a 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -146,7 +146,14 @@ struct delta_index * create_delta_index(const void *buf, unsigned long bufsize)
 	/* Determine index hash size.  Note that indexing skips the
 	   first byte to allow for optimizing the Rabin's polynomial
 	   initialization in create_delta(). */
-	entries = (bufsize - 1)  / RABIN_WINDOW;
+	entries = (bufsize - 1) / RABIN_WINDOW;
+	if (bufsize >= 0xffffffffUL) {
+		/* 
+		 * Current delta format can't encode offsets into
+		 * reference buffer with more than 32 bits.
+		 */
+		entries = 0xfffffffeU / RABIN_WINDOW;
+	}
 	hsize = entries / 4;
 	for (i = 4; (1u << i) < hsize && i < 31; i++);
 	hsize = 1 << i;
