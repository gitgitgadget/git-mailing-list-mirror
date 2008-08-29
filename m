From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 3/5] pack-objects: use fixup_pack_header_footer()'s validation
 mode
Date: Fri, 29 Aug 2008 16:08:00 -0400
Message-ID: <1220040482-10108-4-git-send-email-nico@cam.org>
References: <20080829143023.GA7403@spearce.org>
 <1220040482-10108-1-git-send-email-nico@cam.org>
 <1220040482-10108-2-git-send-email-nico@cam.org>
 <1220040482-10108-3-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 22:09:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZAHi-0006S2-AC
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 22:09:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752095AbYH2UIZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 16:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752093AbYH2UIZ
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 16:08:25 -0400
Received: from relais.videotron.ca ([24.201.245.36]:15047 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751869AbYH2UIY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 16:08:24 -0400
Received: from localhost.localdomain ([66.131.194.97])
 by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K6D007OOP8J18A0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 29 Aug 2008 16:07:32 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.1.212.g35f9f
In-reply-to: <1220040482-10108-3-git-send-email-nico@cam.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94324>

When limiting the pack size, a new header has to be written to the
pack and a new SHA1 computed.  Make sure that the SHA1 of what is being
read back matches the SHA1 of what was written.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 builtin-pack-objects.c |    4 ++--
 csum-file.c            |    6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 79417cb..ba2cf00 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -492,9 +492,9 @@ static void write_pack_file(void)
 		} else if (nr_written == nr_remaining) {
 			sha1close(f, sha1, CSUM_FSYNC);
 		} else {
-			int fd = sha1close(f, NULL, 0);
+			int fd = sha1close(f, sha1, 0);
 			fixup_pack_header_footer(fd, sha1, pack_tmp_name,
-						 nr_written, NULL, 0);
+						 nr_written, sha1, offset);
 			close(fd);
 		}
 
diff --git a/csum-file.c b/csum-file.c
index ace64f1..2838954 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -42,11 +42,11 @@ int sha1close(struct sha1file *f, unsigned char *result, unsigned int flags)
 		sha1flush(f, offset);
 		f->offset = 0;
 	}
+	SHA1_Final(f->buffer, &f->ctx);
+	if (result)
+		hashcpy(result, f->buffer);
 	if (flags & (CSUM_CLOSE | CSUM_FSYNC)) {
 		/* write checksum and close fd */
-		SHA1_Final(f->buffer, &f->ctx);
-		if (result)
-			hashcpy(result, f->buffer);
 		sha1flush(f, 20);
 		if (flags & CSUM_FSYNC)
 			fsync_or_die(f->fd, f->name);
-- 
1.6.0.1.212.g35f9f
