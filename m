Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7401C0DE7
	for <git@vger.kernel.org>; Mon,  1 Apr 2024 16:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711989134; cv=none; b=YMQZPsgGKQgpmgXiej1nIXl04u77Z/PdekNBc+kZSzd4Ak4b74IX2Drj9Wn2Rlitosf4NO1b9nJWHtlx1RrwrswY3cWSoAhFsoSXTvIFBtMlqonXW6aAP7cx4xvYsH7Z5jLFjVjfgXFb/2pp3sH+2YXwczRn0FQO58HRgUDFv5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711989134; c=relaxed/simple;
	bh=5oiTdZhe76jYrEQ1MEaVkWuYnObtGWpLEA1a3tVe2U4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EUL9L+E68QQkVO8udASs8k1Wjh+UU5LfZz3BiYVl8/R8WWKeeEE8lMa2ANCWU6+TuZ/SSa5ON4xL14RFXsy05YgIlE8jtK471Kp3Q41rfeSzAmpeh2aG43fXAd8FmMwDSAPwriIEoXk3ZKf5x35d34YUnsh9UgEfpuoJctna1cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 23042 invoked by uid 109); 1 Apr 2024 16:32:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 01 Apr 2024 16:32:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20886 invoked by uid 111); 1 Apr 2024 16:32:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 01 Apr 2024 12:32:11 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 1 Apr 2024 12:32:09 -0400
From: Jeff King <peff@peff.net>
To: Peter Krefting <peter@softwolves.pp.se>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"Osipov, Michael (IN IT IN)" <michael.osipov@innomotics.com>
Subject: Re: [PATCH v2] bisect: Honor log.date
Message-ID: <20240401163209.GB3120568@coredump.intra.peff.net>
References: <3ec4ec15-8889-913a-1184-72e55a1e0432@softwolves.pp.se>
 <xmqqh6gni1ur.fsf@gitster.g>
 <5ea0837f-2668-028d-4094-c9400e92fceb@softwolves.pp.se>
 <xmqq7chif1pu.fsf@gitster.g>
 <20240401023225.GA2639800@coredump.intra.peff.net>
 <c13c0751-0758-e068-282e-eb43496213b8@softwolves.pp.se>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c13c0751-0758-e068-282e-eb43496213b8@softwolves.pp.se>

On Mon, Apr 01, 2024 at 04:50:32PM +0100, Peter Krefting wrote:

> I am trying to run some comparisons, but I'm not entirely certain what the
> parameters are that were passed to "ls-tree", as it doesn't actually run it
> through a command line. I tried the v1.0.0^0 and are seeing discrepancies in
> the line count. I need to check if it is my configuration that causes it, or
> something else:
> 
>   $ git diff-tree --pretty --stat --summary --cc v1.0.0^0 | grep clone-pack.c
>    clone-pack.c                                     | 153 ++----------------
>   $ git show --stat --summary --no-abbrev-commit v1.0.0^0 | grep clone-pack.c
>    clone-pack.c                                     | 151 ++----------------
> 
> (these are the options I've currently landed on)

Hmm, I get 153 for both. Presumably it's due to some config that only
git-show respects...

Aha. If I set diff.algorithm to "patience", I get 151. And I think
bisect would produce the same, because it loads diff_ui_config() before
running the internal diff-tree.

So I think this is fine.

> > $ git show -s --stat --summary --first-parent v1.0.0^0
> 
> Hmm, the git show manual page doesn't document supporting "--first-parent".

I think that's a documentation bug(-ish). We do not include all of the
traversal-related options that "git log" could use because "git show"
does not traverse by default. But it does also affect diffs, per the
comment added to git-log's documentation in e58142add4
(doc/rev-list-options: document --first-parent changes merges format,
2020-12-21).

But these days we have "--diff-merges=first-parent", which I think is a
more intuitive way to specify the same thing for git-show. And it is
documented. So I'd say we could probably continue to not mention
"--first-parent" itself for git-show.

> Jeff King:
> 
> > I guess that commit is what brought me into the cc. I have not been
> > following this topic too closely, but generally I'm in favor of using
> > "git show". I even suggested it back then, but I think Christian
> > preferred not using an external process if we could avoid it.
> 
> I saw the code that tried to avoid calling one. I don't know the internals
> well enough here to figure out if we can do without, even when using git
> show?

There's not really an easy way.

I think the only thing you could do is call cmd_show(), but I'm
skeptical of that approach in general. The builtin top-level commands
are not designed to be run from other spots. And while it will generally
work, there will be corner cases (e.g., loading config that touches
globals, affecting the calling command in unexpected ways). I suspect
you could largely get away with it here where showing the commit is the
last thing we do, but I don't think it's a good pattern to get into.

> That made me realize, if "git show" runs things through a pager, wouldn't it
> then lose the "%s is the first %s commit\n" message printed by
> bisect_next_all() before calling the function to show the contents?
> 
> Is that fixable?

Good catch. IMHO we should disable the pager entirely by sticking
"--no-pager" at the front of the child argv. But then, maybe somebody
would like the output to be paged? I wouldn't.

If we really wanted to keep the pager for git-show, I guess we'd need to
have it print the "%s is the first %s commit" message. The only way I
can think to do that is to pass it as a custom --format. But then we'd
need to additionally specify all of the usual "medium" format as a
custom format, too, which is quite ugly.

> I think I added it because the diff-tree command did something similar. I
> can drop that as well ("bisect" displays the full commit hash anyway). I
> guess it mostly is for merges where we show the parent hashes?

No, I don't think the "Merge:" lines are affected by it either way.
Those are always abbreviated, and looking at pretty.c's
add_merge_info(), I don't think there is any config that affects it.

-Peff
