From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 05/10] archive-tar: allow to accumulate writes before
 writing 512-byte blocks
Date: Wed, 2 May 2012 21:43:08 +0700
Message-ID: <CACsJy8D5P9EESqwJLqa3Ragixr-TFJby4h4FgqOxm1jC8L9aHg@mail.gmail.com>
References: <1335965122-17458-1-git-send-email-pclouds@gmail.com>
 <1335965122-17458-6-git-send-email-pclouds@gmail.com> <4FA14497.5090203@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Wed May 02 16:43:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPamQ-0006IO-2K
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 16:43:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753807Ab2EBOnl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 May 2012 10:43:41 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:55485 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752434Ab2EBOnk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 May 2012 10:43:40 -0400
Received: by were53 with SMTP id e53so439782wer.19
        for <git@vger.kernel.org>; Wed, 02 May 2012 07:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=xfR3D1kprSCx2zHGj1Gfoerd4jXfvC6+zV5bgtheQhY=;
        b=hjI2tm9KunDBXD6LYeHOTnPOLC1IYCak6GJr2yHtmC5JyEPk55YxDWiTWtg2eJr41U
         EkLvZtaVCIRcn9uZwoZF3EI7uXNRetwiJz8CeI7CQEhIie/SxHR8Ah6ZLahAGUF0egJE
         470jt8aPqMfSmoeA/AJKQpYyQqXdWRBaJjbG7r8wgyeCmCWuGh5NFiICjRcr+bxdRc8Q
         DqfPmz2IQoI19VF6mTDbNBEUs9K3Uffw1axl9xgigUbdzRgzaNXwiytS20ZTgGo+HWWT
         NIwSfQYSWm1EkRQZm0YNV+iX80IGyYjmSrX6pEP+U9L1PV1OXeFHzcRFSk/TYjLwyL0c
         ebQA==
Received: by 10.216.145.153 with SMTP id p25mr894069wej.112.1335969819072;
 Wed, 02 May 2012 07:43:39 -0700 (PDT)
Received: by 10.223.14.193 with HTTP; Wed, 2 May 2012 07:43:08 -0700 (PDT)
In-Reply-To: <4FA14497.5090203@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196832>

On Wed, May 2, 2012 at 9:28 PM, Ren=C3=A9 Scharfe
<rene.scharfe@lsrfire.ath.cx> wrote:
> Am 02.05.2012 15:25, schrieb Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Du=
y:
>> This allows to split single write_blocked(buf, 123) call into multip=
le
>> calls
>>
>> write_blocked(buf, 100, 1);
>> write_blocked(buf, =C2=A023, 1);
>> write_blocked(buf, =C2=A0 0, 0);
>>
>> No call sites do this yet though.
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy<pclouds@gma=
il.com>
>> ---
>> =C2=A0 archive-tar.c | =C2=A0 16 +++++++++-------
>> =C2=A0 1 files changed, 9 insertions(+), 7 deletions(-)
>
> Hmm, I'm not a fan of adding binary parameters to distinguish between=
 two
> modes of a function. =C2=A0It's usually better to split it up at that=
 point.
> E.g. the patch below does that and still provides the old interface, =
i.e.
> the existing callers don't need to be changed.

Good point. Then this can be merged to the next patch too.

> =C2=A0archive-tar.c | =C2=A0 15 +++++++++++++--
> =C2=A01 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/archive-tar.c b/archive-tar.c
> index 20af005..a2babe1 100644
> --- a/archive-tar.c
> +++ b/archive-tar.c
> @@ -30,10 +30,9 @@ static void write_if_needed(void)
> =C2=A0* queues up writes, so that all our write(2) calls write exactl=
y one
> =C2=A0* full block; pads writes to RECORDSIZE
> =C2=A0*/
> -static void write_blocked(const void *data, unsigned long size)
> +static void do_write_blocked(const void *data, unsigned long size)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *buf =3D data;
> - =C2=A0 =C2=A0 =C2=A0 unsigned long tail;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (offset) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long =
chunk =3D BLOCKSIZE - offset;
> @@ -54,6 +53,12 @@ static void write_blocked(const void *data, unsign=
ed long size)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy(block +=
 offset, buf, size);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0offset +=3D si=
ze;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> +}
> +
> +static void finish_record(void)
> +{
> + =C2=A0 =C2=A0 =C2=A0 unsigned long tail;
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0tail =3D offset % RECORDSIZE;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (tail) =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memset(block +=
 offset, 0, RECORDSIZE - tail);
> @@ -62,6 +67,12 @@ static void write_blocked(const void *data, unsign=
ed long size)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0write_if_needed();
> =C2=A0}
>
> +static void write_blocked(const void *data, unsigned long size)
> +{
> + =C2=A0 =C2=A0 =C2=A0 do_write_blocked(data, size);
> + =C2=A0 =C2=A0 =C2=A0 finish_record();
> +}
> +
> =C2=A0/*
> =C2=A0* The end of tar archives is marked by 2*512 nul bytes and afte=
r that
> =C2=A0* follows the rest of the block (if any).



--=20
Duy
