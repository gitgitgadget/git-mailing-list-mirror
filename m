Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E33C433EF
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 09:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238015AbhLJJjk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 04:39:40 -0500
Received: from cloud.peff.net ([104.130.231.41]:48574 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233120AbhLJJjj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 04:39:39 -0500
Received: (qmail 18095 invoked by uid 109); 10 Dec 2021 09:36:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Dec 2021 09:36:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28529 invoked by uid 111); 10 Dec 2021 09:36:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Dec 2021 04:36:06 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Dec 2021 04:36:04 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Eric Sunshine <ericsunshine@gmail.com>
Subject: Re: [PATCH 14/19] tests: apply modern idiom for exiting loop upon
 failure
Message-ID: <YbMfhGCCO2nvTVo6@coredump.intra.peff.net>
References: <20211209051115.52629-1-sunshine@sunshineco.com>
 <20211209051115.52629-15-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211209051115.52629-15-sunshine@sunshineco.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 09, 2021 at 12:11:10AM -0500, Eric Sunshine wrote:

> diff --git a/t/t1050-large.sh b/t/t1050-large.sh
> index 99ff2866b7..0e4267c723 100755
> --- a/t/t1050-large.sh
> +++ b/t/t1050-large.sh
> @@ -51,27 +51,21 @@ EOF
>  test_expect_success 'add a large file or two' '
>  	git add large1 huge large2 &&
>  	# make sure we got a single packfile and no loose objects
> -	bad= count=0 idx= &&
> +	count=0 idx= &&
>  	for p in .git/objects/pack/pack-*.pack
>  	do
>  		count=$(( $count + 1 )) &&
> -		if test_path_is_file "$p" &&
> -		   idx=${p%.pack}.idx && test_path_is_file "$idx"
> -		then
> -			continue
> -		fi
> -		bad=t
> +		test_path_is_file "$p" &&
> +		idx=${p%.pack}.idx &&
> +		test_path_is_file "$idx" || return 1
>  	done &&
> -	test -z "$bad" &&

Thanks goodness. I had to read the original loop several times to
understand what it was trying to do. The post-image is much nicer.

> diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
> index 17f988edd2..a6a73effde 100755
> --- a/t/t9400-git-cvsserver-server.sh
> +++ b/t/t9400-git-cvsserver-server.sh
> @@ -350,10 +350,9 @@ test_expect_success 'cvs update (subdirectories)' \
>  	test_cmp "$dir/$filename" "../$dir/$filename"; then
>          :
>        else
> -        echo >failure
> +        exit 1
>        fi
> -    done) &&
> -   test ! -f failure'
> +    done)'

These all look good. I had to blink a few times to see the subshell in
this one (it's finished by the closing paren after "done", for other
reviewers).

-Peff
