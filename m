Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD098C433F5
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 20:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E3AA61100
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 20:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234539AbhITUyT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 16:54:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:51148 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231886AbhITUwQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 16:52:16 -0400
Received: (qmail 2260 invoked by uid 109); 20 Sep 2021 20:50:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 20 Sep 2021 20:50:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22957 invoked by uid 111); 20 Sep 2021 20:50:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 20 Sep 2021 16:50:47 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 20 Sep 2021 16:50:47 -0400
From:   Jeff King <peff@peff.net>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: Trimming 'deadheads' (TREESAME 2nd parent) from revision walks?
Message-ID: <YUj0J+jY0jURkipM@coredump.intra.peff.net>
References: <01fe28d8-2887-bc42-c91b-c3237b5186a7@iee.email>
 <YUeImAqA0SZAdA2R@coredump.intra.peff.net>
 <87k0jcb01k.fsf@evledraar.gmail.com>
 <88dfc31a-187c-6609-0df6-d6b970b1a136@iee.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <88dfc31a-187c-6609-0df6-d6b970b1a136@iee.email>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 20, 2021 at 12:40:21PM +0100, Philip Oakley wrote:

> One thing that catches me, and I think others, is how the 'strategies'
> work. IIUC a merge will look at each line in the diff, and accept any
> change on either side that has no conflicts within the context zone.
> It's only when there are changes from both sides that the selection
> strategy kicks in. But it is difficult to describe, so it's easy to be
> confused.

I think you might be confusing the "ours" strategy (which takes the
tree state of the first parent entirely) with the "ours" (and "theirs")
options of the merge-recursive (or ort) strategy.

You can see the difference with:

  git init repo
  cd repo
  
  echo base >file
  git add file
  git commit -m base
  
  echo main >file
  git add file
  git commit -m main
  
  git checkout -b side HEAD^
  echo side >file
  echo unrelated >another
  git add file another
  git commit -m side
  
  git checkout -b strategy-ours main
  git merge -s ours side
  
  git checkout -b option-ours main
  git merge -X ours side

The strategy-ours merge will drop "another", because it was not in the
first parent. Whereas option-ours will keep it, preferring the
first parent only for the conflict in "file".

You could construct a similar example where instead of a second file,
there's enough content in "file" that some of it does not conflict.

-Peff
