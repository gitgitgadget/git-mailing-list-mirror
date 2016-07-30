Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE2F61F71B
	for <e@80x24.org>; Sat, 30 Jul 2016 15:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752943AbcG3Pkk (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 11:40:40 -0400
Received: from cloud.peff.net ([50.56.180.127]:51706 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752819AbcG3Pki (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 11:40:38 -0400
Received: (qmail 31461 invoked by uid 102); 30 Jul 2016 15:40:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 30 Jul 2016 11:40:38 -0400
Received: (qmail 12253 invoked by uid 107); 30 Jul 2016 15:41:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 30 Jul 2016 11:41:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 30 Jul 2016 11:40:34 -0400
Date:	Sat, 30 Jul 2016 11:40:34 -0400
From:	Jeff King <peff@peff.net>
To:	Josh Triplett <josh@joshtriplett.org>
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] format-patch: Add a config option format.from to set
 the default for --from
Message-ID: <20160730154034.thjrfu6zeprzwvxb@sigill.intra.peff.net>
References: <cover.8678faa71de50c8e78760b0bcb3d15ebeda207d5.1469871675.git-series.josh@joshtriplett.org>
 <20160730094156.etvrzqbhcpg3is2z@x>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160730094156.etvrzqbhcpg3is2z@x>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Jul 30, 2016 at 02:41:56AM -0700, Josh Triplett wrote:

> @@ -807,6 +808,17 @@ static int git_format_config(const char *var, const char *value, void *cb)
>  		base_auto = git_config_bool(var, value);
>  		return 0;
>  	}
> +	if (!strcmp(var, "format.from")) {
> +		int b = git_config_maybe_bool(var, value);
> +		free(from);
> +		if (b < 0)
> +			from = xstrdup(value);
> +		else if (b)
> +			from = xstrdup(git_committer_info(IDENT_NO_DATE));
> +		else
> +			from = NULL;
> +		return 0;
> +	}

This "free old, then handle tri-state" mirrors the code in the parseopt
callback pretty closely. I wonder if they could share the logic (it is
not many lines, but we would want the logic to stay identical). I
suspect the helper function would end up with more boilerplate than it's
worth, though, trying to handle the unset and default cases.

> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index 1206c48..b0579dd 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -229,6 +229,46 @@ check_patch () {
>  	grep -e "^Subject:" "$1"
>  }
>  
> +test_expect_success 'format.from=false' '
> +
> +	git -c format.from=false format-patch --stdout master..side |
> +	sed -e "/^\$/q" >patch &&
> +	check_patch patch &&
> +	! grep "^From: C O Mitter <committer@example.com>\$" patch
> +'

These tests follow a different style from the "--from" tests later in
the script (and your second patch does follow it, and puts its test
close there). Any reason not to have all of the "from" tests together,
and using the same style?


Overall, the whole thing looks cleanly done, and I don't mind it going
in as-is. These are just two things I noticed while reading it over.

-Peff
