From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] strbuf: allocate enough space when strbuf_setlen() is
 called first time
Date: Tue, 26 Apr 2011 22:32:31 +0700
Message-ID: <BANLkTi=ECjmjBLfS=s6fMWXgtxDYmxcP5g@mail.gmail.com>
References: <1303820660-744-1-git-send-email-pclouds@gmail.com> <7v7hahghls.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 17:33:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEkGD-0005ja-SG
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 17:33:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756929Ab1DZPdE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Apr 2011 11:33:04 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39105 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756169Ab1DZPdC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2011 11:33:02 -0400
Received: by fxm17 with SMTP id 17so512040fxm.19
        for <git@vger.kernel.org>; Tue, 26 Apr 2011 08:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=ma0gbSfHaQwQ2YfIyfnbjKrnUuzfBWNxhkYQqpYiDTk=;
        b=kMvLSxIeOvUEedM4Jjwu+/BcG+1u3fxbPSg2eYz02c544mDte0hFqo69pYf+dEYsw3
         iG4FLLN30up2hhiuqnaTe3FuTjTOfe74Fxg4Rq2P0/0Q9tx41sxfKRRSufZbx/8vztQf
         FImMPjroqe50ALBj9Rjs2iYUytt6gKsnHlvXk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=k9YGE61RNs1XRHV4Wpckce+sBbZ3RQNCt7gizzvpalr6uZLLj/G5QdcnDHYTguvDuK
         ImTA01JG2jTS0V887IaZkEWqqCiigEf2uwCCP6Qo37Cu5/jc9LstCcfv4G/QGvPFP8qP
         Gv/lPDq8WFpHeDNHsRh21ly1u5ju7GqiKvwuQ=
Received: by 10.223.98.141 with SMTP id q13mr986993fan.96.1303831981650; Tue,
 26 Apr 2011 08:33:01 -0700 (PDT)
Received: by 10.223.118.5 with HTTP; Tue, 26 Apr 2011 08:32:31 -0700 (PDT)
In-Reply-To: <7v7hahghls.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172102>

2011/4/26 Junio C Hamano <gitster@pobox.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:
>
>> strbuf_grow(sb, 0) may allocate less than requested len and violate =
the
>> next assertion.
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>> =C2=A0strbuf.h | =C2=A0 =C2=A02 +-
>> =C2=A01 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/strbuf.h b/strbuf.h
>> index 07060ce..ab213da 100644
>> --- a/strbuf.h
>> +++ b/strbuf.h
>> @@ -34,7 +34,7 @@ extern void strbuf_grow(struct strbuf *, size_t);
>>
>> =C2=A0static inline void strbuf_setlen(struct strbuf *sb, size_t len=
) {
>> =C2=A0 =C2=A0 =C2=A0 if (!sb->alloc)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strbuf_grow(sb, 0);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strbuf_grow(sb, len);
>> =C2=A0 =C2=A0 =C2=A0 assert(len < sb->alloc);
>
> This looks so obviously correct that it is scary.
>
> How could 60 callsites of this function manage to have run without cr=
ashes
> so far? =C2=A0They all happen to use the function on a buffer that al=
ready has
> something on it?

I guess no current call site does _setlen right after initialization.
It's new code that triggers it.
--=20
Duy
