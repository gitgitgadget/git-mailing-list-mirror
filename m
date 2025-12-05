Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AFC38A8A0
	for <git@vger.kernel.org>; Fri,  5 Dec 2025 18:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764960412; cv=none; b=S9WHWlgKQWNStT0rWem7Q8aqNezrLahc0mLbFbk/rx+8g8fjD4NPXmQQgSWBxI4+OJC3zXPd3PV4ifeNtBvWQMa6dGBF93J+5Ams77rWnGXg6qESCz+/M70+15m0PYWQTcca5RizqKeHnB9rdiyeXGs7Ghqk4aKfQ8KeNhwH0kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764960412; c=relaxed/simple;
	bh=jlysnjVk/evV0P8JIS/klC10ac3E+4e19frs8S8IZDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V67HlDQioCi48KlqqR/ONfARxjZ3/LOhZp2nUgbEuBIzJz5JaO1eTW/S+BQd0exQjUbsUqeb/7hxEhTUCwnsez6N2hrQAWj51Rh7MXcCUwcrzw1ual2x72y8pO6sMb8LIG530g6NirPTdR1edvSim32h9I8kt7iyJ1Hg+LtVK34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=KJBfFb6N; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="KJBfFb6N"
Received: (qmail 271937 invoked by uid 109); 5 Dec 2025 18:46:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=jlysnjVk/evV0P8JIS/klC10ac3E+4e19frs8S8IZDM=; b=KJBfFb6N5T55voXGPFlozs3CUTy3KDwi9Z5yTQj/6VVCy8Up5pyMvDnxzrqKJPhDKaQaV6dS4g+UFcbX0PrTPLoj+MLE40Rqau7PtJUKk5lZ59sLpppnvD9NK07puWh7+vpNTqlvRacVf7L5uLtqsSVbsuQPLUB8efbz3l3EoqcoV/Bp7p6F6xZ6fvpa0YC/CmbyfZ2kncuHAYu5hh/9ITHmT34R+3dt4zL8CuUhQ2q7XKSbnEZRhBzklk26hKYtam6lhMgfVOu/epKE1fTfnYuhBHqmgscZTpsc5Oy6+KnM825Lf/SRXcF/TWATeWQ8vSnMWqhRfkH5hb4zZQMojA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 05 Dec 2025 18:46:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 340525 invoked by uid 111); 5 Dec 2025 18:46:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 05 Dec 2025 13:46:50 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 5 Dec 2025 13:46:48 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: Paulo Casaretto via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Paulo Casaretto <pcasaretto@gmail.com>
Subject: Re: [PATCH] lockfile: add PID file for debugging stale locks
Message-ID: <20251205184648.GC33447@coredump.intra.peff.net>
References: <pull.2011.git.1764688047077.gitgitgadget@gmail.com>
 <20251203211610.GA64204@coredump.intra.peff.net>
 <aTDFks3RW57Ytwvq@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aTDFks3RW57Ytwvq@nand.local>

On Wed, Dec 03, 2025 at 06:19:46PM -0500, Taylor Blau wrote:

> Changing the naming scheme as above would cause us to hold
> "foo.pid.lock" in addition to "foo.lock". That would allow process B
> here to write branch "foo.lock.pid" (as is the case today). But if the
> scenario were instead "process B wants to write branch foo.pid.lock", it
> would fail immediately since the ".lock" suffix is reserved.

I agree that this gets rid of any corruption or race issues, since all
versions understand how to handle ".lock" specially (and assuming we
create foo.pid.lock with O_EXCL). But there is still a namespace
collision; I cannot write refs "foo" and "foo.pid" at the same time.

> > So I dunno what that means for your patch. I notice that the user has to
> > enable the feature manually. But it feels more like it should be
> > selective based on which subsystem is using the lockfile (so refs would
> > never want it, but other lockfiles/tempfiles might).
> 
> Yeah, I think that something similar to the "which files do we fsync()
> and how?" configuration we have today would be a nice complement here.

I'm not sure it makes sense for the user to configure this. I more meant
that the ref files-backend code would set a flag for "no, do not create
a pid file for me ever" (or inversely, other bits of the code would
add a flag for "yes, it's OK to do so").

-Peff
