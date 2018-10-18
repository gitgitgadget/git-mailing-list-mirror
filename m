Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D38C1F453
	for <e@80x24.org>; Thu, 18 Oct 2018 06:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbeJROxC (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 10:53:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:44438 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727337AbeJROxC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 10:53:02 -0400
Received: (qmail 16597 invoked by uid 109); 18 Oct 2018 06:53:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 18 Oct 2018 06:53:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27601 invoked by uid 111); 18 Oct 2018 06:52:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 18 Oct 2018 02:52:42 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Oct 2018 02:53:29 -0400
Date:   Thu, 18 Oct 2018 02:53:29 -0400
From:   Jeff King <peff@peff.net>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     git@vger.kernel.org, rpeterso@redhat.com,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC v2] revision: Add --sticky-default option
Message-ID: <20181018065328.GC23537@sigill.intra.peff.net>
References: <20181017134947.12571-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181017134947.12571-1-agruenba@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 17, 2018 at 03:49:47PM +0200, Andreas Gruenbacher wrote:

> @@ -2431,7 +2446,11 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
>  		opt->tweak(revs, opt);
>  	if (revs->show_merge)
>  		prepare_show_merge(revs);
> -	if (revs->def && !revs->pending.nr && !revs->rev_input_given && !got_rev_arg) {
> +	if (revs->sticky_default)
> +		cancel_default = has_interesting_revisions();
> +	else
> +		cancel_default = got_rev_arg;
> +	if (revs->def && !revs->rev_input_given && !cancel_default) {

How do you want to handle "maybe has a ref" options like --stdin,
--tags, etc? Those set revs->rev_input_given.

With the code you have here, rev_input_given overrides any
sticky_default decision, and you cannot do this:

  git log --not --remotes=origin

and get the default, because even though you have only UNINTERESTING
commits, rev_input_given is true.

If you move rev_input_given to the cancel_default line above the final
conditional and turn that conditional into:

  if (revs->def && !cancel_default)

then it works.

-Peff
