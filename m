Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61DF21F461
	for <e@80x24.org>; Fri, 23 Aug 2019 05:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392064AbfHWF1j (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Aug 2019 01:27:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:53392 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2392025AbfHWF1i (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Aug 2019 01:27:38 -0400
Received: (qmail 12515 invoked by uid 109); 23 Aug 2019 05:27:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 23 Aug 2019 05:27:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29668 invoked by uid 111); 23 Aug 2019 05:28:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 23 Aug 2019 01:28:53 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 23 Aug 2019 01:27:37 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Joel Teichroeb <joel@teichroeb.net>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [BUG] builtin "stash apply" does not refresh index
Message-ID: <20190823052737.GA10592@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Try this:

  # a repo with one file
  git init repo
  cd repo
  echo base >file
  git add file
  git commit -m base

  # now stash a modification
  echo modified >file
  git stash

  # then make the file stat dirty. This will change inode; on systems
  # without inodes, probably "sleep 1; touch file" would work.
  cp file other
  mv other file

  # now try to apply the stash
  git stash apply

The final command gives me:

  error: Your local changes to the following files would be overwritten by merge:
	file
  Please commit your changes or stash them before you merge.
  Aborting

This started with 8a0fc8d19d (stash: convert apply to builtin,
2019-02-25), which is in v2.22.0. Interestingly, do_stash_apply() does
in fact call refresh_cache(). But it looks like we don't ever write it
out to disk. So when we later call merge_recursive(), it presumably uses
the on-disk index, not what we have in memory.

It's not clear to me where the fix should go, though. Should "stash
apply" be writing out the refreshed index before proceeding? Or should
merge_recursive() be more careful about refreshing the index after it
locks it? The former is what happened with stash as a shell script, but
the latter would save us an otherwise pointless write.

I'm also not sure if other parts of stash might have a similar bug due
to the conversion to C. I think it's an easy mistake when converting
"git update-index --refresh" into "refresh_cache()" and then some other
part of the code takes the index lock (and thus looks at that index, not
what we have in memory).

-Peff
