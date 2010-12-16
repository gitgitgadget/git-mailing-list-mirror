From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 08/14] help.c: Fix detection of custom merge strategy on cygwin
Date: Fri, 17 Dec 2010 00:06:07 +0100
Message-ID: <AANLkTi=9rSEK=7JyS6w50Hr=mrVttmjeqnBrbYsSR=6K@mail.gmail.com>
References: <4D07B786.2060602@ramsay1.demon.co.uk> <AANLkTimt3w9GVCXa_n1_HXivyRmnRyUhhdSArrHOT6fs@mail.gmail.com>
 <4D0A7E87.3020203@ramsay1.demon.co.uk>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>, j6t@kdbg.org,
	jrnieder@gmail.com, vmiklos@frugalware.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Fri Dec 17 00:06:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTMuA-0001C5-RO
	for gcvg-git-2@lo.gmane.org; Fri, 17 Dec 2010 00:06:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752193Ab0LPXGa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Dec 2010 18:06:30 -0500
Received: from mail-fx0-f43.google.com ([209.85.161.43]:57844 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219Ab0LPXG3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Dec 2010 18:06:29 -0500
Received: by fxm18 with SMTP id 18so95058fxm.2
        for <git@vger.kernel.org>; Thu, 16 Dec 2010 15:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=SYKY8a9/1n32kdm6QEW2YtjZtYoSK5qypmL7WR1YjPI=;
        b=QPNoaQCNh2C6dsh1akCoNRGrng9JHvUr9n7Ff6GiYmS2OnMtnLLU8tLOkmoOWX1et7
         qM8kFdPn2+Vbx9HFJ4PAvyw4h3xWl5r1OcsOdQRq+TVAIoENUnXLFgVuF5E4OL4vXfdS
         Yzz0Z200UoeVgB6bZaKj7F+7AHQ5IIXdnHFdM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=bURRYmk657++NxTeZYZKXCmSmuOow+GLlWoKjy64hgOLnI/gaTfqb7GwycBf7RrupP
         1DJQgUUfZHTnVNEzX0dx5wLo7lgzavw94ZGpe5MZj2SaD4tlDYarGZxoJp2FcMDp1ry3
         2dKLMsiVJVESaiyzXKar17Tb1qB3tYHrg4+qE=
Received: by 10.223.81.70 with SMTP id w6mr415191fak.18.1292540787834; Thu, 16
 Dec 2010 15:06:27 -0800 (PST)
Received: by 10.223.96.71 with HTTP; Thu, 16 Dec 2010 15:06:07 -0800 (PST)
In-Reply-To: <4D0A7E87.3020203@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163838>

On Thu, Dec 16, 2010 at 10:03 PM, Ramsay Jones
<ramsay@ramsay1.demon.co.uk> wrote:
> Erik Faye-Lund wrote:
>>> diff --git a/help.c b/help.c
>>> index 7f4928e..eabadc9 100644
>>> --- a/help.c
>>> +++ b/help.c
>>> @@ -126,7 +126,10 @@ static int is_executable(const char *name)
>>> =A0 =A0 =A0 =A0 =A0 =A0!S_ISREG(st.st_mode))
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
>>>
>>> -#ifdef WIN32
>>> +#if defined(WIN32) || defined(__CYGWIN__)
>>> +#if defined(__CYGWIN__)
>>> +if ((st.st_mode & S_IXUSR) =3D=3D 0)
>>> +#endif
>>
>> Perhaps the first check should simply be changed to check for _WIN32
>> instead of WIN32? IIRC _WIN32 is set on Cygwin, but I could be
>> mistaken...
>
> No, neither WIN32 or _WIN32 will be defined here (and they should not=
 be).
> It's actually quite tricky, particularly when #including <windows.h>,=
 viz:
>
> =A0 =A0$ cat -n test.c
> =A0 =A0 1 =A0#include <stdio.h>
> =A0 =A0 2
> =A0 =A0 3 =A0#ifdef IW
> =A0 =A0 4 =A0# include <windows.h>
> =A0 =A0 5 =A0#endif
> =A0 =A0 6
> =A0 =A0 7 =A0int main(int argc, char *argv[])
> =A0 =A0 8 =A0{
> =A0 =A0 9 =A0#ifdef WIN32
> =A0 =A010 =A0 =A0 =A0 =A0 =A0printf("WIN32 ");
> =A0 =A011 =A0#endif
> =A0 =A012 =A0#ifdef _WIN32
> =A0 =A013 =A0 =A0 =A0 =A0 =A0printf("_WIN32 ");
> =A0 =A014 =A0#endif
> =A0 =A015 =A0#ifdef __CYGWIN__
> =A0 =A016 =A0 =A0 =A0 =A0 =A0printf("__CYGWIN__ ");
> =A0 =A017 =A0#endif
> =A0 =A018 =A0#ifdef __MINGW32__
> =A0 =A019 =A0 =A0 =A0 =A0 =A0printf("__MINGW32__ ");
> =A0 =A020 =A0#endif
> =A0 =A021 =A0 =A0 =A0 =A0 =A0printf("\n");
> =A0 =A022 =A0 =A0 =A0 =A0 =A0return 0;
> =A0 =A023 =A0}
>
> =A0 =A0$ gcc -o test test.c
> =A0 =A0$ ./test
> =A0 =A0__CYGWIN__
>
> =A0 =A0$ gcc -o test -DIW test.c
> =A0 =A0$ ./test
> =A0 =A0WIN32 _WIN32 __CYGWIN__
>
> =A0 =A0$ gcc -o test -mno-cygwin test.c
> =A0 =A0$ ./test
> =A0 =A0WIN32 _WIN32 __MINGW32__
>

Hmm, I thought _WIN32 was always defined when targeting Windows, and
that WIN32 was defined when windows.h was included (or usually in the
preprocessor flags when compiling GUI programs) - that's what MSVC
does anyway. MinGW seems to always define both _WIN32 and WIN32, but
as you've shown Cygwin doesn't define either until windows.h is
included.

So sorry for leading you onto the wrong path, a check for __CYGWIN__
seems to be necessary indeed.
