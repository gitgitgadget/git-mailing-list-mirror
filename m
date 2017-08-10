Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB3631F667
	for <e@80x24.org>; Thu, 10 Aug 2017 22:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753403AbdHJWyg (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 18:54:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:35502 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753391AbdHJWyg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 18:54:36 -0400
Received: (qmail 993 invoked by uid 109); 10 Aug 2017 22:54:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 Aug 2017 22:54:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11322 invoked by uid 111); 10 Aug 2017 22:54:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 Aug 2017 18:54:53 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Aug 2017 18:54:28 -0400
Date:   Thu, 10 Aug 2017 18:54:28 -0400
From:   Jeff King <peff@peff.net>
To:     "Tom G. Christensen" <tgc@jupiterrise.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/4] dropping support for older curl
Message-ID: <20170810225428.jubkaistxz33ykco@sigill.intra.peff.net>
References: <20170809120024.7phdjzjv54uv5dpz@sigill.intra.peff.net>
 <alpine.DEB.2.21.1.1708092337350.11175@virtualbox>
 <20170809214758.p77fqrwxanb4zn5a@sigill.intra.peff.net>
 <873e1f31-2a96-5b72-2f20-a5816cad1b51@jupiterrise.com>
 <20170810213236.dej4ibsag2lxf5w2@sigill.intra.peff.net>
 <fbd7e636-0087-9c2b-746f-e2413c6d2133@jupiterrise.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fbd7e636-0087-9c2b-746f-e2413c6d2133@jupiterrise.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 11, 2017 at 12:23:42AM +0200, Tom G. Christensen wrote:

> > > I just built a pristine 2.14.0 on CentOS 5 with curl 7.15.5. No problems at
> > > all neither with building nor with running the testsuite.
> > 
> > As you can see, this does not compile for me. What's going on?
> > 
> The call site for get_curl_allowed_protocols() in http.c is still protected
> by an #if:
> #if LIBCURL_VERSION_NUM >= 0x071304
>         curl_easy_setopt(result, CURLOPT_REDIR_PROTOCOLS,
>                          get_curl_allowed_protocols(0));
>         curl_easy_setopt(result, CURLOPT_PROTOCOLS,
>                          get_curl_allowed_protocols(-1));
> #else
>         warning("protocol restrictions not applied to curl redirects
> because\n"
>                 "your curl version is too old (>= 7.19.4)");
> #endif
> 
> > I don't see how it could work, as CURLPROTO_HTTP is not defined at all
> > in that version of curl.
> 
> Indeed but the #if will handle that.

Er, sorry if I'm being dense, but how? Are you suggesting that by
removing the callsite of get_curl_allowed_protocols(), the compiler
might elide the now-dead code completely? I could certainly see it being
dropped after the compilation, but I'm surprised that it wouldn't
complain about the undeclared identifiers in the first place.

And if that _is_ what is happening...that seems like a very fragile and
unportable thing to be depending on.

> > Can you please double-check that you're
> > building against the correct version of curl, and that you are building
> > the HTTP parts of Git (which _are_ optional, and the test suite will
> > pass without them).
> 
> I use a mock buildroot and there is no other curl than the vendor supplied
> 7.15.5 installed:
> [...]

OK, thanks for double-checking. I'm still puzzled why your build
succeeds and mine does not.

> > I saw that, too. But as I understand it, they provide no code updates:
> > no bugfixes and no security updates. They just promise to answer the
> > phone and help you with troubleshooting. It's possible my perception is
> > wrong, though; I'm certainly not one of their customers.
> 
> I am refering to the Extended Life-cycle Support product (ELS), which
> promises:
> "the ELS Add-On delivers certain critical-impact security fixes and selected
> urgent priority bug fixes and troubleshooting for the last minor release"
> 
> The full description is here:
> https://access.redhat.com/support/policy/updates/errata#Extended_Life_Cycle_Phase

That was the same page I was looking at. The bit I read was:

  For versions of products in the Extended Life Phase, Red Hat will
  provide limited ongoing technical support. No bug fixes, security
  fixes, hardware enablement or root-cause analysis will be available
  during this phase, and support will be provided on existing
  installations only.

But I missed the bit about the "ELS add-on" below there, which I guess
is an extra thing. I do suspect that "install arbitrary new versions of
Git" is outside of their scope of "urgent priority bug fixes". But in a
sense it doesn't really matter. What is much more interesting is whether
there's a significant population that is running RHEL5 and has a strong
need for newer versions of Git. That I'm not sure about.

-Peff
