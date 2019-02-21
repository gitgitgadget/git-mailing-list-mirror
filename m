Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFA9F1F453
	for <e@80x24.org>; Thu, 21 Feb 2019 13:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfBUNWM (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 08:22:12 -0500
Received: from cloud.peff.net ([104.130.231.41]:52482 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725845AbfBUNWM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 08:22:12 -0500
Received: (qmail 20107 invoked by uid 109); 21 Feb 2019 13:22:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 21 Feb 2019 13:22:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12080 invoked by uid 111); 21 Feb 2019 13:22:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 21 Feb 2019 08:22:25 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Feb 2019 08:22:10 -0500
Date:   Thu, 21 Feb 2019 08:22:10 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, hi-angel@yandex.ru, sunshine@sunshineco.com
Subject: Re: [PATCH v2 1/1] worktree add: sanitize worktree names
Message-ID: <20190221132210.GC20536@sigill.intra.peff.net>
References: <20190221110026.23135-1-pclouds@gmail.com>
 <20190221121943.19778-1-pclouds@gmail.com>
 <20190221121943.19778-2-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190221121943.19778-2-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 21, 2019 at 07:19:43PM +0700, Nguyễn Thái Ngọc Duy wrote:

> +/*
> + * worktree name is part of refname and has to pass
> + * check_refname_component(). Remove unallowed characters to make it
> + * valid.
> + */
> +static void sanitize_worktree_name(struct strbuf *name)
> +{
> +	char *orig_name = xstrdup(name->buf);
> +	int i;
> +
> +	/*
> +	 * All special chars replaced with dashes. See
> +	 * check_refname_component() for reference.
> +	 * Note that .lock is also turned to -lock, removing its
> +	 * special status.
> +	 */
> +	for (i = 0; i < name->len; i++) {
> +		if (strchr(":?[]\\~ \t@{}*/.", name->buf[i]))
> +			name->buf[i] = '-';
> +	}

This is reject-known-bad, but I think there are still some other
characters that are not allowed in refnames (e.g., ASCII control
characters). Which would lead to us hitting the BUG() below.

It might make sense to provide access to refname_disposition() and use
it here. Alternatively, I think if we did an allow-known-good, it might
be OK to have a slightly more restrictive scheme (say, alnum plus
dashes, plus high-bit chars).

> +	/* remove consecutive dashes, leading or trailing dashes */
> +	for (i = 0; i < name->len; i++) {
> +		while (name->buf[i] == '-' &&
> +		       (i == 0 ||
> +			i == name->len - 1 ||
> +			(i < name->len - 1 && name->buf[i + 1] == '-')))
> +			strbuf_remove(name, i, 1);
> +	}

I think this is correct, though it is possibly to be quadratic in the
string length due to the O(n) remove. I think this kind of sanitizing is
more readable if done between two strings rather than in-place, like:

  for (i = 0; i < name->len; i++) {
	if (is_allowed(name->buf[i])) {
		strbuf_addch(&dest, name->buf[i]);
		last_was_dash = 0;
	} else if (!last_was_dash && dest->len)
		strbuf_addch(&dest, '-');
		last_was_dash = 1;
	}
  }
  /* still must handle removal from end of stray "-" and ".lock" */
  strbuf_swap(name, &dest);
  strbuf_release(&dest);

but that may just be personal preference. I'm OK with it if you prefer
the in-place way.

-Peff
