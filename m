Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33113C433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 22:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0296C6321A
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 22:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbhKPWcZ convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 16 Nov 2021 17:32:25 -0500
Received: from elephants.elehost.com ([216.66.27.132]:10327 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbhKPWcY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 17:32:24 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 1AGMTBHD071899
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 16 Nov 2021 17:29:12 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        "'Jeff King'" <peff@peff.net>
Cc:     <git@vger.kernel.org>
References: <20211116033542.3247094-1-sandals@crustytoothpaste.net> <YZPR4Ya1ocWvKbAf@coredump.intra.peff.net> <YZQuDVMRx6hGEbpe@camp.crustytoothpaste.net>
In-Reply-To: <YZQuDVMRx6hGEbpe@camp.crustytoothpaste.net>
Subject: RE: [PATCH 0/2] Generate temporary files using a CSPRNG
Date:   Tue, 16 Nov 2021 17:29:06 -0500
Organization: Nexbridge Inc.
Message-ID: <00c201d7db39$616d4990$2447dcb0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQHRZsJQSwQVxvA803MGEaqTSKtEHwMBSj84AeB0DsSr7JbUMA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On November 16, 2021 5:18 PM, brian m. carlson wrote:
> On 2021-11-16 at 15:44:33, Jeff King wrote:
> > On Tue, Nov 16, 2021 at 03:35:40AM +0000, brian m. carlson wrote:
> >
> > > For those who are interested, I computed the probability of spurious
> > > failure for the self-test mode like so:
> > >
> > >   256 * (255/256)^65536
> > >
> > > This Ruby one-liner estimates the probability at approximately 10^-108:
> > >
> > >   ruby -e 'a = 255 ** 65536; b = 256 ** 65536; puts b.to_s.length -
> a.to_s.length - 3'
> > >
> > > If I have made an error in the calculation, please do feel free to
> > > point it out.
> >
> > Yes, I think your math is correct there.
> >
> > A more interesting question is whether generating 64k of PRNG bytes
> > per test run is going to a problem for system entropy pools. For that
> > matter, I guess the use of it for tempfiles will produce a similar
> > burden, since we run so many commands. My understanding is that
> modern
> > systems will just produce infinite output for /dev/urandom, etc, but I
> > wonder if there are any systems left where that is not true (because
> > they have a misguided notion that they need to stir in more "real"
> > entropy bits).
> 
> I have specifically avoided invoking any sort of potentially blocking CSPRNG
> for that reason.  /dev/urandom is specifically not supposed to block, and on
> the systems that I mentioned, the way Go uses it would indicate that it
> should not.  There is a system, which is Plan 9, where Go uses /dev/random
> to seed an X.917 generator, and there I assume there is no /dev/urandom,
> but I also know full well that we are likely completely broken on Plan 9
> already, so this will be the least of the required fixes.
> 
> RtlGenRandom is non-blocking, and as the commit message mentioned,
> arc4random uses ChaCha20 in a non-blocking way on all systems I could find,
> except MirBSD which uses RC4, also without blocking.  Linux's CSPRNG is also
> non-blocking.
> 
> I've also looked at Rust's getrandom crate, which provides support for
> various other systems, and I have no indication that any of the interfaces I've
> provided are blocking in any way, since that crate would not desire that
> behavior.  Looking at it just now, I did notice that macOS supports
> getentropy, so if I need to do a reroll, I'll add an option for that.
> 
> So I don't think we're likely to run into a problem here.  If we do run into
> systems with that problem, we can add an option to use libbsd, which
> provides arc4random and company (using ChaCha20).  The tricky part is that
> when using libbsd, arc4random is not in <stdlib.h> (since that's a system
> header file) and is instead in <bsd/stdlib.h>.  However, it's an easy change if
> we run into some uncommon system where that's the case.
> 
> If we don't like the test, we can avoid running it by default on the risk of
> seeing breakage go uncaught.

Adding these dependencies are also a problem. libbsd does not port to NonStop. GO is not available yet. Please stay at least somewhat POSIX-like. Begging because I do not want to lose git.
-Randall

