Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FEB71F461
	for <e@80x24.org>; Thu, 16 May 2019 05:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfEPFCC (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 01:02:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:59046 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725975AbfEPFCC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 01:02:02 -0400
Received: (qmail 5284 invoked by uid 109); 16 May 2019 05:02:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 16 May 2019 05:02:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27414 invoked by uid 111); 16 May 2019 05:02:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 16 May 2019 01:02:41 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 May 2019 01:02:00 -0400
Date:   Thu, 16 May 2019 01:02:00 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 6/7] config: allow configuration of multiple hook
 error behavior
Message-ID: <20190516050200.GB7241@sigill.intra.peff.net>
References: <20190514002332.121089-1-sandals@crustytoothpaste.net>
 <20190514002332.121089-8-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190514002332.121089-8-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 14, 2019 at 12:23:31AM +0000, brian m. carlson wrote:

> There are a variety of situations in which a user may want an error
> behavior for multiple hooks other than the default. Add a config option,
> hook.<name>.errorBehavior to allow users to customize this behavior on a
> per-hook basis. Provide options for the default behavior (exiting
> early), executing all hooks and succeeding if all hooks succeed, or
> executing all hooks and succeeding if any hook succeeds.

Thanks for using that naming scheme. I think if we do move to allowing
config-based hooks, the config schemes will mesh together well.

> +static int git_default_hook_config(const char *key, const char *value)
> +{
> +	const char *hook;
> +	size_t key_len;
> +	uintptr_t behavior;
> +
> +	key += strlen("hook.");
> +	if (strip_suffix(key, ".errorbehavior", &key_len)) {

There's an undocumented assumption that the caller has confirmed that
the key starts with "hook." here. Can we be a little more defensive and
do:

  if (skip_prefix(key, "hook.", &key))
	return 0;

here (we could even drop the check in git_default_config).

Or we could use parse_key(), which is designed for this:

  if (parse_key(key, "hook", &subsection, &subsection_len, &key) < 0 ||
      !subsection)
	return 0;
  if (!strcmp(key, "errorbehavior"))
	...

> +	/* Use -2 as sentinel because failure to exec is -1. */
> +	int ret = -2;

Maybe this would be simpler to follow by using an enum for the handler
return value?

Aside from these nits, the code looked sensible to me.

-Peff
