Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713F535946
	for <git@vger.kernel.org>; Fri,  6 Jun 2025 00:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749169413; cv=none; b=MUYkbppGkeghp4A+wmTrj2Sd6wUwxrKF86duHukq/N01WiPDy2Kzdv2inKXeftFaN9OTNhp/mn3NEb2Ygf7Tu6lcDgqB/55kIKXECDQQtSjNYATlNJxbjTfvr5suUXVx2vO/lXIQpUoy1lqBrFniZLSK95d3u9z9hDVi/dApxN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749169413; c=relaxed/simple;
	bh=hRpzYfUxWW/XKjYPsiYwuPI1hB//pBRAyUVu0E2VSxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C0IK1U7cNlidAEHi/Ab1uE+FDfJI5rfmOh2c6BVQZ7PeV+gV4QI7aYv87/F41U5Bmf/kUIUJFtY+CvasGrCvCbZHWoye33e3QrPyn+RzMXlvOhC7iEsuHiIqaiumE3B1TqWvrwnr5ahAaMSY4o+UoKkF+xgcPbb2/JOyvraHTlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=A3enAmOA; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="A3enAmOA"
Received: (qmail 24609 invoked by uid 109); 6 Jun 2025 00:23:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=hRpzYfUxWW/XKjYPsiYwuPI1hB//pBRAyUVu0E2VSxE=; b=A3enAmOA6nvKj9vz6LTawSEVQWT6+LS7ZVQG2HdKBuCyzaexM6MrWrsOIZBWxFoodtvfCqhtqP3mn1mZe1ETKGf+OeX4oP4iWZLMnXw8osQo/qpgQoVn1dIxca+eCI80aTNL4fD2Qj1qS9LvRq0jBQh+goiFntZTw1ueTpXGq339bJGUrtIlKF26nUHVGlk38x3/6g2qvusAEzcV56B8EjL+klFwmGWUY/n2nZENsoRHleqA/vNzIXg17YykjYxUxYv/+33tKcpsk1FxqB6O+eKkLp8lvyYYAdeU/+PDPs/6jeNeuC3OtOUqZzdETdcT+LbXOf3+YSNuvJUU5i7ctw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 06 Jun 2025 00:23:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 975 invoked by uid 111); 6 Jun 2025 00:23:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Jun 2025 20:23:32 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 5 Jun 2025 20:23:29 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Mike Hommey <mh@glandium.org>, git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 1/4] Fix maybe-uninitialized warning with GCC at -O3
Message-ID: <20250606002329.GA3556939@coredump.intra.peff.net>
References: <20250603230646.2322671-1-mh@glandium.org>
 <aD_3Y0PQtfg8Dd9z@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aD_3Y0PQtfg8Dd9z@pks.im>

On Wed, Jun 04, 2025 at 09:36:03AM +0200, Patrick Steinhardt wrote:

> On Wed, Jun 04, 2025 at 08:06:43AM +0900, Mike Hommey wrote:
> > ```
> > In file included from parse-options.c:1:
> > git-compat-util.h: In function ‘get_value’:
> > git-compat-util.h:489:21: error: ‘arg’ may be used uninitialized [-Werror=maybe-uninitialized]
> >   489 | #define error(...) (error(__VA_ARGS__), const_error())
> >       |                     ^~~~~
> > parse-options.c:76:21: note: ‘arg’ was declared here
> >    76 |         const char *arg;
> >       |                     ^~~
> > ```
> 
> A bit more explanation whether this warning is a false positive or
> whether this may be an actual issue would be welcome.

I thought at first it was a false positive, as we'd always fill in "arg"
via get_arg(), or return an error. But I suspect the culprit is the
earlier part of this if/else chain:


                  if (unset) {
                          value = 0;
                  } else if (opt->flags & PARSE_OPT_OPTARG && !p->opt) {
                          value = opt->defval;
                  } else if (get_arg(p, opt, flags, &arg)) {
                          return -1;
		  } ...

So if "unset" is true, we set "value" but not "arg". The code the
compiler is complaining about is here:

                  if (value < lower_bound)
                          return error(_("value %s for %s not in range [%"PRIdMAX",%"PRIdMAX"]"),
                                       arg, optname(opt, flags), (intmax_t)lower_bound, (intmax_t)upper_bound);

