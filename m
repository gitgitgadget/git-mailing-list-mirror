From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] Bugfix: undefined htmldir in config.mak.autogen
Date: Wed, 20 Feb 2013 09:39:46 +0800
Message-ID: <CANYiYbF0C2qormAWNVhHm45TVQ6woECD7u1cCxxNuwyZxziNpw@mail.gmail.com>
References: <1be0a520b99fbfecd7255c1d26753015612856b3.1361272864.git.worldhello.net@gmail.com>
	<7v8v6j52qf.fsf@alter.siamese.dyndns.org>
	<7v4nh750v3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Christoph J. Thompson" <cjsthompson@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 02:40:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7yfN-00035V-KR
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 02:40:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933928Ab3BTBjt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Feb 2013 20:39:49 -0500
Received: from mail-wg0-f42.google.com ([74.125.82.42]:56016 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932464Ab3BTBjs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Feb 2013 20:39:48 -0500
Received: by mail-wg0-f42.google.com with SMTP id 12so4141702wgh.5
        for <git@vger.kernel.org>; Tue, 19 Feb 2013 17:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=VCbPLxreKdx1ByYkT9fVV4VH0Idbqf3qeLYwJURamNo=;
        b=ylyVdBPR1dRFoePUgddjQ2h14Rcgoi5gyWTuCjeIzBRbBrQpDMbT3TM7KHAVwIjWZe
         ld7C12Zivj8xBCuVnAXgqlzBWCmjb9Fr+5+6qudFK/uUkdMMb4UAlEjk+VcnK31nGIP0
         /rQuXQ8ubCfEuItsV93XAkZq3xWb5ijJxE8nFURqge/CdB78FVijG8slmTeyLlE90kc/
         CJQzcm+2aivLfYP1E2EjkImayx7SU4rIeHq3xQZp67mfGdcTLk6VbNTyjeiVs35bh7O6
         7+MFVrctocFkNDlS33lifmeBzNxqRAG3wu/6V9o9ktvGDL0pgVOTM/gQQzwTcdnUTSBA
         MJaA==
X-Received: by 10.180.92.39 with SMTP id cj7mr31080922wib.19.1361324387136;
 Tue, 19 Feb 2013 17:39:47 -0800 (PST)
Received: by 10.194.110.199 with HTTP; Tue, 19 Feb 2013 17:39:46 -0800 (PST)
In-Reply-To: <7v4nh750v3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216671>

2013/2/20 Junio C Hamano <gitster@pobox.com>:
> Junio C Hamano <gitster@pobox.com> writes:
>>> After the installation, all the html documents will copy to rootdir=
 (/),
>>> and:
>>>
>>>     $ git --html-path
>>>     <PREFIX>
>>>
>>>     $ git help -w something
>>>     fatal: '<PREFIX>': not a documentation directory.
>>
>> I am not sure if this description is correct.  The generated configu=
re
>> seems to set
>>
>>       datarootdir=3D'${prefix}/share'
>>       htmldir=3D'${docdir}'
>>       docdir=3D'${datarootdir}/doc/${PACKAGE_TARNAME}'
>>
>> so it is likely you would get not <PREFIX> but <PREFIX>/share, no?
>
> This was a mis-diag; without docdir mentioned in config.mak.in, we
> do not even get that far, and htmldir will end up being empty, and
> the runtime code adds <PREFIX> to it in system_path().  What I was
> describing was what happens when you only mention @docdir@ but not
> PACKAGE_TARNAME in the file.

I also doubt about it after sleep, so I check it again:

    ## gettext is installed in non-standard location on Mac
    $ export CFLAGS=3D-I/usr/local/include; export LDFLAGS=3D-L/usr/loc=
al/lib
    $ make config
    $ ./configure --prefix=3D/opt/git/v1.8.2
    $ make && sudo make install
    ## already symlink /opt/git/v1.8.2/bin/* to /usr/local/bin/
    $ git --html-path
    /opt/git/v1.8.2/
    $ git help -w help
    fatal: '/opt/git/v1.8.2/': not a documentation directory.

>> And the worst part is that having to know that the file needs to
>> export docdir and PACKAGE_TARNAME feels to me that we are tying
>> ourselves to too much detail in the internal implementation detail
>> of versions of autoconf we happen to have for testing this change.

I am not familiar with autoconf. After clone autoconf and check,
I cannot find a neat way to change "htmldir" default location to
use ${datarootdir} (just like mandir).
In file "lib/autoconf/general.m4", there are:

    AC_SUBST([docdir],         [m4_ifset([AC_PACKAGE_TARNAME],
                 ['${datarootdir}/doc/${PACKAGE_TARNAME}'],
                 ['${datarootdir}/doc/${PACKAGE}'])])dnl
    ...
    AC_SUBST([htmldir],        ['${docdir}'])dnl
    ...
    AC_SUBST([pdfdir],         ['${docdir}'])dnl
    ...
    AC_SUBST([mandir],         ['${datarootdir}/man'])dnl

> This still stands. It really feels wrong that this file has to be
> aware of such an implementation detail of autoconf.  But as an
> interim workaround, setting these two otherwise unused variables may
> be the best we could do.
>
> I am not sure if such a layout can be actually used for installing,
> though.  Didn't we see some issues around the relativeness of
> htmldir and mandir vs passing them down to Documentation/Makefile,
> or is it not an issue when ./configure and config.mak.autogen is
> used?


--=20
=BD=AF=F6=CE

=B1=B1=BE=A9=C8=BA=D3=A2=BB=E3=D0=C5=CF=A2=BC=BC=CA=F5=D3=D0=CF=DE=B9=AB=
=CB=BE
=D3=CA=BC=FE: worldhello.net@gmail.com
=CD=F8=D6=B7: http://www.ossxp.com/
=B2=A9=BF=CD: http://www.worldhello.net/
=CE=A2=B2=A9: http://weibo.com/gotgit/
=B5=E7=BB=B0: 010-51262007, 18601196889
