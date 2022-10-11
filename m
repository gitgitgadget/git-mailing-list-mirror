Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89D1C433F5
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 02:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiJKCPi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 22:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiJKCPg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 22:15:36 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77AA07B797
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 19:15:33 -0700 (PDT)
Received: (qmail 30116 invoked by uid 109); 11 Oct 2022 02:15:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 Oct 2022 02:15:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16596 invoked by uid 111); 11 Oct 2022 02:15:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 10 Oct 2022 22:15:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 10 Oct 2022 22:15:32 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, jacob@initialcommit.io, gitster@pobox.com
Subject: Re: [PATCH 5/7] shortlog: implement `--group=author` in terms of
 `--group=<format>`
Message-ID: <Y0TRxDRFRgFonhtH@coredump.intra.peff.net>
References: <cover.1665448437.git.me@ttaylorr.com>
 <55a6ef7bc0082818fa51a0915c43002ede5c449f.1665448437.git.me@ttaylorr.com>
 <Y0TIMlrrifYKuBnR@coredump.intra.peff.net>
 <Y0TLf/J22ioQ5UCt@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y0TLf/J22ioQ5UCt@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 10, 2022 at 09:48:47PM -0400, Taylor Blau wrote:

> I think that shortlog_finish_setup() is probably the most reasonable
> choice (and I changed it to that locally). I spent a day or so thinking
> on and off about this while writing the series, and didn't come up with
> any satisfying names.
> 
> I think it points to something deeper about the API that doesn't quite
> sit right with me. But shortlog_finish_setup() is the least-unsatisfying
> name so far, so let's go with that ;-).

Yeah, touching that block in make_cover_letter() definitely tickled my
memory that there was some awkwardness there. That's when I added
shortlog_init() at all (which is good, because otherwise you'd have had
an uninitialized log.format string-list).

I think the general pattern of:

  foo_init();
  foo.option = whatever;
  foo_finish_setup();

  foo_do_the_thing();

is OK. It's a little complicated, but it gives callers the freedom to
tweak options with a lot of flexibility (e.g., based on command line
config, command line options, etc). We have a similar pattern with
diff_setup_done().

The other option is for any option-tweaking to go through methods which
maintain invariants (like if GROUP_AUTHOR is set, then the "%an" format
has been added). That's usually the "right" object-oriented way to do
it. But I think even in this simple case it gets awkward, because the
correct format can't be known until you see whether log->email is set.
So it really has to be a "finalize" step after both log->email and
log->group are set.

> > This loses the HAS_MULTI_BITS() optimization. The idea there is that if
> > you have a single group-by that can't produce multiple outputs, then
> > there's no need to do duplicate detection.
> >
> > The equivalent in an all-formats world is something like:
> >
> >   log.format.nr > 1 && !log.trailers.nr
> >
> > (because trailers are special in that one trailer key can produce
> > multiple idents for a single commit).
> 
> Hmm. I suspect that this is going to become more complicated by the time
> that you read the final patch ;-). Let's wait until then and see what
> you think.

Yes, it's pretty gross with the trailer util thing. You'd probably want
to do something like:

  static int needs_dedup(const struct string_list *formats)
  {
	struct string_list_item *item;
	if (formats->nr > 1)
		return 1;
	for_each_string_list_item(item, formats) {
		if (item->util)
			return 1;
	}
	return 0;
  }

and perhaps call it only once and cache the result, rather than
iterating for each commit/format.

But if we leave trailers as is, then the logic is much easier. And
implementing the optimization for --group=format should fall out pretty
naturally (and that both preserves it for --group=author, and extends it
to --group=format, which I should have noticed when reviewing patch 4).

> > > @@ -439,8 +440,8 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
> > >  	log.file = rev.diffopt.file;
> > >  	log.date_mode = rev.date_mode;
> > >
> > > -	if (!log.groups)
> > > -		log.groups = SHORTLOG_GROUP_AUTHOR;
> > > +	shortlog_init_group(&log);
> > > +
> > >  	string_list_sort(&log.trailers);
> >
> > Now that we have a "finish the shortlog init" function, probably this
> > trailer sort should go into it, too. The current caller doesn't need it,
> > but it removes on more gotcha from using the shortlog API.
> 
> We'll drop this list by the end of the series, too, so it probably isn't
> worth moving it into shortlog_finish_setup() in the interim.

Ah, right. Well, see my other comments. :)

-Peff
