Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21961C433EF
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 15:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbiGKPJv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 11:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbiGKPJs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 11:09:48 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7C6747B0
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 08:09:36 -0700 (PDT)
Received: (qmail 8379 invoked by uid 109); 11 Jul 2022 15:09:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 11 Jul 2022 15:09:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20450 invoked by uid 111); 11 Jul 2022 15:09:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 11 Jul 2022 11:09:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 11 Jul 2022 11:09:34 -0400
From:   Jeff King <peff@peff.net>
To:     Michael J Gruber <git@grubix.eu>
Cc:     hanxin.hx@bytedance.com, chiyutianyi@gmail.com,
        derrickstolee@github.com, git@vger.kernel.org,
        haiyangtand@gmail.com, jonathantanmy@google.com, me@ttaylorr.com,
        Junio C Hamano <gitster@pobox.com>, ps@pks.im
Subject: Re: [PATCH v4 1/1] commit-graph.c: no lazy fetch in
 lookup_commit_in_graph()
Message-ID: <Ysw9LmBFGbRy9L7c@coredump.intra.peff.net>
References: <cover.1656381667.git.hanxin.hx@bytedance.com>
 <cover.1656593279.git.hanxin.hx@bytedance.com>
 <96d4bb71505d87ed501c058bbd89bfc13d08b24a.1656593279.git.hanxin.hx@bytedance.com>
 <165736941632.704481.18414237954289110814.git@grubix.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <165736941632.704481.18414237954289110814.git@grubix.eu>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 09, 2022 at 02:23:36PM +0200, Michael J Gruber wrote:

> > +run_with_limited_processses () {
> > +       # bash and ksh use "ulimit -u", dash uses "ulimit -p"
> > +       if test -n "$BASH_VERSION"
> > +       then
> > +               ulimit_max_process="-u"
> > +       elif test -n "$KSH_VERSION"
> > +       then
> > +               ulimit_max_process="-u"
> > +       fi
> > +       (ulimit ${ulimit_max_process-"-p"} 512 && "$@")
> > +}
> 
> This new test fails for me unless I increase max_processes. 1024 works.
> 
> I haven't bisected the number of prcesses ... This is higly system
> dependent. I even run a slim environment (i3wm) but having chrome or
> such running probably makes quite a difference.
> 
> 512 is probably OK in CI in an isolated environment but is too low on a
> typical "What you mean I'm not working? I'm waiting for the test run!"
> developper workstation.
> 
> Conversely, which number would be too high to catch what the test is
> supposed to catch? Does it incur a big performance penalty to go as high
> as possible?

This bit me, too. It works if I run it standalone:

  $ ./t5330-no-lazy-fetch-with-commit-graph.sh 
  ok 1 - setup: prepare a repository with a commit
  ok 2 - setup: prepare a repository with commit-graph contains the commit
  ok 3 - setup: change the alternates to what without the commit
  ok 4 - fetch any commit from promisor with the usage of the commit graph
  # passed all 4 test(s)

but it fails when I run the whole test suite with "prove -j32". Or even
easier, just run it under "--stress":

  $ ./t5330-no-lazy-fetch-with-commit-graph.sh  --stress
  [...]
  + run_with_limited_processses env GIT_TRACE=/home/peff/compile/git/t/trash directory.t5330-no-lazy-fetch-with-commit-graph.stress-30/trace.txt git -C with-commit-graph fetch origin ba19607defe740988a69e98bced331083e02bdd6
error: last command exited with $?=128
not ok 4 - fetch any commit from promisor with the usage of the commit graph

  $ cat trash*.stress-failed/err
  [...]
  error: cannot fork() for index-pack: Resource temporarily unavailable
  fatal: fetch-pack: unable to fork off index-pack

-Peff
