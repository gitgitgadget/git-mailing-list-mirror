Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A5631F404
	for <e@80x24.org>; Tue, 14 Aug 2018 18:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbeHNVG3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 17:06:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:54958 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725915AbeHNVG3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 17:06:29 -0400
Received: (qmail 31946 invoked by uid 109); 14 Aug 2018 18:18:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 14 Aug 2018 18:18:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24475 invoked by uid 111); 14 Aug 2018 18:18:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 14 Aug 2018 14:18:11 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Aug 2018 14:18:06 -0400
Date:   Tue, 14 Aug 2018 14:18:06 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, git@vger.kernel.org
Subject: [PATCH 2/4] cat-file: split batch "buf" into two variables
Message-ID: <20180814181806.GB26919@sigill.intra.peff.net>
References: <20180814181358.GA26391@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180814181358.GA26391@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We use the "buf" strbuf for two things: to read incoming
lines, and as a scratch space for test-expanding the
user-provided format. Let's split this into two variables
with descriptive names, which makes their purpose and
lifetime more clear.

It will also help in a future patch when we start using the
"output" buffer for more expansions.

Signed-off-by: Jeff King <peff@peff.net>
---
René, in the patch you sent earlier, I noticed that for the
non-batch-all-objects case we use the same strbuf for input and output.
That'd probably be OK most of the time (the first thing we do is resolve
the input to an oid), but I suspect it could be pretty bad with %(rest).
We'd write over or even realloc the string it points into as part of the
output.

This patch just clarifies the names; your reuse idea is in the next one.

 builtin/cat-file.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 04b5cda191..3ed1d0be80 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -466,7 +466,8 @@ static int batch_unordered_packed(const struct object_id *oid,
 
 static int batch_objects(struct batch_options *opt)
 {
-	struct strbuf buf = STRBUF_INIT;
+	struct strbuf input = STRBUF_INIT;
+	struct strbuf output = STRBUF_INIT;
 	struct expand_data data;
 	int save_warning;
 	int retval = 0;
@@ -481,8 +482,9 @@ static int batch_objects(struct batch_options *opt)
 	 */
 	memset(&data, 0, sizeof(data));
 	data.mark_query = 1;
-	strbuf_expand(&buf, opt->format, expand_format, &data);
+	strbuf_expand(&output, opt->format, expand_format, &data);
 	data.mark_query = 0;
+	strbuf_release(&output);
 	if (opt->cmdmode)
 		data.split_on_whitespace = 1;
 
@@ -542,14 +544,14 @@ static int batch_objects(struct batch_options *opt)
 	save_warning = warn_on_object_refname_ambiguity;
 	warn_on_object_refname_ambiguity = 0;
 
-	while (strbuf_getline(&buf, stdin) != EOF) {
+	while (strbuf_getline(&input, stdin) != EOF) {
 		if (data.split_on_whitespace) {
 			/*
 			 * Split at first whitespace, tying off the beginning
 			 * of the string and saving the remainder (or NULL) in
 			 * data.rest.
 			 */
-			char *p = strpbrk(buf.buf, " \t");
+			char *p = strpbrk(input.buf, " \t");
 			if (p) {
 				while (*p && strchr(" \t", *p))
 					*p++ = '\0';
@@ -557,10 +559,10 @@ static int batch_objects(struct batch_options *opt)
 			data.rest = p;
 		}
 
-		batch_one_object(buf.buf, opt, &data);
+		batch_one_object(input.buf, opt, &data);
 	}
 
-	strbuf_release(&buf);
+	strbuf_release(&input);
 	warn_on_object_refname_ambiguity = save_warning;
 	return retval;
 }
-- 
2.18.0.1066.g0d97f3a098

