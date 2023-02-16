Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A4BC61DA4
	for <git@archiver.kernel.org>; Thu, 16 Feb 2023 20:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjBPUqw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Feb 2023 15:46:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjBPUqv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2023 15:46:51 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0129A4B53D
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 12:46:49 -0800 (PST)
Received: (qmail 31586 invoked by uid 109); 16 Feb 2023 20:46:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Feb 2023 20:46:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9713 invoked by uid 111); 16 Feb 2023 20:46:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Feb 2023 15:46:48 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 16 Feb 2023 15:46:48 -0500
From:   Jeff King <peff@peff.net>
To:     tm-uzr3z@entrap.de
Cc:     git@vger.kernel.org
Subject: Re: Bug: git behind proxy is broken in 2.34.1
Message-ID: <Y+6WOF+OHX4u94Z2@coredump.intra.peff.net>
References: <c0862f86061c220af289ce812d57f9c7.squirrel@www.entrap.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c0862f86061c220af289ce812d57f9c7.squirrel@www.entrap.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 16, 2023 at 06:55:42PM +0100, tm-uzr3z@entrap.de wrote:

> I just realized that git cloning behind a webproxy is broken in version
> 2.34.1 (Ubuntu 22.04).
> 
> The environment bash variables http_proxy, https_proxy, HTTP_PROXY and
> HTTPS_PROXY are all set with the value
> "http://myusername:mypassword@ourwebproxy:3128/".
> 
> git gives me the following error message on cloning:
> $git clone https://github.com/XXXX/YYYY
> fatal: unable to access 'https://github.com/XXXX/YYYY/': Received HTTP
> code 407 from proxy after CONNECT

Hmm. We do not have any test coverage for proxies at all. I took a stab
at adding some, and it was not too bad. But...it works!

However, I think there may be a number of possible configurations here.
In my tests, it is an http proxy over http, so it is issuing a GET with
a full URL in it, rather than using CONNECT.

So it may be that CONNECT is broken, but http-over-http proxying is not.
I couldn't get a working CONNECT set up at all (before even worrying
about the authentication step).

> On another very old machine with git 1.9.1 it requests the URL through the
> proxy, receives an http 407 authentication required, and repeats the
> request with credentials, which is allowed then.

That could be good news, as that would mean we might be able to bisect
between 1.9.1 and 2.34.1. However, since you said it was an older
machine, presumably other packages are old, too. I would not be
surprised if the difference is actually in libcurl, not Git.

Still, if you're able to build Git from source and bisect, that would be
worth trying.

-Peff
