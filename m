Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DD691F463
	for <e@80x24.org>; Mon, 30 Sep 2019 21:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731972AbfI3VTK (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Sep 2019 17:19:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:35842 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729326AbfI3VTK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Sep 2019 17:19:10 -0400
Received: (qmail 2455 invoked by uid 109); 30 Sep 2019 21:19:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 30 Sep 2019 21:19:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4898 invoked by uid 111); 30 Sep 2019 21:21:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 30 Sep 2019 17:21:44 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 30 Sep 2019 17:19:09 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v4 04/24] merge-recursive: provide a better label for
 diff3 common ancestor
Message-ID: <20190930211909.GA29232@sigill.intra.peff.net>
References: <20190815214053.16594-1-newren@gmail.com>
 <20190817184144.32179-1-newren@gmail.com>
 <20190817184144.32179-5-newren@gmail.com>
 <20190930211437.GA28110@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190930211437.GA28110@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 30, 2019 at 05:14:37PM -0400, Jeff King wrote:

> > This chosen label was perfectly reasonable when recursiveness kicks in,
> > i.e. when there are multiple merge bases.  (I can't think of a better
> > label in such cases.)  But it is actually somewhat misleading when there
> > is a unique merge base or no merge base.  Change this based on the
> > number of merge bases:
> >     >=2: "merged common ancestors"
> >     1:   <abbreviated commit hash>
> >     0:   "<empty tree>"
> 
> I got a funny result from this today while rebasing some patches in
> git.git, where the base is reported as "00000000". I didn't make a
> minimal case, but you can easily reproduce it with:
> 
>   cd /your/git/clone
>   git fetch https://github.com/peff/git odd-diff3-base
>   git checkout -b odd-diff3-base FETCH_HEAD
>   git -c merge.conflictstyle=diff3 rebase --onto origin/master HEAD~2
> 
> Maybe this has to do with "git apply --build-fake-ancestor" being used
> under the hood?

Oh, indeed, this seems to be the case for all rebases. Doing:

  git init repo && cd repo
  
  echo base >file && git add file && git commit -m base
  echo master >file && git commit -am master
  git checkout -b side HEAD^
  echo side >file && git commit -am side
  git config merge.conflictstyle diff3
  
  git rebase master

yields:

  <<<<<<< HEAD
  master
  ||||||| 0000000
  base
  =======
  side
  >>>>>>> side

-Peff
