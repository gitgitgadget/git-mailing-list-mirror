From: Marius Storm-Olsen <marius@storm-olsen.com>
Subject: Re: [RFC] Enable compilation by Makefile for the MSVC toolchain
Date: Tue, 18 Aug 2009 19:55:01 +0200
Message-ID: <4A8AEAF5.6070205@gmail.com>
References: <alpine.DEB.1.00.0908172149480.8306@pacific.mpi-cbg.de> <1250600335-8642-1-git-send-email-mstormo@gmail.com> <alpine.DEB.1.00.0908181605370.4680@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com, git@vger.kernel.org, lznuaa@gmail.com,
	bonzini@gnu.org, kusmabite@googlemail.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Aug 18 19:54:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdSsu-0002EN-DN
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 19:54:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758786AbZHRRyD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 13:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755133AbZHRRyC
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 13:54:02 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:43317 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754270AbZHRRyB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 13:54:01 -0400
Received: by ewy3 with SMTP id 3so1798730ewy.18
        for <git@vger.kernel.org>; Tue, 18 Aug 2009 10:54:01 -0700 (PDT)
Received: by 10.210.133.17 with SMTP id g17mr4910259ebd.9.1250618041531;
        Tue, 18 Aug 2009 10:54:01 -0700 (PDT)
Received: from ?192.168.0.196? (cm-84.215.55.206.getinternet.no [84.215.55.206])
        by mx.google.com with ESMTPS id 5sm577500eyh.36.2009.08.18.10.54.00
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 18 Aug 2009 10:54:00 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 ThunderGit/0.1a Mnenhy/0.7.6.666
In-Reply-To: <alpine.DEB.1.00.0908181605370.4680@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126430>

Johannes Schindelin said the following on 18.08.2009 16:11:
> On Tue, 18 Aug 2009, Marius Storm-Olsen wrote:
>> So, instead of rely on these vcproj files which *will* go stale, we
>> can simply use the same Makefile system which everyone else is
>> using. :) After all, we're just compiling with a different
>> compiler. The end result will still rely on the *msysGit
>> environment* to function, so we already require it. Thus, GNU Make
>> is present, and we can use it.
> 
> We can also use sed or perl to generate/modify the .vcproj files, or
> run CMake (once Pau got it to build), and package the stuff using zip
> (once I got that to build).

Really? That would be some script being able to parse the Makefile, and 
create something reasonable as a vcproj script :) Keeping all the 
options in sync, conditional files/libs, all the various end executables 
(a separate .vcproj for each of them, and a solution file (.sln)to tie 
them all together into a .. "solution", a complete product blah blah 
blah) etc.

Just using the (GNU) Makefile as the 'default' way of compiling with 
MSVC seems to be the most reasonable to me. Then we could just have a 
contrib/vc/msvc2008.vcproj which someone can update when they feel like 
it. The default way should be hard to get out-of-sync, IMO.


>> diff --git a/Makefile b/Makefile
>> +ifneq (,$(findstring Microsoft Visual Studio, $(INCLUDE)))
...
>> +else
>>  ifneq (,$(findstring MINGW,$(uname_S)))
>>  	pathsep = ;
>>  	NO_PREAD = YesPlease
> 
> This means that gcc is never used when Visual C++ is available?  Hmm.

Yes it does :)
First, "This implementation is a quick hack to make it compile", so it 
was all about just making it compile, not being 100% correct. There are 
still some warnings and options which shouldn't be passed on to cl, so 
it's by no means complete. Second, having MSVC include paths in INCLUDE 
when you're compiling with MinGW would be plain wrong. I could use LIB 
instead, which would be even wronger ;)
I was actually going to replace it with a USE_MSVC variable check 
instead though, so you'd rather do 'make USE_MSVC=1'


>> diff --git a/compat/msvc.h b/compat/msvc.h
>> index 6071565..a9d5f7f 100644
>> --- a/compat/msvc.h
>> +++ b/compat/msvc.h
>> @@ -10,50 +10,120 @@
>>  
>>  /*Configuration*/
>>  
>> +#ifndef NO_PREAD
>>  #define NO_PREAD
>> +#endif
> 
> Why?  You now have the stuff in two places.  If you want to keep them in 
> compat/msvc.h to be able to generate .vcproj files, I'd rather not have 
> them duplicated in the Makefile.

The changes to the msvc.h where added just keep Frank's vcproj project 
working. I would have just nuked all that stuff in the msvc.h since the 
Makefile would just provide it for me anyways..

--
.marius
