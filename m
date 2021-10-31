Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46439C433F5
	for <git@archiver.kernel.org>; Sun, 31 Oct 2021 08:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1952260C40
	for <git@archiver.kernel.org>; Sun, 31 Oct 2021 08:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbhJaI42 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 31 Oct 2021 04:56:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:50490 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229525AbhJaI41 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Oct 2021 04:56:27 -0400
Received: (qmail 28574 invoked by uid 109); 31 Oct 2021 08:53:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 31 Oct 2021 08:53:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8386 invoked by uid 111); 31 Oct 2021 08:53:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 31 Oct 2021 04:53:58 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 31 Oct 2021 04:53:55 -0400
From:   Jeff King <peff@peff.net>
To:     Dongsheng Song <dongsheng.song@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: timezone related bug of git
Message-ID: <YX5Zo9uV7qG73p6R@coredump.intra.peff.net>
References: <CAE8XmWpK0ubcTXOaxBKGKh1qU+73Rr181wMAM7KAAX_A5PEYOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE8XmWpK0ubcTXOaxBKGKh1qU+73Rr181wMAM7KAAX_A5PEYOw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 31, 2021 at 11:23:24AM +0800, Dongsheng Song wrote:

>  I found a timezone related bug in the git:
> 
> 1. git log 11990eba -1 --date=format:%s
> 
> commit 11990eba0be50d1ad0655ede4062b7130326c41f (HEAD -> trunk,
> origin/trunk, origin/HEAD)
> Author: rillig <rillig@NetBSD.org>
> Date:   1635604878
> 
>     indent: move debugging functions to a separate section
> 
> 2. git cat-file -p 11990eba
> 
> tree 5d62150f5e2bafd3db76641450ca5d902302a039
> parent 892557a74bd49983fac28366b772b53c9216ca73
> author rillig <rillig@NetBSD.org> 1635633678 +0000
> committer rillig <rillig@NetBSD.org> 1635633678 +0000
> 
> indent: move debugging functions to a separate section
> 
> 3. conclusion
> 
> The unix time stored in git repository not same as the git log output,
> then there must be a timezone offset bug:
> 
> 1635633678 - 1635604878 = 28800 = 8 hours (local timezone offset)

The short answer is: don't do that. Use --date=unix instead.

The longer one is:

The problem is that the strftime() "%s" specifier is a bit broken.
That function (which is what is interpreting your format) takes a
broken-down "struct tm", which can only be converted back to an epoch
time if you know which time zone it's in.

But we have no way to tell the function that; the standard indicates
that it always assumes the local system timezone, and there's no
provision at all for formatting times in other zones (which is what we
usually try to do, showing the date in the author's zone). There's no
field in the "struct tm" to carry any zone information[1].

Even when you're in the same timezone, there's a similar problem with
the is_dst field. There's some discussion in [2], including the
possibility of intercepting "%s" and handling it ourselves, like we do
for "%z". I don't think anybody has cared enough to work on it.

-Peff

[1] Some implementations (like glibc) actually _do_ carry this
    information in private fields of "struct tm". But we can't rely on
    it, and even where it's available, it's confusing (e.g., mktime()
    ignores it!). If you're a real masochist, you can read all of:

      https://lore.kernel.org/git/22824.29946.305300.380299@a1i15.kph.uni-mainz.de/

[2] This is a similar bug report from 2020:

      https://lore.kernel.org/git/CAGqZTUu2U6FFXGTXihC64O0gB5Bz_Z3MbD750kMoJWMciAGH6w@mail.gmail.com/
