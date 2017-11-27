Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A489320A40
	for <e@80x24.org>; Mon, 27 Nov 2017 06:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751108AbdK0GEP (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 01:04:15 -0500
Received: from cloud.peff.net ([104.130.231.41]:41158 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750838AbdK0GEP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 01:04:15 -0500
Received: (qmail 29350 invoked by uid 109); 27 Nov 2017 06:04:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 27 Nov 2017 06:04:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 768 invoked by uid 111); 27 Nov 2017 06:04:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Mon, 27 Nov 2017 01:04:32 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Nov 2017 01:04:12 -0500
Date:   Mon, 27 Nov 2017 01:04:12 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Nathan Neulinger <nneul@neulinger.org>,
        Santiago Torres <santiago@nyu.edu>, git@vger.kernel.org
Subject: [PATCH] git-status.txt: mention --no-optional-locks
Message-ID: <20171127060412.GA1247@sigill>
References: <20171122161014.djkdygmclk227xmq@LykOS.localdomain>
 <dfbf4af3-e87c-bdcb-7544-685572925a50@neulinger.org>
 <20171122202720.GD11671@aiede.mtv.corp.google.com>
 <20171122211729.GA2854@sigill>
 <20171122215635.GE11671@aiede.mtv.corp.google.com>
 <20171122220627.GE2854@sigill>
 <alpine.DEB.2.21.1.1711252240300.6482@virtualbox>
 <20171126192508.GB1501@sigill>
 <alpine.DEB.2.21.1.1711262231250.6482@virtualbox>
 <20171127052443.GB5946@sigill>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171127052443.GB5946@sigill>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 27, 2017 at 12:24:43AM -0500, Jeff King wrote:

> > If people have to ask on the mailing list even after reading the man
> > pages, that's a strong indicator that we could do better.
> 
> Sure. That's why I suggested improving the documentation in my last
> email. But in all the discussion, I haven't seen any patch to that
> effect.

Maybe like this.

-- >8 --
Subject: [PATCH] git-status.txt: mention --no-optional-locks

If you come to the documentation thinking "I do not want Git
to take any locks for my background processes", then you may
easily run across "--no-optional-locks" in git.txt.

But it's quite reasonable to hit a specific instance of the
problem: you have "git status" running in the background,
and you notice that it causes lock contention with other
processes. So you look in git-status.txt to see if there is
a way to disable it, but there's no mention of the flag.

Let's add a short note mentioning that status does indeed
touch the index (and why), with a pointer to the global
option. That can point users in the right direction and help
them make a more informed decision about what they're
disabling.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-status.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index fc282e0a92..81cab9aefb 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -387,6 +387,19 @@ ignored submodules you can either use the --ignore-submodules=dirty command
 line option or the 'git submodule summary' command, which shows a similar
 output but does not honor these settings.
 
+BACKGROUND REFRESH
+------------------
+
+By default, `git status` will automatically refresh the index, updating
+the cached stat information from the working tree and writing out the
+result. Writing out the updated index is an optimization that isn't
+strictly necessary (`status` computes the values for itself, but writing
+them out is just to save subsequent programs from repeating our
+computation). When `status` is run in the background, the lock held
+during the write may conflict with other simultaneous processes, causing
+them to fail. Scripts running `status` in the background should consider
+using `git --no-optional-locks status` (see linkgit:git[1] for details).
+
 SEE ALSO
 --------
 linkgit:gitignore[5]
-- 
2.15.0.687.g5a800c9f78

