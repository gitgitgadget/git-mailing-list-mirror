Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A060C4332F
	for <git@archiver.kernel.org>; Wed, 28 Dec 2022 21:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbiL1ViA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Dec 2022 16:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiL1Vh6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2022 16:37:58 -0500
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E1A15827
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 13:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1672263471; bh=x8c8tNbaAZPTBUmvkF8JCQNGTa9UdGPnMaS5IXCJXps=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=SpB7K63yrykUeRunWzD7OHjt88dIP+CTNwn3SV89FD/01A20JAek21W4Z4GwOR//H
         31Y5VUvvobpNkCg5ObJ893b1SkoASKhD7uz4EhOJTSZUDItFmD1gsG5nBPet+8zGlj
         9WezVPRkeOdmqDwr6FRIY/+Ei4UcfH3V9gtQih8SvjYehClsRyKv/eHwzqSlUWk7Tk
         MmWrD+CKMK+NznH8CFnv7VVNouQrviPkaDvj+XAUo8zRuD2h8s2IxMcP0azPXOuZDr
         /4AtwtMWRKxcfVJ3rjFkaVWmKfbc+TI6X2cUCI3stypVWTaVfjCgy1APlOXCBCKR0t
         PjNSRBZKXKa7g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.151.35]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MPrPV-1pXWCC2Js3-00MjDb; Wed, 28
 Dec 2022 22:37:51 +0100
Message-ID: <5ca7b3ce-dda9-270a-6439-bd897cd5df28@web.de>
Date:   Wed, 28 Dec 2022 22:37:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 12/20] http-backend.c: fix cmd_main() memory leak,
 refactor reg{exec,free}()
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com>
 <patch-12.20-9be5b0c7836-20221228T175512Z-avarab@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <patch-12.20-9be5b0c7836-20221228T175512Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:psGUpKfRq/xyj+DnQRKy3dZsMa23cg5CAgIrTnntV2IK1D3fnHT
 9zNt8xzmkRgTDTEp5jaGUzCiKIu2af3MIne504aYFZfUMcS3dr1ibvJrfhfobnxjNF9S8m3
 aWOkdtV5WE6nCH74cdKQ65agIiq64Vr1v3kywYAK/QxLR2FBrzEyr0Jf2T8OEXNxc/5atr1
 M2GMb8+g6wFfuvhkNsH5Q==
UI-OutboundReport: notjunk:1;M01:P0:aIM2WCT+hd8=;P+I6LLDIcWWi0HTrePHNXX2SDi/
 9yCgom5csCn23YNsQEReehrr7/CYHUW/NPFaQMEED3AOOG5W6TB+hiOAIoiCNv54E8rEPBQpv
 fJEScsTr3C8amiYw8rXrUqSmXzsis8nc777AV7NFk2Rqmth17bsEzwFNkluaRpUMExMtcE0Iq
 d33v1VLI9DPbOow6naTkP02QUdlucKI6L5NAha9RqRXrFD+JbEsuI7pp0g33imkUM4EgC6mCK
 ztrtD4viz0qPhkc1xdVllFlLTm4J+wBJepgtYQyANBX57xL4IuvoK+GTFi+Akrs1Nrvz4a3og
 gv1Xhc+YExmIt4SSqYqUSD0rxHoE08t7V56EK4Ak4vfuuagAKUJ5RlkXjWY9XzFjGpAk4P8Ar
 1eHiiH45nBpOTriu9TJpUU8DcFq8MGuFzEfG0jEUnMghv2IEZnUk1RdSLteIIefU40XjkqYDw
 oxubOx1hmBy2LXowAZz6GC196dYrudgWZ+8NluARw7mouoQ/COeZuBgOpd9Bm3B2VETSYgDVe
 GQ29TMVdxVEjWnLRmj9gY4fRN9gZVOA9IkjCwXLJvLbIUeUmz8cDANicLK7Dq6ngdtVFlO8P8
 8TLDf2Kt+4nrWQBmz5UQ7eqpf4Atn+ZqmIyq1paLlsBzH6rw+aOzVw66xfcidEWDbVSmSNdVh
 iKPQWUM93TuRXPvnw/5r7B22zHUAUQYeU/QVB9qrSgfHBo84fCf9z2R+e9oVUrjkhDIRL8OhJ
 W/jhgLoyp+Ug9RuoMJpPaxzI7fbCwhyvEWGmXGWqNitxbuVb+DrJbKWinYPoD5W+wFbN1cuIH
 lVEZTzQUYZTw04PCmsC1XRl8PMFhyd0pGJ7VvA2YnclDoqIDu/qYG1wJXmMoOkJel60ykQSQA
 Gp0D1/Wp7Qpdble7JGqagvDUE8KAdSVdH8YDziI5C49Hbkka70USgun26oDQZII4ijSO7+C1T
 3vjLZZpYL8PGzszbmmaZmD+K/xk=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.12.22 um 19:00 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> Fix a memory leak that's been with us ever since
> 2f4038ab337 (Git-aware CGI to provide dumb HTTP transport,
> 2009-10-30). In this case we're not calling regerror() after a failed
> regexec(), and don't otherwise use "re" afterwards.
>
> We can therefore simplify this code by calling regfree() right after
> the regexec(). An alternative fix would be to add a regfree() to both
> the "return" and "break" path in this for-loop.

Yes, or to add one regfree() call early in the conditional...

>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  http-backend.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/http-backend.c b/http-backend.c
> index 6eb3b2fe51c..9bb63c458b1 100644
> --- a/http-backend.c
> +++ b/http-backend.c
> @@ -759,10 +759,14 @@ int cmd_main(int argc, const char **argv)
>  		struct service_cmd *c =3D &services[i];
>  		regex_t re;
>  		regmatch_t out[1];
> +		int ret;
>
>  		if (regcomp(&re, c->pattern, REG_EXTENDED))
>  			die("Bogus regex in service table: %s", c->pattern);
> -		if (!regexec(&re, dir, 1, out, 0)) {
> +		ret =3D regexec(&re, dir, 1, out, 0);
> +		regfree(&re);
> +
> +		if (!ret) {
>  			size_t n;
>

... i.e. right here.  But only after copying the offsets out of "out"!

Anyway, the ret approach taken here is fine.

"dir" is still leaking, by the way.  Probably worth a separate patch.

>  			if (strcmp(method, c->method))
> @@ -774,7 +778,6 @@ int cmd_main(int argc, const char **argv)
>  			dir[out[0].rm_so] =3D 0;
>  			break;
>  		}
> -		regfree(&re);
>  	}
>
>  	if (!cmd)
