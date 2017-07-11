Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E62EC20357
	for <e@80x24.org>; Tue, 11 Jul 2017 07:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755279AbdGKHZk (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 03:25:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:36612 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754269AbdGKHZj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 03:25:39 -0400
Received: (qmail 27807 invoked by uid 109); 11 Jul 2017 07:25:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Jul 2017 07:25:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13514 invoked by uid 111); 11 Jul 2017 07:25:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Jul 2017 03:25:51 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Jul 2017 03:25:37 -0400
Date:   Tue, 11 Jul 2017 03:25:37 -0400
From:   Jeff King <peff@peff.net>
To:     Andreas Krey <a.krey@gmx.de>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        Git Users <git@vger.kernel.org>
Subject: [BUG] detached auto-gc does not respect lock for 'reflog expire',
 was Re: Flurries of 'git reflog expire'
Message-ID: <20170711072536.ijpldg4uxb5pbtdw@sigill.intra.peff.net>
References: <20170704075758.GA22249@inner.h.apk.li>
 <20170705082027.ujddejajjlvto7bp@sigill.intra.peff.net>
 <20170706133124.GB1216@inner.h.apk.li>
 <CAGyf7-FnaWM=XNb_Skb1qR4vu_jAw-5swkgWpEDQqwM0NNq3YQ@mail.gmail.com>
 <20170711044553.GG3786@inner.h.apk.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170711044553.GG3786@inner.h.apk.li>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[Updating the subject since I think this really is a bug].

On Tue, Jul 11, 2017 at 06:45:53AM +0200, Andreas Krey wrote:

> > I also want to add that Bitbucket Server 5.x includes totally
> > rewritten GC handling. 5.0.x automatically disables auto GC in all
> > repositories and manages it explicitly, and 5.1.x fully removes use of
> > "git gc" in favor of running relevant plumbing commands directly.
> 
> That's the part that irks me. This shouldn't be necessary - git itself
> should make sure auto GC isn't run in parallel. Now I probably can't
> evaluate whether a git upgrade would fix this, but given that you
> are going the do-gc-ourselves route I suppose it wouldn't.

It's _supposed_ to take a lock, even in older versions. See 64a99eb47
(gc: reject if another gc is running, unless --force is given,
2013-08-08).

But it looks like before we take that lock, we sometimes run pack-refs
and reflog expire. This is due to 62aad1849 (gc --auto: do not lock refs
in the background, 2014-05-25). IMHO this is buggy; it should be
checking the lock before calling gc_before_repack() and daemonizing.

Annoyingly, the lock code interacts badly with daemonizing because that
latter will fork to a new process. So the simple solution like:

diff --git a/builtin/gc.c b/builtin/gc.c
index 2ba50a287..79480124a 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -414,6 +414,9 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 			if (report_last_gc_error())
 				return -1;
 
+			if (lock_repo_for_gc(force, &pid))
+				return 0;
+
 			if (gc_before_repack())
 				return -1;
 			/*

means that anybody looking at the lockfile will report the wrong pid
(and thus think the lock is invalid). I guess we'd need to update it in
place after daemonizing.

-Peff
