From: Jeff King <peff@peff.net>
Subject: [PATCH 6/6] default pack.indexDuplicates to false
Date: Fri, 23 Aug 2013 20:02:45 -0400
Message-ID: <20130824000245.GF25833@sigill.intra.peff.net>
References: <20130824000111.GA20255@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 24 02:02:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VD1Jd-0002Fp-0B
	for gcvg-git-2@plane.gmane.org; Sat, 24 Aug 2013 02:02:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755245Ab3HXACt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Aug 2013 20:02:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:41511 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755203Ab3HXACs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Aug 2013 20:02:48 -0400
Received: (qmail 30138 invoked by uid 102); 24 Aug 2013 00:02:48 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 23 Aug 2013 19:02:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Aug 2013 20:02:45 -0400
Content-Disposition: inline
In-Reply-To: <20130824000111.GA20255@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232848>

We should never see duplicate objects in packs, and it is
unknown what kind of complications such packs could create
during the repacking process. The previous commit introduced
a safety valve for checking packs coming into the repository
and being indexed by index-pack.

Let's turn the safety valve on by default. This helps
protect sites receiving packfiles from potentially malicious
strangers, and shouldn't affect normal use (and if it does,
it will have helped us identify a buggy packfile writer).
In a pinch, users can recover by turning off the option, or
by resorting to unpack-objects to explode the pack.

Note that this also turns the option on for packs we write
ourselves (e.g., via pack-objects, fast-import, or streaming
large blobs). We do not expect maliciously constructed
packfiles in these code paths, of course, but it can serve
as an extra check that we have no accidentally created a
buggy pack (and the check itself is cheap to perform).

Signed-off-by: Jeff King <peff@peff.net>
Acked-by: Nicolas Pitre <nico@fluxnic.net>
---
 pack-write.c                      | 1 -
 t/t5308-pack-detect-duplicates.sh | 9 ++++-----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/pack-write.c b/pack-write.c
index da946a7..1e3c459 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -7,7 +7,6 @@ void reset_pack_idx_option(struct pack_idx_option *opts)
 	memset(opts, 0, sizeof(*opts));
 	opts->version = 2;
 	opts->off32_limit = 0x7fffffff;
-	opts->allow_duplicates = 1;
 }
 
 static int sha1_compare(const void *_a, const void *_b)
diff --git a/t/t5308-pack-detect-duplicates.sh b/t/t5308-pack-detect-duplicates.sh
index 97ce2e0..e0ba5e1 100755
--- a/t/t5308-pack-detect-duplicates.sh
+++ b/t/t5308-pack-detect-duplicates.sh
@@ -37,10 +37,10 @@ test_expect_success 'index-pack will allow duplicate objects by default' '
 	git index-pack --stdin <no-dups.pack
 '
 
-test_expect_success 'index-pack will allow duplicate objects by default' '
+test_expect_success 'index-pack will allow duplicate objects if asked' '
 	clear_packs &&
 	create_pack dups.pack 100 &&
-	git index-pack --stdin <dups.pack
+	git -c pack.indexDuplicates=true index-pack --stdin <dups.pack
 '
 
 test_expect_success 'create batch-check test vectors' '
@@ -70,11 +70,10 @@ test_expect_success 'index-pack can reject packs with duplicates' '
 	test_cmp expect actual
 '
 
-test_expect_success 'index-pack can reject packs with duplicates' '
+test_expect_success 'index-pack rejects packs with duplicates by default' '
 	clear_packs &&
 	create_pack dups.pack 2 &&
-	test_must_fail \
-		git -c pack.indexDuplicates=0 index-pack --stdin <dups.pack &&
+	test_must_fail git index-pack --stdin <dups.pack &&
 	test_expect_code 1 git cat-file -e $LO_SHA1
 '
 
-- 
1.8.4.rc2.28.g6bb5f3f
