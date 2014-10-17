From: Jeff King <peff@peff.net>
Subject: [PATCH] pack-objects: turn off bitmaps when we split packs
Date: Thu, 16 Oct 2014 21:11:43 -0400
Message-ID: <20141017011142.GA10462@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Vicent Marti <vicent@github.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 17 03:11:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xew5D-00015a-Rq
	for gcvg-git-2@plane.gmane.org; Fri, 17 Oct 2014 03:11:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751638AbaJQBLq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2014 21:11:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:59503 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751322AbaJQBLp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2014 21:11:45 -0400
Received: (qmail 6308 invoked by uid 102); 17 Oct 2014 01:11:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Oct 2014 20:11:45 -0500
Received: (qmail 4490 invoked by uid 107); 17 Oct 2014 01:11:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Oct 2014 21:11:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Oct 2014 21:11:43 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a pack.packSizeLimit is set, we may split the pack data
across multiple packfiles. This means we cannot generate
.bitmap files, as they require that all of the reachable
objects are in the same pack. We check that condition when
we are generating the list of objects to pack (and disable
bitmaps if we are not packing everything), but we forgot to
update it when we notice that we needed to split (which
doesn't happen until the actual write phase).

The resulting bitmaps are quite bogus (they mention entries
that do not exist in the pack!) and can cause a fetch or
push to send insufficient objects.

Signed-off-by: Jeff King <peff@peff.net>
---
You should generally avoid splitting packs anyway, as it introduces
other inefficiencies, so I'm not really concerned about making bitmaps
work here (besides which, it would require a big change to the on-disk
format). The important thing here is avoiding creating the broken
bitmaps.

 builtin/pack-objects.c  | 1 +
 t/t5310-pack-bitmaps.sh | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index d391934..a4022a7 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -811,6 +811,7 @@ static void write_pack_file(void)
 			fixup_pack_header_footer(fd, sha1, pack_tmp_name,
 						 nr_written, sha1, offset);
 			close(fd);
+			write_bitmap_index = 0;
 		}
 
 		if (!pack_to_stdout) {
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 0580258..6003490 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -170,4 +170,13 @@ test_expect_success JGIT 'jgit can read our bitmaps' '
 	)
 '
 
+test_expect_success 'splitting packs does not generate bogus bitmaps' '
+	test-genrandom foo $((1024 * 1024)) >rand &&
+	git add rand &&
+	git commit -m "commit with big file" &&
+	git -c pack.packSizeLimit=500k repack -adb &&
+	git init --bare no-bitmaps.git &&
+	git -C no-bitmaps.git fetch .. HEAD
+'
+
 test_done
-- 
2.1.2.596.g7379948
