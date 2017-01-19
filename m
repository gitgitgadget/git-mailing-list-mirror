Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D502F20A17
	for <e@80x24.org>; Thu, 19 Jan 2017 18:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754084AbdASSNX (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 13:13:23 -0500
Received: from mail.nottheoilrig.com ([52.27.13.164]:39124 "EHLO
        mail.nottheoilrig.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754134AbdASSNW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 13:13:22 -0500
Received: from mail.nottheoilrig.com (localhost [127.0.0.1])
        by mail.nottheoilrig.com (Postfix) with ESMTP id 6EFC520293
        for <git@vger.kernel.org>; Thu, 19 Jan 2017 18:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=nottheoilrig.com;
        s=3532ada; t=1484849524;
        bh=XKIftF6G2pZrEt8u+1+uAo5X57w5uOKb1TMXxZilMXw=;
        h=To:From:Subject:Date:From;
        b=OWB2HU44bDYVJVphDdG4i5dhYbzWnXO/pdS0wbQSeZHBLGLsmysYoDkhs2jSAIPS5
         +IovgIoPO0pFIcnLp8ENHTgE2mzQu/XI+ehLDDhWkdpRt1szWST3mTUs4nrcWI1dxW
         Bn3YHdk06mPZIc0YyRhXKq8UI95Bh4C/lCItQSMw=
Received: from [192.168.0.11] (S0106c8fb26402908.ek.shawcable.net [24.66.132.201])
        by mail.nottheoilrig.com (Postfix) with ESMTPSA
        for <git@vger.kernel.org>; Thu, 19 Jan 2017 18:12:04 +0000 (UTC)
To:     git@vger.kernel.org
From:   Jack Bates <bk874k@nottheoilrig.com>
Subject: grep open pull requests
Message-ID: <276f6ed9-ff06-a00f-b88a-4d40d55c6d40@nottheoilrig.com>
Date:   Thu, 19 Jan 2017 11:12:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have a couple questions around grepping among open pull requests.

First, "git for-each-ref --no-merged": When I run the following,
it lists refs/pull/1112/head, even though #1112 was merged in commit 
ced4da1. I guess this is because the tip of refs/pull/1112/head is 
107fc59, not ced4da1?

This maybe shows my lack of familiarity with Git details,
but superficially the two commits appear identical -- [1] and [2] --
same parent, etc. Nonetheless they have different SHA-1s.
I'm not sure why that is -- I didn't merge the commit --
but regardless, GitHub somehow still connects ced4da1 with #1112.

So my question is, how are they doing that,
and why can't "git for-each-ref --no-merged" likewise
connect ced4da1 with refs/pull/1112/head?

   $ git clone \
   >   --bare \
   >   --config remote.origin.fetch=+refs/pull/*/head:refs/pull/*/head \
   >   https://github.com/apache/trafficserver.git
   $ cd trafficserver.git
   $ git for-each-ref --no-merged


More generally, what I want is to periodically list open pull requests 
that add or modify lines containing the string "memset". So far I have 
the following in a Makefile. Can you recommend any improvements?

.PHONY: all
all: trafficserver.git
	cd trafficserver.git && git fetch
	cd trafficserver.git && git for-each-ref --format '%(refname)' 
refs/pull --no-merged | \
	  while read refname; do \
	    git log -p "master..$$refname" | grep -q '^+.*memset' && echo 
"$$refname"; \
	  done

trafficserver.git:
	git clone \
	  --bare \
	  --config remote.origin.fetch=+refs/pull/*/head:refs/pull/*/head \
	  https://github.com/apache/trafficserver.git


Lastly, a question more about GitHub than Git, but: Given the way GitHub 
is setup, I hope I can get a list of unmerged pull requests from Git 
alone. Can you think of a way to list *open* pull requests,
or is that status only available out of band?

Thanks!


[1] 
https://github.com/apache/trafficserver/commit/107fc59104cce2a4b527f04e7ac86695c98b568c
[2] 
https://github.com/apache/trafficserver/commit/ced4da13279f834c381925f2ecd1649bfb459e8b
