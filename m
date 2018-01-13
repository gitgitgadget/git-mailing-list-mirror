Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E29E1FAE2
	for <e@80x24.org>; Sat, 13 Jan 2018 07:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750890AbeAMHZ1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Jan 2018 02:25:27 -0500
Received: from cloud.peff.net ([104.130.231.41]:42946 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750732AbeAMHZ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jan 2018 02:25:26 -0500
Received: (qmail 21416 invoked by uid 109); 13 Jan 2018 07:25:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 13 Jan 2018 07:25:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5317 invoked by uid 111); 13 Jan 2018 07:26:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 13 Jan 2018 02:26:00 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 13 Jan 2018 02:25:24 -0500
Date:   Sat, 13 Jan 2018 02:25:24 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v4 6/7] trace.c: print env vars in trace_run_command()
Message-ID: <20180113072524.GB27251@sigill.intra.peff.net>
References: <20180112095607.18293-1-pclouds@gmail.com>
 <20180113064949.6043-1-pclouds@gmail.com>
 <20180113064949.6043-7-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180113064949.6043-7-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 13, 2018 at 01:49:48PM +0700, Nguyễn Thái Ngọc Duy wrote:

> diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
> index d24d157379..0ab71f14fb 100644
> --- a/t/helper/test-run-command.c
> +++ b/t/helper/test-run-command.c
> @@ -56,6 +56,10 @@ int cmd_main(int argc, const char **argv)
>  
>  	if (argc < 3)
>  		return 1;
> +	while (!strcmp(argv[1], "env")) {
> +		argv_array_push(&proc.env_array, argv[2]);
> +		argv += 2;
> +	}
>  	proc.argv = (const char **)argv + 2;

Probably not super important for a test command, but do we want to make
sure we don't walk past the end of the array in our loop? E.g.:

  while (argv[1] && !strcmp(argv[1], "env")) {
	if (!argv[2]))
		die("env specifier without a value");
	argv_array_push(&proc.env_array, argv[2]);
	argv += 2;
	argc -= 2;
  }
  /* make sure we still have 2 args left */
  if (argc < 3)
	return 1;
  proc.argv = ...;

> diff --git a/trace.c b/trace.c
> index 7f43da211a..ffa1cf9b91 100644
> --- a/trace.c
> +++ b/trace.c
> @@ -275,6 +275,62 @@ void trace_performance_fl(const char *file, int line, uint64_t nanos,
>  
>  #endif /* HAVE_VARIADIC_MACROS */
>  
> +static void add_env(struct strbuf *dst, const char *const *deltaenv)
> +{
> +	struct string_list envs = STRING_LIST_INIT_DUP;
> +	const char *const *e;
> +	int i;
> +	int printed_unset = 0;
> +
> +	/* Last one wins, see run-command.c:prep_childenv() for context */
> +	for (e = deltaenv; e && *e; e++) {
> +		struct strbuf key = STRBUF_INIT;
> +		char *equals = strchr(*e, '=');
> +		if (equals) {
> +			strbuf_reset(&key);
> +			strbuf_add(&key, *e, equals - *e);

This strbuf_reset() is unnecessary now, since the key strbuf is fresh in
each loop (alternatively, it could be moved out of the loop to avoid
repeated allocations, and move the corresponding release out of the
loop.

> +			string_list_insert(&envs, key.buf)->util = equals + 1;
> +		} else {
> +			string_list_insert(&envs, *e)->util = NULL;
> +		}

Note that this is quadratic in the size of deltaenv (inserting into a
sorted list). But it's the same technique that the actual
prep_childenv() uses, so it's probably OK (we simply don't add that
large a deltaenv in practice).

> +	/* "unset X Y...;" */
> +	for (i = 0; i < envs.nr; i++) {
> +		const char *var = envs.items[i].string;
> +		const char *val = envs.items[i].util;
> +
> +		if (val || !getenv(var))
> +			continue;
> +
> +		if (!printed_unset) {
> +			strbuf_addstr(dst, " unset");
> +			printed_unset = 1;
> +		}
> +		strbuf_addf(dst, " %s", var);
> +	}
> +	if (printed_unset)
> +		strbuf_addch(dst, ';');

Looks good.

> +	/* ... followed by "A=B C=D ..." */
> +	for (i = 0; i < envs.nr; i++) {
> +		const char *var = envs.items[i].string;
> +		const char *val = envs.items[i].util;
> +		const char *oldval;
> +
> +		if (!val)
> +			continue;
> +
> +		oldval = getenv(var);
> +		if (oldval && !strcmp(val, oldval))
> +			continue;
> +
> +		strbuf_addf(dst, " %s=", var);
> +		sq_quote_buf_pretty(dst, val);
> +	}
> +	string_list_clear(&envs, 0);
> +}

Looks good.

The loops in this one are much easier to follow, IMHO.

-Peff
