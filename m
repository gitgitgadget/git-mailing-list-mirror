Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2E8D1F597
	for <e@80x24.org>; Sun, 29 Jul 2018 12:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbeG2NtS (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Jul 2018 09:49:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:34542 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726242AbeG2NtS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Jul 2018 09:49:18 -0400
Received: (qmail 3815 invoked by uid 109); 29 Jul 2018 12:19:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 29 Jul 2018 12:19:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9010 invoked by uid 111); 29 Jul 2018 12:19:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 29 Jul 2018 08:19:03 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 29 Jul 2018 08:19:00 -0400
Date:   Sun, 29 Jul 2018 08:19:00 -0400
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: [BUG] fetching sometimes doesn't update refs
Message-ID: <20180729121900.GA16770@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've noticed for the past couple of weeks that some of my fetches don't
seem to actually update refs, but a follow-up fetch will. I finally
managed to catch it in the act and track it down. It bisects to your
989b8c4452 (fetch-pack: put shallow info in output parameter,
2018-06-27). 

A reproduction recipe is below. I can't imagine why this repo in
particular triggers it, but it was the one where I initially saw the
problem (and doing a tiny reproduction does not seem to work). I'm
guessing it has something to do with the refs, since the main change in
the offending commit is that we recompute the refmap.

-- >8 --
# clone the repo as it is today
git clone https://github.com/cmcaine/tridactyl.git
cd tridactyl

# roll back the refs so that there is something to fetch
for i in refs/heads/master refs/remotes/origin/master; do
	git update-ref $i $i^
done

# and delete the now-unreferenced objects, pretending we are an earlier
# clone that had not yet fetched
rm -rf .git/logs
git repack -ad

# now fetch; this will get the objects but fail to update refs
git fetch

# and fetching again will actually update the refs
git fetch
-- 8< --

-Peff
