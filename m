Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165E5C12002
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 21:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E03A660230
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 21:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234174AbhGPVM5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 17:12:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:52378 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230084AbhGPVM4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 17:12:56 -0400
Received: (qmail 22030 invoked by uid 109); 16 Jul 2021 21:10:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 16 Jul 2021 21:10:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14532 invoked by uid 111); 16 Jul 2021 21:10:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 16 Jul 2021 17:10:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 16 Jul 2021 17:10:00 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     phillip.wood@dunelm.org.uk, Luca Weiss <luca@z3ntu.xyz>,
        Luca Weiss via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH 2/2] merge: make sure to terminate message with newline
Message-ID: <YPH1qKMPOqhCzp4Y@coredump.intra.peff.net>
References: <pull.1048.git.git.1626421416.gitgitgadget@gmail.com>
 <31371c25743e1001b4fac89e80e7206ff477ac8a.1626421416.git.gitgitgadget@gmail.com>
 <8678772b-dd5d-9188-8b63-98d05cedb323@gmail.com>
 <AB048897-F70A-4388-B2A6-56BFEA40B303@z3ntu.xyz>
 <16229b1d-e4a6-7a8d-8ea0-ae7c3f13075d@gmail.com>
 <YPHe/W7+Oh63NpB0@coredump.intra.peff.net>
 <xmqq8s26q9ot.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8s26q9ot.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 16, 2021 at 01:34:58PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I think we still end up calling cleanup_message() on the result before
> > using it as the final message, and that will fix any missing newline.
> > But we feed the intermediate state before then to the hooks (which is
> > exactly where one might expect to use interpret-trailers).
> >
> > I'm not sure if we should be doing a preemptive call to
> > cleanup_message() before feeding the hooks (we'd still need to do the
> > final one, to clean up whatever the hooks return to us). I guess
> > probably not, because I think that would remove comments, as well. So
> > adding in just the missing newline is probably better.
> 
> To be quite honest, I think this patch is a half-way solution and I
> am not sure if it is better than either of the two "purist"
> extremes:
> 
>  * If the hooks want to see messages with as little loss of
>    information from the original as possible, we should give them
>    without clean-up (which you pointed out above) *and* without this
>    patch.
> 
>  * If the hooks want to see messages as canonicalized as people
>    would see in normal "git log" output, we should be passing the
>    full clean-up to lose even comments and in such a case there is
>    no need for this "always terminate" patch (we'd instead do far
>    more).
> 
> Between the two approaches, both are purists' view, I'd prefer the
> former, but from that stance, the conclusion would become that there
> is no need to do anything, which may be a bit unsatisfactory.

Yes, I agree with all of that (including the "as little loss of
information as possible" preference).

> > Since it will usually be added back in by cleanup_message() anyway, I
> > think it's OK to just add it preemptively. The exception would be if the
> > user asked for no cleanup at all. So making it conditional on
> > cleanup_mode would work, whether -F or not.
> >
> > I suppose that does mean people turning off cleanup mode would get a
> > message without a newline from fmt_merge_msg(), though, which is perhaps
> > unexpected.
> >
> > So maybe just keeping the newline there, as you suggest, is the best
> > way.
> 
> Hmph.
> 
> If the user tells us "refrain from touching my message as much as
> possible" and feeds us a proposed log message that ends with an
> incomplete line, I would think they expect us not to turn it into a
> complete line, and I would think doing this change only when cleanup
> is in effect would make sense.  This is especially true for users
> who do not let any hooks to interfere.  They used to get their
> incomplete lines intact, now their incomplete lines will
> unconditionally get completed.  I am not sure if I would want to
> defend this change from their complaints.

Right, what I was suggesting was:

  if (cleanup_mode != COMMIT_MSG_CLEANUP_NONE)
	strbuf_complete(&msg);

which would cover that case. But Phillip mentioned that our own
fmt_merge_msg() does not include a newline. So it would not be the user
feeding us an incomplete line, but rather Git feeding it. And that was
what I suggested should be corrected (which I suppose would be in
addition to correcting lines from the user).

However, I see a call to strbuf_complete_line() at the end of
fmt_merge_msg(), so I am puzzled about what he meant.

-Peff
