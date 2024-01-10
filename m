Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A173F8E4
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 10:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 16950 invoked by uid 109); 10 Jan 2024 10:38:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 10 Jan 2024 10:38:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25653 invoked by uid 111); 10 Jan 2024 10:38:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 10 Jan 2024 05:38:15 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 10 Jan 2024 05:38:12 -0500
From: Jeff King <peff@peff.net>
To: Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 2/3] t7450: test submodule urls
Message-ID: <20240110103812.GB16674@coredump.intra.peff.net>
References: <pull.1635.git.1704822817.gitgitgadget@gmail.com>
 <cf7848edffca27931aad02c0652adf2715320d35.1704822817.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cf7848edffca27931aad02c0652adf2715320d35.1704822817.git.gitgitgadget@gmail.com>

On Tue, Jan 09, 2024 at 05:53:36PM +0000, Victoria Dye via GitGitGadget wrote:

> +#define TEST_TOOL_CHECK_URL_USAGE \
> +	"test-tool submodule check-url <url>"

I don't think this command-line "<url>" mode works at all. Your
underlying function can handle either stdin or arguments:

> -static int check_name(int argc, const char **argv)
> +static int check_submodule(int argc, const char **argv, check_fn_t check_fn)
>  {
>  	if (argc > 1) {
>  		while (*++argv) {
> -			if (check_submodule_name(*argv) < 0)
> +			if (check_fn(*argv) < 0)
>  				return 1;
>  		}
>  	} else {
>  		struct strbuf buf = STRBUF_INIT;
>  		while (strbuf_getline(&buf, stdin) != EOF) {
> -			if (!check_submodule_name(buf.buf))
> +			if (!check_fn(buf.buf))
>  				printf("%s\n", buf.buf);
>  		}
>  		strbuf_release(&buf);

...but the new caller rejects them before we get there:

> +static int cmd__submodule_check_url(int argc, const char **argv)
> +{
> +	struct option options[] = {
> +		OPT_END()
> +	};
> +	argc = parse_options(argc, argv, "test-tools", options,
> +			     submodule_check_url_usage, 0);
> +	if (argc)
> +		usage_with_options(submodule_check_url_usage, options);
> +
> +	return check_submodule(argc, argv, check_submodule_url);
>  }

So you'd want at least:

diff --git a/t/helper/test-submodule.c b/t/helper/test-submodule.c
index da89d265f0..6b964c88ab 100644
--- a/t/helper/test-submodule.c
+++ b/t/helper/test-submodule.c
@@ -88,8 +88,6 @@ static int cmd__submodule_check_url(int argc, const char **argv)
 	};
 	argc = parse_options(argc, argv, "test-tools", options,
 			     submodule_check_url_usage, 0);
-	if (argc)
-		usage_with_options(submodule_check_url_usage, options);
 
 	return check_submodule(argc, argv, check_submodule_url);
 }

but then that reveals another mismatch. In check_submodule() above we
expect argv[0] to be uninteresting (i.e., the name of the program), but
parse_options() will already have thrown it away. So we silently fail to
check the first option (which is especially bad since the only output is
the exit code, and thus the skipped one looks the same as one that
validated correctly).

All of this is inherited from the existing check_name() code, which I
think has all of the same bugs. The test scripts all just use the stdin
mode, so they don't notice. It's not too hard to fix, but maybe it's
worth just ripping out the unreachable code.

-Peff
