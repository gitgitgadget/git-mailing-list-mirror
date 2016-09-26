Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63331209AA
	for <e@80x24.org>; Mon, 26 Sep 2016 11:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034089AbcIZL7F (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 07:59:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:48005 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030341AbcIZL7E (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 07:59:04 -0400
Received: (qmail 18528 invoked by uid 109); 26 Sep 2016 11:59:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 26 Sep 2016 11:59:03 +0000
Received: (qmail 4299 invoked by uid 111); 26 Sep 2016 11:59:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 26 Sep 2016 07:59:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Sep 2016 07:59:01 -0400
Date:   Mon, 26 Sep 2016 07:59:01 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 01/10] get_sha1: detect buggy calls with multiple
 disambiguators
Message-ID: <20160926115901.txmbr4e6xzwyfpmo@sigill.intra.peff.net>
References: <20160926115720.p2yb22lcq37gboon@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160926115720.p2yb22lcq37gboon@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The get_sha1() family of functions takes a flags field, but
some of the flags are mutually exclusive. In particular, we
can only handle one disambiguating function, and the flags
quietly override each other. Let's instead detect these as
programming bugs.

Technically some of the flags are supersets of the others,
so treating COMMITTISH|TREEISH as just COMMITTISH is not
wrong, but it's a good sign the caller is confused. And
certainly asking for BLOB|TREE does not work.

We can do the check easily with some bit-twiddling, and as a
bonus, the bit-mask of disambiguators will come in handy in
a future patch.

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h     | 5 +++++
 sha1_name.c | 9 +++++++++
 2 files changed, 14 insertions(+)

diff --git a/cache.h b/cache.h
index d0494c8..7bd78ca 100644
--- a/cache.h
+++ b/cache.h
@@ -1203,6 +1203,11 @@ struct object_context {
 #define GET_SHA1_FOLLOW_SYMLINKS 0100
 #define GET_SHA1_ONLY_TO_DIE    04000
 
+#define GET_SHA1_DISAMBIGUATORS \
+	(GET_SHA1_COMMIT | GET_SHA1_COMMITTISH | \
+	GET_SHA1_TREE | GET_SHA1_TREEISH | \
+	GET_SHA1_BLOB)
+
 extern int get_sha1(const char *str, unsigned char *sha1);
 extern int get_sha1_commit(const char *str, unsigned char *sha1);
 extern int get_sha1_committish(const char *str, unsigned char *sha1);
diff --git a/sha1_name.c b/sha1_name.c
index faf873c..f9812ff 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -310,6 +310,11 @@ static int prepare_prefixes(const char *name, int len,
 	return 0;
 }
 
+static int multiple_bits_set(unsigned flags)
+{
+	return !!(flags & (flags - 1));
+}
+
 static int get_short_sha1(const char *name, int len, unsigned char *sha1,
 			  unsigned flags)
 {
@@ -327,6 +332,10 @@ static int get_short_sha1(const char *name, int len, unsigned char *sha1,
 	prepare_alt_odb();
 
 	memset(&ds, 0, sizeof(ds));
+
+	if (multiple_bits_set(flags & GET_SHA1_DISAMBIGUATORS))
+		die("BUG: multiple get_short_sha1 disambiguator flags");
+
 	if (flags & GET_SHA1_COMMIT)
 		ds.fn = disambiguate_commit_only;
 	else if (flags & GET_SHA1_COMMITTISH)
-- 
2.10.0.492.g14f803f

