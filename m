From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 03/11] cat-file: use streaming interface to print blobs
Date: Tue, 28 Feb 2012 08:08:42 +0700
Message-ID: <CACsJy8Aa_KRTYVMy8SgB91D3g_=DwP_noxWAO7NWYuQupKPcyA@mail.gmail.com>
References: <1330329315-11407-1-git-send-email-pclouds@gmail.com>
 <1330329315-11407-4-git-send-email-pclouds@gmail.com> <7vzkc49nnu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 28 02:10:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2BZi-0006EW-T5
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 02:09:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965053Ab2B1BJc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Feb 2012 20:09:32 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:45120 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754603Ab2B1BJO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Feb 2012 20:09:14 -0500
Received: by wgbdr13 with SMTP id dr13so2198919wgb.1
        for <git@vger.kernel.org>; Mon, 27 Feb 2012 17:09:13 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.216.134.74 as permitted sender) client-ip=10.216.134.74;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.216.134.74 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.216.134.74])
        by 10.216.134.74 with SMTP id r52mr8292369wei.19.1330391353057 (num_hops = 1);
        Mon, 27 Feb 2012 17:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=+/PmMKs+GaPAYcjdJo+FpOU3lTha7OH1s2O9YzI2te4=;
        b=b/s0sIhJmKI70DIzmUB0DULd977kpsyycKJxX88w5oFODo2LaX7NNKlv+hlsoa7r8T
         lvrP3siR2Eu/bu0+Uqxx7/IIFTMuJ/zJJx/zJWOgLHu9VXH2sYhWzQR8XIrj5e1JosgS
         No+H3vbeH98xVZK97UQqCxBiF9bQu98Pv+dFE=
Received: by 10.216.134.74 with SMTP id r52mr6582370wei.19.1330391352948; Mon,
 27 Feb 2012 17:09:12 -0800 (PST)
Received: by 10.223.13.5 with HTTP; Mon, 27 Feb 2012 17:08:42 -0800 (PST)
In-Reply-To: <7vzkc49nnu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191693>

2012/2/28 Junio C Hamano <gitster@pobox.com>:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enum object_type type;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long size;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *buffer =3D read_sh=
a1_file(sha1, &type, &size);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (memcmp(buffer, "obje=
ct ", 7) ||
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 get_sha1_h=
ex(buffer + 7, new_sha1))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 die("%s not a valid tag", sha1_to_hex(sha1));
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sha1 =3D new_sha1;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 free(buffer);
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 return streaming_write_sha1(1, 0, sha1, OBJ_BLOB, NU=
LL);
>
> I do not think your previous refactoring added a fall-back codepath t=
o the
> function you are calling here. =C2=A0In the original context, the cal=
ler of
> streaming_write_entry() made sure that the blob is suitable for strea=
ming
> write by getting an istream, and called the function only when that i=
s the
> case. =C2=A0Blobs unsuitable for streaming (e.g. an deltified object =
in a pack)
> were handled by the caller that decided not to call
> streaming_write_entry() with the conventional "read to core and then =
write
> it out" codepath.
>
> And I do not think your updated caller in cat_one_file() is equipped =
to do
> so at all.
>
> So it looks to me that this patch totally breaks the cat-file. =C2=A0=
What am I
> missing?

I think open_istream can deal with unsuitable for streaming objects
too. There's a fallback "incore" backend that does
read_sha1_file_extended.
--=20
Duy
