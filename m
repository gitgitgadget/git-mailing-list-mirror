Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8246F1F858
	for <e@80x24.org>; Thu, 28 Jul 2016 16:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759126AbcG1QRy (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 12:17:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:50458 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759075AbcG1QRw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 12:17:52 -0400
Received: (qmail 24649 invoked by uid 102); 28 Jul 2016 16:17:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Jul 2016 12:17:52 -0400
Received: (qmail 26461 invoked by uid 107); 28 Jul 2016 16:18:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Jul 2016 12:18:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Jul 2016 12:17:49 -0400
Date:	Thu, 28 Jul 2016 12:17:49 -0400
From:	Jeff King <peff@peff.net>
To:	Vasco Almeida <vascomalmeida@sapo.pt>
Cc:	git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2] i18n: config: unfold error messages marked for
 translation
Message-ID: <20160728161748.GA18515@sigill.intra.peff.net>
References: <1469642375-27305-1-git-send-email-vascomalmeida@sapo.pt>
 <1469711643-10367-1-git-send-email-vascomalmeida@sapo.pt>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1469711643-10367-1-git-send-email-vascomalmeida@sapo.pt>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 28, 2016 at 01:14:03PM +0000, Vasco Almeida wrote:

>  static void die_bad_number(const char *name, const char *value)
>  {
> -	const char *reason = errno == ERANGE ?
> -			     "out of range" :
> -			     "invalid unit";
>  	if (!value)
>  		value = "";
>  
> -	if (cf && cf->origin_type && cf->name)
> -		die(_("bad numeric config value '%s' for '%s' in %s %s: %s"),
> -		    value, name, cf->origin_type, cf->name, reason);
> -	die(_("bad numeric config value '%s' for '%s': %s"), value, name, reason);
> +	if (!(cf && cf->name))
> +		die(errno == ERANGE
> +		    ? _("bad numeric config value '%s' for '%s': out of range")
> +		    : _("bad numeric config value '%s' for '%s': invalid unit"),
> +		    value, name);
> +
> +	switch (cf->origin_type) {
> +	case CONFIG_ORIGIN_BLOB:
> +		die(errno == ERANGE
> +		    ? _("bad numeric config value '%s' for '%s' in blob %s: out of range")
> +		    : _("bad numeric config value '%s' for '%s' in blob %s: invalid unit"),
> +		    value, name, cf->name);

I get that the point of this patch is to make more complete sentences
for translation, rather than the lego-brick construction. And that makes
sense to me. But it seems like the ":" is a natural separator, and it
would be OK to make these:

  die(_("bad numeric config value '%s' for '%s' in blob %s: %s"),
	value, name, cf->name, reason);

instead of having two separate strings for the errno values.  After all,
that's what we do everywhere else where "reason" is supplied by
strerror(). It's just in this case that there is no errno value matching
"invalid unit", so we have to fill it in ourselves.

-Peff
