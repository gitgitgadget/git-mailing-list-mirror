Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0344FC05027
	for <git@archiver.kernel.org>; Fri,  3 Feb 2023 17:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbjBCRRf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Feb 2023 12:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbjBCRRe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2023 12:17:34 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2254885F9
        for <git@vger.kernel.org>; Fri,  3 Feb 2023 09:17:32 -0800 (PST)
Received: (qmail 26529 invoked by uid 109); 3 Feb 2023 17:17:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 03 Feb 2023 17:17:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10307 invoked by uid 111); 3 Feb 2023 17:17:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 03 Feb 2023 12:17:31 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 3 Feb 2023 12:17:31 -0500
From:   Jeff King <peff@peff.net>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/4] t/lib-httpd ssl fixes
Message-ID: <Y91Bq+xYUhDnPHfS@coredump.intra.peff.net>
References: <Y9pOmR5fOfCHwYpF@coredump.intra.peff.net>
 <Y9s7vyHKXP+TQPRm@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y9s7vyHKXP+TQPRm@pobox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 01, 2023 at 11:27:43PM -0500, Todd Zullinger wrote:

> > The final two patches here fix ssl problems I found. The first two
> > patches drop support for older apache. This yields some minor cleanups,
> > and makes the ssl fixes slightly easier. I've cc'd Todd as the last
> > person to express support for Apache 2.2, in 2017. I'm hoping even
> > CentOS has moved on by now, but we'll see. :)
> 
> Heh.  Fortunately, CentOS 6 has been EOL for a few years.
> CentOS 7 has httpd-2.4.6.

Oh, good. So I think we are OK to take these patches, then.

> I applied these patches and ran builds for CentOS/RHEL 7-9
> and Fedora 36-38.  I had not previously run the test suite
> with LIB_HTTPD_SSL=1 and I ran into many, many failures.
> (154 failures across 12 tests, to be precise.)

Oof. I was just focusing on getting a handful of interesting tests to
run, and didn't think to try the whole suite.

> I can clean up this diff if you think it's worthwhile.

Yes, please. Your fixes all look to be along the lines I'd expect. I
think my patches can stand on their own as an incremental improvement,
and then yours can come on top as a separate series.

> It sounds like it may be quite useful for the http/2 tests, but maybe
> LIB_HTTPD_SSL=1 in t5559-http-fetch-smart-http2 is simpler for now?

I'd prefer to avoid requiring ssl support for those tests if we can.
Version 2.0.12 of mod_http2 does fix the test failure. There may be some
other issues (there's more details in the GitHub issue I linked
earlier), but I think it would be enough to stop the immediate pain. I
don't know how long it will take before that version makes it into an
apache release.

> -- 8< --

A few bits I noticed on your test fixes:

