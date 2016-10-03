Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4394207EC
	for <e@80x24.org>; Mon,  3 Oct 2016 20:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752204AbcJCUgN (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 16:36:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:51466 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753067AbcJCUgM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 16:36:12 -0400
Received: (qmail 17445 invoked by uid 109); 3 Oct 2016 20:36:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 03 Oct 2016 20:36:11 +0000
Received: (qmail 29865 invoked by uid 111); 3 Oct 2016 20:36:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 03 Oct 2016 16:36:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Oct 2016 16:36:09 -0400
Date:   Mon, 3 Oct 2016 16:36:09 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH 15/18] fill_sha1_file: write into a strbuf
Message-ID: <20161003203609.4hig3e24lyvswdcf@sigill.intra.peff.net>
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's currently the responsibility of the caller to give
fill_sha1_file() enough bytes to write into, leading them to
manually compute the required lengths. Instead, let's just
write into a strbuf so that it's impossible to get this
wrong.

The alt_odb caller already has a strbuf, so this makes
things strictly simpler. The other caller, sha1_file_name(),
uses a static PATH_MAX buffer and dies when it would
overflow. We can convert this to a static strbuf, which
means our allocation cost is amortized (and as a bonus, we
no longer have to worry about PATH_MAX being too short for
normal use).

This does introduce some small overhead in fill_sha1_file(),
as each strbuf_addchar() will check whether it needs to
grow. However, between the optimization in fec501d
(strbuf_addch: avoid calling strbuf_grow, 2015-04-16) and
the fact that this is not generally called in a tight loop
(after all, the next step is typically to access the file!)
this probably doesn't matter. And even if it did, the right
place to micro-optimize is inside fill_sha1_file(), by
calling a single strbuf_grow() there.

Signed-off-by: Jeff King <peff@peff.net>
---
 sha1_file.c | 34 ++++++++++------------------------
 1 file changed, 10 insertions(+), 24 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index efc8cee..80a3333 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -172,36 +172,28 @@ enum scld_error safe_create_leading_directories_const(const char *path)
 	return result;
 }
 
-static void fill_sha1_path(char *pathbuf, const unsigned char *sha1)
+static void fill_sha1_path(struct strbuf *buf, const unsigned char *sha1)
 {
 	int i;
 	for (i = 0; i < 20; i++) {
 		static char hex[] = "0123456789abcdef";
 		unsigned int val = sha1[i];
-		*pathbuf++ = hex[val >> 4];
-		*pathbuf++ = hex[val & 0xf];
+		strbuf_addch(buf, hex[val >> 4]);
+		strbuf_addch(buf, hex[val & 0xf]);
 		if (!i)
-			*pathbuf++ = '/';
+			strbuf_addch(buf, '/');
 	}
-	*pathbuf = '\0';
 }
 
 const char *sha1_file_name(const unsigned char *sha1)
 {
-	static char buf[PATH_MAX];
-	const char *objdir;
-	int len;
+	static struct strbuf buf = STRBUF_INIT;
 
-	objdir = get_object_directory();
-	len = strlen(objdir);
+	strbuf_reset(&buf);
+	strbuf_addf(&buf, "%s/", get_object_directory());
 
-	/* '/' + sha1(2) + '/' + sha1(38) + '\0' */
-	if (len + 43 > PATH_MAX)
-		die("insanely long object directory %s", objdir);
-	memcpy(buf, objdir, len);
-	buf[len] = '/';
-	fill_sha1_path(buf + len + 1, sha1);
-	return buf;
+	fill_sha1_path(&buf, sha1);
+	return buf.buf;
 }
 
 struct strbuf *alt_scratch_buf(struct alternate_object_database *alt)
@@ -213,14 +205,8 @@ struct strbuf *alt_scratch_buf(struct alternate_object_database *alt)
 static const char *alt_sha1_path(struct alternate_object_database *alt,
 				 const unsigned char *sha1)
 {
-	/* hex sha1 plus internal "/" */
-	size_t len = GIT_SHA1_HEXSZ + 1;
 	struct strbuf *buf = alt_scratch_buf(alt);
-
-	strbuf_grow(buf, len);
-	fill_sha1_path(buf->buf + buf->len, sha1);
-	strbuf_setlen(buf, buf->len + len);
-
+	fill_sha1_path(buf, sha1);
 	return buf->buf;
 }
 
-- 
2.10.0.618.g82cc264

