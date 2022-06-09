Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B255C43334
	for <git@archiver.kernel.org>; Thu,  9 Jun 2022 15:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242903AbiFIP0M (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 11:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238310AbiFIP0K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 11:26:10 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99574614D
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 08:26:08 -0700 (PDT)
Received: (qmail 11260 invoked by uid 109); 9 Jun 2022 15:26:07 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.0.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Jun 2022 15:26:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Date:   Thu, 9 Jun 2022 11:26:07 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Subject: Re: commit-graph overflow generation chicken and egg
Message-ID: <YqIRD8IwUFt6T8p+@coredump.intra.peff.net>
References: <YqD5dgalb9EPnz85@coredump.intra.peff.net>
 <581c7ef2-3de4-eb8a-bfbb-d4bca3522a2d@github.com>
 <220609.86h74utg6j.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220609.86h74utg6j.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 09, 2022 at 09:49:15AM +0200, Ævar Arnfjörð Bjarmason wrote:

> It's certainly interesting to see *how* we got to this state, but just
> so we're on the same page: I fundimentally don't think it matters to the
> *real* bug here.
> 
> Which is that at the very least f90fca638e9 (commit-graph: consolidate
> fill_commit_graph_info, 2021-01-16) and e8b63005c48 (commit-graph:
> implement generation data chunk, 2021-01-16) (CC'd author) have a bad
> regression on earlier fixes that read-only operations of the
> commit-graph *must not die*. I.e. the "parse" and "verify" paths of the
> commit-graph.c code shouldn't call exit(), die() etc.

Yeah, I'd agree that this is a good philosophy to follow. The
commit-graph data is meant to be an optimization, and we can always
continue without it.

> If you replace your graph with Jeff's corrupt one and run "git status",
> "git log" etc. it's still emitting one verbose complaint, but it no
> longer does so in loops (at least for these paths, but e.g. "git gc" is
> still doing that).
> 
> But it does get us to where we can run "git gc", and while complaining
> too much along the way will write out a new & valid commit graph at the
> end ("[... comments are mine"):

Yeah, getting through "git gc" is the key thing here. Then the problem
solves itself, sometimes even automatically (via auto-gc).

-Peff
