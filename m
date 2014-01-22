From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH/RFC] Makefile: Fix compilation of windows resource file
Date: Wed, 22 Jan 2014 17:42:16 +0100
Message-ID: <52DFF4E8.8060605@viscovery.net>
References: <52DD857C.6060005@ramsay1.demon.co.uk>	<xmqqy529t5bb.fsf@gitster.dls.corp.google.com>	<xmqqppnlt3u3.fsf@gitster.dls.corp.google.com>	<52DEF9F2.1000905@ramsay1.demon.co.uk>	<xmqqk3dssxpb.fsf@gitster.dls.corp.google.com>	<52DF6B6C.4020708@viscovery.net> <xmqq38kgyozt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 22 17:42:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W60so-0006jL-5M
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 17:42:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753321AbaAVQmZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jan 2014 11:42:25 -0500
Received: from so.liwest.at ([212.33.55.18]:56984 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755612AbaAVQmX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jan 2014 11:42:23 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1W60sb-0002Ik-9m; Wed, 22 Jan 2014 17:42:17 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id C701116613;
	Wed, 22 Jan 2014 17:42:16 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <xmqq38kgyozt.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240839>

Am 1/22/2014 17:12, schrieb Junio C Hamano:
> Johannes Sixt <j.sixt@viscovery.net> writes:
> 
>> [Cc Pat, who added git.rc]
>>
>> Am 1/22/2014 0:48, schrieb Junio C Hamano:
>>> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
>>>
>>>>> Note that I am merely guessing that "short-digit" version numbers
>>>>> are acceptable by now after seeing
>>>>>
>>>>>     https://sourceware.org/ml/binutils/2012-07/msg00199.html
>>>>
>>>> Ah, nice find!
>>>>
>>>> I will test your patch (below) and let you know soon, but it looks
>>>> good to me. (I can't test it tonight, unfortunately.)
>>>
>>> One thing to note is that I don't know why the existing code dropped
>>> the fourth digit from the maintenance series.
>>
>> I don't know either. But it does not really matter. When there are 4
>> digits in the FILEVERSION and PRODUCTVERSION statements, then the user
>> does not see them as-are, but, for example, 1.8.1283 for
>> FILEVERSION 1,8,5,3 (1283 = 5*256+3). Therefore, I think that there is

I just noticed that I'm wrong here: The user will see "1.8.5.3". But I
think it makes no difference. Read on.

>> no point in providing 4 numbers, and the patch below should be
>> sufficient.
> 
> Would that work well when we do 1.9.1, the first maintenance/bugfix
> release for 1.9?

Define "work well".

The numbers defined in {FILE,PRODUCT}VERSION statements are intended for
machine consumption and are always 4 positions (if the source contains
fewer, they are padded with zeros). They can be used by installers to
decide whether a file that already exists in the system should be
overwritten by a newer version.

Unfortunately, these numbers are visible when the user invokes Properties
from the context menu of git.exe in the file manager and then switches to
the "Version" tab. All 4 positions are always listed. Therefore, the user
will see "1.9.0.0" for the first release of the 1.9 series, which is
"wrong", because you will call "1.9", not "1.9.0.0", I assume.

With sufficient effort, we could achieve that version 1.9.1 is listed as
"1.9.1.0". That is still "wrong".

Since we can't get this display right, I suggest that we just punt (as per
my patch). That should work out nicely because we can fairly safely assume
that there are no installers around that look at these particular version
numbers.

BTW, that same "Version" tab will have another entry, called "Product
Version" later in the list. This one lists the string that we pass in
-DGIT_VERSION (see quoted context below). It is the truely correct version
that *users* should be interested in.

> 
>> diff --git a/Makefile b/Makefile
>> index b4af1e2..99b2b89 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -1773,7 +1773,7 @@ $(SCRIPT_LIB) : % : %.sh GIT-SCRIPT-DEFINES
>>  
>>  git.res: git.rc GIT-VERSION-FILE
>>  	$(QUIET_RC)$(RC) \
>> -	  $(join -DMAJOR= -DMINOR= -DPATCH=, $(wordlist 1,3,$(subst -, ,$(subst ., ,$(GIT_VERSION))))) \
>> +	  $(join -DMAJOR= -DMINOR=, $(wordlist 1,2,$(subst -, ,$(subst ., ,$(GIT_VERSION))))) \
>>  	  -DGIT_VERSION="\\\"$(GIT_VERSION)\\\"" $< -o $@
>>  
>>  ifndef NO_PERL
>> diff --git a/git.rc b/git.rc
>> index bce6db9..33aafb7 100644
>> --- a/git.rc
>> +++ b/git.rc
>> @@ -1,6 +1,6 @@
>>  1 VERSIONINFO
>> -FILEVERSION     MAJOR,MINOR,PATCH,0
>> -PRODUCTVERSION  MAJOR,MINOR,PATCH,0
>> +FILEVERSION     MAJOR,MINOR,0,0
>> +PRODUCTVERSION  MAJOR,MINOR,0,0
>>  BEGIN
>>    BLOCK "StringFileInfo"
>>    BEGIN
