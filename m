From: Jeff King <peff@peff.net>
Subject: [PATCH] replace sha1 with another algorithm
Date: Tue, 25 Oct 2011 17:12:37 -0700
Message-ID: <20111026001237.GA22195@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 26 02:12:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIr6w-0004hO-I2
	for gcvg-git-2@lo.gmane.org; Wed, 26 Oct 2011 02:12:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753994Ab1JZAMq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Oct 2011 20:12:46 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56104
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752168Ab1JZAMp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2011 20:12:45 -0400
Received: (qmail 18906 invoked by uid 107); 26 Oct 2011 00:18:32 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (216.239.45.18)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 25 Oct 2011 20:18:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Oct 2011 17:12:37 -0700
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184243>

SHA-1 is due to be cryptographically broken sometime in the
next decade, with collision attacks becoming possible. But
we don't have to wait! We can act now and replace it,
treating us to all of the pain of a flag day without any
delay!

We could of course use the SHA-2 family, or wait for the
upcoming SHA-3. But any good cryptographer knows that you
should _never_ use a standard algorithm. It's always better
to roll your own. After all, if _you_ can't break it, how
could anyone else?

Signed-off-by: Jeff King <peff@peff.net>
Reviewed-by: Brandon Casey <drafnel@gmail.com>
Mocked-by: Rick Balocca <richard.balocca@ericsson.com>
Enjoyed-by: Elijah Newren <newren@gmail.com>
---
 block-sha1/sha1.h |    2 +-
 cache.h           |    4 +++-
 sha1_file.c       |   32 ++++++++++++++++++++++++++++++++
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/block-sha1/sha1.h b/block-sha1/sha1.h
index b864df6..49331e3 100644
--- a/block-sha1/sha1.h
+++ b/block-sha1/sha1.h
@@ -19,4 +19,4 @@
 #define git_SHA_CTX	blk_SHA_CTX
 #define git_SHA1_Init	blk_SHA1_Init
 #define git_SHA1_Update	blk_SHA1_Update
-#define git_SHA1_Final	blk_SHA1_Final
+#define real_git_SHA1_Final	blk_SHA1_Final
diff --git a/cache.h b/cache.h
index 2e6ad36..068062b 100644
--- a/cache.h
+++ b/cache.h
@@ -13,9 +13,11 @@
 #define git_SHA_CTX	SHA_CTX
 #define git_SHA1_Init	SHA1_Init
 #define git_SHA1_Update	SHA1_Update
-#define git_SHA1_Final	SHA1_Final
+#define real_git_SHA1_Final	SHA1_Final
 #endif
 
+void git_SHA1_Final(unsigned char out[20], git_SHA_CTX *ctx);
+
 #include <zlib.h>
 typedef struct git_zstream {
 	z_stream z;
diff --git a/sha1_file.c b/sha1_file.c
index 27f3b9b..23e0107 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2833,3 +2833,35 @@ void assert_sha1_type(const unsigned char *sha1, enum object_type expect)
 		die("%s is not a valid '%s' object", sha1_to_hex(sha1),
 		    typename(expect));
 }
+
+static void xor_bytes(unsigned char *out, unsigned char *a, unsigned char *b,
+		      unsigned n)
+{
+	unsigned i;
+	for (i = 0; i < n; i++)
+		out[i] = a[i] ^ b[i];
+}
+
+static void mix_hash(unsigned char *h, unsigned n)
+{
+	unsigned char out[20];
+	unsigned mid = n / 2;
+
+	if (2*mid < n)
+		return;
+
+	xor_bytes(out, h, h + mid, mid);
+	xor_bytes(out + mid, h + mid, h, mid);
+	memcpy(h, out, n);
+
+	/* If a little bit of mixing is good, then a lot must be GREAT! */
+	mix_hash(h, mid);
+	mix_hash(h + mid, mid);
+}
+
+void git_SHA1_Final(unsigned char out[20], git_SHA_CTX *ctx)
+{
+	/* We build on top of the regular SHA1, but then "enhance" it. */
+	real_git_SHA1_Final(out, ctx);
+	mix_hash(out, 20);
+}
-- 
1.7.7.troll
