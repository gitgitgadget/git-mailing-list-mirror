From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 11/23] Don't expect verify_pack() callers to set pack_size
Date: Sat, 6 Jun 2009 00:04:50 +0800
Message-ID: <20090606000450.244c3b5e.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 05 18:09:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCbzG-00053w-1N
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 18:09:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755538AbZFEQIv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 12:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755335AbZFEQIu
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 12:08:50 -0400
Received: from rv-out-0506.google.com ([209.85.198.239]:59733 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751162AbZFEQIt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 12:08:49 -0400
Received: by rv-out-0506.google.com with SMTP id f9so689116rvb.1
        for <git@vger.kernel.org>; Fri, 05 Jun 2009 09:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=CZh4SGuWw4uQ+UJwTwmD+BGt4uHC4HwYlxQLEKhQriY=;
        b=lCGIYvm5axAX3MjS48+85OV9kAo2IGAuE8+t3QLh1BMRrwz9+q0ocLQ7d52nd6EPKL
         uVtQ21FLsp71rjYHMHJNcs+3qmThwOJO6RRlBwylYGvmDQh63Cwsm2CNo5oMrXE6pbJc
         ivtPKQnaF1TWpilzmFY6HB+wTk9hcNcYocPX0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=ZYnARgHUa2q+I5q+RCSXn/tTsj/unSdgSLQyFnsWhPvEHdMa+3tAp1Sit8Xf2XU3wC
         7t9QknqAVpxDOUfWk6H8S3K3+ywtymim5OwgO7cPzMO6Q16tNfB++rOURjheE/8BpL3E
         Xkb88hbD6LU+KqZggM+Ihx/KLJjHIi53xmWPE=
Received: by 10.143.165.9 with SMTP id s9mr1475535wfo.54.1244218130730;
        Fri, 05 Jun 2009 09:08:50 -0700 (PDT)
Received: from your-cukc5e3z5n (cm97.zeta149.maxonline.com.sg [116.87.149.97])
        by mx.google.com with ESMTPS id 22sm421513wfi.12.2009.06.05.09.08.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Jun 2009 09:08:50 -0700 (PDT)
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120792>

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
