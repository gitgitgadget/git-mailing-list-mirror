From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH] abspath.c: use PATH_MAX in real_path_internal()
Date: Fri, 18 Jul 2014 01:03:08 +0200
Message-ID: <53C8562C.4000304@gmail.com>
References: <1405601143-31354-1-git-send-email-pclouds@gmail.com> <53C80265.5030903@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>,
	=?UTF-8?B?Tmd1eeG7hW4=?= =?UTF-8?B?IFRow6FpIE5n4buNYyBEdXk=?= 
	<pclouds@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 18 01:03:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7uhm-0005pt-I2
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jul 2014 01:03:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758196AbaGQXDJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Jul 2014 19:03:09 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:45807 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757990AbaGQXDI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2014 19:03:08 -0400
Received: by mail-wi0-f176.google.com with SMTP id bs8so8547705wib.3
        for <git@vger.kernel.org>; Thu, 17 Jul 2014 16:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=mgb9L1KZRSS2Nz8mj2h9fkWyyEYb4B9VJEBllgUVipU=;
        b=g+SRJwoS3dWlhcKP14O+NrX9fyJ3ArnkNxVQMx/c52wiAlGnfOs9r3x/fdoof0L2R2
         ycO4/QalvoynexpiOdck4l3jes5+6OTdhCZH09BzgkiSiVuhP7FJ5so2D/yptIwBciEc
         cVleMXzkCPFAJ8RxpYzawXkbj38BkFu/EhkPxsAOs63zlyo+m6foNgmEqCcgrpGGAQdc
         yORS0Z0VAdcvc0ggC7GnM6JXDfVOxoqdda3NFiNlru2A++1puGTjpgsHA8SZ3Tkul+lN
         ElqhVOKArwYGF4mo0C7owTUFbr4yAENHFlpIpfwAxlzYBqJKDzeaKEFBEMpwnv6FH0gO
         RF3g==
X-Received: by 10.180.72.234 with SMTP id g10mr13596335wiv.52.1405638187307;
        Thu, 17 Jul 2014 16:03:07 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id ut2sm9436559wjc.49.2014.07.17.16.03.05
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 17 Jul 2014 16:03:06 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53C80265.5030903@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253787>

Am 17.07.2014 19:05, schrieb Ren=C3=A9 Scharfe:
> Am 17.07.2014 14:45, schrieb Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Du=
y:
[...]
> "These routines have traditionally been used by programs to save the
> name of a working directory for the purpose of returning to it. A muc=
h
> faster and less error-prone method of accomplishing this is to open t=
he
> current directory (.) and use the fchdir(2) function to return."
>=20

fchdir() is part of the POSIX-XSI extension, as is realpath(). So why n=
ot
use realpath() directly (which would also be thread-safe)?

=46or non-XSI-compliant platforms, we could keep the current implementa=
tion.
Or re-implement a thread-safe version, e.g. applying resolve_symlink() =
from
lockfile.c to all path components.


If I may bother you with the Windows point of view:=20

There is no fchdir(), and I'm pretty sure open(".") won't work either.

fchdir() could be emulated using GetFileInformationByHandleEx(FileNameI=
nfo).
realpath() is pretty much what GetFinalPathNameByHandle() does. However=
,
both of these APIs require Windows Vista.

Opening a handle to a directory can be done using FILE_FLAG_BACKUP_SEMA=
NTICS,
which AFAICT MSVCRT.dll's open() implementation does _not_ do (could be
emulated in our mingw_open() wrapper, though).

=2E..lots of work for little benefit, I would think.
