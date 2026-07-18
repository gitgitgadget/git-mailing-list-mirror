Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2338537AA97
	for <git@vger.kernel.org>; Sat, 18 Jul 2026 08:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784363880; cv=none; b=cTrQyw+IDPDF5WKSYVrAGEE8nFtYPc0mONzO/iYiQ+CtqboiwmykuTH8e2tKALij6uj/zgvy7petdR6cAXE40KK8uwgqQQFxgqgBc0Bcm72vCOscf+8pV8mSqzJZ4Z+jE3Uo+qLbGxi389/wlxvUTwNM3bquvfbz3W4oxAzBgrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784363880; c=relaxed/simple;
	bh=68u1KOpUQVcnGeqzJf9JfjQcOnQcROc7MlD0tqZJpBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGyiJAp/T4qW2WI5aF78I7PFg8wAc9JO32JcsWwQ1EYt6Uilk7MM8GvSvhJqYm2iwbJ+sgbrwRCh6sfLGiNIK0iFL2rBTSbCBlbaJgxpdEx4d2PER2VoKOblkFX1IgqHahDqZv0h1LTht70KVgpluwqUBeFl7yXBGM4U9EX7ziQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=SgAoSD9z; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="SgAoSD9z"
Received: (qmail 60622 invoked by uid 106); 18 Jul 2026 08:37:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=68u1KOpUQVcnGeqzJf9JfjQcOnQcROc7MlD0tqZJpBU=; b=SgAoSD9zUQT4pEPbC69LNjJOTZaW5cIDwoQ1LfVgPk9nq/LUoszWqiaClTnPoyaTz57XRlzNkPJ99jUAbKMBPpVxIQRCFWs8RTYRuYyDVvKn51IiweRis4rPxHfwlkU0ZIw1SkQ2miuAOeuXgmTiutzDeKfYe7sx4nm8HNKM3ZrTLzQa/POMfgo/imCEwFFCVCP5HezWq82lclsRoWDl2wF4djgvZ2G7o3voAQ9sGx1NuWiOotLKmi1pmiOEyQYXE6XKJjb8qE0iyaJyKvCfovsuJmnMorCaFtnn5w4T9QfI7yuP5J+l51xThZ17e+YHAF+kEHNvfPQzcV/DnPk1QA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 18 Jul 2026 08:37:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 107126 invoked by uid 111); 18 Jul 2026 08:38:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 18 Jul 2026 04:38:02 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 18 Jul 2026 04:37:57 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <ttaylorr@openai.com>
Cc: Toon Claes <toon@iotcl.com>, git@vger.kernel.org,
	Gusted <gusted@codeberg.org>
Subject: Re: [PATCH 3/4] last-modified: check pathspec against Bloom filter
 first
Message-ID: <20260718083757.GD22588@coredump.intra.peff.net>
References: <20260717-toon-speed-up-last-modified-v1-0-410418f18614@iotcl.com>
 <20260717-toon-speed-up-last-modified-v1-3-410418f18614@iotcl.com>
 <alq1Q55ezuN9ZI9j@com-79390>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alq1Q55ezuN9ZI9j@com-79390>

On Fri, Jul 17, 2026 at 06:05:39PM -0500, Taylor Blau wrote:

> > diff --git a/builtin/last-modified.c b/builtin/last-modified.c
> > index 5478182f2e..e8ee610404 100644
> > --- a/builtin/last-modified.c
> > +++ b/builtin/last-modified.c
> > @@ -272,6 +272,9 @@ static bool maybe_changed_path(struct last_modified *lm,
> >  	if (!filter)
> >  		return true;
> >
> > +	if (revs_maybe_changed_in_bloom(&lm->rev, filter) == 0)
> 
> Nit: please prefer 'if (!foo())' over 'if (foo() == 0)'.

Yeah, though there is some subtlety here because of the tristate return
I described elsewhere in the thread. I think if we switch to a boolean
return then a straight "!" becomes even more desirable.

> I don't think this is safe with '--show-trees'. The original pathspec
> does not cover every entry in 'lm->paths', since the function
> 'populate_paths_from_revs()' also adds ancestor tree entries.

Hmm, interesting. I am surprised to learn that "-t" includes "d" when
the pathspec asked for "d/a". I thought it was mostly about showing
"d/a" when we recurse to find "d/a/b". But I guess it does not make a
distinction between the two (probably because it is just telling the
diff code to show trees, and it does not further apply the pathspec to
the output).

Does this mean there is also a bug in "git log"? I guess not, because it
is purely pruning based on the pathspec, and only shows "d/" for those
commits.

>         git -c core.commitGraph=false last-modified -t HEAD -- d/a \
>             >expect &&
>         git -c core.commitGraph=true last-modified -t HEAD -- d/a \
>             >actual &&

A minor side note: the documentation claims "-t" has no effect without
"-r", but it clearly is not true (it tells us to show "d", even when we
are not recursing).

> I think that the conditional is otherwise correct, if guarded when we
> know that 'lm->show_trees' is false, like so:
> 
>     if (!lm->show_trees &&
>         !revs_maybe_changed_in_bloom(&lm->rev, filter))
>             return false;

Hmph. That makes this optimization all but useless, because the intended
use case of last-modified is almost always going to use "-t" to be able
to mark the interior trees. And most callers are not going to care about
seeing "d" here; their purpose was to find out about the things _inside_
"d".

Would we consider removing "d" from the output for this case? Presumably
by double-checking the pathspecs again in add_path_from_diff(). That
gives less surprising output (to me, anyway) and would enable this
optimization. And the command is still marked as experimental, and I
think this is exactly the kind of corner case that is meant to cover.

-Peff
