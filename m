Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C67C344020
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 19:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775589898; cv=none; b=C9A8aSHgKsBjJMf3tvJqdqaiwNdbxHcjYwbeRA07MtjKugsuZHWtdolkwM/fWmfcaGuwDYTFgpnizZZmotevCB9ui673dCc+FpQUDXrmNs7bII45JgC2zWikWeuopEQpJIsBT66YuOWLV9qVsj506Dm3SEdZ8sAUSheXOSEFiWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775589898; c=relaxed/simple;
	bh=k8RcfTM1xvDjBfTFdynb17YaJiAf4Qb2kO+Jqmw3LCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=filDY7S4TZgtdPpnDXRImZBZyAiXLq2h+aeTA01y66Zy8VyueiyCKbAUVzAJZd0EaZGscoKKeoKF1ipnySSQPB2Mo97sLSGx12S7MahvtI8FZTJIDlCex667jiT/h368Qtkg5fzoITmU+qYZFoKtjusZXKT30FMyJ4UyRJDc+D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Ss6Um17B; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Ss6Um17B"
Received: (qmail 275377 invoked by uid 106); 7 Apr 2026 19:24:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=k8RcfTM1xvDjBfTFdynb17YaJiAf4Qb2kO+Jqmw3LCA=; b=Ss6Um17ByiBat3VrAimN07FwPSwkWnr+DEq2sT6Az+/TzVxnrbt6JhXJjgBU933mty3+bGIXijZU12tB1Y7dwem+M0WOs2GPULocSPlXKE7xKryTXsp7UbFDkPcsDMX/o/huGpyzn8uA/Z/ftX/6uof/8u5iY92Ob/2rrLrTdugb8RmAb3SuV1i5r67SsSsLmw8PglsBg/5HzdrhLf9VsrKa5tKfzvFDaRmWdaShAWQaVzV8PJVLbz5mLYvwQSNfgtzukpOWZbxH/X36Tft+4G0fQd5n8YvJFJcEMB66/FKTm1uE9tvHG8aJznvvQ60QYJFqk7SLCVsqkXGezNR0FA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 07 Apr 2026 19:24:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 450452 invoked by uid 111); 7 Apr 2026 19:24:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Apr 2026 15:24:54 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 7 Apr 2026 15:24:54 -0400
From: Jeff King <peff@peff.net>
To: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [RFC] archive: behavior of --prefix with absolute or parent path
 components
Message-ID: <20260407192454.GA754735@coredump.intra.peff.net>
References: <20260407162101.2285-1-pushkarkumarsingh1970@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260407162101.2285-1-pushkarkumarsingh1970@gmail.com>

On Tue, Apr 07, 2026 at 04:21:01PM +0000, Pushkar Singh wrote:

> Currently, --prefix accepts values such as absolute paths or ones with ..,
> e.g.:
>     git archive --prefix=/ HEAD > out.tar
>     git archive --prefix=//// HEAD > out.tar
>     git archive --prefix=../../ HEAD > out.tar
> 
> Upon listing the archive contents (e.g., tar -tf), you get entries like:
>     /a.txt
>     ////a.txt
>     ../../a.txt
> 
> In such cases, tar emits warnings like:
>     "Removing leading '/' from member names"
>     "Removing leading '../' from member names"

Yes, but note that with "-P" tar will happily allow those paths. They
_can_ be useful, if you know what you are doing, but they aren't
necessarily safe when coming from untrusted sources.

We can also generate zip files, but I think most unzip implementations
have similar restrictions (info-zip does, with "-:" to override).

In theory we could support other formats, but after 20 years I don't
think anybody has bothered to do so. Cpio, anyone? :)

Though speaking of cpio (the command, not the format), it will happily
list and extract the paths above from a tar input without any extra
option (it has an option to restrict, but unlike tar, it defaults to
off).

> From a user perspective, I was wondering:
>   - Is this behavior intentional (i.e., leaving validation to archive
>     consumers)?
>   - Would it be worth documenting this explicitly?
>   - Or should there be any normalization or validation at the Git level?
> 
> I understand that Git generally avoids enforcing policy decisions in 
> such cases, but I wanted to confirm whether this behavior is intentional.

I don't recall it ever being discussed. Of the three you mentioned,
"../" and leading "/" are potentially useful, so I don't think we'd want
to disallow them entirely. At least some tar implementations require
"-P" on the generating side to avoid mistakes, so we could follow that
path.  It may be considered a regression by anybody who is using the
feature currently, though.

The "////" is meaningless AFAICT, and could be replaced with a single
slash. But I think it's also mostly harmless, as the reading side (well,
the kernel) will equate "foo/////file" and "foo/file". I don't know if
there are systems where that would not be the case.

So...yeah. I guess we can document it more explicitly. Since you seem to
be the first to ask about it, it does not seem like a common question.
But if we can clarify the behavior without making the current docs
harder to read, I don't see a problem in doing so.

-Peff
