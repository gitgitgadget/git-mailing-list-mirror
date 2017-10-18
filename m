Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E15E202A3
	for <e@80x24.org>; Wed, 18 Oct 2017 21:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751161AbdJRVYy (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Oct 2017 17:24:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:57066 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750926AbdJRVYx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Oct 2017 17:24:53 -0400
Received: (qmail 13104 invoked by uid 109); 18 Oct 2017 21:24:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 18 Oct 2017 21:24:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4065 invoked by uid 111); 18 Oct 2017 21:24:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 18 Oct 2017 17:24:57 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Oct 2017 17:24:51 -0400
Date:   Wed, 18 Oct 2017 17:24:51 -0400
From:   Jeff King <peff@peff.net>
To:     Guillaume Castagnino <casta+github@xwing.info>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] use filetest pragma to work with ACL
Message-ID: <20171018212451.goqxu4qq6aqe4tpl@sigill.intra.peff.net>
References: <0102015f310e24b9-b96378f3-a029-4110-80dd-e454522e2cb7-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0102015f310e24b9-b96378f3-a029-4110-80dd-e454522e2cb7-000000@eu-west-1.amazonses.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 18, 2017 at 07:55:31PM +0000, Guillaume Castagnino wrote:

> From: Guillaume Castagnino <casta@xwing.info>
> [...]

Stefan raised a few meta issues, all of which I agree with. But I had
some questions about the patch itself:

> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 9208f42ed1753..0ee7f304ce2b1 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -3072,6 +3072,7 @@ sub git_get_projects_list {
>  				# only directories can be git repositories
>  				return unless (-d $_);
>  				# need search permission
> +				use filetest 'access';
>  				return unless (-x $_);

This "use" will unconditionally at compile-time (such as "compile" is
for perl, anyway). Which raises a few questions:

  - would we want to use "require" instead to avoid loading when we
    don't enter this function?

  - If the answer to the above is "no" (e.g., because we basically
    always need it; I didn't check), should it go at the top of the
    script with the other "use" directives?

    I think this is a scoped pragma, so what you have here affects only
    this particular "-x". But wouldn't other uses of "-x" potentially
    want the same benefit?

  - Do all relevant versions of perl ship with filetest? According to
    Module::Corelist, it first shipped with perl 5.6. In general I think
    we treat that as a minimum for our perl scripts, though I do notice
    that the gitweb script says "use 5.008". I'm not sure how realistic
    that is.

    If we can't count on it everywhere, then we probably need to wrap it
    in an eval, and fall back to the existing "-x".

-Peff
