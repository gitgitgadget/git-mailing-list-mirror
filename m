Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127EDC433E0
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 14:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E334020775
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 14:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="ajDPHg8Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbgHCOBD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 10:01:03 -0400
Received: from mout.web.de ([212.227.15.14]:57621 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbgHCOBD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 10:01:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1596463256;
        bh=UDCxAUVPqXw7dY8uGzksSJ8n82ZDRiTTgFFGoB4FnlM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ajDPHg8ZCf9CTBEyRiDBzCa8MQL7aTTpU4+qDYkgJtYavbbGgJ5cLVlE5p7r7gtkq
         fMdkj82DkkqF/wEH06DgLMvlLZfqWWrRdv6g2q5wmgrRVMAAk1IdakSXpjrcFFogH9
         YDI/oongUtiSxOZECWn5/apbk6+NxWoVKYDtV2i4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.26.151]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MUU68-1kBV0K215s-00QQle; Mon, 03
 Aug 2020 16:00:56 +0200
Subject: Re: [PATCH] upload-pack: use buffered I/O to talk to rev-list
To:     Chris Torek <chris.torek@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <6722ade6-971e-7ecc-e8f0-7f595ca0b0ff@web.de>
 <CAPx1GvdJ-4Yyf7Vm1OdhaW2TZp77HOfGxoGw0R2fKfEuHQkqOg@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <87c4ab84-8db5-bd62-af66-fd88f788827b@web.de>
