From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] abspath.c: use PATH_MAX in real_path_internal()
Date: Fri, 18 Jul 2014 17:49:04 +0700
Message-ID: <CACsJy8D5X5svApB9edHK+1EaGi+q2ZRSOvyDYaDieVV2psgZPg@mail.gmail.com>
References: <1405601143-31354-1-git-send-email-pclouds@gmail.com>
 <53C80265.5030903@web.de> <53C8562C.4000304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 12:49:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X85jP-00008Y-K9
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jul 2014 12:49:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761303AbaGRKtf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Jul 2014 06:49:35 -0400
Received: from mail-qa0-f50.google.com ([209.85.216.50]:54596 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760968AbaGRKte convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Jul 2014 06:49:34 -0400
Received: by mail-qa0-f50.google.com with SMTP id s7so2925748qap.9
        for <git@vger.kernel.org>; Fri, 18 Jul 2014 03:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=S0GiRRnMnQ9m7ZgA2QEOSMZBgX9ueBBYLQu2wM7Gywc=;
        b=rH19Jks9vWFMvs62c5CPzguHIrt3hZ0oY+ZWGSplVEtEC9yb/nztN+fEPHQptJBmip
         pPJviE81WNSaAgjbI8SFtxn9dL25nsGQecvM+ApKh5lvQZmt2CyorCPGJVbfy5wJ55zg
         qYoMQzSaqmWNwYE9MWrtLX6iK/XNt0kOHJMuXjXj6M4GBmCb/EYtxu0w9TUQEerVA4rb
         rimU63xq+0UjeH74+5TqvTJUCqtdxjEyGOB14wQtEG089pkWWWq2xaA6FKzaEpqv3t/T
         WXfwHe+p3i0yY/e1+BKGVrrmqilF4CCRIoM/cvsDkDHM5H7NfKmV68UTfhvHcyen3Hp4
         YIew==
X-Received: by 10.140.24.243 with SMTP id 106mr6298101qgr.11.1405680574056;
 Fri, 18 Jul 2014 03:49:34 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Fri, 18 Jul 2014 03:49:04 -0700 (PDT)
In-Reply-To: <53C8562C.4000304@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253810>

On Fri, Jul 18, 2014 at 6:03 AM, Karsten Blees <karsten.blees@gmail.com=
> wrote:
> Am 17.07.2014 19:05, schrieb Ren=C3=A9 Scharfe:
>> Am 17.07.2014 14:45, schrieb Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy:
> [...]
>> "These routines have traditionally been used by programs to save the
>> name of a working directory for the purpose of returning to it. A mu=
ch
>> faster and less error-prone method of accomplishing this is to open =
the
>> current directory (.) and use the fchdir(2) function to return."
>>
>
> fchdir() is part of the POSIX-XSI extension, as is realpath(). So why=
 not
> use realpath() directly (which would also be thread-safe)?

But realpath still needs a given buffer (of PATH_MAX at least again).
Unless you pass a NULL pointer as "resolved_name", then Linux can
allocate the buffer but that's implementation specific [1]. I guess we
can make a wrapper "git_getcwd" that returns a new buffer. The default
implementation returns one of PATH_MAX chars, certain platforms like
Linux can use realpath (or something else) to return a longer path?

[1] http://pubs.opengroup.org/onlinepubs/009695399/functions/realpath.h=
tml

> For non-XSI-compliant platforms, we could keep the current implementa=
tion.
> Or re-implement a thread-safe version, e.g. applying resolve_symlink(=
) from
> lockfile.c to all path components.
>
>
> If I may bother you with the Windows point of view:
>
> There is no fchdir(), and I'm pretty sure open(".") won't work either=
=2E
>
> fchdir() could be emulated using GetFileInformationByHandleEx(FileNam=
eInfo).
> realpath() is pretty much what GetFinalPathNameByHandle() does. Howev=
er,
> both of these APIs require Windows Vista.
>
> Opening a handle to a directory can be done using FILE_FLAG_BACKUP_SE=
MANTICS,
> which AFAICT MSVCRT.dll's open() implementation does _not_ do (could =
be
> emulated in our mingw_open() wrapper, though).
>
> ...lots of work for little benefit, I would think.
>

We could wrap this "get cwd, cd back" pattern as well. So "save_cwd"
returns an opaque pointer, "go_back" takes the pointer, (f)chdir back
and free the pointer if needed. On platforms that support fchdir, it
can be used, else we fall back to chdir. I think there are only four
places that follow this pattern, here, setup.c (.git discovery), git.c
(restore_env) and unix-socket.c. Enough call sites to make it worth
the effort?
--=20
Duy
