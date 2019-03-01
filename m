Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BD4120248
	for <e@80x24.org>; Fri,  1 Mar 2019 19:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388074AbfCATJ5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Mar 2019 14:09:57 -0500
Received: from cloud.peff.net ([104.130.231.41]:34826 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1732637AbfCATJ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Mar 2019 14:09:57 -0500
Received: (qmail 21425 invoked by uid 109); 1 Mar 2019 19:09:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 01 Mar 2019 19:09:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 724 invoked by uid 111); 1 Mar 2019 19:10:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 01 Mar 2019 14:10:12 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Mar 2019 14:09:55 -0500
Date:   Fri, 1 Mar 2019 14:09:55 -0500
From:   Jeff King <peff@peff.net>
To:     Brandon Richardson <brandon1024.br@gmail.com>
Cc:     git@vger.kernel.org, rybak.a.v@gmail.com, pclouds@gmail.com
Subject: Re: [PATCH v2] commit-tree: utilize parse-options api
Message-ID: <20190301190954.GG30847@sigill.intra.peff.net>
References: <20190301171304.2267-1-brandon1024.br@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190301171304.2267-1-brandon1024.br@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 01, 2019 at 01:13:04PM -0400, Brandon Richardson wrote:

> +/*
> + * Use this assertion for callbacks that expect to be called with NONEG,
> + * and require an argument be supplied.
> + */
> +#define BUG_ON_OPT_NEG_NOARG(unset, arg) do { \

I think this general concept is fine. It's a variant of
BUG_ON_OPT_NEG(), so you'd use one or the other.

However, the implementation:

> +	if((!unset) && (!arg)) \
> +		BUG("option callback does not expect negation and requires an argument"); \

does not really make sense. If "!unset" is true, then we know that
"!arg" will always be true as well. So this collapse down to "!unset",
which is the same as BUG_ON_OPT_NEG().

I think you want an "OR". Or even separate conditions, since really this
is just implying OPT_NEG(). In fact, you could implement and explain it
like this:

diff --git a/parse-options.h b/parse-options.h
index 14fe32428e..d46f89305c 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -202,6 +202,18 @@ const char *optname(const struct option *opt, int flags);
 		BUG("option callback does not expect an argument"); \
 } while (0)
 
+/*
+ * Similar to the assertions above, but checks that "arg" is always non-NULL.
+ * I.e., that we expect the NOARG and OPTARG flags _not_ to be set. Since
+ * negation is the other common cause of a NULL arg, this also implies
+ * BUG_ON_OPT_NEG(), letting you declare both assertions in a single line.
+ */
+#define BUG_ON_OPT_NOARG(unset, arg) do { \
+	BUG_ON_OPT_NEG(unset); \
+	if (!(arg)) \
+		BUG("option callback require an argument"); \
+} while (0)
+
 /*----- incremental advanced APIs -----*/
 
 enum {

-Peff
