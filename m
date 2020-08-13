Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1127C433E1
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 05:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C39F320715
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 05:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="OFt92bgk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbgHMF6H (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 01:58:07 -0400
Received: from mout.web.de ([212.227.17.12]:55443 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725954AbgHMF6G (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 01:58:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1597298281;
        bh=gy+1ax5EPJNDjjZfa5sc/sfAOno6//oYUYRfNmoUoS4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=OFt92bgkpBjxSUMJnolUdTjkCPdC38wRLYxe/SWlBfN5G7b6UYtRat7xg28WY+WpK
         lQXrNA/Lm6MhAuFBXeFC1VqRRftM5P6yNcpoYYRZHaot3u4GKDdxanLHwfSMnHeWke
         fMIMNOaB/cA6cs/LWUTt8m4WnhdpFNNdhPAUzX0s=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.26.151]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MejmG-1kLQB63ium-00OIlj; Thu, 13
 Aug 2020 07:58:00 +0200
Subject: Re: [PATCH v2] upload-pack: use buffered I/O to talk to rev-list
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Chris Torek <chris.torek@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
References: <6722ade6-971e-7ecc-e8f0-7f595ca0b0ff@web.de>
 <cf395005-af63-f698-fe19-6c4b6f1a8a4b@web.de>
 <CAP8UFD1rDZOQSDWhc+xdEQVX+Umq-nE-sd-orgKZ3UWTWFHJhw@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <866055fd-7857-3eb3-6dae-befc8f891994@web.de>
Date:   Thu, 13 Aug 2020 07:57:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAP8UFD1rDZOQSDWhc+xdEQVX+Umq-nE-sd-orgKZ3UWTWFHJhw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7M3nOlm3fQmrkafkI9wFg8rCGaIUc9D22TKJ67SPwb7Gr0jymNf
 w/RVcXi0kCw26k1B21HGLX9dUp+s7U6ce2zZwUGnrw5ZENyTuIE2cV1rmHtCNw/qX8SRb7i
 r44ISsrSBMGPy3qNQKEGsW3QMIoBGFKAvAReuzGRAMwp+jxhlvPi3VbJ3h1LNMAEVCbZpHP
 0OVVfWp37DBMLOGGtpTBg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UjKCWs30GiE=:RNOwFarAPOL+DOUdAkyLZR
 WHSuklVsgzT5lVwhBWLbXBKNnVIm3UCrH5RxJLu4jJa09iGkgqeChOcwQRLVbBSupbgA004uf
 IDaInZty7F4WtE5ner/x3GYOIqgPoJZV3s8PwFkCyI9B9eKYNBKZDMB+hPk22ECg9Njphsi/b
 FhS4sWR7MVoXAe73oxFld8LHC90rTEwzKq/djtSYSWbhuzz6T6kFC7YljBdp9ePb2/Aj5W69d
 ExQN0dmZQwYQ0GGgGaik2TugHYJAEyGmbV1gYyoXQfsA1RKvZGL7N4GtlLKSypoXZgARXZqL5
 hSx3HO9PjQi0szaHj2/241EuZ3n/HONV6zDnJ+qIB1p6gR7WbA66roUiAZjFDkhNY+DdH+Fx1
 N/1P5/fMkoHJE1nYBMTPPz6aiedwCn7gUP0zDhUCF1cYwhqnjVA31IW2ihTevbYJiaxQ81M6V
 9IHO23mCEOvRcSX4Jhh/pMT7m/Mlm7jI2Vw6H6tMSDPYkqm/9QXLoe+qTVgJTc9jQYbtXQFoY
 FuIJ4yxq0rBLTOcSgK0munhnsuPndeoNDpcfwHtceYyRiYPouZflRwhO4dpeWBBnmQnK8qysw
 jXZsvP7bLQCP4yxiQSoc8HNjKWDZb3vqlZsonjN+t0Ir49VLOTIcV85ACDr4mifvW9lNUeD5t
 RLpRYXB5EpABmAczTUAFXKFmrQFxOMGAuPcVyph5z31jrv4UqLn7D8mgsAQNzld25ROlY0tz4
 516B52VLe2mwIfUpVwAPcUbbsjq+dJjBP4UFoA7leL+tfOUQySWqD5KxV0fet1VScn3ANpT7c
 t+VkoZz6A+MiG9p4tvyxLMgNSD7RjkCQ6LspTlzKD3EcmacPpCeF6OetAjf0HnN/SNVmLOmxd
 wVxc2XjSmRVWs9GwNawG93suSMe3kJDVe/SO3mtC/equqfAKMn7M0PmQ7RTzi6/iN7RFnC7uV
 7YQBvvJgGPkgkSoWcOqcaXE292puuEugkc7WqRc3pUF3ePLzAFcYZlm3JRiICwnWn55UuGC9Y
 FAzBDENf0bY7A+MpLx6Em/DZ4HKws9a9Q0QAi0QQlIkGAkR3cL1iCA5m1V154OjbyOS/nhpYX
 lpI/L3/KcYYLL6FVZMD+mXWDKvPj+/oiG52qpbBIRo+Ie9m9nthywME6R7F7SV4mVMh4KXYTz
 G4oo9Ed+HmAJBO0820FzxxYVwiQ91TN9BTODncYCjPtXVrpzjifXBQFwd7mGMx9gJf+SMnphu
 MUpeZrHaABowTg1S5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.08.20 um 07:17 schrieb Christian Couder:
> On Wed, Aug 12, 2020 at 6:54 PM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>
>> -       close(cmd->in);
>> +       if (ferror(cmd_in) || fflush(cmd_in))
>> +               goto error;
>> +       fclose(cmd_in);
>>         cmd->in =3D -1;
>
> I wonder if setting cmd->in to -1 is still useful...

The patch doesn't change its usefulness.  It probably was not necessary
to begin with.

>
>>         sigchain_pop(SIGPIPE);
>>

The next line right here (not shown in the diff) returns 0.

>> @@ -660,8 +658,8 @@ static int do_reachable_revlist(struct child_proces=
s *cmd,
>>  error:
>>         sigchain_pop(SIGPIPE);
>>
>> -       if (cmd->in >=3D 0)
>> -               close(cmd->in);
>> +       if (cmd_in)
>> +               fclose(cmd_in);
>
> ...as we don't check cmd->in anymore at the end of the function, but
> we now check cmd_in instead. So should cmd_in have been set to -1
> instead of cmd->in?

This error handler is not reached from the place that sets cmd->in back
to -1.  It can be reached from a place where cmd_in is still NULL, so
this check is necessary and setting cmd_in to NULL above is not needed.

Ren=C3=A9
