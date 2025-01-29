Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F158B29A2
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 20:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738181120; cv=none; b=akngbhuEGc6/AXBx0Hz6Nst9fmdJ/OwlB7khLG6tQTWKjL2xJr7xA8bN2dwbCmrNEt0qMYrFVtsHDKKM4OqpeOOQmjy7pf/qfBVHVKIhAK//P9bIz+gPrwJs2gzSmKto5NU7Imnu2RClrTOjg6b0STYAAfNl2z3np0BttvJjvnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738181120; c=relaxed/simple;
	bh=kGDL3wHy/kZzd06k6eRnJ20EQfPcwvEGkxwVsVkVrbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bh13hTqrKnYzSDgnVl046abXKYo1yylxSUvgW85MTbcAy1d9GnBIe9Le22n/JmajNN3ewVqLXYFQ2NI+Rjn/K/gN2GK1SJiGhHO4m00kDuSNayL63rOeZ1HyaKqByzq4gvUo9KHdZXBULW+9h05y/j/6uc7jOztjrZyM3+WwDQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=MTtQoMdH; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="MTtQoMdH"
Received: (qmail 29464 invoked by uid 109); 29 Jan 2025 20:05:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=kGDL3wHy/kZzd06k6eRnJ20EQfPcwvEGkxwVsVkVrbg=; b=MTtQoMdH+RuKguohG/7jDxVoH1975GIDilylr6O0T6HuVouXQuJjyXVGeFJCcLVfmUaepB4OVRXfpI1YoqfrBXU/rihMeyqjFU3PpE2044g7exQiFHwgzTo5tf516DssSZ6PucqXE0n/pai63cpAqoVBC/EuadhOujdhY76ucFXFMWEY5KhgyRsu2XStzw408bnEwKRIpLbm4we5NygqBeltgA8r5WgHG2wVkTDyxEtMCwwXN3dAN0Rdi1rUPppBJ1xuQC1CA6FSKxUqrraXnUsigERR8Y2bKd/k/sjXv4/dImWYoJ4wMytY4rSS8YCSsesWBELnUUrx+8qK69ykkg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 29 Jan 2025 20:05:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32466 invoked by uid 111); 29 Jan 2025 20:05:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 29 Jan 2025 15:05:11 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 29 Jan 2025 15:05:09 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/2] Plug two memory leaks exposed via Meson
Message-ID: <20250129200509.GA2331283@coredump.intra.peff.net>
References: <20250129-b4-pks-memory-leaks-v1-0-79e41299eb0c@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250129-b4-pks-memory-leaks-v1-0-79e41299eb0c@pks.im>

On Wed, Jan 29, 2025 at 05:24:13PM +0100, Patrick Steinhardt wrote:

> I've had the need to play around with the memory leak sanitizer today
> and for the first time used it with Meson. Interestingly enough, a test
> run with Meson flags two memory leaks that our Makefile doesn't. I
> haven't found the time yet to figure out why that is, but this small
> patch series fixes both of these leaks.

At least for the first one, it depends on how long the path to your
trash directory is. Doing this:

  make SANITIZE=leak
  cd t
  ./t0301-credential-cache.sh --root=/tmp/this_is_a_very_long_path/the_size_of_sockaddr_un_sun_path_is_usually_108

will fail reliably (it's not 108, but with the trash directory and xdg
boilerplate tacked on, it is).  The failed chdir() triggers because it's
trying the xdg path to see if it exists.

With "make", my path is something like:

  /home/peff/compile/git/t/trash directory.t0301-credential-cache/.cache/git/credential/socket

which is 93 bytes. If I do an out-of-tree build into the "build"
directory, then I get 109 bytes, one too many:

  /home/peff/compile/git/build/test-output/trash directory.t0301-credential-cache/.cache/git/credential/socket

so it is mostly a matter of luck combined with your personal directory
layout.

This test would trigger it reliably, but it's weirdly specific:

diff --git a/t/t0301-credential-cache.sh b/t/t0301-credential-cache.sh
index dc30289f75..0ef8ce4e60 100755
--- a/t/t0301-credential-cache.sh
+++ b/t/t0301-credential-cache.sh
@@ -134,6 +134,13 @@ test_expect_success SYMLINKS 'use user socket if user directory is a symlink to
 	test_path_is_socket "$HOME/.git-credential-cache/socket"
 '
 
+test_expect_success 'error path for chdir of long socket name' '
+	A=aaaaaaaaaaaaaaaa &&
+	LONG=$A/$A/$A/$A/$A/$A/$A/$A &&
+	# do not create $LONG; we want to trigger the error
+	git credential-cache --socket "$PWD/$LONG/socket" exit
+'
+
 helper_test_timeout cache --timeout=1
 
 test_done

So I don't know if it's worth adding in to your patch. The fix itself is
obviously correct.

-Peff
