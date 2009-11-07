From: Steven Noonan <steven@uplinklabs.net>
Subject: Re: [cgit PATCH] Close file descriptor on error in readfile()
Date: Fri, 6 Nov 2009 18:22:09 -0800
Message-ID: <f488382f0911061822y7d0b52d5sa5cf4b199554312f@mail.gmail.com>
References: <4AF4D4EC.1040806@pixeltards.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Rys Sommefeldt <rys@pixeltards.com>
X-From: git-owner@vger.kernel.org Sat Nov 07 03:22:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6awo-0007xH-3C
	for gcvg-git-2@lo.gmane.org; Sat, 07 Nov 2009 03:22:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759344AbZKGCWG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Nov 2009 21:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758816AbZKGCWF
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 21:22:05 -0500
Received: from mail-pz0-f188.google.com ([209.85.222.188]:65178 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752367AbZKGCWE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Nov 2009 21:22:04 -0500
Received: by pzk26 with SMTP id 26so1057963pzk.4
        for <git@vger.kernel.org>; Fri, 06 Nov 2009 18:22:09 -0800 (PST)
Received: by 10.142.249.24 with SMTP id w24mr517365wfh.325.1257560529734; Fri, 
	06 Nov 2009 18:22:09 -0800 (PST)
In-Reply-To: <4AF4D4EC.1040806@pixeltards.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132350>

On Fri, Nov 6, 2009 at 6:01 PM, Rys Sommefeldt <rys@pixeltards.com> wro=
te:
> Hi Lars,
>
> My colleagues and I use cgit at work, and we've found that the scanni=
ng
> process can consume all available fds pretty quickly on our cgit host=
s,
> because it doesn't close them properly on error. =A0We have a few tho=
usand
> active repositories for cgit to scan, and we noticed it dying after a
> certain amount.
>
> I've attached a patch which should apply against current master, alth=
ough I
> developed it a while back on an older 0.8 version (sorry it took so l=
ong to
> subscribe and send the patch in).
>
> Cheers,
>
> Rys Sommefeldt
> ---
>
> From 6446cf839d2104cd40848e439bf97cd7fd6ccfee Mon Sep 17 00:00:00 200=
1
> From: Rys Sommefeldt <rsommefeldt@plus.net>
> Date: Fri, 6 Nov 2009 17:14:56 +0000
> Subject: [PATCH] Close fd when done
>
> ---
> shared.c | =A0 =A09 +++++++--
> 1 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/shared.c b/shared.c
> index d7b2d5a..d5e54e6 100644
> --- a/shared.c
> +++ b/shared.c
> @@ -404,14 +404,19 @@ int readfile(const char *path, char **buf, size=
_t
> *size)
> =A0 =A0struct stat st;
>
> =A0 =A0fd =3D open(path, O_RDONLY);
> - =A0 =A0if (fd =3D=3D -1)
> + =A0 =A0if (fd =3D=3D -1) {
> + =A0 =A0 =A0 =A0close(fd);
> =A0 =A0 =A0 =A0return errno;
> - =A0 =A0if (fstat(fd, &st))
> + =A0 =A0}

The above change looks bogus. If fd =3D=3D -1, you close() it anyway?

> + =A0 =A0if (fstat(fd, &st)) {
> + =A0 =A0 =A0 =A0close(fd);
> =A0 =A0 =A0 =A0return errno;
> + =A0 =A0}
> =A0 =A0if (!S_ISREG(st.st_mode))
> =A0 =A0 =A0 =A0return EISDIR;
> =A0 =A0*buf =3D xmalloc(st.st_size + 1);
> =A0 =A0*size =3D read_in_full(fd, *buf, st.st_size);
> =A0 =A0(*buf)[*size] =3D '\0';
> + =A0 =A0close(fd);
> =A0 =A0return (*size =3D=3D st.st_size ? 0 : errno);
> }
> --
> 1.6.5.2
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
