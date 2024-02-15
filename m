Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F99539A
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 04:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707973182; cv=none; b=hEcffgDjeQIcl7L8oPoN+7IqbKdVwYaqd2zd28grYLtVjsznpSpu2cRnoj7Y+eKGCxwoUgUpAUG5+wmyDO1nhwPhkQYdmBTAbZVkyJAZiZtkw3MF7bRbnlB/FuSUZ/mYiSQr1WGllwxCTMpdh8DBV9tY//ZWKEDClEwFo4wm6J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707973182; c=relaxed/simple;
	bh=4TuVAkpGncMn73jJNpoxWFKRzS8yAjJIK5aanGnwA/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQW+RljMTfi/TuGoMVlJB+rueFny1z0AaVvJ8JzIEPrX+XjelrLjiXZbgmJGmtWPIgYcSYNgWNCnhn8SZcSatD04J2ALStTqhrYtRKFHUU44NNQVo3Vl1/PZWP/tkQdMmS2F08/3RU70kj0JnqyVTdkruuKJHZGEMKDF6FMlXN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 17925 invoked by uid 109); 15 Feb 2024 04:59:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 Feb 2024 04:59:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11710 invoked by uid 111); 15 Feb 2024 04:59:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Feb 2024 23:59:40 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 14 Feb 2024 23:59:38 -0500
From: Jeff King <peff@peff.net>
To: M Hickford via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH] credential/osxkeychain: store new attributes
Message-ID: <20240215045938.GB2821179@coredump.intra.peff.net>
References: <pull.1663.git.1707860618119.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1663.git.1707860618119.gitgitgadget@gmail.com>

On Tue, Feb 13, 2024 at 09:43:38PM +0000, M Hickford via GitGitGadget wrote:

>     Is any keen MacOS user interested in building and testing this RFC
>     patch? I personally don't have a MacOS machine, so haven't tried
>     building it. Fixes are surely necessary. Once it builds, you can test
>     the feature with:
>     
>     GIT_TEST_CREDENTIAL_HELPER=osxkeychain ./t0303-credential-external.sh

You might also need:

  GIT_TEST_CREDENTIAL_HELPER_SETUP="export HOME=$HOME"

according to 34961d30da (contrib: add credential helper for OS X
Keychain, 2011-12-10). IIRC I also ran into problems trying to test over
ssh, as those sessions did not have access to the keychain.

(Sorry, I haven't touched a mac since adding the helper back then, but
maybe those hints will help somebody else).

>  static void add_internet_password(void)
>  {
> +	int len;
> +

This should probably be a size_t to avoid integer overflow for malicious
inputs. I suspect it's hard to get a super-long string into the system.
We do use the dynamic getline(), but stuff like host, user, etc, almost
certainly comes from the user or from a URL that was passed over a
command-line. Maybe oauth_refresh_token() could be long, though?

Anyway, probably better safe than sorry (though see below).

>  	/* Only store complete credentials */
>  	if (!protocol || !host || !username || !password)
>  		return;
>  
> +	char *secret;

This is a decl-after-statement, which our style forbids (though I am
happy to defer on style issues to anybody who volunteers to maintain
a slice of contrib/, and I don't think we need to worry about pre-c99
compilers here).

> +	if (password_expiry_utc && oauth_refresh_token) {
> +		len = strlen(password) + strlen(password_expiry_utc) + strlen(oauth_refresh_token) + strlen("\npassword_expiry_utc=\noauth_refresh_token=");
> +		secret = xmalloc(len);
> +		snprintf(secret, len, len, "%s\npassword_expiry_utc=%s\noauth_refresh_token=%s", password, oauth_refresh_token);

Do you need to add one more byte to "len" for the NUL terminator?

I think there is also a mismatch in your snprintf call, which has three
%s placeholders and only two var-args.

Since we added xmalloc() as a helper, I wonder if we could go just a
little further with (totally untested):

  __attribute__((format (printf, 1, 2)))
  char *xstrfmt(const char *fmt, ...)
  {
          va_list ap, cp;
	  char *ret;
	  int len;

	  va_start(ap, fmt);

	  va_copy(cp, ap);
	  len = vsnprintf(NULL, 0, fmt, cp);
	  va_end(cp);

	  /*
	   * sadly we must use int for the length, since that's what the
	   * standard specifies. But good implementations will return a
	   * negative value if the resulting length would overflow.
	   */
	   if (len < 0)
	            die("xstrfmt string too long");

	   ret = xmalloc(len + 1);
	   vsnprintf(ret, len, fmt, ap);
	   va_end(ap);

	   return ret;
  }

Then you can just write:

  secret = xstrfmt("%s\npassword_expiry_utc=%s\noauth_refresh_token=%s",
                   password, password_expiry_utc, oauth_refresh_token);

Even across the three instances, I doubt it is saving any lines, but it
is much easier to verify that we sized the buffer correctly and did not
introduce an overflow.

-Peff
