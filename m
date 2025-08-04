Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D881D6187
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 13:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754313565; cv=none; b=RA/lwlX4++Ga79U1xnLrgnfiPG96tnINJY+iJl1T/UPMHX/REAyvaKg7v1A2E3ftCy4FvfmlBSvlARkIdRssH/hLed4LNCDaH9Kg/sxtCI7dBkvnO5dUKnPlPdau6SjNHngwYDJskyeiGJvNTTN4O+tDNEkY6OX45tMB5QyH3PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754313565; c=relaxed/simple;
	bh=KRpiWLVoBOBYlXTjl2iTYiAB5jxfIug9t62TDWmf+hA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c5SBizqyiWsTWtXcBtfkswC5can9XqkyUYW9B61X/6WBIVG10R9RsVGsoAZaNx9XhhN7+PHOIRUrNAe00JF0L2CbYonh9SuM8ngKUYolA9CS0UE+bRfQcQKj1DSMqN7OIvSFkjrS5tHVoiAjBRgq9ZsJTnBpZwNR4nMRyppvXYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=PedeWYb/; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="PedeWYb/"
Received: (qmail 890 invoked by uid 109); 4 Aug 2025 13:19:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=KRpiWLVoBOBYlXTjl2iTYiAB5jxfIug9t62TDWmf+hA=; b=PedeWYb/UR1t5iWhlgBeCTESjAeNjB8pp3eJKrmCPjjy2FtXALyW4pZejn/ePEeA24nOqSuyvvnMKTmzIBQYnKN0HsksZmoGt0dZUqyEVbi1OP5fsav4zHoTek5z+8VtcH1nzBXP5WW8p1N1Y4zP2eN64FLF7Gi7MaiGuH0ZzZJtbzGWCOFuhQyNMnEapXPklvVyKSnT9j/IalL4TEqFsSq8oCdUlOXcRB5XyDD9PsLKz1NY0g2dbwWPHis/XMDa1QmpCgWOGy3pYZuE6wBPiTvNGc0MJnWiAXZF0OH040NICaz4rmcHMPv37hzjpnyAD9sjAzp6Yk2hpg0jd+3FXg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 04 Aug 2025 13:19:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19357 invoked by uid 111); 4 Aug 2025 13:19:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 04 Aug 2025 09:19:23 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 4 Aug 2025 09:19:22 -0400
From: Jeff King <peff@peff.net>
To: Denton Liu <liu.denton@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] fix -Wmaybe-uninitialized with -Og
Message-ID: <20250804131922.GB86602@coredump.intra.peff.net>
References: <d03308e9474f5e26fd4a5494ec243a278e971443.1754302009.git.liu.denton@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d03308e9474f5e26fd4a5494ec243a278e971443.1754302009.git.liu.denton@gmail.com>

On Mon, Aug 04, 2025 at 03:07:15AM -0700, Denton Liu wrote:

> When building with -Og on gcc 15.1.1, the build produces two warnings.
> Even though in practice, these codepaths can't actually be hit while the
> variables are uninitialized, satisfy the compiler by initializing the
> variables.

I see these on gcc 14.2.0, too.

> diff --git a/builtin/remote.c b/builtin/remote.c
> index 5dd6cbbaee..cc462677e1 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -1463,7 +1463,7 @@ static int set_head(int argc, const char **argv, const char *prefix,
>  		b_local_head = STRBUF_INIT;
>  	char *head_name = NULL;
>  	struct ref_store *refs = get_main_ref_store(the_repository);
> -	struct remote *remote;
> +	struct remote *remote = NULL;
>  
>  	struct option options[] = {
>  		OPT_BOOL('a', "auto", &opt_a,

I think you're right that this can't be triggered, but maybe a bit of
reordering would make that more obvious both to the compiler and to
humans. The issue is that we do this:

          if (argc) {
                  strbuf_addf(&b_head, "refs/remotes/%s/HEAD", argv[0]);
                  remote = remote_get(argv[0]);
          }

and then follow it up with various sanity checks about how the value of
argc. But we always require that argc is at least 1 or we bail with a
usage message.

This comes from 012bc566ba (remote set-head: set followRemoteHEAD to
"warn" if "always", 2024-12-05). If we revert out that change and
instead add it later, like so:

diff --git a/builtin/remote.c b/builtin/remote.c
index 5dd6cbbaee..8ba02d1854 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1474,10 +1474,8 @@ static int set_head(int argc, const char **argv, const char *prefix,
 	};
 	argc = parse_options(argc, argv, prefix, options,
 			     builtin_remote_sethead_usage, 0);
-	if (argc) {
+	if (argc)
 		strbuf_addf(&b_head, "refs/remotes/%s/HEAD", argv[0]);
-		remote = remote_get(argv[0]);
-	}
 
 	if (!opt_a && !opt_d && argc == 2) {
 		head_name = xstrdup(argv[1]);
@@ -1501,6 +1499,8 @@ static int set_head(int argc, const char **argv, const char *prefix,
 	} else
 		usage_with_options(builtin_remote_sethead_usage, options);
 
+	remote = remote_get(argv[0]);
+
 	if (!head_name)
 		goto cleanup;
 	strbuf_addf(&b_remote_head, "refs/remotes/%s/%s", argv[0], head_name);

then the compiler is happy. Though I still find the whole b_head thing
to be total spaghetti (it must be set before our argc if/else cascade
because deletion mode expects it there, but we can't just set it inside
there because other modes expect it to be set later on).

So I wonder if this would be much more obvious (again, to both humans
and compilers):

diff --git a/builtin/remote.c b/builtin/remote.c
index 5dd6cbbaee..f0e49a5681 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1474,10 +1474,13 @@ static int set_head(int argc, const char **argv, const char *prefix,
 	};
 	argc = parse_options(argc, argv, prefix, options,
 			     builtin_remote_sethead_usage, 0);
-	if (argc) {
-		strbuf_addf(&b_head, "refs/remotes/%s/HEAD", argv[0]);
-		remote = remote_get(argv[0]);
-	}
+
+	/* All modes require at least a remote name. */
+	if (!argc)
+		usage_with_options(builtin_remote_sethead_usage, options);
+
+	strbuf_addf(&b_head, "refs/remotes/%s/HEAD", argv[0]);
+	remote = remote_get(argv[0]);
 
 	if (!opt_a && !opt_d && argc == 2) {
 		head_name = xstrdup(argv[1]);

> diff --git a/t/unit-tests/clar/clar.c b/t/unit-tests/clar/clar.c
> index d54e455367..03a3aa8e87 100644
> --- a/t/unit-tests/clar/clar.c
> +++ b/t/unit-tests/clar/clar.c
> @@ -350,7 +350,7 @@ static void
>  clar_run_suite(const struct clar_suite *suite, const char *filter)
>  {
>  	const struct clar_func *test = suite->tests;
> -	size_t i, matchlen;
> +	size_t i, matchlen = 0;
>  	struct clar_report *report;
>  	int exact = 0;

For this one I don't see any real alternative. We set matchlen if and
only if "filter" is set:

  if (filter) {
	...
	matchlen = strlen(filter);
	...
  }

and the line it complains about is:

  if (filter && strncmp(test[i].name, filter, matchlen))

so the short-circuit protects us. So it's only a problem if "filter"
changes between those two lines. It is in a loop, but I don't see how
"filter" could ever be changed within the loop. So I'm not sure if this
is just a compiler bug, or if there's some really subtle alias thing
where filter _could_ be changed in a sub-function or something.

At any rate I agree that "0" is the appropriate value here, and
assigning it to shut up the compiler is the best approach.

-Peff
