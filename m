Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E09861FCA9
	for <e@80x24.org>; Mon, 19 Sep 2016 10:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751581AbcISKvh (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 06:51:37 -0400
Received: from ikke.info ([178.21.113.177]:37392 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750933AbcISKvg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 06:51:36 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 86F2A4400B9; Mon, 19 Sep 2016 12:51:33 +0200 (CEST)
Date:   Mon, 19 Sep 2016 12:51:33 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Swift Geek <swiftgeek@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mailinfo: unescape quoted-pair in header fields
Message-ID: <20160919105133.GA10901@ikke.info>
References: <20160916210204.31282-1-me@ikke.info>
 <20160916222206.jz2d4gpaxxccia5p@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160916222206.jz2d4gpaxxccia5p@sigill.intra.peff.net>
User-Agent: Mutt/1.7.0 (2016-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the review

On Fri, Sep 16, 2016 at 03:22:06PM -0700, Jeff King wrote:
> On Fri, Sep 16, 2016 at 11:02:04PM +0200, Kevin Daudt wrote:
> 
> >  mailinfo.c                 | 54 ++++++++++++++++++++++++++++++++++++++++++++++
> >  t/t5100-mailinfo.sh        |  6 ++++++
> >  t/t5100/quoted-pair.expect |  5 +++++
> >  t/t5100/quoted-pair.in     |  9 ++++++++
> >  4 files changed, 74 insertions(+)
> >  create mode 100644 t/t5100/quoted-pair.expect
> >  create mode 100644 t/t5100/quoted-pair.in
> > 
> > diff --git a/mailinfo.c b/mailinfo.c
> > index e19abe3..04036f3 100644
> > --- a/mailinfo.c
> > +++ b/mailinfo.c
> > @@ -54,15 +54,69 @@ static void parse_bogus_from(struct mailinfo *mi, const struct strbuf *line)
> >  	get_sane_name(&mi->name, &mi->name, &mi->email);
> >  }
> >  
> > +static int unquote_quoted_string(struct strbuf *line)
> > +{
> > +	struct strbuf outbuf;
> > +	const char *in = line->buf;
> > +	int c, take_next_literally = 0;
> > +	int found_error = 0;
> > +	char escape_context=0;
> 
> Style: whitespace around "=".
> 
> I had to wonder why we needed both escape_context and
> take_next_literally; shouldn't we just need a single state bit. But
> escape_context is not "escape the next character", it is "we are
> currently in a mode where we should be escaping".
> 
> Could we give it a more descriptive name? I guess it is more than just
> "we are in a mode", but rather "here is the character that will end the
> escaped mode". Maybe a comment would be more appropriate.
> 

Yes, your analysis is right, we need to know what character would end
the 'escape context'. I'll add a comment.

> > +	while ((c = *in++) != 0) {
> > +		if (take_next_literally) {
> > +			take_next_literally = 0;
> > +		} else {
> 
> OK, so that means the previous one was backslash-quoted, and we don't do
> any other cleverness. Good.
> 
> > +			switch (c) {
> > +			case '"':
> > +				if (!escape_context)
> > +					escape_context = '"';
> > +				else if (escape_context == '"')
> > +					escape_context = 0;
> > +				continue;
> 
> And here we open or close the quoted portion, depending. Makes sense.
> 
> > +			case '\\':
> > +				if (escape_context) {
> > +					take_next_literally = 1;
> > +					continue;
> > +				}
> > +				break;
> 
> I didn't look in the RFC. Is:
> 
>   From: my \"name\" <foo@example.com>
> 
> really the same as:
> 
>   From: "my \\\"name\\\"" <foo@example.com>
> 
> ? That seems weird, but I think it may be that the former is simply
> bogus (you are not supposed to use backslashes outside of the quoted
> section at all).

Correct, the quoted-pair (escape sequence) can only occur in a quoted
string or a comment. Even more so, the display name *needs* to be quoted
when consisting of more then one word according to the RFC.

> 
> > +			case '(':
> > +				if (!escape_context)
> > +					escape_context = '(';
> > +				else if (escape_context == '(')
> > +					found_error = 1;
> > +				break;
> 
> Hmm. Is:
> 
>   From: Name (Comment with (another comment))
> 
> really disallowed? RFC2822 seems to say that "comment" can contain
> "ccontent", which can itself be a comment.

Yes, you are right, it is allowed, I was just looking at the ctext when
adding this, but failed to see that comments can be nested at that time.

> 
> This is obviously getting pretty silly, but if we are going to follow
> the RFC, I think you actually have to do a recursive parse, and keep
> track of an arbitrary depth of context.
> 
> I dunno. This method probably covers most cases in practice, and it's
> easy to reason about.

The problem is, how do you differentiate between nested comments, and
escaped braces within a comment after one run?
> 
> > +			case ')':
> > +				if (escape_context == '(')
> > +					escape_context = 0;
> > +				break;
> > +			}
> > +		}
> > +
> > +		strbuf_addch(&outbuf, c);
> > +	}
> > +
> > +	strbuf_reset(line);
> > +	strbuf_addbuf(line, &outbuf);
> > +	strbuf_release(&outbuf);
> 
> I think you can use strbuf_swap() here to avoid copying the line an
> extra time, like:
> 
>   strbuf_swap(line, &outbuf);
>   strbuf_release(&outbuf);
> 
> Another option would be to just:
> 
>   in = strbuf_detach(&line);
> 
> at the beginning, and then output back into "line".
> 

Thanks, I just looked at what other functions were doing, but this is
much better indeed.

> > +	return found_error;
> 
> What happens when we get here and take_next_literally is set? I.e., a
> backslash at the end of the string. We'll silently print nothing, which
> seems reasonable to me (the other option is to print a literal
> backslash).
> 
> Ditto, what if escape_context is non-zero? We're in the middle of an
> unterminated quoted string (or comment).
> 
> I'm fine with silently continuing, but it seems weird that we notice
> embedded comments (and return an error), but not these other conditions.
> 

I agree. I'm thinking it's better to just be lenient in this method. If
a quote wasn't properly closed, there would be no e-mail adress for
example. I think it would do little harm, and I'd remove the checking
for the opening brace too.

> >  static void handle_from(struct mailinfo *mi, const struct strbuf *from)
> >  {
> >  	char *at;
> >  	size_t el;
> >  	struct strbuf f;
> >  
> > +
> >  	strbuf_init(&f, from->len);
> >  	strbuf_addbuf(&f, from);
> 
> Funny extra line?

Ugh

> 
> > +test_expect_success 'mailinfo unescapes rfc2822 quoted-string' '
> > +    mkdir quoted-pair &&
> > +    git mailinfo /dev/null /dev/null <"$TEST_DIRECTORY"/t5100/quoted-pair.in >quoted-pair/info &&
> > +    test_cmp "$TEST_DIRECTORY"/t5100/quoted-pair.expect quoted-pair/info
> > +'
> 
> We usually break long lines with backslash-escapes. Like:
> 
>   git mailinfo /dev/null /dev/null \
> 	<"$TEST_DIRECTORY"/t5100/quoted-pair.in \
> 	>quoted-pair/info
> 
> I'd also wonder if things might be made much more readable by putting
> "$TEST_DIRECTORY/t5100" into a shorter variable like $data or something.
> That would be best done as a preparatory patch which updates all of the
> tests.
> 
> > --- /dev/null
> > +++ b/t/t5100/quoted-pair.in
> > @@ -0,0 +1,9 @@
> > +From 1234567890123456789012345678901234567890 Mon Sep 17 00:00:00 2001
> > +From: "Author \"The Author\" Name" <somebody@example.com>
> > +Date: Sun, 25 May 2008 00:38:18 -0700
> > +Subject: [PATCH] testing quoted-pair
> 
> I do not care that much about the "()" comment behavior myself, but if
> we are going to implement it, it probably makes sense to protect it from
> regression with a test.

Yeah, good idea.
> 
> -Peff
