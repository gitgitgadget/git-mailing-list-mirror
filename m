From: Frans Klaver <fransklaver@gmail.com>
Subject: Re: [PATCH 2/2] git: continue alias lookup on EACCES errors
Date: Thu, 29 Mar 2012 13:31:09 +0200
Message-ID: <CAH6sp9OcWUks_n1bD2n1KbePHeUX+FSY0+wLFu+zPik1Pwj3Aw@mail.gmail.com>
References: <7v4nt9j1m3.fsf@alter.siamese.dyndns.org>
	<20120328043058.GD30251@sigill.intra.peff.net>
	<7vaa30wrjx.fsf@alter.siamese.dyndns.org>
	<20120328174841.GA27876@sigill.intra.peff.net>
	<20120328180404.GA9052@burratino>
	<7v1uocwpap.fsf@alter.siamese.dyndns.org>
	<20120328184014.GA8982@burratino>
	<20120328193909.GB29019@sigill.intra.peff.net>
	<20120328194516.GD8982@burratino>
	<20120328201851.GA29315@sigill.intra.peff.net>
	<20120328215704.GB10795@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	James Pickens <jepicken@gmail.com>,
	Git ML <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 29 13:31:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDDZT-0003k3-EJ
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 13:31:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759124Ab2C2LbL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Mar 2012 07:31:11 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:33472 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756854Ab2C2LbJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Mar 2012 07:31:09 -0400
Received: by qcqw6 with SMTP id w6so1297029qcq.19
        for <git@vger.kernel.org>; Thu, 29 Mar 2012 04:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=salHvL8CWjFw2ZSnc1LrrpJrCm8xAUMeceUg9g5ZcIU=;
        b=eH+alDf44DWGa4vby5XwZusYRRRrqfO9WpRXcC+WbL2sfMxhpDBnwCjMV+anBUj3kn
         UmRAUWb2lwSub1xx+ZlhQRutuFzzRz39ReXhpjJHUGH1N8GYGH5aktjWM93Sv4jhMNGF
         0KISfVhv9BoeuHssOWldFXaDeXZ9cfsjVCYRGXKjzalzLVTNMZpQax4qVpIps+Gl/QXS
         luu4KKAy3YNSrU78Rg75ADQkdB/dg3WuVk5qQTsaYoSuBOlTX+AcTwVVOproDgNKcLYo
         yS5O1ahLiRS+5qnGdpXb8l8si4XFsCoaNiMOgHH11VIOEIdEBY3x0/t/OvEWx3axchAh
         YB1A==
Received: by 10.224.58.147 with SMTP id g19mr42598493qah.58.1333020669397;
 Thu, 29 Mar 2012 04:31:09 -0700 (PDT)
Received: by 10.224.32.19 with HTTP; Thu, 29 Mar 2012 04:31:09 -0700 (PDT)
In-Reply-To: <20120328215704.GB10795@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194248>

On Wed, Mar 28, 2012 at 11:57 PM, Jeff King <peff@peff.net> wrote:

> +static int exists_in_PATH(const char *file)
> +{
> + =C2=A0 =C2=A0 =C2=A0 const char *p =3D getenv("PATH");
> + =C2=A0 =C2=A0 =C2=A0 struct strbuf buf =3D STRBUF_INIT;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (!p || !*p)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
> +
> + =C2=A0 =C2=A0 =C2=A0 while (1) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *end =3D=
 strchrnul(p, ':');
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strbuf_reset(&buf)=
;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* POSIX specifies=
 an empty entry as the current directory. */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (end !=3D p) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 strbuf_add(&buf, p, end - p);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 strbuf_addch(&buf, '/');
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strbuf_addstr(&buf=
, file);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!access(buf.bu=
f, F_OK)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 strbuf_release(&buf);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 return 1;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!*end)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 break;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 p =3D end + 1;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 strbuf_release(&buf);
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}

I expect that if more post-mortem checking is done, this function is
going to need a sibling that provides you with the first found entry
in PATH, so you can do more checks on it.


> +
> +int sane_execvp(const char *file, char * const argv[])
> +{
> + =C2=A0 =C2=A0 =C2=A0 if (!execvp(file, argv))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;

> + =C2=A0 =C2=A0 =C2=A0 if (errno =3D=3D EACCES && !strchr(file, '/'))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 errno =3D exists_i=
n_PATH(file) ? EACCES : ENOENT;
> + =C2=A0 =C2=A0 =C2=A0 return -1;
> +}

One of the things I ran into while working on [1] is that quite some
errors that are produced can also be caused by the interpreter. This
does cover most of the itch I had earlier. I will still want to have
the interpreter check [2] in though; errno can for example also be set
to ENOENT if the interpreter or a required library isn't available. In
that case you wouldn't want to continue to the aliases, right?
