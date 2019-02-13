Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 941E71F453
	for <e@80x24.org>; Wed, 13 Feb 2019 18:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391164AbfBMSSq (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 13:18:46 -0500
Received: from elephants.elehost.com ([216.66.27.132]:52631 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391106AbfBMSSp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Feb 2019 13:18:45 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x1DIIct8036773
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 13 Feb 2019 13:18:38 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Eric Sunshine'" <sunshine@sunshineco.us>
Cc:     "'Git List'" <git@vger.kernel.org>
References: <20190209185930.5256-1-randall.s.becker@rogers.com> <20190209185930.5256-3-randall.s.becker@rogers.com>     <CAPig+cTMoYMmnHVuay_4RGr_FN-HWC1tN4TPDsNM4vKCH3GzXw@mail.gmail.com>    <xmqqh8d9diy8.fsf@gitster-ct.c.googlers.com> <xmqqh8d7d2ij.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqh8d7d2ij.fsf@gitster-ct.c.googlers.com>
Subject: RE: [Patch v1 2/3] t5318: replace use of /dev/zero with generate_zero_bytes
Date:   Wed, 13 Feb 2019 13:18:31 -0500
Message-ID: <004701d4c3c8$8a018d20$9e04a760$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGM7GjkJQPJw2ZzFceglcz2DqNUWwGXJak9AdRbyOoBXWggQALkfM5xpjBLm0A=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> From: Junio C Hamano <jch2355@gmail.com> On Behalf Of Junio C Hamano
> Sent: February 13, 2019 12:25
> To: Eric Sunshine <sunshine@sunshineco.us>
> Cc: randall.s.becker@rogers.com; Git List <git@vger.kernel.org>; Randall
S.
> Becker <rsbecker@nexbridge.com>
> Subject: Re: [Patch v1 2/3] t5318: replace use of /dev/zero with
> generate_zero_bytes
> 
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Eric Sunshine <sunshine@sunshineco.com> writes:
> >
> >> On Sat, Feb 9, 2019 at 2:00 PM <randall.s.becker@rogers.com> wrote:
> >>> This change removes the dependency on /dev/zero with
> >>> generate_zero_bytes appending NUL values to blocks generating wrong
> signatures for test cases.
> >>
> >> This commit message says what the patch does but not _why_. At
> >> minimum, it should explain that /dev/zero is not available on all
> >> platforms, therefore, not portable, and (perhaps) cite NonStop as an
> >> example.
> >
> > Does sombody want to do the honors?  [PATCH 1/3] would become wasted
> > effort until that happens.  On the other hand, if this is not urgent
> > (it is only urgent for those without /dev/zero, and to others it may
> > be distraction/disruption this close to the final release to add
> > increased risk of fat finger mistakes), obviously I can wait.
> 
> So, before I lose the access to my primary screen (I was told that somehow
I
> need to reimage the workstation today X-<), here is what I have now.
> 
> -- >8 --
> From: "Randall S. Becker" <rsbecker@nexbridge.com>
> Date: Sat, 9 Feb 2019 13:59:29 -0500
> Subject: [PATCH] t5318: replace use of /dev/zero with generate_zero_bytes
> 
> There are platforms (e.g. NonStop) that lack /dev/zero; use the
> generate_zero_bytes helper we just introduced to append stream of NULs at
> the end of the file.
> 
> The original, even though it uses "dd seek=... count=..." to make it look
like it
> is overwriting the middle part of an existing file, has truncated the file
before
> this step with another use of "dd", which may make it tricky to see why
this
> rewrite is a correct one.

Here is how I interpret the test - might be wrong, but yanno...
The first dd copies something looking like reasonable data from the test
case.
The second dd copies zeros from seek to the end of a fixed size block.

My first attempt at a fix used truncate that extended the first to the
correct size (filling with zeros). My worry there is that I'm not sure there
is a guarantee of zeros, but that shouldn't matter for the test which just
wants a signature mismatch.

Others suggested using yes to fill in junk.

My second attempt was to create the generate_zero_bytes function to replace
exactly what the second dd was doing but not user /dev/zero. The fix was not
to change the conditions of the test - not debating the correctness of that
here - but to simply replicate the use of /dev/zero in context. So the
resulting file contains [reasonable-stuff]{seek}[0]{orig_size-seek}, which
is sufficient to satisfy the conditions of the test.

> 
> Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  t/t5318-commit-graph.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh index
> 16d10ebce8..d4bd1522fe 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -383,7 +383,7 @@ corrupt_graph_and_verify() {
>  	cp $objdir/info/commit-graph commit-graph-backup &&
>  	printf "$data" | dd of="$objdir/info/commit-graph" bs=1
> seek="$pos" conv=notrunc &&
>  	dd of="$objdir/info/commit-graph" bs=1 seek="$zero_pos" count=0
> &&
> -	dd if=/dev/zero of="$objdir/info/commit-graph" bs=1
> seek="$zero_pos" count=$(($orig_size - $zero_pos)) &&
> +	generate_zero_bytes $(($orig_size - $zero_pos))
> +>>"$objdir/info/commit-graph" &&
>  	test_must_fail git commit-graph verify 2>test_err &&
>  	grep -v "^+" test_err >err &&
>  	test_i18ngrep "$grepstr" err

