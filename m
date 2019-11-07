Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA87F1F454
	for <e@80x24.org>; Thu,  7 Nov 2019 06:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbfKGGP6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 01:15:58 -0500
Received: from cloud.peff.net ([104.130.231.41]:41698 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725938AbfKGGP6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 01:15:58 -0500
Received: (qmail 28977 invoked by uid 109); 7 Nov 2019 06:15:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 Nov 2019 06:15:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32255 invoked by uid 111); 7 Nov 2019 06:19:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Nov 2019 01:19:19 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 7 Nov 2019 01:15:57 -0500
From:   Jeff King <peff@peff.net>
To:     Doan Tran Cong Danh <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 6/8] sequencer: reencode squashing commit's message
Message-ID: <20191107061557.GE6431@sigill.intra.peff.net>
References: <20191031092618.29073-1-congdanhqx@gmail.com>
 <cover.1573094789.git.congdanhqx@gmail.com>
 <97ab88e5d886b376b396b2fbe563e1a21be03e44.1573094789.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <97ab88e5d886b376b396b2fbe563e1a21be03e44.1573094789.git.congdanhqx@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 07, 2019 at 09:56:17AM +0700, Doan Tran Cong Danh wrote:

> On fixup/squash-ing rebase, git will create new commit in
> i18n.commitencoding, reencode the commit message to that said encode.

That makes sense (and I agree this is logically distinct from the
previous ones, which were about _showing_ commits, not generating them).

I wondered who is responsible for setting the "encoding" header in the
resulting object. It looks like we just call out to a separate "git
commit", feeding it some content we wrote out to a file. So before this
patch, I think we probably are writing out "encoding iso8859-1" or
whatever in the commit object, but actually outputting whatever the
original commit happened to have in it.

So your approach here is right: we just need to make sure what we write
out for git-commit to read back in is in i18n.commitEncoding.

> diff --git a/t/t3900-i18n-commit.sh b/t/t3900-i18n-commit.sh
> index e8ce5323ee..521d7bb927 100755
> --- a/t/t3900-i18n-commit.sh
> +++ b/t/t3900-i18n-commit.sh
> @@ -209,6 +209,13 @@ test_commit_autosquash_multi_encoding () {
>  	old=$2
>  	new=$3
>  	msg=$4
> +	squash_msg=
> +	if test $flag = squash; then
> +		squash_msg='
> +		subject="squash! $(head -1 expect)" &&
> +		printf "\n%s\n" "$subject" >> expect &&
> +		'
> +	fi

Now what's going on here? This is a snippet of code we man to evaluate
later:

> -		test_line_count = 3 actual
> +		test_line_count = 3 actual &&
> +		iconv -f '$old' -t utf-8 "$TEST_DIRECTORY/t3900/'$msg'" >expect &&
> +		'"$squash_msg"'

I assume this is part of the same confusion that caused the
single-quotes in the earlier patch. You can just include those lines
inline in the quoted test snippet.

-Peff
