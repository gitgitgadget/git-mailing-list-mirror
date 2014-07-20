From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH] abspath.c: use PATH_MAX in real_path_internal()
Date: Sun, 20 Jul 2014 13:17:47 +0200
Message-ID: <53CBA55B.5010606@web.de>
References: <1405601143-31354-1-git-send-email-pclouds@gmail.com> <53C80265.5030903@web.de> <53C8562C.4000304@gmail.com> <53C905EB.3010908@web.de> <53CB0575.5020707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: Karsten Blees <karsten.blees@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWk=?= =?UTF-8?B?IE5n4buNYyBEdXk=?= 
	<pclouds@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 20 13:18:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8p8P-0008IP-C3
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jul 2014 13:18:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbaGTLST convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Jul 2014 07:18:19 -0400
Received: from mout.web.de ([212.227.15.3]:61411 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751079AbaGTLSS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2014 07:18:18 -0400
Received: from [192.168.178.27] ([79.253.172.97]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0MF3Rz-1XIzSu30Q7-00GDzN; Sun, 20 Jul 2014 13:18:07
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53CB0575.5020707@gmail.com>
X-Provags-ID: V03:K0:ZZml2ZMzs2Zwyj7SiP7CTdm2qa9vOoNKPDqG7tzrB9aXpC76F2S
 2RxDIN9JQOGXEPe/8ozMiI4YkkkhryDAHP7esyYifONaOVzjptGQZF6Mte5XNhXkVQ/i9cJ
 2kTT0dVgbJtCq1MyN6jlcITFBmaQAmCQZKLn/sKguKu5Hfut8P4bYKLf2XZ+4DQ82wCWSOO
 WCC4lV+TGtnNHdNAHBq4Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253914>

Am 20.07.2014 01:55, schrieb Karsten Blees:
> Am 18.07.2014 13:32, schrieb Ren=C3=A9 Scharfe:
>> Am 18.07.2014 01:03, schrieb Karsten Blees:
>>> Am 17.07.2014 19:05, schrieb Ren=C3=A9 Scharfe:
>>>> Am 17.07.2014 14:45, schrieb Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc=
 Duy:
>>> [...]
>>>> "These routines have traditionally been used by programs to
>>>> save the name of a working directory for the purpose of
>>>> returning to it. A much faster and less error-prone method of
>>>> accomplishing this is to open the current directory (.) and use
>>>> the fchdir(2) function to return."
>>>>
>>>
>>> fchdir() is part of the POSIX-XSI extension, as is realpath(). So
>>> why not use realpath() directly (which would also be
>>> thread-safe)?
>>
>> That's a good question; thanks for stepping back and looking at the
>> bigger picture.  If there is widespread OS support for a
>> functionality then we should use it and just provide a
>> compatibility implementation for those platforms lacking it.  The
>> downside is that compat code gets less testing.
>>
>
> I just noticed that in contrast to the POSIX realpath(), our
> real_path() doesn't require the last path component to exist. I don't
> know if this property is required by the calling code, though.

If it's important then removing the last component on ENOENT, calling=20
realpath() again and appending it should handle that, right?

>> Seeing that readlink()
>
> You mean realpath()? We don't have a stub for that yet.
>
>> is left as a stub in compat/mingw.h that only errors out, would the
>> equivalent function on Windows be PathCanonicalize
>> (http://msdn.microsoft.com/en-us/library/windows/desktop/bb773569%28=
v=3Dvs.85%29.aspx)?
>>
> PathCanonicalize() doesn't return an absolute path, the realpath()
> equivalent would be GetFullPathName() (doesn't resolve symlinks) or
> GetFinalPathNameByHandle() (requires Vista, resolves symlinks,
> requires the path to exist).

I meant readlink() and assumed its ENOSYS stub in compat/mingw.h means=20
that git doesn't handle symlinks on Windows at all.

> However, a POSIX conformant getcwd must fail with ERANGE if the
> buffer is too small. So a better alternative would be to add a
> strbuf_getcwd() that works similar to strbuf_readlink() (i.e. resize
> the buffer until its large enough).

That's a good idea anyway, will send patches.

> Side note: the 'hard' 260 limit for the current directory also means
> that as long as we *simulate* realpath() via chdir()/getcwd(), long
> paths [1] don't work here.

Great, so that motivation for getting a chdir()-free implementation=20
remains. :)
