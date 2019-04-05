Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D83120248
	for <e@80x24.org>; Fri,  5 Apr 2019 18:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731457AbfDESM5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 14:12:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:48718 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728683AbfDESM5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Apr 2019 14:12:57 -0400
Received: (qmail 11308 invoked by uid 109); 5 Apr 2019 18:12:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 05 Apr 2019 18:12:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28317 invoked by uid 111); 5 Apr 2019 18:13:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 05 Apr 2019 14:13:24 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Apr 2019 14:12:55 -0400
Date:   Fri, 5 Apr 2019 14:12:55 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v2 07/13] http: simplify parsing of remote objects/info/packs
Message-ID: <20190405181255.GG32243@sigill.intra.peff.net>
References: <20190405180306.GA21113@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190405180306.GA21113@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We can use skip_prefix() and parse_oid_hex() to continuously increment
our pointer, rather than dealing with magic numbers. This also fixes a
few small shortcomings:

  - if we see a line with the right prefix, suffix, and length, i.e.
    matching /P pack-.{40}.pack\n/, we'll interpret the middle part as
    hex without checking if it could be parsed. This could lead to us
    looking at uninitialized garbage in the hash array. In practice this
    means we'll just make a garbage request to the server which will
    fail, though it's interesting that a malicious server could convince
    us to leak 40 bytes of uninitialized stack to them.

  - the current code is picky about seeing a newline at the end of file,
    but we can easily be more liberal

Signed-off-by: Jeff King <peff@peff.net>
---
This drops an incorrect claim from the v1 commit message. Sorry, I only
remembered to deal with it as I was sending the patch out, so it is not
reflected in the range-diff in the cover letter.

 http.c | 35 ++++++++++++++---------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/http.c b/http.c
index a32ad36ddf..2ef47bc779 100644
--- a/http.c
+++ b/http.c
@@ -2147,11 +2147,11 @@ static int fetch_and_setup_pack_index(struct packed_git **packs_head,
 int http_get_info_packs(const char *base_url, struct packed_git **packs_head)
 {
 	struct http_get_options options = {0};
-	int ret = 0, i = 0;
-	char *url, *data;
+	int ret = 0;
+	char *url;
+	const char *data;
 	struct strbuf buf = STRBUF_INIT;
-	unsigned char hash[GIT_MAX_RAWSZ];
-	const unsigned hexsz = the_hash_algo->hexsz;
+	struct object_id oid;
 
 	end_url_with_slash(&buf, base_url);
 	strbuf_addstr(&buf, "objects/info/packs");
@@ -2163,24 +2163,17 @@ int http_get_info_packs(const char *base_url, struct packed_git **packs_head)
 		goto cleanup;
 
 	data = buf.buf;
-	while (i < buf.len) {
-		switch (data[i]) {
-		case 'P':
-			i++;
-			if (i + hexsz + 12 <= buf.len &&
-			    starts_with(data + i, " pack-") &&
-			    starts_with(data + i + hexsz + 6, ".pack\n")) {
-				get_sha1_hex(data + i + 6, hash);
-				fetch_and_setup_pack_index(packs_head, hash,
-						      base_url);
-				i += hexsz + 11;
-				break;
-			}
-		default:
-			while (i < buf.len && data[i] != '\n')
-				i++;
+	while (*data) {
+		if (skip_prefix(data, "P pack-", &data) &&
+		    !parse_oid_hex(data, &oid, &data) &&
+		    skip_prefix(data, ".pack", &data) &&
+		    (*data == '\n' || *data == '\0')) {
+			fetch_and_setup_pack_index(packs_head, oid.hash, base_url);
+		} else {
+			data = strchrnul(data, '\n');
 		}
-		i++;
+		if (*data)
+			data++; /* skip past newline */
 	}
 
 cleanup:
-- 
2.21.0.729.g7d31bf3764

