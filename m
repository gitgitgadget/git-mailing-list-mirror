Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3521209AA
	for <e@80x24.org>; Mon, 26 Sep 2016 12:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034349AbcIZMAQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 08:00:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:48027 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965590AbcIZMAP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 08:00:15 -0400
Received: (qmail 18634 invoked by uid 109); 26 Sep 2016 12:00:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 26 Sep 2016 12:00:09 +0000
Received: (qmail 4377 invoked by uid 111); 26 Sep 2016 12:00:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 26 Sep 2016 08:00:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Sep 2016 08:00:07 -0400
Date:   Mon, 26 Sep 2016 08:00:07 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 06/10] get_short_sha1: NUL-terminate hex prefix
Message-ID: <20160926120007.eswpfrzs2ed66d2o@sigill.intra.peff.net>
References: <20160926115720.p2yb22lcq37gboon@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160926115720.p2yb22lcq37gboon@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We store the hex prefix in a 40-byte buffer with the prefix
itself followed by 40-minus-len "x" characters. These x's
serve no purpose, and the lack of NUL termination makes the
prefix string annoying to use. Let's just terminate it.

Note that this is in contrast to the binary prefix, which
_must_ be zero-padded, because we look at the whole thing
during a binary search to find the first potential match in
each pack index. The loose-object hex search cannot use the
same trick because it has to do a linear walk through the
unsorted results of readdir() (and even if it could, you'd
want zeroes instead of x's).

Signed-off-by: Jeff King <peff@peff.net>
---
 sha1_name.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 79eb1ee..549ef3f 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -14,7 +14,7 @@ typedef int (*disambiguate_hint_fn)(const unsigned char *, void *);
 
 struct disambiguate_state {
 	int len; /* length of prefix in hex chars */
-	char hex_pfx[GIT_SHA1_HEXSZ];
+	char hex_pfx[GIT_SHA1_HEXSZ + 1];
 	unsigned char bin_pfx[GIT_SHA1_RAWSZ];
 
 	disambiguate_hint_fn fn;
@@ -291,7 +291,6 @@ static int init_object_disambiguation(const char *name, int len,
 		return -1;
 
 	memset(ds, 0, sizeof(*ds));
-	memset(ds->hex_pfx, 'x', GIT_SHA1_HEXSZ);
 
 	for (i = 0; i < len ;i++) {
 		unsigned char c = name[i];
@@ -313,6 +312,7 @@ static int init_object_disambiguation(const char *name, int len,
 	}
 
 	ds->len = len;
+	ds->hex_pfx[len] = '\0';
 	prepare_alt_odb();
 	return 0;
 }
@@ -351,7 +351,7 @@ static int get_short_sha1(const char *name, int len, unsigned char *sha1,
 	status = finish_object_disambiguation(&ds, sha1);
 
 	if (!quietly && (status == SHORT_NAME_AMBIGUOUS))
-		return error("short SHA1 %.*s is ambiguous.", ds.len, ds.hex_pfx);
+		return error("short SHA1 %s is ambiguous.", ds.hex_pfx);
 	return status;
 }
 
-- 
2.10.0.492.g14f803f

