From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC 2/2] Make misuse of get_pathname() buffers detectable by valgrind
Date: Wed, 16 Nov 2011 21:18:53 +0700
Message-ID: <CACsJy8BK3zvxA5mpC+3UvYMe20X6iFWJ7JL+VH6fr-Xstw2usg@mail.gmail.com>
References: <1317097687-11098-1-git-send-email-mhagger@alum.mit.edu> <1317097687-11098-3-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Nov 16 15:19:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQgKo-0006yE-Pp
	for gcvg-git-2@lo.gmane.org; Wed, 16 Nov 2011 15:19:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757821Ab1KPOT0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Nov 2011 09:19:26 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:51656 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757816Ab1KPOTZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Nov 2011 09:19:25 -0500
Received: by bke11 with SMTP id 11so602509bke.19
        for <git@vger.kernel.org>; Wed, 16 Nov 2011 06:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=MLAwFnRUwAH5qgeLmf3UeaMsGs7MLpaGD0zChhjSGhs=;
        b=OLA21YqNBJy21N4aiTk7v+U1fVnOFDZDpL7IycvD2gz+5YZ2NvBe/H8tKgTd0YyLOJ
         /cPWMTTgljlm2eyMrS+9t+plVC7diDBcwbIywgAxkuTUgRZU7Y3mW8QjJcWLfPJRGWwG
         4DqWZ8CZv08eVfv/wZT7qtfd6eXzB+OCC6AVo=
Received: by 10.204.9.209 with SMTP id m17mr22299657bkm.101.1321453164155;
 Wed, 16 Nov 2011 06:19:24 -0800 (PST)
Received: by 10.204.23.2 with HTTP; Wed, 16 Nov 2011 06:18:53 -0800 (PST)
In-Reply-To: <1317097687-11098-3-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185550>

On Tue, Sep 27, 2011 at 11:28 AM, Michael Haggerty <mhagger@alum.mit.ed=
u> wrote:
> +#ifdef VALGRIND
> + =C2=A0 =C2=A0 =C2=A0 static char *pathname_array[PATHNAME_BUFFER_CO=
UNT];
> + =C2=A0 =C2=A0 =C2=A0 index =3D (index + 1) & (PATHNAME_BUFFER_COUNT=
 - 1);
> + =C2=A0 =C2=A0 =C2=A0 if (pathname_array[index]) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* In a corre=
ct program, this will have no effect, but
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* *if* someb=
ody erroneously uses this buffer after it
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* has been f=
reed, it gives more of a chance that the
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* error will=
 be detected even if valgrind is not
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* running:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strcpy(pathname_ar=
ray[index], buggy_path);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 free(pathname_arra=
y[index]);
> + =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 pathname_array[index] =3D xmalloc(PATH_MAX);
> + =C2=A0 =C2=A0 =C2=A0 return pathname_array[index];
> +#else

Not sure if it works (just read man pages, haven't tried anything) I'm
thinking to use mmap() with MAP_ANONYMOUS instead of xmalloc(), then
mprotect() instead of free() to remove read access from that area. Any
access after that should be caught. Leaking may not be severe for
git_path(), hopefully.
--=20
Duy
