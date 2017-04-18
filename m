Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B9781FA26
	for <e@80x24.org>; Tue, 18 Apr 2017 03:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754092AbdDRDSS (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 23:18:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:35039 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753434AbdDRDSR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 23:18:17 -0400
Received: (qmail 7287 invoked by uid 109); 18 Apr 2017 03:18:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 18 Apr 2017 03:18:16 +0000
Received: (qmail 8213 invoked by uid 111); 18 Apr 2017 03:18:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 17 Apr 2017 23:18:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Apr 2017 23:18:13 -0400
Date:   Mon, 17 Apr 2017 23:18:13 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 07/18] avoid using fixed PATH_MAX buffers for refs
Message-ID: <20170418031812.lsi4v5tmxdfuglgo@sigill.intra.peff.net>
References: <20170328194255.vf7nfzzmmzxsbn36@sigill.intra.peff.net>
 <20170328194629.5ddehsxizajitn3q@sigill.intra.peff.net>
 <xmqq1ssrk1za.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1ssrk1za.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 16, 2017 at 11:00:25PM -0700, Junio C Hamano wrote:

> > diff --git a/builtin/replace.c b/builtin/replace.c
> > index f83e7b8fc..065515bab 100644
> > --- a/builtin/replace.c
> > +++ b/builtin/replace.c
> > @@ -93,26 +93,31 @@ typedef int (*each_replace_name_fn)(const char *name, const char *ref,
> >  static int for_each_replace_name(const char **argv, each_replace_name_fn fn)
> [...]
> 
> Don't we need to strbuf_release(&ref) before leaving this function?

Yes, good catch. Squashable patch is below.

I'm not sure how I missed that one. I double-checked the other hunks in
the patch and they are all fine.

diff --git a/builtin/replace.c b/builtin/replace.c
index 065515bab..ab17668f4 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -120,6 +120,7 @@ static int for_each_replace_name(const char **argv, each_replace_name_fn fn)
 		if (fn(full_hex, ref.buf, &oid))
 			had_error = 1;
 	}
+	strbuf_release(&ref);
 	return had_error;
 }
 
