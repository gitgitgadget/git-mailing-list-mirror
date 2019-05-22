Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 163301F462
	for <e@80x24.org>; Wed, 22 May 2019 05:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbfEVFcP (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 May 2019 01:32:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:35804 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725801AbfEVFcP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 May 2019 01:32:15 -0400
Received: (qmail 16402 invoked by uid 109); 22 May 2019 05:32:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 22 May 2019 05:32:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20366 invoked by uid 111); 22 May 2019 05:32:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 22 May 2019 01:32:56 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 May 2019 01:32:13 -0400
Date:   Wed, 22 May 2019 01:32:13 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] hash-object: don't pointlessly zlib compress without -w
Message-ID: <20190522053213.GD29933@sigill.intra.peff.net>
References: <20190520222932.22843-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190520222932.22843-1-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 21, 2019 at 12:29:32AM +0200, Ævar Arnfjörð Bjarmason wrote:

> That added in 568508e765 ("bulk-checkin: replace fast-import based
> implementation", 2011-10-28) would compress the file with zlib, but
> was oblivious as to whether the content would actually be written out
> to disk, which isn't the case unless hash-object is called with the
> "-w" option.

Yeah, this seems like an obvious and easy improvement. I'd guess that
not many people use hash-object without "-w", so nobody ever really
cared much.

> diff --git a/bulk-checkin.c b/bulk-checkin.c
> index 39ee7d6107..a26126ee76 100644
> --- a/bulk-checkin.c
> +++ b/bulk-checkin.c
> @@ -105,8 +105,9 @@ static int stream_to_pack(struct bulk_checkin_state *state,
>  	int status = Z_OK;
>  	int write_object = (flags & HASH_WRITE_OBJECT);
>  	off_t offset = 0;
> +	int level = write_object ? pack_compression_level : Z_NO_COMPRESSION;
>  
> -	git_deflate_init(&s, pack_compression_level);
> +	git_deflate_init(&s, level);

Hmm. It really seems like if we're not writing, that we could avoid this
whole pack-encoding business altogether, and just stream the contents
through the hash, no matter the size. E.g., we're paying extra here to
compute a pack crc32 that nobody cares about, not to mention the zlib
crc.

That said, this is just not that common a case, and you've regained the
vast majority of the performance with this simple change. So it may not
be worth pursuing further.

> +test_lazy_prereq SHA1SUM_AND_SANE_DD_AND_URANDOM '
> +	>empty &&
> +	sha1sum empty >empty.sha1sum &&
> +	grep -q -w da39a3ee5e6b4b0d3255bfef95601890afd80709 empty.sha1sum &&
> +	dd if=/dev/urandom of=random.test bs=1024 count=1 &&
> +	stat -c %s random.test >random.size &&
> +	grep -q -x 1024 random.size
> +'

I don't think this needs to be cryptographically random. You could just
use "test-tool genrandom" instead, which gets rid of the need for dd and
/dev/urandom (and as a bonus, is more deterministic since it's a seeded
LCG).

> +test_perf 'sha1sum(1) on file.random (for comparison)' '
> +	sha1sum file.random
> +'

I'm not sure this is worth the prereq it entails. Who really cares how
fast sha1sum is? What we generally care about in the perf suite is how
Git speeds compare. Primarily between versions (to show off
improvements, or find regressions), but sometimes between two builds
(but sadly the perf output is not good at comparing those numbers
automatically).

I know this sets a baseline, but it feels a bit like apples to oranges.

> +for threshold in 32M 64M
> +do
> +	for write in '' ' -w'
> +	do
> +		for literally in ' --literally -t commit' ''

Is this "-t commit" worth it? I guess it proves that --literally is
being used, since we'd choke otherwise. But for a perf test, it seems
like you'd want to change as few variables as possible.

> +			test_perf "'git hash-object$write$literally --stdin < <file>' with threshold=$threshold" "

This test title violates our shell style (whitespace after "<"). ;)

(Yes, I know it was probably to avoid "<<").

> +			test_perf "'echo <file> | git hash-object$write$literally --stdin-paths' threshold=$threshold" "
> +				echo file.random | git -c core.bigFileThreshold=$threshold hash-object$write$literally --stdin-paths

You have to bunch up the option variables in the title to get the
whitespace right. But in the command itself, you can do:

  hash-object $write $literally ...

and the shell's whitespace handling will make it work. Maybe worth it to
make the source a bit more readable.

-Peff
