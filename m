Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2807C433E0
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 20:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D26F60201
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 20:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbhBJUhD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 15:37:03 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52470 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbhBJUhD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 15:37:03 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 98C69A29C9;
        Wed, 10 Feb 2021 15:36:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Du/2QRp9BwX+euIrU0khTMYXVx4=; b=PG8J8e
        0ZttiPi1x7YMYb3CPCT1Yro65V1jLv4nxR/5GeVW2cNiQdHaMPAs29vjNdb6KvGG
        LnqKIOFHdFtL7p+zGG0mwLB5aB6p4qnr83SedLaERow/iWgYrsHm9EdQK8DRsKhl
        wIiOiNK6xH+3xxFu86waRKEpNE6eScEn4qQ/M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wlADHhi4dXsEvaTa6HUoITsBXztwr/ne
        7oQRwki2ZQPAH0TGkhJKQOQv92ZhEBvYEMBC7D3MUUQLLhY/jNOgcVr3RotFQpgh
        eUtNA1N+u226IkJLodX78gk6Fs6F/7NP2jp49bXwzZtdjvZ09A82y1lAs/YC4U2H
        gkgbieHAkR4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8F65BA29C7;
        Wed, 10 Feb 2021 15:36:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1E4F8A29C6;
        Wed, 10 Feb 2021 15:36:20 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/2] t1450: robustify `remove_object()`
References: <pull.874.git.1612980090.gitgitgadget@gmail.com>
        <24d43d121162a9052f31c760a5fc929fdaad76b5.1612980090.git.gitgitgadget@gmail.com>
Date:   Wed, 10 Feb 2021 12:36:19 -0800
In-Reply-To: <24d43d121162a9052f31c760a5fc929fdaad76b5.1612980090.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Wed, 10 Feb 2021
        18:01:29 +0000")
Message-ID: <xmqqtuqj1wzg.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A1CD37C6-6BDF-11EB-BD2F-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> -test_expect_success 'setup: helpers for corruption tests' '
> -	sha1_file() {
> -		remainder=${1#??} &&
> -		firsttwo=${1%$remainder} &&
> -		echo ".git/objects/$firsttwo/$remainder"
> -	} &&
> +sha1_file () {
> +	git rev-parse --git-path objects/$(test_oid_to_path "$1")
> +}

Yeah, back when 90cf590f (fsck: optionally show more helpful info
for broken links, 2016-07-17) originally introduced this pattern,
we didn't have nicely abstracted helper, but now we do, and there
is no reason not to use it.  Nice.

> -	remove_object() {
> -		rm "$(sha1_file "$1")"
> -	}
> -'
> +remove_object() {

Just like you did for the other one, let's insert SP before () for
consistency here.

> +	rm "$(sha1_file "$1")"
> +}
>  
>  test_expect_success 'object with bad sha1' '
>  	sha=$(echo blob | git hash-object -w --stdin) &&

Nicely done.  

Reviewed-by: Junio C Hamano <gitster@pobox.com>
