Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 110131F404
	for <e@80x24.org>; Tue,  6 Feb 2018 14:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752283AbeBFOO3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 09:14:29 -0500
Received: from cloud.peff.net ([104.130.231.41]:42216 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752223AbeBFOO0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 09:14:26 -0500
Received: (qmail 7411 invoked by uid 109); 6 Feb 2018 14:14:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 06 Feb 2018 14:14:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20011 invoked by uid 111); 6 Feb 2018 14:15:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 06 Feb 2018 09:15:07 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Feb 2018 09:14:23 -0500
Date:   Tue, 6 Feb 2018 09:14:23 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Filip Jorissen <filip.jorissen@kuleuven.be>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Cloned repository has file changes -> bug?
Message-ID: <20180206141423.GA28721@sigill.intra.peff.net>
References: <BCFDB3A3-B515-4932-AC67-F720AEB4B0BE@kuleuven.be>
 <87607nvzrd.fsf@evledraar.gmail.com>
 <20180128075731.GA17412@tor.lan>
 <CD3563ED-5E0D-4238-A664-4F2335598FE2@kuleuven.be>
 <87lgg6l08m.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87lgg6l08m.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 06, 2018 at 02:24:25PM +0100, Ævar Arnfjörð Bjarmason wrote:

>  3) Such hooks slow down pushes, especially on big repos, you can
>     optimize things a bit (e.g. only look in the same directories), but
>     pathologically you end up needing to compare the cross-product of
>     changed files v.s. all existing files for each changed file.

I think you could just complain about any tree that contains entries
that have duplicate entries after normalization. I.e.:

  git rev-list --objects $new --not $old |
  awk '{print $1}' |
  git cat-file --batch-check='%(objecttype) %(objectname)' |
  awk '/^tree/ {print $2}'|
  while read tree; do
	dups=$(git ls-tree $tree | cut -f 2- | tr A-Z a-z | sort | uniq -d)
	test -z "$dups" || echo "$tree has duplicates: $dups"
  done

That gives reasonable algorithmic complexity, but of course the shell
implementation is horrific. One could imagine that this could be
implemented as part of fsck_tree(), though, which is already reading
through all the entries (unfortunately it requires auxiliary storage
linear with the size of a given tree object, but that's not too bad).

But it would probably need:

  1. To be enabled as an optional fsck warning, possibly even defaulting
     to "ignore".

  2. That "tr" could be any arbitrary transformation. Case-folding is
     the obvious one, but in theory you could match the normalization
     behavior of certain popular filesystems.

I'm not entirely convinced it's worth all of this effort, but I think it
would be _possible_ at least.

-Peff
