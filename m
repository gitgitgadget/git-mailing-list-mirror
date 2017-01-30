Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5661B20D13
	for <e@80x24.org>; Mon, 30 Jan 2017 23:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754570AbdA3XhI (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jan 2017 18:37:08 -0500
Received: from cloud.peff.net ([104.130.231.41]:47074 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754526AbdA3XhH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2017 18:37:07 -0500
Received: (qmail 12990 invoked by uid 109); 30 Jan 2017 23:37:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 30 Jan 2017 23:37:07 +0000
Received: (qmail 30890 invoked by uid 111); 30 Jan 2017 23:37:08 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.42.43.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 30 Jan 2017 18:37:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 Jan 2017 00:37:03 +0100
Date:   Tue, 31 Jan 2017 00:37:03 +0100
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     cornelius.weig@tngtech.com, git@vger.kernel.org
Subject: Re: [PATCH v3 2/3] refs: add option core.logAllRefUpdates = always
Message-ID: <20170130233702.o6naszpz32juf5gt@sigill.intra.peff.net>
References: <xmqqvat11k1i.fsf@gitster.mtv.corp.google.com>
 <20170127100948.29408-1-cornelius.weig@tngtech.com>
 <20170127100948.29408-2-cornelius.weig@tngtech.com>
 <xmqq37g0us5p.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq37g0us5p.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 30, 2017 at 01:58:10PM -0800, Junio C Hamano wrote:

> >     When writing the test for git-tag, I realized that the option
> >     --no-create-reflog to git-tag does not take precedence over
> >     logAllRefUpdate=always. IOW the setting cannot be overridden on the command
> >     line. Do you think this is a defect or would it not be desirable to have this
> >     feature anyway?
> 
> "--no-create-reflog" should override the configuration set to "true"
> or "always".  Also "--create-reflog" should override the
> configuration set to "false".
> 
> If the problem was inherited from the original code before your
> change (e.g. you set logAllRefUpdates to true and then did
> "update-ref --no-create-reflog refs/heads/foo".  Does the code
> before your change ignore the command lne option and create a reflog
> for the branch?), then it would be ideal to fix the bug before this
> series as a preparatory fix.  If the problem was introduced by this
> patch set, then we would need a fix not to introduce it ;-)

I hadn't thought about that. I think "git branch --no-create-reflog" has
the same problem in the existing code.

I suspect nobody cares much in practice. Even if you say "don't create a
reflog now", if you have core.logAllRefUpdates turned on, then it's
likely that some _other_ operation will create the reflog later
accidentally (e.g., as soon as you "git checkout foo && git commit",
you'll get a reflog). I think you're fighting an uphill battle to turn
logAllRefUpdates on and then try to disable some reflogs selectively.

So I agree the current behavior is quietly broken, which is not good.
But I wonder if "--no-create-reflog" is really sane in the first place,
and whether we might be better off to simply disallow it.

-Peff
