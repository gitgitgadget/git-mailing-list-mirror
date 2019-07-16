Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DCFC1F461
	for <e@80x24.org>; Tue, 16 Jul 2019 18:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbfGPS6h (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jul 2019 14:58:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:37884 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726213AbfGPS6h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jul 2019 14:58:37 -0400
Received: (qmail 10540 invoked by uid 109); 16 Jul 2019 18:58:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 16 Jul 2019 18:58:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2549 invoked by uid 111); 16 Jul 2019 18:59:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 16 Jul 2019 14:59:33 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Jul 2019 14:58:35 -0400
Date:   Tue, 16 Jul 2019 14:58:35 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Steven Roberts <fenderq@gmail.com>, git@vger.kernel.org
Subject: Re: git segfault in tag verify (patch included)
Message-ID: <20190716185835.GA24468@sigill.intra.peff.net>
References: <CAOGP0GoYviFHhFzhqEimEw+ebd=DJx9JucG4BNvSvPuDudoWxw@mail.gmail.com>
 <xmqqsgr53kov.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsgr53kov.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 16, 2019 at 11:20:48AM -0700, Junio C Hamano wrote:

> That is this thing.
> 
>         static void parse_gpg_output(struct signature_check *sigc)
>         {
>                 const char *buf = sigc->gpg_status;
>                 const char *line, *next;
>                 int i, j;
>                 int seen_exclusive_status = 0;
> 
>                 /* Iterate over all lines */
>                 for (line = buf; *line; line = strchrnul(line+1, '\n')) {
>                         while (*line == '\n')
>                                 line++;
>                         /* Skip lines that don't start with GNUPG status */
>                         if (!skip_prefix(line, "[GNUPG:] ", &line))
>                                 continue;
> 
> If the GPG output ends with a trailing blank line, we skip and get
> to the terminating NUL, then find that it does not begin with
> the "[GNUPG:] " prefix, and hit the continue.  We try to scan and
> look for LF (or stop at the end of the string) for the next round,
> starting at one past where we are, which is already the terminating
> NUL.  Ouch.
> 
> Good finding.

Yeah. The patch below looks fine, and I do not see any other
out-of-bounds issues in the code (there is a similar "next + 1" in the
inner loop, but it checks for an empty line right beforehand already).

I find these kind of "+1" pointer increments without constraint checking
are error-prone.  I suspect this whole loop could be a bit easier to
follow by finding the next line boundary at the start of the loop, and
jumping to it in the for-loop advancement. And then within the loop, we
know the boundaries of the line (right now, for example, we issue a
strchrnul() looking for a space that might unexpectedly cross line
boundaries).

Something like:

  for (line = buf; *line; line = next) {
	next = strchrnul(line, '\n');

	... do stuff ...
	/* find a space within the line */
	space = memchr(line, ' ', next - line);
  }

or even:

  for (line = buf; *line; line += len) {
	size_t len = strchrnul(line, '\n') - line;
	...
	space = memchr(line, ' ', linelen);
  }

but it may not be worth the churn. It's just as likely to introduce a
new bug. ;)

I've also found working with strbuf_getline() to be very pleasant for a
lot of these cases (in which you get a real per-line NUL-terminated
string), but of course it implies an extra copy.

-Peff
