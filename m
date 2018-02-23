Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E40AE1F576
	for <e@80x24.org>; Fri, 23 Feb 2018 06:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751413AbeBWGpw (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 01:45:52 -0500
Received: from cloud.peff.net ([104.130.231.41]:33680 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750943AbeBWGpw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 01:45:52 -0500
Received: (qmail 26897 invoked by uid 109); 23 Feb 2018 06:45:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 23 Feb 2018 06:45:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11794 invoked by uid 111); 23 Feb 2018 06:46:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 23 Feb 2018 01:46:39 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Feb 2018 01:45:50 -0500
Date:   Fri, 23 Feb 2018 01:45:50 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?Q?=22Marcel_'childNo=CD=A1=2Ede'_Trautwein=22?= 
        <c0d3+gitscm@childno.de>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: Re: [BUG] [git 2.16.1] yeeek ... my files are gone .. by git pull
 <otherRepositoryUrl>
Message-ID: <20180223064549.GA19791@sigill.intra.peff.net>
References: <741A56BF-93C0-41EA-856F-C1170803F0A7@childno.de>
 <20180222232031.GE256918@aiede.svl.corp.google.com>
 <8A26AAB4-E2E5-4681-87D4-0D6727CA423A@childno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8A26AAB4-E2E5-4681-87D4-0D6727CA423A@childno.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 23, 2018 at 06:29:55AM +0100, "Marcel 'childNo͡.de' Trautwein" wrote:

> shows me a quite different behavior, so solely rebase not seems the full problem
> BUT
> `--rebase=preserve` will .. o’man , really, is this intended?

Yeah, the bug seems to be in --preserve-merges. Here's an easier
reproduction:

  git init
  >one && git add one && git commit -m one
  git checkout --orphan other
  git mv one two && git commit -m two

  git rebase --preserve-merges master

at which point we've dropped commit "two" and its files entirely.

I don't know much about how preserve-merges works. It looks like in the
loop around git-rebase--interactive.sh:931 that we mark commit "two"
with preserve=t, and so we _don't_ add it to the list of commits to
pick.

I think that stems from the fact that it has no parent marked to be
rewritten.

So something like this helps:

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 81c5b42875..71e6cbb388 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -921,15 +921,20 @@ else
 
 		if test -z "$rebase_root"
 		then
 			preserve=t
+			p=
 			for p in $(git rev-list --parents -1 $sha1 | cut -d' ' -s -f2-)
 			do
 				if test -f "$rewritten"/$p
 				then
 					preserve=f
 				fi
 			done
+			if test -z "$p"
+			then
+				preserve=f
+			fi
 		else
 			preserve=f
 		fi
 		if test f = "$preserve"

Because it at least adds "two" to the list of commits to pick. But
oddly, it picks it directly as a root commit again. Whereas a rebase
without --preserve-merges (and even "-i") picks it on top of commit
"one" (which is what I'd expect).

+cc Dscho, as the --preserve-merges guru.

-Peff
