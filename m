Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F35E56B850
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 20:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788985647; cv=none; b=cICcDzccK4vh6R+t9LBSpm2X/ydL3OGQw720nQVPsGQHrZHvHieOHd7WeUGNe1b1VBNQbJs+Q4suhjW1Hl1BDJqzqAGOmbydUCSJHvszi0w4ihFVkgoLOHGh/CisCIi+NP3Wd4DGi/sp2770L7L7BROadsvD49/DVC1gl0ol1SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788985647; c=relaxed/simple;
	bh=NAgeYjqbJDItD7+UTqGS5f/PqnY8X0+eSJG7iCOLB+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hkm5GYw5NLvxr5HhpoDLiXfPoIXSjustHEMzIDxTZlwz4sYHaZv2xvHvNpLhs3s0pQX7fI1VNHsbjvIRXMqVPqyG2GLRp6BvW1IkkSl6WMaeTc1or6F4kNrofBArwwDoCnDgZFq468TnPAT+3kfEycdh3bPixyhk4kg/ti/69TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=PL4Zr+YH; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="PL4Zr+YH"
Received: (qmail 28885 invoked by uid 106); 9 Sep 2026 20:27:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=NAgeYjqbJDItD7+UTqGS5f/PqnY8X0+eSJG7iCOLB+E=; b=PL4Zr+YHPq7CueDPXEmOWwkpiPibjxgkfyuqZZ/VFGB8/MgLwano8Y26ccCChYQA85jKyhu92T4ciieWQk7RFbwXE0A6w7qCDs/RspZ09laHOJbSKQ7v0kkm2VsDVEGAn0b6NjKL9w7BifGA4n3yNK4ptYOCJFLLpXrzCIAPbH+RhGLmvCzKvAahJBKpjvx6+pJJzQda5UYZA8AR135TY6p7JBDjWcYWatc382aE2IbmbflJ/Z3Fzf7JyvuAaj22lAy/oy8ZFQ1z0DuF6Q/9Nbhk/nY9wbJ4DmBD2RTjIw0dOTFfSI684QaDpV2KBBJ3+A8wwCtgKWy5uLesOogyxw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 09 Sep 2026 20:27:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 146811 invoked by uid 111); 9 Sep 2026 20:27:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 09 Sep 2026 16:27:18 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 9 Sep 2026 16:27:18 -0400
From: Jeff King <peff@peff.net>
To: Vsevolod Myalitsin <ub4nal@mail.ru>
Cc: git@vger.kernel.org, gitster@pobox.me, ben.knoble@gmail.org
Subject: Re: [PATCH v3] advice: use global config for default branch name
Message-ID: <20260909202718.GA183838@coredump.intra.peff.net>
References: <20270829004959.90983-1-ub4nal@mail.ru>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20270829004959.90983-1-ub4nal@mail.ru>

On Sun, Aug 29, 2027 at 03:49:58AM +0300, Vsevolod Myalitsin wrote:

> Add a scope hint to advice settings so that the suggested
> command uses the appropriate config scope.
> 
> Pass the advice setting itself to vadvise() instead of passing
> its fields separately. Use NULL for advise() calls that are not
> associated with an advice setting.

Thanks, this looks OK to me. A few small nits/observations:

> @@ -96,18 +105,31 @@ static struct {
>  
>  static const char turn_off_instructions[] =
>  N_("\n"
> -   "Disable this message with \"git config set advice.%s false\"");
> +   "Disable this message with \"git config set%s advice.%s false\"");

Translators will need to update their message translations, and I wonder
if seeing this "set%s" in isolation might be confusing. Probably it
should be obvious that they should leave everything within the
double-quotes alone. But the alternative is adding a comment with
"TRANSLATORS" in it, I think.

See below, also.

