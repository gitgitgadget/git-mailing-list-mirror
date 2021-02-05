Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B995BC433E6
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 09:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7454664F70
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 09:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhBEJCE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 04:02:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:51390 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229706AbhBEJCE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 04:02:04 -0500
Received: (qmail 15183 invoked by uid 109); 5 Feb 2021 09:01:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 05 Feb 2021 09:01:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25967 invoked by uid 111); 5 Feb 2021 09:01:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 05 Feb 2021 04:01:21 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 5 Feb 2021 04:01:20 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] usage: trace2 BUG() invocations
Message-ID: <YB0JYPLMC+hbcxCa@coredump.intra.peff.net>
References: <20210205054914.104640-1-jonathantanmy@google.com>
 <xmqq1rdv2g3q.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1rdv2g3q.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 04, 2021 at 10:17:29PM -0800, Junio C Hamano wrote:

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > die() messages are traced in trace2, but BUG() messages are not. Anyone
> > tracking die() messages would have even more reason to track BUG().
> > Therefore, write to trace2 when BUG() is invoked.
> >
> > Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> > ---
> > This was noticed when we observed at $DAYJOB that a certain BUG()
> > invocation [1] wasn't written to traces.
> >
> > [1] https://lore.kernel.org/git/YBn3fxFe978Up5Ly@google.com/
> > ---
> >  t/helper/test-trace2.c   |  9 +++++++++
> >  t/t0210-trace2-normal.sh | 19 +++++++++++++++++++
> >  usage.c                  |  6 ++++++
> >  3 files changed, 34 insertions(+)
> 
> Sounds like a good idea.  Expert opinions?

I like the overall idea, but it does open the possibility of a BUG() in
the trace2 code looping infinitely.

For instance, injecting this bug:

  diff --git a/trace2/tr2_tgt_event.c b/trace2/tr2_tgt_event.c
  index 6353e8ad91..b386bae402 100644
  --- a/trace2/tr2_tgt_event.c
  +++ b/trace2/tr2_tgt_event.c
  @@ -242,6 +242,7 @@ static void fn_error_va_fl(const char *file, int line, const char *fmt,
          if (fmt && *fmt)
                  jw_object_string(&jw, "fmt", fmt);
          jw_end(&jw);
  +       jw_end(&jw);
   
          tr2_dst_write_line(&tr2dst_event, &jw.json);
          jw_release(&jw);

and running something like:

  GIT_TRACE2_EVENT=1 ./git config --file=does.not.exist --list

currently yields:

  [...a bunch of trace2 lines...]
  Aborted
  BUG: json-writer.c:397: json-writer: too many jw_end(): '{"event":"error",[...etc...]

With this patch it loops forever (well, probably until it runs out of
memory, but I stopped it after one minute and 10G of RAM). ;)

Presumably triggering this in practice would be pretty rare.  But then,
the point of BUG() is to find things we do not expect to happen.

We've had a similar problem on the die() side in the past, and solved it
with a recursion flag. But note it gets a bit non-trivial in the face of
threads. There's some discussion in 1ece66bc9e (run-command: use
thread-aware die_is_recursing routine, 2013-04-16).

That commit talks about a case where "die()" in a thread takes down the
thread but not the whole process. That wouldn't be true here (we'd
expect BUG() to take everything down). So a single counter might be OK
in practice, though I suspect we could trigger the problem racily
Likewise this is probably a lurking problem when other threaded code
calls die(), but we just don't do that often enough for anybody to have
noticed.

-Peff
