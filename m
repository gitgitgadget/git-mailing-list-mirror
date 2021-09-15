Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0011EC433F5
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 17:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8E016121F
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 17:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbhIORBx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 13:01:53 -0400
Received: from mout01.posteo.de ([185.67.36.65]:45855 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230024AbhIORBv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 13:01:51 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id C4959240027
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 19:00:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1631725229; bh=658/FDCpxdGerlnMJMddesdESAhzOISDHeTvLJRLf9c=;
        h=Subject:To:Cc:From:Date:From;
        b=QRopeS1P5+ZpVtrJ/sPTQLjk//f8KPvao1z0zZodSWJ+tho0N5xZcYAnz2gs6RNwM
         XvjIJgsiMHNykSgji6v7xZi5aU6MTdeaI21nvcpW9OQfTPB5wNWeXvreP4dMAauSA8
         GgTjXYVmjZHTkzKlGJVkB5cl0I5+8+zweLbMhjh0NpFXkLDUe4Z8Zr3OLNr64S3x8b
         gnagfV7taMRjGduTh3iHKQaecQ84WKwgHQikBBHVqtJCHoRuVh3kAAgJ5/7jKqQrP1
         OfEbhjEj7vKc0AEP/Acfu6Gki7XoTUkd0xQzRXa+kaRE8xPbqF4vZZKuQYjZOdX3VQ
         nN9zei5bC87PA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4H8mgH0Qjcz6tmH;
        Wed, 15 Sep 2021 19:00:27 +0200 (CEST)
Subject: Re: [PATCH] send-email: Avoid incorrect header propagation
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Drew DeVault <sir@cmpwn.com>, Simon Ser <contact@emersion.fr>,
        xiaoqiang zhao <zxq_yx_007@163.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Christian Ludwig <chrissicool@gmail.com>
References: <20210830153001.29961-1-mhaeuser@posteo.de>
From:   =?UTF-8?Q?Marvin_H=c3=a4user?= <mhaeuser@posteo.de>
Message-ID: <0c753ae6-cc2c-2d70-c510-5370a0b4dcf9@posteo.de>
Date:   Wed, 15 Sep 2021 17:00:26 +0000
MIME-Version: 1.0
In-Reply-To: <20210830153001.29961-1-mhaeuser@posteo.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ping? :)

On 30/08/2021 17:30, Marvin Häuser wrote:
> If multiple independent patches are sent with send-email, even if the
> "In-Reply-To" and "References" headers are not managed by --thread or
> --in-reply-to, their values may be propagated from prior patches to
> subsequent patches with no such headers defined.
>
> To mitigate this and potential future issues, make sure all global
> patch-specific variables are always either handled by
> command-specific code (e.g. threading), or are reset to their default
> values for every iteration.
>
> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: Marvin Häuser <mhaeuser@posteo.de>
> ---
>   git-send-email.perl   | 26 ++++++++++++++++---------
>   t/t9001-send-email.sh | 45 +++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 62 insertions(+), 9 deletions(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 25be2ebd2a..e411860b18 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1625,7 +1625,6 @@ sub send_message {
>   
>   $in_reply_to = $initial_in_reply_to;
>   $references = $initial_in_reply_to || '';
> -$subject = $initial_subject;
>   $message_num = 0;
>   
>   # Prepares the email, prompts the user, sends it out
> @@ -1648,6 +1647,7 @@ sub process_file {
>   	@xh = ();
>   	my $input_format = undef;
>   	my @header = ();
> +	$subject = $initial_subject;
>   	$message = "";
>   	$message_num++;
>   	# First unfold multiline header fields
> @@ -1854,15 +1854,23 @@ sub process_file {
>   	}
>   
>   	# set up for the next message
> -	if ($thread && $message_was_sent &&
> -		($chain_reply_to || !defined $in_reply_to || length($in_reply_to) == 0 ||
> -		$message_num == 1)) {
> -		$in_reply_to = $message_id;
> -		if (length $references > 0) {
> -			$references .= "\n $message_id";
> -		} else {
> -			$references = "$message_id";
> +	if ($thread) {
> +		if ($message_was_sent &&
> +		  ($chain_reply_to || !defined $in_reply_to || length($in_reply_to) == 0 ||
> +		  $message_num == 1)) {
> +			$in_reply_to = $message_id;
> +			if (length $references > 0) {
> +				$references .= "\n $message_id";
> +			} else {
> +				$references = "$message_id";
> +			}
>   		}
> +	} elsif (!defined $initial_in_reply_to) {
> +		# --thread and --in-reply-to manage the "In-Reply-To" header and by
> +		# extension the "References" header. If these commands are not used, reset
> +		# the header values to their defaults.
> +		$in_reply_to = undef;
> +		$references = '';
>   	}
>   	$message_id = undef;
>   	$num_sent++;
> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index 3b7540050c..f95177af39 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -2167,6 +2167,51 @@ test_expect_success $PREREQ 'leading and trailing whitespaces are removed' '
>   	test_cmp expected-list actual-list
>   '
>   
> +test_expect_success $PREREQ 'set up in-reply-to/references patches' '
> +	cat >has-reply.patch <<-\EOF &&
> +	From: A U Thor <author@example.com>
> +	Subject: patch with in-reply-to
> +	Message-ID: <patch.with.in.reply.to@example.com>
> +	In-Reply-To: <replied.to@example.com>
> +	References: <replied.to@example.com>
> +
> +	This is the body.
> +	EOF
> +	cat >no-reply.patch <<-\EOF
> +	From: A U Thor <author@example.com>
> +	Subject: patch without in-reply-to
> +	Message-ID: <patch.without.in.reply.to@example.com>
> +
> +	This is the body.
> +	EOF
> +'
> +
> +test_expect_success $PREREQ 'patch reply headers correct with --no-thread' '
> +	clean_fake_sendmail &&
> +	git send-email \
> +		--no-thread \
> +		--to=nobody@example.com \
> +		--smtp-server="$(pwd)/fake.sendmail" \
> +		has-reply.patch no-reply.patch &&
> +	grep "In-Reply-To: <replied.to@example.com>" msgtxt1 &&
> +	grep "References: <replied.to@example.com>" msgtxt1 &&
> +	! grep replied.to@example.com msgtxt2
> +'
> +
> +test_expect_success $PREREQ 'cmdline in-reply-to used with --no-thread' '
> +	clean_fake_sendmail &&
> +	git send-email \
> +		--no-thread \
> +		--in-reply-to="<cmdline.reply@example.com>" \
> +		--to=nobody@example.com \
> +		--smtp-server="$(pwd)/fake.sendmail" \
> +		has-reply.patch no-reply.patch &&
> +	grep "In-Reply-To: <cmdline.reply@example.com>" msgtxt1 &&
> +	grep "References: <cmdline.reply@example.com>" msgtxt1 &&
> +	grep "In-Reply-To: <cmdline.reply@example.com>" msgtxt2 &&
> +	grep "References: <cmdline.reply@example.com>" msgtxt2
> +'
> +
>   test_expect_success $PREREQ 'invoke hook' '
>   	mkdir -p .git/hooks &&
>   

