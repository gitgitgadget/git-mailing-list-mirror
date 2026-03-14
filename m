Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DF72FD660
	for <git@vger.kernel.org>; Sat, 14 Mar 2026 16:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773504504; cv=none; b=Rlii+P1TKt74r7SobyeXhlag3Km8GAiv5h/Yew9pgIUGA/t0kGkCIVo4JlSxWFkSnO/BhbR7CYKc2lLJRPStduuNjpyddtZPtWZLnFOIjMcoMzdaoddweb1jU1UjaAltoc7c1FtuLypse1CFRnk1W0UVvoPNmrhD6w/l74va+Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773504504; c=relaxed/simple;
	bh=tUVzb+hUVOLRb2DttJTOa8x2j5UowxwGwwPHHwDItw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ctoOgWt56plX2SxYaZUI7+6z/+Bx2P9tijxo4aoktZKCfY2HVp9QEajHph1nNgMZG4mPx/+kj4cDqzPWOjK3Lf5Bc8ax2PGUpNLIlIa/D90pGv07HRGdkP8iS7Fy4aIG7EF705eRphTedOZ5DDqMW0lUb1AhJbrdI9P/CUn/xVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=XQj2UQRL; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="XQj2UQRL"
Received: (qmail 116720 invoked by uid 106); 14 Mar 2026 16:08:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=tUVzb+hUVOLRb2DttJTOa8x2j5UowxwGwwPHHwDItw4=; b=XQj2UQRLpH+a53S7Hz9XIbI3xFLqnrckbJcpuuEjqTzdtirKkZXbqmSpKyTgRdJMJkdYWi4qe9t8VldOeCze852rMUtssECIqp4PSuaT/8TX3AMwGLbKeX0Km0tu2kbdmo0FliBhjOZ0Jlb9E6xLPCOIjeuy/hMrazdQQynZ5x7K88zeMUhWcynW98iP2COmKP+dq0EFoCqEaoDwb4z4rObF8RrbjAu7IoiKatrU6jS1hEapwQEU1qJETKiZgxGnE+b2gze4u0zag8PkxiwiV0sUc38+L9BNEWt102PHiqOxHgMnUfhPJ/8TGk+4R0GlkzGVgWgSYaEQfQHF2NsGsg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 14 Mar 2026 16:08:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 545657 invoked by uid 111); 14 Mar 2026 16:08:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 14 Mar 2026 12:08:15 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 14 Mar 2026 12:08:14 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Andrew Au <cshung@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v4] transport-helper, connect: use clean_on_exit to reap
 children on abnormal exit
Message-ID: <20260314160814.GA918806@coredump.intra.peff.net>
References: <20260311184206.GA1911377@coredump.intra.peff.net>
 <20260312214945.4050010-1-cshung@gmail.com>
 <xmqqsea4aen2.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsea4aen2.fsf@gitster.g>

On Thu, Mar 12, 2026 at 03:04:17PM -0700, Junio C Hamano wrote:

> Thanks, queued.

Curiously this patch seems to cause a failure in one of the CI leak
jobs, but I don't think it's the culprit. See below for a fix and
explanation.

I don't know if you want to apply it separately (since it's really a
totally different topic) or on top (since it is only the application of
Andrew's patch which lets us find the problem).

-- >8 --
Subject: [PATCH] transport: plug leaks in transport_color_config()

We retrieve config values with repo_config_get_string(), which will
allocate a new copy of the string for us. But we don't hold on to those
strings, since they are just fed to git_config_colorbool() and
color_parse(). But nor do we free them, which means they leak.

We can fix this by using the "_tmp" form of repo_config_get_string(),
which just hands us a pointer directly to the internal storage. This is
OK for our purposes, since we don't need it to last for longer than our
parsing calls.

Two interesting side notes here:

  1. Many types already have a repo_config_get_X() variant that handles
     this for us (e.g., repo_config_get_bool()). But neither colorbools
     nor colors themselves have such helpers. We might think about
     adding them, but converting all callers is a larger task, and out
     of scope for this fix.

  2. As far as I can tell, this leak has been there since 960786e761
     (push: colorize errors, 2018-04-21), but wasn't detected by LSan in
     our test suite. It started triggering when we applied dd3693eb08
     (transport-helper, connect: use clean_on_exit to reap children on
     abnormal exit, 2026-03-12) which is mostly unrelated.

     Even weirder, it seems to trigger only with clang (and not gcc),
     and only with GIT_TEST_DEFAULT_REF_FORMAT=reftable. So I think this
     is another odd case where the pointers happened to be hanging
     around in stack memory, but changing the pattern of function calls
     in nearby code was enough for them to be incidentally overwritten.

Signed-off-by: Jeff King <peff@peff.net>
---
 transport.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/transport.c b/transport.c
index 107f4fa5dc..2fb4767821 100644
--- a/transport.c
+++ b/transport.c
@@ -54,14 +54,14 @@ static int transport_color_config(void)
 		return 0;
 	initialized = 1;
 
-	if (!repo_config_get_string(the_repository, key, &value))
+	if (!repo_config_get_string_tmp(the_repository, key, &value))
 		transport_use_color = git_config_colorbool(key, value);
 
 	if (!want_color_stderr(transport_use_color))
 		return 0;
 
 	for (size_t i = 0; i < ARRAY_SIZE(keys); i++)
-		if (!repo_config_get_string(the_repository, keys[i], &value)) {
+		if (!repo_config_get_string_tmp(the_repository, keys[i], &value)) {
 			if (!value)
 				return config_error_nonbool(keys[i]);
 			if (color_parse(value, transport_colors[i]) < 0)
-- 
2.53.0.887.g3d5d06adec

