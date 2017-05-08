Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: **
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=2.5 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MIME_CHARSET_FARAWAY,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C3981FDEA
	for <e@80x24.org>; Mon,  8 May 2017 11:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750884AbdEHLZI (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 07:25:08 -0400
Received: from m12-11.163.com ([220.181.12.11]:32979 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752105AbdEHLZH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 07:25:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Mime-Version:Subject:From:Date:Message-Id; bh=TLYzK
        jAHFRdNpSHrNlv2cDdHxEZbIe303E2w/R8dvDQ=; b=F9pqauFbbBNQiwT8+xTrB
        4TdhKHWhKfOmlUmz6JikIdhRB6NEGHtF6EoS8V08QlWgYMkcosxiuF2kTC10vn/W
        GvW4ik1QYrnfxgMNiWhPRMh9Pg0CwD1i8j/HIloYk+yoE1lSp9RHyok903ipcjm3
        lqkI/b3nEzA3nCcIdzClhc=
Received: from [10.223.209.10] (unknown [117.136.38.219])
        by smtp7 (Coremail) with SMTP id C8CowAD3vClDVRBZfQoSEQ--.8251S2;
        Mon, 08 May 2017 19:23:49 +0800 (CST)
Content-Type: text/plain;
        charset=gb2312
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3] send-email: --batch-size to work around some SMTP server limit
From:   =?GB2312?B?1dTQoce/?= <zxq_yx_007@163.com>
X-Mailer: iPhone Mail (14E304)
In-Reply-To: <xmqqpofk9edz.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 8 May 2017 19:23:46 +0800
Cc:     git@vger.kernel.org, viktorin@rehivetech.com, mst@kernel.org,
        pbonzini@redhat.com, mina86@mina86.com, artagnon@gmail.com,
        avarab@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <E359FC85-97FC-48BF-B93C-B01CA32F70A8@163.com>
References: <20170507043648.24143-1-zxq_yx_007@163.com> <xmqqpofk9edz.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-CM-TRANSID: C8CowAD3vClDVRBZfQoSEQ--.8251S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtr4xtr1UAr1fXr47GFWktFb_yoWkWrcEqw
        sxZrZ2q3Wj9Fn7tFsrJr4vgrnagF1DJa9Fv34DX3W7W345ZFZ5ZF4qkrZ7ua1rJr4FvrZx
        GwsaqFWfC3sxujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU82Nt7UUUUU==
X-Originating-IP: [117.136.38.219]
X-CM-SenderInfo: 520ts5t0bqili6rwjhhfrp/xtbB0gzRxlUMDz8lEAAAsV
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> =D4=DA 2017=C4=EA5=D4=C28=C8=D5=A3=AC12:11=A3=ACJunio C Hamano <gitster@po=
box.com> =D0=B4=B5=C0=A3=BA
>=20
> Two suggestions.
>=20
> (1) I do not think $smtp is always valid when we come here; it is
>     unsafe to unconditionally say $smtp->quit like this patch does.
>=20
>    $smtp->quit if defined $smtp;
>=20
>     may help codepaths like $dry_run and also the case where
>     $smtp_server is the absolute path to a local program.
>=20

Hmm=A3=ACmissed this code path.

> (2) You are setting $auth to zero to force re-authentication to
>     happen.  It would be more consistent to the state of $auth that
>     is not-yet-used to "undef $auth;" here instead.  After all, the
>     variable starts its life in an undefined state.
>=20
>=20
> So all in all
>=20
>    $smtp->quit if defined $smtp;
>    undef $smtp;
>    undef $auth;
>=20
> perhaps?
>=20
> This change of course forces re-authentication every N messages,
> which may not hurt those who use some form of credential helper, but
> that may be something we want to mention in the log message.

Yes, it' s better to undef $auth here. I will update the commit message next=
 version.

Thank you very much for your helpful suggestions =A3=A1

>=20
>> +        sleep($relogin_delay);
>> +    }
>> }
>=20
> Thanks.


