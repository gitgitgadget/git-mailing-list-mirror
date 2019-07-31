Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DCF71F732
	for <e@80x24.org>; Wed, 31 Jul 2019 05:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbfGaFhF (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 01:37:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:56536 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726798AbfGaFhF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 01:37:05 -0400
Received: (qmail 11713 invoked by uid 109); 31 Jul 2019 05:37:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 31 Jul 2019 05:37:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13940 invoked by uid 111); 31 Jul 2019 05:38:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 31 Jul 2019 01:38:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 31 Jul 2019 01:37:04 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Gregory Szorc <gregory.szorc@gmail.com>, Eric Wong <e@80x24.org>,
        git@vger.kernel.org
Subject: [PATCH 0/3] handling warnings due to auto-enabled bitmaps
Message-ID: <20190731053703.GA16709@sigill.intra.peff.net>
References: <qhdnuh$5m5r$1@blaine.gmane.org>
 <20190729100745.GA2755@sigill.intra.peff.net>
 <87v9vl57in.fsf@evledraar.gmail.com>
 <20190731042807.GA26237@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190731042807.GA26237@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 31, 2019 at 12:28:07AM -0400, Jeff King wrote:

> On Mon, Jul 29, 2019 at 02:50:56PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> > > Instead, it may make sense to turn the --write-bitmap-index option of
> > > pack-objects into a tri-state: true/false/auto. Then pack-objects would
> > > know that we are in best-effort mode, and would avoid warning in that
> > > case. That would also let git-repack express its intentions better to
> > > git-pack-objects, so we could replace 7328482253, and keep more of the
> > > logic in pack-objects, which is ultimately what has to make the decision
> > > about whether it can generate bitmaps.
> > 
> > Sounds like pentastate to me :) (penta = 5, had to look it up). I.e. in
> > most cases of "auto" we pick a true/false at the outset, whereas this is
> > true/true-but-dont-care-much/false/false-but-dont-care-much with "auto"
> > picking the "-but-dont-care-much" versions of a "soft" true/false.
> 
> I don't think we care about false-but-dont-care-much. Pack-objects just
> needs to know whether the bitmaps are the user's expressed intention, or
> just something that it should do if it's convenient.
> 
> I'll see if I can work up a patch to demonstrate.

This actually turned out pretty well, I think. I wish I had thought of
it when were initially looking at the .keep stuff. :) It was not too
hard to clean that up in the third patch, though.

  [1/3]: t7700: clean up .keep file in bitmap-writing test
  [2/3]: repack: silence warnings when auto-enabled bitmaps cannot be built
  [3/3]: repack: simplify handling of auto-bitmaps and .keep files

 builtin/pack-objects.c | 21 ++++++++++++++++-----
 builtin/repack.c       | 24 +++++++-----------------
 t/t7700-repack.sh      | 15 ++++++++++++++-
 3 files changed, 37 insertions(+), 23 deletions(-)

