Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A40FDC47083
	for <git@archiver.kernel.org>; Sun, 23 May 2021 20:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6648560BBB
	for <git@archiver.kernel.org>; Sun, 23 May 2021 20:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbhEWT6b (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 May 2021 15:58:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:35132 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231856AbhEWT6b (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 May 2021 15:58:31 -0400
Received: (qmail 16851 invoked by uid 109); 23 May 2021 19:57:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 23 May 2021 19:57:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28577 invoked by uid 111); 23 May 2021 19:57:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 23 May 2021 15:57:04 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 23 May 2021 15:57:03 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Siavash <siavash.askari.nasr@gmail.com>, git@vger.kernel.org
Subject: Re: [Bug] git-credential-netrc.perl is not built and is not
 available in `exec-path`
Message-ID: <YKqzj/DZU8m9AaI/@coredump.intra.peff.net>
References: <87k0nt3f8i.fsf@gmail.com>
 <YKcTFDgW4etXFpOR@camp.crustytoothpaste.net>
 <YKeFxcTDp4tHSRu8@coredump.intra.peff.net>
 <YKgzvFHOcUgPjbj/@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YKgzvFHOcUgPjbj/@camp.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 21, 2021 at 10:27:08PM +0000, brian m. carlson wrote:

> > I agree with this, but just following up with a bit of a devil's
> > advocate: why not put osxkeychain into a regular "make install", but
> > make it conditional via a Makefile knob, like we do for other
> > platform-specific features?
> 
> Sure, let's do it.
> 
> For osxkeychain, it's probably pretty simple to always build it, since
> macOS will always have the appropriate libraries if the compiler is
> installed.

Hmm. So I tried just building oxskeychain in our CI via contrib, and it
fails. :(

It looks like it's OK with clang, but not gcc:

  https://github.com/peff/git/runs/2647748209?check_suite_focus=true

Maybe nobody cares about gcc for this use, but I'm inclined to leave it
to somebody who actually runs macOS to poke at further.

> I would be in favor of also building by default on Linux and
> having a Makefile knob to disable that, since the requisite libraries are
> a part of nearly every distribution and doing so will spur distros to
> ship it, which many do not.

I assume you mean contrib/credential/libsecret here. I'd worry that
flipping it on by default is annoying for people who build from source.
I don't have dev libraries for things like libsecret or glib on my
development system[1], and I'd be surprised if most server-oriented
machines have even the non-dev versions.

Which isn't an argument against making it easier to build them from the
main Makefile, but it seems like having them on by default (with a
NO_LIBSECRET) would cause more surprises than the other way around
(USE_LIBSECRET or similar).

I suspect that just opening a bug report against distro packages might
get some traction (especially if it comes with a patch to create the
extra package). I do wonder if packagers are hesitant to reach into
contrib/, not knowing how well maintained the contents are (to be
honest, I am not confident in how well maintained they are, either; it
might be helpful if somebody who routinely used each helper stepped up
to say that they would maintain it).

-Peff

[1] I was actually surprised I had libsecret installed at all.
    Apparently pinentry-gtk2 links against it, which I have for use with
    gpg. But my system might not be considered typical anyway, as I
    don't use any kind of "desktop environment".
