Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1A2520899
	for <e@80x24.org>; Wed, 23 Aug 2017 15:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932413AbdHWP6a (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 11:58:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:46768 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932260AbdHWP63 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 11:58:29 -0400
Received: (qmail 12151 invoked by uid 109); 23 Aug 2017 15:58:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 23 Aug 2017 15:58:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1107 invoked by uid 111); 23 Aug 2017 15:58:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 23 Aug 2017 11:58:56 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Aug 2017 11:58:26 -0400
Date:   Wed, 23 Aug 2017 11:58:26 -0400
From:   Jeff King <peff@peff.net>
To:     Ivan Vyshnevskyi <sainaen@gmail.com>
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH/RFC] push: anonymize URL in error output
Message-ID: <20170823155826.m4s5y55x2esfoass@sigill.intra.peff.net>
References: <20170823094929.13541-1-sainaen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170823094929.13541-1-sainaen@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 23, 2017 at 12:49:29PM +0300, Ivan Vyshnevskyi wrote:

> Commits 47abd85 (fetch: Strip usernames from url's before storing them,
> 2009-04-17) and later 882d49c (push: anonymize URL in status output,
> 2016-07-14) made fetch and push strip the authentication part of the
> remote URLs when used in the merge-commit messages or status outputs.
> The URLs that are part of the error messages were not anonymized.
> 
> A commonly used pattern for storing artifacts from a build server in a
> remote repository utilizes a "secure" environment variable with
> credentials to embed them in the URL and execute a push. Given enough
> runs, an intermittent network failure will cause a push to fail, leaving
> a non-anonymized URL in the build log.
> 
> To prevent that, reuse the same anonymizing function to scrub
> credentials from URL in the push error output.

This makes sense. I suspect that most errors we output should be using
the anonymized URL. Did you poke around for other calls?

The general structure of the patch looks good, but I have a few minor
comments below.

> Not sure how much of the background should be included in the commit message.
> The "commonly used pattern" I mention could be found in the myriad of
> online tutorials and looks something like this:

My knee-jerk reaction is if it's worth writing after the dashes, it's
worth putting in the commit message.

However, in the case I think it is OK as-is (the motivation of "we
already avoid leaking auth info to stdout, so we should do the same for
error messages" seems self-contained and reasonable).

> diff --git a/builtin/push.c b/builtin/push.c
> index 03846e837..59f3bc975 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -336,7 +336,7 @@ static int push_with_options(struct transport *transport, int flags)
>  	err = transport_push(transport, refspec_nr, refspec, flags,
>  			     &reject_reasons);
>  	if (err != 0)
> -		error(_("failed to push some refs to '%s'"), transport->url);
> +		error(_("failed to push some refs to '%s'"), transport_anonymize_url(transport->url));

This leaks the return value. That's probably not a _huge_ deal since the
program is likely to exit, but it's a bad pattern. I wonder if we should
be setting up transport->anonymous_url preemptively, and just let its
memory belong to the transport struct.

> diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
> index d38bf3247..0b6fb6252 100755
> --- a/t/t5541-http-push-smart.sh
> +++ b/t/t5541-http-push-smart.sh
> @@ -377,5 +377,23 @@ test_expect_success 'push status output scrubs password' '
>  	grep "^To $HTTPD_URL/smart/test_repo.git" status
>  '
>  
> +cat >"$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git/hooks/update" <<EOF
> +#!/bin/sh
> +exit 1
> +EOF
> +chmod a+x "$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git/hooks/update"
> +
> +cat >exp <<EOF
> +error: failed to push some refs to '$HTTPD_URL/smart/test_repo.git'
> +EOF

I know the t5541 script, which is old and messy, led you into these bad
constructs. But usually in modern tests we:

 1. Try to keep all commands inside test_expect blocks to catch
    unexpected failures or unwanted output.

 2. Use write_script for writing scripts, like:

      write_script "$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git/hooks/update" <<-\EOF
      exit 1
      EOF

 3. Backslash our here-doc delimiter to suppress interpolation.

> +test_expect_success 'failed push status output scrubs password' '
> +	cd "$ROOT_PATH"/test_repo_clone &&
> +	test_must_fail git push "$HTTPD_URL_USER_PASS/smart/test_repo.git" +HEAD:scrub_err 2>stderr &&
> +	grep "^error: failed to push some refs" stderr >act &&
> +	test_i18ncmp exp act
> +'
> +rm -f "$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git/hooks/update"

Similarly, this "rm" should probably be a test_when_finished in the
block with the write_script (unless you really need to carry it over
several test_expect blocks, in which case there should be an explicit
test_expect cleaning it up).

Instead of grepping for the exact error, should we instead grep for the
password to make sure it is not present on _any_ line?

-Peff
