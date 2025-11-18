Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D475035CBA5
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 09:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763459184; cv=none; b=du+T9cu1KUrG+GJk1tiovXrlXOzbgKYiC2tie7wJRgsky1NeCd/cIrryYgax3V/k2xlduvkZyug3jl8XvNfhzJkI2W8+TyOIhVzK0rkCuaYQB1S6YqFr3Rzl9sm50Kbni52NdJhJ+LNzgeJjFsGHJOBOwmt77aiNuTeWUEaR2hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763459184; c=relaxed/simple;
	bh=jHg9ZbDtwkb3fjmu+xfV1hwbzcGrbF3+LgQBJ9MynDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VszKykzjZP/GZ03O5zuqCtFHKsUDTu0I+7QHErKWWS6E5iq51AkoaOqRYVjOv7F6WcG6xxxGpDQjlesL6veVYQxw4P63iA1oFJ9uikCZl+E0AG+kHWn4UcP2W1mPUV6N1+kMHbXDMRp8wCt0TnoNSLknYll9LZHKvXa7yYsv3Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=KX1qExvZ; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="KX1qExvZ"
Received: (qmail 20190 invoked by uid 109); 18 Nov 2025 09:46:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=jHg9ZbDtwkb3fjmu+xfV1hwbzcGrbF3+LgQBJ9MynDs=; b=KX1qExvZfDw8TPl+pgoJD8a44CoTeZuSHg7UbdGU2KAd7utJXvRUqjAJarYrfcKWhcoqgDqwXQ5Hf68D0baa3vKnEf+9h4OqDNnPF4SJDsHruUL8dkO4Ypu+tpadXWsh3BNe4vGTOMlEETJTrRvEIGNoRebJEj9hmJGRUV8HxzjL9dNgV5vzQYswjq//0f6trkYMjBZAvPY/wL+g1FEoXwuhzxfmGsurKZjhnqfbBN1BJlINRr1ywiHATGBGjj/6l683XTvJJoWF3KJC/0LKiemKdlUz8z6Rxc0Ixdww5iDqArUSVIDmxCWz7/pyeUdMINjCrDTtDLQTY7NK2wmBXQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Nov 2025 09:46:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27806 invoked by uid 111); 18 Nov 2025 09:46:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Nov 2025 04:46:26 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 18 Nov 2025 04:46:21 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Git List <git@vger.kernel.org>
Subject: Re: [PATCH] wrapper: simplify xmkstemp()
Message-ID: <20251118094621.GB530545@coredump.intra.peff.net>
References: <058c5722-30f5-4bc5-90f5-24e4c6f3ff8f@web.de>
 <xmqqbjl0iax6.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqbjl0iax6.fsf@gitster.g>

On Mon, Nov 17, 2025 at 01:52:53PM -0800, Junio C Hamano wrote:

> >  int xmkstemp(char *filename_template)
> >  {
> > -	int fd;
> > -	char origtemplate[PATH_MAX];
> > -	strlcpy(origtemplate, filename_template, sizeof(origtemplate));
> > -
> > -	fd = mkstemp(filename_template);
> > -	if (fd < 0) {
> > -		int saved_errno = errno;
> > -		const char *nonrelative_template;
> > -
> > -		if (strlen(filename_template) != strlen(origtemplate))
> > -			filename_template = origtemplate;
> > -
> > -		nonrelative_template = absolute_path(filename_template);
> > -		errno = saved_errno;
> > -		die_errno("Unable to create temporary file '%s'",
> > -			nonrelative_template);
> > -	}
> > -	return fd;
> > +	return xmkstemp_mode(filename_template, 0600);
> >  }
> 
> A patch that loses lines is nice.  My curiosity wonders what the
> strlen() comparison in the original was about, but let's not waste
> our brain cycles to code that we no longer use ;-).  xmkstemp_mode()
> checks if our git_mkstemp_mode() cleared the template[0] as a sign
> to restore the origtemplate, and uses the template that was munged
> by git_mkstemp_mode() and used to attempt opening it, which seems
> very sensible.

I agree that we do not need to worry about code that is going away,
but...it made me wonder if the reason for the strlen() applied equally
to git_mkstemp_mode(). I.e., if it has had a small bug for a long time,
and we are now about to expose it to a wider audience.

Looks like it comes from f7be59b477 (xmkstemp(): avoid showing truncated
template more carefully, 2012-12-18), where some implementations of
mkstemp() would truncate "foo/bar.XXXXX" as "foo\0". But since we are
now always using our own function, we know it truncates at the very
start. So we do not need to worry about that hack.


I also wondered if we ever use mkstemp() at all after this patch. If
not, we might want to declare it off-limits. Not because it is evil, but
because our own implementation is more predictable (and we can drop the
compat wrappers for mingw). It looks like there is one more call in
entry.c's open_output_fd(), but arguably that should be calling
xmkstemp() or git_mkstemp_mode(). But that's out of scope for this patch
(I just thought I might nerd-snipe René into looking at it).

-Peff
