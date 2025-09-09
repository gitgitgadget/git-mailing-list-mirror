Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149493009CD
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 18:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757443252; cv=none; b=be5x9QPtI+fquKI82vWwUVwSUxvKhYQvICc2XUvUlmXaJP37L2wX7w7ASYxAdUUxAlEP7NXWd1UFzwahDpQ5HVM4OXwSuj4OlF7/NHuWBEAGpMdF1EWyJC7ZfEixNhmTcbihQr/BQnBhaTNjO5BUe16FGTgnLcoQ5vhykmMy3Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757443252; c=relaxed/simple;
	bh=pPl+gGTOchIfEQ89DeLins8BG8jwqPvliMyec0dAb4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZEz0ocKmYIEx7TP3CAP58qdlDTzXxuiDdbu5nrR3HbsWEglg75MBGf4GTpfd8Z6L7sacRr+Ex0NtdnfgFNsR8azTZP7trnXMRis2tovjbLVnNzrNoTY83VBB7d9ISaEFz+lvrBcX3PB5IoIdbDKFJ8uLXZMzCcQSDrng/PcE7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=eKI7+nCU; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="eKI7+nCU"
Received: (qmail 31956 invoked by uid 109); 9 Sep 2025 18:40:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=pPl+gGTOchIfEQ89DeLins8BG8jwqPvliMyec0dAb4k=; b=eKI7+nCU8QjvtRV9wckHEV5Vfvse26gamTc/I2FG0UfUyLNhsuUK6HzfKfsIxzBdh1/AR6ZuVWaIAafnkhQmoZgVW5Bv/fiLHu8EwPr0IFDeJOtGP+I/YDLyVOMcdbJRc0XpPpvf2yy9+0ZVbjeuf9WeK2Fpvdk+3yNLRSznIRcUKBzkrJjotVdBghKq5J3VMe6l2M7XRGX3x6UB6sm2Ag0OdX8U/cShOnxUSL6MWZ6IyY+N5BoqZbzOVES8KD4DjUELk/lCCZkQfVS18HjjunqbP5HxHjaEa06Qmu58UmIMW61f+sUzZc/84o7IIX2v4OXsfra/h1/R1/AX0vIW9g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 09 Sep 2025 18:40:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 54116 invoked by uid 111); 9 Sep 2025 18:40:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 09 Sep 2025 14:40:46 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 9 Sep 2025 14:40:45 -0400
From: Jeff King <peff@peff.net>
To: Jon Forrest <nobozo@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Is Git Add Supposed to Work Like This (git 2.50)?
Message-ID: <20250909184045.GA1912898@coredump.intra.peff.net>
References: <63045080-74d6-4835-9d9c-4d3558acdbfb@gmail.com>
 <20250907233456.GA1281511@coredump.intra.peff.net>
 <b8df3605-7afe-4121-ae50-095dfd671df9@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b8df3605-7afe-4121-ae50-095dfd671df9@gmail.com>

On Tue, Sep 09, 2025 at 09:00:34AM -0700, Jon Forrest wrote:

> > I guess one could argue either way (though probably not at this point in
> > time, as switching behaviors would cause confusion). But one challenge
> > with "partial success" like this is that the exit code is binary. If we
> > return "0" even though some items were ignored, callers may miss a
> > failure. If we return "1" even though some items were added, callers may
> > not realize they've mutated the state (and might need to rollback
> > depending on what they were trying to accomplish).
> 
> If this were a big deal, which it isn't, I'd suggest a command line
> flag that says what to do if there's an invalid file specified on
> the command line. One setting of the flag would result in the
> current behavior and the other setting would result in all the
> invalid file(s) being ignored and the valid file(s) being
> handled normally.

Interestingly there are a few --ignore-* options, including
--ignore-missing, which I think does what you want. But it only works
with --dry-run. I didn't dig into the rationale.

-Peff
