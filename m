Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76619C433F5
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 23:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiJJX41 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 19:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiJJX4Z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 19:56:25 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD397F256
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 16:56:23 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 13F7D14534D;
        Mon, 10 Oct 2022 19:56:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jQYXCwJcztS7kR9v+Eu2qAIDkvVpAvDRlT0Oyz
        H0gCs=; b=oUGfDnXmq3jwNYyVInsGdzYww1HI0EywXLzVr0swSBTlogcRwxkgZ/
        writmZPxVGtd/1fEODLlpyV8dIPVFTx5NZ4ENHroRObfOYxLlr+OMyvdsPhF3154
        9vv/Adtt78JQY1uSY8dlJgPV8uAe29BiIDHmycVqZv6OQVAGOaFTk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0A04A14534C;
        Mon, 10 Oct 2022 19:56:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6D28B14534A;
        Mon, 10 Oct 2022 19:56:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     sndanailov@wired4ever.net, git@vger.kernel.org
Subject: Re: [PATCH] docs: git-send-email: difference between ssl and tls
 smtp-encryption
References: <20221010172859.13832-1-sndanailov@wired4ever.net>
        <Y0R2AwKuXAVMP5Ma@tapette.crustytoothpaste.net>
Date:   Mon, 10 Oct 2022 16:56:20 -0700
In-Reply-To: <Y0R2AwKuXAVMP5Ma@tapette.crustytoothpaste.net> (brian
        m. carlson's message of "Mon, 10 Oct 2022 19:44:03 +0000")
Message-ID: <xmqq35bvz10b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 23E3F588-48F7-11ED-AED9-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>>  --smtp-encryption=<encryption>::
>> +	Specify the encryption to use, either 'ssl' or 'tls'. Any other
>> +	value reverts to plain SMTP. The difference between the two for Git is
>> +	that 'ssl' uses implicit encryption and defaults to port 465, 'tls'
>> +	uses explicit encryption and defaults to port 25. Other ports might be
>> +	used by the SMTP server. Default is the value of
>>  	`sendemail.smtpEncryption`.
>
> This is a definite improvement, but maybe we'd want to say that 'tls' is
> really STARTTLS, while 'ssl' is always-on encryption over a dedicated
> port.  It might also be worth mentioning that the choice of name doesn't
> affect the actual protocol and version used and the user is almost
> certainly using TLS either way.

So, it is not really specifying "the encryption", rather the way to
get into the encrypted communication.

I think the prose is OK, as long as we are not adding the third
value, at which time we may want to use enumeration instead.

        Specify how SMTP connection should be entered into encrypted
        mode.  The valid values are 'ssl' and 'tls'. Any other value
        reverts to plain (unencrypted) SMTP.  'ssl' refers to "implicit"
        encryption (sometimes calls SMTPS) that uses port 465 or 587 by
        default. 'tls' refers to "explicit" encryption (often known as
        STARTTLS) that uses port 25 by default.  Despite their names, it
        is likely the user is using the newer TLS protocol, not the
        deprecated SSL, for the actual encryption protocol either way.
    +
    Other ports might be used by the SMTP server. Default is the value of
    `sendemail.smtpEncryption`.

We might want to

 * introduce synonyms implicit/smtps vs explicit/starttls and
   deprecate the current confusing names over time?

 * error out when invalid value is given, instead of silently
   talking plaintext SMTP?

