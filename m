Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 675ED1F597
	for <e@80x24.org>; Thu,  2 Aug 2018 18:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732189AbeHBUbq (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 16:31:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:40664 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727355AbeHBUbq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 16:31:46 -0400
Received: (qmail 21788 invoked by uid 109); 2 Aug 2018 18:39:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 02 Aug 2018 18:39:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26368 invoked by uid 111); 2 Aug 2018 18:39:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 02 Aug 2018 14:39:26 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Aug 2018 14:39:25 -0400
Date:   Thu, 2 Aug 2018 14:39:25 -0400
From:   Jeff King <peff@peff.net>
To:     Liam Decker <ldecker@indeed.com>
Cc:     git@vger.kernel.org
Subject: Re: Question regarding quarantine environments
Message-ID: <20180802183924.GB23690@sigill.intra.peff.net>
References: <CALcD6sYfcaftciYU+2AHpzabyOS9ohRcZoE6LDuMyht+dxktHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALcD6sYfcaftciYU+2AHpzabyOS9ohRcZoE6LDuMyht+dxktHw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 02, 2018 at 12:58:52PM -0500, Liam Decker wrote:

> I've been working on a git hook in golang recently. However, the library I
> was using did not support a possible quarantine directory, which I would
> use for my hook.
> 
> I have been trying to find out how git finds this incoming directory in the
> objects folder, as their code simply assumed it resided in
> .git/objects/<1st byte>/<last 19 bytes>

When you're running a hook inside the quarantine environment, then
$GIT_OBJECT_DIRECTORY in the environment will be set to the quarantine
directory, and $GIT_ALTERNATE_OBJECT_DIRECTORIES will point to the main
repository object directory (possibly alongside other alternates, if
there were any already set).

Any Git commands you run should therefore find objects from either
location, but any writes would go to the quarantine (most notably, Git's
own index-pack/unpack-objects processes, which is the point of the
quarantine in the first place).

> The solution that I implemented was to check the objects directory for the
> object, and if it was not there, to look for a quarantine directory and try
> there. However, that feels fairly inefficient.

That's more or less what Git will do under the hood (though in the
opposite order).

> For the curious, the library and solution I attempted are both here [5]

Just skimming, but it sounds like go-git does not support the
GIT_OBJECT_DIRECTORY environment variable.

-Peff
