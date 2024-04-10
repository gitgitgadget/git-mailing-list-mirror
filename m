Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2634016E87A
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 21:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712783464; cv=none; b=jYXTz6TzULkA9OmlWSJwhvxbRa9MdU1aSASmXPek7Zqv+Bmu9NnT+GQ52vayFsSxT4qlgNvjONwnnYxqV3VSw8xPGHSNMlpcAgw+6qLpjYQkdPtvF68s4AD2S5n/F/Sy7SpUG8fMQa9dQ0gGr+qVQMJifQOYwqFjO93ZhfHU5hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712783464; c=relaxed/simple;
	bh=yJl5UWlZR1530qoRMfYkwmJ3oVD5Cx4280hu6Mvzv18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ENmvOAk0PhbRa7v095kkxZSPPhP7JB2N72UWIa06VcnLH+0wSgcSsZh0W1M3NeX+nb4fYNv86yVc+v8NuWs+esfO2VwGEa38Adek9X3hVnhDQJD0pma73tqpy6d3/U3EsYqDV5pdAcXpsPO5fFkhesq2htEnFkKir4u4ugd9X5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 18691 invoked by uid 109); 10 Apr 2024 21:11:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 10 Apr 2024 21:11:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20186 invoked by uid 111); 10 Apr 2024 21:11:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 10 Apr 2024 17:11:02 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 10 Apr 2024 17:11:00 -0400
From: Jeff King <peff@peff.net>
To: Josh Steadmon <steadmon@google.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] fuzz: link fuzz programs with `make all` on Linux
Message-ID: <20240410211100.GA2276041@coredump.intra.peff.net>
References: <cover.1709673020.git.steadmon@google.com>
 <eef15e3d3da3ca6953fa8bf3ade190da8e68bf46.1709673020.git.steadmon@google.com>
 <xmqqplw8z73y.fsf@gitster.g>
 <ZhW6BM9V-Rto_CW4@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZhW6BM9V-Rto_CW4@google.com>

On Tue, Apr 09, 2024 at 02:58:28PM -0700, Josh Steadmon wrote:

> > It would have been easier on the eyes if we had the fuzz things
> > together, perhaps like this simplified version?  We build FUZZ_OBJS
> > either way, and when the LINK_FUZZ_PROGRAMS is requested, we follow
> > the fuzz-all recipe, too.
> 
> We need the LINK_FUZZ_PROGRAMS conditional to happen after we import
> config.mak.uname (line 1434 in my V1). We also need to define FUZZ_OBJS
> prior to adding it to OBJECTS (line 2698 in V1). I can move all of the
> fuzz-definition within that range, keeping everything in one place at
> the cost of a larger diff. I'll do that for V2, but if you prefer
> otherwise please let me know.
> 
> Although I'm not 100% sure that we even need to add FUZZ_OBJS to
> OBJECTS, so let me check that tomorrow. If not, then I can move
> everything to the bottom of the Makefile where we also define fuzz-all
> and the build rules for FUZZ_PROGRAMS.

The conditional has to be read handled while reading the Makefile, but
as a "simple" variable, OBJECTS isn't expanded until the whole Makefile
has been read. So for example this out-of-order definition works:

diff --git a/Makefile b/Makefile
index 533eaae612..5dbf1935a1 100644
--- a/Makefile
+++ b/Makefile
@@ -755,6 +755,7 @@ ETAGS_TARGET = TAGS
 # If you add a new fuzzer, please also make sure to run it in
 # ci/run-build-and-minimal-fuzzers.sh so that we make sure it still links and
 # runs in the future.
+OBJECTS += $(FUZZ_OBJS)
 FUZZ_OBJS += oss-fuzz/dummy-cmd-main.o
 FUZZ_OBJS += oss-fuzz/fuzz-commit-graph.o
 FUZZ_OBJS += oss-fuzz/fuzz-config.o
@@ -2695,7 +2696,6 @@ OBJECTS += $(SCALAR_OBJS)
 OBJECTS += $(PROGRAM_OBJS)
 OBJECTS += $(TEST_OBJS)
 OBJECTS += $(XDIFF_OBJS)
-OBJECTS += $(FUZZ_OBJS)
 OBJECTS += $(REFTABLE_OBJS) $(REFTABLE_TEST_OBJS)
 OBJECTS += $(UNIT_TEST_OBJS)
 

Now whether that is useful for organizing the Makefile, I don't know,
but I thought I'd throw it out there in case it helps you.

-Peff
