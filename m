Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF49630BBAE
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 09:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770370722; cv=none; b=dPoNFk6pVbZZQkOFcHPGcV0geT3u/19WhF9ps55Cq24tDJyPtrFXcr1u5GPdeLgKyANFvG8KhHXBa0+qye/eHucPa97GVIttyqxzGwoqkwz3NWTD6El6L5C1U/i0iOeaqRylKWFNQPp0tNSJNYnZ9SsXR/I3XrzmnYk4McRaBNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770370722; c=relaxed/simple;
	bh=OJk85Z61cW7kBwOS/GHxCM7MRN60klJusTSrNtale7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hqeMoECdsq4YckNLVFZzXc+AOVznvLiVxDre5159Afavqw1lYhN6MVycMgH/zypKg3/CwbaQ7xm/zo6diPJWXmqpUaWHAMxfA/t1nRGMnvMhQQk0Foi//f1av7gE58QQcFD9tsxE3j3z2utHqO2OUS42Hhmbbf2n2Ss/LidkGqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=PBb5CYUc; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="PBb5CYUc"
Received: (qmail 298277 invoked by uid 109); 6 Feb 2026 09:38:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=OJk85Z61cW7kBwOS/GHxCM7MRN60klJusTSrNtale7Y=; b=PBb5CYUc+/OccVafz4XvwNMzF+nkimsHtS2fHnTADn93ChvHcpLlNvSlNk/l01TExEWcKPOgqml/6vzMY90CH6GM2YPr2YkUzPzftsDf4it1H53UB0AXxHpWwZlUmVfVCsMvTic4Gyp57Wui176iOi3AzzMwpa+l4hXZlNGlbUk28FspJSDWtheb4mYe9tgh7CZoN7Eo8jV8hW8y9YqA6RQrLfSQ7E346vIEwEW+CVw4l4uLB2Wy9ZoCLFgSkBX7WERBUivJ76WmUz6LeK5tUL4gvyhVsMSPlYiBs/lk6OafRQHpVYrOLCzCevurO0XUWvohQw1eqDtnqymcPB1Cyg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 06 Feb 2026 09:38:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 599208 invoked by uid 111); 6 Feb 2026 09:38:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 06 Feb 2026 04:38:45 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 6 Feb 2026 04:38:40 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Ashlesh Gawande <git@ashlesh.me>, git@vger.kernel.org,
	sandals@crustytoothpaste.net
Subject: Re: [PATCH v3] t5550: add netrc tests for http 401/403
Message-ID: <20260206093840.GC2761602@coredump.intra.peff.net>
References: <20260106114029.763351-1-git@ashlesh.me>
 <20260107074724.13165-1-git@ashlesh.me>
 <xmqqms1mihqo.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqms1mihqo.fsf@gitster.g>

On Thu, Feb 05, 2026 at 09:05:51PM -0800, Junio C Hamano wrote:

> >   - Third test case checks that the git clone fails when the .netrc file
> >     provides credentials that are valid but do not have permission for
> >     this user. For example one may have multiple tokens in GitHub
> >     and uses the one which was not authorized for cloning this repo.
> >     In such a case the HTTP server returns 403 Forbidden.
> >     For this test, the apache.conf is modified to return a 403
> >     on finding a forbidden-user. No prompt for username/password is
> >     expected after the 403 (unlike 401). This is because prompting may wipe
> >     out existing credentials or conflict with custom credential helpers.
> 
> Nicely summarised.  So we say 401 when we do not know you, while we
> say 403 when we know you and do not want you to be accessing the
> resource.  We test for both.

I think it is fine to check the 403 handling, but note that this _isn't_
how GitHub would respond. If you try to fetch from a repository you
don't have access to, it will return a 401 first (so you try to log in)
and then a 404. The idea being to avoid revealing the existence of the
repository to unauthorized users.

> Just out of curiosity, do we test for these codes with other
> credential helpers or is this only relevant for .netrc users?

The netrc support here should not involve credential helpers at all. It
is all being done internally by curl. So in this (third and final) test:

> > +test_expect_success 'netrc authorized but forbidden credentials (fail on 403)' '
> > +	test_when_finished clear_netrc &&
> > +	set_askpass wrong &&
> > +	set_netrc 127.0.0.1 forbidden-user@host pass@host &&
> > +	test_must_fail git clone "$HTTPD_URL/auth/dumb/repo.git" clone-auth-netrc-403 2>err &&
> > +	expect_askpass none &&
> > +	grep "The requested URL returned error: 403" err
> > +'

...what is happening is roughly:

  - curl sends the first request with no credentials, which gets a 401

  - curl internally, without returning a response to Git, looks up the
    netrc value and repeats the request with an Authorization header

  - curl returns the resulting 403 to Git

  - Git calls this an error (just like it would a 404) and bails

But from Git's perspective the use of netrc here is not really
interesting. We don't even know it happened! And if the server did
return a 401, we'd happily try to get credentials (from the user or from
a helper) in the usual way. And that's what happens in the second test:

> > +test_expect_success 'netrc unauthorized credentials (prompt after 401)' '
> > +	test_when_finished clear_netrc &&
> > +	set_askpass wrong &&
> > +	set_netrc 127.0.0.1 user@host pass@wrong &&
> > +	test_must_fail git clone "$HTTPD_URL/auth/dumb/repo.git" clone-auth-netrc-401 &&
> > +	expect_askpass both wrong
> > +'

Curl tries the credential under the hood, but we have no idea, and we
process a 401 in the usual way.

And in the first one:

> > +test_expect_success 'using credentials from netrc to clone successfully' '
> > +	test_when_finished clear_netrc &&
> > +	set_askpass wrong &&
> > +	set_netrc 127.0.0.1 user@host pass@host &&
> > +	git clone "$HTTPD_URL/auth/dumb/repo.git" clone-auth-netrc &&
> > +	expect_askpass none
> > +'

We do not ever even see the 401, and curl just magically handles it for
us. We see only the successful 200 code, just as if authentication was
not required in the first place.


So really, none of this is testing anything novel in Git at all that is
not covered elsewhere, except for the fact that we pass the flag to curl
that says "you may use netrc". And so there's some value in adding it in
that case. But trying to answer your question about other credential
helpers, no, they're not even entering the picture here.

-Peff
