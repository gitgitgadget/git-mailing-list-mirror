From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] t5004: avoid using tar for checking emptiness of archive
Date: Thu, 9 May 2013 14:21:42 -0400
Message-ID: <CAPig+cTidjz4D1vZ7Aci4YZK8ph9HJ1vMqZ1-n2hVPbLuf4AKw@mail.gmail.com>
References: <518BA058.6050300@lsrfire.ath.cx>
	<518BA10B.2080003@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git discussion list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, BJ Hargrave <bj@bjhargrave.com>
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu May 09 20:21:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaVTS-0006GU-KL
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 20:21:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037Ab3EISVq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 May 2013 14:21:46 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:64926 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848Ab3EISVp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 May 2013 14:21:45 -0400
Received: by mail-la0-f46.google.com with SMTP id fk20so3108591lab.5
        for <git@vger.kernel.org>; Thu, 09 May 2013 11:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=NDarc4obGdaSOIDWRGE4bIRIju4JUm86HZlqoqnmAq0=;
        b=jr3TCv2qnJeS442698yzX9UXh4QEFPnTHEA6Jfxy/0qEvsoGDv2n71vFaW4YFcjxm8
         3JgHuv7kraD3DL8JSS0Di0lEXFJpop2370GlTLVKyzLvpgiRsig/0ub1q6b20OZSCaf+
         NAA9r7KNkvJBN1q79L0cvDKhjEgS16y+DKbBSLmaNjyWAUqM99TRkl/KcWAP9e6RvXFY
         gW8nf8nL3eFHKi8MqGBGna0oDhpJsg5+4NYT6cfARond3gjhFvQ0x+yhxf68KZ09z5JZ
         OYCkUaMqr6tISgQRXLDCaWHuLzEG+zlVkwNwKbmvc4Ur2CY3qVjPbrFUaVRTkKiCAsIb
         Nl0g==
X-Received: by 10.152.37.196 with SMTP id a4mr5967711lak.55.1368123702286;
 Thu, 09 May 2013 11:21:42 -0700 (PDT)
Received: by 10.114.181.3 with HTTP; Thu, 9 May 2013 11:21:42 -0700 (PDT)
In-Reply-To: <518BA10B.2080003@lsrfire.ath.cx>
X-Google-Sender-Auth: aAZ0TvgvFPHGVG5bn05GgTrRXao
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223765>

On Thu, May 9, 2013 at 9:13 AM, Ren=E9 Scharfe
<rene.scharfe@lsrfire.ath.cx> wrote:
> Test 2 of t5004 checks if a supposedly empty tar archive really
> contains no files.  24676f02 (t5004: fix issue with empty archive tes=
t
> and bsdtar) removed our commit hash to make it work with bsdtar, but
> the test still fails on NetBSD and OpenBSD, which use their own tar
> that considers a tar file containing only NULs as broken.
>
> Here's what the different archivers do when asked to create a tar
> file without entries:
>
>         $ uname -v
>         NetBSD 6.0.1 (GENERIC)
>         $ gtar --version | head -1
>         tar (GNU tar) 1.26
>         $ bsdtar --version
>         bsdtar 2.8.4 - libarchive 2.8.4
>
>         $ : >zero.tar
>         $ perl -e 'print "\0" x 10240' >tenk.tar
>         $ sha1 zero.tar tenk.tar
>         SHA1 (zero.tar) =3D da39a3ee5e6b4b0d3255bfef95601890afd80709
>         SHA1 (tenk.tar) =3D 34e163be8e43c5631d8b92e9c43ab0bf0fa62b9c
>
>         $ : | tar cf - -T - | sha1
>         da39a3ee5e6b4b0d3255bfef95601890afd80709
>         $ : | gtar cf - -T - | sha1
>         34e163be8e43c5631d8b92e9c43ab0bf0fa62b9c
>         $ : | bsdtar cf - -T - | sha1
>         34e163be8e43c5631d8b92e9c43ab0bf0fa62b9c
>
> So NetBSD's native tar creates an empty file, while GNU tar and bsdta=
r
> both give us 10KB of NULs -- just like git archive with an empty tree=
=2E
> Now let's see how the archivers handle these two kinds of empty tar
> files:
>
>         $ tar tf zero.tar; echo $?
>         tar: Unexpected EOF on archive file
>         1
>         $ gtar tf zero.tar; echo $?
>         gtar: This does not look like a tar archive
>         gtar: Exiting with failure status due to previous errors
>         2
>         $ bsdtar tf zero.tar; echo $?
>         0
>
>         $ tar tf tenk.tar; echo $?
>         tar: Cannot identify format. Searching...
>         tar: End of archive volume 1 reached
>         tar: Sorry, unable to determine archive format.

Missing "echo $?" output.

>         $ gtar tf tenk.tar; echo $?
>         0
>         $ bsdtar tf tenk.tar; echo $?
>         0
>
> NetBSD's tar complains about both, bsdtar happily accepts any of them
> and GNU tar doesn't like zero-length archive files.  So the safest
> course of action is to stay with our block-of-NULs format which is
> compatible with GNU tar and bsdtar, as we can't make NetBSD's native
> tar happy anyway.
>
> We can simplify our test, however, by taking tar out of the picture.
> Instead of extracting the archive and checking for the non-presence o=
f
> files, check if the file has a size of 10KB and contains only NULs.
> This makes t5004 pass on NetBSD and OpenBSD.
>
> Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
