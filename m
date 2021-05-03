Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6526C433B4
	for <git@archiver.kernel.org>; Mon,  3 May 2021 14:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD1EA61153
	for <git@archiver.kernel.org>; Mon,  3 May 2021 14:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbhECOL0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 10:11:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:43062 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229900AbhECOLW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 10:11:22 -0400
Received: (qmail 5867 invoked by uid 109); 3 May 2021 14:10:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 03 May 2021 14:10:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3934 invoked by uid 111); 3 May 2021 14:10:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 May 2021 10:10:28 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 May 2021 10:10:28 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Daniel Carpenter <dc@ammonit.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: http.sslVersion only specifies minimum TLS version, later
 versions are allowed
Message-ID: <YJAEVMeY9v/j6PeS@coredump.intra.peff.net>
References: <8f664b07d1df45bcb6b3f787f42bd046@ammonit.com>
 <87pmy7x6le.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87pmy7x6le.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 03, 2021 at 03:55:31PM +0200, Ævar Arnfjörð Bjarmason wrote:

> On Mon, May 03 2021, Daniel Carpenter wrote:
> 
> > When I run: "GIT_SSL_VERSION=tlsv1.2 GIT_CURL_VERBOSE=T git clone https://github.com/git/git.git"
> >
> > I see: "SSL connection using TLS1.3 / ECDHE_RSA_AES_128_GCM_SHA256", but I was expecting to see "TLS1.2".
> >
> > This happens because the "sslversions" array (
> > https://github.com/git/git/blob/7e391989789db82983665667013a46eabc6fc570/http.c#L58
> > ) uses "CURL_SSLVERSION_TLSv1_2" which only specifies TLS 1.2 or later
> > ( https://curl.se/libcurl/c/CURLOPT_SSLVERSION.html ).
> >
> > I think configuring "tlsv1.2" should imply "CURL_SSLVERSION_TLSv1_2 |
> > CURL_SSLVERSION_MAX_TLSv1_2", to force that specific version (and the
> > same for "tlsv1.0", "tlsv1.1", "tlsv1.3").
> >
> > For background: I noticed this because of this issue with debian
> > buster https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=987188 . The
> > new libcurl backport enables TLS 1.3 support with gnutls, but it
> > doesn't work for certain operations, so buster applications using a
> > backported libcurl need to explicitly disable TLS 1.3 .
> 
> I think you're right per the documentation, but I wonder if the current
> behavior isn't more useful for most users. I.e. are there really users
> who want exactly 1.2 and not 1.3, 1.4 etc. in the future that aren't
> dealing with an issue like what you're encountering?
> 
> I.e. the "better security in the future by default" seems like a
> better/more common case than "pin to this forever" in this case, no?
> 
> We should of course have a way to pin it, but given the current behavior
> I wonder if we shouldn't just change the documentation, and introduce
> support for e.g. "=tlsv1.1" etc, or a http.pinSSLVersion=tls1.1 or
> something...

Just looking at how the curl binary does it, "--tlsv1.2" means "1.2 or
greater" (which is not at all surprising; the library interface tends to
mirror their command-line and vice versa, and our behavior is influenced
by the library interface here).  But that implies to me that curl folks
considered this and though the "or greater" behavior was useful (which
makes sense -- the main goal is probably to avoid insecurities in older
versions of the protocol).

Anyway, the binary also has --tls-max for capping the maximum version.
That seems more flexible in general than "use this version exactly" (if
you only care that 1.3 is broken, then setting "max=1.2" lets you talk
to servers that support 1.1 or 1.2).

-Peff
