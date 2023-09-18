Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3EC6CD37B0
	for <git@archiver.kernel.org>; Mon, 18 Sep 2023 19:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjIRTFT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Sep 2023 15:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjIRTFR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2023 15:05:17 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA6310DD
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 12:04:22 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8845D1BEBF0;
        Mon, 18 Sep 2023 15:04:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=n7r9HUmxw0NEsBIjqlecyT5i/eSXaOGYabbArY
        y8SCc=; b=FDUEcuxKw3NRXKmCUwsKT4QCZI8UMNFO6ZALb8dnTctfgIRjlTbFWO
        LlUxzcdtnkJzX6Xujfn8IVTP6LQ9w3a/XVFUiCoLpXN+UErxEJ/QGIf3l2spEV+K
        9HXwN5z9e846mEolQFmaW+aN8wuQwiZM9azRFAvOGJ5Q1XF3AYFFU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 808081BEBEF;
        Mon, 18 Sep 2023 15:04:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AAC0F1BEBEE;
        Mon, 18 Sep 2023 15:04:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH] git-send-email.perl: avoid printing undef when
 validating addresses
In-Reply-To: <545729b619308c6f3397b9aa1747f26ddc58f461.1695054945.git.me@ttaylorr.com>
        (Taylor Blau's message of "Mon, 18 Sep 2023 12:35:53 -0400")
References: <ZQhI5fMhDE82awpE@debian.me>
        <545729b619308c6f3397b9aa1747f26ddc58f461.1695054945.git.me@ttaylorr.com>
Date:   Mon, 18 Sep 2023 12:04:19 -0700
Message-ID: <xmqq5y47l2vg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2C66407C-5656-11EE-B914-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> diff --git a/git-send-email.perl b/git-send-email.perl
> index 897cea6564..288ea1ae80 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1166,10 +1166,10 @@ sub extract_valid_address {
>  
>  sub extract_valid_address_or_die {
>  	my $address = shift;
> +	my $valid_address = extract_valid_address($address);
>  	die sprintf(__("error: unable to extract a valid address from: %s\n"), $address)
> +		if !$valid_address;
> +	return $valid_address;

This will still use undef if the incoming $address is already undef,
but the caller deserves what it gets in such a case.  The message
reports that the %s is the source from which the code tried to
extract the address from, not the result of failed extraction, so
the rewrite is absolutely the right thing to do.

Will queue.  Thanks.


>  }
>  
>  sub validate_address {
