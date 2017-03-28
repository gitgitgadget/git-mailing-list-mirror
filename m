Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09ADD1FAFB
	for <e@80x24.org>; Tue, 28 Mar 2017 19:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755725AbdC1Tqd (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 15:46:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:53158 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755401AbdC1Tq0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 15:46:26 -0400
Received: (qmail 11783 invoked by uid 109); 28 Mar 2017 19:46:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 19:46:25 +0000
Received: (qmail 4768 invoked by uid 111); 28 Mar 2017 19:46:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 15:46:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Mar 2017 15:46:23 -0400
Date:   Tue, 28 Mar 2017 15:46:23 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 05/18] tag: use strbuf to format tag header
Message-ID: <20170328194623.sv2sih2s7q533zgf@sigill.intra.peff.net>
References: <20170328194255.vf7nfzzmmzxsbn36@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170328194255.vf7nfzzmmzxsbn36@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We format the tag header into a fixed 1024-byte buffer. But
since the tag-name and tagger ident can be arbitrarily
large, we may unceremoniously die with "tag header too big".
Let's just use a strbuf instead.

Note that it looks at first glance like we can just format
this directly into the "buf" strbuf where it will ultimately
go. But that buffer may already contain the tag message, and
we have no easy way to prepend formatted data to a strbuf
(we can only splice in an already-generated buffer). This
isn't a performance-critical path, so going through an extra
buffer isn't a big deal.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/tag.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index ad29be692..045e7ad23 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -231,26 +231,22 @@ static void create_tag(const unsigned char *object, const char *tag,
 		       unsigned char *prev, unsigned char *result)
 {
 	enum object_type type;
-	char header_buf[1024];
-	int header_len;
+	struct strbuf header = STRBUF_INIT;
 	char *path = NULL;
 
 	type = sha1_object_info(object, NULL);
 	if (type <= OBJ_NONE)
 	    die(_("bad object type."));
 
-	header_len = snprintf(header_buf, sizeof(header_buf),
-			  "object %s\n"
-			  "type %s\n"
-			  "tag %s\n"
-			  "tagger %s\n\n",
-			  sha1_to_hex(object),
-			  typename(type),
-			  tag,
-			  git_committer_info(IDENT_STRICT));
-
-	if (header_len > sizeof(header_buf) - 1)
-		die(_("tag header too big."));
+	strbuf_addf(&header,
+		    "object %s\n"
+		    "type %s\n"
+		    "tag %s\n"
+		    "tagger %s\n\n",
+		    sha1_to_hex(object),
+		    typename(type),
+		    tag,
+		    git_committer_info(IDENT_STRICT));
 
 	if (!opt->message_given) {
 		int fd;
@@ -288,7 +284,8 @@ static void create_tag(const unsigned char *object, const char *tag,
 	if (!opt->message_given && !buf->len)
 		die(_("no tag message?"));
 
-	strbuf_insert(buf, 0, header_buf, header_len);
+	strbuf_insert(buf, 0, header.buf, header.len);
+	strbuf_release(&header);
 
 	if (build_tag_object(buf, opt->sign, result) < 0) {
 		if (path)
-- 
2.12.2.845.g55fcf8b10

