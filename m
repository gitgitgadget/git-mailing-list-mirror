Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFF0C433ED
	for <git@archiver.kernel.org>; Thu, 13 May 2021 07:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A424161439
	for <git@archiver.kernel.org>; Thu, 13 May 2021 07:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbhEMHuU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 03:50:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:53366 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231713AbhEMHuQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 03:50:16 -0400
Received: (qmail 331 invoked by uid 109); 13 May 2021 07:49:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 13 May 2021 07:49:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13982 invoked by uid 111); 13 May 2021 07:49:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 13 May 2021 03:49:08 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 13 May 2021 03:49:05 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Gregory Anders <greg@gpanders.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Subject: Re: [PATCH 0/9] send-email: various optimizations to speed up by >2x
Message-ID: <YJzZ8aSbt4ycX4ZH@coredump.intra.peff.net>
References: <cover-0.9-0000000000-20210512T132955Z-avarab@gmail.com>
 <YJxmmyM9/3KBFPTg@coredump.intra.peff.net>
 <87sg2rrsg1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87sg2rrsg1.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 13, 2021 at 09:37:36AM +0200, Ævar Arnfjörð Bjarmason wrote:

> > My only concern is changing the interface of Git::config_regexp() in the
> > final patch. Do we need to have a config_regexp_with_values() to avoid
> > breaking third-party users of the module?
> 
> As noted in 3/9 I don't think we need to worry about it, it's recently
> introduced (a few months) API in Git.pm for send-email itself. I think
> we can just change it.

Ah, thanks for pointing that out. I _thought_ I had seen you mention it
earlier, but when I went back to look I couldn't find it.

I'm not entirely convinced, though. I agree it's probably not heavily
used, but the existing interface was shipped in three releases already
(v2.29 and up).

> In general I think it's unfortunate that we have (at least in principle)
> a "public by default" module like Git.pm that's mostly for our own use.

I'd certainly agree with that sentiment. :)

> This series doesn't try to deal with that in general at all, I'm
> somewhat of the opinion that we should just fork it at this
> point. I.e. have a Git.pm we freeze in time, and a Git/Ours.pm that's
> going to be the private API.
> 
> I stopped with these optimizations at the point of refactoring away
> Error.pm, which is a large contributor to compilation time, but as long
> as it's a public API that can't be done without changing the public
> API. If all we needed to worry about was send-email, git-svn etc. just
> changing it to Perl-native exceptions would be trivial.

Yeah, I don't have any real problem with that, as long as we don't break
third-party scripts that we've promised not to. I'd even be OK with
deprecating Git.pm and eventually phasing it out, if we think it's a
maintenance burden.

-Peff
