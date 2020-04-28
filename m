Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1C3C83001
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 00:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B32A42078C
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 00:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rM389zqr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgD1AEN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 20:04:13 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60249 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgD1AEN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Apr 2020 20:04:13 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 664A35DF89;
        Mon, 27 Apr 2020 20:04:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0AuNQZOx2s3m+4ZBcMMpj+gwL1c=; b=rM389z
        qruDi2dIG26hJ6NPJhWdU5wbmFeu3q46ehd7rJ7ITs3DgYT05iiuC2NnFzL6I9/l
        RVcqbQDll+4hQl1vqk74DFUDhVxpPM9DX5qi4PLHM2vcyuNG6D4gd5Dw/+AYh5nl
        BaxhKOP96TezNCCpWdDbGQbi40y169V+lb2Jo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=M4fxO4kjaWGAWIvFAZlh9ZBsZd2ytBRB
        7PsNpvs63R/hn5ZShqpioecmiKouqhrvZ3wHBJ8/aGemSfPqvcZfEuJpjba7pXmi
        sEnpzP8eS2nh0Cc+APDPdgLqrLCY9zPCJ0eN0OoBTvPmgrP5CH+/e6d3Y6eOQ9O+
        Jx2RQj2QAIc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5E8F55DF87;
        Mon, 27 Apr 2020 20:04:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DD80E5DF85;
        Mon, 27 Apr 2020 20:04:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] bugreport: collect list of populated hooks
References: <20200424233800.200439-1-emilyshaffer@google.com>
        <20200427233820.179891-1-emilyshaffer@google.com>
        <20200427234510.GC36078@google.com>
Date:   Mon, 27 Apr 2020 17:04:10 -0700
In-Reply-To: <20200427234510.GC36078@google.com> (Jonathan Nieder's message of
        "Mon, 27 Apr 2020 16:45:10 -0700")
Message-ID: <xmqqh7x45vd1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C996BD8E-88E3-11EA-959B-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Emily Shaffer wrote:
>
>> --- a/t/t0091-bugreport.sh
>> +++ b/t/t0091-bugreport.sh
>> @@ -57,5 +57,15 @@ test_expect_success 'can create leading directories outside of a git dir' '
>>  	nongit git bugreport -o foo/bar/baz
>>  '
>>  
>> +test_expect_success 'indicates populated hooks' '
>> +	test_when_finished rm git-bugreport-hooks.txt &&
>> +	test_when_finished rm -fr .git/hooks &&
>> +	mkdir .git/hooks &&
>> +	touch .git/hooks/applypatch-msg &&
>> +	chmod +x .git/hooks/applypatch-msg &&
>
> optional: could use write_script for this

Yup, it is a good practice to do so.  Use of touch is especially bad
here, as it is quite plausible for us to later change the "is the
hook there?" check to exclude a completely empty file.

>> +	git bugreport -s hooks &&
>> +	test_i18ngrep applypatch-msg git-bugreport-hooks.txt
>
> This should work even when translated, so it can use "grep" instead of
> test_i18ngrep.

Nicely spotted.

Thanks.
