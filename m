Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CBD11F51C
	for <e@80x24.org>; Sat, 19 May 2018 01:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751907AbeESB5s (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 May 2018 21:57:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:46174 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750957AbeESB5r (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 May 2018 21:57:47 -0400
Received: (qmail 9240 invoked by uid 109); 19 May 2018 01:57:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 19 May 2018 01:57:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15874 invoked by uid 111); 19 May 2018 01:57:54 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 18 May 2018 21:57:54 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 May 2018 18:57:44 -0700
Date:   Fri, 18 May 2018 18:57:44 -0700
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/5] log_write_email_headers: use strbufs
Message-ID: <20180519015743.GB32492@sigill.intra.peff.net>
References: <20180519015444.GA12080@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180519015444.GA12080@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we write a MIME attachment, we write the mime headers
into fixed-size buffers. These are likely to be big enough
in practice, but technically the input could be arbitrarily
large (e.g., if the caller provided a lot of content in the
extra_headers string), in which case we'd quietly truncate
it and generate bogus output. Let's convert these buffers to
strbufs.

The memory ownership here is a bit funny. The original fixed
buffers were static, and we merely pass out pointers to them
to be used by the caller (and in one case, we even just
stuff our value into the opt->diffopt.stat_sep value).
Ideally we'd actually pass back heap buffers, and the caller
would be responsible for freeing them.

This patch punts on that cleanup for now, and instead just
marks the strbufs as static. That means we keep ownership in
this function, making it not a complete leak. This also
takes us one step closer to fixing it in the long term
(since we can eventually use strbuf_detach() to hand
ownership to the caller, once it's ready).

Signed-off-by: Jeff King <peff@peff.net>
---
The rest of that cleanup is a possible #leftoverbits.

 log-tree.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index d1c0bedf24..1173fdb057 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -386,11 +386,15 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 		graph_show_oneline(opt->graph);
 	}
 	if (opt->mime_boundary) {
-		static char subject_buffer[1024];
-		static char buffer[1024];
+		static struct strbuf subject_buffer = STRBUF_INIT;
+		static struct strbuf buffer = STRBUF_INIT;
 		struct strbuf filename =  STRBUF_INIT;
 		*need_8bit_cte_p = -1; /* NEVER */
-		snprintf(subject_buffer, sizeof(subject_buffer) - 1,
+
+		strbuf_reset(&subject_buffer);
+		strbuf_reset(&buffer);
+
+		strbuf_addf(&subject_buffer,
 			 "%s"
 			 "MIME-Version: 1.0\n"
 			 "Content-Type: multipart/mixed;"
@@ -405,13 +409,13 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 			 extra_headers ? extra_headers : "",
 			 mime_boundary_leader, opt->mime_boundary,
 			 mime_boundary_leader, opt->mime_boundary);
-		extra_headers = subject_buffer;
+		extra_headers = subject_buffer.buf;
 
 		if (opt->numbered_files)
 			strbuf_addf(&filename, "%d", opt->nr);
 		else
 			fmt_output_commit(&filename, commit, opt);
-		snprintf(buffer, sizeof(buffer) - 1,
+		strbuf_addf(&buffer,
 			 "\n--%s%s\n"
 			 "Content-Type: text/x-patch;"
 			 " name=\"%s\"\n"
@@ -422,7 +426,7 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 			 filename.buf,
 			 opt->no_inline ? "attachment" : "inline",
 			 filename.buf);
-		opt->diffopt.stat_sep = buffer;
+		opt->diffopt.stat_sep = buffer.buf;
 		strbuf_release(&filename);
 	}
 	*extra_headers_p = extra_headers;
-- 
2.17.0.1052.g7d69f75dbf

