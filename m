Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96765C433EF
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 06:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CDC161057
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 06:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243184AbhKRGmN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 01:42:13 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63119 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbhKRGmL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 01:42:11 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8E6BFFDFE3;
        Thu, 18 Nov 2021 01:39:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=Jm3BpgbBhXEr5mX0l+9UaaTpq2IOHWN8wZx2bKuryBs=; b=nZ8O
        rkIftSmiW8QvPumKom3uXp+2Img+EdxNoBnCayhYMtxj8ivNfw7c1a2k2SodNluS
        lBQ/w3PTl1Y/f0NNlkzT+AC/Du0zx0OLXAb8nBaTwfA7VMsDF4zPiDYpqEPU3/39
        cd6wdZCyYNpAGQxnWV0Gb6rzykujd4UOPOlQD9Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 71DD2FDFE2;
        Thu, 18 Nov 2021 01:39:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C8B1EFDFE1;
        Thu, 18 Nov 2021 01:39:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] ssh signing: support non ssh-* keytypes
References: <20211117162727.650857-1-fs@gigacodes.de>
        <xmqq4k8a2m97.fsf@gitster.g>
Date:   Wed, 17 Nov 2021 22:39:08 -0800
Message-ID: <xmqqh7caynlf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3C49812E-483A-11EC-A55C-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Fabian Stelzer <fs@gigacodes.de> writes:
>
>> +/* Determines wether key contains a literal ssh key or a path to a file */
>> +static int is_literal_ssh_key(const char *key) {
>> +	return (
>> +		starts_with(key, "ssh-") ||
>> +		starts_with(key, "ecdsa-") ||
>> +		starts_with(key, "sk-ssh-") ||
>> +		starts_with(key, "sk-ecdsa-")
>> +	);
>> +}
>
> A more forward looking thing you could do is to 
>
>  (1) grandfather the convention "any string that begins with 'ssh-'
>      is taken as a ssh literal key".
>
>  (2) refrain from spreading such an unstructured mess by picking a
>      reserved prefix, say "ssh-key::" and have all other kinds of
>      ssh keys use the convention.
>
> making the above function look more like
>
>     static int is_literal_ssh_key(const char *string, const char **key)
>     {
> 	if (skip_prefix(string, "ssh-key::", key)
> 	    return 1;
> 	if (starts_with(string, "ssh-")) {
> 	    key = string;
> 	    return 1;
> 	}
> 	return 0;
>     }

Given that this ONLY gets called from ssh codepath, I think the
special prefix can just be "key::", and when a new crypto suite
is introduced to sit next to GPG and SSH, presumably the code
structure to support it will be similar to that of ssh's, and it
can also use "key::" prefix for their literal keys.  That design
may be cleaner.

Thanks.