> -	if (display_instructions)
> -		strbuf_addf(&buf, turn_off_instructions, key);
> +	if (setting && setting->level == 0) {

I left this comparison as something like "!setting->level" in my earlier
suggestion, which I think would be OK. But really it is an enum, and if
we are going to use "==" we should probably spell out the whole name
rather than 0, like:

  if (setting && setting->level == ADVICE_LEVEL_NONE)

> +		const char *scope = "";
> +		switch (setting->scope_hint) {
> +			case ADVICE_SCOPE_LOCAL:
> +				break;
> +			case ADVICE_SCOPE_GLOBAL:
> +				scope = " --global";
> +				break;
> +			case ADVICE_SCOPE_SYSTEM:
> +				scope = " --system";
> +				break;
> +		}

I had somehow hoped we could reuse the existing CONFIG_SCOPE enum
without having to redeclare it ourselves. But there are a lot more
scopes than these three! On the other hand, I think it would be possible
to use config_scope_name() to convert them into options.

That makes the translation more lego-like, but maybe it would actually
make it easier to understand, because we could pull the whole command
out into a single placeholder. Like:

diff --git a/advice.c b/advice.c
index cbb0f2f428..789f01c7e1 100644
--- a/advice.c
+++ b/advice.c
@@ -40,15 +40,9 @@ enum advice_level {
 	ADVICE_LEVEL_ENABLED,
 };
 
-enum advice_scope {
-	ADVICE_SCOPE_LOCAL = 0,
-	ADVICE_SCOPE_GLOBAL,
-	ADVICE_SCOPE_SYSTEM,
-};
-
 struct advice_setting {
 	const char *key;
-	enum advice_scope scope_hint;
+	enum config_scope scope_hint;
 	enum advice_level level;
 };
 
@@ -60,7 +54,7 @@ static struct advice_setting advice_setting[] = {
 	[ADVICE_AM_WORK_DIR] 				= { "amWorkDir" },
 	[ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME] 	= { "checkoutAmbiguousRemoteBranchName" },
 	[ADVICE_COMMIT_BEFORE_MERGE]			= { "commitBeforeMerge" },
-	[ADVICE_DEFAULT_BRANCH_NAME]			= { "defaultBranchName", ADVICE_SCOPE_GLOBAL },
+	[ADVICE_DEFAULT_BRANCH_NAME]			= { "defaultBranchName", CONFIG_SCOPE_GLOBAL },
 	[ADVICE_DETACHED_HEAD]				= { "detachedHead" },
 	[ADVICE_DIVERGING]				= { "diverging" },
 	[ADVICE_FETCH_SET_HEAD_WARN]			= { "fetchRemoteHEADWarn" },
@@ -105,7 +99,7 @@ static struct advice_setting advice_setting[] = {
 
 static const char turn_off_instructions[] =
 N_("\n"
-   "Disable this message with \"git config set%s advice.%s false\"");
+   "Disable this message with \"%s");
 
 static void vadvise(const char *advice,
 	const struct advice_setting *setting, va_list params)
@@ -116,19 +110,16 @@ static void vadvise(const char *advice,
 	strbuf_vaddf(&buf, advice, params);
 
 	if (setting && setting->level == 0) {
-		const char *scope = "";
-		switch (setting->scope_hint) {
-			case ADVICE_SCOPE_LOCAL:
-				break;
-			case ADVICE_SCOPE_GLOBAL:
-				scope = " --global";
-				break;
-			case ADVICE_SCOPE_SYSTEM:
-				scope = " --system";
-				break;
-		}
-		strbuf_addf(&buf, turn_off_instructions,
-				scope, setting->key);
+		struct strbuf cmd = STRBUF_INIT;
+
+		strbuf_addstr(&cmd, "git config set");
+		if (setting->scope_hint &&
+		    setting->scope_hint != CONFIG_SCOPE_LOCAL)
+			strbuf_addf(&cmd, " --%s",
+				    config_scope_name(setting->scope_hint));
+		strbuf_addf(&cmd, "advice.%s false", setting->key);
+		strbuf_addf(&buf, turn_off_instructions, cmd.buf);
+		strbuf_release(&cmd);
 	}
 
 	for (cp = buf.buf; *cp; cp = np) {


Having typed that, I'm not sure if it is more or less confusing. It does
avoid replicating the CONFIG_SCOPE enum. There is some lego-string
construction, but it is all within the code and for the non-translated
command. It would obviously be nonsense with CONFIG_SCOPE_FILE, but
there is no reason to think we'd ever pass that.

So I dunno. I could take or leave it as a further cleanup.

-Peff
