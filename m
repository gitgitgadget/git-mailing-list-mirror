Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AFE2F39C2
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 20:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773348026; cv=none; b=izTO/jjmP28+/1iy5ByKT6sDVEhqqPkoRIsuxM7Qmrx5C9A1I42jtcgdhYjnzzTh1MP9Lh+z/R1n4xYMi71j2rFcoa1kWFXeehlKh7AUE6d3MSvt7/a+H/AddAMwA+uBKrLYnupFCHfZgCPYaPZzxetUENqxKi7ITbOi6RMSUw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773348026; c=relaxed/simple;
	bh=QhTFK3tUxs2rFWPl6dAFF3QPlJ2kHuBbl7a0FInA+Uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kprB/CzqtzAmBBt1j7Mm0fq0plPXK5rYNYJvFVUuCZPWYmZWx4rjrpt4xPFT/g2fE7CgkdL537ez1Ofbjr3lSZuYqHaGNKj7GzwEaUtPwB5PziqEJNuo0l7OKMIJMmAVqLEVZWh2fz/pbl/n0etozGs3icfQt4Hrv31zSik7Ucg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=SbP0Xib/; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="SbP0Xib/"
Received: (qmail 90168 invoked by uid 106); 12 Mar 2026 20:40:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=QhTFK3tUxs2rFWPl6dAFF3QPlJ2kHuBbl7a0FInA+Uk=; b=SbP0Xib/i1kNvAppQfPo5osxhk1skD3PEBg1D3MIrXMm+kyd3ixxfqDdtPs/iUHnUk2RKet6CHRgafliVcNOwOnJmGyS+pdprQCmc4vTbbJLzhWknWdTjNgpImoOvfxz6ip6m7dJjjZBMYe3aiDInYIybsz8J5fdv+4cvXdX09FRAr3dIkKuYjTBryPL7PlmZ4vBSpTIQRIwu5rRfwHZCGb2zzSVdJktMzmNA6G3trOrAsQbPoSw5Qxi2tKxnqL9RgoyzeYIdy0K5M417Pj0Ev+HTaOjlTdAK3XK3pxTyRLaFDo/sMl+/C8Awr1UXICrQYKdxXhtmjbxVBgdiOryJQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 12 Mar 2026 20:40:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 510930 invoked by uid 111); 12 Mar 2026 20:40:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 12 Mar 2026 16:40:25 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 12 Mar 2026 16:40:23 -0400
From: Jeff King <peff@peff.net>
To: Andrew Au <cshung@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
	Copilot <223556219+Copilot@users.noreply.github.com>
Subject: Re: [PATCH v3] transport-helper, connect: use clean_on_exit to reap
 children on abnormal exit
Message-ID: <20260312204023.GB2552877@coredump.intra.peff.net>
References: <20260311184206.GA1911377@coredump.intra.peff.net>
 <20260312195813.4006430-1-cshung@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260312195813.4006430-1-cshung@gmail.com>

On Thu, Mar 12, 2026 at 07:55:59PM +0000, Andrew Au wrote:

> Set clean_on_exit and wait_after_clean on child_process structs in both
> transport-helper.c and connect.c so that the existing run-command
> cleanup infrastructure handles reaping on any exit path. This avoids
> rolling custom atexit handlers that call finish_command(), which could
> deadlock if the child is blocked waiting for the parent to close a pipe.

Ah, right, I forgot about wait_after_clean when I suggested
clean_on_exit. Yes, you definitely want both here.

> The clean_on_exit mechanism sends SIGTERM first, then waits, ensuring
> the child terminates promptly. It also handles signal-based exits, not
> just atexit.
> 
> Signed-off-by: Andrew Au <cshung@gmail.com>
> 
> Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>

I don't know if we have established a pattern in the project for
AI-assisted work (and whether it is worth marking at all, and if so, if
co-author is the right way to do so). But if we are going to, usually
the trailers would all be together, with no blank line in between.

>  connect.c          | 4 ++++
>  transport-helper.c | 2 ++
>  2 files changed, 6 insertions(+)

The changes here are all a trivial implementation of the idea. So if the
idea is good (and I think it is), then the patch looks correct to me.

-Peff
