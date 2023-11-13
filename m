Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA8D22F0B
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 19:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B741702
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 11:00:28 -0800 (PST)
Received: (qmail 20271 invoked by uid 109); 13 Nov 2023 19:00:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 13 Nov 2023 19:00:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5308 invoked by uid 111); 13 Nov 2023 19:00:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 13 Nov 2023 14:00:29 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 13 Nov 2023 14:00:27 -0500
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH] format-patch: fix ignored encode_email_headers for cover
 letter
Message-ID: <20231113190027.GC3838361@coredump.intra.peff.net>
References: <20231109111950.387219-1-contact@emersion.fr>
 <20231109183506.GB2711684@coredump.intra.peff.net>
 <0c0d685c-29e5-462c-a743-4573a56d7e04@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0c0d685c-29e5-462c-a743-4573a56d7e04@web.de>

On Sun, Nov 12, 2023 at 07:38:22PM +0100, René Scharfe wrote:

> > Grepping for other
> >      code that does the same thing, I see that show_log() and
> >      cmd_format_patch() copy a lot more.
> 
> show_log() copies almost half of the struct 6d167fd7cc members
> from struct rev_info!
> 
> cmd_format_patch() doesn't seem have a struct pretty_print_context,
> though...

Doh, you're right. I grepped for spots setting encode_email_headers, but
the one in cmd_format_patch() is copying it from the config-default into
the rev_info, not into the pretty-print context.

Which makes sense. It is going to call show_log() to show each commit,
which is where the value is copied into the pretty-print context.

> > (For that matter, why doesn't
> >      make_cover_letter() just use the context set up by
> >      cmd_format_patch()?).
> 
> ... which answers this question, but did you perhaps mean a different
> function?

Right, I was just confused.

> >   2. Why are we copying this stuff at all? When we introduced the
> >      pretty-print context back in 6bf139440c (clean up calling
> >      conventions for pretty.c functions, 2011-05-26), the idea was just
> >      to keep all of the format options together. But later, 6d167fd7cc
> >      (pretty: use fmt_output_email_subject(), 2017-03-01) added a
> >      pointer to the rev_info directly.
> 
> Hmm.  Was sticking the rev_info pointer in unwise?  Does it tangle up
> things that should be kept separate?  It uses force_in_body_from,
> grep_filter, sources, nr, total and subject_prefix from struct rev_info.
> That seems a lot, but is just a small fraction of its total members and
> we could just copy those we need.  Or prepare the subject string and
> pass it in, as before 6d167fd7cc.

I don't know that it was unwise. I was mostly just noting the history
because that explains why we _didn't_ simply refer to ctx->revs in
6bf139440c. Has the separation between the two been valuable since then?
I'm not sure. We do have some code paths that do not have a rev_info at
all (e.g., pp_commit_easy(), which makes an ad-hoc empty context
struct).

> > So could/should we just be using
> >      pp->rev->encode_email_headers here?
> 
> Perhaps.  If we want struct pretty_print_context to be a collection of
> named parameters, though, then it makes sense to avoid using
> complicated types to provide a nice interface to its callers, and
> struct rev_info is one of our largest structs we have.

Yeah, philosophically it may be better to keep the modules separated.
But if we end up having to just copy a ton of fields, it may not be as
practical. If we can at least factor that out into a single spot,
though, it may not be so bad.

> >      Or if that field is not always set (or we want to override some
> >      elements), should there be a single helper function to initialize
> >      the pretty_print_context from a rev_info, that could be shared
> >      between spots like show_log() and make_cover_letter()?
> 
> That would help avoid forgetting to copy something.  But copying is
> questionable in general, as you mentioned.  Given the extent of the
> overlap, would it make sense to embed struct pretty_print_context in
> struct rev_info instead?  Or a subset thereof?

I had a similar thought, but the pretty_print_context carries both input
options from the caller, as well as computed state used internally by
the pretty-print code. So you'd have to split those two up, I would
think. And now all of the pretty-print functions have to pass around
_two_ contexts.

That's more annoying, but arguably is a cleaner design (the internal
struct can be a private thing that is not even defined outside of
pretty.c). I dunno.

-Peff
