Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FDFE1F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 19:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbeKUFu4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 00:50:56 -0500
Received: from avasout05.plus.net ([84.93.230.250]:44154 "EHLO
        avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbeKUFu4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 00:50:56 -0500
Received: from [10.0.2.15] ([146.198.133.33])
        by smtp with ESMTPA
        id PBZAgeWAUcoA7PBZCgSJZf; Tue, 20 Nov 2018 19:20:11 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=WdYilXpX c=1 sm=1 tr=0
 a=VCDsReDbrwk4B7AcQzWGLw==:117 a=VCDsReDbrwk4B7AcQzWGLw==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=EBOSESyhAAAA:8 a=dUYzk90wsJ5QMD8BcYoA:9
 a=OolTMI78cdA8IQxV:21 a=01eXct6IkHKAAM9D:21 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] clone: fix colliding file detection on APFS
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, gitster@pobox.com
Cc:     carenas@gmail.com, git@jeffhostetler.com, git@vger.kernel.org,
        newren@gmail.com, pawelparuzel95@gmail.com, peff@peff.net,
        sandals@crustytoothpaste.net, szeder.dev@gmail.com, tboegi@web.de
References: <xmqq36rwcwtu.fsf@gitster-ct.c.googlers.com>
 <20181120162853.22441-1-pclouds@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <1d92df80-02cd-2986-d2f1-f1fe084d8adc@ramsayjones.plus.com>
Date:   Tue, 20 Nov 2018 19:20:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181120162853.22441-1-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfOXJMmjfLtjHbLK4HMzxx5DJGbM0ShvOLhX6MyNRIZqydeWndituRqE/k8/JaSwsTRjXnvqwlTe36lpzUI05bkB+Qma8ARuUolmjo/TtaxjwLuYfmBgP
 S8EETYZgt7LiI1nCWMQ2qFN8NDTDed65WsoYqnL4hStRhi3TivS1KEFj
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 20/11/2018 16:28, Nguyễn Thái Ngọc Duy wrote:
> Commit b878579ae7 (clone: report duplicate entries on case-insensitive
> filesystems - 2018-08-17) adds a warning to user when cloning a repo
> with case-sensitive file names on a case-insensitive file system. The
> "find duplicate file" check was doing by comparing inode number (and
> only fall back to fspathcmp() when inode is known to be unreliable
> because fspathcmp() can't cover all case folding cases).
> 
> The inode check is very simple, and wrong. It compares between a
> 32-bit number (sd_ino) and potentially a 64-bit number (st_ino). When
> an inode is larger than 2^32 (which seems to be the case for APFS), it
> will be truncated and stored in sd_ino, but comparing with itself will
> fail.
> 
> As a result, instead of showing a pair of files that have the same
> name, we show just one file (marked before the beginning of the
> loop). We fail to find the original one.
> 
> The fix could be just a simple type cast (*)
> 
>     dup->ce_stat_data.sd_ino == (unsigned int)st->st_ino
> 
> but this is no longer a reliable test, there are 4G possible inodes
> that can match sd_ino because we only match the lower 32 bits instead
> of full 64 bits.
> 
> There are two options to go. Either we ignore inode and go with
> fspathcmp() on Apple platform. This means we can't do accurate inode
> check on HFS anymore, or even on APFS when inode numbers are still
> below 2^32.
> 
> Or we just to to reduce the odds of matching a wrong file by checking
> more attributes, counting mostly on st_size because st_xtime is likely
> the same. This patch goes with this direction, hoping that false
> positive chances are too small to be seen in practice.
> 
> While at there, enable the test on Cygwin (verified working by Ramsay
> Jones)

Well, no, I tested the previous version of this patch. However, this
patch also passes the test. (Note _test_ singular - in order to check
that this patch doesn't cause a regression I would need to run the
whole test-suite - that takes 3.5 hours, if I'm not doing anything
else!)

> 
> (*) this is also already done inside match_stat_data()
> 
> Reported-by: Carlo Arenas <carenas@gmail.com>
> Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  So I'm going with match_stat_data(). But I don't know, perhaps just
>  ignoring inode (like Carlo's original patch) is safer/better?
> 
>  Tested on case-insensitive JFS on Linux. But I don't think it really
>  matters because I'm not even sure if I could push inode above 2^32
>  with this. Hacking JFS for this test sounds fun, but no time for that.
> 
>  entry.c          | 4 ++--
>  t/t5601-clone.sh | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/entry.c b/entry.c
> index 5d136c5d55..0a3c451f5f 100644
> --- a/entry.c
> +++ b/entry.c
> @@ -404,7 +404,7 @@ static void mark_colliding_entries(const struct checkout *state,
>  {
>  	int i, trust_ino = check_stat;
>  
> -#if defined(GIT_WINDOWS_NATIVE)
> +#if defined(GIT_WINDOWS_NATIVE) || defined(__CYGWIN__)

I was a little curious about this (but couldn't be bothered actually
read the code, post-application), so I removed this hunk from the
patch, rebuilt and ran the test again: it _passed_ the test. :-D

So, ...

ATB,
Ramsay Jones

>  	trust_ino = 0;
>  #endif
>  
> @@ -419,7 +419,7 @@ static void mark_colliding_entries(const struct checkout *state,
>  		if (dup->ce_flags & (CE_MATCHED | CE_VALID | CE_SKIP_WORKTREE))
>  			continue;
>  
> -		if ((trust_ino && dup->ce_stat_data.sd_ino == st->st_ino) ||
> +		if ((trust_ino && !match_stat_data(&dup->ce_stat_data, st)) ||
>  		    (!trust_ino && !fspathcmp(ce->name, dup->name))) {
>  			dup->ce_flags |= CE_MATCHED;
>  			break;
> diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
> index f1a49e94f5..c28d51bd59 100755
> --- a/t/t5601-clone.sh
> +++ b/t/t5601-clone.sh
> @@ -628,7 +628,7 @@ test_expect_success 'clone on case-insensitive fs' '
>  	)
>  '
>  
> -test_expect_success !MINGW,!CYGWIN,CASE_INSENSITIVE_FS 'colliding file detection' '
> +test_expect_success !MINGW,CASE_INSENSITIVE_FS 'colliding file detection' '
>  	grep X icasefs/warning &&
>  	grep x icasefs/warning &&
>  	test_i18ngrep "the following paths have collided" icasefs/warning
> 
