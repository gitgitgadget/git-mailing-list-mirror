Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB447F
	for <git@vger.kernel.org>; Mon,  1 Apr 2024 02:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711938758; cv=none; b=RjOybUQhtgvcwOuM86BunS6ZfBz7INaOW5QStP/Vqzvvt2hdUSnPQwimB5npgiJOxAqMVy/52atg42WdXwCHlEWpdS2qXTlG0d8iojuMaxaG9EoVRjCiMuSHKQz++1/u1JlMs+bK13ZeuQMD2Zo9lhEZUvQ21S6CI6FW2R/G5Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711938758; c=relaxed/simple;
	bh=ryX1a7GYRM3jUvPaj4A+cUVJf3Xs+3YE4CNG1ww6efA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eeyZfbVi1sL1UNtrNxdpKxyvT0GfsIrANtCrSdCtMyE9TqN8Vyg4QlSSS5sSQS6V50iAfCGtqlyRx0bn/OCB6P4veP+w9NlMiRfZ79aUC9Mq5TAabvn3QjOxxNID3WWIakjq+oD4MpHCU22YqJvlUjMFhDLdquQVpE0oDT8i7ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 12938 invoked by uid 109); 1 Apr 2024 02:32:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 01 Apr 2024 02:32:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14270 invoked by uid 111); 1 Apr 2024 02:32:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 31 Mar 2024 22:32:29 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 31 Mar 2024 22:32:25 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Peter Krefting <peter@softwolves.pp.se>, git@vger.kernel.org,
	"Osipov, Michael (IN IT IN)" <michael.osipov@innomotics.com>
Subject: Re: [PATCH v2] bisect: Honor log.date
Message-ID: <20240401023225.GA2639800@coredump.intra.peff.net>
References: <3ec4ec15-8889-913a-1184-72e55a1e0432@softwolves.pp.se>
 <xmqqh6gni1ur.fsf@gitster.g>
 <5ea0837f-2668-028d-4094-c9400e92fceb@softwolves.pp.se>
 <xmqq7chif1pu.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7chif1pu.fsf@gitster.g>

On Sun, Mar 31, 2024 at 03:58:21PM -0700, Junio C Hamano wrote:

> Again, the output from them do not have to be identical---we are
> primarily after catching unintended loss of informatino in such a
> comparison, while gaining more confidence that it is a better
> approach to use "show" output to produce output for end-user
> consumption.
> 
> We have changed the bisect output before, as recent as in 2019 with
> b02be8b9 (bisect: make diff-tree output prettier, 2019-02-22), and
> heard nobody complain, so once we get to a reasonable set of options
> and land this patch, maybe we can try improving on it safely.

I guess that commit is what brought me into the cc. I have not been
following this topic too closely, but generally I'm in favor of using
"git show". I even suggested it back then, but I think Christian
preferred not using an external process if we could avoid it.

The thread from 2019 is here:

  http://lore.kernel.org/git/20190222061949.GA9875@sigill.intra.peff.net

which links to the earlier discussion about "git show":

  https://lore.kernel.org/git/CAP8UFD3QhTUj+j3vBGrm0sTQ2dSOLS-m2_PwFj6DZS4VZHKRTQ@mail.gmail.com/

IMHO this config thing is a good example of the strength of the separate
"show" process. If our goal is to trigger all the niceties of "git
show", it is tricky to catch them all. The revision machinery is pretty
reusable, but there's no easy way to figure out which config affects
git-show and so on. Of course if we had a way to invoke git-show
in-process that would work, but I suspect there are unexpected corner
cases that might trigger.

> FYI, attached is a comparison between the diff-tree output and
> output from show with my choice of options for "show" picked from
> the top of my head.  I do not think I personally like the --stat
> output applied to a merge (--stat and --summary do not work N-way
> like --cc does for patch text), but I think these options are the
> closest parallel to what we have been giving to "diff-tree".

I think it was me who added the --cc in 2019; before then we simply
showed nothing at all for merges. I am inclined to say that --cc is not
really that useful for a bisection at all. If a merge introduces a bug,
it _might_ come from a resolved hunk that would be shown by --cc
--patch, but it is just as likely to me that there is some semantic
conflict between the two sides.

For a workflow like the one we use in git.git, where we are merging
topic branches to a long-running branch, I think that showing the
-stat/--summary against the first parent is what you want. We know that
things worked in merge^1, so we show the changes brought in by merge^2.
That does not necessarily mean that the changes in merge^1 are not to
blame, but at least the changes in merge^2 give you a good place to
start.

For a workflow where you do lots of back-merges, it is less clear that
showing the changes against the first parent is better than against
others. But I still think the "well, at least showing the changes
against one parent gives you an idea of where to start looking" logic
applies. And showing the "-m" diff against every parent often has a lot
of useless noise.

I don't think I considered all this back when adding --cc in 2019. But I
believe that "--stat --cc" is just showing the diff against the first
parent. Which happens to be what I think this useful, biased of course
by the fact that projects I work on tend to use a topic-branch workflow. ;)

Arguably passing "--diff-merges=first-parent" would more directly
express the intent (I don't think that existed back in 2019).

Of course with "git show" we do not need to even say anything, since
"--cc" is the default and it does what we (I) want.

(I was puzzled that earlier in the thread you said "it no longer shows
the diffstat when the final commit turns out to be a merge commit". It
looks like it still does?).

I do think keeping --summary is important; it's the only place we show
mode changes, for example.

The other changes you outlined all seem like improvements to me.

Looking at Peter's patch, I think:

  - "--no-patch" is doing nothing (passing --stat is enough to suppress
    the default behavior of showing the patch).

  - "--pretty=medium" is redundant at best (it's the default), and
    possibly overriding a different decision "show" might make (I don't
    remember if we have a way for a user to configure the default show
    format for commits, but if we did, I think users would expect it to
    kick in here)

  - I'm not sure what the intent is in adding --no-abbrev-commit. It is
    already the default not to abbreviate it in the "commit <oid>" line,
    and if the user has set log.abbrevcommit, shouldn't we respect that?
    It seems to me the point of the patch is that "git show" represents
    the way users expect to see commits shown, and we should let it do
    its thing as much as possible.

-Peff
