Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 110F4207EC
	for <e@80x24.org>; Mon,  3 Oct 2016 20:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753016AbcJCUgA (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 16:36:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:51457 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752994AbcJCUf6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 16:35:58 -0400
Received: (qmail 17427 invoked by uid 109); 3 Oct 2016 20:35:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 03 Oct 2016 20:35:58 +0000
Received: (qmail 29830 invoked by uid 111); 3 Oct 2016 20:36:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 03 Oct 2016 16:36:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Oct 2016 16:35:55 -0400
Date:   Mon, 3 Oct 2016 16:35:55 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH 13/18] fill_sha1_file: write "boring" characters
Message-ID: <20161003203555.6xadycotmmkuf34h@sigill.intra.peff.net>
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function forms a sha1 as "xx/yyyy...", but skips over
the slot for the slash rather than writing it, leaving it to
the caller to do so. It also does not bother to put in a
trailing NUL, even though every caller would want it (we're
forming a path which by definition is not a directory, so
the only thing to do with it is feed it to a system call).

Let's make the lives of our callers easier by just writing
out the internal "/" and the NUL.

Signed-off-by: Jeff King <peff@peff.net>
---
 sha1_file.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 70c3e2f..c6308c1 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -178,10 +178,12 @@ static void fill_sha1_path(char *pathbuf, const unsigned char *sha1)
 	for (i = 0; i < 20; i++) {
 		static char hex[] = "0123456789abcdef";
 		unsigned int val = sha1[i];
-		char *pos = pathbuf + i*2 + (i > 0);
-		*pos++ = hex[val >> 4];
-		*pos = hex[val & 0xf];
+		*pathbuf++ = hex[val >> 4];
+		*pathbuf++ = hex[val & 0xf];
+		if (!i)
+			*pathbuf++ = '/';
 	}
+	*pathbuf = '\0';
 }
 
 const char *sha1_file_name(const unsigned char *sha1)
@@ -198,8 +200,6 @@ const char *sha1_file_name(const unsigned char *sha1)
 		die("insanely long object directory %s", objdir);
 	memcpy(buf, objdir, len);
 	buf[len] = '/';
-	buf[len+3] = '/';
-	buf[len+42] = '\0';
 	fill_sha1_path(buf + len + 1, sha1);
 	return buf;
 }
@@ -406,8 +406,6 @@ struct alternate_object_database *alloc_alt_odb(const char *dir)
 
 	ent->name = ent->scratch + dirlen + 1;
 	ent->scratch[dirlen] = '/';
-	ent->scratch[dirlen + 3] = '/';
-	ent->scratch[entlen-1] = 0;
 
 	return ent;
 }
-- 
2.10.0.618.g82cc264

