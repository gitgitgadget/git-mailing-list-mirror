Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F67D534
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 08:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 29693 invoked by uid 109); 11 Jan 2024 08:04:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 11 Jan 2024 08:04:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3737 invoked by uid 111); 11 Jan 2024 08:04:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 11 Jan 2024 03:04:32 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 11 Jan 2024 03:04:29 -0500
From: Jeff King <peff@peff.net>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>,
	Git List <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] advice: allow disabling the automatic hint in
 advise_if_enabled()
Message-ID: <20240111080429.GG48154@coredump.intra.peff.net>
References: <7c68392c-af2f-4999-ae64-63221bf7833a@gmail.com>
 <d6099d78-43c6-4709-9121-11f84228cf91@gmail.com>
 <20240110110226.GC16674@coredump.intra.peff.net>
 <aaf59fc82ef3132ece8e1f70623570a2@manjaro.org>
 <97fdf6d4-1403-4fe9-b912-a85342a9fa56@gmail.com>
 <a97b03a305a7b8b95341b63af1de0271@manjaro.org>
 <xmqqil41duov.fsf@gitster.g>
 <d6d72ec5431ad1ca775e6e4e9921f94c@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d6d72ec5431ad1ca775e6e4e9921f94c@manjaro.org>

On Wed, Jan 10, 2024 at 06:45:49PM +0100, Dragan Simic wrote:

> 4) As a careful git user that remembers important things, you go back
> to your git configuration file and set core.verboseAdvice to true, and
> the additional advices are back, telling you how to disable the
> unwanted advice.
> 
> 5) After you disable the unwanted advice, you set core.verboseAdvice
> back to false and keep it that way until the next redundant advice
> pops up.
> 
> However, I do see that this approach has its downsides, for example
> the need for the unwanted advice to be displayed again together with
> the additional advice, by executing the appropriate git commands,
> after the above-described point #4.

Right, the need to re-trigger the advice is the problematic part here, I
think. In some cases it is easy. But in others, especially commands
which mutate the repo state (like the empty-commit rebase that started
this thread), you may need to do a lot of work to recreate the
situation.

> Let's see what it would look like with the granular, per-advice on/off
> knobs:
> 
> 1) You use git and find some advice useful, so you decide to keep it
> displayed.  However, the additional advice about turning the advice
> off becomes annoying a bit, or better said, it becomes redundant
> because the main advice stays.
> 
> 2) As a result, you follow the additional advice and set the specific
> knob to false, and voila, the redundant additional advice disappears.
> Of course, it once again isn't perfect, as the next point will clearly
> show.
> 
> 3) You keep using git, and one of the advices that you previously used
> to find useful becomes no longer needed.  But, what do you do, where's
> that helpful additional advice telling you how to turn the advice off?
> 
> 4) Now you need to dig though the manual pages, or to re-enable the
> additional advices in your git configuration file, perhaps all of them
> at once, while keeping a backup of your original settings, to restore
> it later.  Then, you again need to wait until the original advice gets
> displayed.

These steps (3) and (4) seem unlikely to me. These are by definition
messages you have seen before and decided to configure specifically (to
"always", and not just "off"). So you probably only have a handful (if
even more than one) of them in your config file.

Whereas for the case I am worried about, you are exposed to a _new_
message that you haven't seen before (and is maybe even new to Git!),
from the much-larger pool of "all advice messages Git knows about".

It's possible we could implement both mechanisms and let people choose
which one they want, depending on their preferences. It's not very much
code. I just hesitate to make things more complex than they need to be.

-Peff
