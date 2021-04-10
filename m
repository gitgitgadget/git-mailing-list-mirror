Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC1CC433B4
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 00:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C51F76113A
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 00:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235325AbhDJA5Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 20:57:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53085 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235215AbhDJA5Z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 20:57:25 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 45A2DAFFC3;
        Fri,  9 Apr 2021 20:57:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4R2K90GpuR0m9WrE7efNlX486K4=; b=vRv4SC
        g1fO2aVd94t0O9e8D84rX91oedIAAUZK/vP71fdXBMEG8kihi5b6q3hGsc/FQslk
        CydnzCziPOxWyx0A03YBf8qM9iq+P3XydgXM8N2Dt31nvhVWHcSGRQKWPEJTxAcu
        ZUBQ0fP+8mg+O4kGIZlTwuVyEwadJcbA3M4fc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=t39aLAYcJpsiEpPApmLUcxO+qjVldDn1
        XrKHH9tQxBOfQ25015qvQQC9euHYY6sZMKiZ6B+rZ4iB/uwvc4zAbeDipIoli+NM
        q3lFTmFjfrV/T+S+KaOYBP3SCl6QmFxHRI6T2QsSaKQGvDU3u0RVZFj5xq8jBajW
        g2FXeTtoLHI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3E2A4AFFC1;
        Fri,  9 Apr 2021 20:57:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BE616AFFC0;
        Fri,  9 Apr 2021 20:57:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] test-lib: allow test snippets as here-docs
References: <YHDUg6ZR5vu93kGm@coredump.intra.peff.net>
        <YHDVAxxKDzfTlq3h@coredump.intra.peff.net>
        <xmqqtuofkqxu.fsf@gitster.g>
Date:   Fri, 09 Apr 2021 17:57:10 -0700
In-Reply-To: <xmqqtuofkqxu.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        09 Apr 2021 15:56:29 -0700")
Message-ID: <xmqqh7kfklcp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AE479B96-9997-11EB-8AD3-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> +	# start with a newline, to match hanging newline from open-quote style
>> +	eval "$1=\$LF"
>> +	local test_line
>> +	while IFS= read -r test_line
>> +	do
>> +		eval "$1=\${$1}\${test_line}\${LF}"
>> +	done
>
> I wonder if we can do this without relying on "read -r" (which I
> distrust, perhaps out of superstition)?  Perhaps by slurping the
> whole thing with "$(cat)"?

Meaning, something along this line...

----- >8 --------- >8 --------- >8 --------- >8 ----
#!/bin/sh
LF='
'
ttt () {
	eval "$1"='$LF$(cat)'
}
ttt script <<\EOT
	a
	b
EOT
echo "<<<$script>>>"
----- 8< --------- 8< --------- 8< --------- 8< ----
