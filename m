Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B93C1E1C3F
	for <git@vger.kernel.org>; Wed,  1 Jan 2025 20:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735762350; cv=none; b=DOC2McAx9hLzCiLMZPo2roau+y71HAvip22Kov/BjWM4KFe5iYZPbl/T0OeSt3HthfAvIxREdIpgpY/tQfH58JecArdidA3jq7wRPaa4l5Z7G6SwZlJvGxPwMqjZNyBmvpASndD0pPyIPmoaU1lI33JmHucbG6/byncKB+X5NQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735762350; c=relaxed/simple;
	bh=z96zTSL+qBdmHB/OXa4stcFh52sZP85uSM0IX2v/0IE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TpxfSSj8/igS5FJio/Cvsnhjby4ykXqA86uBq3EHoOa9Du9pE2rqBOX2fDbqxZZ6Wzc9E7TPH7c1Mt1GbrVomQjoWpHvyBgfd6AUm4A+hMlh4Qk/I2FBlrHH+inwjCVNAs90KHFlTjFDxdFAUOPXDFJQFgxVnBI3eN9w+rxOET8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ceBT45GW; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ceBT45GW"
Received: (qmail 22939 invoked by uid 109); 1 Jan 2025 20:12:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=z96zTSL+qBdmHB/OXa4stcFh52sZP85uSM0IX2v/0IE=; b=ceBT45GW5O7jOPxqU6/R478/zTCfZOo7NgUwV9B1qoD4wfYnV9TO3HOc9Hfpe7zcKSdjXt9zCK03Z9/LOxkT5ubYfp8YguJHIShLr9hWykJeSqXaG+7/z7N5cHhUns4wH3K6GoFbJXjxcawHhHZ6K2Xk5a3pdFLZdiT6A9m98lumMb4vfTWn3Xa8VEO8Yx5gPYrFds+JkYg5ORlUHKau321kBl+7HsSx8vvtadap3N21pUVDIGaNVcbs8XdTTNw6LoScaZtubqKbbdAW14uzN6hSBQQHnXzHaOOGKvnPj6uhvBomm+ksmYSBHkgBu3yIqoLlsr8U0+tAgBONsahO8g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 01 Jan 2025 20:12:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11387 invoked by uid 111); 1 Jan 2025 20:12:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Jan 2025 15:12:26 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 1 Jan 2025 15:12:26 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: [PATCH 0/6] a less-invasive racy-leak fix
Message-ID: <20250101201226.GA3304465@coredump.intra.peff.net>
References: <xmqqpll9xehr.fsf@gitster.g>
 <20250101191422.GC1391912@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250101191422.GC1391912@coredump.intra.peff.net>

On Wed, Jan 01, 2025 at 02:14:22PM -0500, Jeff King wrote:

> And finally, one other option (that I'm not sure why I didn't consider
> before): can we just ignore the false positives, similar to what we did
> in 370ef7e40d (test-lib: ignore uninteresting LSan output, 2023-08-28).
> I think we'd have to stop doing abort_on_error for the leak checker and
> just rely on the logs, but that's OK (we always check the logs these
> days). And detecting the false positive is a little involved. But this
> seems to work:

So here's a clean series that does that. I'm kicking myself a little for
not going this route immediately, and spending so much time trying to
deal with the actual race in code that is not even ours. :-/

It would replace what's queued in jk/lsan-race-with-barrier, though the
first two patches remain the same.

Since the grep exit codes and inversions are a little tricky, I checked
at each step that we continue to correctly report the leaks found by
doing:

diff --git a/t/helper/test-date.c b/t/helper/test-date.c
index f25512de9a..7bedb51eaf 100644
--- a/t/helper/test-date.c
+++ b/t/helper/test-date.c
@@ -54,8 +54,6 @@ static void show_dates(const char **argv, const char *format)
 
 		printf("%s -> %s\n", *argv, show_date(t, tz, mode));
 	}
-
-	date_mode_release(&mode);
 }
 
 static void parse_dates(const char **argv)

and running "./t0006-date.sh -i" (which should bail on test 23 and
report the full stack trace).

  [1/6]: test-lib: use individual lsan dir for --stress runs
  [2/6]: Revert "index-pack: spawn threads atomically"
  [3/6]: test-lib: rely on logs to detect leaks
  [4/6]: test-lib: simplify leak-log checking
  [5/6]: test-lib: check leak logs for presence of DEDUP_TOKEN
  [6/6]: test-lib: ignore leaks in the sanitizer's thread code

 builtin/index-pack.c |  2 --
 t/test-lib.sh        | 25 +++++++++++--------------
 2 files changed, 11 insertions(+), 16 deletions(-)

-Peff
