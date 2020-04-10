Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A2DC2D0EC
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 19:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE5BD2083E
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 19:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgDJTrw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 15:47:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:40084 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726263AbgDJTrw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 15:47:52 -0400
Received: (qmail 7661 invoked by uid 109); 10 Apr 2020 19:47:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 10 Apr 2020 19:47:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2263 invoked by uid 111); 10 Apr 2020 19:58:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Apr 2020 15:58:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Apr 2020 15:47:51 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 5/6] config: use size_t to store parsed variable baselen
Message-ID: <20200410194751.GE1363756@coredump.intra.peff.net>
References: <20200410194211.GA1363484@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200410194211.GA1363484@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Most of the config parsing infrastructure is limited in what it can
parse only by the size of memory, because it parses character by
character, building up strbufs for keys, values, etc. One exception is
the "baselen" value we keep in git_parse_source(), which is an int.

That stores the length of the section.subsection base, to which we can
then append individual key names (by truncating back to the baselen with
strbuf_setlen(), and then appending characters for the key name). But
because it's an int, if we see an absurdly long section or subsection,
we may overflow the integer, wrapping negative. That negative value is
then implicitly cast to a size_t when we pass it to strbuf_setlen(),
creating a very large value and triggering a BUG. For example:

  $ {
       printf '[foo "'
       perl -e 'print "a" x 2**31'
       echo '"]bar = value'
    } >huge
  $ git config --file=huge --list
  fatal: BUG: strbuf_setlen() beyond buffer

While this is obviously a silly case that we don't care about
supporting, it's worth fixing it by switching to a size_t for a few
reasons:

  - we should try to avoid hitting BUG assertions at all

  - avoiding integer truncation or overflow sets a good example and
    makes it easier to audit the code for more important issues

  - the BUG outcome is what happens in _this_ instance, because we wrap
    negative. If we used a 2**32 subsection, we'd wrap to a small
    positive value and actually generate wrong output (the subsection of
    our key would be truncated).

Signed-off-by: Jeff King <peff@peff.net>
---
 config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.c b/config.c
index c48bb35dc0..1c25c94863 100644
--- a/config.c
+++ b/config.c
@@ -729,7 +729,7 @@ static int git_parse_source(config_fn_t fn, void *data,
 			    const struct config_options *opts)
 {
 	int comment = 0;
-	int baselen = 0;
+	size_t baselen = 0;
 	struct strbuf *var = &cf->var;
 	int error_return = 0;
 	char *error_msg = NULL;
-- 
2.26.0.414.ge3a6455e3d

