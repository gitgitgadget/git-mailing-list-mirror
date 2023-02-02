Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFAEC636D3
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 00:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjBBAM0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 19:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBBAM0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 19:12:26 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E246AC99
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 16:12:25 -0800 (PST)
Received: (qmail 7152 invoked by uid 109); 2 Feb 2023 00:12:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 02 Feb 2023 00:12:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26024 invoked by uid 111); 2 Feb 2023 00:12:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Feb 2023 19:12:24 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 1 Feb 2023 19:12:23 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     M Hickford via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Cheetham <mjcheetham@outlook.com>,
        Dennington <lessleydennington@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH v2] credential: new attribute password_expiry_utc
Message-ID: <Y9r/59pKKF07pBo4@coredump.intra.peff.net>
References: <pull.1443.git.git.1674914650588.gitgitgadget@gmail.com>
 <pull.1443.v2.git.git.1675244392025.gitgitgadget@gmail.com>
 <Y9pWxHfgPtgCKO+B@coredump.intra.peff.net>
 <xmqq8rhh2tum.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8rhh2tum.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 01, 2023 at 09:12:01AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
> >> index f3c89831d4a..338058be7f9 100644
> >> --- a/builtin/credential-cache--daemon.c
> >> +++ b/builtin/credential-cache--daemon.c
> >> @@ -127,6 +127,9 @@ static void serve_one_client(FILE *in, FILE *out)
> >>  		if (e) {
> >>  			fprintf(out, "username=%s\n", e->item.username);
> >>  			fprintf(out, "password=%s\n", e->item.password);
> >> +			if (e->item.password_expiry_utc != TIME_MAX)
> >> +				fprintf(out, "password_expiry_utc=%"PRItime"\n",
> >> +					e->item.password_expiry_utc);
> >>  		}
> >
> > Is there a particular reason to use TIME_MAX as the sentinel value here,
> > and not just "0"? It's not that big a deal either way, but it's more
> > usual in our code base to use "0" if there's no reason not to (and it
> > seems like nothing should be expiring in 1970 these days).
> 
> This is my fault ;-).  Here, there is no difference between 0 and
> TIME_MAX, but elsewhere the code needed
> 
> 	if (expiry != 0 && expiry < time(NULL))
> 
> to see if the entry has expired.  If the sentinel for an entry that
> will never expire were TIME_MAX, you do not need the first half of
> the expression.
> 
> I am OK either way.

Ah. That at least is a compelling reason to use TIME_MAX. I'm OK with
it.

-Peff
