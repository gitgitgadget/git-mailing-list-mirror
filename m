Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C38CA0ECA
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 08:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbjILIgK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Sep 2023 04:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232878AbjILIfy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2023 04:35:54 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8210A19B2
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 01:35:29 -0700 (PDT)
Received: (qmail 14586 invoked by uid 109); 12 Sep 2023 08:35:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Sep 2023 08:35:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16821 invoked by uid 111); 12 Sep 2023 08:35:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Sep 2023 04:35:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 12 Sep 2023 04:35:28 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 1/2] test-lib: prevent misuses of --invert-exit-code
Message-ID: <20230912083528.GC1630538@coredump.intra.peff.net>
References: <68522960-edda-26d3-ddca-cee63f2d859e@gmail.com>
 <1a60a1ca-0ef0-ecf5-d0aa-a28d7c148a82@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1a60a1ca-0ef0-ecf5-d0aa-a28d7c148a82@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 10, 2023 at 01:08:11AM +0200, Rubén Justo wrote:

> GIT_TEST_PASSING_SANITIZE_LEAK=true and GIT_TEST_SANITIZE_LEAK_LOG=true
> use internnlly the --invert-exit-code machinery.  Therefore if the user
> wants to use --invert-exit-code in combination with them, the result
> will be confusing.
> 
> For the same reason, we are already using BAIL_OUT if the user tries to
> combine GIT_TEST_PASSING_SANITIZE_LEAK=check with --invert-exit-code.
> 
> Let's do the same for GIT_TEST_PASSING_SANITIZE_LEAK=true and
> GIT_TEST_SANITIZE_LEAK_LOG=true.

OK, so we are trying to find a case where the user is triggering
--invert-exit-code themselves and complaining. But in the code...

> @@ -1557,15 +1557,25 @@ then
>  			say "in GIT_TEST_PASSING_SANITIZE_LEAK=check mode, setting --invert-exit-code for TEST_PASSES_SANITIZE_LEAK != true"
>  			invert_exit_code=t
>  		fi
> -	elif test -z "$passes_sanitize_leak" &&
> -	     test_bool_env GIT_TEST_PASSING_SANITIZE_LEAK false
> +	elif test_bool_env GIT_TEST_PASSING_SANITIZE_LEAK false
>  	then
> -		skip_all="skipping $this_test under GIT_TEST_PASSING_SANITIZE_LEAK=true"
> -		test_done
> +		if test -n "$invert_exit_code"
> +		then
> +			BAIL_OUT "cannot use --invert-exit-code under GIT_TEST_PASSING_SANITIZE_LEAK=true"
> +		elif test -z "$passes_sanitize_leak"
> +		then
> +			skip_all="skipping $this_test under GIT_TEST_PASSING_SANITIZE_LEAK=true"
> +			test_done
> +		fi
>  	fi

You can see at the top of the context that we will set
invert_exit_code=t ourselves, which will then complain here:

>  	if test_bool_env GIT_TEST_SANITIZE_LEAK_LOG false
>  	then
> +		if test -n "$invert_exit_code"
> +		then
> +			BAIL_OUT "cannot use --invert-exit-code and GIT_TEST_SANITIZE_LEAK_LOG=true"
> +		fi
> +
>  		if ! mkdir -p "$TEST_RESULTS_SAN_DIR"
>  		then
>  			BAIL_OUT "cannot create $TEST_RESULTS_SAN_DIR"

That varible-set in the earlier context is from running in "check" mode.
So:

  make GIT_TEST_PASSING_SANITIZE_LEAK=check GIT_TEST_SANITIZE_LEAK_LOG=true

will now always fail. But this is the main way you'd want to run it
(enabling the leak log catches more stuff, and the log-check function
you touch in patch 2 already covers check mode).

So I think you'd have to hoist your check above the if/else for setting
up PASSING_SANITIZE_LEAK modes.

-Peff
