Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308B6C76196
	for <git@archiver.kernel.org>; Mon, 10 Apr 2023 20:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjDJUBo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Apr 2023 16:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjDJUBn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2023 16:01:43 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF43D1BF8
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 13:01:42 -0700 (PDT)
Received: (qmail 2806 invoked by uid 109); 10 Apr 2023 20:01:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 10 Apr 2023 20:01:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 541 invoked by uid 111); 10 Apr 2023 20:01:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 10 Apr 2023 16:01:41 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 10 Apr 2023 16:01:41 -0400
From:   Jeff King <peff@peff.net>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>, johncai86@gmail.com
Subject: Re: [Question] Can git cat-file have a type filtering option?
Message-ID: <20230410200141.GB104097@coredump.intra.peff.net>
References: <CAOLTT8RTB7kpabN=Rv1nHvKTaYh6pLR6moOJhfC2wdtUG_xahQ@mail.gmail.com>
 <xmqqy1n3k63p.fsf@gitster.g>
 <CAOLTT8SXXKG3uEd8Q=uh3zx7XeUDUWezGgNUSCd1Fpq-Kyy-2A@mail.gmail.com>
 <ZDIUvK/bF7BFqX5q@nand.local>
 <ZDIgyKDQ2rJT2YEI@nand.local>
 <ZDIiO1HMjej+rnMk@nand.local>
 <CAOLTT8TFiXG1hABFVLp_TOEZ4__s2k4+nvcG3Ax867=LJxOi_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOLTT8TFiXG1hABFVLp_TOEZ4__s2k4+nvcG3Ax867=LJxOi_g@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 09, 2023 at 02:51:34PM +0800, ZheNing Hu wrote:

> > The right thing to do here if you wanted to get a listing of all blobs
> > in your repository regardless of their reachability or whether they are
> > loose or packed is:
> >
> >     git cat-file --batch-check='%(objectname)' --batch-all-objects |
> >     git rev-list --objects --stdin --no-walk --filter='object:type=blob'
> >
> 
> This looks like a mistake. Try passing a tree oid to git rev-list:
> 
> git rev-list --objects --stdin --no-walk --filter='object:type=blob'
> <<< HEAD^{tree}
> 27f9fa75c6d8cdae7834f38006b631522c6a5ac3
> 4860bebd32f8d3f34c2382f097ac50c0b972d3a0 .cirrus.yml
> c592dda681fecfaa6bf64fb3f539eafaf4123ed8 .clang-format
> f9d819623d832113014dd5d5366e8ee44ac9666a .editorconfig
> b0044cf272fec9b987e99c600d6a95bc357261c3 .gitattributes
> ...

This is the expected behavior. The filter options are meant to support
partial clones, and the behavior is really "filter things we'd traverse
to". It is intentional that objects the caller directly asks for will
always be included in the output.

I certainly found that convention confusing, but I imagine it solves
some problems with the lazy-fetch requests themselves. Regardless,
that's how it works and it's not going to change anytime soon. :)

For that reason, and just for general flexibility, I think you are
mostly better off piping cat-file through an external filter program
(and then back to cat-file to get more data on each object).

-Peff
