Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 549EC1FAEB
	for <e@80x24.org>; Sat, 10 Jun 2017 10:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751943AbdFJKSQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Jun 2017 06:18:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:37625 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751890AbdFJKSQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2017 06:18:16 -0400
Received: (qmail 10300 invoked by uid 109); 10 Jun 2017 10:18:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 10 Jun 2017 10:18:15 +0000
Received: (qmail 30418 invoked by uid 111); 10 Jun 2017 10:18:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 10 Jun 2017 06:18:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Jun 2017 06:18:13 -0400
Date:   Sat, 10 Jun 2017 06:18:13 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 7/8] alias_lookup(): optionally return top-level
 directory
Message-ID: <20170610101813.n26wmxcueicecptz@sigill.intra.peff.net>
References: <cover.1496951503.git.johannes.schindelin@gmx.de>
 <aa6601bbfa50c728b7820e0a2991da76288509a5.1496951503.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aa6601bbfa50c728b7820e0a2991da76288509a5.1496951503.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 08, 2017 at 09:53:50PM +0200, Johannes Schindelin wrote:

> -char *alias_lookup(const char *alias)
> [...]
>  {
> -	char *v = NULL;
> -	struct strbuf key = STRBUF_INIT;
> -	strbuf_addf(&key, "alias.%s", alias);
> -	if (git_config_key_is_valid(key.buf))
> -		git_config_get_string(key.buf, &v);
> -	strbuf_release(&key);
> -	return v;
> +	struct strbuf key;
> +	char *v;
> +};
> [...]
> +char *alias_lookup(const char *alias, struct strbuf *cdup_dir)
> +{
> +	struct config_alias_data data = { STRBUF_INIT, NULL };
> +
> +	strbuf_addf(&data.key, "alias.%s", alias);
> +	if (git_config_key_is_valid(data.key.buf))
> +		read_early_config(config_alias_cb, &data, cdup_dir);
> +	strbuf_release(&data.key);
> +
> +	return data.v;
>  }

Two optional cleanups here:

  1. We don't need to call config_key_is_valid when using a callback. We
     only needed that to prevent the configset machinery from issuing a
     warning. It does save us reading the config entirely when the
     program name is syntactically invalid as an alias, but that's a
     pretty rare case.

  2. Now that we're not using the configset machinery, we don't need to
     have the alias name as a full string. Instead of using the strbuf,
     we could just pass the "alias" string itself and do:

       if (skip_prefix(var, "alias.", &key) && !strcmp(key, data->key))

     in the callback.

I don't think either is a big deal, though.

-Peff
