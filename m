From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 5/5] fixup_pack_header_footer(): use nicely aligned buffer sizes
Date: Fri, 29 Aug 2008 16:08:02 -0400
Message-ID: <1220040482-10108-6-git-send-email-nico@cam.org>
References: <20080829143023.GA7403@spearce.org>
 <1220040482-10108-1-git-send-email-nico@cam.org>
 <1220040482-10108-2-git-send-email-nico@cam.org>
 <1220040482-10108-3-git-send-email-nico@cam.org>
 <1220040482-10108-4-git-send-email-nico@cam.org>
 <1220040482-10108-5-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 22:09:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZAHz-0006Wv-7f
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 22:09:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752409AbYH2UIe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 16:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752216AbYH2UIe
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 16:08:34 -0400
Received: from relais.videotron.ca ([24.201.245.36]:15047 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752317AbYH2UIc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 16:08:32 -0400
Received: from localhost.localdomain ([66.131.194.97])
 by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K6D007OOP8J18A0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 29 Aug 2008 16:07:33 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.1.212.g35f9f
In-reply-to: <1220040482-10108-5-git-send-email-nico@cam.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94326>

It should be more efficient to use nicely aligned buffer sizes, either
for filesystem operations or SHA1 checksums.  Also, using a relatively
small nominal size might allow for the data to remain in L1 cache
between both SHA1_Update() calls.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 pack-write.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/pack-write.c b/pack-write.c
index f9776c5..939ed56 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -167,7 +167,7 @@ void fixup_pack_header_footer(int pack_fd,
 			 unsigned char *partial_pack_sha1,
 			 off_t partial_pack_offset)
 {
-	static const int buf_sz = 128 * 1024;
+	int aligned_sz, buf_sz = 8 * 1024;
 	SHA_CTX old_sha1_ctx, new_sha1_ctx;
 	struct pack_header hdr;
 	char *buf;
@@ -188,10 +188,11 @@ void fixup_pack_header_footer(int pack_fd,
 	partial_pack_offset -= sizeof(hdr);
 
 	buf = xmalloc(buf_sz);
+	aligned_sz = buf_sz - sizeof(hdr);
 	for (;;) {
 		ssize_t m, n;
-		m = (partial_pack_sha1 && partial_pack_offset < buf_sz) ?
-			partial_pack_offset : buf_sz;
+		m = (partial_pack_sha1 && partial_pack_offset < aligned_sz) ?
+			partial_pack_offset : aligned_sz;
 		n = xread(pack_fd, buf, m);
 		if (!n)
 			break;
@@ -199,6 +200,10 @@ void fixup_pack_header_footer(int pack_fd,
 			die("Failed to checksum %s: %s", pack_name, strerror(errno));
 		SHA1_Update(&new_sha1_ctx, buf, n);
 
+		aligned_sz -= n;
+		if (!aligned_sz)
+			aligned_sz = buf_sz;
+
 		if (!partial_pack_sha1)
 			continue;
 
-- 
1.6.0.1.212.g35f9f
