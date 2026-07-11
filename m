Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D4A239085
	for <git@vger.kernel.org>; Sat, 11 Jul 2026 07:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783755212; cv=none; b=g1UCA/D3HAR+DIWFbCFm4Xu13ux084XZhWhH0lp4v60hHAvkaCW5v/9lOfsoE6/juovgYph0vcxD76mGWgAb0Hrd1jHqNZP98B2XipOuq/7wNaEvhvTS7dteMIIY6Ky4NBGaG790y/DKHXJaZ4DzqhqDnGgpQsWjf5N6CIQXcHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783755212; c=relaxed/simple;
	bh=UItVukkiw2lAMfPOi1mJCl2jk243ZD0fIOjmaozeZ7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/hPUYy2TIc3krwXezdzfmbNyEupdF2Vdu7KDdiL4x7+j2JPzVA+BA7Yp9Ldl+zCiKsoun7IneNew5EOlnwFzU537tzZEdywx4USyZrG07qblx1DaUgf027mY2pgsbx52qdk3mQROqQCSWv5OYjgeiR+MC2Smt0h2/e06lJm124=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=N5YzT4c8; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="N5YzT4c8"
Received: (qmail 55680 invoked by uid 106); 11 Jul 2026 07:33:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=UItVukkiw2lAMfPOi1mJCl2jk243ZD0fIOjmaozeZ7c=; b=N5YzT4c8MdsMcj+4Fd6b1lW+MF12iNg8nhpXh/5cQ1ZTAoJ96l+wsUHXCE/Q7TA3du6x2s5I0+R2gShC8uc58G4zxdvBYOD3Xx7YqFKF86HxnGVjzMpRo/ajjoAI4Dhu55/RoZN58zPPIrjBLCY3HIdg15PQ/7fQOi8L7C/lukIbEDvzKPTToyF7m+JrccGFJokb9bu0JlqZx8fx4JYKTHhF0T1r+J61onre7u4lgue/cvG+660YExB/7Dmkb4q+x3gQMVY0xy3XISyDUq16RZpYF6gvTUrMpmPmKvuoSHTDxATjxsLlct0ItdBr3gyeEsMPfOxF/DS0vAJB5x5CMw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 11 Jul 2026 07:33:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 95181 invoked by uid 111); 11 Jul 2026 07:33:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 11 Jul 2026 03:33:21 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 11 Jul 2026 03:33:20 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, xuqing yang <rigelyoung@icloud.com>,
	Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH] object-file: fix closing object stream twice
Message-ID: <20260711073320.GA1457061@coredump.intra.peff.net>
References: <20260710-pks-odb-stream-double-close-v1-1-d5fa233a37c7@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260710-pks-odb-stream-double-close-v1-1-d5fa233a37c7@pks.im>

On Fri, Jul 10, 2026 at 04:54:16PM +0200, Patrick Steinhardt wrote:

> And while the mentioned commit did drop one call that closed the stream,
> there's a second such call that was missed when reading from the stream
> fails. The consequence of this can be a double free of the stream.
> 
> Fix the bug by dropping that leftover call to `odb_read_stream_close()`.

Thanks, both the patch and the new test look good to me.

> Note that it was originally discussed whether this should be treated as
> a security vulnerability. But there are only two callers: once via
> `parse_object_with_flags()`, and once via `verify_packfile()`. Neither
> of these callers plays any role on the transport layer, so this issue is
> only relevant for objects that are already available via the local
> object database. Furthermore, a packfile that is corrupted in this way
> would be detected when receiving the packfile, so it's not easy for an
> adversary to plant such a packfile, either. Consequently, we decided
> that this is not covered as part of our threat model.

I think this case probably would violate our "it is OK to clone from the
local untrusted .git repo" goal (since you could perhaps get to this
code path via upload-pack/pack-objects, though I didn't try it myself).

But the text in git(1)'s SECURITY section is pretty clear that it is
more goal than promise, and that this scenario carries extra risk
exactly because of the increased attack surface. And that you can
mitigate by serving from an untrusted user.

-Peff
