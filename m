From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH/RFC] Makefile: Fix compilation of windows resource file
Date: Tue, 21 Jan 2014 22:51:30 +0000
Message-ID: <52DEF9F2.1000905@ramsay1.demon.co.uk>
References: <52DD857C.6060005@ramsay1.demon.co.uk>	<xmqqy529t5bb.fsf@gitster.dls.corp.google.com> <xmqqppnlt3u3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 21 23:51:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5kAU-0000pD-RA
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jan 2014 23:51:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753514AbaAUWvf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jan 2014 17:51:35 -0500
Received: from mdfmta005.mxout.tch.inty.net ([91.221.169.46]:42999 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750862AbaAUWve (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jan 2014 17:51:34 -0500
Received: from mdfmta005.tch.inty.net (unknown [127.0.0.1])
	by mdfmta005.tch.inty.net (Postfix) with ESMTP id 672F318C98A;
	Tue, 21 Jan 2014 22:51:32 +0000 (GMT)
Received: from mdfmta005.tch.inty.net (unknown [127.0.0.1])
	by mdfmta005.tch.inty.net (Postfix) with ESMTP id 1A15018C985;
	Tue, 21 Jan 2014 22:51:32 +0000 (GMT)
Received: from [192.168.254.13] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta005.tch.inty.net (Postfix) with ESMTP;
	Tue, 21 Jan 2014 22:51:31 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <xmqqppnlt3u3.fsf@gitster.dls.corp.google.com>
X-MDF-HostID: 18
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240786>

On 21/01/14 21:36, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
>>
>>> If the git version number consists of less than three period
>>> separated numbers, then the windows resource file compilation
>>> issues a syntax error:
>>>
>>>   $ touch git.rc
>>>   $ make V=1 git.res
>>>   GIT_VERSION = 1.9.rc0
>>>   windres -O coff \
>>>             -DMAJOR=1 -DMINOR=9 -DPATCH=rc0 \
>>>             -DGIT_VERSION="\\\"1.9.rc0\\\"" git.rc -o git.res
>>>   C:\msysgit\msysgit\mingw\bin\windres.exe: git.rc:2: syntax error
>>>   make: *** [git.res] Error 1
>>>   $
>>>
>>> [Note that -DPATCH=rc0]
>>
>> Thanks for a report.  I've been wondering how many distros and
>> packagers would have an issue like this when we go to 2-digit
>> release naming.  Of course we knew everybody can grok 3-or-4 ;-)
>>
>>> In order to fix the syntax error, we replace any rcX with zero and
>>> include some additional 'zero' padding to the version number list.
>>>
>>> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
>>> ---
>>>
>>> Hi Junio,
>>>
>>> This patch is marked RFC because, as I was just about to send this
>>> email, I realized it wouldn't always work:
>>
>> Yeah, and I suspect that with the use of $(wordlist 1,3,...) it is
>> not even working for maintenance releases.  Does it differenciate
>> between 1.8.5.1 and 1.8.5.2, for example?.  Or does "windres" always
>> assume that a package version is always 3-dewey-decimal (not 2, not
>> 4)?

I'm no expert on '.rc' file syntax, but the code certainly does not
(currently) support four digit versions.

> Perhaps like this?  Just grab digit-only segments that are separated
> with either dot or dash (and stop when we see a non-digit like
> 'dirty' or 'rcX'), and make them separated with comma.

Oh, this is *much* better than my new (unsent) attempt to fix this! ;-)

> 
> Note that I am merely guessing that "short-digit" version numbers
> are acceptable by now after seeing
> 
>     https://sourceware.org/ml/binutils/2012-07/msg00199.html

Ah, nice find!

I will test your patch (below) and let you know soon, but it looks
good to me. (I can't test it tonight, unfortunately.)

ATB,
Ramsay Jones

> 
> without knowing the current state of affairs.  If that is not the
> case you may have to count the iteration of the loop and append or
> chop the resulting string as necessary.
> 
>  Makefile              |  2 +-
>  gen-version-string.sh | 13 +++++++++++++
>  git.rc                |  4 ++--
>  3 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index b4af1e2..329f942 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1773,7 +1773,7 @@ $(SCRIPT_LIB) : % : %.sh GIT-SCRIPT-DEFINES
>  
>  git.res: git.rc GIT-VERSION-FILE
>  	$(QUIET_RC)$(RC) \
> -	  $(join -DMAJOR= -DMINOR= -DPATCH=, $(wordlist 1,3,$(subst -, ,$(subst ., ,$(GIT_VERSION))))) \
> +		-DVERSIONSTRING=$$(./gen-version-string.sh $(GIT_VERSION)) \
>  	  -DGIT_VERSION="\\\"$(GIT_VERSION)\\\"" $< -o $@
>  
>  ifndef NO_PERL
> diff --git a/gen-version-string.sh b/gen-version-string.sh
> new file mode 100755
> index 0000000..00af718
> --- /dev/null
> +++ b/gen-version-string.sh
> @@ -0,0 +1,13 @@
> +#!/bin/sh
> +
> +IFS=.- result=
> +for v in $1
> +do
> +	if expr "$v" : '[0-9][0-9]*$' >/dev/null
> +	then
> +		result=$result${result:+,}$v
> +	else
> +		break
> +	fi
> +done
> +echo "$result"
> diff --git a/git.rc b/git.rc
> index bce6db9..6f2a8d2 100644
> --- a/git.rc
> +++ b/git.rc
> @@ -1,6 +1,6 @@
>  1 VERSIONINFO
> -FILEVERSION     MAJOR,MINOR,PATCH,0
> -PRODUCTVERSION  MAJOR,MINOR,PATCH,0
> +FILEVERSION     VERSIONSTRING,0
> +PRODUCTVERSION  VERSIONSTRING,0
>  BEGIN
>    BLOCK "StringFileInfo"
>    BEGIN
> .
> 
