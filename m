Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 080E7C11F64
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 15:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E75646112D
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 15:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233845AbhGAPtv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 11:49:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:38618 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233828AbhGAPtu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 11:49:50 -0400
Received: (qmail 28073 invoked by uid 109); 1 Jul 2021 15:47:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 01 Jul 2021 15:47:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16454 invoked by uid 111); 1 Jul 2021 15:47:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Jul 2021 11:47:19 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 1 Jul 2021 11:47:18 -0400
From:   Jeff King <peff@peff.net>
To:     Martin Langhoff <martin.langhoff@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Structured (ie: json) output for query commands?
Message-ID: <YN3jhlXyTEmoBOon@coredump.intra.peff.net>
References: <CACPiFC++fG-WL8uvTkiydf3wD8TY6dStVpuLcKA9cX_EnwoHGA@mail.gmail.com>
 <CACPiFCLzsiUjx-vm-dcd=0E8HezMWkErPyS==OQ7OhaXqR6CUA@mail.gmail.com>
 <YNyxD4qAHmbluNRe@coredump.intra.peff.net>
 <CACPiFC+F9P1DY_Dgt4+Z-U4o5WRbRduq60+Df0+FHBn6=XL2hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACPiFC+F9P1DY_Dgt4+Z-U4o5WRbRduq60+Df0+FHBn6=XL2hw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 30, 2021 at 02:20:09PM -0400, Martin Langhoff wrote:

> > One complication we faced is that a lot of Git's data is bag-of-bytes,
> 
> Great point -- hadn't thought of that. Don't see anything in
> json-writer.c but we do use iconv already.

We do, but the problem is deeper than that. We don't always know the
intended encoding of bytes in the repository. For commits, there's an
"encoding" header and we default to utf8 if it's not specified. But
filenames in trees do not have an encoding (nor are two entries in a
single tree even required to be in the same encoding). They really are
just sequences of NUL-terminated binary bytes from Git's perspective.

Most of the time that just works, of course. People tend to use utf8
these days anyway. And even if they aren't utf8, as long as the user's
terminal is configured to match, then everything will look OK to them
(you do have to turn off core.quotepath to see any high-bit characters
in filenames).

So in practice I suspect it is fine to just output them as-is in json.
Things will Just Work for people using utf8 consistently. People using
other encodings will have things look OK in their terminal, but probably
JSON parsers would choke. We could provide an option to say "when you
generate json, assume paths are in encoding XYZ (say, latin1) and
convert to utf8". That wouldn't help people who have mix-and-match
encodings in their trees, but that seems even more rare.

-Peff
