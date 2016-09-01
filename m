Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F18B1F6BF
	for <e@80x24.org>; Thu,  1 Sep 2016 20:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754597AbcIAUy4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 16:54:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56378 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753423AbcIAUyw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 16:54:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E4E339B8A;
        Thu,  1 Sep 2016 13:15:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=tElkoyKrE+yc
        uDPw1D6KBNo+Bug=; b=f7WR0TXuOiAVsCAt3IP+BN4Th9pwhWHS4DGRvsLf2fgd
        mE0bQVVq0xLcPkfqKaKDTK9gkldp/1KHPdIGndTxchwCZIF/qKznBgGarNrn2BB5
        VpI1bcYtyn22rFIkFaVnYDso0UUOxY+EHwhNVL9tnWwo4FfLlWEyrei/hPqO2WE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=WEpvcj
        SKlqeexstF49U+IC1fvO3/MdGBMb8WHrH4S57r6rQLEOPxIDzKT5KTfFGMJCxrHL
        Yx5sDdpdeL6kCy8HIdtKSWO4BIPQq3AnsKHgxiCm+1SELjFxKBvy0h/rWRg37Rjv
        qUj+Qd8AJqKD6CaMetD+/pmOvaDrNbPhMAfV8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 462D639B89;
        Thu,  1 Sep 2016 13:15:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B59E339B88;
        Thu,  1 Sep 2016 13:15:58 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org,
        peff@peff.net, sbeller@google.com, Johannes.Schindelin@gmx.de,
        jnareb@gmail.com, mlbright@gmail.com
Subject: Re: [PATCH v6 13/13] read-cache: make sure file handles are not inherited by child processes
References: <20160825110752.31581-1-larsxschneider@gmail.com>
        <20160825110752.31581-14-larsxschneider@gmail.com>
        <xmqqy43fbgcj.fsf@gitster.mtv.corp.google.com>
        <4D9E5AED-7003-4707-8791-1C25432DB558@gmail.com>
        <xmqq37lnbbpk.fsf@gitster.mtv.corp.google.com>
        <4A177D61-AA25-415A-808D-B6BDA3BB5C47@gmail.com>
        <20160830145429.GA11221@tb-raspi>
Date:   Thu, 01 Sep 2016 10:15:55 -0700
In-Reply-To: <20160830145429.GA11221@tb-raspi> ("Torsten =?utf-8?Q?B=C3=B6?=
 =?utf-8?Q?gershausen=22's?=
        message of "Tue, 30 Aug 2016 14:54:29 +0000")
Message-ID: <xmqqd1kny20k.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C00FD48C-7067-11E6-A6E6-F7BB12518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

>>=20
>> diff --git a/sha1_file.c b/sha1_file.c
>> index d5e1121..759991e 100644
>> --- a/sha1_file.c
>> +++ b/sha1_file.c
>> @@ -1485,7 +1485,7 @@ int check_sha1_signature(const unsigned char *sh=
a1, void *map,
>> =20
>>  int git_open_noatime(const char *name)
>
> Hm, should the function then be renamed into
>
> git_open_noatime_cloexec()
>
>>  {
>> -	static int sha1_file_open_flag =3D O_NOATIME;
>> +	static int sha1_file_open_flag =3D O_NOATIME | O_CLOEXEC;

Perhaps.

In any case, this is probably something that can and should be done
outside this series.

I am tempted to suggest that the patch 13/13 under discussion may
also want to be done outside the scope of, and before, this series.
Even though with the current system an inherited file descriptor to
v1 filter processes would cause issues, there is no good reason to
expose this file desciptor to them.

Thanks.

