Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3A332F49D
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 20:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758054329; cv=none; b=kf6w3VAn4dxb4uf5m6nU2OP/bs0sgiHhQ3c/fx2FMugG5pA7It8UpVbukMTJDgDfjjWw1YZmqlzOT1i30lVTZJPU3ivZFkKUxLZ0On0N6uxBFx3r3F/pdlvn1ChAhoF/gMBam3tTzxdeAml919C9wbn+cH7i/K+icDnvxWIDoB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758054329; c=relaxed/simple;
	bh=Hsp+OgYJVU/7nKiIliM8kAAtiSLqHaHLHatXHXPJpP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ef6Xv8j696vVuOZaIVJa0XzwlqhPRc/FfcML+TPviIw4VfvtMk9PTxg0l6kAZyHY93gO7lNsiGGLhjhLQImoEquqUt7MholFSzgi/2TapWtOOXJI03EQu83VxjJUg60RAjwlYXqSjCy/Zia2CtxTbTQT6Y1Yya+LVde2Yom443w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=SLk6+36R; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="SLk6+36R"
Received: (qmail 102480 invoked by uid 109); 16 Sep 2025 20:25:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Hsp+OgYJVU/7nKiIliM8kAAtiSLqHaHLHatXHXPJpP0=; b=SLk6+36RBmmg2NBrvV8KQYSjeIKeSnTQUgtTDBHXBDlFFg9c2LiS8UAMXaoczIwq43XpSiEVWfzmB9lLqZ1By1iZr3Pprth+OOUpinzwXtXwx63dBWpilrZ0zBLD6hzE8R9tsnNFF3D+N8AZtHXzLVFw6UZ5KfVBG06T/hcWxHFiYo7agQ0AkEFoG8TaVrVkj0GsVb1EDu9mmiCD5RKwI+1sKYcbr0n5aaNYyDYKT7uOxlx/rNujAipGsYqfNlHmKNxotzq3EH1+5Aed9vOxoNeh/9Ndm8t+UmJAal7PDsH2VEqZpdOqg/NrtmQ0qiKswgAVtxKIanANSgK0FngN0A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Sep 2025 20:25:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 166300 invoked by uid 111); 16 Sep 2025 20:25:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Sep 2025 16:25:26 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 16 Sep 2025 16:25:26 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 10/13] color: return bool from want_color()
Message-ID: <20250916202526.GJ612873@coredump.intra.peff.net>
References: <20250916201036.GA612463@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250916201036.GA612463@coredump.intra.peff.net>

The point of want_color() is to take in a git_colorbool enum value and
collapse it down to a single true/false boolean, letting UNKNOWN fall
back to the color.ui default and checking isatty() for AUTO.

Let's make that more clear in the type system by returning a bool rather
than an integer.

This sadly still does not help us much with compiler warnings for using
the two types interchangeably. But it helps make the intent more clear
to a human reader.

We still retain the idempotency of want_color(), because in C a bool
true/false converts to 1/0 when converted to an integer, which
corresponds to GIT_COLOR_ALWAYS and GIT_COLOR_NEVER. So you can store
the bool in a git_colorbool and get the right result (something a few
pieces of code still do, but which we'll clean up in further patches).

Note that we rely on this same bool/int conversion for
check_auto_color(). We cache its results in a tristate int with "-1" as
"not yet set", but we can assign to it (and return it) with implicit
conversions to/from bool.

Signed-off-by: Jeff King <peff@peff.net>
---
 color.c | 8 ++++----
 color.h | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/color.c b/color.c
index 3348ead534..07ac8c9d40 100644
--- a/color.c
+++ b/color.c
@@ -391,20 +391,20 @@ enum git_colorbool git_config_colorbool(const char *var, const char *value)
 	return GIT_COLOR_AUTO;
 }
 
-static int check_auto_color(int fd)
+static bool check_auto_color(int fd)
 {
 	static int color_stderr_is_tty = -1;
 	int *is_tty_p = fd == 1 ? &color_stdout_is_tty : &color_stderr_is_tty;
 	if (*is_tty_p < 0)
 		*is_tty_p = isatty(fd);
 	if (*is_tty_p || (fd == 1 && pager_in_use() && pager_use_color)) {
 		if (!is_terminal_dumb())
-			return 1;
+			return true;
 	}
-	return 0;
+	return false;
 }
 
-int want_color_fd(int fd, enum git_colorbool var)
+bool want_color_fd(int fd, enum git_colorbool var)
 {
 	/*
 	 * NEEDSWORK: This function is sometimes used from multiple threads, and
diff --git a/color.h b/color.h
index fcb38c5562..43e6c9ad09 100644
--- a/color.h
+++ b/color.h
@@ -106,7 +106,7 @@ enum git_colorbool git_config_colorbool(const char *var, const char *value);
  * Return a boolean whether to use color, where the argument 'var' is
  * one of GIT_COLOR_UNKNOWN, GIT_COLOR_NEVER, GIT_COLOR_ALWAYS, GIT_COLOR_AUTO.
  */
-int want_color_fd(int fd, enum git_colorbool var);
+bool want_color_fd(int fd, enum git_colorbool var);
 #define want_color(colorbool) want_color_fd(1, (colorbool))
 #define want_color_stderr(colorbool) want_color_fd(2, (colorbool))
 
-- 
2.51.0.527.g34bc42dacd

