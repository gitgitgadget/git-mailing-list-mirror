From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/3] exclude: do strcmp as much as possible before fnmatch
Date: Sun, 27 May 2012 19:06:14 +0700
Message-ID: <CACsJy8DOz30GD_zv9yO7KD55+=H0t=+q_5qRtt51nOoYXwOBBQ@mail.gmail.com>
References: <1338035474-4346-1-git-send-email-pclouds@gmail.com>
 <1338035474-4346-3-git-send-email-pclouds@gmail.com> <7vk3zyp14i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 27 14:06:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYcFI-0006vp-D2
	for gcvg-git-2@plane.gmane.org; Sun, 27 May 2012 14:06:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751754Ab2E0MGs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 May 2012 08:06:48 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:58246 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002Ab2E0MGr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 May 2012 08:06:47 -0400
Received: by wibhj8 with SMTP id hj8so896812wib.1
        for <git@vger.kernel.org>; Sun, 27 May 2012 05:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=RelQ0nqVbJXm+ERs7Kszaty5niD9ARm93QdF2OnEUbo=;
        b=WyvbYocOFT3s1TEJja6ou3a89aTzIO24jNNWVuiATNOiPVB5QGnM1ZNnyAtJG+c616
         h/IGfH1HPVLFkg+uyBdNnPRzHoqQ/adAL26bLsOZedFegJ+SNXGiuJoz+WY9/ESN/IOe
         21smDiFEbIu9jDPAjO1boUm12Thg7YvF9I/zGeYpRW7stAVRh2dUQbwft1tCSApNYWr2
         c5CNQr+XrpsI8bcDXpeJy29IMJEsuSc8RVj21pE9fOAETk5K0DxMk8V3ZaFG++MTo6ef
         gI46M+hxWfOnRFOetJOJUdAmyTUUZuU//c1tO8iyMpXXyUP5LfX6fokjSMqNZ5Xij2HX
         tcmw==
Received: by 10.180.92.5 with SMTP id ci5mr8650968wib.19.1338120406123; Sun,
 27 May 2012 05:06:46 -0700 (PDT)
Received: by 10.223.64.208 with HTTP; Sun, 27 May 2012 05:06:14 -0700 (PDT)
In-Reply-To: <7vk3zyp14i.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198585>

On Sun, May 27, 2012 at 1:51 PM, Junio C Hamano <gitster@pobox.com> wro=
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
>
> I have been wondering if you can take a different approach based on t=
he
> same observation this patch is based on. =C2=A0If you see an entry /f=
oo/bar/*.c
> in the top-level .gitignore, perhaps you can set it aside in a differ=
ent
> part of "struct exclude" for the top-level directory (because the pat=
tern
> will never match outside foo/bar directory), so that it is not even u=
sed
> for matching, and only when you descend to foo/bar directory, add "/*=
=2Ec"
> to the "struct exclude" you create for that directory.

that part is "base" field in "struct exclude", I believe.

> That way, instead of "strcmp is faster than fnmatch, but we always co=
mpare
> all elements in the huge pattern list given at the toplevel", you wou=
ld be
> doing "we do not even bother to compare with the elements we know do =
not
> matter", which would be far more efficient, no?

You still have to do at least one strncmp on "base" though to know if
a pattern is applicable to the given directory. So it's not really
cheaper than what is done in 3/3.
--=20
Duy
