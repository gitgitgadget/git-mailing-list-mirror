Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5EE18BC3B
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 16:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757348212; cv=none; b=mO3gWfydMKmkwtXrrN0qmZ/WnOBpAAAFo7Pxth3ykTaMmKEYItJ+8F5TzQDGMNKCsUnZVJn7bs7CUC3zs5utopDdlj5PzJ7yG0TzDh+IwBSDuRfG1FLoGlyoUt/LfHd1LJI/gc2T9EG7psbTRcT6JJR4jKHmwvIxVBSvowk8jSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757348212; c=relaxed/simple;
	bh=KP71DmYAh+buAGC9ddZQtjfXcw15+fzg7itLK6V7TXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tHFr81aKKHloyJjES0gvTTS2YxkLzduoockropylNePt0IgsrcB7HQhAeXPZvTUHj7yaadS5M8j2H9eEVYYMW6sEpbet8G2s4vGFNpujy3olRGXiW9k4HyEciepKpyMswh8B5oCiaN35TC2qz1m+BIffDp56MKeK38m37kCRZ9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=GEQPGyAQ; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="GEQPGyAQ"
Received: (qmail 21411 invoked by uid 109); 8 Sep 2025 16:16:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=KP71DmYAh+buAGC9ddZQtjfXcw15+fzg7itLK6V7TXo=; b=GEQPGyAQCaqFDG3spVTu5bQPxeCYMbPU2n+9m1ybpqXzBAQW9nrX0ym+ouot+kAgi+eifmIE2eveU8HFeTKOiQEAjjmu8TQf+cWOsj+nCNbDr9451gCdoQ7u6niJzQrtA+2eQbxIW4q1XqVI5E/PCXcVsl79f4y16ZbFBHydNCA5QB2goY7EQq7BPXbUozhQSfHSmZaeUzHZp6fLDivdHGM7sqfjIzEubI0kurNLVTsJYwrgqSVSDuIiQO3hKNlHDBR5EbLcR8OY9tWw6SBblPTtaDXW0VToFJttXY6kOx3upOCPc0kAXFF7buLNI3h8CeNXBroHEumIX+5lQmg8Jg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 08 Sep 2025 16:16:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 34752 invoked by uid 111); 8 Sep 2025 16:16:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 08 Sep 2025 12:16:49 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 8 Sep 2025 12:16:48 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Isaac Oscar Gariano <isaacoscar@live.com.au>, git@vger.kernel.org
Subject: Re: [PATCH 2/4] add-interactive: respect color.diff for diff coloring
Message-ID: <20250908161648.GC1308482@coredump.intra.peff.net>
References: <20250821070740.GA3356411@coredump.intra.peff.net>
 <20250821071918.GB1839835@coredump.intra.peff.net>
 <aLfs7wuFpMhg8fK_@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aLfs7wuFpMhg8fK_@pks.im>

On Wed, Sep 03, 2025 at 09:23:27AM +0200, Patrick Steinhardt wrote:

> > +static int check_color_config(struct repository *r, const char *var)
> >  {
> >  	const char *value;
> > +	int ret;
> > +
> > +	if (repo_config_get_value(r, var, &value))
> > +		ret = -1;
> 
> Not an old issue, but should we use `GIT_COLOR_UNKNOWN` here?

My initial reaction was: yeah, we could probably fix this up in a
preparatory patch. But the problem is much deeper than the
add-interactive code. Nobody uses GIT_COLOR_UNKNOWN at all! Even
git_config_colorbool() just returns -1.

Moreover, it does not even use the ALWAYS/NEVER defines, but just 1 and
0. Making things even more complicated, we sometimes want to consider
"do we want color" as this always/never/auto/unknown set, and then
sometimes we collapse that (using the same variable!) into a single
true/false value.

So using that consistently and possibly switching to an enum is a much
bigger topic. It may be worth cleaning up, but I don't think it's worth
derailing this regression fix. In the meantime, I'd rather keep this
code matching the rest of the color code (it's not even really adding
new instances of "-1", but just shuffling them around).

> > -	if (want_color_fd(1, -1)) {
> > +	if (want_color_fd(1, s->s.use_color_diff)) {
> >  		struct child_process colored_cp = CHILD_PROCESS_INIT;
> >  		const char *diff_filter = s->s.interactive_diff_filter;
> >  
> 
> We're printing the diff here, and this change is the whole point of this
> commit as far as I understand as we now properly respect configured diff
> colors.

Yes. I would have liked to split it up more to make this hunk stand out,
but there's some chicken-and-egg dependencies.

> > +test_expect_success 're-coloring diff without color.interactive' '
> > +	git reset --hard &&
> > +
> > +	test_write_lines 1 2 3 >test &&
> > +	git add test &&
> > +	test_write_lines one 2 three >test &&
> > +
> > +	test_write_lines s n n |
> > +	force_color git \
> > +		-c color.interactive=false \
> > +		-c color.diff=true \
> > +		-c color.diff.frag="bold magenta" \
> > +		add -p >output.raw 2>&1 &&
> > +	test_decode_color <output.raw >output &&
> > +	test_grep "<BOLD;MAGENTA>@@" output
> > +'
> > +
> 
> Should we also verify that the interactive prompts aren't colored here?

Seems reasonable. Knowing that the patch is splitting the diff coloring
off of the interactive, it would be pretty hard to introduce such a bug.
But from a black box perspective, that is probably a good thing to test.

Ultimately the best test would be for every item that _could_ be colored
by each type to be individually checked in each scenario. But I didn't
want the test to depend on enumerating those very specific details of
the code.

-Peff
