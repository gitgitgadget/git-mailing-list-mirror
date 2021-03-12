Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A836C433DB
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 01:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09BB164F77
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 01:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhCLBbg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 20:31:36 -0500
Received: from cloud.peff.net ([104.130.231.41]:33062 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229606AbhCLBbV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 20:31:21 -0500
Received: (qmail 20034 invoked by uid 109); 12 Mar 2021 01:31:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 12 Mar 2021 01:31:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15846 invoked by uid 111); 12 Mar 2021 01:31:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 11 Mar 2021 20:31:21 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 11 Mar 2021 20:31:20 -0500
From:   Jeff King <peff@peff.net>
To:     John Szakmeister <john@szakmeister.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 0/2] http: store credential when PKI auth is used
Message-ID: <YErEaJ25gY8dzErv@coredump.intra.peff.net>
References: <20210312004842.30697-1-john@szakmeister.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210312004842.30697-1-john@szakmeister.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 11, 2021 at 07:48:40PM -0500, John Szakmeister wrote:

> Here's my second attempt at getting the certificate password into the credential
> store.  I tested from a working PKI setup and found curl--at least reasonable
> recent versions of it--return CURLE_SSL_CERTPROBLEM:
> 
>        CURLE_SSL_CERTPROBLEM (58)
>               problem with the local client certificate.
> 
> It appears there could be another possible error from curl:
> 
>        CURLE_SSL_CONNECT_ERROR (35)
>               A  problem  occurred  somewhere  in the SSL/TLS handshake. You
>               really want the error buffer and read the message there as it
>               pinpoints the problem slightly more. Could be  certificates  (file
>               formats, paths, permissions), passwords, and others.
> 
> This seems less likely to be a bad client password scenario, so I did not look
> for this particular error to reject it.
> 
> I also added one other small patch to remove the check of a non-empty password
> before calling credential_store() for proxy_auth, as credential_store() already
> checks for a non-empty password and gracefully handles it when it doesn't.

Thanks. Both patches look good to me. I wondered briefly if we needed to
worry about old versions of curl missing CURLE_SSL_CERTPROBLEM. But it
seems to have shown up in ~2002, so I think we are fine to assume it's
there.

It would be nice if we had some tests here, but we currently do not
cover any of the ssl-cert stuff in the test suite. I suspect adding them
would be a big pain to configure and maintain, so I'm OK to leave it off
for now. Hopefully you gave it some basic manual testing with your
working setup (good password is stored, bad password is rejected).

Looking at how we generate the server-side cert for our http tests, we
could _probably_ do something similar for a client-side cert, and just
configure the server to accept a self-signed certificate. But like I
said, I'm OK to leave that for another series (though of course if you
want to work on it, that would be very much appreciated).

-Peff
