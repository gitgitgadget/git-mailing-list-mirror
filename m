Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3087722D7B9
	for <git@vger.kernel.org>; Sat, 18 Oct 2025 09:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760780447; cv=none; b=ZsW/csQtx5JfIybs/NvmE9hWFczd5zT02kV18YZw8mS8pAgET0P0lCApoFOpRTA8zp2mIPUevJqx96MUA25wDUVMeOxfd+72QVdVnMUzLNfwIf1M1WeHoBaKhCi3swNRHHnP3baa56F+oEd83cU1ULBAyQBXuBTtN9+g+Ci4MY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760780447; c=relaxed/simple;
	bh=5f/6nAk/I5U+SU1Q8KBzgX3mtL6V4BwzG1rbP3j+Sgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kAB0nh7iaUylGMiFDaywtrRrVzErWi5/P0qgXnKeE2wqXIELtSnQyxt28AW2visBd08KoKvsFQ1q0EoRmYPKh95Lb+BDdG4MF7B/Ra6xuTEo41ZMeGb8++9cFpnkuJsf+7Qec1LkSxJ6rFNvhT6B2WV8/BxDpmv/A6i7edNx9sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=TeK3Gbve; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="TeK3Gbve"
Received: (qmail 261172 invoked by uid 109); 18 Oct 2025 09:40:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=5f/6nAk/I5U+SU1Q8KBzgX3mtL6V4BwzG1rbP3j+Sgw=; b=TeK3GbveefCW2y2KYAI7bw85BRvqLaHvK/QSU+OPCq26FbEY89CCNkLGW8ZShR8ceo0CCdeTbO42gduHXswzcH8yK8B5r1+pHfTwW+v1tKJB5LgAjnGvzgd0x+01YHAnA8eHLEM/vcpEbKUmwD2W6PhKfxZcxGn06veJyETc39fn21D84ec5w1DFm+cHHQd1Y67FSZX6cGS8609fLGQYqTX3wJthvNwXRjWr+gMTOSwXD+fpmAtFQ1xVOiKu0C4XrVAwBx6w+XI9tknq6Nd/In45YFk//eazgiWy1Y9HIZoyAtwsm4HSTBLpBw5IrQpmVHRg5+lkO1JPxysrHJ0KZA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 18 Oct 2025 09:40:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 409614 invoked by uid 111); 18 Oct 2025 09:40:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 18 Oct 2025 05:40:37 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 18 Oct 2025 05:40:37 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jake Zimmerman <jake@zimmerman.io>, Lidong Yan <yldhome2d2@gmail.com>,
	git@vger.kernel.org
Subject: Re: Regression in `git diff --quiet HEAD` when a new file is staged
Message-ID: <20251018094037.GA1060824@coredump.intra.peff.net>
References: <CACJRbWjwOQwJB13CwTfvhV3p+Hbn4KrNM9AtBanGtUS4V_1MbQ@mail.gmail.com>
 <20251017075153.GA4078773@coredump.intra.peff.net>
 <xmqq7bwt1kyf.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7bwt1kyf.fsf@gitster.g>

On Fri, Oct 17, 2025 at 10:45:12AM -0700, Junio C Hamano wrote:

> > diff --git a/diff.c b/diff.c
> > index 87fa16b730..687206f353 100644
> > --- a/diff.c
> > +++ b/diff.c
> > @@ -6890,6 +6890,15 @@ void diff_flush(struct diff_options *options)
> >  	if (output_format & DIFF_FORMAT_NO_OUTPUT &&
> >  	    options->flags.exit_with_status &&
> >  	    options->flags.diff_from_contents) {
> > +		/*
> > +		 * run diff_flush_patch for the exit status. setting
> > +		 * options->file to /dev/null should be safe, because we
> > +		 * aren't supposed to produce any output anyway.
> > +		 */
> > +		diff_free_file(options);
> > +		options->file = xfopen("/dev/null", "w");
> > +		options->close_file = 1;
> > +		options->color_moved = 0;
> >  		for (i = 0; i < q->nr; i++) {
> >  			struct diff_filepair *p = q->queue[i];
> >  			if (check_pair_status(p))
> >
> > That would catch the bug here, as well as any others lurking. And it
> > converts any missing dry_run from correctness problems (we definitely
> > will not produce extra output) into optimization problems (we might emit
> > data we do not need, but we can fix those separately). At least for the
> > normal code paths. I think without those extra fixes the problems that
> > b55e6d36eb tried to fix for "-I" would still be observable, but at least
> > its fixes could not regress the other code paths.
> 
> Ahh.  I like this "stupid but cannot be incorrect" version even
> better than the original one that introduced the "dry run" mode.
> 
> But once we go in that direction, do we still need the dry-run
> machinery with diff_flush_patch_quietly() helper function?

I'm not sure which of these you mean:

  - Do we still need to call diff_flush_patch_quietly() directly below
    the hunk above, in diff_flush()?

    The answer is no, we do not need to (just like we did not before
    b55e6d36eb). But I think it is worth doing so still, because the
    low-level code may be able to use the flag to do things more
    efficiently.

  - Do we still need the dry-run code at all?

    My impression is yes, because there are other code paths which do
    the dry-run thing and need it for correctness.

    If I understand the motivation of b55e6d36eb, it really has multiple
    parts:

      1. Add a dry-run mode to the diff code.

      2. Use that dry-run mode for handling -I with name-status, etc.

      3. Since we now have dry-run mode, convert diff_flush()'s
	 /dev/null for --quiet mode to use it.

    The goal was really part (2). And any bugs in (1) would show up
    there, but they couldn't actually be regressions, but rather just an
    incomplete fix for (2). But by doing part (3), now bugs in (1) are
    regressions for --quiet. Hence my suggestion to undo just that part,
    and then do fixes for (1) separately.

    Or did you just mean: can we just go to a world where the _quietly()
    function just redirects /dev/null rather than worrying about dry-run
    at all? That is certainly an option, though I do think there is room
    for more efficiency with dry-run. So I think I prefer the
    belt-and-suspenders of "redirect to /dev/null just in case we miss a
    spot, but also tell the low-level code nobody is looking at the
    output".

-Peff
