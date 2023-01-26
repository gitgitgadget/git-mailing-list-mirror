Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66519C05027
	for <git@archiver.kernel.org>; Thu, 26 Jan 2023 10:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237009AbjAZKCb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Jan 2023 05:02:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236877AbjAZKC3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2023 05:02:29 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685EB43931
        for <git@vger.kernel.org>; Thu, 26 Jan 2023 02:02:28 -0800 (PST)
Received: (qmail 19152 invoked by uid 109); 26 Jan 2023 10:02:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 26 Jan 2023 10:02:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21875 invoked by uid 111); 26 Jan 2023 10:02:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Jan 2023 05:02:27 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 26 Jan 2023 05:02:26 -0500
From:   Jeff King <peff@peff.net>
To:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v7 08/12] test-http-server: add simple authentication
Message-ID: <Y9JPslSoEayaCJ3n@coredump.intra.peff.net>
References: <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com>
 <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com>
 <b8d3e81b5534148359c7e92807cf1e2795480ddf.1674252531.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b8d3e81b5534148359c7e92807cf1e2795480ddf.1674252531.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 20, 2023 at 10:08:46PM +0000, Matthew John Cheetham via GitGitGadget wrote:

> +struct auth_module {
> +	char *scheme;
> +	char *challenge_params;
> +	struct string_list *tokens;
> +};

This is a really minor nit, but: why is "tokens" a pointer? It's always
initialized, so you never need or want to test it for NULL.

That would make this:

> +	if (create) {
> +		struct auth_module *mod = xmalloc(sizeof(struct auth_module));
> +		mod->scheme = xstrdup(scheme);
> +		mod->challenge_params = NULL;
> +		ALLOC_ARRAY(mod->tokens, 1);
> +		string_list_init_dup(mod->tokens);

simplify to:

  string_list_init_dup(&mod->tokens);

and one does not have to wonder why we use ALLOC_ARRAY() there, but not
when allocating the module itself. :)

Likewise you could skip freeing it, but since the memory is held until
program end anyway, that doesn't happen either way.

Certainly what you have won't behave wrong; I'd consider this more like
a coding style thing.

> +	cat >auth.config <<-EOF &&
> +	[auth]
> +		challenge = no-params
> +		challenge = with-params:foo=\"bar\" p=1
> +		challenge = with-params:foo=\"replaced\" q=1
> +
> +		token = no-explicit-challenge:valid-token
> +		token = no-explicit-challenge:also-valid
> +		token = reset-tokens:these-tokens
> +		token = reset-tokens:will-be-reset
> +		token = reset-tokens:
> +		token = reset-tokens:the-only-valid-one
> +
> +		allowAnonymous = false
> +	EOF
> +
> +	cat >OUT.expected <<-EOF &&
> +	WWW-Authenticate: no-params
> +	WWW-Authenticate: with-params foo="replaced" q=1
> +	WWW-Authenticate: no-explicit-challenge
> +	WWW-Authenticate: reset-tokens
> +
> +	Error: 401 Unauthorized
> +	EOF

OK, so I think now we are getting to the interesting part of what your
custom http-server does compared to something like apache. And the
answer so far is: custom WWW-Authenticate lines.

I think we could do that with mod_headers pretty easily. But presumably
we also want to check that we are getting the correct tokens, generate a
401, etc.

I suspect this could all be done as a CGI wrapping git-http-backend. You
can influence the HTTP response code by sending:

   Status: 401 Authorization Required
   WWW-Authenticate: whatever you want

And likewise you can see what the client sends by putting something like
this in apache.conf:

   SetEnvIf Authorization "(.*)" HTTP_AUTHORIZATION=$1

and then reading $HTTP_AUTHORIZATION as you like. At that point, it
feels like a simple shell or perl script could then decide whether to
return a 401 or not (and if not, then just exec git-http-backend to do
the rest). And the scripts would be simple enough that you could have
individual scripts to implement various schemes, rather than
implementing this configuration scheme. You can control which script is
run based on the URL; see the way we match /broken_smart/, etc, in
t/lib-httpd/apache.conf.

-Peff
