Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20F08207EC
	for <e@80x24.org>; Thu,  6 Oct 2016 16:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S942352AbcJFQHy (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 12:07:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:53456 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S942349AbcJFQHt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 12:07:49 -0400
Received: (qmail 19755 invoked by uid 109); 6 Oct 2016 16:01:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 06 Oct 2016 16:01:07 +0000
Received: (qmail 29153 invoked by uid 111); 6 Oct 2016 16:01:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 06 Oct 2016 12:01:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Oct 2016 12:01:04 -0400
Date:   Thu, 6 Oct 2016 12:01:04 -0400
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        git <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
        Martin-Louis Bright <mlbright@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v8 00/11] Git filter protocol
Message-ID: <20161006160104.nhpxhfhketr4rb4h@sigill.intra.peff.net>
References: <C2C9761E-986F-473D-BFB7-CBEF900D9FA3@gmail.com>
 <f7a4f828-bb1d-0ffa-e369-3b4fa476d9e5@web.de>
 <xmqqk2duhcdm.fsf@gitster.mtv.corp.google.com>
 <1A8A9127-4DF9-44AD-9497-F8A630AB1193@gmail.com>
 <xmqq60pee6rp.fsf@gitster.mtv.corp.google.com>
 <C53500E8-7352-4AAC-9F53-40CCFA7F1418@gmail.com>
 <15ff438f-ec58-e649-b927-b1de4751cc45@gmail.com>
 <E9946E9F-6EE5-492B-B122-9078CEB88044@gmail.com>
 <f7f9ca4c-229c-390a-beb0-a58e0d3d66b3@gmail.com>
 <5C30800A-C821-4B39-BEB7-7D55D86BD7EA@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5C30800A-C821-4B39-BEB7-7D55D86BD7EA@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 06, 2016 at 03:13:19PM +0200, Lars Schneider wrote:

> >>> Well, it would be good to tell users _why_ Git is hanging, see below.
> >> 
> >> Agreed. Do you think it is OK to write the message to stderr?
> > 
> > On the other hand, this is why GIT_TRACE (and GIT_TRACE_PERFORMANCE)
> > was invented for.  We do not signal troubles with single-shot filters,
> > so I guess doing it for multi-file filters is not needed.
> 
> I am on the fence with this one.
> 
> @Junio/Peff:
> Where would you prefer to see a "Waiting for filter 'XYZ'... " message?
> On stderr or via GIT_TRACE?

I am not sure if I have followed all of this discussion, but I am of the
opinion that Git should not be doing any timeouts at all. There are
simply too many places where the filter (or any other process that git
is depending on) could inexplicably hang, and I
do not want to pepper random timeouts for all parts of the procedure
where we say "woah, this is taking longer than expected" (nor do I want
to have a timeout for _one_ spot, and ignore all the others).

If this is debugging output of the form "now I am calling wait() on all
of the filters", without respect to any timeout, that sounds reasonable.
Though I would argue that run-command should simply trace_printf()
any processes it is waiting for, which covers _any_ process, not just
the filters. That seems like a good match for the rest of the GIT_TRACE
output, which describes how and when we spawn the sub-processes.

Something like:

diff --git a/run-command.c b/run-command.c
index 5a4dbb6..b884605 100644
--- a/run-command.c
+++ b/run-command.c
@@ -226,6 +226,9 @@ static int wait_or_whine(pid_t pid, const char *argv0, int in_signal)
 	pid_t waiting;
 	int failed_errno = 0;
 
+	if (!in_signal)
+		trace_printf("waiting for pid %d", (int)pid);
+
 	while ((waiting = waitpid(pid, &status, 0)) < 0 && errno == EINTR)
 		;	/* nothing */
 	if (in_signal)

but it does not have to be part of this series, I think.

-Peff
