Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC22C433ED
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 18:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ABB0613F7
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 18:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbhD3SvK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Apr 2021 14:51:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:41542 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229954AbhD3SvK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Apr 2021 14:51:10 -0400
Received: (qmail 21476 invoked by uid 109); 30 Apr 2021 18:50:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 30 Apr 2021 18:50:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2361 invoked by uid 111); 30 Apr 2021 18:50:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 30 Apr 2021 14:50:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 30 Apr 2021 14:50:20 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        avarab@gmail.com, christian.couder@gmail.com,
        johannes.schindelin@gmx.de, jrnieder@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] urlmatch: do not allow passwords in URLs by default
Message-ID: <YIxRbOh4j9eFxBF3@coredump.intra.peff.net>
References: <pull.945.git.1619807844627.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.945.git.1619807844627.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 30, 2021 at 06:37:24PM +0000, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <dstolee@microsoft.com>
> 
> Git allows URLs of the following pattern:
> 
>   https://username:password@domain/route
> 
> These URLs are then parsed to pull out the username and password for use
> when authenticating with the URL. Git is careful to anonymize the URL in
> status messages with transport_anonymize_url(), but it stores the URL as
> plaintext in the .git/config file. The password may leak in other ways.

I'm not really opposed to disallowing this entirely (with an escape
hatch, as you have here), because it really is an awful practice for a
lot of reasons. But another option we discussed previously was to allow
the initial clone, but not store the password, which would result in the
user being prompted for subsequent fetches:

  https://lore.kernel.org/git/20190519050724.GA26179@sigill.intra.peff.net/

I think that third patch there is just too gross. But with the first
two, if you do have a credential helper configured, then:

  git clone https://user:pass@example.com/repo.git

would do what you want: clone with that user/pass, and then store the
result in the credential helper.

> @@ -191,6 +204,7 @@ static char *url_normalize_1(const char *url, struct url_info *out_info, char al
>  			}
>  			colon_ptr = strchr(norm.buf + scheme_len + 3, ':');
>  			if (colon_ptr) {
> +				die_if_username_password_not_allowed();
>  				passwd_off = (colon_ptr + 1) - norm.buf;
>  				passwd_len = norm.len - passwd_off;
>  				user_len = (passwd_off - 1) - (scheme_len + 3);

It's probably a bit nicer to just ignore the password, which will prompt
the user. But then, it is nicer still to use it just the one time but
not store it in the .git/config file. :)

-Peff
