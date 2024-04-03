Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D15211CB8
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 01:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712107102; cv=none; b=ONZ9XL/Mb7ZbUD1MfI9M/uBmv+xjVa+373J9g3n4NIIvuLOOOEeFc8HoUi9C4Kicu3y3mwT1hbJHtlmW8CsOHJtu10TDlLDhUuGVzxDaffSyVxNklD2vOGhOougVAKjy+gd3S6jN5QfQJkkcZ6QHl5ay36kAx2/DhSU+kZSmZW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712107102; c=relaxed/simple;
	bh=9MrDPGupClsHKrCMdVRHKZ43WjmYxae1rqcGrS9+0Hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JDsGCjz39INGF5hJ9jvTH0HfCIP31xvX7C052Dy+Oanw92KHkpF3mR4/zA1lAaZnbRu+0zmgl0qn66QX4gREBXzgCM25MTs6/DnfWGSreUUzzBMD5YTQUDEzXSre5hW0/zKhJ44rr2k6nazphrtTOUcNEYZuz9SKAO6UOllQlus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 13719 invoked by uid 109); 3 Apr 2024 01:18:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 03 Apr 2024 01:18:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3473 invoked by uid 111); 3 Apr 2024 01:18:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 02 Apr 2024 21:18:22 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 2 Apr 2024 21:18:18 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] mem-pool: use st_add() in mem_pool_strvfmt()
Message-ID: <20240403011818.GB892394@coredump.intra.peff.net>
References: <bbe00b9e-64d8-4ec8-a2b9-2c6917c72dbd@web.de>
 <20240401033642.GB2639525@coredump.intra.peff.net>
 <9f26b9f0-f8d7-4988-b6d4-e0446dab30b1@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9f26b9f0-f8d7-4988-b6d4-e0446dab30b1@web.de>

On Tue, Apr 02, 2024 at 03:48:45PM +0200, René Scharfe wrote:

> Makes sense.  Could be rolled into a new wrapper, xvsnprintf();
> imap-send.c::nfvasprintf() could call it as well.
> 
> There are also callers of vsnprintf(3) that use its return value without
> checking for error: builtin/receive-pack.c::report_message(),
> path.c::mksnpath() and arguably imap-send.c::nfsnprintf().

Hmm, yeah. Those are all OK not to use xsnprintf(), since they handle
truncation themselves. But the first two don't look like they handle a
negative return well. In report_message(), we'd end up shrinking "sz".
That's potentially an out-of-bounds problem, except that we'll always
have put a non-empty prefix into the buffer. For mksnpath(), though, I
suspect that trying to format a very long name could result in the
output being full of uninitialized bytes.

It only has one caller, which creates "foo~1" when we got EEXIST from
"foo". So I doubt you can get up to too much mischief with it. But it
could easily be replaced by mkpathdup() (or even a reusable strbuf
outside the loop if you really wanted to hyper-optimize)

And then we could get rid of mksnpath() entirely, and its horrible
bad_path failure mode.

> We can throw in errno to distinguish between EILSEQ (invalid wide
> character) and EOVERFLOW.  And we'd better not call die_errno() to avoid
> triggering a recursion warning.  We can open-code it instead:
> 
>         if (vsnprintf(p, pend - p, err, params) < 0) {
>                 fprintf(stderr, _("%sunable to format message '%s': %s\n"),
>                         _("fatal: "), err, strerror(errno));
>                 exit(128);
>         }

We could also just throw it into the buffer and let the rest of the
function proceed, like:

diff --git a/usage.c b/usage.c
index 09f0ed509b..5baab98fa3 100644
--- a/usage.c
+++ b/usage.c
@@ -19,8 +19,10 @@ static void vreportf(const char *prefix, const char *err, va_list params)
 	}
 	memcpy(msg, prefix, prefix_len);
 	p = msg + prefix_len;
-	if (vsnprintf(p, pend - p, err, params) < 0)
+	if (vsnprintf(p, pend - p, err, params) < 0) {
+		if (snprintf(p, pend - p, "could not format error: %s", err) < 0)
 		*p = '\0'; /* vsnprintf() failed, clip at prefix */
+	}
 
 	for (; p != pend - 1 && *p; p++) {
 		if (iscntrl(*p) && *p != '\t' && *p != '\n')

Though most of the rest of the function is not that useful (it is mostly
removing unreadable chars, and hopefully we do not have any of those in
our format strings!). I had not thought about showing strerror(). The C
standard does mention a negative value for encoding errors, but says
nothing about errno. POSIX does seem to mention EILSEQ and EOVERFLOW.
So this...

> But when I ran your test command (on macOS 14.4.1) ten times with this
> change I got:
> 
> fatal: unable to format message 'invalid ref format: %s': Invalid argument
> fatal: unable to format message 'invalid ref format: %s': Undefined error: 0
> fatal: unable to format message 'invalid ref format: %s': Invalid argument
> fatal: unable to format message 'invalid ref format: %s': Undefined error: 0
> fatal: unable to format message 'invalid ref format: %s': Invalid argument
> fatal: unable to format message 'invalid ref format: %s': Undefined error: 0
> fatal: unable to format message 'invalid ref format: %s': Invalid argument
> fatal: unable to format message 'invalid ref format: %s': Undefined error: 0
> fatal: unable to format message 'invalid ref format: %s': Undefined error: 0
> fatal: unable to format message 'invalid ref format: %s': Undefined error: 0
> 
> Which scares me.  Why is errno sometimes zero?  Why EINVAL instead of
> EOVERFLOW?  O_o

...is just confusing. I do think even without worrying about errno,
simply saying "I tried to format 'some error: %s' and couldn't" is going
to be way more useful than just "fatal: ". The only reason it would fail
is that there's something gross in that "%s". We can't be more specific
without interpreting the printf-format ourselves (which is probably not
worth it).

-Peff
