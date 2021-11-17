Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80879C433EF
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 23:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6466D61B3A
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 23:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241627AbhKQXi0 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 17 Nov 2021 18:38:26 -0500
Received: from elephants.elehost.com ([216.66.27.132]:63828 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241632AbhKQXiP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 18:38:15 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 1AHNZ0dp042233
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 17 Nov 2021 18:35:00 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'brian m. carlson'" <sandals@crustytoothpaste.net>
Cc:     "'Jeff King'" <peff@peff.net>,
        "'Carlo Arenas'" <carenas@gmail.com>, <git@vger.kernel.org>
References: <YZPOzqU0UQDVA57R@coredump.intra.peff.net> <009d01d7db03$354ecae0$9fec60a0$@nexbridge.com> <YZQzqjWMzaWVkkfP@camp.crustytoothpaste.net> <00e001d7db40$985c61a0$c91524e0$@nexbridge.com> <YZRUzHVS32W4Flo/@camp.crustytoothpaste.net> <CAPUEspiHnTkwbUJ5o+fT2u4Kn+fwNe-3FoqVtNsjTF+Pg6Tryg@mail.gmail.com> <YZRxOrv9JFt2oeSU@coredump.intra.peff.net> <CAPUEsphh-enSYS66mi7_XaS0n1bmUvGXRcgVp6iqhg94xSHVog@mail.gmail.com> <YZVfrhos+lZas7hk@coredump.intra.peff.net> <01a501d7dbf0$7c538000$74fa8000$@nexbridge.com> <YZWQroXwOKIi8Zs4@camp.crustytoothpaste.net>
In-Reply-To: <YZWQroXwOKIi8Zs4@camp.crustytoothpaste.net>
Subject: RE: [PATCH 1/2] wrapper: add a helper to generate numbers from a CSPRNG
Date:   Wed, 17 Nov 2021 18:34:55 -0500
Organization: Nexbridge Inc.
Message-ID: <01de01d7dc0b$bd3ab050$37b010f0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQK/PXzqamOO2O7k/yYB5n9fLRkz9gG6Bq+SAr+amqEBWGqg+AIN091oAeUuXFcBmNbGGAHERPKDAo1F/y4Bq1AFtQHs+5qZqZ9d1GA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On November 17, 2021 6:31 PM, brian m. carlson wrote:
> To: rsbecker@nexbridge.com
> Cc: 'Jeff King' <peff@peff.net>; 'Carlo Arenas' <carenas@gmail.com>;
> git@vger.kernel.org
> Subject: Re: [PATCH 1/2] wrapper: add a helper to generate numbers from a
> CSPRNG
> 
> On 2021-11-17 at 20:19:49, rsbecker@nexbridge.com wrote:
> > I missed this one... lrand48 is also not generally available. I don’t think it is
> even available on Windows.
> >
> > If we need a generalized solution, it probably needs to be abstracted in git-
> compat-util.h and compat/rand.[ch], so that the platform maintainers can
> plug in whatever decent platform randomization happens to be available, if
> any. We know that rand() is vulnerable, but it might be the only generally
> available fallback. Perhaps get the compat layer in place with a test suite that
> exercises the implementation before getting into the general git code base -
> maybe based on jitterentropy or sslrng. Agree on an interface, decide on a
> period of time to implement, send the word out that this needs to get done,
> and hope for the best. I have code that passes FIPS-140 for NonStop ia64 (-
> ish although not jitterentropy) and x86, and I'm happy to contribute some of
> this.
> 
> I think in this case I'd like to try to stick with OpenSSL or other standard
> interfaces if that's going to meet folks' needs.  I can write an HMAC-DRBG,
> but getting entropy is the tricky part, and jitterentropy approaches are
> controversial because it's not clear how unpredictable they are.  I'm also
> specifically trying to avoid anything that's architecture specific like RDRAND,
> since that means we have to carry assembly code, and on some systems
> RDRAND is broken, which means that you have to test for that and then pass
> the output into another CSPRNG.
> I'm also not sure how maintainable such code is, since I don't think there are
> many people on the list who would be familiar enough with those algorithms
> to maintain it.  Plus there's always the rule, "Don't write your own crypto."
> 
> Using OpenSSL or system-provided interfaces is much, much easier, it means
> users can use Git in FIPS-certified environments, and it avoids us ending up
> with subtly broken code in the future.

I agree wholeheartedly. git in FIPS-certified environments is one of my actual goals - well, in this case, I am a proxy for my customers'. Sticking with OpenSSL would be far preferable to me than basically reimplementing what OpenSSL does. Even OpenSSH uses OpenSSL.

Regards,
Randall

