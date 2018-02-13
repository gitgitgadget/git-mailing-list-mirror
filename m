Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93A241F404
	for <e@80x24.org>; Tue, 13 Feb 2018 16:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934056AbeBMQI1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 11:08:27 -0500
Received: from cloud.peff.net ([104.130.231.41]:50684 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S933764AbeBMQI0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 11:08:26 -0500
Received: (qmail 10533 invoked by uid 109); 13 Feb 2018 16:08:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 13 Feb 2018 16:08:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19337 invoked by uid 111); 13 Feb 2018 16:09:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 13 Feb 2018 11:09:10 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Feb 2018 11:08:24 -0500
Date:   Tue, 13 Feb 2018 11:08:24 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?zqPPgM+Nz4HOv8+CIM6SzrHOts6xzq/Ov8+C?= 
        <sbazaios@gmail.com>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: make git diff output easier to read - use better diff heuristics
Message-ID: <20180213160824.GA5203@sigill.intra.peff.net>
References: <CAOmC-AncOZfAwowXLjwDbL9Bdx1+=RbXsrd72LzEBd2W-=LAQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOmC-AncOZfAwowXLjwDbL9Bdx1+=RbXsrd72LzEBd2W-=LAQg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 13, 2018 at 05:06:15PM +0200, Σπύρος Βαζαίος wrote:

> Hi, I've came across an issue when using the git diff command. In
> particular the diff is different to what the svn diff produces. While
> both being correct the output of the svn diff is easier to understand
> than the git diff one. See the following issue on github where I
> initially reported the issue:
> 
> https://github.com/git-for-windows/git/issues/1494
> 
> I have Included a picture to better illustrate the problem. What do
> you think? Is it possible to make git diff output similar to svn diff
> regarding this issue?

Try "git diff --no-indent-heuristic", which makes your example look
better. Here's a quick reproduction:

-- >8 --
cat >foo.c <<\EOF
static struct foo bar[] = {
#ifdef SOMETHING
	{ "stats.info", MNU_GBX_FSTAINF, etc },
	{ "expired.info", MNU_GBX_FSTAINF, etc },
	{ "info.log", MNU_GBX_INFOLOG, etc },
#endif
	{ NULL, 0, 0 },
};
EOF

sed '6a\
#ifdef WITH_EMU\
	{ "SoftCam.Key", MNU_CFG_FSOFTCAMKEY, etc },\
#endif
' <foo.c >bar.c
-- 8< --

Now this looks ugly:

  git diff --no-index foo.c bar.c

but this does not:

  git diff --no-index --no-indent-heuristic foo.c bar.c

That heuristic is described in 433860f3d0 (diff: improve positioning of
add/delete blocks in diffs, 2016-09-05). I'm not sure exactly why it
does the wrong thing here, or if it would be possible to tweak the
weighting factors to make it work.

-Peff
