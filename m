From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Re* [PATCH 1/2] clone: allow to clone from .git file
Date: Tue, 23 Aug 2011 08:11:29 +0700
Message-ID: <CACsJy8ABBB69V3pFjGohJwAQbZ_MwGqv=p27tUHF8HAGRMLpQw@mail.gmail.com>
References: <1313927890-21227-1-git-send-email-pclouds@gmail.com>
 <7v7h66y4s5.fsf@alter.siamese.dyndns.org> <CACsJy8BaCwT+fd-KORsqXqQEtWZUpTDwgoSGU9+pMfNdero5=Q@mail.gmail.com>
 <7vbovhw9pb.fsf@alter.siamese.dyndns.org> <7vty99upn9.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 23 03:12:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvfXC-0008AU-UV
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 03:12:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754676Ab1HWBMC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Aug 2011 21:12:02 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58219 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754633Ab1HWBMA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Aug 2011 21:12:00 -0400
Received: by bke11 with SMTP id 11so4070771bke.19
        for <git@vger.kernel.org>; Mon, 22 Aug 2011 18:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Ot2aRovpZUxMyGgU+sQdUB/uROXkFMA0iSLFZuxHcMA=;
        b=i0yZt13LiT4hvBhrYNCyhe8Kg10z6hpXwjfc3yBuOykWCkI/fyb5h4V+6RX5nai+jC
         qd+/8e+OmZJY2yq+4PFZHuoft+xKMclYZd5nNaz936Oe+79Iqr2NH+3KA1ChYjwi0smH
         XwGunlfHb6ZuyK25SZ0l6szjiBUQh6O9TwMVk=
Received: by 10.204.151.70 with SMTP id b6mr1175464bkw.71.1314061919206; Mon,
 22 Aug 2011 18:11:59 -0700 (PDT)
Received: by 10.204.156.19 with HTTP; Mon, 22 Aug 2011 18:11:29 -0700 (PDT)
In-Reply-To: <7vty99upn9.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179911>

On Tue, Aug 23, 2011 at 4:01 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> -const char *read_gitfile_gently(const char *path)
> +const char *read_gitfile_gently(const char *path, int *status)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0char *buf;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0char *dir;
> @@ -389,20 +391,39 @@ const char *read_gitfile_gently(const char *pat=
h)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!S_ISREG(st.st_mode))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;

Set *status here too? I assume we need valid *status whenever NULL is r=
eturned.

> =C2=A0 =C2=A0 =C2=A0 =C2=A0fd =3D open(path, O_RDONLY);
> - =C2=A0 =C2=A0 =C2=A0 if (fd < 0)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die_errno("Error o=
pening '%s'", path);
> + =C2=A0 =C2=A0 =C2=A0 if (fd < 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!status)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 die_errno("Error opening '%s'", path);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *status =3D ERROR_=
READ_GITFILE_CANTOPEN;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;
> + =C2=A0 =C2=A0 =C2=A0 }
> =C2=A0 =C2=A0 =C2=A0 =C2=A0buf =3D xmalloc(st.st_size + 1);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0len =3D read_in_full(fd, buf, st.st_size);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0close(fd);
--=20
Duy
