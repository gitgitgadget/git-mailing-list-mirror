From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH 2/3] exclude: do strcmp as much as possible before fnmatch
Date: Tue, 29 May 2012 15:21:37 -0300
Message-ID: <CACnwZYeB2Da5mEtw9xX9pPnCa=Ld4WoePsJytn90L9XwO2+WxQ@mail.gmail.com>
References: <1338035474-4346-1-git-send-email-pclouds@gmail.com>
	<1338035474-4346-3-git-send-email-pclouds@gmail.com>
	<7v8vga6f1a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 29 20:21:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZR39-0008Ca-D3
	for gcvg-git-2@plane.gmane.org; Tue, 29 May 2012 20:21:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754957Ab2E2SVj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 May 2012 14:21:39 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:56808 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754776Ab2E2SVi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 May 2012 14:21:38 -0400
Received: by vbbff1 with SMTP id ff1so2727146vbb.19
        for <git@vger.kernel.org>; Tue, 29 May 2012 11:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=3tjo4tplMzB7VdBwa4U7B4xbWtpYujK+Dha6RXyd8C0=;
        b=q9/5sDKogNTtqpTQdOw27Lv2CB7fcK9GDZJxu07IWbm/BV8IXt/HlGlVDVuGoYpLVW
         Yjl08R4IoS87qHNpEanf0Wdla3v3Ghjrkx3FZym1dQtpC14pmgicf5DpOIy2x+6VeCB2
         JpT31eOkAoDxY1DkyySyA2wUgEXlHHI7VdII48YIPtYxI/XTeFMElG98AmsYYCuGY+eZ
         De/SjM7ApGcenZwLQi9kXqv+XIGjNO1M4XcIH3Mmzh+3PVa8YDKsehzr+81DEzNhjaZy
         axLnPXsx9/h4HWgmX49qbv3V5+uOAhqqKbmartmiAk2zP+UR9JKrW86LYXtu/gCS2WpU
         w9/A==
Received: by 10.52.23.144 with SMTP id m16mr11686948vdf.77.1338315697740; Tue,
 29 May 2012 11:21:37 -0700 (PDT)
Received: by 10.220.214.73 with HTTP; Tue, 29 May 2012 11:21:37 -0700 (PDT)
In-Reply-To: <7v8vga6f1a.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198745>

On Tue, May 29, 2012 at 3:03 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> w=
rites:
>
>> this also avoids calling fnmatch() if the non-wildcard prefix is
>> longer than basename
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>> =C2=A0dir.c | 41 +++++++++++++++++++++++++++--------------
>> =C2=A0dir.h | =C2=A02 +-
>> =C2=A02 files changed, 28 insertions(+), 15 deletions(-)
>>
>> diff --git a/dir.c b/dir.c
>> index 8535cf2..50d744f 100644
>> --- a/dir.c
>> +++ b/dir.c
>> @@ -295,9 +295,11 @@ int match_pathspec_depth(const struct pathspec =
*ps,
>> =C2=A0 =C2=A0 =C2=A0 return retval;
>> =C2=A0}
>>
>> +const char *wildcards =3D "*?[{\\";
>
nit: can this be const char wildcards[] =3D "..."; ?

also an unrelated question, is there a style guide for naming
constants like this? In chromium project we write them like kFoo.
