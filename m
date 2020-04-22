Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87648C38A30
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 04:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66E38206EC
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 04:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725810AbgDVEQP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 00:16:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:35466 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725355AbgDVEQP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Apr 2020 00:16:15 -0400
Received: (qmail 2743 invoked by uid 109); 22 Apr 2020 04:16:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 22 Apr 2020 04:16:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26300 invoked by uid 111); 22 Apr 2020 04:27:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 22 Apr 2020 00:27:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 22 Apr 2020 00:16:14 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Ilya Tretyakov <it@it3xl.ru>
Subject: Re: [PATCH] credential: fix matching URLs with multiple levels in
 path
Message-ID: <20200422041614.GD3559880@coredump.intra.peff.net>
References: <20200421225837.GB3515235@coredump.intra.peff.net>
 <20200422012344.2051103-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200422012344.2051103-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 22, 2020 at 01:23:44AM +0000, brian m. carlson wrote:

> 46fd7b3900 ("credential: allow wildcard patterns when matching config",
> 2020-02-20) introduced support for matching credential helpers using
> urlmatch.  In doing so, it introduced code to percent-encode the paths
> we get from the credential helper so that they could be effectively
> matched by the urlmatch code.
> 
> Unfortunately, that code had a bug: it percent-encoded the slashes in
> the path, resulting in any URL path that contained multiple levels
> (i.e., a directory component) not matching.
> 
> We are currently the only caller of the percent-encoding code and could
> simply change it not to encode slashes.  However, this would be
> surprising to other potential users who might want to use it and might
> result in unwanted slashes appearing in the encoded value.
> 
> So instead, let's add a flag to skip encoding slashes, which is the
> behavior we want here, and use it when calling the code in this case.
> Add a test for credential helper URLs using multiple slashes in the
> path, which our test suite previously lacked.

Thanks for the quick turnaround. The explanation makes sense.

The patch leaves me with one question, though...

> diff --git a/credential.c b/credential.c
> index 108d9e183a..f0e55a27ac 100644
> --- a/credential.c
> +++ b/credential.c
> @@ -136,14 +136,14 @@ static void credential_format(struct credential *c, struct strbuf *out)
>  		return;
>  	strbuf_addf(out, "%s://", c->protocol);
>  	if (c->username && *c->username) {
> -		strbuf_add_percentencode(out, c->username);
> +		strbuf_add_percentencode(out, c->username, STRBUF_PERCENTENCODE_PATH);
>  		strbuf_addch(out, '@');

Wouldn't we want to keep encoding slashes in the username?

>  	if (c->path) {
>  		strbuf_addch(out, '/');
> -		strbuf_add_percentencode(out, c->path);
> +		strbuf_add_percentencode(out, c->path, STRBUF_PERCENTENCODE_PATH);
>  	}

This hunk is the one I expected.

> diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
> index 5555a1524f..15eeef1dfd 100755
> --- a/t/t0300-credentials.sh
> +++ b/t/t0300-credentials.sh
> @@ -510,6 +510,24 @@ test_expect_success 'helpers can abort the process' '
>  	test_i18ncmp expect stderr
>  '
>  
> +test_expect_success 'helpers can fetch with multiple path components' '
> +	test_unconfig credential.helper &&
> +	test_config credential.https://example.com/foo/repo.git.helper "verbatim foo bar" &&

OK, you can't just use an argument to "check" because you want to set a
specific config option, not just credential.helper. Would this test make
sense a little higher in the file, below "match percent-encoded values"
perhaps?

> +	echo url=https://example.com/foo/repo.git | git credential fill &&

What's this line doing? It will just do the same "check fill" as
below, but without the stdout checking. Is it leftover debugging cruft?

> +	check fill <<-\EOF
> +	url=https://example.com/foo/repo.git
> +	--
> +	protocol=https
> +	host=example.com
> +	username=foo
> +	password=bar
> +	--
> +	verbatim: get
> +	verbatim: protocol=https
> +	verbatim: host=example.com

And here we confirm that we got values from the "verbatim" helper. Good.

-Peff
