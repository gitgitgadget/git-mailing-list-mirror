Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 455F2201C8
	for <e@80x24.org>; Sun, 12 Nov 2017 16:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751774AbdKLQEO (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 11:04:14 -0500
Received: from cloud.peff.net ([104.130.231.41]:54054 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751537AbdKLQEE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Nov 2017 11:04:04 -0500
Received: (qmail 5751 invoked by uid 109); 12 Nov 2017 16:04:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 12 Nov 2017 16:04:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15878 invoked by uid 111); 12 Nov 2017 16:04:16 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (62.189.9.201)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Sun, 12 Nov 2017 11:04:16 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 12 Nov 2017 16:04:02 +0000
Date:   Sun, 12 Nov 2017 16:04:02 +0000
From:   Jeff King <peff@peff.net>
To:     Soukaina NAIT HMID <nhsoukaina@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [add-default-config 5/5] fix return code on default + add tests
Message-ID: <20171112160401.qeimqv234ojben5e@sigill.intra.peff.net>
References: <0102015fb0bf2f74-cb456171-fe65-4d83-8784-b553c7c9e584-000000@eu-west-1.amazonses.com>
 <0102015fb0bf3103-7448dcb3-ec22-4e67-8995-5cbea349263f-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0102015fb0bf3103-7448dcb3-ec22-4e67-8995-5cbea349263f-000000@eu-west-1.amazonses.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 12, 2017 at 03:00:40PM +0000, Soukaina NAIT HMID wrote:

> diff --git a/builtin/config.c b/builtin/config.c
> index eab81c5627091..29c5f55f27a57 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -261,9 +261,12 @@ static int get_value(const char *key_, const char *regex_)
>  
>  	if (values.nr == 0 && default_value) {
>  		if(types == TYPE_INT || types == TYPE_BOOL || types == TYPE_BOOL_OR_INT || types == TYPE_PATH ) {
> -			char* xstr = normalize_value(key, default_value);
> -			fwrite(xstr, 1, strlen(xstr), stdout);
> -			fwrite("\n", 1, 1, stdout);
> +			if(strlen(default_value)) {
> +				char* xstr = normalize_value(key, default_value);
> +				fwrite(xstr, 1, strlen(xstr), stdout);
> +				fwrite("\n", 1, 1, stdout);
> +				ret = 0;
> +			}
>  		}

OK, fixing up the return value is a good thing (though again, I think if
we place our default_value in the list earlier that will just fall out
naturally).

I'm not sure why we care if the default_value string is empty or not. It
should be allowed to default to an empty string, I'd think.

> diff --git a/t/t9904-default.sh b/t/t9904-default.sh
> new file mode 100755
> index 0000000000000..8e838f512298b
> --- /dev/null
> +++ b/t/t9904-default.sh

We usually try to group tests with similar-numbered ones. Most of the
config tests are in the t13xx area. Probably "t1310-config-default.sh"
would be the right place (or if there really are just a few tests, which
I think may be all we need, they can just go into t1300).

> +boolean()
> +{
> +	slot=$([ "$#" == 3 ] && echo $3 || echo "no.such.slot") &&
> +	actual=$(git config --default "$1" --bool "$slot") &&
> +	test "$actual" = "$2"
> +}

A minor style nit, but we usually prefer "test" instead of "[" for
conditionals. It took me a while to figure out how this function was
meant to be used. It might be worth adding a comment. Though most of it
was due to the first line, which I think can just be written as:

  slot=${3:-no.such.slot}

(or you could even just write that directly in the second line).

That's a bit more idiomatic for our shell scripts.

> +test_expect_success 'empty value for boolean' '
> +	invalid_boolean ""
> +'

There are a lot of tests here about type interpretation, but I think
that should be largely orthogonal to the --default feature. Once it's
written in a way that's independent of the type, I think we can assume
that if "--default" works for one type, it should work with others
without being exhaustive.

So I think what we really want to test from this series is:

  1. --default kicks in when no matching config is found

  2. --default does not kick in when config _is_ found

  3. (optional) we complain about --default with non-get actions

  4. --color works as a type for "get" operations

  5. --color is not normalized for "set" operations; if you do:

       git config --color some.key red

     we should write "red" into the config file, not the ANSI codes.

I know the reason you were looking into t4026 originally because it was
the only spot that used --get-color in the whole test suite. But its use
of "--get-color" is largely orthogonal to what it's testing. It cares
about parsing the specific colors, but just didn't have another easy way
to convince Git to parse a bunch of colors without having to pick the
results out of diff or log output.

I'd be OK with converting that to use "--color --default" instead of
--get-color, but if we do so we should make sure that there's some
coverage of "--get-color" elsewhere in the config tests (not checking
every possible color variation, but just making sure that it can
actually look up any color with it).

-Peff