Date:   Mon, 3 Aug 2020 16:00:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAPx1GvdJ-4Yyf7Vm1OdhaW2TZp77HOfGxoGw0R2fKfEuHQkqOg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zwueUrGevI9ipbiiaDKPis8CimchMZ++5QGTDjlwSZinCat3uWX
 RkEek6U56Y3P6vuk9hGK2lfRU6SXv9ooGa1khE58vQad99fhtvu05QNtMU2MAiXZ8sxJ06r
 iWrcgZvWL5IuhbC2WfGIsSaCWCY1N+gGh3CS4wcbLr2GPOsslCdkf/rdtLyWQjtv+tJsjv+
 HXxAIBNOzhKuFbYEJfC7w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5SxNEyMYI9I=:7q7ISNwbaSEYAfLwds/I7D
 QhL+qh8JZliuvhTY5omWJO0rhfkRD5MPW6zdxM/Nr0+nyL9LBE/zUaVIJQzjZ/hbsOnF9kXKu
 YNtNNakDXpBSE6VSXPCVITrRjU4tdqrkIYq2f1+aXye56tZR1mQdFwzkwSmOhtJ7wGzesZ4/4
 itanRBv984RQXAkSmItTtCVhrQZHrR4QpryHfLhCfK9/bJduQQpA/LfLpmNJFk4HDx1bftE7q
 tDP5TQuVy+rjX2/I4u2fG6UfiCeqRviL53PoEa/oTVPhQ8ZjuejFb13fRY1AxPt6xAIvzlshT
 0vzYYDgS87SM9A7Ug0eT3Z7vF7le6FnoJmmavcnuJDmhAIYiFsG0VYTWvJdmQSNkqSt2kIECp
 iImsikovhPcsagZMNwm2x6Sl767nV6nmUBfPQasFe1+F8dG131h1786AW+TMkYlNRf7dFS6hr
 z7l2xW51o4bmSGueSno2ECUEmzDk8xrJyaK1hxUm5ogvUuLUjiIB1AG3gLxje086UQx8+BsTM
 yrtzNHFPDiD+DYi3hdrwp6bHQFsx7ILCdHuEQfqYF1u+3/PArPb2sJ8DvpBc01qHyADiFDSN/
 If1G/dQbRzo9hMaz7hj1/njyYvDdVc7zqjTa/y4muzzbrvlP0PzSw8XBWc6MJJmKEZPNfKD/p
 /7hBiefo/1PCL15XThMs41WhqEZg/208L+isFCdw0cBypHPK1f+b0OI6lQmSI1FdJbSI0HIPU
 PAxAbb1nbogvs/mLb0ZZPx/LDrXVuV7LmmxKl+i4qUgEjPeYWoXuhAkMa1mNpsxQB1+wC3/tq
 0ag2nqgGzdu/ohHZ1rcLxjBbs8RGfETSxHTOJVqURRWaDfJ6pTpwyTVGggNMyT54kDD3bdnfo
 EGxYt3Hpbtgh58NLuj/FY1a6StV1v30KdP8UveXeREnApjw1NHtfkXcTMGZ9BWkHx+8ZikE/I
 WB0X9iIAX9E6KpYiFFx+WJflE8lrurRM/hpoW7aV02GShhHDRoV6t/VL0sTmoQCfaKMBDHGC0
 ege2ddh60dg/cGYggi1vEaPJJMC5q9lw+vhEtTt/c5ro7pLbFCy3VC6fc9+PlOwR+Vr9eYrVl
 27RSlBDbepriikk1lgtgRHhvr3GqaRZYmdYkOxlX8aNaRLtYhJD+PapKlxPGuZEYWCBxYvp0S
 ogCxpuq7DwAVTtIuVej52XNNcKvU1NYWOBmpz8K7NEmp4hY7MQGVRFBCgu5PaPMg/timgyY7W
 uYZx9NuePgtXv/hAO
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.08.20 um 18:03 schrieb Chris Torek:
> One suggestion here:
>
> On Sun, Aug 2, 2020 at 7:41 AM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>> Like f0bca72dc77 (send-pack: use buffered I/O to talk to pack-objects,
>> 2016-06-08), significantly reduce the number of system calls and
>> simplify the code for sending object IDs to rev-list by using stdio's
>> buffering and handling errors after the loops.
>>
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>> ---
>>  upload-pack.c | 21 +++++++--------------
>>  1 file changed, 7 insertions(+), 14 deletions(-)
>>
>> diff --git a/upload-pack.c b/upload-pack.c
>> index 86737410709..9f616c2c6a6 100644
>> --- a/upload-pack.c
>> +++ b/upload-pack.c
>
> [snip]
>
>> @@ -640,12 +636,11 @@ static int do_reachable_revlist(struct child_proc=
ess *cmd,
>>                 }
>>                 if (reachable && o->type =3D=3D OBJ_COMMIT)
>>                         o->flags |=3D TMP_MARK;
>> -               memcpy(namebuf, oid_to_hex(&o->oid), hexsz);
>> -               if (write_in_full(cmd->in, namebuf, hexsz + 1) < 0)
>> -                       goto error;
>> +               fprintf(cmd_in, "%s\n", oid_to_hex(&o->oid));
>
> The fprintf() call here *can* return an error, e.g., if the
> connection has died.  If it does, it should set things up so that
> a later ferror(cmd_in) returns true.
>
>>         }
>> -       close(cmd->in);
>>         cmd->in =3D -1;
>> +       if (fclose(cmd_in))
>> +               goto error;
>
> The fclose() call doesn't necessarily check ferror().  (The
> FreeBSD stdio in particular definitely does not.)  It might
> be better to use:
>
>     failure =3D ferror(cmd_in);
>     failure |=3D fclose(cmd_in);
>     if (failure) ...
>
> here, or similar.  (The temporary variable is not needed,
> but someone might assume `if (ferror(fp) | fclose(fp))` is
> a typo for `if (ferror(fp) || fclose(fp))`.)

Thanks, didn't know that.  That's awful.  So the sentence "The fclose()
and fdclose() functions may also fail and set errno for any of the
errors specified for fflush(3)." from the FreeBSD manpage for fclose(3)
actually means that while it will flush, it is free to ignore any
flush errors?

Or do you mean that fflush() can succeed on a stream that has its error
indicator set?

In any case, we'd then better add a function that flushes the buffer,
closes the stream and reports errors in its return code and errno --
i.e. a sane fclose().

Ren=C3=A9

