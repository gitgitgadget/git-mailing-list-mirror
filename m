Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D0E847A
	for <git@vger.kernel.org>; Sat,  6 Jul 2024 06:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720247860; cv=none; b=fYcHKojxIOnFb5VilL2/cH1QY6uBh8lpVSJ40ZzYal66gOu+Y417bwYnSCGd8LYF4Ni0uq8o8MBEdKVGUt8Yo0Wq42h+j2TKr0ytoGazlIJAR1ieC0BNNgfzfuL+lCpOGsglzF0f3/btEtfcKJXLMS6qvPOt40qhLrSilQe5KUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720247860; c=relaxed/simple;
	bh=mXQ8UmgTl8c+NrJEu2P/ecbYNczPuDWCi9wzHDitSAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=faxuUTbeVrDcjkQrS3xmV97po01Im3XUdHPsIBdu7nv9zntvk4TV+pSaskg5bPtxDt7nJGAAg8yFHtd4Nh+NXGtJn7Haa4Jr6Uc4S2Dj+bM+hs8LDDgzbvspeZvdo1wNTuVZrkc2OIwnoGJD721S5GutRn6Hg3QiNZI1ZvGbVXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 23984 invoked by uid 109); 6 Jul 2024 06:37:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 06 Jul 2024 06:37:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31438 invoked by uid 111); 6 Jul 2024 06:37:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 06 Jul 2024 02:37:35 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 6 Jul 2024 02:37:37 -0400
From: Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Sean Allred <allred.sean@gmail.com>,
	Git mailing list <git@vger.kernel.org>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: Should commit-msg hook receive the washed message?
Message-ID: <20240706063737.GF700645@coredump.intra.peff.net>
References: <m0h6d3pphu.fsf@epic96565.epic.com>
 <CAPig+cTpxXNwy8MYWjcDTa5QPoq5Mod3_LZ=+F16-gF5QVbrkg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cTpxXNwy8MYWjcDTa5QPoq5Mod3_LZ=+F16-gF5QVbrkg@mail.gmail.com>

On Fri, Jul 05, 2024 at 05:35:25PM -0400, Eric Sunshine wrote:

> > This seems like a bug to me; is there something I'm missing? I would
> > propose adding a call to `cleanup_message` (with the appropriate
> > arguments) inside `prepare_to_commit` right before `commit-msg` is
> > invoked.
> 
> The idea of calling cleanup_message() has been discussed before[1]. My
> takeaway from reading that message is that calling cleanup_message()
> unconditionally before invoking the hook could potentially throw away
> information that the hook might want to consult. It's possible to
> imagine a workflow in which a specialized comment is inserted in a
> commit message to control/augment behavior of the hook in some
> fashion.

Yeah, looking over that earlier discussion, I think the main takeaway is
that the unsanitized version might have useful information for the hook.
I don't know of any real workflow that relies on that, but it does seem
possible that somebody has one.

> The idea you proposed in a different thread[2] of exposing
> cleanup_message() functionality as a user-facing utility which a hook
> can call on an as-needed basis may make more sense(?).

So yes, I like that approach much better. But as noted elsewhere, the
hook has to understand which cleanup mechanism is going to be used.
Which could get complicated.

It would be nice if we could just provide _both_ forms to the hook. It
looks like commit-msg just takes the filename as the first parameter.
Perhaps we could extend it by passing a second one? It does mean
sanitizing and writing out the message twice, even if the hook might not
look at it, but I doubt the overhead is all that high.

-Peff
