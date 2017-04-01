Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97D8D1FAFB
	for <e@80x24.org>; Sat,  1 Apr 2017 05:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750817AbdDAF1p (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Apr 2017 01:27:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:55238 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750802AbdDAF1o (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2017 01:27:44 -0400
Received: (qmail 19611 invoked by uid 109); 1 Apr 2017 05:27:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 01 Apr 2017 05:27:42 +0000
Received: (qmail 15645 invoked by uid 111); 1 Apr 2017 05:27:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 01 Apr 2017 01:27:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Apr 2017 01:27:39 -0400
Date:   Sat, 1 Apr 2017 01:27:39 -0400
From:   Jeff King <peff@peff.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Bug in "git am" when the body starts with spaces
Message-ID: <20170401052739.dw65gnh26izgt5u7@sigill.intra.peff.net>
References: <CA+55aFypmFkc4gOEea-AF1kKYb3K=6nosXvYS4AMGFOQHw0ZxA@mail.gmail.com>
 <CA+55aFwcQuxwhQ+LABmev2XRHgOqsbRm7YDYn3FDDXKMYcF-CA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+55aFwcQuxwhQ+LABmev2XRHgOqsbRm7YDYn3FDDXKMYcF-CA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 31, 2017 at 05:52:00PM -0700, Linus Torvalds wrote:

> Ok, did a bisect, and this bisects to commit 6b4b013f1884 ("mailinfo:
> handle in-body header continuations").
> 
> The continuation logic is oddly complex, and I can't follow the logic.
> But it is completely broken in how it thinks empty lines are somehow
> "continuations".

I think the continuation logic is OK. The problem is that the newline is
never fed to check_inbody_header() at all. So the next line its state
machine sees is the indented line, which looks like a continuation.

It seems to me that ignoring that newline is a bug, and causes other
problems. For instance, if you have a blank line and then another
header-looking thing (not a continuation) after, it is respected. For
instance, running mailinfo on:

  From ...mbox header...
  From: Email Author <author@example.com>
  Subject: email subject
  Date: whatever

  From: in-body author <author@example.com>

  Subject: in-body subject

  And the rest of the message.

will use "in-body subject" as the subject, though I'd have thought we
should stop parsing in-body headers as soon as we see the first in-body
blank line (the one after the in-body "From").

The blank line gets eaten by the check at the beginning of
handle_commit_msg(), right _before_ we pass it off to the
check_inbody_header() function.

It seems like that should be more like:

diff --git a/mailinfo.c b/mailinfo.c
index a489d9d0f..6d89781eb 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -757,8 +757,10 @@ static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
 	assert(!mi->filter_stage);
 
 	if (mi->header_stage) {
-		if (!line->len || (line->len == 1 && line->buf[0] == '\n'))
+		if (!line->len || (line->len == 1 && line->buf[0] == '\n')) {
+			mi->header_stage = 0;
 			return 0;
+		}
 	}
 
 	if (mi->use_inbody_headers && mi->header_stage) {


But that breaks a bunch of tests. It looks like the loop in handle_body
always starts by feeding the initial header-separator (the real headers,
not the in-body ones) to the various parsers. So that first newline
makes us trigger "no more in-body headers" before we even start parsing
any lines. Oops.

So doing this:

@@ -960,7 +962,7 @@ static void handle_body(struct mailinfo *mi, struct strbuf *line)
 			goto handle_body_out;
 	}
 
-	do {
+	while (!strbuf_getwholeline(line, mi->input, '\n')) {
 		/* process any boundary lines */
 		if (*(mi->content_top) && is_multipart_boundary(mi, line)) {
 			/* flush any leftover */
@@ -1013,7 +1015,7 @@ static void handle_body(struct mailinfo *mi, struct strbuf *line)
 
 		if (mi->input_error)
 			break;
-	} while (!strbuf_getwholeline(line, mi->input, '\n'));
+	}
 
 	flush_inbody_header_accum(mi);
 

on top fixes that. But that still breaks a test that has blank lines at
the beginning of the message, before the in-body header. So probably the
state-machine needs an extra state: sucking up pre-inbody-header
newlines.

-Peff
