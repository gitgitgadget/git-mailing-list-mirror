Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580A5EB64D9
	for <git@archiver.kernel.org>; Wed, 14 Jun 2023 22:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236505AbjFNWoJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jun 2023 18:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236724AbjFNWoF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2023 18:44:05 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7308F2689
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 15:44:00 -0700 (PDT)
Received: (qmail 18113 invoked by uid 109); 14 Jun 2023 22:43:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Jun 2023 22:43:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16815 invoked by uid 111); 14 Jun 2023 22:43:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Jun 2023 18:43:57 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 14 Jun 2023 18:43:54 -0400
From:   Jeff King <peff@peff.net>
To:     M Hickford via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH v2 1/2] credential: avoid erasing distinct password
Message-ID: <20230614224354.GA1441072@coredump.intra.peff.net>
References: <pull.1525.git.git.1686741785.gitgitgadget@gmail.com>
 <pull.1525.v2.git.git.1686778838.gitgitgadget@gmail.com>
 <35ee1795bcdb974cdb9ca0f55ddf8f8a5bc562ae.1686778838.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <35ee1795bcdb974cdb9ca0f55ddf8f8a5bc562ae.1686778838.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 14, 2023 at 09:40:37PM +0000, M Hickford via GitGitGadget wrote:

> From: M Hickford <mirth.hickford@gmail.com>
> 
> Test that credential helpers do not erase a password distinct from the
> input. Such calls can happen when multiple credential helpers are
> configured.
> 
> Fixes for credential-cache and credential-store.

I think this goal makes sense. I missed the "multiple helpers" part of
your message at first, and wondered how you would even get such
duplicate entries stored in a helper. But the point is that you might
have two helpers with two separate passwords.

Which is...weird, I'd think, because we will only ever use one of them.
But from past discussions, I guess you're in a situation where you could
use some kind of renewable token _or_ possibly a more stable password,
via two different helpers. And when the token expires, you want to be
able to remove it from a caching helper without asking for the stable
password to be dropped.

I don't think it's strictly necessary to spell out the intended use in
the commit message. The behavior you're proposing seems like the
least-surprising thing to me in general (and it is only because the
situation is rare that nobody complained about the existing behavior in
the last decade). But it might not hurt to outline the case that we'd
expect this to help.

The other thing I'd watch out for is how this behavior would affect
non-erase modes. Let's see...

> diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
> index 756c5f02aef..82f376d3351 100644
> --- a/builtin/credential-cache--daemon.c
> +++ b/builtin/credential-cache--daemon.c
> @@ -33,12 +33,12 @@ static void cache_credential(struct credential *c, int timeout)
>  	e->expiration = time(NULL) + timeout;
>  }
>  
> -static struct credential_cache_entry *lookup_credential(const struct credential *c)
> +static struct credential_cache_entry *lookup_credential(const struct credential *c, int match_password)
>  {
>  	int i;
>  	for (i = 0; i < entries_nr; i++) {
>  		struct credential *e = &entries[i].item;
> -		if (credential_match(c, e))
> +		if (credential_match(c, e, match_password))
>  			return &entries[i];
>  	}
>  	return NULL;
> [...]
> @@ -127,7 +127,7 @@ static void serve_one_client(FILE *in, FILE *out)
>  	if (read_request(in, &c, &action, &timeout) < 0)
>  		/* ignore error */ ;
>  	else if (!strcmp(action.buf, "get")) {
> -		struct credential_cache_entry *e = lookup_credential(&c);
> +		struct credential_cache_entry *e = lookup_credential(&c, 0);
>  		if (e) {
>  			fprintf(out, "username=%s\n", e->item.username);
>  			fprintf(out, "password=%s\n", e->item.password);

OK, for a cache "get" we'll continue not to match the password. This
shouldn't trigger in practice, as Git will stop asking helpers once it
has a username and password, but it is good to retain the existing
behavior here.

> @@ -48,7 +48,7 @@ static void remove_credential(const struct credential *c)
>  {
>  	struct credential_cache_entry *e;
>  
> -	e = lookup_credential(c);
> +	e = lookup_credential(c, c->password != NULL);
>  	if (e)
>  		e->expiration = 0;
>  }

And this is erase, where we do want to respect it. I actually think
passing an unconditional "1" here instead of the NULL check would be OK,
as the CHECK() macro in credential_match() treats NULL as "always
match". But I am also OK with making that logic explicit here.

This made me wonder how "store" works, since it's not touched here. It's
implemented as remove_credential(), plus an unconditional allocation via
cache_credential().

It seems like overwriting would be broken, then, wouldn't it? If I
store:

   https://user:pass1@example.com

and then try to store:

   https://user:pass2@example.com

then the call to remove_credential() will see a "struct credential" with
the password set to "pass2". And because it always passes
match_password, it will fail to remove it, and we'll end up with two.

We should be able to test that pretty easily, like this:

  echo url=https://user:pass1@example.com | git credential-cache store
  echo url=https://user:pass2@example.com | git credential-cache store
  echo url=https://example.com | git credential-cache get

Before your patch that will return "pass1". After, it returns "pass2",
because the old credential is left in place. I think you'd want
something like:

diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
index 82f376d335..f64dd21d33 100644
--- a/builtin/credential-cache--daemon.c
+++ b/builtin/credential-cache--daemon.c
@@ -44,11 +44,11 @@ static struct credential_cache_entry *lookup_credential(const struct credential
 	return NULL;
 }
 
-static void remove_credential(const struct credential *c)
+static void remove_credential(const struct credential *c, int match_password)
 {
 	struct credential_cache_entry *e;
 
-	e = lookup_credential(c, c->password != NULL);
+	e = lookup_credential(c, match_password);
 	if (e)
 		e->expiration = 0;
 }
@@ -151,14 +151,14 @@ static void serve_one_client(FILE *in, FILE *out)
 		exit(0);
 	}
 	else if (!strcmp(action.buf, "erase"))
-		remove_credential(&c);
+		remove_credential(&c, 1);
 	else if (!strcmp(action.buf, "store")) {
 		if (timeout < 0)
 			warning("cache client didn't specify a timeout");
 		else if (!c.username || !c.password)
 			warning("cache client gave us a partial credential");
 		else {
-			remove_credential(&c);
+			remove_credential(&c, 0);
 			cache_credential(&c, timeout);
 		}
 	}

Unless your goal really is to store two entries that differ only in
their passwords within a single cache. That seems weird, though. Again,
it might help if your use case was fleshed out a bit more.

> diff --git a/builtin/credential-store.c b/builtin/credential-store.c
> index 30c6ccf56c0..e0ae028b1c3 100644
> --- a/builtin/credential-store.c
> +++ b/builtin/credential-store.c
> @@ -13,12 +13,14 @@ static struct lock_file credential_lock;
>  static int parse_credential_file(const char *fn,
>  				  struct credential *c,
>  				  void (*match_cb)(struct credential *),
> -				  void (*other_cb)(struct strbuf *))
> +				  void (*other_cb)(struct strbuf *),
> +				  const char* op)
>  {
>  	FILE *fh;
>  	struct strbuf line = STRBUF_INIT;
>  	struct credential entry = CREDENTIAL_INIT;
>  	int found_credential = 0;
> +	const int match_password = !strcmp(op, "erase") && c->password != NULL;
>  
>  	fh = fopen(fn, "r");
>  	if (!fh) {
> @@ -29,8 +31,8 @@ static int parse_credential_file(const char *fn,
>  
>  	while (strbuf_getline_lf(&line, fh) != EOF) {
>  		if (!credential_from_url_gently(&entry, line.buf, 1) &&
> -		    entry.username && entry.password &&
> -		    credential_match(c, &entry)) {
> +			entry.username && entry.password &&
> +			credential_match(c, &entry, match_password)) {
>  			found_credential = 1;
>  			if (match_cb) {
>  				match_cb(&entry);

OK, so for credential-store we only kick in the new behavior for
"erase". So it would not have the same quirk that I mentioned above.

I do think your logic could likewise here be:

  const int match_password = !strcmp(op, "erase");

because credential_match() handles the NULL case already.

(It's also unusual for us to declare non-parameter variables as "const";
it's not wrong to do so, so it's really just a style thing, but there's
not much benefit).

> @@ -60,7 +62,7 @@ static void print_line(struct strbuf *buf)
>  }
>  
>  static void rewrite_credential_file(const char *fn, struct credential *c,
> -				    struct strbuf *extra)
> +				    struct strbuf *extra, const char *op)
>  {
>  	int timeout_ms = 1000;
>  
> @@ -69,7 +71,7 @@ static void rewrite_credential_file(const char *fn, struct credential *c,
>  		die_errno(_("unable to get credential storage lock in %d ms"), timeout_ms);
>  	if (extra)
>  		print_line(extra);
> -	parse_credential_file(fn, c, NULL, print_line);
> +	parse_credential_file(fn, c, NULL, print_line, op);
>  	if (commit_lock_file(&credential_lock) < 0)
>  		die_errno("unable to write credential store");
>  }

If we have to plumb through this "op" string, I wonder if it would be
more flexible and robust to just pass along a match_password flag.
That's generally a bit more robust than string matching (where a
misspelling in one string would not be caught by the compiler, unlike a
boolean variable).

> @@ -221,6 +222,31 @@ helper_test() {
>  		EOF
>  	'
>  
> +	test_expect_success "helper ($HELPER) does not erase a password distinct from input" '
> +		check approve $HELPER <<-\EOF &&
> +		protocol=https
> +		host=example.com
> +		username=user5
> +		password=pass1
> +		EOF
> +		check reject $HELPER <<-\EOF &&
> +		protocol=https
> +		host=example.com
> +		username=user5
> +		password=pass2
> +		EOF
> +		check fill $HELPER <<-\EOF
> +		protocol=https
> +		host=example.com
> +		username=user5
> +		--
> +		protocol=https
> +		host=example.com
> +		username=user5
> +		password=pass1
> +		EOF
> +	'

The test makes sense. We are not using multiple helpers, but the
behavior can be checked using a single helper, since the point is that
it should be independent of what any other helper is doing.

-Peff
