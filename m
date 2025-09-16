Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4362DD60F
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 20:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758053650; cv=none; b=MQVeUB0CMX7WREkWe/X6W48TuWzZssqn0eKSHmDZDRl++hEGu+jm6G05tagnABt6pcXyAlHkwCA5KDt+VH2QFE7iU20QoSsie35lRl6mZlv/J2UqtJbfPIQXL8fnV0GukESuSK1MvG0+2tJwE1oWIBPD6qUW/J/Nq0ACMCm6L1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758053650; c=relaxed/simple;
	bh=byHBubnhWle0QKVHpSU54u3+FmzT2b0qxD5rdhJmsvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PhvgwwdmXwnYZa7O2qUgcvvP2sJROGvRb2IeUP3Qc3wXThyGhyL+iAXsil4e+N/ZHLBm9y2ZmIOzrXAWA335WtEGunr6I+d5OTIG9KIK5bfOjQvXZ68wmbluFzOkR2VFtzGDqVAQpy7ntZIPL5r4x9+2Ib/eBuyZcwblZzAFMHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=cShnwVPz; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="cShnwVPz"
Received: (qmail 102268 invoked by uid 109); 16 Sep 2025 20:14:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=byHBubnhWle0QKVHpSU54u3+FmzT2b0qxD5rdhJmsvU=; b=cShnwVPzpb2XQG6aiXX3nojx41CaLT5BvagsrALR668xHEKS0PlamPdJbpzZTDU9WszU5Q7TXrHgp1AB/Cwml0aajcxxjz+SGKJctxbN3lN39fSUGQULugAN9vPhDzysrY+/j3Gnp2pw+vRjYZusSUzPDcBKOCPRZCkBIX4YDnKCc71BxJcYc6gVCJOOdXu+hCWnQRczZjzzA1msponpkj5iuFi8agPWuO2aweU2Mse3+MN0YJ1o1PyM1N4ctUdOf/ChPmdu/+8eohASvMLPUdXftTxj3rArZdSL7YUbEKFiS7nOQQvdgx0VJy2RHSYEhf72gI3s8zM5alRQ7hlCbQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Sep 2025 20:14:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 166091 invoked by uid 111); 16 Sep 2025 20:14:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Sep 2025 16:14:07 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 16 Sep 2025 16:14:07 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 02/13] color: return enum from git_config_colorbool()
Message-ID: <20250916201407.GB612873@coredump.intra.peff.net>
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

The git_config_colorbool() function returns an integer which is always
one of the GIT_COLOR_* constants UNKNOWN, NEVER, ALWAYS, or AUTO. We
define these constants with macros, but let's switch to using an enum.
Even though the compiler does not strictly enforce enum/int conversions,
this should make the intent clearer to human readers. And as a bonus,
enum names are typically available to debuggers, making it more pleasant
to step through the code there.

This patch updates the return type of git_config_colorbool(), but holds
off on updating all of the callers. There's some trickiness to some of
them, and in the meantime it's perfectly fine to assign an enum into an
int.

Signed-off-by: Jeff King <peff@peff.net>
---
 color.c |  2 +-
 color.h | 12 +++++++-----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/color.c b/color.c
index 22aa453fef..f3adce0141 100644
--- a/color.c
+++ b/color.c
@@ -369,7 +369,7 @@ int color_parse_mem(const char *value, int value_len, char *dst)
 #undef OUT
 }
 
-int git_config_colorbool(const char *var, const char *value)
+enum git_colorbool git_config_colorbool(const char *var, const char *value)
 {
 	if (value) {
 		if (!strcasecmp(value, "never"))
diff --git a/color.h b/color.h
index 7ed259a35b..303e2c9a6d 100644
--- a/color.h
+++ b/color.h
@@ -73,10 +73,12 @@ struct strbuf;
  * returned from git_config_colorbool. The "auto" value can be returned from
  * config_colorbool, and will be converted by want_color() into either 0 or 1.
  */
-#define GIT_COLOR_UNKNOWN -1
-#define GIT_COLOR_NEVER  0
-#define GIT_COLOR_ALWAYS 1
-#define GIT_COLOR_AUTO   2
+enum git_colorbool {
+	GIT_COLOR_UNKNOWN = -1,
+	GIT_COLOR_NEVER = 0,
+	GIT_COLOR_ALWAYS = 1,
+	GIT_COLOR_AUTO = 2,
+};
 
 /* A default list of colors to use for commit graphs and show-branch output */
 extern const char *column_colors_ansi[];
@@ -98,7 +100,7 @@ int git_color_config(const char *var, const char *value, void *cb);
  * GIT_COLOR_ALWAYS for "always" or a positive boolean,
  * and GIT_COLOR_AUTO for "auto".
  */
-int git_config_colorbool(const char *var, const char *value);
+enum git_colorbool git_config_colorbool(const char *var, const char *value);
 
 /*
  * Return a boolean whether to use color, where the argument 'var' is
-- 
2.51.0.527.g34bc42dacd

