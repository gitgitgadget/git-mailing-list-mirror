From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] use_pack: handle signed off_t overflow
Date: Thu, 25 Feb 2016 09:23:26 -0500
Message-ID: <20160225142326.GC17811@sigill.intra.peff.net>
References: <20160225142004.GA17678@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jacek Wielemborek <d33tah@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 25 15:23:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYwpJ-00049x-5e
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 15:23:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760358AbcBYOX3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 09:23:29 -0500
Received: from cloud.peff.net ([50.56.180.127]:49134 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759878AbcBYOX3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 09:23:29 -0500
Received: (qmail 6665 invoked by uid 102); 25 Feb 2016 14:23:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 25 Feb 2016 09:23:28 -0500
Received: (qmail 21426 invoked by uid 107); 25 Feb 2016 14:23:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 25 Feb 2016 09:23:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Feb 2016 09:23:26 -0500
Content-Disposition: inline
In-Reply-To: <20160225142004.GA17678@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287393>

A v2 pack index file can specify an offset within a packfile
of up to 2^64-1 bytes. On a system with a signed 64-bit
off_t, we can represent only up to 2^63-1. This means that a
corrupted .idx file can end up with a negative offset in the
pack code. Our bounds-checking use_pack function looks for
too-large offsets, but not for ones that have wrapped around
to negative. Let's do so, which fixes an out-of-bounds
access demonstrated in t5313.

Signed-off-by: Jeff King <peff@peff.net>
---
 sha1_file.c                   | 2 ++
 t/t5313-pack-bounds-checks.sh | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/sha1_file.c b/sha1_file.c
index d2ffd92..9d223e6 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1076,6 +1076,8 @@ unsigned char *use_pack(struct packed_git *p,
 		die("packfile %s cannot be accessed", p->pack_name);
 	if (offset > (p->pack_size - 20))
 		die("offset beyond end of packfile (truncated pack?)");
+	if (offset < 0)
+		die("offset before end of packfile (broken .idx?)");
 
 	if (!win || !in_window(win, offset)) {
 		if (win)
diff --git a/t/t5313-pack-bounds-checks.sh b/t/t5313-pack-bounds-checks.sh
index 0717746..a8a587a 100755
--- a/t/t5313-pack-bounds-checks.sh
+++ b/t/t5313-pack-bounds-checks.sh
@@ -136,7 +136,7 @@ test_expect_success 'bogus offset into v2 extended table' '
 	test_must_fail git index-pack --verify $pack
 '
 
-test_expect_failure 'bogus offset inside v2 extended table' '
+test_expect_success 'bogus offset inside v2 extended table' '
 	# We need two objects here, so we can plausibly require
 	# an extended table (if the first object were larger than 2^31).
 	do_pack "$object $(git rev-parse HEAD)" --index-version=2 &&
-- 
2.7.2.695.gf3fde8e
