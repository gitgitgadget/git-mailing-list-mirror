Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6645720286
	for <e@80x24.org>; Fri,  8 Sep 2017 03:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753575AbdIHD4v (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Sep 2017 23:56:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:60412 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752110AbdIHD4u (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2017 23:56:50 -0400
Received: (qmail 9684 invoked by uid 109); 8 Sep 2017 03:56:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Sep 2017 03:56:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5613 invoked by uid 111); 8 Sep 2017 03:57:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 Sep 2017 23:57:23 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Sep 2017 23:56:48 -0400
Date:   Thu, 7 Sep 2017 23:56:48 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Rene Scharfe <l.s.r@web.de>, git@vger.kernel.org
Subject: Re: [PATCH 27/34] shortlog: release strbuf after use in
 insert_one_record()
Message-ID: <20170908035648.jhm6ypxkwwms4bqu@sigill.intra.peff.net>
References: <20170830175005.20756-1-l.s.r@web.de>
 <20170830180037.20950-1-l.s.r@web.de>
 <20170830180037.20950-8-l.s.r@web.de>
 <xmqqtw0f61xr.fsf@gitster.mtv.corp.google.com>
 <20170907043354.fwxiifzbqf3yt5rr@sigill.intra.peff.net>
 <xmqqzia61125.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzia61125.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 08, 2017 at 09:33:38AM +0900, Junio C Hamano wrote:

> >> An alterative, as this is the only place we add to log->list, could
> >> be to make log->list take ownership of the string by not adding a
> >> _release() here but instead _detach(), I guess.
> >
> > I agree that would be better, but I think it's a little tricky. The
> > string_list_insert() call may make a new entry, or it may return an
> > existing one. We'd still need to free in the latter case. I'm not sure
> > the string_list interface makes it easy to tell the difference.
> 
> True; I do not think string_list API does.  But for this particular
> application, I suspect that we can by looking at the util field of
> the item returned.  A newly created one has NULL, but we always make
> it non-NULL before leaving this function.

Yeah, I agree that would work here.

I also wondered if we could get away with avoiding the malloc entirely
here. Especially in the "shortlog -n" case, it is identical to the name
field we already have in ident.name. So ideally we'd do a lookup to see
if we have the entry before allocating anything (since we do one lookup
per commit, but only insert once per unique author).

But that doesn't quite work, because ident.name doesn't put to a
NUL-terminated string, and string_list only handles strings.

We _can_ reuse the same buffer over and over:

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 43c4799ea9..7328abf4a1 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -54,7 +54,7 @@ static void insert_one_record(struct shortlog *log,
 	struct string_list_item *item;
 	const char *mailbuf, *namebuf;
 	size_t namelen, maillen;
-	struct strbuf namemailbuf = STRBUF_INIT;
+	static struct strbuf namemailbuf = STRBUF_INIT;
 	struct ident_split ident;
 
 	if (split_ident_line(&ident, author, strlen(author)))
@@ -66,6 +66,7 @@ static void insert_one_record(struct shortlog *log,
 	maillen = ident.mail_end - ident.mail_begin;
 
 	map_user(&log->mailmap, &mailbuf, &maillen, &namebuf, &namelen);
+	strbuf_reset(&namemailbuf);
 	strbuf_add(&namemailbuf, namebuf, namelen);
 
 	if (log->email)

That saves the malloc, if not the extra copying. It shows about a 1%
speed up on "git shortlog -ns" on linux.git. Probably that's not worth
caring too much about, but it also "solves" the leaking problem (I'm not
sure if the speedup is from calling malloc less frequently, or from
lowering our peak heap usage due to fixing the leak).

-Peff
