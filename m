Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8EAA1FD09
	for <e@80x24.org>; Wed, 31 May 2017 21:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751009AbdEaVkV (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 17:40:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:60820 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750952AbdEaVkU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 17:40:20 -0400
Received: (qmail 17143 invoked by uid 109); 31 May 2017 21:40:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 31 May 2017 21:40:20 +0000
Received: (qmail 8932 invoked by uid 111); 31 May 2017 21:40:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 31 May 2017 17:40:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 31 May 2017 17:40:20 -0400
Date:   Wed, 31 May 2017 17:40:20 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Anthony Sottile <asottile@umich.edu>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: bug: `git log --grep ... --invert-grep --author=...` negates /
 ignores --author
Message-ID: <20170531214019.bbhjdaejvgje3v6g@sigill.intra.peff.net>
References: <CA+dzEBn4EKzDqS0pCHHsPtGGJc1orf5weKKh0GN-GkE+fVYGcg@mail.gmail.com>
 <CACBZZX7OhdRM+Mhx4FVX-Upvq169ZLvArL5ZxcTgz8u=WRh3aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX7OhdRM+Mhx4FVX-Upvq169ZLvArL5ZxcTgz8u=WRh3aw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 31, 2017 at 08:08:54PM +0200, Ævar Arnfjörð Bjarmason wrote:

> $ git log --grep=bar --author=Ævar --pretty=format:%an -100 origin/pu
> |sort|uniq -c|sort -nr
> 5 Ævar Arnfjörð Bjarmason
> 
> $ git log --author=Ævar --pretty=format:%an -100 origin/pu |sort|uniq
> -c|sort -nr
> 100 Ævar Arnfjörð Bjarmason
> 
> $ git log --grep=bar --invert-grep --author=Ævar --pretty=format:%an
> -100 origin/pu |sort|uniq -c|sort -nr
>      78 Junio C Hamano
>      14 Jeff King
>       2 Andreas Heiduk
>       1 Sahil Dua
>       1 Rikard Falkeborn
>       1 Johannes Sixt
>       1 Johannes Schindelin
>       1 Ben Peart
>       1 Ævar Arnfjörð Bjarmason
> 
> That last command should only find my commits, but instead --author is
> discarded.

I would have thought that the last command wouldn't find _any_ of your
commits. Don't we consider --author a greppable pattern and invert it?

By itself:

  $ git log --author=Ævar --invert-grep --format=%an -100 origin/pu |
    sort | uniq -c | sort -rn
       79 Junio C Hamano
        8 Stefan Beller
        8 Jeff King
        1 Sahil Dua
        1 Rikard Falkeborn
        1 Johannes Sixt
        1 Johannes Schindelin
        1 Andreas Heiduk

So that makes sense from the "--author is invertable" world-view.

But I'm puzzled that you show up at all when --grep=bar is added (and
moreover, that we get _one_ commit from you, not the 5 found in your
initial command). That seems like a bug.

-Peff
