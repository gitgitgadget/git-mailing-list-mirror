Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D2ED202AB
	for <e@80x24.org>; Wed,  5 Jul 2017 08:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751833AbdGEIgP (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jul 2017 04:36:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:59866 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751654AbdGEIgO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2017 04:36:14 -0400
Received: (qmail 23175 invoked by uid 109); 5 Jul 2017 08:36:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 05 Jul 2017 08:36:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6022 invoked by uid 111); 5 Jul 2017 08:36:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 05 Jul 2017 04:36:23 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Jul 2017 04:36:11 -0400
Date:   Wed, 5 Jul 2017 04:36:11 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Konstantin Khomoutov <kostix+git@007spb.ru>,
        Git ML <git@vger.kernel.org>
Subject: Re: Should "head" also work for "HEAD" on case-insensitive FS?
Message-ID: <20170705083611.jgxbp4sqogicfwdb@sigill.intra.peff.net>
References: <87ziclb2pa.fsf@gmail.com>
 <20170704071909.phs4bf5ybdord2lv@tigra>
 <87van8boe9.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87van8boe9.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 04, 2017 at 10:24:30AM +0200, Ævar Arnfjörð Bjarmason wrote:

> I.e. we allow any arbitrary ref sitting in .git/, but presumably we
> could just record the original string the user provided so that this
> dies on OSX/Windows too:
> 
>     $ cp .git/{HEAD,Whatever}
>     $ git rev-parse wHATEVER
>     wHATEVER
>     fatal: ambiguous argument 'wHATEVER': unknown revision or path not in the working tree.
> 
> But this may be a much deeper rabbit hole than I initially thought, I
> was fishing to see if someone knew of a place in the code or WIP patch
> that dealt with these special refs, but between the low-level machinery
> & sha1_name.c (and others) there may be no easy one place to do this...

I think we talked at one point about allowing only [A-Z_] for top-level
refs. My recollection is that it generally seemed like a good idea, but
I don't think we ever had patches.

I think it would work to enforce it via check_refname_format(). That
would catch reading via dwim_ref(), which is what your example is
hitting. But it should also prevent people from writing ".git/foo" (or
worse, ".git/config") as a ref.

I do think that's the tip of the iceberg for case-sensitivity problems
with refs, though. Because packed-refs is case-sensitive, I think you
can create some pretty confusing states on case-insensitive filesystems.
For example:

  http://public-inbox.org/git/20150825052123.GA523@sigill.intra.peff.net/

Ultimately I think the path forward is to have a ref backend that
behaves uniformly (either because it avoids the filesystem, or because
it encodes around the differences). See:

  http://public-inbox.org/git/xmqqvb4udyf9.fsf@gitster.mtv.corp.google.com/

and its reply.

-Peff
