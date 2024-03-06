Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B1E6FB1
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 01:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709686819; cv=none; b=YV/sqDEUlA7Cs6IB0NpXrpbjZIPL2qsC+3awy9X11rnqccMFVVPEsvs7DHs4jynmfGjHdpaLjeCu0ArMLVrVLM00O8mLLFbA7eUKAsr2BQwguo1gjlUFZRs/TNfyBKc7/g9xYbGb8SkXc+ZxTyfFAVlhN8M3S/jarINiJtg/5q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709686819; c=relaxed/simple;
	bh=b2OehBaoJSczDObv68D48IzSoFMPGgZ07RCuGOLLSno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mE8hCVW7jxGzFSnn5dn9vwDMfrFzxDC9nCnlpIdESC4qlQCW3mfV46x8RFIraZrCrBakW+G1Ce+Ekgnk9k/9Ft6tE7hNxuvdISXD+8Rl3dJ2OSpOhogV9e0Vrfe37qw94YfQj4TNI9L7P5D54fpnad3ZRHJUMET6hEIgxzUAvFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 22729 invoked by uid 109); 6 Mar 2024 01:00:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 06 Mar 2024 01:00:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30450 invoked by uid 111); 6 Mar 2024 01:00:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 05 Mar 2024 20:00:19 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 5 Mar 2024 20:00:16 -0500
From: Jeff King <peff@peff.net>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] ci: also define CXX environment variable
Message-ID: <20240306010016.GA3811328@coredump.intra.peff.net>
References: <cover.1709673020.git.steadmon@google.com>
 <75f98cbf98005b0a069977096ec5501f2f7830fe.1709673020.git.steadmon@google.com>
 <20240306005057.GC3797463@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240306005057.GC3797463@coredump.intra.peff.net>

On Tue, Mar 05, 2024 at 07:50:58PM -0500, Jeff King wrote:

> On Tue, Mar 05, 2024 at 01:11:59PM -0800, Josh Steadmon wrote:
> 
> > In a future commit, we will build the fuzzer executables as part of the
> > default 'make all' target, which requires a C++ compiler. If we do not
> > explicitly set CXX, it defaults to g++ on GitHub CI. However, this can
> > lead to incorrect feature detection when CC=clang, since the
> > 'detect-compiler' script only looks at CC. Fix the issue by always
> > setting CXX to match CC in our CI config.
> > 
> > We only plan on building fuzzers on Linux, so none of the other CI
> > configs need a similar adjustment.
> 
> Does this mean that after your patch 2, running:
> 
>   make CC=clang
> 
> may have problems on Linux, because it will now try to link fuzzers
> using g++, even though everything else is built with clang (and ditto
> the detect-compiler used it)?

Also, if the answer is "yes": do we really need a c++ linker here? My
understanding from reading "git log -SCXX Makefile" is that when using
oss-fuzz, you'd sometimes want to pass c++ specific things in
FUZZ_CXXFLAGS. But we're not using that here, and are just making sure
that things can be linked. Can we just use $(CC) by default here, then?

Something like:

diff --git a/Makefile b/Makefile
index f74e96d7c2..3f09d75f46 100644
--- a/Makefile
+++ b/Makefile
@@ -3861,17 +3861,18 @@ cover_db_html: cover_db
 #
 # An example command to build against libFuzzer from LLVM 11.0.0:
 #
-# make CC=clang CXX=clang++ \
+# make CC=clang FUZZ_CXX=clang++ \
 #      CFLAGS="-fsanitize=fuzzer-no-link,address" \
 #      LIB_FUZZING_ENGINE="-fsanitize=fuzzer,address" \
 #      fuzz-all
 #
+FUZZ_CXX ?= $(CC)
 FUZZ_CXXFLAGS ?= $(ALL_CFLAGS)
 
 .PHONY: fuzz-all
 
 $(FUZZ_PROGRAMS): %: %.o oss-fuzz/dummy-cmd-main.o $(GITLIBS) GIT-LDFLAGS
-	$(QUIET_LINK)$(CXX) $(FUZZ_CXXFLAGS) -o $@ $(ALL_LDFLAGS) \
+	$(QUIET_LINK)$(FUZZ_CXX) $(FUZZ_CXXFLAGS) -o $@ $(ALL_LDFLAGS) \
 		-Wl,--allow-multiple-definition \
 		$(filter %.o,$^) $(filter %.a,$^) $(LIBS) $(LIB_FUZZING_ENGINE)
 

-Peff
