From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 02/10] unpack-trees: move all skip-worktree check back to unpack_trees()
Date: Tue, 16 Nov 2010 09:19:59 +0700
Message-ID: <AANLkTimO2fZ13BEL51GVTOChkzAD+jLm5HWAuc-+Rutc@mail.gmail.com>
References: <1289817410-32470-1-git-send-email-pclouds@gmail.com>
 <1289817410-32470-3-git-send-email-pclouds@gmail.com> <AANLkTi=cvt2W1Eqj7KmtM+ng-BS7wRTM=+49gq5n+ghs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 16 03:20:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIB9x-0006jL-VU
	for gcvg-git-2@lo.gmane.org; Tue, 16 Nov 2010 03:20:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759222Ab0KPCUY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Nov 2010 21:20:24 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:40252 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759184Ab0KPCUV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Nov 2010 21:20:21 -0500
Received: by wyb28 with SMTP id 28so182257wyb.19
        for <git@vger.kernel.org>; Mon, 15 Nov 2010 18:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=ONlsGs7Pg3VgaarWpFZ6HBOJ1WfOYelCrwEZng+EpUE=;
        b=rRMoahESEyGKD01ydmEkjwSx+fmiHPzgqIAy+zc32bz6hxTXs27uGJzB0bKa3xlDBR
         3lFlJCROLYIAs5/+o09OuBr9vwqjDeEi5EeeikOdSItteSVP7or+665gZKfzfApvoqrQ
         UP1t3hSW63KUzygjNepJepPApS02lxH7EaiLc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=tmAg6ME0odwE/9PZBKRTf09vpD0vMJoXXcyVIFli3j8aUzrVXplinwW95plwfbp7U5
         QUB4UXWrBPn/Vaz/ixq2cfZ6f9Eol4wfkb6d9ASkfN0HI1CMZM2K8QpMn7Rwjh0y4XW9
         +pHVkfScHVnxhCaKgprlUzjIYBySJFlpeTZjc=
Received: by 10.216.47.19 with SMTP id s19mr7456917web.56.1289874020236; Mon,
 15 Nov 2010 18:20:20 -0800 (PST)
Received: by 10.216.172.199 with HTTP; Mon, 15 Nov 2010 18:19:59 -0800 (PST)
In-Reply-To: <AANLkTi=cvt2W1Eqj7KmtM+ng-BS7wRTM=+49gq5n+ghs@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161530>

2010/11/15 Thiago Farina <tfransosi@gmail.com>:
> 2010/11/15 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>:
>> =C2=A0cache.h =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A01 +
>> =C2=A0unpack-trees.c | =C2=A0 69 +++++++++++++++++++++++++++++++++++=
+++++++++++++++-----
>> =C2=A02 files changed, 63 insertions(+), 7 deletions(-)
>>
>> diff --git a/cache.h b/cache.h
>> index 33decd9..d87708a 100644
>> --- a/cache.h
>> +++ b/cache.h
>> @@ -182,6 +182,7 @@ struct cache_entry {
>> =C2=A0#define CE_WT_REMOVE (0x400000) /* remove in work directory */
>>
>> =C2=A0#define CE_UNPACKED =C2=A0(0x1000000)
>> +#define CE_NEW_SKIP_WORKTREE (0x2000000)
>>
> Would be good to remove the () around the hex here and else in this f=
ile?

That was the tradition of CE_*. I don't know why () is there. Will do
a preparation patch to remove all () first.

>
>> =C2=A0/*
>> =C2=A0* Extended on-disk flags
>> diff --git a/unpack-trees.c b/unpack-trees.c
>> index 803445a..9acd9be 100644
>> --- a/unpack-trees.c
>> +++ b/unpack-trees.c
>> @@ -258,7 +258,7 @@ static int apply_sparse_checkout(struct cache_en=
try *ce, struct unpack_trees_opt
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0int was_skip_worktree =3D ce_skip_worktre=
e(ce);
>>
>> - =C2=A0 =C2=A0 =C2=A0 if (!ce_stage(ce) && will_have_skip_worktree(=
ce, o))
>> + =C2=A0 =C2=A0 =C2=A0 if (ce->ce_flags & CE_NEW_SKIP_WORKTREE)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ce->ce_flags =
|=3D CE_SKIP_WORKTREE;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0else
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ce->ce_flags =
&=3D ~CE_SKIP_WORKTREE;
>> @@ -834,6 +834,49 @@ static int unpack_callback(int n, unsigned long=
 mask, unsigned long dirmask, str
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0return mask;
>> =C2=A0}
>>
>> +static void set_new_skip_worktree_1(struct unpack_trees_options *o)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 int i;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 for (i =3D 0;i < o->src_index->cache_nr;i++) =
{
> Could you add spaces after ; for readability, please? There is anothe=
r
> for below that needs this to.
>

Yes. I kept reminding myself of doing that, then forgot.
--=20
Duy
