Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10105201A4
	for <e@80x24.org>; Mon, 15 May 2017 03:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756156AbdEODdi (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 May 2017 23:33:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:51667 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754994AbdEODdh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 May 2017 23:33:37 -0400
Received: (qmail 20316 invoked by uid 109); 15 May 2017 03:33:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 May 2017 03:33:36 +0000
Received: (qmail 12828 invoked by uid 111); 15 May 2017 03:34:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 14 May 2017 23:34:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 14 May 2017 23:33:33 -0400
Date:   Sun, 14 May 2017 23:33:33 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brian Malehorn <bmalehorn@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] interpret-trailers: obey scissors lines
Message-ID: <20170515033333.g25hdr4fgzuay536@sigill.intra.peff.net>
References: <20170512090032.coddhlsrs6s3zm2f@sigill.intra.peff.net>
 <20170514033923.12870-1-bmalehorn@gmail.com>
 <20170514033923.12870-2-bmalehorn@gmail.com>
 <20170514035652.rn5npxxflku6s5k4@sigill.intra.peff.net>
 <xmqqfug6yiks.fsf@gitster.mtv.corp.google.com>
 <20170515030726.mmbb43zxqgtbrbuy@sigill.intra.peff.net>
 <xmqqpofax0af.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpofax0af.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 15, 2017 at 12:32:24PM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Mon, May 15, 2017 at 11:12:03AM +0900, Junio C Hamano wrote:
> >
> >> >> diff --git a/builtin/commit.c b/builtin/commit.c
> >> >> index 2de5f6cc6..2ce9c339d 100644
> >> >> --- a/builtin/commit.c
> >> >> +++ b/builtin/commit.c
> >> >> @@ -1735,7 +1735,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
> >> >>  
> >> >>  	if (verbose || /* Truncate the message just before the diff, if any. */
> >> >>  	    cleanup_mode == CLEANUP_SCISSORS)
> >> >> -		wt_status_truncate_message_at_cut_line(&sb);
> >> >> +		strbuf_setlen(&sb,
> >> >> +			      wt_status_last_nonscissors_index(sb.buf, sb.len));
> >> >
> >> > This hunk surprised me at first (that we would need to touch commit.c at
> >> > all), but the refactoring makes sense.
> >> 
> >> This still surprises me.  If the problem is in interpret-trailers,
> >> why do we even need to touch cmd_commit()?  If GIT_EDITOR returns us
> >
> > The behavior of cmd_commit() shouldn't be changed by the patch. But to
> > make the interface suitable for the new callsite (which doesn't have a
> > strbuf, but a ptr/len buffer), it needs to return the length rather than
> > shortening the strbuf. We could leave in place:
> >
> >   void wt_status_truncate_message_at_cut_line(struct strbuf *sb)
> >   {
> > 	strbuf_setlen(sb, wt_status_last_nonscissors_index(sb->buf, sb->len));
> >   }
> >
> > but it would only have this one caller.
> >
> > If I were doing the patch series, I'd probably have split that
> > refactoring into its own patch and discussed the reason separately. I
> > waffled on whether or not to ask Brian to do so (and obviously didn't in
> > the end).
> 
> I suspect that you would have just explained "since there is only
> one caller, let's open-code it" in the log message, without making
> this a two-patch series, and that would also have been perfectly
> understandable (and in this case probably preferrable).
> 
> So the patch text would be OK; it was surprising to have the change
> without being explained, that's all.

Yeah, I'd agree it could use a better explanation in the commit message.
I was surprised to see it, too. Since both of us were surprised, that's
probably a good indicator. :)

-Peff
