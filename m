Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBA4185935
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 20:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735935053; cv=none; b=oI0aHkHwF/dyPAjD1YMjUy1mnSbxEmFROABctReq9q7AJ2Yg2bgvPceYfngQ1faWhNQYA94WHxf7elL86oHYDDPZubGk4fFyq/lI/ZQsuEuplj4fb5IvrCY4L01ThqV9KvH1L8OtsdLok9UuBISEZ1Inc4bvYgGEZO5Oef1d0nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735935053; c=relaxed/simple;
	bh=VHrhI3tCctPOOSZVGnnTXkleml1CWhZze8GIcqUWlss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JfgiUh9LjxRUU3V5yYO0w0Q/BmSmX/sB++NRzlVYXVP476/t1m5OsxE9RziGzRwtWwnEQkRCnVQ1xjSmqkvgsDaJvGt2q+AnIDl+jvEMD6fP1wKpyKbbn22zJY43Q7ICzffClIcVJ33QDD6kZZvwHjUyM9gko8Vir0PwD95iC30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=WqdVbYLQ; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="WqdVbYLQ"
Received: (qmail 18886 invoked by uid 109); 3 Jan 2025 20:10:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=VHrhI3tCctPOOSZVGnnTXkleml1CWhZze8GIcqUWlss=; b=WqdVbYLQhBlmPJj5BHhV8s4vJSAojjTlthIr9PnCLxSdmndX+6seLkR321noCxsHXDNpQYqFJ4SJVFOyYMXv0wIK3tehkhFmiwNwILMtLTIsTvmk2yOX5zokyKdwnlYsIyPBQP90lEhRV1pgNqkh6HOKNJYAHKN8D+8synEhfGoBepkokflgEZ6Lyg8GRVcBCs5CiCrh2nf5epmYhDpmj52abiM2ScwJsTz0QXvgc9yhqci/2Vgxy0RWSJKEq35WPwSiZ2ubCllfypfJo6CqnZjQDkTfpg1mvDURH/TSS1eG73Fnty305niy0l1FElkV9OjsLFhLiZ7MM1UOvyEBUA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 03 Jan 2025 20:10:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4737 invoked by uid 111); 3 Jan 2025 20:10:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 03 Jan 2025 15:10:50 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 3 Jan 2025 15:10:50 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/6] test-lib: rely on logs to detect leaks
Message-ID: <20250103201050.GB3212696@coredump.intra.peff.net>
References: <20250101201226.GA3304465@coredump.intra.peff.net>
 <20250101201444.GC3305462@coredump.intra.peff.net>
 <Z3fSj-NsSg2El2wI@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z3fSj-NsSg2El2wI@pks.im>

On Fri, Jan 03, 2025 at 01:05:41PM +0100, Patrick Steinhardt wrote:

> > So now aborting on error is superfluous for LSan! We can get everything
> > we need by checking the logs. And checking the logs is actually
> > preferable, since it gives us more control over silencing false
> > positives (something we do not yet do, but will soon).
> > 
> > So let's tell LSan to just exit normally, even if it finds leaks. We can
> > do so with exitcode=0, which also suppresses the abort_on_error flag.
> 
> The only downside I can think of is that we now run the whole testcase
> to completion before checking for leaks, whereas beforehand we most
> likely aborted the testcase on hitting the first leak. It follows that
> we may now have multiple leak reports, and it is not immediately clear
> which of the commands has actually been failing.

True, I didn't think of that. We do at least check the logs after each
case, so it would have to be multiple leaks in the same snippet. The
LSan output also mentions the process name, though not the arguments
(and some snippets may invoke the same program multiple times).

The other thing I guess we'd miss is that SIGABRT can optionally produce
a core dump. I don't think I've ever found that useful for LSan (since
it's not exiting until the end of process) but occasionally have used it
for ASan (though this patch does not change anything there).

> I think we're now in a clean-enough state regarding memory leaks that
> this isn't a huge issue anymore though.

Yeah, agreed. We can see how much of a problem it is in practice. You
can always switch the flag yourself for a specific run, like:

  LSAN_OPTIONS=exitcode=23 ./twhatever -i

-Peff
