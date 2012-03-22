From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] make is_empty_blob_sha1 available everywhere
Date: Thu, 22 Mar 2012 14:53:39 -0400
Message-ID: <20120322185339.GB32727@sigill.intra.peff.net>
References: <20120322185246.GA27037@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Ralf Nyren <ralf.nyren@ericsson.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 22 19:53:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAn8u-0008Qc-PC
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 19:53:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759188Ab2CVSxn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 14:53:43 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56834
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759140Ab2CVSxm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 14:53:42 -0400
Received: (qmail 3894 invoked by uid 107); 22 Mar 2012 18:53:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 22 Mar 2012 14:53:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Mar 2012 14:53:39 -0400
Content-Disposition: inline
In-Reply-To: <20120322185246.GA27037@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193685>

The read-cache implementation defines this static function,
but it is a generally useful concept in git. Let's give
the empty blob the same treatment as the empty tree,
providing both hex and binary forms of the sha1.

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h      |   13 +++++++++++++
 read-cache.c |   10 ----------
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/cache.h b/cache.h
index e5e1aa4..5280574 100644
--- a/cache.h
+++ b/cache.h
@@ -708,6 +708,19 @@ static inline void hashclr(unsigned char *hash)
 #define EMPTY_TREE_SHA1_BIN \
 	 ((const unsigned char *) EMPTY_TREE_SHA1_BIN_LITERAL)
 
+#define EMPTY_BLOB_SHA1_HEX \
+	"e69de29bb2d1d6434b8b29ae775ad8c2e48c5391"
+#define EMPTY_BLOB_SHA1_BIN_LITERAL \
+	"\xe6\x9d\xe2\x9b\xb2\xd1\xd6\x43\x4b\x8b" \
+	"\x29\xae\x77\x5a\xd8\xc2\xe4\x8c\x53\x91"
+#define EMPTY_BLOB_SHA1_BIN \
+	((const unsigned char *) EMPTY_BLOB_SHA1_BIN_LITERAL)
+
+static inline int is_empty_blob_sha1(const unsigned char *sha1)
+{
+	return !hashcmp(sha1, EMPTY_BLOB_SHA1_BIN);
+}
+
 int git_mkstemp(char *path, size_t n, const char *template);
 
 int git_mkstemps(char *path, size_t n, const char *template, int suffix_len);
diff --git a/read-cache.c b/read-cache.c
index 274e54b..6c8f395 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -157,16 +157,6 @@ static int ce_modified_check_fs(struct cache_entry *ce, struct stat *st)
 	return 0;
 }
 
-static int is_empty_blob_sha1(const unsigned char *sha1)
-{
-	static const unsigned char empty_blob_sha1[20] = {
-		0xe6,0x9d,0xe2,0x9b,0xb2,0xd1,0xd6,0x43,0x4b,0x8b,
-		0x29,0xae,0x77,0x5a,0xd8,0xc2,0xe4,0x8c,0x53,0x91
-	};
-
-	return !hashcmp(sha1, empty_blob_sha1);
-}
-
 static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
 {
 	unsigned int changed = 0;
-- 
1.7.10.rc0.9.gdcbe9
