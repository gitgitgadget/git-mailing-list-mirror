Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F65B13A87C
	for <git@vger.kernel.org>; Fri, 13 Sep 2024 04:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726203314; cv=none; b=T0gi0blglNE4b+aGcp+Xy0SJ7LvWTzo/1oHQSAafu+RJIPI69KtnB65ZZ8J7IhqvPATfglX2Uuvm8I4iKCg556DWu5G7x1//TQTSlL8Exl3LzWbFmFIW3aaZq+xXB+cVPRBWepJN9zeg2YzoUTeTAxB22GTy6xBNqP1RR/qwQlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726203314; c=relaxed/simple;
	bh=iTK6Bon/sBdEAiosggvZIrj+SLBVEOnqIi87lMxX794=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vEvAP5hE/ZHo3A90iDs3VAKX1aIhMxNnQ/BzbrzjbI7qHycckoB/mIjXex9yU3phSkmZOAyXVTXsr/29mwTlKzZ3utcylPSFnWgcXeH4EfAxdiDNZI5rwhR9ZEDFazWy3sFShifuY4DpzFO4h9nO9FVxC2X+7mYxzhM/v9k1bVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 22957 invoked by uid 109); 13 Sep 2024 04:55:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 13 Sep 2024 04:55:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31830 invoked by uid 111); 13 Sep 2024 04:55:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 13 Sep 2024 00:55:10 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 13 Sep 2024 00:55:10 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/4] ci: use more recent linux32 image
Message-ID: <20240913045510.GA1194807@coredump.intra.peff.net>
References: <20240912094238.GA589050@coredump.intra.peff.net>
 <20240912094730.GC589828@coredump.intra.peff.net>
 <ZuLFPxsDiMB9UBhF@pks.im>
 <20240912112242.GA622312@coredump.intra.peff.net>
 <ZuLWHBvrT31KVd9W@pks.im>
 <ZuLi4x664v8dbm2i@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZuLi4x664v8dbm2i@pks.im>

On Thu, Sep 12, 2024 at 02:47:38PM +0200, Patrick Steinhardt wrote:

> On Thu, Sep 12, 2024 at 01:53:00PM +0200, Patrick Steinhardt wrote:
> > On Thu, Sep 12, 2024 at 07:22:42AM -0400, Jeff King wrote:
> > > On Thu, Sep 12, 2024 at 12:41:03PM +0200, Patrick Steinhardt wrote:
> > And with that the [fixed] pipeline builds and executes our tests just
> > fine. I didn't wait for tests to finish though.
> > 
> > Patrick
> > 
> > [here]: https://gitlab.com/gitlab-org/git/-/merge_requests/210
> > [first]: https://gitlab.com/gitlab-org/git/-/jobs/7808775485
> > [fixed]: https://gitlab.com/gitlab-org/git/-/jobs/7808836999
> 
> Most of the tests pass, except for t5559. Seems like it doesn't have
> mod_http2. Maybe its Apache version is too old, or it needs to be
> installed separately.

Yeah, according to "apt-file", there's no package which contains
mod_http2.so. t5559 is supposed to notice that during webserver setup
and just skip the script. Poking at it myself in a xenial container, I
think it does do so correctly. So that's good.

But the CI environment switches GIT_TEST_HTTPD from "auto" to "true",
turning a setup failure into an error. This is overall a good thing
(since we'd notice if our apache setup breaks), but obviously is wrong
here. Unfortunately we don't have a knob just for http2. So the best we
can do is something like (might be whitespace-damaged, I just pasted it
out of a container session):

diff --git a/ci/lib.sh b/ci/lib.sh
index 51f8f59..0514f6a 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -336,7 +336,15 @@ ubuntu-*)
	fi
	MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/$PYTHON_PACKAGE"

-	export GIT_TEST_HTTPD=true
+	case "$distro" in
+	ubuntu-16.04)
+		# too old for http/2
+		export GIT_TEST_HTTPD=auto
+		;;
+	*)
+		export GIT_TEST_HTTPD=yes
+		;;
+	esac

	# The Linux build installs the defined dependency versions below.
	# The OS X build installs much more recent versions, whichever


That would still run the regular tests, and just turn the http2 failure
into a "skip". But it does make me nervous that we'd break something for
the non-http2 tests on that old platform and never realize it. So maybe
we need a GIT_TEST_HTTP2 knob that defaults to the value of
GIT_TEST_HTTPD. And then we can turn it off for 16.04, leave the regular
one as "yes".

I assume you're collecting a few patches to make your new xenial job
work. I think what I suggested above should be pretty easy to implement,
but let me know if you'd like me to come up with something concrete.

-Peff
