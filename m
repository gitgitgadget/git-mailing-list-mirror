Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B89C433F5
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 10:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE36761241
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 10:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbhKKKH6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Nov 2021 05:07:58 -0500
Received: from cloud.peff.net ([104.130.231.41]:57392 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231972AbhKKKH5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Nov 2021 05:07:57 -0500
Received: (qmail 32572 invoked by uid 109); 11 Nov 2021 10:05:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 11 Nov 2021 10:05:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27628 invoked by uid 111); 11 Nov 2021 10:05:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 11 Nov 2021 05:05:09 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 11 Nov 2021 05:05:06 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com
Subject: Re: [PATCH 4/4] midx: report checksum mismatches during 'verify'
Message-ID: <YYzq0uBr+uoVvkbC@coredump.intra.peff.net>
References: <cover.1624473543.git.me@ttaylorr.com>
 <94e9de44e3b52513c5ab48aecd74f809dc34cbe3.1624473543.git.me@ttaylorr.com>
 <20211110231132.GB5811@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211110231132.GB5811@szeder.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 11, 2021 at 12:11:32AM +0100, SZEDER Gábor wrote:

> So the test corrupts the checksum trailer in the 'multi-pack-index'
> file by overwriting its last byte with 0xff, but if that byte were
> already 0xff, then the file would be left as is, and 'git
> multi-pack-index verify' wouldn't find anything amiss.

Good find. I tried running with the patch you showed:

>   $ for i in {1..500} ; do ./t5319-multi-pack-index.sh |sed -n -e 's/^checksum:  //p' ; done |sort |uniq -c
>        31 1a70 3b1c 8ed3 56a6 5101 2a38 057e 698d 6faf fbaa
>       340 5fc0 552f 0ac0 c876 f229 d9e3 ef13 a314 5847 89ff
>       129 ce7d 3710 fd21 ef7b 8316 2b99 4e6c e5d5 5e7c 7b08

but I only ever got the last one, even under load. However, it's easy
enough to tweak the mtimes to stimulate a failure:

  diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
  index 3f69e43178..b84e96779f 100755
  --- a/t/t5319-multi-pack-index.sh
  +++ b/t/t5319-multi-pack-index.sh
  @@ -481,10 +481,25 @@ test_expect_success 'corrupt MIDX is not reused' '
   	git multi-pack-index verify
   '
   
  +while true; do
   test_expect_success 'verify incorrect checksum' '
  +	t=1234567890 &&
  +	for i in $(ls $objdir/pack/*.pack | shuf)
  +	do
  +		touch -d @$t $i &&
  +		t=$((t+100))
  +	done &&
  +	rm -f $objdir/pack/multi-pack-index &&
  +	git multi-pack-index write &&
  +	skip=$(($(wc -c <$objdir/pack/multi-pack-index) - 20)) &&
  +	printf "checksum: " >&5 &&
  +	od -x -w20 -j$skip --endian=big -An "$objdir/pack/multi-pack-index" >&5 &&
   	pos=$(($(wc -c <$objdir/pack/multi-pack-index) - 1)) &&
   	corrupt_midx_and_verify $pos "\377" $objdir "incorrect checksum"
   '
  +done
  +
  +test_done
   
   test_expect_success 'repack progress off for redirected stderr' '
   	GIT_PROGRESS_DELAY=0 git multi-pack-index --object-dir=$objdir repack 2>err &&

Brute force, but it fails after a few hundred attempts. :)

> Since SHA1 is essentially random, there's a 1:256 chance of that
> happening, assuming that the file's content is random.

The most exact fix here would be to read the final byte, increment it
mod-256, and write it back, which would ensure it was always changed.
But that's a bit annoying to do in shell. Perhaps just corrupting more
bytes is a good solution? The patch below should reduce your changes to
1 in 2^80.

diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 3f69e43178..a612e44547 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -482,8 +482,10 @@ test_expect_success 'corrupt MIDX is not reused' '
 '
 
 test_expect_success 'verify incorrect checksum' '
-	pos=$(($(wc -c <$objdir/pack/multi-pack-index) - 1)) &&
-	corrupt_midx_and_verify $pos "\377" $objdir "incorrect checksum"
+	pos=$(($(wc -c <$objdir/pack/multi-pack-index) - 10)) &&
+	corrupt_midx_and_verify $pos \
+		"\377\377\377\377\377\377\377\377\377\377" \
+		$objdir "incorrect checksum"
 '
 
 test_expect_success 'repack progress off for redirected stderr' '

There are other variants, of course. Just appending a single byte to the
file is enough to give you a high probability of failing the checksum
(since it shifts it all by one byte, making it essentially random), but
the corrupt_midx() helper doesn't support that.

-Peff
