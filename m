Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6818520248
	for <e@80x24.org>; Tue,  5 Mar 2019 05:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbfCEFL3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 00:11:29 -0500
Received: from cloud.peff.net ([104.130.231.41]:38916 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725818AbfCEFL3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 00:11:29 -0500
Received: (qmail 922 invoked by uid 109); 5 Mar 2019 05:11:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Mar 2019 05:11:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28834 invoked by uid 111); 5 Mar 2019 05:11:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 05 Mar 2019 00:11:45 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Mar 2019 00:11:27 -0500
Date:   Tue, 5 Mar 2019 00:11:27 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] curl: anonymize URLs in error messages and warnings
Message-ID: <20190305051126.GL19800@sigill.intra.peff.net>
References: <pull.156.git.gitgitgadget@gmail.com>
 <ab6f4032cb8cbbe77dbfad4660c30acd7ba688bb.1551713624.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ab6f4032cb8cbbe77dbfad4660c30acd7ba688bb.1551713624.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 04, 2019 at 07:33:46AM -0800, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> Just like 47abd85ba0 (fetch: Strip usernames from url's before storing
> them, 2009-04-17) and later 882d49ca5c (push: anonymize URL in status
> output, 2016-07-13), this change anonymizes URLs (read: strips them of
> user names and especially passwords) in user-facing error messages and
> warnings.

Yeah, these all look obviously correct. I suspect most people haven't
noticed them because it's pretty easy to use a real password helper
these days instead of shoving it into the URL.

> @@ -251,7 +252,7 @@ static struct ref *parse_info_refs(struct discovery *heads)
>  		if (data[i] == '\n') {
>  			if (mid - start != 40)
>  				die("%sinfo/refs not valid: is this a git repository?",
> -				    url.buf);
> +				    transport_anonymize_url(url.buf));

Looking at the code, I think we'd keep the trailing slash during the
anonymization. Good.

> @@ -442,17 +443,23 @@ static struct discovery *discover_refs(const char *service, int for_push)
>  		break;
>  	case HTTP_MISSING_TARGET:
>  		show_http_message(&type, &charset, &buffer);
> -		die("repository '%s' not found", url.buf);
> +		die("repository '%s' not found",
> +		    transport_anonymize_url(url.buf));

Sort of orthogonal to your patch, but these could probably stand to be
marked for translation (I'm happy for that to come on top later,
though).

> -	if (options.verbosity && !starts_with(refs_url.buf, url.buf))
> -		warning(_("redirecting to %s"), url.buf);
> +	if (options.verbosity && !starts_with(refs_url.buf, url.buf)) {
> +		char *u = transport_anonymize_url(url.buf);
> +		warning(_("redirecting to %s"), u);
> +		free(u);
> +	}

Good attention to detail here.

-Peff
