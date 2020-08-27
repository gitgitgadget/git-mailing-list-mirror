Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BBAC433E7
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 23:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49BCA20872
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 23:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbgH0Xe5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 19:34:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:43216 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727954AbgH0Xez (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 19:34:55 -0400
Received: (qmail 20450 invoked by uid 109); 27 Aug 2020 23:34:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 27 Aug 2020 23:34:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 899 invoked by uid 111); 27 Aug 2020 23:34:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 27 Aug 2020 19:34:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 27 Aug 2020 19:34:54 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2020, #07; Thu, 27)
Message-ID: <20200827233454.GA3973432@coredump.intra.peff.net>
References: <xmqqh7snpxy1.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh7snpxy1.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 27, 2020 at 02:43:02PM -0700, Junio C Hamano wrote:

> * tb/repack-clearing-midx (2020-08-26) 1 commit
>   (merged to 'next' on 2020-08-27 at a465875cbb)
>  + builtin/repack.c: invalidate MIDX only when necessary
> 
>  When a packfile is removed by "git repack", multi-pack-index gets
>  cleared; the code was taught to do so less aggressively by first
>  checking if the midx actually refers to a pack that no longer
>  exists.
> 
>  Will merge to 'master'.

This seems to break t7700 when run with midx support:

  $ git checkout e08f7bb093
  HEAD is now at e08f7bb093 builtin/repack.c: invalidate MIDX only when necessary

  $ make && (cd t && GIT_TEST_MULTI_PACK_INDEX=1 ./t7700-repack.sh -i)
  [...]
  + git repack -a -d
  Enumerating objects: 10, done.
  Counting objects: 100% (10/10), done.
  Delta compression using up to 16 threads
  Compressing objects: 100% (5/5), done.
  Writing objects: 100% (10/10), done.
  Total 10 (delta 1), reused 10 (delta 1), pack-reused 0
  fatal: error preparing packfile from multi-pack-index
  error: last command exited with $?=128
  not ok 6 - packed obs in alt ODB are repacked when local repo has packs
  #	
  #		rm -f .git/objects/pack/* &&
  #		echo new_content >>file1 &&
  #		git add file1 &&
  #		test_tick &&
  #		git commit -m more_content &&
  #		git repack &&
  #		git repack -a -d &&
  #		test_no_missing_in_packs

I didn't look into whether it's a bug in the actual code, or just a
weird interaction with the way GIT_TEST_MULTI_PACK_INDEX triggers
git-repack to write a midx. But either way we should figure that out
before it graduates.

-Peff
