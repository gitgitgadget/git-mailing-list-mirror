From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] Rewrite bulk-checkin.c:finish_bulk_checkin() to use a
 strbuf for handling packname
Date: Fri, 28 Feb 2014 15:47:11 -0500
Message-ID: <CAPig+cT8ziBV3w9gTR_GM=xupmJiZ=2hvizagk+SR3GY_wMGUw@mail.gmail.com>
References: <1393576104-1758-1-git-send-email-sunheehnus@gmail.com>
	<CAPig+cSvkmZH2qEqKd=sjaMO8bfnxiKiuTKtfOuMCDwDfCDciw@mail.gmail.com>
	<CAJr59C2Uw+tnRSuHbMnyJjGSE+XNpepPdode5MvcHb4X31e+qQ@mail.gmail.com>
	<CAJr59C1ezbeG5+x2VHCnxbfATXgVO1gq9+b3amgvKUqZa0Swkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: =?UTF-8?B?5a2Z6LWr?= <sunheehnus@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 28 21:47:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJUL2-0006NQ-T5
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 21:47:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752387AbaB1UrP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Feb 2014 15:47:15 -0500
Received: from mail-yh0-f43.google.com ([209.85.213.43]:41430 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751849AbaB1UrM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Feb 2014 15:47:12 -0500
Received: by mail-yh0-f43.google.com with SMTP id b6so905618yha.16
        for <git@vger.kernel.org>; Fri, 28 Feb 2014 12:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=v51u6YUo0/UjPtoADN9F7YoKmZANrA1NCGVm2syLtno=;
        b=XNWu1+GvA5ZR4rhxKZ9w35uXmPPJtEzD1krduDSVDyMC5p7iVKGG7zjTk2bAQKYo9w
         0jhZz7Gc50HSepXurpwJZEjQeF6ZQuNJGRsVcFGIN7uXpaynjcmZR9kGnX/NaiJGUrQK
         CNkKokk9ou/uFwpaDWV3uz0v6d/+S2PI3SvIRXQtuyh4xhbMupROmKObwo/dc8D1RMPa
         PBVuR2yGJl0+qsb+WAiXdNXUWXs8xk9nPbtlovxZLf/qAEtlja1sfxD/7yEuuas856fJ
         5k1pZJeL5jZxipfzkj990UIQamuEUTrFssIIfgkN0wDbLXFxdj3mjzLpl74K7Ha9QwyD
         7t7g==
X-Received: by 10.236.152.36 with SMTP id c24mr3951473yhk.118.1393620431785;
 Fri, 28 Feb 2014 12:47:11 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Fri, 28 Feb 2014 12:47:11 -0800 (PST)
In-Reply-To: <CAJr59C1ezbeG5+x2VHCnxbfATXgVO1gq9+b3amgvKUqZa0Swkg@mail.gmail.com>
X-Google-Sender-Auth: Iz_vRKxwRDwZlL7bn5kqdr1d0Vs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243015>

On Fri, Feb 28, 2014 at 10:54 AM, =E5=AD=99=E8=B5=AB <sunheehnus@gmail.=
com> wrote:
> 2014-02-28 17:47 GMT+08:00 Eric Sunshine [via git]
> <ml-node+s661346n7604473h64@n2.nabble.com>:
>> On Fri, Feb 28, 2014 at 3:28 AM, Sun He <[hidden email]> wrote:
>>> Signed-off-by: Sun He <[hidden email]>
>>> ---
>> > diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
>>
>>> index c733379..72fb82b 100644
>>> --- a/builtin/pack-objects.c
>>> +++ b/builtin/pack-objects.c
>>> @@ -803,7 +803,7 @@ static void write_pack_file(void)
>>>
>>>                 if (!pack_to_stdout) {
>>>                         struct stat st;
>>> -                       char tmpname[PATH_MAX];
>>> +                       struct strbuf tmpname =3D STRBUF_INIT;
>>>
>>>                         /*
>>>                          * Packs are runtime accessed in their mtim=
e
>>> @@ -823,26 +823,22 @@ static void write_pack_file(void)
>>>                                 utb.modtime =3D --last_mtime;
>>>                                 if (utime(pack_tmp_name, &utb) < 0)
>>>                                         warning("failed utime() on =
%s:
>>> %s",
>>> -                                               tmpname, strerror(e=
rrno));
>>> +                                               pack_tmp_name,
>>> strerror(errno));
>>
>> Good catch finding this bug (as your commentary below states).
>> Ideally, each conceptual change should be presented distinctly from
>> others, so this bug should have its own patch (even though it's just=
 a
>> one-liner).
>>
>
> OK. Should I send this patch?

Yes, it is perfectly acceptable (and encouraged) to send this patch as
a submission distinct from your microproject.
