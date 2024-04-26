Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBD52C68A
	for <git@vger.kernel.org>; Fri, 26 Apr 2024 20:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714164109; cv=none; b=FjEXkV444OppOWS6nM0Cg59Eo/DICecEWzGeVwWisHftS8bhFnDKUOxH/x7bTmWHTJASKmZtt1EBClDegKogD93ZBQ2NDiaIPPjDajFODQv+AkVTdPW+pJ3zdUXTwrN8Bqn5rsjlR51UqhoLYJaMmgdpDJ1csoCU0WuNn5jvNXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714164109; c=relaxed/simple;
	bh=iPnnvvefPdBft9WlJKaG+D3SCmVn/+rnT+uYufKOXfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXiGxzPt/ugsbXiCkH80EJPb+GgbhJlBceQL09IS6Rt0K9GrAGGc7m/WgMHMGDgrQPMBRezIx3b4KbhQFGoa7Ti61CgoA4yz8lTlrmpaNOq2i3NejnCZnW4neKz6sGdKz6YbsyS/JJlaMm+vRcHt8qgKiQIUVu7814TDTlphu0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 13628 invoked by uid 109); 26 Apr 2024 20:41:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 26 Apr 2024 20:41:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3201 invoked by uid 111); 26 Apr 2024 20:41:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 26 Apr 2024 16:41:47 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 26 Apr 2024 16:41:45 -0400
From: Jeff King <peff@peff.net>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: chris.torek@gmail.com, git@vger.kernel.org, gitster@pobox.com,
	ps@pks.im
Subject: Re: [PATCH v3 0/8] refs: add symref support to 'git-update-ref'
Message-ID: <20240426204145.GC13703@coredump.intra.peff.net>
References: <20240412095908.1134387-1-knayak@gitlab.com>
 <20240423212818.574123-1-knayak@gitlab.com>
 <20240423220308.GC1172807@coredump.intra.peff.net>
 <CAOLa=ZRk8QR4qkbkRm6AirapdrAqz6bG-tXfY3zRQU_9XkJM1Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOLa=ZRk8QR4qkbkRm6AirapdrAqz6bG-tXfY3zRQU_9XkJM1Q@mail.gmail.com>

On Wed, Apr 24, 2024 at 09:25:27AM -0700, Karthik Nayak wrote:

> This also brings light onto the previous versions we were considering:
> 
>     symref-update SP <ref> SP <new-target> [SP (<old-target> | <old-oid>)] LF
> 
> There is also some ambiguity here which we missed, especially when we
> support dangling refs. If we're updating a dangling ref <ref>, and we
> provide an old value. Then there is uncertainty around whether the
> provided value is actually a <old-target> or if it's an <old-oid>.
> 
> For non dangling ref symref, we first parse it as an <old-target> and
> since the <old-target> would exist, we can move on.
> 
> So I see two ways to go about this,
> 
> 1. In the symref-update function, we need to parse and see if <ref> is a
> regular ref or a symref, if it is symref, we simply set the provided old
> value as <old-target>, if not, we set it as <old-oid>. This seems clunky
> because we'll be parsing the ref and trying to understand its type in
> 'update-ref.c', before the actual update.

I think this avoids the "mischief" case I mentioned because it is about
looking at what is in <ref> currently, not spooky action from a
possibly-unrelated "refs/heads/ref". But in general, I think it is a
good thing if we can tell what the caller is asking for based only on
the syntax of the request, without taking into account repository state.
It just makes things easier to reason about.

> 2. We change the syntax to something like
> 
>     symref-update SP <ref> SP <new-ref> [SP (ref <old-target> | oid
> <old-oid>)] LF
> 
> this would remove any ambiguity since the user specifies the data type
> they're providing.

Yeah, I was going to suggest that it could be resolved with any syntax
that would not be a valid oid name. Certainly check-ref-format places
some restrictions there (e.g., no "^") but name resolution relies on
that, too (so foo^{tree} is a valid name). Probably something like
"^foo" is unambiguous, but it's ugly and hard to explain. ;)

But I think your "ref <old-target>" solves that. Resolved names can have
spaces in them, but only after a "^" (e.g., "foo^{/some regex}") or ":"
(e.g., "foo:path with spaces"). So seeing just "ref" by itself, followed
by a space, I think is unambiguous. And it looks pretty.

It gets a little tricky when the field delimiter is also space, and the
item in question is not the final field. See below.

> Also on a sidenote, it's worth considering that with the direction of
> [2], we could also extrapolate to introduce {verify, update, create,
> delete} v2, which support both symrefs and regular refs. But require
> explicit types from the user:
> 
>     update-v2 SP <ref> NUL (oid <new-oid> | ref <new-target>) NUL
> [(oid <old-oid> | ref <old-target>)] NUL
> 	create-v2 SP <ref> NUL (oid <new-oid> | ref <new-target>) NUL
> 	delete-v2 SP <ref> NUL [(oid <old-oid> | ref <old-target>)] NUL
> 	verify-v2 SP <ref> NUL [(oid <old-oid> | ref <old-target>)] NUL
> 
> This is similar to the v3 patches I've currently sent out, in that it
> would also allow cross operations between regular refs and symrefs.

So I _think_ that "<oid> | ref <symref-target>" is unambiguous. In which
case you could just have:

  update SP <ref> NUL (<new-oid> | ref <new-target>) NUL [(<old-oid> | ref <old-target>)]

which is backwards-compatible.

With the NUL separator it's easy to parse, because "ref " with a
trailing space always means a ref, even in the "new" field. But with
spaces instead, it gets weird. If you have:

  update refs/heads/foo refs refs/heads/bar

it can either be creating a symref to "bar" (with no "old" specifier) or
it could be pointing it at the resolved-name "refs", which the old value
coming from "bar".

I guess one option would be to only allow "ref" syntax in "-z" mode, but
that is probably getting to be a bit weird and hard to explain.

-Peff
