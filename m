Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB74C433E0
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 22:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71A3F20722
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 22:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="VyCQrn3W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgHCW2D (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 18:28:03 -0400
Received: from mout.web.de ([212.227.15.4]:40593 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgHCW2C (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 18:28:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1596493677;
        bh=SRvXdQ24OfMGMQYqNmU+/SuhG5y5UaPp8X800xPR+kI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=VyCQrn3W6gGU3KsjM7AzgdRtq3VInxj/xGMtvG1WtRqCM2csQoLyFqwb5uguTrnbe
         KrsFeJF/ZiKYxanN707UZ1gFjDXxtkK/nq9lmKPJjXwuWg+6tGzxndGzbkEq6mKSEa
         bSinXNpXEik4dDXI8AuiRXfRZHm/7RN9jEgBlABU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.26.151]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M28SL-1k0mzU0P2f-002ZPO; Tue, 04
 Aug 2020 00:27:57 +0200
Subject: Re: [PATCH] midx: use buffered I/O to talk to pack-objects
To:     Johannes Sixt <j6t@kdbg.org>, Chris Torek <chris.torek@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <c5920e08-b7dd-e870-f99e-225d0aafc663@web.de>
 <CAPx1GveChRzsA=FayzhZRSQLPz+o1Po3-_9ZvAGLPztpH5Jg9w@mail.gmail.com>
 <1fd18b0c-8c2c-54ab-89aa-357b046eb403@kdbg.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <fdf66f66-b7ed-f733-22d0-23ec17209f40@web.de>
Date:   Tue, 4 Aug 2020 00:27:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1fd18b0c-8c2c-54ab-89aa-357b046eb403@kdbg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mH1sRFBRE8/Jj0tJsU7IFw76+nwK9UCtZmgu4KQmmlMwVlf++vg
 AaCYT8p4BQGLlZpa79ZCRKuZlKkuKCoves6YrB7R/IWteJbtxPB4lxm+qBdeyvaXnvkBp+B
 0x7Q2BqY4tNTdQIiSGVxqGN3WqQlfRWNO1sBZ3qNNslzUtjMtWvW83fTT3btfYjyZTByVc/
 QyWqgonxOD3wzoaFEQNdA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PZCYiSwZUHA=:RA/9GoiX7EjEkZ99yTuZs/
 mui9QBddLPeckdj+yP4yq7mQO8CjD3eVnwJXPBBTR45Fr9pNk1J9fY+QQ+wNceoDc4c5FmTm9
 domEBjbMe9B1+3I7owQ+hyt3OMLIPTdcXfuKbO6Qg7C1cnAFkvMp8UqzxErIkNJ0QJWVCb5fz
 nuD1F/WpcOtRI1JsHZJ02sOuZTkfc+D5qCoKxHTBcHZdee9WkBOwG0PTzSFR7JfBgswod4CD2
 RxgIMK+SZdlFa9LKVQfoLFj6N+toPjcPprsT04HYg+QrKQWvCIx19/gaLfqSIad2TkEI30caK
 PFwb+L1BytjmVak7mzxdZEvJr09SKymglYunRKky9hszEHdJO1X6U64QJC8b+fPBtCKxcbksO
 0h01Nm/qLPxwUjc1duVFIMxa/LpBiItsa1t9t2oYz1pHyV1f5eH965NCgdGAlCdsWrnIVp552
 ydZtIQCIhzcMa1dmZB42Mk9OjW4NkgDUsvKmQzlupNzrfvzsAIO+cCKmBt29rO4W5FIxizoO3
 0Bm3iCyLHuO31Jv0E/YUzTyr7KII37EvPAbC6Tjdch2NGna3rjnz/hpxN7iPuO/I9mpS+2h7W
 ySsT5W2MYAJW/nGp7JIuGcofzdXTo19SrSajTaDe7IrxGsE2n8eIsmkKZHz65jtFpbNBElM+g
 gHl3pashFoZnMUHPEBJnVsQpZTC8v8QNSV5q6WjBllpVfW7PFMUQ8RVuUgewN/TNDv698Z88j
 gXa6V5ilyfOiiUEEBXUe2rxqEcI9sg9TcjJyHrHLBG8BBwtUWKFJlhm6j0ycnabYaRK6wISeu
 b7CxyuYDQX9M2YBOi1wuBKiumZSrF1evOGMmSmvia2rGwfdq52prHUYi53f2wFY0ZFpLwWzTR
 tV2faD1PRhEawi8P0tmncOYxn+2jJsvX8+kuZvVStcF7CFM0TK+aUJGsVHLj7yPNiHIAtFtXu
 PRVVTGNoDxgHOMVEnynn/ebXWjApuyc1C6LemHLTspJBtQbQ7+Tk1JfjmmgzsNaeWfisybjbm
 DCYpZbZFCjJjs6l+4vzfMGGgG2dh7lZPOHYjRQPrnU/0c52Gpptfkl19nTZlDzeF6qtkbPuoi
 5IUnUNayu86f/e06DDA3qBL/w99tWdX5FPzzvd502Bh+kDYC0RD9cVAbgi3p5WKz1W5aWp/NZ
 TiNPIG+uuJkjmQusB7UdXYJj+26IDVJwwN2yZmev3W8La85Yj0h1JZCULIGvgk1tlel2SGAl0
 ZCk7OJS38anVmNhuW
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.08.20 um 20:10 schrieb Johannes Sixt:
> Am 02.08.20 um 18:11 schrieb Chris Torek:
>> On Sun, Aug 2, 2020 at 7:40 AM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>>> @@ -1443,10 +1446,15 @@ int midx_repack(struct repository *r, const ch=
ar *object_dir, size_t batch_size,
>>>                         continue;
>>>
>>>                 nth_midxed_object_oid(&oid, m, i);
>>> -               xwrite(cmd.in, oid_to_hex(&oid), the_hash_algo->hexsz)=
;
>>> -               xwrite(cmd.in, "\n", 1);
>>> +               fprintf(cmd_in, "%s\n", oid_to_hex(&oid));
>>> +       }
>>> +
>>> +       if (fclose(cmd_in)) {
>>> +               error_errno(_("could not close stdin of pack-objects")=
);
>>> +               result =3D 1;
>>> +               finish_command(&cmd);
>>> +               goto cleanup;
>>>         }
>>> -       close(cmd.in);
>>>
>>>         if (finish_command(&cmd)) {
>>>                 error(_("could not finish pack-objects"));
>>> --
>>> 2.28.0
>>
>> Here, we don't have any explicit errno checking, but
>> of course error_errno() uses errno.  This too needs
>> an ferror() (or fflush()) test before the final fclose(),
>> and then we just need to use plain error().  Otherwise
>> you'll need the clumsier test-after-each-fprintf() and
>> an explicit final fflush()-and-test.

OK, the implicit fflush() called by fclose() and thus fclose() itself
can succeed even if the error indicator is set, in particular if that
fflush() has nothing to do.  So we need to check ferror() before calling
fclose().

If ferror() tells us there was an error, errno might contain some random
error code, but not necessarily the root cause.  Thus we better keep
quiet about it and only use error() to tell the user we failed to talk
to our child but we don't know why.

We could fflush() explicitly before fclose(), but fclose() reports any
failure of its implicit fflush() anyway , so we don't gain anything by
doing so.

Did I get that right?

> We need this explicit test after each fprintf anyway because SIGPIPE may
> be ignored, and then writing fails with EPIPE. On Windows, this is
> doubly important because we do not have SIGPIPE at all (and always see
> EPIPE), but we see EPIPE only on the first failed write; subsequent
> writes produce EINVAL.

Why is this important?  The current code doesn't care about it, at
least.  It does care about EINTR, though.

Ren=C3=A9

