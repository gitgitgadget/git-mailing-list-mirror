From: "Matthias Andree" <matthias.andree@gmx.de>
Subject: Re: [PATCH v3] To make GIT-VERSION-FILE, search for git more widely
Date: Fri, 08 May 2009 10:27:21 +0200
Message-ID: <op.utlq3vgx1e62zd@merlin.emma.line.org>
References: <1241688129-31613-1-git-send-email-matthias.andree@gmx.de>
 <7v7i0scvcf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 08 10:27:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2LQo-0002bh-KT
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 10:27:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756346AbZEHI12 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 04:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756014AbZEHI10
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 04:27:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:45022 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755600AbZEHI1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2009 04:27:25 -0400
Received: (qmail invoked by alias); 08 May 2009 08:27:24 -0000
Received: from g226232121.adsl.alicedsl.de (EHLO mandree.no-ip.org) [92.226.232.121]
  by mail.gmx.net (mp039) with SMTP; 08 May 2009 10:27:24 +0200
X-Authenticated: #428038
X-Provags-ID: V01U2FsdGVkX18DWTUGu/oDjelqBCWAn1aAIf9GuZbNn7iJl5BP3A
	yi2uW8qJRUHYLm
Received: from merlin.emma.line.org (localhost [127.0.0.1])
	by merlin.emma.line.org (Postfix) with ESMTP id 426E7194008;
	Fri,  8 May 2009 10:27:22 +0200 (CEST)
In-Reply-To: <7v7i0scvcf.fsf@alter.siamese.dyndns.org>
User-Agent: Opera Mail/9.64 (Linux)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.47
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118585>

Am 08.05.2009, 02:05 Uhr, schrieb Junio C Hamano <gitster@pobox.com>:

> Matthias Andree <matthias.andree@gmx.de> writes:
>
>> The underlying problem flow is:
>>
>> 1 - Makefile has "include GIT-VERSION-FILE", thus gmake builds
>>     GIT-VERSION-FILE early.
>>
>> 2 - GIT-VERSION-FILE depends on a .PHONY target  
>> (.FORCE-GIT-VERSION-FILE)
>> 3 - Thus, GNU make *always* executes GIT-VERSION-GEN
>> 4 - GIT-VERSION-GEN now, under the stripped $PATH, cannot find "git" and
>>     sees a different version number.
>> 5 - GIT-VERSION-GEN notes the difference in versions and regenerates
>>     GIT-VERSION-FILE, with up-to-date timestamp.
>
> Interesting.  I wonder if you need the change to the Makefile.
>
> As long as GIT-VERSION-GEN notices that you have a freshly built git
> available (test -x) and uses it, falling back to whatever on the PATH, it
> would not have to touch GIT-VERSION-FILE, no?

Hi Junio,

Makefile (+ GNU make) is the actual culprit and introduces this cycle, why  
do we want to leave Makefile - of all things - alone?

Makefile also has all the info: (1) locations, for VPATH builds, (2)  
$(prefix), (3) $X (extension), so let's have it communicate that (through  
the $GIT variable). Let's not introduce second-guessing into the script.  
It would be error prone and manually duplicates efforts that either are  
already there or are automatic in Makefile. G-V-GEN is run under  
Makefile's control, so let's steer it into the right direction.

The G-V-GEN test -x is only there to fall back to a path search if the  
variable is unset when running things directly, rather than through make.

HTH
Matthias

> IOW, instead of this:
>
>> diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
>> index 39cde78..d0dfef3 100755
>> --- a/GIT-VERSION-GEN
>> +++ b/GIT-VERSION-GEN
>> @@ -2,6 +2,7 @@
>>
>>  GVF=GIT-VERSION-FILE
>>  DEF_VER=v1.6.3.GIT
>> +test -x "$GIT" || GIT=git
>
> wouldn't it make more sense to do
>
> 	if test -x "git"
>         then
>         	GIT=./git
> 	elif test -x "git.exe"
>         then
>         	GIT=./git.exe
> 	else
>         	GIT=git
> 	fi
>
> and use the rest of the patch to GIT-VERSION-GEN, without touching
> Makefile at all?



-- 
Matthias Andree
