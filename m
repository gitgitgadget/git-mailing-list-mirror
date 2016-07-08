Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E4462023C
	for <e@80x24.org>; Fri,  8 Jul 2016 09:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754251AbcGHJHB (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 05:07:01 -0400
Received: from cloud.peff.net ([50.56.180.127]:41839 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754437AbcGHJGy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 05:06:54 -0400
Received: (qmail 4831 invoked by uid 102); 8 Jul 2016 09:06:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 08 Jul 2016 05:06:55 -0400
Received: (qmail 11791 invoked by uid 107); 8 Jul 2016 09:07:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 08 Jul 2016 05:07:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Jul 2016 05:06:50 -0400
Date:	Fri, 8 Jul 2016 05:06:50 -0400
From:	Jeff King <peff@peff.net>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Matthieu Moy <Matthieu.Moy@imag.fr>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/8] config: fix bogus fd check when setting up default config
Message-ID: <20160708090649.GA10152@sigill.intra.peff.net>
References: <20160708090400.GA26594@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160708090400.GA26594@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Since 9830534 (config --global --edit: create a template
file if needed, 2014-07-25), an edit of the global config
file will try to open() it with O_EXCL, and wants to handle
three cases:

  1. We succeeded; the user has no config file, and we
     should fill in the default template.

  2. We got EEXIST; they have a file already, proceed as usual.

  3. We got another error; we should complain.

However, the check for case 1 does "if (fd)", which will
generally _always_ be true (except for the oddball case that
somehow our stdin got closed and opening really did give us
a new descriptor 0).

So in the EEXIST case, we tried to write the default config
anyway! Fortunately, this turns out to be a noop, since we
just end up writing to and closing "-1", which does nothing.

But in case 3, we would fail to notice any other errors, and
just silently continue (given that we don't actually notice
write errors for the template either, it's probably not that
big a deal; we're about to spawn the editor, so it would
notice any problems. But the code is clearly _trying_ to hit
cover this case and failing).

We can fix it easily by using "fd >= 0" for case 1.

Signed-off-by: Jeff King <peff@peff.net>
---
I was looking at this to see whether it could be converted to
write_file(). However, the O_EXCL and the error-handling make things
too tricky.

 builtin/config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/config.c b/builtin/config.c
index 1d7c6ef..a991a53 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -604,7 +604,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 				      given_config_source.file : git_path("config"));
 		if (use_global_config) {
 			int fd = open(config_file, O_CREAT | O_EXCL | O_WRONLY, 0666);
-			if (fd) {
+			if (fd >= 0) {
 				char *content = default_user_config();
 				write_str_in_full(fd, content);
 				free(content);
-- 
2.9.0.393.g704e522

