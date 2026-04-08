Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8A5358381
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 05:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775627031; cv=none; b=g3Vuc7uD6joO0oO1cxKXr6Z1d60yPpO6ZY6GPTgC8HgpKEyYnLBPP8i+OnQyhgYDblIJvOzOrT5OOsjC9l+fE4MjH8Lbs1NTJzAZ3WvLu3OqGZHHu9TKOpYakiK2szK4XJpGRS9zeHm0Gc5SNycHsoguArcOz9iddt/XdXdcAS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775627031; c=relaxed/simple;
	bh=6mIV65D75Zju19Z1fsu7V8G786aynm7ywN0A/HFa/B4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U2HzMVDYEeha6IwsZ4w4HPqNWTjbLzN4TW6l1ekbsOZM0C82AM99rd/5/r/z4HPdrF/v3lcorBXJYRG2tqAO+m93J8BODMJkVDue64z6SqqatnYK0LSFXqKffoLfazBof6MO9Gi5OyvuuFJtcKfEZiRkFt1XY/LVcSobZYahiVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=K+1mmZXZ; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="K+1mmZXZ"
Received: (qmail 279663 invoked by uid 106); 8 Apr 2026 05:43:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=6mIV65D75Zju19Z1fsu7V8G786aynm7ywN0A/HFa/B4=; b=K+1mmZXZJ58NXhFsVpnXnHQ61RmPrXKt3dqWFygybZWdkNTC+9diUM/UXWs4HbYVpO9iDSmQhQXSDhVPHJIzt87pY7LJpQ3ThUl2I2XYj292ytAf6oV5rqikd5weXg5aDsbb/WYcxMdGESharZ1uNkZEc+6ye7Sz8B/zkffpgZH8Zd1rWIK1CFiZHaLIFNjNHGtqu/mljlkCN5lN2NSaNhngvPLwpbb8WVnkMaGOXe7pCoS3tSrBh9XWewCdBguvkD6mlyxbdqMNLYC+6ucZEqZiC4Yss1sH7gxW5Vk7j+y7toJaY9beiZtiU5Ewu+T1NxtIpAwtYseHInvrBEZFww==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 08 Apr 2026 05:43:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 457674 invoked by uid 111); 8 Apr 2026 05:43:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 08 Apr 2026 01:43:47 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 8 Apr 2026 01:43:47 -0400
From: Jeff King <peff@peff.net>
To: rsbecker@nexbridge.com
Cc: Junio C Hamano <gitster@pobox.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>, git@vger.kernel.org
Subject: Re: Help needed on 2.54.0-rc0 t5301.13 looping.
Message-ID: <20260408054347.GA2284358@coredump.intra.peff.net>
References: <00f501dcc6e7$8ef295c0$acd7c140$@nexbridge.com>
 <20260408052031.GB1324339@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260408052031.GB1324339@coredump.intra.peff.net>

On Wed, Apr 08, 2026 at 01:20:31AM -0400, Jeff King wrote:

> I suspect we could construct a related case that does fail on Linux
> without the patch above. Imagine we actually have two hooks running in
> parallel. The first one is fast and does not read its input, and the
> second one is slow. We'll get SIGPIPE writing to the first one, and then
> kill _both_ children. But that's wrong! There is no reason to kill the
> second hook, as our intent was to ignore SIGPIPE.

This would require running hooks in parallel, which isn't implemented
yet for v2.54.0. But if I build on top of the ar/parallel-hooks topic,
then this test:

diff --git a/t/t5401-update-hooks.sh b/t/t5401-update-hooks.sh
index 44ec875aef..97257763d3 100755
--- a/t/t5401-update-hooks.sh
+++ b/t/t5401-update-hooks.sh
@@ -139,4 +139,43 @@ test_expect_success 'pre-receive hook that forgets to read its input' '
 	git push ./victim.git "+refs/heads/*:refs/heads/*"
 '
 
+test_expect_success 'hooks in parallel that do not read input' '
+	# Add this to our $PATH to avoid having to write the whole trash
+	# directory into our config options, which would require quoting.
+	mkdir bin &&
+	PATH=$PWD/bin:$PATH &&
+
+	write_script bin/hook-fast <<-\EOF &&
+	# This hook does not read its input, so the parent process
+	# may see SIGPIPE if it is not ignored. It should happen
+	# relatively quickly.
+	exit 0
+	EOF
+
+	write_script bin/hook-slow <<-\EOF &&
+	# This hook is slow, so we expect it to still be running
+	# when the other hook has exited (and the parent has a pipe error
+	# writing to it).
+	#
+	# So we want to be slow enough that we expect this to happen, but not
+	# so slow that the test takes forever. 1 second is probably enough
+	# in practice (and if it is occasionally not on a loaded system, we
+	# will err on the side of having the test pass).
+	sleep 1
+	exit 0
+	EOF
+
+
+	git init --bare parallel.git &&
+	git -C parallel.git config hook.fast.command "hook-fast" &&
+	git -C parallel.git config hook.fast.event pre-receive &&
+	git -C parallel.git config hook.fast.parallel true &&
+	git -C parallel.git config hook.slow.command "hook-slow" &&
+	git -C parallel.git config hook.slow.event pre-receive &&
+	git -C parallel.git config hook.slow.parallel true &&
+	git -C parallel.git config hook.jobs 2 &&
+
+	git push ./parallel.git "+refs/heads/*:refs/heads/*"
+'
+
 test_done

fails reliably. And applying the patch I suggested earlier fixes it.

So I think it's probably a good idea regardless, though I'm still
curious to see if it solves Randall's non-parallel case on NonStop.

-Peff
