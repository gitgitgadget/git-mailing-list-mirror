Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B93CC4741F
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 00:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 435C820789
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 00:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbgKJADX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 19:03:23 -0500
Received: from cloud.peff.net ([104.130.231.41]:52190 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727311AbgKJADX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 19:03:23 -0500
Received: (qmail 5097 invoked by uid 109); 10 Nov 2020 00:03:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 10 Nov 2020 00:03:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29173 invoked by uid 111); 10 Nov 2020 00:03:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Nov 2020 19:03:22 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 9 Nov 2020 19:03:22 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v2] t5411: consistent result for proc-receive broken test
Message-ID: <20201110000322.GA687107@coredump.intra.peff.net>
References: <CANYiYbHQKshFg=1xAv8MFfSjmFfQ0uJRm3mQBnZMsTd1n7R-Ow@mail.gmail.com>
 <20201109105846.64303-1-zhiyou.jx@alibaba-inc.com>
 <xmqqh7pyb61f.fsf@gitster.c.googlers.com>
 <20201109231246.GA677345@coredump.intra.peff.net>
 <xmqqk0uu9kuf.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk0uu9kuf.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 09, 2020 at 03:22:32PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I.e., I think the bug is in receive-pack's run_proc_receive_hook().
> 
> I thought that this was merely to work it around and give the
> particular test a reliable failure code, though.  Either way,
> receive-pack will get a failure when the hook fails (either the
> failure message from the hook, or unexpected EOF), so no matter what
> this patch does around this area, it would not affect interactions
> with real-life hooks, I would think.

Yes. Either way receive-pack will fail and won't update any refs, which
is good. The question is whether or not it gives a useful message back
to the client or not. So the tests are exposing an interesting
user-visible behavior, albeit one which we wouldn't expect to come up
much in practice.

> > I think the patch really ought to be in receive-pack, converting
> > packet_write_fmt() and packet_flush() into their "gently" forms.
> 
> That would be a real fix, not "work around flakey tests".  Yes, the
> hook driver roughly mimics run_and_feed_hook() and I suspect it
> started from copy-and-paste from that function, so we might need to
> review that original copy, too.

Good idea. I think it is fine, though. It does all of its writing
through write_in_full(), and breaks out of the write loop on error.
Whereas run_proc_receive_hook() switched to using the packet_*
functions, which by default die on write errors. So I think that's the
root of the problem.

I found it a little curious that run_and_feed_hook() did not complain on
write error, but I think it is explicitly allowing a hook to "exit 0"
immediately without even reading the input. As long as the hook exits
non-zero, we'd still consider that an error (and because we handled the
write error gracefully, we'd do so reliably).  It would be weird if we
saw some _other_ error (EIO or something) while writing, though. I
suspect that's all but impossible for a pipe write like this, but it
wouldn't be wrong to tighten it up, I suppose.

And back to run_proc_receive_hook(), I think it _should_ complain about
a write error, rather than allowing the hook to quietly say "exit 0".
The protocol for the proc-receive hook is more complicated, and we are
looking for an exchange of pkt-lines, and not just "we dumped some data
and it gave us an exit code". So I think it failing to read should
probably be considered a break of that pkt-line protocol.

-Peff
