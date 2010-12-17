From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 14/21] Convert ce_path_match() to use struct pathspec
Date: Fri, 17 Dec 2010 16:59:52 +0700
Message-ID: <AANLkTikKCU==mS5_TdqHstETj=CQ_deHMCJ4xW0r+Sck@mail.gmail.com>
References: <1292425376-14550-1-git-send-email-pclouds@gmail.com>
 <1292425376-14550-15-git-send-email-pclouds@gmail.com> <7v39pxl10y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 17 11:00:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTX7K-0008GH-Sr
	for gcvg-git-2@lo.gmane.org; Fri, 17 Dec 2010 11:00:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753230Ab0LQKA0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Dec 2010 05:00:26 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:56752 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753210Ab0LQKAX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Dec 2010 05:00:23 -0500
Received: by wyb28 with SMTP id 28so441339wyb.19
        for <git@vger.kernel.org>; Fri, 17 Dec 2010 02:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=wO0YRdtQH6YspE41Pi8bcsEBgns9e5lrkgNcUhleaDw=;
        b=PnAy1toFmzPwbjVKUaWzQG7WHgkIIDz30id2mZmPmfYNZL4uCD66TlYwpixgbETpjb
         GHQlnr9BVfZQeJy23Ym0/KOsi6fd5YKk+2W5ilwfl62lZKwQprwaiF0pz+ue5AIKIQm/
         ZRjYiUuhluqCrtRUlNKXY4lwFjILk4XpjHLpI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ax/OXAqdLypTuidhvzgfpUYGRAYOp9q7/Z4upSBBZAfdYTFciJBQxF9BwCuQTylepE
         ilzI0DQx43K/X82JAj4J1R/tkvdYYhwQj/0TgKZlrQDo/sqbzbRojP0fVLhH4EuRzP1h
         rK2GNXWuINWQuNMUi+kWPrIuqGg5iD60KZKFw=
Received: by 10.216.142.101 with SMTP id h79mr855312wej.49.1292580022297; Fri,
 17 Dec 2010 02:00:22 -0800 (PST)
Received: by 10.216.158.83 with HTTP; Fri, 17 Dec 2010 01:59:52 -0800 (PST)
In-Reply-To: <7v39pxl10y.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163869>

2010/12/17 Junio C Hamano <gitster@pobox.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> w=
rites:
>
>> diff --git a/diff-lib.c b/diff-lib.c
>> index 3b809f2..63db7f4 100644
>> --- a/diff-lib.c
>> +++ b/diff-lib.c
>> @@ -89,9 +89,11 @@ int run_diff_files(struct rev_info *revs, unsigne=
d int option)
>> =C2=A0 =C2=A0 =C2=A0 int silent_on_removed =3D option & DIFF_SILENT_=
ON_REMOVED;
>> =C2=A0 =C2=A0 =C2=A0 unsigned ce_option =3D ((option & DIFF_RACY_IS_=
MODIFIED)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ? CE_MATCH_RACY_IS_DIRTY : 0);
>> + =C2=A0 =C2=A0 struct pathspec pathspec;
>>
>> =C2=A0 =C2=A0 =C2=A0 diff_set_mnemonic_prefix(&revs->diffopt, "i/", =
"w/");
>>
>> + =C2=A0 =C2=A0 init_pathspec(&pathspec, revs->prune_data);
>
> I wonder if it makes more sense to change the type of revs->prune_dat=
a
> from an array of pointers to strings to a pointer to struct pathspec.
> Is there a downside?

Converting a pointer to another pointer means mis typecasting can
happen and the compiler won't help catching them. I thinking of
changing prune_data to simply struct pathspec. Looks like it breaks
thing.. hm...
--=20
Duy
