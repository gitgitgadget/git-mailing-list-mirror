Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C04EB64D9
	for <git@archiver.kernel.org>; Thu, 15 Jun 2023 07:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244736AbjFOHLG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jun 2023 03:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244685AbjFOHJu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2023 03:09:50 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8C63581
        for <git@vger.kernel.org>; Thu, 15 Jun 2023 00:08:18 -0700 (PDT)
Received: (qmail 19113 invoked by uid 109); 15 Jun 2023 07:08:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 Jun 2023 07:08:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19497 invoked by uid 111); 15 Jun 2023 07:08:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 Jun 2023 03:08:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 15 Jun 2023 03:08:09 -0400
From:   Jeff King <peff@peff.net>
To:     M Hickford via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH v3 1/2] credential: avoid erasing distinct password
Message-ID: <20230615070809.GA1460739@coredump.intra.peff.net>
References: <pull.1525.v2.git.git.1686778838.gitgitgadget@gmail.com>
 <pull.1525.v3.git.git.1686809004.gitgitgadget@gmail.com>
 <df3c8a15bf8ef3258ed6959568cf4cfd1042f71d.1686809004.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <df3c8a15bf8ef3258ed6959568cf4cfd1042f71d.1686809004.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 15, 2023 at 06:03:23AM +0000, M Hickford via GitGitGadget wrote:

> @@ -151,14 +151,14 @@ static void serve_one_client(FILE *in, FILE *out)
>  		exit(0);
>  	}
>  	else if (!strcmp(action.buf, "erase"))
> -		remove_credential(&c);
> +		remove_credential(&c, 1);
>  	else if (!strcmp(action.buf, "store")) {
>  		if (timeout < 0)
>  			warning("cache client didn't specify a timeout");
>  		else if (!c.username || !c.password)
>  			warning("cache client gave us a partial credential");
>  		else {
> -			remove_credential(&c);
> +			remove_credential(&c, 0);
>  			cache_credential(&c, timeout);
>  		}
>  	}

Great, this hunk fixes the overwrite problem from the previous round.
All of the credential-cache bits look good to me.

> @@ -29,8 +30,8 @@ static int parse_credential_file(const char *fn,
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

This hunk is from credential-store. I think the code change is doing the
right thing, but the modified indentation is wrong (we'd usually do a
4-space indentation to line up the conditions; doing a full tab confuses
the conditions with the actual body).

> diff --git a/credential.c b/credential.c
> index 023b59d5711..9157ff0865e 100644
> --- a/credential.c
> +++ b/credential.c
> @@ -33,13 +33,14 @@ void credential_clear(struct credential *c)
>  }
>  
>  int credential_match(const struct credential *want,
> -		     const struct credential *have)
> +		     const struct credential *have, int match_password)
>  {
>  #define CHECK(x) (!want->x || (have->x && !strcmp(want->x, have->x)))
>  	return CHECK(protocol) &&
> -	       CHECK(host) &&
> -	       CHECK(path) &&
> -	       CHECK(username);
> +		CHECK(host) &&
> +		CHECK(path) &&
> +		CHECK(username) &&
> +		(!match_password || CHECK(password));
>  #undef CHECK
>  }

The indentation here seemed funny to me, too, though I think it's a
matter of taste (indent a tab versus line up with the seven chars of
"return ". I'd have a slight preference to leave it as-is, just because
it makes the diff noisier, but I'm OK with it either way.

> diff --git a/t/lib-credential.sh b/t/lib-credential.sh
> index f1ab92ba35c..7b4fdd011d7 100644
> --- a/t/lib-credential.sh
> +++ b/t/lib-credential.sh
> @@ -44,6 +44,8 @@ helper_test_clean() {
>  	reject $1 https example.com user1
>  	reject $1 https example.com user2
>  	reject $1 https example.com user4
> +	reject $1 https example.com user5
> +	reject $1 https example.com user8
>  	reject $1 http path.tld user
>  	reject $1 https timeout.tld user
>  	reject $1 https sso.tld

This is a funny gap to have (I realize it is because you use 6-7 in the
next patch, but usually we'd try to do things in order and rebase
downstream patches as appropriate). Doubly funny here is that the test
for "8" comes before "5". That's not wrong from a code/testing
standpoint, but it may make the script harder to read or modify later
on.

Maybe it would be easier to read if we gave these users non-numeric
names that match how we will use them. E.g., can we call user8
user-overwrite or something? That makes the intention obvious, and then
we do not have to worry about maintaining ordering constraints.

> @@ -167,6 +169,49 @@ helper_test() {
>  		EOF
>  	'
>  
> +	test_expect_success "helper ($HELPER) overwrites on store" '
> [...]

Great, thank you for adding a test for this case. The test itself looks
good to me.

> @@ -221,6 +266,31 @@ helper_test() {
>  		EOF
>  	'
>  
> +	test_expect_success "helper ($HELPER) does not erase a password distinct from input" '
> [...]

And this one continues to look good. I think the username could be
"user-distinct-pass" or something if we wanted to go with
human-understandable ones.

-Peff
