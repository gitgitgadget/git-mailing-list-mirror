Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692FF28690
	for <git@vger.kernel.org>; Sun, 28 Jun 2026 08:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782633613; cv=none; b=WnXd5aV2ISc1QGQsrHSvz552mnlMPC7kl/yuqHdG+BN1fS+vA7kaPeDCoA9AiVSjm4fD0MHOCMJeTRBROAiC5BmlYUVEyhvNxqx2wImRDEBqJPErSgK5fvfrJP2dFJ1QfLdYci8Ub7xXE7aUcpyMaJgyyXsw2oNgomXpW8B2gpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782633613; c=relaxed/simple;
	bh=6FWnNnnewPAe13wniPvUDWHOPZlSp9YUZKeyc+k7ea8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=heVNwm7AbOAV3Sm+8JZzMwTZ0LW4OsMg/wN2T301SFhuCRHKNP3CfhGU+2Vu3YgYcA477oeVX7UhYX1LMg1vVX6aV8EtnbVChC8Y7Kt4T0ztv+SxJTOtbkSRaCJ2TZUBsgJdPzPn42yfutZUoN7pE3uCtEEWMZ46UbBS3F1siSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=OdfB5PrL; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="OdfB5PrL"
Received: (qmail 52209 invoked by uid 106); 28 Jun 2026 08:00:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=6FWnNnnewPAe13wniPvUDWHOPZlSp9YUZKeyc+k7ea8=; b=OdfB5PrLxGILC0B5WZdrMO1LXGxTeaYjbIBuNT0KFngokxy7u2z1cqTJ8lpg4lfuar/z3Dsm4KhRw+UWUAt011Lid4XMlisTgqwWhYBYzYIiG4btaeJwzk0lGzzcmdfSkdrbxLDYARpGxpWj8ulVPLzVDx9SiKZcILDlJMW8Vm224XyOP6k2vz3kyxgXs66PGex3TvN38jB9RsLTEv7G7DXzPy4FvJTSYN19I8bfUnZdgASoVylsqkSrnEbveZPcdDoh/CKPQ2zeLUFaMxSlBjKdwE7IYvGOVLGDn/yRHjgl3L425A7RhU2phCsiij2dMsiK+GV/WVnbRLXold4hqQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 28 Jun 2026 08:00:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 111233 invoked by uid 111); 28 Jun 2026 08:00:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 28 Jun 2026 04:00:09 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 28 Jun 2026 04:00:09 -0400
From: Jeff King <peff@peff.net>
To: Michael Montalbo <mmontalbo@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] t/lib-httpd: bump apache timeout
Message-ID: <20260628080009.GA107826@coredump.intra.peff.net>
References: <20260628075716.GA3525066@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260628075716.GA3525066@coredump.intra.peff.net>

Since enabling more tests with 7a094d68a2 (ci: run expensive tests on
push builds to integration branches, 2026-05-08), we sometimes see test
failures or timeouts in GitHub CI. The culprit seems to be the "enormous
ref negotiation" test in t5551, which creates ~100k tag refs in our http
server-side repo.

Iterating through the loose refs of this repo to generate a ref
advertisement can take a long time, especially on a platform with slow
I/O. On my otherwise unloaded local machine, a cold cache ref
advertisement takes ~10s. On a busy CI machine running tests in
parallel, it can presumably top 60s, which runs afoul of Apache's
default CGI timeout.

The result in t5551 is a test failure, where Apache simply hangs up the
connection and the client reports an error. But worse, t5559 runs the
same test with HTTP/2, and a bug in Apache causes the connection to hang
indefinitely! We eventually see this as a CI timeout after 6 hours.

Let's bump Apache's timeout to something much larger: 600 seconds. This
doesn't eliminate the possibility of a timeout, but it makes it much
less likely. It should eliminate both the test failures and the CI
timeouts in practice, and it protects us from running into similar
problems with other tests in the future.

There are two counter-arguments to consider.

One, could/should we just make the test faster? Probably yes. The
biggest mistake here is having such an absurd number of unpacked refs on
a system which is bottle-necked on I/O. But I think it's worth bumping
the timeout so that we can fix this (and possibly other) correctness
issues, and then consider performance separately (which we'll do in
subsequent patches).

And two, is this just papering over a problem that users might see in
the real world? We could teach Git to handle this case more gracefully
with optimizations or keep-alives. But I think it's really an artificial
situation. You need a combination of this silly number of loose refs,
plus a very heavily loaded system. If you were trying to run a real
server and it took more than 60s to generate the ref advertisement, I
don't think the timeout is your biggest problem. Your crappy service is,
and you should adjust your resources to match your load. I.e., it is
probably reasonable for Git to assume that advertisements happen
fast-ish and don't need protocol-level keepalives.

Though the patch here is small, tons of work went into analyzing the
problem. Many thanks to the contributors credited below.

Helped-by: Michael Montalbo <mmontalbo@gmail.com>
Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Jeff King <peff@peff.net>
---
I didn't reference Michael's bugzilla report directly, because you can't
read it without a login. :(

Maybe it's worth doing anyway?

 t/lib-httpd/apache.conf | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 40a690b0bb..4149fc1078 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -4,6 +4,7 @@ DocumentRoot www
 LogFormat "%h %l %u %t \"%r\" %>s %b" common
 CustomLog access.log common
 ErrorLog error.log
+Timeout 600
 <IfModule !mod_log_config.c>
 	LoadModule log_config_module modules/mod_log_config.so
 </IfModule>
-- 
2.55.0.rc2.353.gf769b6597e