In the case of "unset", I think we could never trigger this, since our
lower bound will never be above 0.

But what about opt->defval? We don't know anything about it here.
Probably it would be a programming error to pass in a value that is
outside the bounds, but this code doesn't know that. So something like
this (it was actually hard to find an integer option with OPTARG!):

diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 3b6aac2cf7..630403611b 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -28,7 +28,7 @@ int cmd_fmt_merge_msg(int argc,
 			.argh = N_("n"),
 			.help = N_("populate log with at most <n> entries from shortlog"),
 			.flags = PARSE_OPT_OPTARG,
-			.defval = DEFAULT_MERGE_LOG_LEN,
+			.defval = -2147483649,
 		},
 		{
 			.type = OPTION_INTEGER,

would cause:

  git fmt-merge-msg --log

to print uninitialized memory. But it is equally wrong with Mike's
patch; we'd just segfault!

I think this is unlikely to happen in practice, but it does feel like we
should be able to solve it in a better way. I came up with two options.

One is to BUG() on a bogus default value, like this:

diff --git a/parse-options.c b/parse-options.c
index a9a39ecaef..7ddf213d0c 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -73,7 +73,7 @@ static enum parse_opt_result do_get_value(struct parse_opt_ctx_t *p,
 					  enum opt_parsed flags,
 					  const char **argp)
 {
-	const char *arg;
+	const char *arg = NULL;
 	const int unset = flags & OPT_UNSET;
 	int err;
 
@@ -195,9 +195,13 @@ static enum parse_opt_result do_get_value(struct parse_opt_ctx_t *p,
 				     optname(opt, flags));
 		}
 
-		if (value < lower_bound)
+		if (value < lower_bound) {
+			if (!arg)
+				BUG("default option value for '%s' is not in range",
+				    optname(opt, flags));
 			return error(_("value %s for %s not in range [%"PRIdMAX",%"PRIdMAX"]"),
 				     arg, optname(opt, flags), (intmax_t)lower_bound, (intmax_t)upper_bound);
+		}
 
 		switch (opt->precision) {
 		case 1:

The other is to not bother checking the bounds on the default values at
all, by pushing this bounds check into the if/else chain after we know
we have something to parse, like this (extended context to make it more
obvious how this fits into the chain):

diff --git a/parse-options.c b/parse-options.c
index a9a39ecaef..d36e56da15 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -179,39 +179,38 @@ static enum parse_opt_result do_get_value(struct parse_opt_ctx_t *p,
 
 		if (unset) {
 			value = 0;
 		} else if (opt->flags & PARSE_OPT_OPTARG && !p->opt) {
 			value = opt->defval;
 		} else if (get_arg(p, opt, flags, &arg)) {
 			return -1;
 		} else if (!*arg) {
 			return error(_("%s expects a numerical value"),
 				     optname(opt, flags));
 		} else if (!git_parse_signed(arg, &value, upper_bound)) {
 			if (errno == ERANGE)
 				return error(_("value %s for %s not in range [%"PRIdMAX",%"PRIdMAX"]"),
 					     arg, optname(opt, flags), lower_bound, upper_bound);
 
 			return error(_("%s expects an integer value with an optional k/m/g suffix"),
 				     optname(opt, flags));
-		}
-
-		if (value < lower_bound)
+		} else if (value < lower_bound) {
 			return error(_("value %s for %s not in range [%"PRIdMAX",%"PRIdMAX"]"),
 				     arg, optname(opt, flags), (intmax_t)lower_bound, (intmax_t)upper_bound);
+		}
 
 		switch (opt->precision) {
 		case 1:
 			*(int8_t *)opt->value = value;
 			return 0;
 		case 2:
 			*(int16_t *)opt->value = value;
 			return 0;
 		case 4:
 			*(int32_t *)opt->value = value;
 			return 0;
 		case 8:
 			*(int64_t *)opt->value = value;
 			return 0;
 		default:
 			BUG("invalid precision for option %s",
 			    optname(opt, flags));

-Peff
