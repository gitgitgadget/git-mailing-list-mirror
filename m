Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FAF4C433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 20:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 886A361AEC
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 20:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240649AbhKQUXT convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 17 Nov 2021 15:23:19 -0500
Received: from elephants.elehost.com ([216.66.27.132]:63271 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240670AbhKQUXM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 15:23:12 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 1AHKJsRP028347
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 17 Nov 2021 15:19:55 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Jeff King'" <peff@peff.net>, "'Carlo Arenas'" <carenas@gmail.com>
Cc:     "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        <git@vger.kernel.org>
References: <20211116033542.3247094-1-sandals@crustytoothpaste.net> <20211116033542.3247094-2-sandals@crustytoothpaste.net> <YZPOzqU0UQDVA57R@coredump.intra.peff.net> <009d01d7db03$354ecae0$9fec60a0$@nexbridge.com> <YZQzqjWMzaWVkkfP@camp.crustytoothpaste.net> <00e001d7db40$985c61a0$c91524e0$@nexbridge.com> <YZRUzHVS32W4Flo/@camp.crustytoothpaste.net> <CAPUEspiHnTkwbUJ5o+fT2u4Kn+fwNe-3FoqVtNsjTF+Pg6Tryg@mail.gmail.com> <YZRxOrv9JFt2oeSU@coredump.intra.peff.net> <CAPUEsphh-enSYS66mi7_XaS0n1bmUvGXRcgVp6iqhg94xSHVog@mail.gmail.com> <YZVfrhos+lZas7hk@coredump.intra.peff.net>
In-Reply-To: <YZVfrhos+lZas7hk@coredump.intra.peff.net>
Subject: RE: [PATCH 1/2] wrapper: add a helper to generate numbers from a CSPRNG
Date:   Wed, 17 Nov 2021 15:19:49 -0500
Organization: Nexbridge Inc.
Message-ID: <01a501d7dbf0$7c538000$74fa8000$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQHRZsJQSwQVxvA803MGEaqTSKtEHwGUCvbjAr89fOoBugavkgK/mpqhAVhqoPgCDdPdaAHlLlxXAZjWxhgBxETygwKNRf8uq3T5czA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On November 17, 2021 3:02 PM, Jeff King wrote:
> On Tue, Nov 16, 2021 at 07:36:51PM -0800, Carlo Arenas wrote:
> 
> > > > for the little amount of random data we need, it might be wiser to
> > > > fallback to something POSIX like lrand48 which is most likely to
> > > > be available, but of course your tests that consume lots of random
> > > > data will need to change.
> > >
> > > Unfortunately that won't help. You have to seed lrand48 with
> > > something, which usually means pid and/or timestamp. Which are
> > > predictable to an attacker, which was the start of the whole
> > > conversation. You really need _some_ source of entropy, and only the OS
> can provide that.
> >
> > again, showing my ignorance here; but that "something" doesn't need to
> > be guessable externally; ex: git add could use as seed contents from
> > the file that is adding, or even better mix it up with the other
> > sources as a poor man's /dev/urandom
> 
> Those contents are still predictable. So you've made the attacker's job a little
> harder (now they have to block tempfiles for, say, each tag you're going to
> verify), but haven't changed the fundamental problem.
> 
> It definitely would help in _some_ threat models, but I think we should strive
> for a solution that can be explained clearly as "nobody can DoS your
> tempfiles" without complicated qualifications.

I missed this one... lrand48 is also not generally available. I don’t think it is even available on Windows.

If we need a generalized solution, it probably needs to be abstracted in git-compat-util.h and compat/rand.[ch], so that the platform maintainers can plug in whatever decent platform randomization happens to be available, if any. We know that rand() is vulnerable, but it might be the only generally available fallback. Perhaps get the compat layer in place with a test suite that exercises the implementation before getting into the general git code base - maybe based on jitterentropy or sslrng. Agree on an interface, decide on a period of time to implement, send the word out that this needs to get done, and hope for the best. I have code that passes FIPS-140 for NonStop ia64 (-ish although not jitterentropy) and x86, and I'm happy to contribute some of this.

Randall

