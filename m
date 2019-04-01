Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96BE320248
	for <e@80x24.org>; Mon,  1 Apr 2019 10:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbfDAKL7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 06:11:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:42684 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725867AbfDAKL7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 06:11:59 -0400
Received: (qmail 23568 invoked by uid 109); 1 Apr 2019 10:11:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 01 Apr 2019 10:11:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11082 invoked by uid 111); 1 Apr 2019 10:12:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 01 Apr 2019 06:12:24 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Apr 2019 06:11:57 -0400
Date:   Mon, 1 Apr 2019 06:11:57 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Andrei Rybak <rybak.a.v@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] mailinfo: support Unicode scissors
Message-ID: <20190401101156.GA1131@sigill.intra.peff.net>
References: <20190331220104.31628-1-rybak.a.v@gmail.com>
 <20190331230947.GI32732@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190331230947.GI32732@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 01, 2019 at 01:09:47AM +0200, SZEDER Gábor wrote:

> On Mon, Apr 01, 2019 at 12:01:04AM +0200, Andrei Rybak wrote:
> > diff --git a/mailinfo.c b/mailinfo.c
> > index b395adbdf2..4ef6cdee85 100644
> > --- a/mailinfo.c
> > +++ b/mailinfo.c
> > @@ -701,6 +701,13 @@ static int is_scissors_line(const char *line)
> >  			c++;
> >  			continue;
> >  		}
> > +		if (!memcmp(c, "✂", 3)) {
> 
> This character is tiny.  Please add a comment that it's supposed to be
> a Unicode scissors character.

I think it might also be the first raw UTF-8 character in our source,
which is otherwise ASCII. Usually we'd spell out the binary (with a
comment).

I think I agree with Junio's response, tough, that this is probably not
a road we want to go down, unless this micro-format is being actively
used in the wild (I have no idea, but I have never seen it).

> Should we worry about this memcmp() potentially reading past the end
> of the string when 'c' points to the last character?

I also wondered if the existing memcmps for ">8", etc, would have this
problem. They don't, but it's somewhat subtle. They are only 2
characters long, and the outer loop guarantees we have at least 1
character. So at most we will look at the NUL. But obviously a 3-byte
sequence like this may invoke undefined behavior, and the existing
memcmps encourage anybody adding code to do it wrong.

I wonder if it's worth re-writing it like:

diff --git a/mailinfo.c b/mailinfo.c
index b395adbdf2..46b1b2a4a8 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -693,8 +693,8 @@ static int is_scissors_line(const char *line)
 			perforation++;
 			continue;
 		}
-		if ((!memcmp(c, ">8", 2) || !memcmp(c, "8<", 2) ||
-		     !memcmp(c, ">%", 2) || !memcmp(c, "%<", 2))) {
+		if ((starts_with(c, ">8") || starts_with(c, "8<") ||
+		     starts_with(c, ">%") || starts_with(c, "%<"))) {
 			in_perforation = 1;
 			perforation += 2;
 			scissors += 2;

-Peff
