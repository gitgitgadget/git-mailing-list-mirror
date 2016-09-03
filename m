Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B57A11F6BF
	for <e@80x24.org>; Sat,  3 Sep 2016 18:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753535AbcICSDy (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Sep 2016 14:03:54 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:43403 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753372AbcICSDx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Sep 2016 14:03:53 -0400
Received: from mfilter46-d.gandi.net (mfilter46-d.gandi.net [217.70.178.177])
        by relay4-d.mail.gandi.net (Postfix) with ESMTP id 48378172097;
        Sat,  3 Sep 2016 20:03:51 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter46-d.gandi.net
Received: from relay4-d.mail.gandi.net ([IPv6:::ffff:217.70.183.196])
        by mfilter46-d.gandi.net (mfilter46-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
        with ESMTP id HbjBGxJ5Ky_u; Sat,  3 Sep 2016 20:03:49 +0200 (CEST)
X-Originating-IP: 50.39.163.18
Received: from x (50-39-163-18.bvtn.or.frontiernet.net [50.39.163.18])
        (Authenticated sender: josh@joshtriplett.org)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id B32B41720A9;
        Sat,  3 Sep 2016 20:03:47 +0200 (CEST)
Date:   Sat, 3 Sep 2016 11:03:45 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 9/9] rebase -i: rearrange fixup/squash lines using the
 rebase--helper
Message-ID: <20160903180344.truur5ey6j6ah2wh@x>
References: <cover.1472833365.git.johannes.schindelin@gmx.de>
 <3810bd4bddb3b850a78e5d960207157de64a2e56.1472833365.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3810bd4bddb3b850a78e5d960207157de64a2e56.1472833365.git.johannes.schindelin@gmx.de>
User-Agent: NeoMutt/ (1.7.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 02, 2016 at 06:23:42PM +0200, Johannes Schindelin wrote:
> Let's reimplement this with linear complexity (using a hash map to
> match the commits' subject lines) for the common case; Sadly, the
> fixup/squash feature's design neglected performance considerations,
> allowing arbitrary prefixes (read: `fixup! hell` will match the
> commit subject `hello world`), which means that we are stuck with
> quadratic performance in the worst case.

If the performance of that case matters enough, we can do better than
quadratic complexity: maintain a trie of the subjects, allowing prefix
lookups.  (Or hash all the prefixes, which you can do in linear time on
a string: hash next char, save hash, repeat.)  However, that would
pessimize the normal case of either a complete subject or a sha1, due to
the extra time taken constructing the data structure.  Probably not
worth it, if you assume that most "fixup!" subjects come from `git
commit --fixup` or similar automated means.
