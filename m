Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F4F61F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 18:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751757AbdARSah (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 13:30:37 -0500
Received: from cloud.peff.net ([104.130.231.41]:40961 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751467AbdARSag (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 13:30:36 -0500
Received: (qmail 9920 invoked by uid 109); 18 Jan 2017 18:28:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 Jan 2017 18:28:46 +0000
Received: (qmail 29830 invoked by uid 111); 18 Jan 2017 18:29:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 Jan 2017 13:29:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jan 2017 13:28:44 -0500
Date:   Wed, 18 Jan 2017 13:28:44 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     santiago@nyu.edu, git@vger.kernel.org, sunshine@sunshineco.com,
        walters@verbum.org, Lukas Puehringer <luk.puehringer@gmail.com>
Subject: Re: [PATCH v6 4/6] builtin/tag: add --format argument for tag -v
Message-ID: <20170118182843.iyico5jpii6a3z7i@sigill.intra.peff.net>
References: <20170117233723.23897-1-santiago@nyu.edu>
 <20170117233723.23897-5-santiago@nyu.edu>
 <xmqqmvepb4oj.fsf@gitster.mtv.corp.google.com>
 <xmqqh94wb4y0.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh94wb4y0.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 18, 2017 at 10:25:59AM -0800, Junio C Hamano wrote:

> > This triggers:
> >
> >     builtin/tag.c: In function 'cmd_tag':
> >     builtin/tag.c:451:3: error: passing argument 3 of
> >     'for_each_tag_name' discards 'const' qualifier from pointer target type [-Werror]
> >        return for_each_tag_name(argv, verify_tag, format);
> >
> > Either for-each-tag-name's new parameter needs to be typed
> > correctly, or the type of the "format" variable needs to be updated.
> 
> Squashing the following into this commit solves this issue with the
> former approach.  The lines it touches are all from 4/6 and I view
> all of it as general improvement, including type correctness and
> code formatting.
> 
> diff --git a/builtin/tag.c b/builtin/tag.c
> index f81273a85a..fbb85ba3dc 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -66,10 +66,10 @@ static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting, con
>  }
>  
>  typedef int (*each_tag_name_fn)(const char *name, const char *ref,
> -				const unsigned char *sha1, void *cb_data);
> +				const unsigned char *sha1, const void *cb_data);

This would bite us later if one of the iterators really does need to
pass something mutable. But as this iteration interface is confined to
builtin/tag.c, I think it's a nice simple fix.

A more general fix would be to pass a non-const pointer to const pointer
(preferably inside a struct for readability). But I don't see any need
for that complexity here.

-Peff
