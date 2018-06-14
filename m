Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28EB71F403
	for <e@80x24.org>; Thu, 14 Jun 2018 15:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964796AbeFNPPK (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 11:15:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:44454 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1755166AbeFNPPJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 11:15:09 -0400
Received: (qmail 18189 invoked by uid 109); 14 Jun 2018 15:15:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 Jun 2018 15:15:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11859 invoked by uid 111); 14 Jun 2018 15:15:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 14 Jun 2018 11:15:24 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Jun 2018 11:15:07 -0400
Date:   Thu, 14 Jun 2018 11:15:07 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Christian Halstrick <christian.halstrick@gmail.com>,
        Git <git@vger.kernel.org>
Subject: Re: OAuth2 support in git?
Message-ID: <20180614151507.GA6933@sigill.intra.peff.net>
References: <CAENte7iUYcLX1ym1rdiYT2L8yLSWforf8kUvfHKLvhi_GhKQvg@mail.gmail.com>
 <20180614101342.GO38834@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180614101342.GO38834@genre.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 14, 2018 at 10:13:42AM +0000, brian m. carlson wrote:

> > I know that other git server environments like github support that on
> > client side by allowing tokens to be used as usernames in a BASIC
> > authentication flow. We could do the same but I am asking whether
> > there is also a way to transport tokens in a standard conform
> > "Authorization: Bearer ..." Header field.
> 
> There isn't any support for Bearer authentication in Git.  For HTTP, we
> use libcurl, which doesn't provide this natively.  While it could in
> theory be added, it would require some reworking of the auth code.
> 
> You are, of course, welcome to send a patch.

If it's just a custom Authorization header, we should be able to support
it with existing curl versions without _too_ much effort.

I think there are probably two possible directions:

 1. add a special "bearer" command line option, etc, as a string

 2. add a boolean option to send the existing "password" field as a
    "bearer" header

I suspect (2) would fit in with the existing code better, as the special
case would mostly be limited to the manner in which we feed the
credential to curl. And you could probably just set a config option for
"this url's auth will be oauth2", and use the existing mechanisms for
providing the password.

We'd maybe also want to allow credential helpers to say "by the way,
this password should be treated as a bearer token", for cases where you
might sometimes use oauth2 and sometimes a real password.

-Peff
