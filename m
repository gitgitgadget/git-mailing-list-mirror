From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 05/17] Don't expect verify_pack() callers to set pack_size
Date: Sat, 30 May 2009 01:58:58 +0800
Message-ID: <20090530015858.a629892f.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 29 20:02:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MA6P3-0000Xl-Nr
	for gcvg-git-2@gmane.org; Fri, 29 May 2009 20:02:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758309AbZE2SAw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2009 14:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758210AbZE2SAv
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 14:00:51 -0400
Received: from mail-px0-f123.google.com ([209.85.216.123]:53739 "EHLO
	mail-px0-f123.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757889AbZE2SAu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2009 14:00:50 -0400
Received: by mail-px0-f123.google.com with SMTP id 29so1678194pxi.33
        for <git@vger.kernel.org>; Fri, 29 May 2009 11:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=CZh4SGuWw4uQ+UJwTwmD+BGt4uHC4HwYlxQLEKhQriY=;
        b=AdV0NWQXO6uA4zzySWgyOYaSMpXSlY9fx8RjK9h7qQBkX0kB7NjkHb9M5+H4UZBikA
         i9rSmVLcBLND7td47NbgOmk3oR29vOXxV5nWTXRaeNVLWRgJvmddsNkmYoteA6Orzhau
         /4qJ7YsVKB+imRwuHLmO0rAbvt6vS26/uZqxw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=g0eTcHZ1ZSatDI78Cm6iugi8u3Sq+LOkFxnik75FyLX8dFFj8RhCFcIceJ16shuwb2
         KDzO442BA0xKKw9PbRDfUqfmJBNvN55axFawFFI+CbUMUjAkSdYdrQllOEudDOLCwX+h
         HfqKNv1HMpPehFosrRU7XpKy/8ykkBz9q5M0A=
Received: by 10.115.107.1 with SMTP id j1mr4465632wam.62.1243620052775;
        Fri, 29 May 2009 11:00:52 -0700 (PDT)
Received: from your-cukc5e3z5n (cm189.zeta148.maxonline.com.sg [116.87.148.189])
        by mx.google.com with ESMTPS id m28sm2532682waf.37.2009.05.29.11.00.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 29 May 2009 11:00:52 -0700 (PDT)
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120294>

From:	Mike Hommey <mh@glandium.org>
Date:	Sun, 18 Jan 2009 09:04:26 +0100

Since use_pack() will end up populating pack_size if it is not already set,
we can just adapt the code in verify_packfile() such that it doesn't require
pack_size to be set beforehand.

This allows callers not to have to set pack_size themselves, and we can thus
revert changes from 1c23d794 (Don't die in git-http-fetch when fetching packs).

Signed-off-by: Mike Hommey <mh@glandium.org>
Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 pack-check.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/pack-check.c b/pack-check.c
index 90c33b1..166ca70 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -49,7 +49,7 @@ static int verify_packfile(struct packed_git *p,
 	const unsigned char *index_base = p->index_data;
 	git_SHA_CTX ctx;
 	unsigned char sha1[20], *pack_sig;
-	off_t offset = 0, pack_sig_ofs = p->pack_size - 20;
+	off_t offset = 0, pack_sig_ofs = 0;
 	uint32_t nr_objects, i;
 	int err = 0;
 	struct idx_entry *entries;
@@ -61,14 +61,16 @@ static int verify_packfile(struct packed_git *p,
 	 */

 	git_SHA1_Init(&ctx);
-	while (offset < pack_sig_ofs) {
+	do {
 		unsigned int remaining;
 		unsigned char *in = use_pack(p, w_curs, offset, &remaining);
 		offset += remaining;
+		if (!pack_sig_ofs)
+			pack_sig_ofs = p->pack_size - 20;
 		if (offset > pack_sig_ofs)
 			remaining -= (unsigned int)(offset - pack_sig_ofs);
 		git_SHA1_Update(&ctx, in, remaining);
-	}
+	} while (offset < pack_sig_ofs);
 	git_SHA1_Final(sha1, &ctx);
 	pack_sig = use_pack(p, w_curs, pack_sig_ofs, NULL);
 	if (hashcmp(sha1, pack_sig))
--
1.6.3.1