> diff --git i/t/lib-httpd.sh w/t/lib-httpd.sh
> index 608949ea80..a4f787f580 100644
> --- i/t/lib-httpd.sh
> +++ w/t/lib-httpd.sh
> @@ -168,7 +168,7 @@ prepare_httpd() {
>  		then
>  			HTTPD_PARA="$HTTPD_PARA -DSVN"
>  			LIB_HTTPD_SVNPATH="$rawsvnrepo"
> -			svnrepo="http://127.0.0.1:$LIB_HTTPD_PORT/"
> +			svnrepo="$HTTPD_PROTO://127.0.0.1:$LIB_HTTPD_PORT/"

This probably should have been $HTTPD_URL all along, which fixes the
protocol and avoids hard-coding the loopback address.

> diff --git i/t/t5541-http-push-smart.sh w/t/t5541-http-push-smart.sh
> index fbad2d5ff5..b1f414dfe0 100755
> --- i/t/t5541-http-push-smart.sh
> +++ w/t/t5541-http-push-smart.sh
> @@ -122,9 +122,9 @@ test_expect_success 'setup rejected update hook' '
>  
>  	cat >exp <<-EOF
>  	remote: error: hook declined to update refs/heads/dev2
> -	To http://127.0.0.1:$LIB_HTTPD_PORT/smart/test_repo.git
> +	To '$HTTPD_PROTO'://127.0.0.1:$LIB_HTTPD_PORT/smart/test_repo.git

Ditto here.

> diff --git i/t/t5550-http-fetch-dumb.sh w/t/t5550-http-fetch-dumb.sh
> index 8f182a3cbf..070d04cdce 100755
> --- i/t/t5550-http-fetch-dumb.sh
> +++ w/t/t5550-http-fetch-dumb.sh
> @@ -384,7 +384,7 @@ test_expect_success 'remote-http complains cleanly about malformed urls' '
>  # learned to handle early remote helper failures more cleanly.
>  test_expect_success 'remote-http complains cleanly about empty scheme' '
>  	test_must_fail ok=sigpipe git ls-remote \
> -		http::${HTTPD_URL#http}/dumb/repo.git 2>stderr &&
> +		http::${HTTPD_URL#$HTTPD_PROTO}/dumb/repo.git 2>stderr &&
>  	test_i18ngrep "url has no scheme" stderr
>  '

I wondered if this should also be adjusting "http::" to match the
protocol. It doesn't really matter, though. The point of the test is use
"http::" to route it to git-remote-curl, and then "://anything" should
fail. The fact that it is using $HTTPD_URL in the first place is only so
that we might detect an accidental success. We never expect to actually
hit the endpoint.

> @@ -454,9 +454,9 @@ test_expect_success 'http-alternates triggers not-from-user protocol check' '
>  	echo "$HTTPD_URL/dumb/victim.git/objects" \
>  		>"$evil/objects/info/http-alternates" &&
>  	test_config_global http.followRedirects true &&
> -	test_must_fail git -c protocol.http.allow=user \
> +	test_must_fail git -c protocol.'$HTTPD_PROTO'.allow=user \
>  		clone $HTTPD_URL/dumb/evil.git evil-user &&
> -	git -c protocol.http.allow=always \
> +	git -c protocol.'$HTTPD_PROTO'.allow=always \
>  		clone $HTTPD_URL/dumb/evil.git evil-user
>  '

These single quotes seem unnecessary. We're in a single-quoted string,
but it's a test-body that will be eval'd. So the variable can just be
referenced in the usual way, just like $HTTPD_URL in the existing
context.

> diff --git i/t/t5703-upload-pack-ref-in-want.sh w/t/t5703-upload-pack-ref-in-want.sh
> index df74f80061..b365e30eda 100755
> --- i/t/t5703-upload-pack-ref-in-want.sh
> +++ w/t/t5703-upload-pack-ref-in-want.sh
> @@ -450,7 +450,7 @@ test_expect_success 'setup repos for change-while-negotiating test' '
>  		# Local repo with many commits (so that negotiation will take
>  		# more than 1 request/response pair)
>  		rm -rf "$LOCAL_PRISTINE" &&
> -		git clone "http://127.0.0.1:$LIB_HTTPD_PORT/smart/repo" "$LOCAL_PRISTINE" &&
> +		git clone "$HTTPD_PROTO://127.0.0.1:$LIB_HTTPD_PORT/smart/repo" "$LOCAL_PRISTINE" &&

Another one that could be $HTTPD_URL.

> @@ -462,7 +462,7 @@ test_expect_success 'setup repos for change-while-negotiating test' '
>  		test_commit m3 &&
>  		git tag -d m2 m3
>  	) &&
> -	git -C "$LOCAL_PRISTINE" remote set-url origin "http://127.0.0.1:$LIB_HTTPD_PORT/one_time_perl/repo" &&
> +	git -C "$LOCAL_PRISTINE" remote set-url origin "$HTTPD_PROTO://127.0.0.1:$LIB_HTTPD_PORT/one_time_perl/repo" &&

Likewise.

> diff --git i/t/t5812-proto-disable-http.sh w/t/t5812-proto-disable-http.sh
> index d8da5f58d1..9ee5132276 100755
> --- i/t/t5812-proto-disable-http.sh
> +++ w/t/t5812-proto-disable-http.sh
> [...]
> @@ -28,9 +28,9 @@ test_expect_success 'curl limits redirects' '
>  '
>  
>  test_expect_success 'http can be limited to from-user' '
> -	git -c protocol.http.allow=user \
> +	git -c protocol.'$HTTPD_PROTO'.allow=user \
>  		clone "$HTTPD_URL/smart/repo.git" plain.git &&
> -	test_must_fail git -c protocol.http.allow=user \
> +	test_must_fail git -c protocol.'$HTTPD_PROTO'.allow=user \
>  		clone "$HTTPD_URL/smart-redir-perm/repo.git" redir.git
>  '

And another one with funny quotes.

-Peff
