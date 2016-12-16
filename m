Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39B541FF40
	for <e@80x24.org>; Fri, 16 Dec 2016 18:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755429AbcLPSI5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Dec 2016 13:08:57 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61289 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751334AbcLPSI4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2016 13:08:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 925AD571E6;
        Fri, 16 Dec 2016 13:08:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=D8W9MpPkcWaGRfTdvi+19sOso3k=; b=SLTlMX
        VichJx5+sKLsIBCBWJFriDPURAfyXBGLKI2YiA52reBno6LIVW+z2NTBoaKqktzB
        RlUqpfk08WUgzZShB8T+7moHWYTdoUJ6gp9LUGZVxoMXKjfCY9OX679lyKmecbG8
        ID8G9MyCrM1ZLoT4Ls4qaeXVQKrMyWzSfD3is=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KBcXOue1q5JiIubDJQE9msnYLb6VgQZN
        ArLiCPda+KUBY3GH9Xu+Hg/vyiSv4V/v25z5jlONDMYguGokpQd193hEGKVTYkmA
        Gdb2tHsHlHu1ybaPh6YPIvQerzb3xvp7KZ43CYHZJYMjArRQWIP/AWhU2b7jc/00
        hNry65F+B6I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 88391571E5;
        Fri, 16 Dec 2016 13:08:55 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0D9DC571E4;
        Fri, 16 Dec 2016 13:08:54 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH 1/1] mingw: intercept isatty() to handle /dev/null as Git expects it
References: <cover.1481454992.git.johannes.schindelin@gmx.de>
        <42ddc270ea04e01e899cc479063e5d602e4a4448.1481454992.git.johannes.schindelin@gmx.de>
        <129f000c-49c1-0e75-26b3-c96e9b442443@kdbg.org>
Date:   Fri, 16 Dec 2016 10:08:53 -0800
In-Reply-To: <129f000c-49c1-0e75-26b3-c96e9b442443@kdbg.org> (Johannes Sixt's
        message of "Fri, 16 Dec 2016 18:48:01 +0100")
Message-ID: <xmqqy3zfsq4q.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B51475D2-C3BA-11E6-830D-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 11.12.2016 um 12:16 schrieb Johannes Schindelin:
>> When Git's source code calls isatty(), it really asks whether the
>> respective file descriptor is connected to an interactive terminal.
>> ...
>> +			if (!GetConsoleScreenBufferInfo(handle, &dummy))
>> +				res = 0;
>
> I am sorry to have to report that this check does not work as
> expected. I am operating Git from CMD, not mintty, BTW.

Ouch.

Sorry for not having waited for you to chime in before agreeing to
fast-track this one, and now this is in 'master'.

I should have known better than that by now, after having seen you
uncover bugs that did not trigger in Dscho's environment and vice
versa to tell you that Windows specific things both of you deem good
have a much higher chance of being correct than a change without an
Ack by the other.



> It fails with GetLastError() == 6 (invalid handle value). The reason
> for this is, I think, that in reality we are not writing to the
> console directly, but to a pipe, which is drained by console_thread(),
> which writes to the console.
>
> I have little clue what this winansi.c file is doing. Do you have any
> pointers where I should start digging?
>
> Wait...
>
> Should we not use winansi_get_osfhandle() instead of _get_osfhandle()?
>
>> +		}
>> +	}
>> +
>> +	return res;
>> +}
>> +
>>  void winansi_init(void)
>>  {
>>  	int con1, con2;
>>
