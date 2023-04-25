Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A854C6FD18
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 06:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233446AbjDYGsX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 02:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233438AbjDYGsV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 02:48:21 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191587AA6
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 23:47:59 -0700 (PDT)
Received: (qmail 22408 invoked by uid 109); 25 Apr 2023 06:47:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 25 Apr 2023 06:47:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1844 invoked by uid 111); 25 Apr 2023 06:47:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 25 Apr 2023 02:47:58 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 25 Apr 2023 02:47:58 -0400
From:   Jeff King <peff@peff.net>
To:     M Hickford via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Cheetham <mjcheetham@outlook.com>,
        Dennington <lessleydennington@gmail.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH v2] credential: new attribute oauth_refresh_token
Message-ID: <20230425064758.GD4061254@coredump.intra.peff.net>
References: <pull.1394.git.1678776364753.gitgitgadget@gmail.com>
 <pull.1394.v2.git.1682070479816.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1394.v2.git.1682070479816.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 21, 2023 at 09:47:59AM +0000, M Hickford via GitGitGadget wrote:

> Git authentication with OAuth access token is supported by every popular
> Git host including GitHub, GitLab and BitBucket [1][2][3]. Credential
> helpers Git Credential Manager (GCM) and git-credential-oauth generate
> OAuth credentials [4][5]. Following RFC 6749, the application prints a
> link for the user to authorize access in browser. A loopback redirect
> communicates the response including access token to the application.
> 
> For security, RFC 6749 recommends that OAuth response also includes
> expiry date and refresh token [6]. After expiry, applications can use
> the refresh token to generate a new access token without user
> reauthorization in browser. GitLab and BitBucket set the expiry at two
> hours [2][3]. (GitHub doesn't populate expiry or refresh token.)
> 
> However the Git credential protocol has no attribute to store the OAuth
> refresh token (unrecognised attributes are silently discarded). This
> means that the user has to regularly reauthorize the helper in browser.
> On a browserless system, this is particularly intrusive, requiring a
> second device.
> 
> Introduce a new attribute oauth_refresh_token. This is especially
> useful when a storage helper and a read-only OAuth helper are configured
> together. Recall that `credential fill` calls each helper until it has a
> non-expired password.
> 
> ```
> [credential]
> 	helper = storage  # eg. cache or osxkeychain
> 	helper = oauth
> ```

OK. I don't have much knowledge of OAuth, but taking the notion of "this
is a useful thing for oauth clients to store" as a given, the
implementation seems reasonable.

It does feel a bit funny, in that nothing _except_ credential-cache is
going to understand or store this thing. In general, I'd expect most
helpers doing anything as complex as oauth to just implement their own
storage layer. But I get that your goal here is trying to keep things as
composable as possible. I just wonder how successful it will be if there
is only one helper that you can actually use for storage.

> Add support for the new attribute to credential-cache. Eventually, I
> hope to see support in other popular storage helpers.

At least your optimism is documented. :)

> Alternatives considered: ask helpers to store all unrecognised
> attributes. This seems excessively complex for no obvious gain.
> Helpers would also need extra information to distinguish between
> confidential and non-confidential attributes.

I've written the "store arbitrary attributes" patch before, and it
actually is quite simple (if you neglect the "confidential" concept,
which is largely what the current protocol and helpers do). But I don't
know that it buys that much anyway, if helpers need to decide whether
and how to store these items anyway. We get support in credential-cache
for "free" because it happens to store the same in-memory struct that
Git itself does, but most other helpers would need special patches. And
because they're often interfacing with system storage, they can't
necessarily just store arbitrary items.

> diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
> index 62c09a271d6..9db5f00184d 100644
> --- a/builtin/credential-cache--daemon.c
> +++ b/builtin/credential-cache--daemon.c
> @@ -133,6 +133,9 @@ static void serve_one_client(FILE *in, FILE *out)
>  			if (e->item.password_expiry_utc != TIME_MAX)
>  				fprintf(out, "password_expiry_utc=%"PRItime"\n",
>  					e->item.password_expiry_utc);
> +			if (e->item.oauth_refresh_token)
> +				fprintf(out, "oauth_refresh_token=%s\n",
> +					e->item.oauth_refresh_token);
>  		}
>  	}
>  	else if (!strcmp(action.buf, "exit")) {

This hunk makes me wonder if the cache daemon should just be using
credential_write(), which would then support this automatically (along
with any other fields, like the expiry, or the new wwwauth stuff).

It would mean that it spits back parts of the query (like host, etc) for
a "get", rather than just username/password. That's not wrong, but is
maybe a little weird.

I can live with it as-is, certainly.

> +helper_test_oauth_refresh_token() {
> +	HELPER=$1
> +
> +	test_expect_success "helper ($HELPER) stores oauth_refresh_token" '
> +		check approve $HELPER <<-\EOF
> +		protocol=https
> +		host=example.com
> +		username=user4
> +		password=pass
> +		oauth_refresh_token=xyzzy
> +		EOF
> +	'
> +
> +	test_expect_success "helper ($HELPER) gets oauth_refresh_token" '
> +		check fill $HELPER <<-\EOF
> +		protocol=https
> +		host=example.com
> +		username=user4
> +		--
> +		protocol=https
> +		host=example.com
> +		username=user4
> +		password=pass
> +		oauth_refresh_token=xyzzy
> +		--
> +		EOF
> +	'
> +}

This is in a separate function, so normal t0303 tests won't run it (and
confuse users when they fail because they don't support this field).
Good.

Possibly t0303 should learn to optionally trigger this the way it does
with helper_test_timeout. But I'm also content to leave it until
somebody has a helper they want to test with it.

> diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
> index c66d91e82d8..b49fc14a2bd 100755
> --- a/t/t0300-credentials.sh
> +++ b/t/t0300-credentials.sh
> @@ -214,6 +214,24 @@ test_expect_success 'credential_approve stores password expiry' '
>  	EOF
>  '
>  
> +test_expect_success 'credential_approve stores oauth refresh token' '
> +	check approve useless <<-\EOF
> +	protocol=http
> +	host=example.com
> +	username=foo
> +	password=bar
> +	oauth_refresh_token=xyzzy
> +	--
> +	--
> +	useless: store
> +	useless: protocol=http
> +	useless: host=example.com
> +	useless: username=foo
> +	useless: password=bar
> +	useless: oauth_refresh_token=xyzzy
> +	EOF
> +'

Makes sense. This file is just checking how Git passes the data around
between helpers.

> diff --git a/t/t0301-credential-cache.sh b/t/t0301-credential-cache.sh
> index 698b7159f03..c02a3b5969c 100755
> --- a/t/t0301-credential-cache.sh
> +++ b/t/t0301-credential-cache.sh
> @@ -29,6 +29,7 @@ test_atexit 'git credential-cache exit'
>  
>  # test that the daemon works with no special setup
>  helper_test cache
> +helper_test_oauth_refresh_token cache
>  
>  test_expect_success 'socket defaults to ~/.cache/git/credential/socket' '
>  	test_when_finished "

And this one is just testing credential-cache, which we know supports
the feature. Good.

So the patch looks like it correctly implements the intent. I don't feel
strongly about what the patch is trying to do, but it's not a problem
area I know a lot about or use myself. So if it's doing something useful
for you, that sounds reasonable to me. :)

-Peff
