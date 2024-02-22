Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5374A154BE3
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 17:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708622582; cv=none; b=hdlOeNTZIjpB4R3X/wHbmQYwP0HYNUbHPaTyC7SSKkTc/Q0SF6cAo5vzS+/OL+/LAkrl3aZscBKV7aXMYbfZnebbVQbroCHSPYPKnuxlOovlYpOGpe9XHVjo3Fj2mASbqtlT79n42XwMB/ae7i1NCPm3wDtlCyH/izxoaAaMc5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708622582; c=relaxed/simple;
	bh=kLqdPJ4SiWweh6w7v2ftW9RtWN5HjrXRUNbsTqqSehA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T24RjXy6COVFvBN2czOmR2so8cEZg1Q4k/6ivDbosGehf2dCvjQ/OQ8LVOP4zTOq9REqejvOpAY+dr5VMwhynjMNVuwQNa6TRuHissFGp0L9z8tj/K8zpwv5IPr4LM0cB2MikA7WB/dKqK9HEAKcdXYXk///HFdoNOj/6picxrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 25283 invoked by uid 109); 22 Feb 2024 17:22:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 22 Feb 2024 17:22:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19416 invoked by uid 111); 22 Feb 2024 17:22:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 22 Feb 2024 12:22:54 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 22 Feb 2024 12:22:52 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, Yasushi SHOJI <yasushi.shoji@gmail.com>,
	Denton Liu <liu.denton@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: Segfault: git show-branch --reflog refs/pullreqs/1
Message-ID: <20240222172252.GA3535450@coredump.intra.peff.net>
References: <CAELBRWK-bZTV0qx6_34HAgpmYwy+5Zo2E0M+4B6yZJJ3CqweTw@mail.gmail.com>
 <20240221084250.GA25385@coredump.intra.peff.net>
 <xmqqv86hogpi.fsf@gitster.g>
 <ZdcNtxw04MtybTWZ@tanuki>
 <xmqq34tkiho9.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq34tkiho9.fsf@gitster.g>

On Thu, Feb 22, 2024 at 08:32:06AM -0800, Junio C Hamano wrote:

> > Hum, I dunno. I don't really understand what the benefit of this
> > fallback is. If a user wants to know the latest object ID of the ref
> > they shouldn't ask for `foo@{0}`, they should ask for `foo`. On the
> > other hand, if I want to know "What is the latest entry in the ref's
> > log", I want to ask for `foo@{0}`.
> 
> The usability hack helps small things like "List up to 4 most recent
> states from a branch", e.g.
> 
>     for nth in $(seq 0 3)
>     do
> 	git rev-parse --quiet --verify @$nth || break
> 	git show -s --format="@$nth %h %s" @$nth
>     done
> 
> vs
> 
>     for rev in HEAD @{1} @{2} @{3}
>     do
> 	git rev-parse --quiet --verify "$rev" || break
> 	git show -s --format="$rev %h %s" "$rev"
>     done
> 
> by not forcing you to special case the "current".

In those examples, though, it is useful precisely because you _do_ have
a reflog, and ref@{0} is conceptually the top entry (which brought us to
the same state as just "ref").

The question to me is more "is ref@{0} useful on its own, even when you
do not necessarily have a reflog". That I am less sure of.

> Ideally, "foo@{0}" should have meant "the state immediately before
> the current state of foo" so that "foo" is the unambiguous and only
> way to refer to "the current state of foo", but that was not how we
> implemented the reflog, allowing a subtle repository corruption
> where the latest state of a branch according to the reflog and the
> current commit pointed by the branch can diverge.  But that wasn't
> what we did, and instead both "foo@{0}" and "foo" mean to refer to
> "the latest state of foo".  We can take advantage of that misdesign
> and allow "foo@{0}" to refer to the same commit as "foo", at least
> at the get_oid_basic() level, whether a reflog actually exists or
> not, and that would make the whole thing more consistent.

I think there is some confusion here between how get_oid_basic() behaves
and how read_ref_at() is used for something like show-branch. In the
former case, we only care about getting an oid as output, but in the
latter we actually want the reflog entry (because we care about its
timestamp, message, and so on).

So in terms of reflog entries, ref@{0} should refer to the most recent
entry. And the oid it returns should be the end-result of that entry,
which (in a non corrupted repository) is identical to the current ref
value. And that "should" is reinforced by stuff like:

  git log -g "%gd %gs"

which shows the most recent entry as HEAD@{0}.

I think 6436a20284 (refs: allow @{n} to work with n-sized reflog,
2021-01-07) confused things mightily by having read_ref_at() with a
count of "n" find entry "n-1" instead, and then return the oid for the
"old" value. That makes get_oid_basic() work, because it doesn't care
about which entry we found, only the oid. But for show-branch, now we
are confused about which reflog entry ref@{1}, etc, refers to (but
ref@{0} still works because of the weird special-casing done by that
commit).

I think we should fix that (and I have the start of some patches to do
so). But in that world-view, having read_ref_at() return anything for a
count of "0" when there is no reflog does not make sense. There is no
such entry!

OTOH, we face the same problem when asking about ref@{N} when there are
only N entries. We can provide an oid (based on the "old" value from the
oldest entry we did see), but we have to "fake" the reflog entry data
(like the messsage), since there wasn't one.

So the open questions to me are:

  - should this faking happen in read_ref_at(), just returning a dummy
    reflog message? Or should we keep read_ref_at() purely about finding
    the entry, and put the special-casing into get_oid_basic(), which
    only cares about the oid result?

  - wherever we put the faking, should we only fake ref@{N} when N > 0?
    Or should we also fake ref@{0} when there is no reflog at all?

If none of this makes sense, it is because I am only now untangling what
is going on with 6436a20284. ;) I will try to polish my proposed patches
and hopefully that will explain it a bit more clearly (I may not get to
it until tomorrow though).

-Peff
