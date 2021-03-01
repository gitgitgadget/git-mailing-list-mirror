Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F596C433E0
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 09:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44EB364E31
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 09:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233901AbhCAJat (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 04:30:49 -0500
Received: from cloud.peff.net ([104.130.231.41]:47834 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233950AbhCAJaa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 04:30:30 -0500
Received: (qmail 4503 invoked by uid 109); 1 Mar 2021 09:29:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 01 Mar 2021 09:29:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21649 invoked by uid 111); 1 Mar 2021 09:29:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 01 Mar 2021 04:29:48 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 1 Mar 2021 04:29:47 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Aleksey Kliger <alklig@microsoft.com>
Subject: [PATCH] config.mak.uname: enable OPEN_RETURNS_EINTR for macOS Big Sur
Message-ID: <YDy0C9sRvboGXQ7P@coredump.intra.peff.net>
References: <YDXZY8XFRayiM1If@coredump.intra.peff.net>
 <YDXaJHnZ5LgCj9NX@coredump.intra.peff.net>
 <xmqqzgzuyqli.fsf@gitster.g>
 <YDaY/M3Rw+6xwZlf@coredump.intra.peff.net>
 <YDiRywyld/0OTT5U@coredump.intra.peff.net>
 <xmqq8s7ascby.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8s7ascby.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 26, 2021 at 02:17:53PM -0800, Junio C Hamano wrote:

> > +	/*
> > +	 * Also O_TMPFILE would take a mode, but it isn't defined everywhere.
> > +	 * And anyway, we don't use it in our code base.
> > +	 */
> 
> That is being extra careful---I like it very much.

I wondered what would happen if my "anyway" above is wrong. We at least
would not invoke undefined behavior (because we'd avoid looking at the
mode parameter even though it exists), but would pass a "0" mode to the
real open(). Presumably somebody would notice that. :)

> > +	if (flags & O_CREAT) {
> > +		va_list ap;
> > +		va_start(ap, flags);
> > +		mode = va_arg(ap, int);
> > +		va_end(ap);
> > +	}
> > +
> > +	do {
> > +		ret = open(path, flags, mode);
> > +	} while (ret < 0 && errno == EINTR);
> > +
> > +	return ret;
> > +}
> 
> Thanks.

I got another off-list report of the problem. I think we probably want
to do this on top:

-- >8 --
Subject: config.mak.uname: enable OPEN_RETURNS_EINTR for macOS Big Sur

We've had mixed reports on whether the latest release of macOS needs
this Makefile knob set. In most reported cases, there's antivirus
software running (which one might imagine could cause an open() call to
be delayed). However, one of the (off-list) reports I've gotten
indicated that it happened on an otherwise clean install of Big Sur.

Since the symptom is so bad (checkout randomly fails to write several
fails when the progress meter kicks in), and since the workaround is so
lightweight (if we don't see EINTR, it's just an extra conditional
check), let's just turn it on by default.

Signed-off-by: Jeff King <peff@peff.net>
---
Apparently Big Sur jumped from macOS 10.x to 11.x. But our "uname -r"
check gives the "Darwin version", in which it is 20.x (following 19.x
for the previous version). At least according to some sources I found
online. :) So that is good, because otherwise all of our uname_R checks
here would have been broken. I don't have a Big Sur machine handy to
test with, but I believe this should do what we want.

 config.mak.uname | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/config.mak.uname b/config.mak.uname
index e22d4b6d67..d204c20a64 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -124,6 +124,9 @@ ifeq ($(uname_S),Darwin)
 	ifeq ($(shell test "`expr "$(uname_R)" : '\([0-9][0-9]*\)\.'`" -ge 11 && echo 1),1)
 		HAVE_GETDELIM = YesPlease
 	endif
+	ifeq ($(shell test "`expr "$(uname_R)" : '\([0-9][0-9]*\)\.'`" -ge 20 && echo 1),1)
+		OPEN_RETURNS_EINTR = UnfortunatelyYes
+	endif
 	NO_MEMMEM = YesPlease
 	USE_ST_TIMESPEC = YesPlease
 	HAVE_DEV_TTY = YesPlease
-- 
2.31.0.rc0.521.g56be7fa5e1

