Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.2 required=5.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16E2920179
	for <e@80x24.org>; Thu, 16 Jun 2016 23:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754541AbcFPXhX (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 19:37:23 -0400
Received: from cloud.peff.net ([50.56.180.127]:55978 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754031AbcFPXhX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 19:37:23 -0400
Received: (qmail 12823 invoked by uid 102); 16 Jun 2016 23:37:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Jun 2016 19:37:22 -0400
Received: (qmail 21827 invoked by uid 107); 16 Jun 2016 23:37:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Jun 2016 19:37:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Jun 2016 19:37:20 -0400
Date:	Thu, 16 Jun 2016 19:37:20 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Christian Couder <christian.couder@gmail.com>,
	Markus Trippelsdorf <markus@trippelsdorf.de>,
	git@vger.kernel.org
Subject: [PATCH] bisect: always call setup_revisions after init_revisions
Message-ID: <20160616233719.GB15013@sigill.intra.peff.net>
References: <20160616125326.GA314@x4>
 <20160616132952.GC314@x4>
 <20160616134742.GA25920@sigill.intra.peff.net>
 <xmqqporh3rqu.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqporh3rqu.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The former initializes the rev_info struct to default
values, and the latter parsers any command-line arguments
and finalizes the struct.

In e22278c (bisect: display first bad commit without forking
a new process, 2009-05-28), a show_diff_tree() was added
that calls the former but not the latter. It doesn't have
any arguments to parse, but it still should do the
finalizing step.

This may have caused other minor bugs over the years, but it
became much more prominent after fe37a9c (pretty: allow
tweaking tabwidth in --expand-tabs, 2016-03-29). That leaves
the expected tab width as "-1", rather than the true default
of "8". When we see a commit with tabs to be expanded, we
end up trying to add (size_t)-1 spaces to a strbuf, which
complains about the integer overflow.

The fix is easy: just call setup_revisions() with no
arguments.

Signed-off-by: Jeff King <peff@peff.net>
---
Same patch as earlier, now with 100% more commit message.

I didn't add a test, as it seemed weirdly specific to be checking "can
bisect show a commit with tabs in it". I.e., it's not likely to actually
regress in this specific way again.

 bisect.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bisect.c b/bisect.c
index 6d93edb..dc13319 100644
--- a/bisect.c
+++ b/bisect.c
@@ -890,6 +890,7 @@ static void show_diff_tree(const char *prefix, struct commit *commit)
 	if (!opt.diffopt.output_format)
 		opt.diffopt.output_format = DIFF_FORMAT_RAW;
 
+	setup_revisions(0, NULL, &opt, NULL);
 	log_tree_commit(&opt, commit);
 }
 
-- 
2.9.0.165.g4aacdc3

