Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE1CD203EC
	for <e@80x24.org>; Tue, 13 Dec 2016 19:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933931AbcLMTKu (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 14:10:50 -0500
Received: from cloud.peff.net ([104.130.231.41]:55921 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932547AbcLMTKu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 14:10:50 -0500
Received: (qmail 25286 invoked by uid 109); 13 Dec 2016 19:10:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Dec 2016 19:10:49 +0000
Received: (qmail 17557 invoked by uid 111); 13 Dec 2016 19:11:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Dec 2016 14:11:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Dec 2016 14:10:46 -0500
Date:   Tue, 13 Dec 2016 14:10:46 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] builtin/commit.c: convert trivial snprintf calls to
 xsnprintf
Message-ID: <20161213191046.vbl7st3qf5xxjhab@sigill.intra.peff.net>
References: <20161213132717.42965-1-gitter.spiros@gmail.com>
 <20161213135514.z7eituxgxsvybwgz@sigill.intra.peff.net>
 <xmqqy3zj3b3a.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy3zj3b3a.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 13, 2016 at 11:03:53AM -0800, Junio C Hamano wrote:

> >> @@ -1525,12 +1526,10 @@ static int git_commit_config(const char *k, const char *v, void *cb)
> >>  static int run_rewrite_hook(const unsigned char *oldsha1,
> >>  			    const unsigned char *newsha1)
> >>  {
> >> -	/* oldsha1 SP newsha1 LF NUL */
> >> -	static char buf[2*40 + 3];
> >> +	char *buf;
> >>  	struct child_process proc = CHILD_PROCESS_INIT;
> >>  	const char *argv[3];
> >>  	int code;
> >> -	size_t n;
> >>  
> >>  	argv[0] = find_hook("post-rewrite");
> >>  	if (!argv[0])
> >> @@ -1546,34 +1545,33 @@ static int run_rewrite_hook(const unsigned char *oldsha1,
> >>  	code = start_command(&proc);
> >>  	if (code)
> >>  		return code;
> >> -	n = snprintf(buf, sizeof(buf), "%s %s\n",
> >> -		     sha1_to_hex(oldsha1), sha1_to_hex(newsha1));
> >> +	buf = xstrfmt("%s %s\n", sha1_to_hex(oldsha1), sha1_to_hex(newsha1));
> >>  	sigchain_push(SIGPIPE, SIG_IGN);
> >> -	write_in_full(proc.in, buf, n);
> >> +	write_in_full(proc.in, buf, strlen(buf));
> >>  	close(proc.in);
> >> +	free(buf);
> >
> > Any time you care about the length of the result, I'd generally use an
> > actual strbuf instead of xstrfmt. The extra strlen isn't a big deal
> > here, but it somehow seems simpler to me. It probably doesn't matter
> > much either way, though.
> 
> Your justification for this extra allocation was that it is a
> heavy-weight operation.  While I agree that the runtime cost of
> allocation and deallocation does not matter, I would be a bit
> worried about extra cognitive burden to programmers.  They did not
> have to worry about leaking because they are writing a fixed length
> string.  Now they do, whether they use xstrfmt() or struct strbuf.
> When they need to update what they write, they do have to remember
> to adjust the size of the "fixed string", and the original is not
> free from the "programmers' cognitive cost" point of view, of
> course.  Probably use of strbuf/xstrfmt is an overall win.

So I think you are agreeing, but I have a minor nit to pick. :)

The fact that the extra allocation will not hurt performance is
_necessary_, but not _sufficient_. So it's not a justification in
itself, only something we have to check before proceeding.

The only justification here is that magic numbers like "2*40 + 3" are
confusing and a potential maintenance burden. And that's why I suggested
splitting this one out from the other two (whose justification is
"PATH_MAX is sometimes too small").

I agree with you that it's a tradeoff between "magic numbers" versus
"having to free resources". In my opinion it's a net improvement, but I
think it would also be reasonable to switch to xsnprintf() here. Then
the programmer has an automatic check that the buffer size is
sufficient.

-Peff
