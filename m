Return-Path: <SRS0=62NG=5C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD10C1975A
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 17:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEC0C20738
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 17:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgCQRz7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Mar 2020 13:55:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:41986 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726148AbgCQRz7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Mar 2020 13:55:59 -0400
Received: (qmail 3797 invoked by uid 109); 17 Mar 2020 17:55:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 17 Mar 2020 17:55:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8650 invoked by uid 111); 17 Mar 2020 18:05:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 17 Mar 2020 14:05:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 17 Mar 2020 13:55:58 -0400
From:   Jeff King <peff@peff.net>
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Git <git@vger.kernel.org>
Subject: Re: Conditional newline in pretty format
Message-ID: <20200317175558.GA16061@coredump.intra.peff.net>
References: <CAHd499DiCi3FJb9qWJNBNKyVQg_zYMgJRuYcH_pOP3LnGwk5Tg@mail.gmail.com>
 <CAHd499B+ro+d0bGA+-Y1Qnfkc1vMzXCnBfZmtZv+CscUXim=wQ@mail.gmail.com>
 <20200317171853.GA6598@coredump.intra.peff.net>
 <CAHd499AfYZth1oFii66iUMDJTKVaa-S1K37jt2V027EmYsGPkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHd499AfYZth1oFii66iUMDJTKVaa-S1K37jt2V027EmYsGPkA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 17, 2020 at 12:27:00PM -0500, Robert Dailey wrote:

> > I wonder in the meantime if it would be possible to introduce a block
> > syntax to the pretty formats, like:
> >
> >   git log --format='* %s%n%+{%w(100,2,2)%b}'
> >
> > or something. I don't know the conditional code well enough to say
> > whether that would be a trivial patch or a horribly complicated one. :)
> 
> Thanks for the information. It could also be that for something this
> complex, expecting Git to do it internally might be unreasonable. I'll
> try to come up with a bash script to replace the alias. It'll be a lot
> more verbose but I can take more of a "string builder" approach in an
> actual script which might be more intuitive. I just wanted to check
> for any bugs/built-in behavior before I go that route.

Yeah, I think it would be easy to do something like this with perl
(possibly using Git's --format directives to make it easier to parse the
individual pieces). Once upon a time I had a hacky patch to let you
format with lua inside Git, which would have made this trivial. But it
needed quite a bit of polishing.

At any rate, here's a patch for %{}. It seems to work but I think it may
be too hacky within the current system. One thing in particular is that
%w takes effect for the rest of the string, and we apply it
retroactively at the end of the string. I think we'd want to "push" a
new context onto a stack and pop it at the end of the block. But the
current format_commit_context is a bit muddled; some of the things we'd
want to do this with (wrapping, padding, etc) but not others (parsed
elements of the commit we've parsed).

I didn't pursue it further because I think the right solution is doing
an up-front parse of the format string into a true recursive parse tree,
and then walking that tree to format each commit.

But in the meantime, you can hack around it by "popping" the wrap
parameters manually at the end of the block:

  git log --format='* %s%n%+{%w(100,2,2)%b%w(0,0,0)}'

---
diff --git a/pretty.c b/pretty.c
index 28afc701b6..659fc4f3e9 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1146,6 +1146,9 @@ static int format_trailer_match_cb(const struct strbuf *key, void *ud)
 	return 0;
 }
 
+static size_t format_commit_item(struct strbuf *, const char *placeholder,
+				 void *context);
+
 static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 				const char *placeholder,
 				void *context)
@@ -1209,6 +1212,29 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 	case '<':
 	case '>':
 		return parse_padding_placeholder(placeholder, c);
+
+	case '{':
+		{
+			/*
+			 * A real recursive descent parser would allow embedded
+			 * braces, or blocks within blocks. This hacky solution
+			 * just finds a plausible ending brace, but it's
+			 * probably the best we can do using strbuf_expand().
+			 *
+			 * The copy is also ugly and inefficient, since we do
+			 * it for every commit. This would all be much nicer if
+			 * we pre-parsed the format into a tree.
+			 */
+			const char *beg = placeholder + 1;
+			const char *end = strchrnul(beg, '}');
+			char *inner = xmemdupz(beg, end - beg);
+
+			strbuf_expand(sb, inner, format_commit_item, context);
+			free(inner);
+
+			/* consumed whole inner string plus maybe closing brace */
+			return end - placeholder + !!*end;
+		  }
 	}
 
 	/* these depend on the commit */
