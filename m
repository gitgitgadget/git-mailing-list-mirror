From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] rerere: fix memory leak if rerere images can't be read
Date: Tue, 23 Feb 2010 22:56:20 +0100
Message-ID: <36ca99e91002231356u189b80ebka7ae8caf89ab9c10@mail.gmail.com>
References: <1266955913-4943-1-git-send-email-bert.wesarg@googlemail.com>
	 <alpine.DEB.1.00.1002232225480.3980@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 23 22:56:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk2k2-0000Z8-3s
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 22:56:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754209Ab0BWV4X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Feb 2010 16:56:23 -0500
Received: from mail-bw0-f209.google.com ([209.85.218.209]:40984 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754020Ab0BWV4W convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Feb 2010 16:56:22 -0500
Received: by bwz1 with SMTP id 1so1444531bwz.21
        for <git@vger.kernel.org>; Tue, 23 Feb 2010 13:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7/DNoBtRJou/9qaXxsi/yjVaE/L+Iq1SO6k9w/Tyc0Q=;
        b=r6wgSAX6Yf7BcZWpe/py1rFJfY4nNPZPeKu+Xv8peHV02TUErg1hAS5RFcQoynjrKQ
         9uu6+o76IVpCFog+YbBjRNlRHJtSr2yUC7BtxT06XpkQyXFCebkXGaIg9Xh9Q5hEAj9G
         q59hQBlaiuFoXwP/eCEj9ePeCVTc2Oz2WEV7c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=p/4p6hny7JFikiy3ZHtct7xyKgF2w7DcSNujR/fDpRftr1NAeHnhAE1ZSgKSpIyEj9
         UyUqL8ep1slInPlSdtO+kRZxhLinooMiGBgMZXt8aqKR6ZVTC/I/fhRberFVIHoQ0J6Y
         6L3E9zTwe4sa6Um99Lm8G02z9eOVoosdmVt78=
Received: by 10.204.13.69 with SMTP id b5mr3266271bka.196.1266962180863; Tue, 
	23 Feb 2010 13:56:20 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1002232225480.3980@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140849>

On Tue, Feb 23, 2010 at 22:26, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Tue, 23 Feb 2010, Bert Wesarg wrote:
>
>> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>> ---
>> =C2=A0rerere.c | =C2=A0 =C2=A06 ++++--
>> =C2=A01 files changed, 4 insertions(+), 2 deletions(-)
>
> Looks good to me, except...
>
>> diff --git a/rerere.c b/rerere.c
>> index d1d3e75..9ca4cb8 100644
>> --- a/rerere.c
>> +++ b/rerere.c
>> @@ -364,16 +364,17 @@ static int find_conflict(struct string_list *c=
onflict)
>> =C2=A0static int merge(const char *name, const char *path)
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 int ret;
>> - =C2=A0 =C2=A0 mmfile_t cur, base, other;
>> + =C2=A0 =C2=A0 mmfile_t cur =3D {NULL, 0}, base =3D {NULL, 0}, othe=
r =3D {NULL, 0};
>> =C2=A0 =C2=A0 =C2=A0 mmbuffer_t result =3D {NULL, 0};
>>
>> =C2=A0 =C2=A0 =C2=A0 if (handle_file(path, NULL, rerere_path(name, "=
thisimage")) < 0)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;
>>
>> + =C2=A0 =C2=A0 ret =3D 1;
>
> This initialization can come earlier, at declaration time.
I thought about it, but I think it is clearer to put just in front of
the condition which may fail.

Bye,
Bert
