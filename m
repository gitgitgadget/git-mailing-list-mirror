From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 06/18] Don't expect verify_pack() callers to set pack_size
Date: Sun, 24 May 2009 22:19:47 +0800
Message-ID: <20090524221947.c83d6aba.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 24 16:22:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8Eam-0005ol-UJ
	for gcvg-git-2@gmane.org; Sun, 24 May 2009 16:22:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753751AbZEXOVu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 May 2009 10:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753724AbZEXOVu
	(ORCPT <rfc822;git-outgoing>); Sun, 24 May 2009 10:21:50 -0400
Received: from mail-pz0-f177.google.com ([209.85.222.177]:55668 "EHLO
	mail-pz0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753630AbZEXOVt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 May 2009 10:21:49 -0400
Received: by mail-pz0-f177.google.com with SMTP id 7so2113664pzk.33
        for <git@vger.kernel.org>; Sun, 24 May 2009 07:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=7W9DzXhXpGLd6bn8OWebxiJF5bPvk2qM3tFcQH+vk3s=;
        b=PEhVEZAyB4FSWfShlRo4gZanKrturjkns5VgEAVx/7T+h03DJPDfjk8Onvv7h/Jit2
         9+7Ppid2JcGb868C4spFqNseHyvMTwLYvmWBwWDtjn+AX0Yvp6m5D63X1cLZXKPwb6x4
         TNew0adW3oYPxTvwKME/4+5b3Ev8+aQx1mWOQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=Ewv58OJpOtazlwzYw9vTLi0ErQ3H3jTptX6z+jpGG0G1B3Gwj0XtwHOrqsPSQKf0qQ
         lOasDY7McnVrFli5CyyrzNX10y20qWUBy5C94OJjavEIeAWHpii0lrrx7sL3SRrgBRBM
         6hXlbyI1DzQy6k5rSfqpaLKQwx0KJKVKVShO4=
Received: by 10.115.92.2 with SMTP id u2mr12291896wal.228.1243174910003;
        Sun, 24 May 2009 07:21:50 -0700 (PDT)
Received: from your-cukc5e3z5n (cm10.zeta148.maxonline.com.sg [116.87.148.10])
        by mx.google.com with ESMTPS id f20sm12308577waf.17.2009.05.24.07.21.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 May 2009 07:21:49 -0700 (PDT)
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119829>

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
