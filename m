Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DCC3C433ED
	for <git@archiver.kernel.org>; Fri, 21 May 2021 10:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B77F6109F
	for <git@archiver.kernel.org>; Fri, 21 May 2021 10:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbhEUKGU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 06:06:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:33236 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229704AbhEUKGT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 06:06:19 -0400
Received: (qmail 3165 invoked by uid 109); 21 May 2021 10:04:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 21 May 2021 10:04:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8047 invoked by uid 111); 21 May 2021 10:04:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 May 2021 06:04:56 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 21 May 2021 06:04:53 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Siavash <siavash.askari.nasr@gmail.com>, git@vger.kernel.org
Subject: Re: [Bug] git-credential-netrc.perl is not built and is not
 available in `exec-path`
Message-ID: <YKeFxcTDp4tHSRu8@coredump.intra.peff.net>
References: <87k0nt3f8i.fsf@gmail.com>
 <YKcTFDgW4etXFpOR@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YKcTFDgW4etXFpOR@camp.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 21, 2021 at 01:55:32AM +0000, brian m. carlson wrote:

> On 2021-05-20 at 09:51:25, Siavash wrote:
> > 
> > which is located in `contrib/credential/netrc`.
> > 
> > If I'm not mistaken, it's because it sets the `SCRIPT_PERL` environment variable here:
> > https://github.com/git/git/blob/88dd4282d949cdafff516650c1be8aaf4d67983f/contrib/credential/netrc/Makefile#L13
> > 
> > But the Git Makefile un-sets environment variables here:
> > https://github.com/git/git/blob/88dd4282d949cdafff516650c1be8aaf4d67983f/Makefile#L587
> > 
> > Also credential helpers in `contrib/credential` are not present in the
> > output of `git help -a`, is that a bug?
> 
> Things in contrib are not built by default because they don't
> necessarily work everywhere.  For example, the osxkeychain credential
> helper won't compile on Linux because the requisite shared libraries
> are specific to macOS.  You'll need to compile them manually and install
> them in a suitable location.

I agree with this, but just following up with a bit of a devil's
advocate: why not put osxkeychain into a regular "make install", but
make it conditional via a Makefile knob, like we do for other
platform-specific features?

The big reason most helpers are in contrib/ is because I wanted them to
be true third-party contributions that do not share any code with Git.
That avoids licensing questions when linking with libraries, and puts
them on an equal footing for people who want to implement a helper for
their favorite obscure tool.

It has lead to a somewhat funny situation, though. I don't really
consider osxkeychain well maintained. It's not built nor tested as part
our regular build. I wrote it long ago, but I never actually _used_ it
day-to-day, as I've never had a mac. It doesn't seem to have gotten any
commits since 2013.

And yet, my impression is that basically every Git user on macOS is
using it every day, because both Apple Git and homebrew build it by
default (and I think at least in the case of Apple Git, it's hard-coded
into the config). A little scary, but nobody seems to have complained. :)

I wonder if we could build it and run it through t0303 as part of the
mac CI process (though I recall at the time that it was really finicky
for automated testing; it wouldn't even run over an ssh session).

Likewise, we probably could be building and testing the libsecret ones
via the Linux CI job (I don't use those either myself, but presumably
they pass t0303).

> Note that that location can be someplace like ~/bin, if that's in your
> PATH.  For example, since the Debian packages don't yet ship the
> libsecret credential helper, I've built it and placed it there.  Now
> that I've done that, git help -a shows git credential-libsecret as an
> option.

One curiosity is that:

  cd contrib/credential/netrc
  make install

builds and installs into .../libexec/git-core. And we don't seem to
include that in "git help -a" (it's not listed in our generated command
list, but nor is it an "external command" found in the $PATH).

-Peff
