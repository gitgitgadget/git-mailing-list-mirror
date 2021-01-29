Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4155C433E0
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 00:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0CE164D99
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 00:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbhA2Ase (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 19:48:34 -0500
Received: from cloud.peff.net ([104.130.231.41]:42718 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231450AbhA2Aq1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 19:46:27 -0500
Received: (qmail 20536 invoked by uid 109); 29 Jan 2021 00:45:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 29 Jan 2021 00:45:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4305 invoked by uid 111); 29 Jan 2021 00:45:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 28 Jan 2021 19:45:39 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 28 Jan 2021 19:45:37 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jrnieder@gmail.com
Subject: Re: [PATCH v3 07/10] t: prepare for GIT_TEST_WRITE_REV_INDEX
Message-ID: <YBNasXXZc1BEkMxH@coredump.intra.peff.net>
References: <cover.1610129989.git.me@ttaylorr.com>
 <cover.1611617819.git.me@ttaylorr.com>
 <7cf16485cccccf365101d30138d9ee8b00d705d0.1611617820.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7cf16485cccccf365101d30138d9ee8b00d705d0.1611617820.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 25, 2021 at 06:37:38PM -0500, Taylor Blau wrote:

> diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
> index 297de502a9..2fc3aadbd1 100755
> --- a/t/t5319-multi-pack-index.sh
> +++ b/t/t5319-multi-pack-index.sh
> @@ -710,8 +710,9 @@ test_expect_success 'expire respects .keep files' '
>  		PACKA=$(ls .git/objects/pack/a-pack*\.pack | sed s/\.pack\$//) &&
>  		touch $PACKA.keep &&
>  		git multi-pack-index expire &&
> -		ls -S .git/objects/pack/a-pack* | grep $PACKA >a-pack-files &&
> -		test_line_count = 3 a-pack-files &&
> +		test_path_is_file $PACKA.idx &&
> +		test_path_is_file $PACKA.keep &&
> +		test_path_is_file $PACKA.pack &&

I find the post-image here more readable than the original. It probably
runs faster, too (zero processes instead of three).

> --- a/t/t5325-reverse-index.sh
> +++ b/t/t5325-reverse-index.sh
> @@ -3,6 +3,10 @@
>  test_description='on-disk reverse index'
>  . ./test-lib.sh
>  
> +# The below tests want control over the 'pack.writeReverseIndex' setting
> +# themselves to assert various combinations of it with other options.
> +sane_unset GIT_TEST_WRITE_REV_INDEX

I think we had a discussion a while ago about sane_unset outside of an
&&-chain, where it does nothing that regular "unset" would not. But I
don't know if we reached any kind of conclusion. I actually argued that
it was fine in:

  https://lore.kernel.org/git/20200630185536.GA1888406@coredump.intra.peff.net/

So I guess I should probably stand by that. ;)

> --- a/t/t5604-clone-reference.sh
> +++ b/t/t5604-clone-reference.sh
> @@ -329,7 +329,7 @@ test_expect_success SYMLINKS 'clone repo with symlinked or unknown files at obje
>  	for raw in $(ls T*.raw)
>  	do
>  		sed -e "s!/../!/Y/!; s![0-9a-f]\{38,\}!Z!" -e "/commit-graph/d" \
> -		    -e "/multi-pack-index/d" <$raw >$raw.de-sha-1 &&
> +		    -e "/multi-pack-index/d" -e "/rev/d" <$raw >$raw.de-sha-1 &&

This one is less readable than before. :) I'm not sure how to really
improve that, though.

> --- a/t/t5702-protocol-v2.sh
> +++ b/t/t5702-protocol-v2.sh
> @@ -851,8 +851,10 @@ test_expect_success 'part of packfile response provided as URI' '
>  	test -f h2found &&
>  
>  	# Ensure that there are exactly 6 files (3 .pack and 3 .idx).
> -	ls http_child/.git/objects/pack/* >filelist &&
> -	test_line_count = 6 filelist
> +	ls http_child/.git/objects/pack/*.pack >packlist &&
> +	ls http_child/.git/objects/pack/*.idx >idxlist &&
> +	test_line_count = 3 idxlist &&
> +	test_line_count = 3 packlist
>  '

Hmm. Too bad we can't rely on shell brace expansion, as:

  ls http_child/.git/objects/pack/*.{pack,idx}

would be more readable. You could still do it in a single "ls" by
writing out both arguments manually, but it's probably not that
important.

>  test_expect_success 'fetching with valid packfile URI but invalid hash fails' '
> @@ -905,8 +907,10 @@ test_expect_success 'packfile-uri with transfer.fsckobjects' '
>  		clone "$HTTPD_URL/smart/http_parent" http_child &&
>  
>  	# Ensure that there are exactly 4 files (2 .pack and 2 .idx).
> -	ls http_child/.git/objects/pack/* >filelist &&
> -	test_line_count = 4 filelist
> +	ls http_child/.git/objects/pack/*.pack >packlist &&
> +	ls http_child/.git/objects/pack/*.idx >idxlist &&
> +	test_line_count = 2 idxlist &&
> +	test_line_count = 2 packlist
>  '

Likewise. But...

> diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
> index 4a3b8f48ac..f76586f808 100755
> --- a/t/t6500-gc.sh
> +++ b/t/t6500-gc.sh
> @@ -106,17 +106,17 @@ test_expect_success 'auto gc with too many loose objects does not attempt to cre
>  	test_commit "$(test_oid obj2)" &&
>  	# Our first gc will create a pack; our second will create a second pack
>  	git gc --auto &&
> -	ls .git/objects/pack | sort >existing_packs &&
> +	ls .git/objects/pack/pack-*.pack | sort >existing_packs &&
>  	test_commit "$(test_oid obj3)" &&
>  	test_commit "$(test_oid obj4)" &&
>  
>  	git gc --auto 2>err &&
>  	test_i18ngrep ! "^warning:" err &&
> -	ls .git/objects/pack/ | sort >post_packs &&
> +	ls .git/objects/pack/pack-*.pack | sort >post_packs &&
>  	comm -1 -3 existing_packs post_packs >new &&
>  	comm -2 -3 existing_packs post_packs >del &&
>  	test_line_count = 0 del && # No packs are deleted
> -	test_line_count = 2 new # There is one new pack and its .idx
> +	test_line_count = 1 new # There is one new pack
>  '

This one is making the test a bit looser (it would miss a case where we
somehow failed to generate the .idx). That seems like an unlikely bug,
but I wonder if we can keep the original behavior. I guess:

  ls .git/objects/pack/*.pack \
     .git/objects/pack/*.idx |
     sort >post_packs

would work?

>  test_expect_success 'gc --no-quiet' '
> diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
> index 3d17e932a0..8f1caf8025 100755
> --- a/t/t9300-fast-import.sh
> +++ b/t/t9300-fast-import.sh
> @@ -1632,7 +1632,10 @@ test_expect_success 'O: blank lines not necessary after other commands' '
>  	INPUT_END
>  
>  	git fast-import <input &&
> -	test 8 = $(find .git/objects/pack -type f | grep -v multi-pack-index | wc -l) &&
> +	ls -la .git/objects/pack/pack-*.pack >packlist &&
> +	ls -la .git/objects/pack/pack-*.pack >idxlist &&
> +	test_line_count = 4 idxlist &&
> +	test_line_count = 4 packlist &&

Another case where I don't think we're losing anything (actually, we are
gaining just slightly; if a bug somehow created 6 packs and 2 idx files,
we'd now notice!).

-Peff
