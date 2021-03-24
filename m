Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC8B1C433DB
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 18:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88B5F61A16
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 18:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237686AbhCXSre (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 14:47:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:47758 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237604AbhCXSrB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 14:47:01 -0400
Received: (qmail 14241 invoked by uid 109); 24 Mar 2021 18:47:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 24 Mar 2021 18:47:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20696 invoked by uid 111); 24 Mar 2021 18:47:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 24 Mar 2021 14:47:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 24 Mar 2021 14:47:00 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v4 01/10] userdiff: refactor away the parse_bool()
 function
Message-ID: <YFuJJCSGPXbrt0Mx@coredump.intra.peff.net>
References: <20210224195129.4004-1-avarab@gmail.com>
 <cover-00.11-00000000000-20210324T014604Z-avarab@gmail.com>
 <patch-01.11-fb7346cd296-20210324T014604Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-01.11-fb7346cd296-20210324T014604Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 24, 2021 at 02:48:43AM +0100, Ævar Arnfjörð Bjarmason wrote:

> Since 6680a0874f (drop odd return value semantics from
> userdiff_config, 2012-02-07) we have not cared about the return values
> of parse_tristate() or git_config_bool() v.s. falling through in
> userdiff_config(), so let's do so in those cases to make the code
> easier to read.
> 
> Having a wrapper function for git_config_bool() dates back to
> d9bae1a178 (diff: cache textconv output, 2010-04-01) and
> 122aa6f9c0 (diff: introduce diff.<driver>.binary, 2008-10-05), both of
> which predated the change in 6680a0874f which made their return values
> redundant.

I think this cleanup makes sense.

>  int userdiff_config(const char *k, const char *v)
> @@ -312,16 +305,17 @@ int userdiff_config(const char *k, const char *v)
>  		return parse_funcname(&drv->funcname, k, v, 0);
>  	if (!strcmp(type, "xfuncname"))
>  		return parse_funcname(&drv->funcname, k, v, REG_EXTENDED);
> -	if (!strcmp(type, "binary"))
> -		return parse_tristate(&drv->binary, k, v);
>  	if (!strcmp(type, "command"))
>  		return git_config_string(&drv->external, k, v);
>  	if (!strcmp(type, "textconv"))
>  		return git_config_string(&drv->textconv, k, v);
> -	if (!strcmp(type, "cachetextconv"))
> -		return parse_bool(&drv->textconv_want_cache, k, v);
>  	if (!strcmp(type, "wordregex"))
>  		return git_config_string(&drv->word_regex, k, v);
> +	/* Don't care about the parse errors for these, fallthrough */
> +	if (!strcmp(type, "cachetextconv"))
> +		drv->textconv_want_cache = git_config_bool(k, v);
> +	if (!strcmp(type, "binary"))
> +		parse_tristate(&drv->binary, k, v);

The original returned early, which short-circuited the rest of the
strcmp(). that probably doesn't matter much in practice (after all, an
unrecognized value is inherently O(n)). But perhaps:

  if (...)
     assign...;
  else if (...)
     assign...;

would make the comment unnecessary. I don't feel strongly either way,
though.

-Peff
