From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] utf8.c: fix strbuf_utf8_replace copying the last NUL to
 dst string
Date: Wed, 30 Jul 2014 17:20:22 +0700
Message-ID: <20140730102022.GA5653@lanh>
References: <1406639429-28748-1-git-send-email-pclouds@gmail.com>
 <xmqqha202b2v.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 30 12:20:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCQzh-0008HG-L4
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jul 2014 12:20:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751771AbaG3KUU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Jul 2014 06:20:20 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34542 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751235AbaG3KUS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2014 06:20:18 -0400
Received: by mail-pa0-f53.google.com with SMTP id rd3so1275780pab.40
        for <git@vger.kernel.org>; Wed, 30 Jul 2014 03:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=aqOTlVm06prF3aa7oRuRS2unsQr4dleThc3At1GdLLw=;
        b=Imch/qG+HdUFY2VMn7rtJvX4TZC+zVF9jfB3C0x+paBLiRCZdUGulJss4pRyeArc3z
         SdWiYaDV+KD2Cjb4SBpm+//ROmrmLhPssWjAFK7oKI+zxhGMtUjaxI6I+gG4y0mp/fWW
         OpKNpLtx/5/QXfYNxoWi5GD26OFuBdgTpmgWMyubYB6vJ7aaG3rCyG1PWusyhJGuQNT4
         AGiArgwXxXq5Ih4Ri1M6p7/vX7P0MWgLR/vLbhyi4PcvZUUDHVhcBw0cC6PVjQKTSIhA
         myFlGT4NiXaMzFchAqnP96slpQOQg1qquJZXxSiLgM1pxJMYSgrybcj8/q43EQRrDBNM
         HLgQ==
X-Received: by 10.68.104.66 with SMTP id gc2mr3408201pbb.17.1406715617895;
        Wed, 30 Jul 2014 03:20:17 -0700 (PDT)
Received: from lanh ([115.73.231.247])
        by mx.google.com with ESMTPSA id t12sm2797023pdj.12.2014.07.30.03.20.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jul 2014 03:20:17 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 30 Jul 2014 17:20:22 +0700
Content-Disposition: inline
In-Reply-To: <xmqqha202b2v.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254483>

On Tue, Jul 29, 2014 at 12:56:24PM -0700, Junio C Hamano wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>=20
> > When utf8_width(&src) is called with *src =3D=3D NULL (because the
> > source string ends with an ansi sequence),
>=20
> I am not sure what you mean by "because" here.  Do you mean somebody
> (who?) decides to call the utf8_width() with NULL pointer stored in
> *src because of "ansi sequence"?
>=20
> What do you mean by "ansi sequence"?  I'll assume that you mean
> those terminal control that all use bytes with hi-bit clear.

OK let's try with an example, strbuf_utf8_replace(&sb, 0, 0, "") where
"sb" contains "\033[m". The expected result is exactly the same string
with length of 3. After this block

		while ((n =3D display_mode_esc_sequence_len(src))) {
			memcpy(dst, src, n);
			src +=3D n;
			dst +=3D n;
		}

src will be right after 'm', *src is NUL (iow. src =3D=3D end). After

		n =3D utf8_width((const char**)&src, NULL);

n is zero but 'src' is advanced by another character, so
src - old_src =3D=3D 1. This NUL character is counted as part of the
string, so after the _setlen, we have the same string with length of
_4_ (instead of 3).

> At the very beginning of utf8_width(), *start can be cleared to
> point at a NULL pointer by pick_one_utf8_char() if the pointer that
> comes into utf8_width() originally points at an invalid UTF-8
> string, but as far as I can see, ESC (or any bytes that would be
> used in those terminal control sequences like colors and cursor
> control) will simply be returned as a single byte, without going
> into error path that clears *start =3D NULL.
>=20
> Puzzled...
>=20
> > it returns 0 and steps 'src' by one.=20
>=20
> Here "it" refers to utf8_width()?  Who steps 'src' by one?

utf8_width() steps 'src'.

>=20
> Ahh, did you mean *src =3D=3D NUL, i.e. "already at the end of the
> string"?

Yes.. I guess you have a better commit message prepared for me now :)

> I think utf8_width() called with an empty string should not move the
> pointer past that end-of-string NUL in the first place.  It makes me
> wonder if it would be a better fix to make it not to do that (and
> return 0), but if we declare it is the caller's fault, perhaps we
> may want to add
>=20
> 	if (!**start)
>         	die("BUG: empty string to utf8_width()???");
>=20
> at the very beginning of utf8_width(), even before it calls
> pick-one-utf8-char.
>=20
> Still puzzled...

I don't know. I mean, in a UTF-8 byte sequence, NUL is a valid
character (part of the ASCII subset), so advancing '*start' by one
makes sense. Whether we have any call sites crazy enough to do that on
purpose is a different matter.

> > This stepping makes strbuf_utf8_replace add NUL to the
> > destination string at the end of the loop. Check and break the loop
> > early.
> >
> > Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@g=
mail.com>
> > ---
> >  utf8.c | 2 ++
> >  1 file changed, 2 insertions(+)
>=20
> Tests?

Ugh.. this was triggered by one of the alignment specifier in log
--pretty. Probably easier to export strbuf_utf8_replace() as a
test-command and verify the output?

--
Duy
