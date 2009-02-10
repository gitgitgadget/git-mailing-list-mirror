From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv2] lis3lv02d: support both one- and two-byte sensors
Date: Wed, 11 Feb 2009 00:51:25 +0100
Message-ID: <cb7bb73a0902101551o30dde0aesaeba399f1ab732af@mail.gmail.com>
References: <1234309249-13672-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <499211D0.3090705@tremplin-utc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Pavel Machek <pavel@suse.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: =?ISO-8859-1?Q?=C9ric_Piel?= <Eric.Piel@tremplin-utc.net>
X-From: git-owner@vger.kernel.org Wed Feb 11 00:52:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LX2PS-0005ee-83
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 00:52:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755389AbZBJXva convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Feb 2009 18:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754153AbZBJXv3
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 18:51:29 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:61592 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753620AbZBJXv2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Feb 2009 18:51:28 -0500
Received: by ewy14 with SMTP id 14so267095ewy.13
        for <multiple recipients>; Tue, 10 Feb 2009 15:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Ak+/pMClaXNrdvuspCXcaSUz3ysah9UHvQ3/ai+NnsY=;
        b=FFjRS/KEACJ00lP+heKn/9ndcBNv0HPruYTGgthJpNhe4cKMpcO/l5VQU3Zw098ZXj
         POOF9N2GiSTuqu9PNXBMoql7QnIS9TY7zunGXuxVm1JqdT0uBInu81hkYsM4Ym1rED6p
         qyvHuKY0oXJFTUmOUVYyJv14C40tKudPwgrkI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BCulZ1Bw9UMfw1xANFZWU/oKcBDVXB8Ji2kyMwjaTJABNVV+7FbFHzYvBZa206TNg8
         vKmFD4vbPdxCs1E7Cl0N9rNC2Sa6IDrmup437mrJkHkNWROPSjR5tDdfBInC0o5iRPaq
         MBCV9VfBHFoGh392nrPeCTiMdGDR9BIlmcc7A=
Received: by 10.210.57.12 with SMTP id f12mr3061523eba.164.1234309885949; Tue, 
	10 Feb 2009 15:51:25 -0800 (PST)
In-Reply-To: <499211D0.3090705@tremplin-utc.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109350>

On Wed, Feb 11, 2009 at 12:46 AM, =C9ric Piel <Eric.Piel@tremplin-utc.n=
et> wrote:
> Giuseppe Bilotta schreef:
>>
>> Sensors responding with 0x3B to WHO_AM_I only have one data register=
 per
>> direction, thus returning a signed byte from the position which is
>> occupied by the MSB in sensors responding with 0x3A.
>>
>> We support both kind of sensors by checking for the sensor type on i=
nit
>> and defining appropriate data-access routines and sensor limits (for=
 the
>> joystick) depending on what we find.
>>
>> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
>> ---
>>
>> This is the other version of the patch, and it changes access to use=
 the
>> base address from the 8-bit, so the 16-bit routine is changed to acc=
ess
>> the PREVIOUS byte for the LSB.
>>
>> Choose whichever of the patches is deemed more correct 8-)
>>
>> Note that both patches are based off Linus tree, so I don't know how
>> they cope with Pavel's "don't touch too much on init" one. I'll try =
to
>> work out a patch on top of that too.
>
> Yes, great, and this one looks even better than v1 :-)

And don't forget about the v3 for -mm ;-)

> However I'm not sure about the conversion between s8 and s16:
>
>> +static s16 lis3lv02d_read_8(acpi_handle handle, int reg)
>> +{
>> +       u8 lo;
>> +       adev.read(handle, reg, &lo);
>> +       return *((s8*)(&lo));
>> +}
>
> Does it really extend the sign to 16 bits? I would have written it th=
is way:
> +static s16 lis3lv02d_read_8(acpi_handle handle, int reg)
> +{
> +       s8 lo;
> +       adev.read(handle, reg, &lo);
> +       return (s16)lo;
> +}
> Doesn't it work better?

Well, the previous one works, but I admit it's horribly convoluted.
I'll double check with this one and resubmit (I'll only resubmit the
one based on Pavel's "don't touch anything on init" probably though,
hope it's ok)


--=20
Giuseppe "Oblomov" Bilotta
