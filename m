Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5C261F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 16:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753185AbcHCQTQ (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 12:19:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:53807 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751351AbcHCQTP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 12:19:15 -0400
Received: (qmail 4885 invoked by uid 102); 3 Aug 2016 16:19:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Aug 2016 12:19:14 -0400
Received: (qmail 1599 invoked by uid 107); 3 Aug 2016 16:19:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Aug 2016 12:19:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Aug 2016 12:19:11 -0400
Date:	Wed, 3 Aug 2016 12:19:11 -0400
From:	Jeff King <peff@peff.net>
To:	Eric Wong <e@80x24.org>
Cc:	Junio C Hamano <gitster@pobox.com>,
	"Kyle J. McKay" <mackyle@gmail.com>, git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH 1/1 v2] pager: move pager-specific setup into the build
Message-ID: <20160803161911.dxucq7f2pvnoovoc@sigill.intra.peff.net>
References: <20160801214937.4752-1-e@80x24.org>
 <20160801214937.4752-2-e@80x24.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160801214937.4752-2-e@80x24.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 01, 2016 at 09:49:37PM +0000, Eric Wong wrote:

> +static void setup_pager_env(struct argv_array *env)
> +{
> +	const char *pager_env = PAGER_ENV;
> +
> +	while (*pager_env) {
> +		struct strbuf buf = STRBUF_INIT;
> +		const char *cp = strchrnul(pager_env, '=');
> +
> +		if (!*cp)
> +			die("malformed build-time PAGER_ENV");
> +		strbuf_add(&buf, pager_env, cp - pager_env);
> +		cp = strchrnul(pager_env, ' ');
> +		if (!getenv(buf.buf)) {
> +			strbuf_reset(&buf);
> +			strbuf_add(&buf, pager_env, cp - pager_env);
> +			argv_array_push(env, strbuf_detach(&buf, NULL));
> +		}

argv_array handles its own allocation, so this leaks the detached
strbuf.

You'd want:

  argv_array_push(env, buf.buf);
  strbuf_release(&buf);

or just:

  argv_array_pushf(env, "%.*s", (int)(cp - pager_env), pager_env);

Also:

> +		strbuf_reset(&buf);

should this be strbuf_release()? If we didn't follow the conditional
above (because getenv() told us the variable was already set), then we
would not do do the detach/release there, and would finish the loop with
memory still allocated by "buf".

-Peff
