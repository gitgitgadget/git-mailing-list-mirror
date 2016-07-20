Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 241612034E
	for <e@80x24.org>; Wed, 20 Jul 2016 15:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751550AbcGTP6r (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 11:58:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:47570 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751036AbcGTP6q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 11:58:46 -0400
Received: (qmail 16172 invoked by uid 102); 20 Jul 2016 15:58:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 Jul 2016 11:58:46 -0400
Received: (qmail 22144 invoked by uid 107); 20 Jul 2016 15:59:09 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 Jul 2016 11:59:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Jul 2016 09:58:37 -0600
Date:	Wed, 20 Jul 2016 09:58:37 -0600
From:	Jeff King <peff@peff.net>
To:	Jeff Hostetler <jeffhost@microsoft.com>
Cc:	git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v1 1/6] Allow --porcelain[=<n>] in status and commit
 commands
Message-ID: <20160720155837.GA24902@sigill.intra.peff.net>
References: <1468966258-11191-1-git-send-email-jeffhost@microsoft.com>
 <1468966258-11191-2-git-send-email-jeffhost@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1468966258-11191-2-git-send-email-jeffhost@microsoft.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 19, 2016 at 06:10:53PM -0400, Jeff Hostetler wrote:

> +static int opt_parse_porcelain(const struct option *opt, const char *arg, int unset)
> +{
> +	enum wt_status_format *value = (enum wt_status_format *)opt->value;
> +	if (unset) {
> +		*value = STATUS_FORMAT_UNSPECIFIED;

Nice attention to detail here and below in handling "unset" and "!arg"
cases.  I think should be STATUS_FORMAT_NONE, though, which is what the
old code used to do (since "0" is the usual special value for --no-*
options). It only matters if you do:

  git status --no-porcelain

Right now that will switch to the long format, regardless of your
config. With your path it defaults to any configured value. It's
probably a case that nobody hits ever, but in the absence of a good
reason to do otherwise, I'd stick with the current behavior.

> +	} else if (arg) {
> +		int n = strtol(arg, NULL, 10);
> +		if (n == 1)
> +			*value = STATUS_FORMAT_PORCELAIN;
> +		else
> +			die("unsupported porcelain version");

This silently allows:

  git status --porcelain="1 for the money"

and later:

  git status --porcelain="2 for the show"

Probably not a big deal in practice, but since the list of formats is
constrained, we don't really care about parsing arbitrary numbers.
So:

  if (!strcmp(arg, "1"))
	*value = STATUS_FORMAT_PORCELAIN;

is actually simpler, and more robust.

I also wondered if:

  git status --porcelain=v1

is more self-documenting about the meaning of "1". It's purely
aesthetics, but it somehow looks better to me. Matching that is also
much easier with pure strcmps.

> @@ -1381,6 +1392,8 @@ int cmd_status(int argc, const char **argv, const char *prefix)
>  
>  	s.is_initial = get_sha1(s.reference, sha1) ? 1 : 0;
>  	s.ignore_submodule_arg = ignore_submodule_arg;
> +	s.status_format = status_format;
> +

I wonder what happens if you pass a "wt_status" with a format of "SHORT"
to the long-formatting code.

I think it is ignored completely, as you are just now introducing the
s.status_format field. But I wonder if there is room for further cleanup
in pushing the big switch statements from run_status() and cmd_status()
into wt-status.c.

-Peff
