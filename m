Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C1011FCC7
	for <e@80x24.org>; Thu, 22 Dec 2016 23:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941878AbcLVXSN (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Dec 2016 18:18:13 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54304 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S941233AbcLVXSM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2016 18:18:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7A7385AD3F;
        Thu, 22 Dec 2016 18:18:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=euiytVuBHHlopb8R3y63UZOgk/k=; b=ivUdPq
        FP0g9yH0lwrtYIW+ASfoFYjMHyhvjwXPB6oZQnmrCV18Z0LmdzVzk49JwhZDGut9
        ZGx+MQy9j5+bN2T3QEEVxTEyn2snyWLYFAyzENdFuctoShDCqDy7uriGPSCPuUtT
        fNWsOrxQWTZmSrCaA+qOon61eTtBoOSPMyChI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gWZLQA5mBRt3QicWuHDPN1E6brJS77Vp
        6JWeLJimWVNDQjA/Sw0sAjQIdn1TZscNPx/9zJe92/MIaAgHkvFLM1R84U9Bwjnf
        OFnA3Xgka0uiLK271UKy5AMOWvIQkilp8tWaIX6nwnqcrX2Chqo/kbQh9licye7O
        Q8h6i+2KCx8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 71C9E5AD3E;
        Thu, 22 Dec 2016 18:18:11 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F3F365AD3D;
        Thu, 22 Dec 2016 18:18:10 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Beat Bolli <dev+git@drbeat.li>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 1/3] mingw: adjust is_console() to work with stdin
References: <cover.1482342791.git.johannes.schindelin@gmx.de>
        <cover.1482426497.git.johannes.schindelin@gmx.de>
        <ca4c61c603247c8ad0b876b068f6cd41fbe01667.1482426497.git.johannes.schindelin@gmx.de>
        <fc3e0d9c-86ea-4a62-6b70-b9cdd67f581a@drbeat.li>
Date:   Thu, 22 Dec 2016 15:18:09 -0800
In-Reply-To: <fc3e0d9c-86ea-4a62-6b70-b9cdd67f581a@drbeat.li> (Beat Bolli's
        message of "Fri, 23 Dec 2016 00:04:18 +0100")
Message-ID: <xmqqlgv7eeoe.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E7C2DC4E-C89C-11E6-BA1D-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Beat Bolli <dev+git@drbeat.li> writes:

>> @@ -84,6 +84,7 @@ static void warn_if_raster_font(void)
>>  static int is_console(int fd)
>>  {
>>  	CONSOLE_SCREEN_BUFFER_INFO sbi;
>> +	DWORD mode;
>
> Nit: can we move this definition into the block below where it's used?
>
>>  	HANDLE hcon;
>>  
>>  	static int initialized = 0;
>> @@ -98,7 +99,10 @@ static int is_console(int fd)
>>  		return 0;
>>  
>>  	/* check if its a handle to a console output screen buffer */
>> -	if (!GetConsoleScreenBufferInfo(hcon, &sbi))
>> +	if (!fd) {
>
> Right here:
> +               DWORD mode;
>
>> +		if (!GetConsoleMode(hcon, &mode))
>> +			return 0;
>> +	} else if (!GetConsoleScreenBufferInfo(hcon, &sbi))
>>  		return 0;

As these patches have been already merged to 'next' a few hours ago
as part of today's integration cycle, please make any further
refinement (if necessary) as incremental updates.

Thanks.
