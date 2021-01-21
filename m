Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58006C433E6
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 14:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 182EC23A21
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 14:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731320AbhAUOgl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jan 2021 09:36:41 -0500
Received: from cloud.peff.net ([104.130.231.41]:33976 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731520AbhAUOgP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jan 2021 09:36:15 -0500
Received: (qmail 4807 invoked by uid 109); 21 Jan 2021 14:28:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 21 Jan 2021 14:28:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1408 invoked by uid 111); 21 Jan 2021 14:28:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 21 Jan 2021 09:28:45 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 21 Jan 2021 09:28:45 -0500
From:   Jeff King <peff@peff.net>
To:     Martin von Zweigbergk <martinvonz@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        "B. Stebler" <bono.stebler@gmail.com>, git <git@vger.kernel.org>
Subject: Re: Improving merge of tricky conflicts
Message-ID: <YAmPnfb/KMlqimhH@coredump.intra.peff.net>
References: <a0418859-c62e-c207-a1b0-1b1aaf178527@gmail.com>
 <4df975f0-e4b1-afa1-cac1-f38e6d31a0d8@kdbg.org>
 <20200722074530.GB3306468@coredump.intra.peff.net>
 <xmqqmu3r5umr.fsf@gitster.c.googlers.com>
 <20200723182549.GB3975154@coredump.intra.peff.net>
 <CANiSa6iV3WbS9VQdUQ-eF=dcz-mmQXvyckGJL8ZhpgFYc7U_TQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANiSa6iV3WbS9VQdUQ-eF=dcz-mmQXvyckGJL8ZhpgFYc7U_TQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 15, 2021 at 04:50:08PM -1000, Martin von Zweigbergk wrote:

> > > I do this often enough to wonder if I should write a small "filter"
> > > that I can pipe a whole "diff3" <<< ... ||| ... === ... >>> region
> > > to and convert it into to diffs, but not often enough to motivate
> > > me to actually write one ;-).
> >
> > I would definitely have found that useful before (usually when one side
> > made a tiny one-line change and the other side deleted or drastically
> > changed a huge chunk).
> 
> FYI, I added something similar to Mercurial recently. Instead of two
> diffs, it shows one snapshot and one diff. See
> https://phab.mercurial-scm.org/D9551 for details. I've used it for a
> few weeks and it seems to be working pretty well. The drawback is
> mostly when you want to keep the side with the diff and ignore the
> other side, since you'll then have to drop the lines prefixed with "-"
> and then enter column-selection mode or something and delete the first
> character on each remaining line.

I've used the script I posted earlier in the thread several times in the
last 6 months or so, by replacing the conflict markers in the file I'm
resolving with the new output (basically "%!magic-diff3" in vim).

It is helpful. My biggest complaint is cleaning up the diff from the
marker after viewing it. In most cases where it's helpful, one side made
a large change (say, deleting or moving a big chunk of code) and the
other made a small one (tweaking one line in the moved chunk). The small
diff is useful, but the big one is not. And then after having viewed it,
I have to remove the whole big diff in my editor.

(It sounds like yours _replaces_ the conflict marker with the diff,
which is why you have to edit the diff. Mine is showing it in addition,
so you have to delete the diff).

I think rather than thinking of these as expanded conflict markers, it
would probably be a more useful workflow to just look at the diff in a
separate command (so just show the conflicts, not everything else, and
just show the diff). I suspect it could be made pretty nice with some
simple editor support (e.g., open a new buffer in the editor showing the
diff for just the current hunk, or even the current _half_ of the hunk
you're on).

-Peff
