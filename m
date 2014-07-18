From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH] abspath.c: use PATH_MAX in real_path_internal()
Date: Fri, 18 Jul 2014 13:32:59 +0200
Message-ID: <53C905EB.3010908@web.de>
References: <1405601143-31354-1-git-send-email-pclouds@gmail.com> <53C80265.5030903@web.de> <53C8562C.4000304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: Karsten Blees <karsten.blees@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWk=?= =?UTF-8?B?IE5n4buNYyBEdXk=?= 
	<pclouds@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 18 13:33:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X86Po-0000NJ-D9
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jul 2014 13:33:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761529AbaGRLdX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Jul 2014 07:33:23 -0400
Received: from mout.web.de ([212.227.15.3]:51775 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761516AbaGRLdW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2014 07:33:22 -0400
Received: from [192.168.178.27] ([79.250.167.186]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0Lilcj-1WXfb83dnh-00cxep; Fri, 18 Jul 2014 13:33:11
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53C8562C.4000304@gmail.com>
X-Provags-ID: V03:K0:Z4wu1AHTbyftMcQrVL5wFi7bLIHAA0FU94/xPTimyr/uvooTAsD
 uMCPT1CE46Wt6skz693OTmURjRAZCZ8bes3+522bYP86tzPRXamDQI96bDJbKmW1eky1yXV
 cSpBYBEvDw9sERxQ/ns5T4L+8+ymkUa8CSgDfRy+btmsHcdWqPK55EaCBrWqb6giHXLZgk6
 6QeRu4UeJRQyDWtHEcNXA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253812>

Am 18.07.2014 01:03, schrieb Karsten Blees:
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

That's a good question; thanks for stepping back and looking at the=20
bigger picture.  If there is widespread OS support for a functionality=20
then we should use it and just provide a compatibility implementation=20
for those platforms lacking it.  The downside is that compat code gets=20
less testing.

Seeing that readlink() is left as a stub in compat/mingw.h that only=20
errors out, would the equivalent function on Windows be PathCanonicaliz=
e=20
(http://msdn.microsoft.com/en-us/library/windows/desktop/bb773569%28v=3D=
vs.85%29.aspx)?

> For non-XSI-compliant platforms, we could keep the current implementa=
tion.

OK, so realpath() for Linux and the BSDs, mingw_realpath() wrapping=20
PathCanonicalize() for Windows and the current code for the rest?

> Or re-implement a thread-safe version, e.g. applying resolve_symlink(=
) from
> lockfile.c to all path components.

Thread safety sounds good.  We'd also need something like=20
normalize_path_copy() but without the conversion of backslashes to=20
slashes, in order to get rid of "." and ".." path components and=20
something like absolute_path() that doesn't die on error, no?

> If I may bother you with the Windows point of view:
>
> There is no fchdir(), and I'm pretty sure open(".") won't work either=
=2E

On Windows, there *is* an absolute path length limit of 260 in the=20
normal case and a bit more than 32000 for some functions using the \\?\=
=20
namespace.  So one could get away with using a constant-sized buffer fo=
r=20
a "remember the place and return later" function here.

Also, _getcwd can be asked to allocate an appropriately-sized buffer fo=
r=20
use, like GNU's get_current_dir_name, by specifying NULL as its first=20
parameter (http://msdn.microsoft.com/en-us/library/sf98bd4y.aspx).

Not having to move around at all as mentioned above is still better, of=
=20
course.

Ren=C3=A9
