Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DE871FBB0
	for <e@80x24.org>; Fri,  2 Dec 2016 00:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756114AbcLBAGF (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 19:06:05 -0500
Received: from cloud.peff.net ([104.130.231.41]:50414 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752147AbcLBAGF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 19:06:05 -0500
Received: (qmail 28025 invoked by uid 109); 2 Dec 2016 00:06:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 02 Dec 2016 00:06:05 +0000
Received: (qmail 6836 invoked by uid 111); 2 Dec 2016 00:06:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Dec 2016 19:06:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Dec 2016 19:06:02 -0500
Date:   Thu, 1 Dec 2016 19:06:02 -0500
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH 5/6] http: treat http-alternates like redirects
Message-ID: <20161202000602.xm5gb5gz75hnztki@sigill.intra.peff.net>
References: <20161201090336.xjbb47bublfcpglo@sigill.intra.peff.net>
 <20161201090432.wtcu2jpacwcf6a4a@sigill.intra.peff.net>
 <20161201230223.GI54082@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161201230223.GI54082@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 01, 2016 at 03:02:23PM -0800, Brandon Williams wrote:

> > diff --git a/http.c b/http.c
> > index 825118481..051fe6e5a 100644
> > --- a/http.c
> > +++ b/http.c
> > @@ -745,6 +745,7 @@ static CURL *get_curl_handle(void)
> >  	if (is_transport_allowed("ftps"))
> >  		allowed_protocols |= CURLPROTO_FTPS;
> >  	curl_easy_setopt(result, CURLOPT_REDIR_PROTOCOLS, allowed_protocols);
> > +	curl_easy_setopt(result, CURLOPT_PROTOCOLS, allowed_protocols);
> >  #else
> >  	if (transport_restrict_protocols())
> >  		warning("protocol restrictions not applied to curl redirects because\n"
> 
> Because I don't know much about how curl works....Only
> http/https/ftp/ftps protocols are allowed to be passed to curl?  Is that
> because curl only understands those particular protocols?

No, curl understands more protocols, and that is exactly the problem. We
don't want to accidentally have curl access file://, smtp://, or
similar, based on what some server puts in their http-alternates file.

You should only be able to get to this code-path by calling one of
git-remote-{http,https,ftp,ftps}. So there is no problem with
restricting the protocol beyond those options. And there should be no
problem with restricting within that set; if the protocol we intend to
feed to curl had been disallowed by policy, git would have blocked it
before hitting git-remote in the first place.

-Peff
