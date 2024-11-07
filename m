Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD85579F6
	for <git@vger.kernel.org>; Thu,  7 Nov 2024 02:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730944867; cv=none; b=ZmF6Oa+k/1i6npmKmxfnAJT3H83muNJ1dxFTFPG/neK6+XRsrC2g1FRuTL/8VlFa0DXZWhYxX0xbEChxyfYhD7ITejktOmf1z0sgs3S2mIxI5BTnc7ys/dJF92DxLMZw2Rcs1eXhbtPQVca7uZhLHfsfeUzAvf4hyk7SRCTbMeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730944867; c=relaxed/simple;
	bh=EauAu9y69EHNKtEGMGbZNbZHeutoHbvDeAiR/kf08sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JKZwi7f1JKZb582hKkCnUubBbe4HT+JYl87WXer3FubiO4FoBzqQhclKKffH0cebcynFJxLXUphL0tN57EiWUaTS0YjiYBraSZ6LugR51SfTpW1qs/fIVjZ41AvpsoDe4efO2OJjKFaFuGCS/XHTTcCOFsa8IBmycluebHUHnXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=KUxuFmcO; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="KUxuFmcO"
Received: (qmail 17595 invoked by uid 109); 7 Nov 2024 02:01:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=EauAu9y69EHNKtEGMGbZNbZHeutoHbvDeAiR/kf08sw=; b=KUxuFmcO7ZVrlo9H0ViRBxH1XuuHqJwD8GjvjHKzOLdvhZjmZ6S27A+cJ4HUdnu3Z/AzfH5nXjaM67h4czB2HJZO1R+lDDJqzJ3zP3olsuRJfTcIC/6q/h+lyE6bmF8oxr0Cg46/nGmLdPNsVU0vXjw8B50KjW9gdcuvJZ2eSNvBTiTn3PYqJFyIodvzxgmOcNJ9AP5BUzUVBCnk8QVFvxqFgAUwhHsCPRl2mq5ccr2tmix9oAONqtAUDhWRiTLv5xfakR3FTO4F7y1xet9YC9/qiN9OElKE35ep9YQSudpTbeVOq8y/MUiEYPyo/FC5RA7zZSG8pXHzimkxD7Jwew==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Nov 2024 02:01:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10399 invoked by uid 111); 7 Nov 2024 02:01:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 06 Nov 2024 21:01:00 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 6 Nov 2024 21:01:00 -0500
From: Jeff King <peff@peff.net>
To: Adam Murray via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Adam Murray <ad@canva.com>
Subject: Re: [PATCH] trace2: prevent segfault on config collection where no
 value specified
Message-ID: <20241107020100.GC961214@coredump.intra.peff.net>
References: <pull.1814.git.1730937889182.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1814.git.1730937889182.gitgitgadget@gmail.com>

On Thu, Nov 07, 2024 at 12:04:48AM +0000, Adam Murray via GitGitGadget wrote:

> When TRACE2 analytics is enabled, a git config option that has no value
> causes a segfault.
> 
> Steps to Reproduce
> GIT_TRACE2=true GIT_TRACE2_CONFIG_PARAMS=status.*
> git -c status.relativePaths version
> Expected Result
> git version 2.46.0
> Actual Result
> zsh: segmentation fault GIT_TRACE2=true
> 
> This adds a null check to prevent the segfault and instead return
> the "empty config value" error.

We definitely should deal with the NULL here, but I'm not sure that
returning an error is correct. A value-less config like this is a
synonym for "true". If the point of this code is to dump a trace of
config settings, then by returning without printing anything, we're
misleading the user.

I.e., doing this, with an explicit value for the config option:

  GIT_TRACE2=true GIT_TRACE2_CONFIG_PARAMS=status.* git -c status.relativePaths=true version

should (and does) show:

  20:48:11.662470 trace2.c:437                      def_param scope:command status.relativepaths=true

If we swap that our for "-c status.relativePaths", then the outcome is
the same: we've turned on that config option. But with your patch, the
trace won't mention it at all.

> diff --git a/trace2.c b/trace2.c
> index f894532d053..5df43478b8f 100644
> --- a/trace2.c
> +++ b/trace2.c
> @@ -759,7 +759,7 @@ void trace2_def_param_fl(const char *file, int line, const char *param,
>  	int j;
>  	const char *redacted;
>  
> -	if (!trace2_enabled)
> +	if (!trace2_enabled || !value)
>  		return;
>  
>  	redacted = redact_arg(value);

So here I think we need to either:

  1. Just quietly substitute "true" for the value. For a bool, the two
     are equivalent, and this is probably an acceptable fiction for a
     trace to show. For a non-bool (e.g., something like "author.name"),
     though, it's an error, and the trace is somewhat misleading.

  2. Put in some special marker for the NULL value. Something like
     "(null)" works, but it's ambiguous with a config of the same value
     (which obviously you wouldn't expect in normal use, but since the
     point of tracing is often to debug, I could see it being
     misleading).

All of this is made harder by the fact that there are multiple output
targets. So you'd have to pass the NULL down to them and let them handle
it. Something like:

diff --git a/trace2.c b/trace2.c
index 5df43478b8..e67edf4b1b 100644
--- a/trace2.c
+++ b/trace2.c
@@ -759,10 +759,10 @@ void trace2_def_param_fl(const char *file, int line, const char *param,
 	int j;
 	const char *redacted;
 
-	if (!trace2_enabled || !value)
+	if (!trace2_enabled)
 		return;
 
-	redacted = redact_arg(value);
+	redacted = value ? redact_arg(value) : NULL;
 
 	for_each_wanted_builtin (j, tgt_j)
 		if (tgt_j->pfn_param_fl)
diff --git a/trace2/tr2_tgt_normal.c b/trace2/tr2_tgt_normal.c
index baef48aa69..924736ab36 100644
--- a/trace2/tr2_tgt_normal.c
+++ b/trace2/tr2_tgt_normal.c
@@ -307,8 +307,9 @@ static void fn_param_fl(const char *file, int line, const char *param,
 	enum config_scope scope = kvi->scope;
 	const char *scope_name = config_scope_name(scope);
 
-	strbuf_addf(&buf_payload, "def_param scope:%s %s=%s", scope_name, param,
-		    value);
+	strbuf_addf(&buf_payload, "def_param scope:%s %s", scope_name, param);
+	if (value)
+		strbuf_addf(&buf_payload, "=%s", value);
 	normal_io_write_fl(file, line, &buf_payload);
 	strbuf_release(&buf_payload);
 }

but you'd need to do the same for each target implementation.

-Peff
