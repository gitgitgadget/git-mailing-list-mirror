Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992D0C77B78
	for <git@archiver.kernel.org>; Sun, 23 Apr 2023 00:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjDWAf5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Apr 2023 20:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjDWAf4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2023 20:35:56 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEB52126
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 17:35:54 -0700 (PDT)
Received: (qmail 22276 invoked by uid 109); 23 Apr 2023 00:35:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 23 Apr 2023 00:35:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6927 invoked by uid 111); 23 Apr 2023 00:35:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 22 Apr 2023 20:35:53 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 22 Apr 2023 20:35:53 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Chris Torek <chris.torek@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/6] string-list: introduce
 `string_list_split_in_place_multi()`
Message-ID: <20230423003553.GA3953216@coredump.intra.peff.net>
References: <cover.1681428696.git.me@ttaylorr.com>
 <cover.1681845518.git.me@ttaylorr.com>
 <6658b231a906dde6acbe7ce156da693ef7dc40e6.1681845518.git.me@ttaylorr.com>
 <20230422111213.GB2969939@coredump.intra.peff.net>
 <8d228041-d473-7f3f-87d7-543b350aab0e@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d228041-d473-7f3f-87d7-543b350aab0e@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 22, 2023 at 05:53:05PM +0200, René Scharfe wrote:

> > Obviously one solution is to add the "runs" option to all variants. But
> > I'd be hesitant to burden existing callers. So I'd propose one of:
> >
> >   1. Make your _1() function public, with a name like _with_options() or
> >      something (though the function name is sadly already quite long).
> >      Leave string_list_split_in_place() as a wrapper that behaves as
> >      now, and have the few new callers use the with_options() variant.
> >
> >   2. Don't bother implementing the "runs" version. The only users would
> >      be test programs, and nobody cares much either way for their cases.
> >      Document in the commit message (and possibly above the function)
> >      that this isn't a strict replacement for strtok(). That would
> >      hopefully be enough for a potential caller to think about the
> >      behavior, and we can add "runs" if and when somebody actually wants
> >      it.
> 
> You can call string_list_remove_empty_items() to get rid of empty
> strings.  And if the single-char version calls a multi-char version
> under the hood then its only advantage is backward compatibility -- but
> converting all callers isn't that hard.  So the only string_list split
> function version you really need accepts multiple delimiters and
> preserves empty items and can be called string_list_split_in_place().

Ooh, I like that. I didn't think of processing after the fact. And
indeed, we have several spots already that do the split/remove_empty
pair.

And yes, it looks like there are only 7 callers which would need a
trivial update if we just switched to the multi-char version.

That's very compelling.

-Peff
