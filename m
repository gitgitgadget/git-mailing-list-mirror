Return-Path: <SRS0=kKTt=BD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792C9C433DF
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 19:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E9B9206F6
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 19:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgGXTsm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jul 2020 15:48:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:37472 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbgGXTsm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jul 2020 15:48:42 -0400
Received: (qmail 24757 invoked by uid 109); 24 Jul 2020 19:48:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Jul 2020 19:48:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26059 invoked by uid 111); 24 Jul 2020 19:48:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Jul 2020 15:48:41 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Jul 2020 15:48:40 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        "B. Stebler" <bono.stebler@gmail.com>, git@vger.kernel.org
Subject: Re: Improving merge of tricky conflicts
Message-ID: <20200724194840.GA4013174@coredump.intra.peff.net>
References: <a0418859-c62e-c207-a1b0-1b1aaf178527@gmail.com>
 <4df975f0-e4b1-afa1-cac1-f38e6d31a0d8@kdbg.org>
 <20200722074530.GB3306468@coredump.intra.peff.net>
 <xmqqmu3r5umr.fsf@gitster.c.googlers.com>
 <20200723182549.GB3975154@coredump.intra.peff.net>
 <xmqqk0ytn208.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk0ytn208.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 23, 2020 at 06:19:19PM -0700, Junio C Hamano wrote:

> Unfortunately, there is no ">>>>>>>" shown with this code, as $_
> seems to get clobbered before the sub returns, so ...

Ah yeah, thanks for pointing it out (as you might guess I was mainly
looking at the diff output to see if it was broken ;) ).

Your suggested fix is probably what I'd do (I really wish perl localized
$_ automatically when entering new blocks, but I suspect they would
never do so because of compatibility).

> >   my $pre = File::Temp->new;
> >   print $pre @$pre_data;
> 
> I am debating myself if I want to see the base version between these
> two extra diffs.  Perhaps there is no need, as either one of these
> two extra diffs should be sufficient to see what was in the base
> version.

Yeah, I didn't give too much thought to the output, but was afraid of
making it too long and hard to read. In addition to whether to show the
base, I also wondered whether we could omit the "---/+++" header for
each diff. It's mostly boilerplate, and the signal of "hey, this is the
diff between 'base' and 'ours'" could be done on the "|||||||" line
(which also could potentially use a different character to be more
distinct).

I was also tempted to remove the hunk header since the line numbers are
fairly useless. But it is possible for the diff to have multiple hunks,
and you'd still want to show that.

My big challenge now will be remembering to try to use this next time I
run into a conflict that could be helped by it. :)

-Peff
