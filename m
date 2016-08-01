Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66F7B1F855
	for <e@80x24.org>; Mon,  1 Aug 2016 18:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754397AbcHASGy (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 14:06:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:52655 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751517AbcHASGw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 14:06:52 -0400
Received: (qmail 8131 invoked by uid 102); 1 Aug 2016 17:38:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Aug 2016 13:38:50 -0400
Received: (qmail 15101 invoked by uid 107); 1 Aug 2016 17:39:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Aug 2016 13:39:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Aug 2016 13:38:47 -0400
Date:	Mon, 1 Aug 2016 13:38:47 -0400
From:	Jeff King <peff@peff.net>
To:	Josh Triplett <josh@joshtriplett.org>
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] format-patch: Add a config option format.from to
 set the default for --from
Message-ID: <20160801173847.qph2tora75h6ebsk@sigill.intra.peff.net>
References: <cover.4d006cadf197f80d899ad7d7d56d8ba41f574adf.1469905775.git-series.josh@joshtriplett.org>
 <20160730191111.cd6ay3l4hweyjf7f@x>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160730191111.cd6ay3l4hweyjf7f@x>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Jul 30, 2016 at 12:11:11PM -0700, Josh Triplett wrote:

> +enum from {
> +	FROM_AUTHOR,
> +	FROM_USER,
> +	FROM_VALUE,
> +};
> +
> +static void set_from(enum from type, const char *value)
> +{
> +	free(from);
> +	switch (type) {
> +	case FROM_AUTHOR:
> +		from = NULL;
> +		break;
> +	case FROM_USER:
> +		from = xstrdup(git_committer_info(IDENT_NO_DATE));
> +		break;
> +	case FROM_VALUE:
> +		from = xstrdup(value);
> +		break;
> +	}
> +}

Thanks for looking into reducing the duplication. TBH, I am not sure it
is really an improvement, just because of the amount of boilerplate (and
this function interface is kind of weird, because of the rules for when
"value" should or should not be NULL).

I guess another way to do it would be:

  #define FROM_AUTO_IDENT ((const char *)(intptr_t)1))
  void set_from(const char *value)
  {
	if (value == FROM_AUTO_IDENT)
		value = git_committer_info(IDENT_NO_DATE);
	free(from);
	from = xstrdup_or_null(value);
  }

but I think the effort to polish further here is outweighing the
magnitude of the patch itself. So I offer that as "how I would have done
it" in case you like it, but again, I am fine with either this version
or the previous.

-Peff
