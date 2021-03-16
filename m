Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68464C433DB
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 14:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A4CF65081
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 14:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234660AbhCPOot (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 10:44:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:37732 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233841AbhCPOoa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 10:44:30 -0400
Received: (qmail 19265 invoked by uid 109); 16 Mar 2021 14:44:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Mar 2021 14:44:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28377 invoked by uid 111); 16 Mar 2021 14:44:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Mar 2021 10:44:26 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 16 Mar 2021 10:44:26 -0400
From:   Jeff King <peff@peff.net>
To:     Mike Hommey <mh@glandium.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [ANNOUNCE] Git v2.31.0
Message-ID: <YFDESmnZvFZNE4fL@coredump.intra.peff.net>
References: <xmqqwnu8z03c.fsf@gitster.g>
 <20210316051459.oqsl7bhwh6he5cql@glandium.org>
 <875z1rfpmr.fsf@evledraar.gmail.com>
 <20210316091026.wta7wpxdyr75xo6x@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210316091026.wta7wpxdyr75xo6x@glandium.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 16, 2021 at 06:10:26PM +0900, Mike Hommey wrote:

> > > For the record, this is backwards incompatible with git-programs in
> > > $PATH that were expecting the old format (e.g. git-cinnabar releases
> > > using an older version of libgit.a).
> > 
> > What isn't noted there is that we're still parsing the old format in
> > some cases, see f9dbb64fad (config: parse more robust format in
> > GIT_CONFIG_PARAMETERS, 2021-01-12).
> > 
> > But I suspect you mean that you have your own parser that expects the
> > old format only, I didn't find which way it was by grepping
> > git-cinnabar's sources.
> 
> git-cinnabar is using git's libgit.a, so when using a pre-compiled
> version built against git < 2.31.0, it fails to parse
> GIT_CONFIG_PARAMETERS when used with git 2.31.0.
> There's not much I can do apart from releasing a new version.

Yeah, that makes sense. As Ævar noted, we did write it such that people
passing in values would be unaffected. But we couldn't help anybody
_parsing_ the old format. This was a risk we accepted, because it's an
undocumented internal format.

So the "right" thing to do would be for the receiving side to pull the
value out with "git config" (which, presumably running the same version
of Git as the generating side, would do fine). I understand why a
program like git-cinnabar wouldn't want to make a bunch of awkward and
expensive git-config calls. But it's a problem that comes with using the
(also undocumented and not recommended) libgit.a as an interface.

So I am sad to have created headaches, but I also think it should not be
a far-reaching problem.

(I also wondered whether something like libgit2 or jgit might have been
parsing GIT_CONFIG_PARAMETERS, but neither seems to).

-Peff
