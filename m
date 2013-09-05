From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 31/38] sha1_file.c: make use of decode_varint()
Date: Thu, 05 Sep 2013 02:19:54 -0400
Message-ID: <1378362001-1738-32-git-send-email-nico@fluxnic.net>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 05 08:20:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHSvy-0007xc-1G
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 08:20:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757536Ab3IEGUn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 02:20:43 -0400
Received: from relais.videotron.ca ([24.201.245.36]:53284 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757386Ab3IEGUV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 02:20:21 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MSN00G402XQD3A0@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 05 Sep 2013 02:20:16 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTP id 20B2A2DA05B8	for <git@vger.kernel.org>; Thu,
 05 Sep 2013 02:20:16 -0400 (EDT)
X-Mailer: git-send-email 1.8.4.38.g317e65b
In-reply-to: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233901>

... replacing the equivalent open coded loop.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---
 sha1_file.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index a298933..67eb903 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1687,20 +1687,12 @@ static off_t get_delta_base(struct packed_git *p,
 	 * is stupid, as then a REF_DELTA would be smaller to store.
 	 */
 	if (type == OBJ_OFS_DELTA) {
-		unsigned used = 0;
-		unsigned char c = base_info[used++];
-		base_offset = c & 127;
-		while (c & 128) {
-			base_offset += 1;
-			if (!base_offset || MSB(base_offset, 7))
-				return 0;  /* overflow */
-			c = base_info[used++];
-			base_offset = (base_offset << 7) + (c & 127);
-		}
+		const unsigned char *cp = base_info;
+		base_offset = decode_varint(&cp);
 		base_offset = delta_obj_offset - base_offset;
 		if (base_offset <= 0 || base_offset >= delta_obj_offset)
 			return 0;  /* out of bound */
-		*curpos += used;
+		*curpos += cp - base_info;
 	} else if (type == OBJ_REF_DELTA) {
 		/* The base entry _must_ be in the same pack */
 		base_offset = find_pack_entry_one(base_info, p);
-- 
1.8.4.38.g317e65b
