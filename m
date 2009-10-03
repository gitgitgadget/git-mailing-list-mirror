From: Marius Storm-Olsen <marius@storm-olsen.com>
Subject: Re: MSVC build broken (on cygwin)
Date: Sat, 03 Oct 2009 22:29:31 +0200
Message-ID: <4AC7B42B.8020506@gmail.com>
References: <4AC4E2C2.6030509@ramsay1.demon.co.uk> <4AC5B4AE.5070307@gmail.com> <81b0412b0910020123j13c74497w874e301c38cddec9@mail.gmail.com> <4AC5BEA6.5000102@gmail.com> <4AC7AEB9.3030404@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sat Oct 03 22:32:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MuBGn-0005Pg-Sl
	for gcvg-git-2@lo.gmane.org; Sat, 03 Oct 2009 22:31:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755531AbZJCUap (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Oct 2009 16:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753875AbZJCUao
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Oct 2009 16:30:44 -0400
Received: from mail-ew0-f211.google.com ([209.85.219.211]:43695 "EHLO
	mail-ew0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753212AbZJCUao (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Oct 2009 16:30:44 -0400
Received: by ewy7 with SMTP id 7so2343385ewy.17
        for <git@vger.kernel.org>; Sat, 03 Oct 2009 13:29:31 -0700 (PDT)
Received: by 10.211.130.19 with SMTP id h19mr5054868ebn.54.1254601771462;
        Sat, 03 Oct 2009 13:29:31 -0700 (PDT)
Received: from ?192.168.0.198? (cm-84.215.55.206.getinternet.no [84.215.55.206])
        by mx.google.com with ESMTPS id 10sm1217314eyd.10.2009.10.03.13.29.29
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 03 Oct 2009 13:29:30 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 ThunderGit/0.1a Mnenhy/0.7.6.666
In-Reply-To: <4AC7AEB9.3030404@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129502>

Ramsay Jones said the following on 03.10.2009 22:06:
> Marius Storm-Olsen wrote:
>> So, something like this maybe, in git-compat-util.h:
>>
>> #if defined(__MINGW32__) || defined(_MSC_VER)
>> #  defined API_WIN32
>> #  defined OS_WINDOWS
>> #elif defined(__CYGWIN__)
>> #  defined API_POSIX
>> #  defined OS_WINDOWS
>> #else
>> #  defined API_POSIX
>> #endif
> 
> This is a much better idea.

OK, I'll write up a patch, tomorrow or Monday.

...
> So, I think something like this in git-compat-util.h:
> 
> #if defined(_WIN32) && !defined(__CYGWIN__)
> # define WIN32_API
> # define WIN32_LEAN_AND_MEAN
> # include <winsock2.h>
> # include <windows.h>
> #endif

I agree with this one. Send a patch, and I'll ack.


> and replace all #if(n)def WIN32|_WIN32 with #if(n)def WIN32_API.

Ok, I might look into that too then.


> The only use of the <windows.h> header by cygwin can be moved
> into compat/cygwin.c. (I don't much like cygwin using the
> Win32 API anyway!)

I don't have Cygwin installed, so I won't touch this one.


>> So, then we can use #ifdef API_WIN32 when using the Win32 API is the 
>> only option/preferred for MinGW or MSVC; and use #ifdef OS_WINDOWS 
>> when there are things that affect all the Windows builds.
>>
>> Opinions?
> 
> see above. I don't think OS_WINDOWS is necessary.

Well, it was mostly intended where we'd have code/algorithms which are 
platform specific, and not really compiler specific; such as the *stat() 
optimizations. They could probably be joined into an OS_WINDOWS section, 
with a POSIX_API hunk for the Cygwin fallbacks.

Not really important though. Hopefully there won't be too much platform 
specific stuff anyways.

--
.marius
