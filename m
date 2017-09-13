Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49E7520286
	for <e@80x24.org>; Wed, 13 Sep 2017 12:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751756AbdIMM4O (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 08:56:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:36650 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751120AbdIMM4N (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 08:56:13 -0400
Received: (qmail 6212 invoked by uid 109); 13 Sep 2017 12:56:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Sep 2017 12:56:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13854 invoked by uid 111); 13 Sep 2017 12:56:48 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Sep 2017 08:56:48 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Sep 2017 08:56:11 -0400
Date:   Wed, 13 Sep 2017 08:56:11 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 06/34] clone: release strbuf after use in remove_junk()
Message-ID: <20170913125611.zdy3r5gijz5ohl2r@sigill.intra.peff.net>
References: <20170830175005.20756-1-l.s.r@web.de>
 <20170830175005.20756-7-l.s.r@web.de>
 <xmqq1snj61wr.fsf@gitster.mtv.corp.google.com>
 <0884b528-d455-09c6-0eaf-d2af50077a98@web.de>
 <20170910073002.hg6tqgm2z7owqr2u@sigill.intra.peff.net>
 <7a30c171-22c8-4ae3-3e15-3f4eea893127@web.de>
 <20170910173826.jopzzt5cpc2i3c6m@sigill.intra.peff.net>
 <1c0918c7-8630-e545-6c34-ab03995797bb@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1c0918c7-8630-e545-6c34-ab03995797bb@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 11, 2017 at 11:40:05PM +0200, René Scharfe wrote:

> > Yes, but I didn't want to touch each code site that creates a file,
> > which is a lot more invasive. I expect expanding to 4096 (or PATH_MAX)
> > would be sufficient in practice.
> 
> Perhaps it is in most cases.  Having certainty would be better.  We can
> leave unpack_trees() untouched and instead traverse the tree beforehand,
> in order to find the longest path.  Perhaps we can do something similar
> for init_db().

I wonder if it would be possible to just wrap open() in a transparent
way.

> > I'd also note that the current code isn't _remotely_ async safe and
> > nobody's complained. So I'm perfectly happy doing nothing, too. I care
> > a bit more about the tempfile.c interface because it's invoked a lot
> > more frequently.
> 
> I guess clones are not interrupted very often during checkout; same
> with worktree creation.  So perhaps nasty things could happen with a
> low probability, but nobody tried hard enough to hit that case?

Right, that's my guess. And "nasty" is quite likely to be "deadlocks on
a malloc or stdio lock". Which is not the end of the world.

> > No, I think that's how you'd have to do it. The implementation isn't all
> > that bad, but hitting every file-creation would be invasive. I'd
> > almost rather bail to exec-ing "rm -rf $dir", but we probably can't do
> > _that_ in a signal-handler either. :)
> 
> Well, fork(2), execve(2), and waitpid(2) are on the list, so actually
> you can.
> 
> mingw_spawnvpe(), which is used by start_command() on Windows,
> allocates memory, though.  Preparing environment and argument list
> in advance and just calling CreateProcess() in the signal handler
> might work.

Yeah, I imagine it's do-able with enough advance effort.

Given the lack of reports and the rapidly expanding complexity, I'm not
planning on looking further into this for now.

-Peff
