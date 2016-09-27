Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B506207EC
	for <e@80x24.org>; Tue, 27 Sep 2016 05:15:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751152AbcI0FO6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 01:14:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:48549 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750961AbcI0FO5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 01:14:57 -0400
Received: (qmail 16168 invoked by uid 109); 27 Sep 2016 05:14:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 27 Sep 2016 05:14:56 +0000
Received: (qmail 11609 invoked by uid 111); 27 Sep 2016 05:15:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 27 Sep 2016 01:15:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Sep 2016 01:14:54 -0400
Date:   Tue, 27 Sep 2016 01:14:54 -0400
From:   Jeff King <peff@peff.net>
To:     David Turner <novalis@novalis.org>
Cc:     git@vger.kernel.org, mhagger@alum.mit.edu,
        David Turner <dturner@twosigma.com>
Subject: Re: [PATCH 1/2] tree-walk: be more specific about corrupt tree errors
Message-ID: <20160927051453.yuvrnao5ldjpzhcj@sigill.intra.peff.net>
References: <1474918365-10937-1-git-send-email-novalis@novalis.org>
 <1474918365-10937-2-git-send-email-novalis@novalis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1474918365-10937-2-git-send-email-novalis@novalis.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 26, 2016 at 03:32:44PM -0400, David Turner wrote:

> From: Jeff King <peff@peff.net>
> 
> When the tree-walker runs into an error, it just calls
> die(), and the message is always "corrupt tree file".
> However, we are actually covering several cases here; let's
> give the user a hint about what happened.
> 
> Let's also avoid using the word "corrupt", which makes it
> seem like the data bit-rotted on disk. Our sha1 check would
> already have found that. These errors are ones of data that
> is malformed in the first place.
> 
> Signed-off-by: David Turner <dturner@twosigma.com>
> Signed-off-by: Jeff King <peff@peff.net>

Yay. This has been on my "to look at and repost" list for literally 2
years. Thanks for picking it up (see kids, procrastination _does_ pay
off).

>  t/t1007-hash-object.sh           |  15 +++++++++++++--
>  t/t1007/tree-with-empty-filename | Bin 0 -> 28 bytes
>  t/t1007/tree-with-malformed-mode | Bin 0 -> 39 bytes

Ooh, and tests. Exciting.

> -test_expect_success 'corrupt tree' '
> +test_expect_success 'too-short tree' '
>  	echo abc >malformed-tree &&
> -	test_must_fail git hash-object -t tree malformed-tree
> +	test_must_fail git hash-object -t tree malformed-tree 2>err &&
> +	grep "too-short tree object" err
> +'

Should this be test_i18ngrep? Even if the message is not translated now,
it seems like a good proactive measure (and probably it _should_ be
translated).

> +test_expect_success 'malformed mode in tree' '
> +	test_must_fail git hash-object -t tree ../t1007/tree-with-malformed-mode 2>err &&
> +	grep "malformed mode in tree entry for tree" err
> +'

This ".." will break when the test is run with "--root". You should use

  "$TEST_DIRECTORY"/t1007/...

instead. And ditto in the second test, of course.

> diff --git a/t/t1007/tree-with-empty-filename b/t/t1007/tree-with-empty-filename
> new file mode 100644
> index 0000000000000000000000000000000000000000..aeb1ceb20e485eebd0acbb81c974d1c6fedcc1fe
> GIT binary patch
> literal 28
> kcmXpsFfcPQQDAsB_tET47q2;ccWbUIkGgT_Nl)-Z0Hx{;SO5S3
> 
> literal 0
> HcmV?d00001

This is rather opaque, of course. :)

I wonder if it would be possible to generate the test vector with
something like:

  # any 20 bytes will do
  bin_sha1='\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0'

  printf "100644 \0$bin_sha1" >tree-with-empty-filename

I know that is longer and possibly more error-prone to run, but I think
it makes the test much easier to read and modify later.

I also wonder if $bin_sha1 should actually be more like:

  hex_sha1=$(echo foo | git hash-object --stdin -w)
  bin_sha1=$(echo $hex_sha1 | perl -ne 'printf "\\%3o", ord for /./g')

so that it's a real sha1 (or maybe it is in your original, from an
object that happens to be in the repo; it's hard to tell). I wouldn't
expect the code to actually get to the point of looking at the sha1, but
it's perhaps a more realistic test.

I also think it would be nice if hash-object had a "--binary-sha1"
option to avoid the perl grossness. :)

> diff --git a/tree-walk.c b/tree-walk.c
> index ce27842..ba544cf 100644

The code change itself looks brilliant, naturally. :)

-Peff
