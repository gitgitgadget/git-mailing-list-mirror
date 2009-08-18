From: Marius Storm-Olsen <marius@storm-olsen.com>
Subject: Re: [RFC] Enable compilation by Makefile for the MSVC toolchain
Date: Tue, 18 Aug 2009 19:38:15 +0200
Message-ID: <4A8AE707.9010202@gmail.com>
References: <alpine.DEB.1.00.0908172149480.8306@pacific.mpi-cbg.de> <1250600335-8642-1-git-send-email-mstormo@gmail.com> <alpine.LNX.2.00.0908181226160.7195@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes.Schindelin@gmx.de, msysgit@googlegroups.com,
	git@vger.kernel.org, lznuaa@gmail.com, bonzini@gnu.org,
	kusmabite@googlemail.com
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Aug 18 19:37:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdSci-0003Hg-Ed
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 19:37:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758664AbZHRRhR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 13:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755079AbZHRRhR
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 13:37:17 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:36652 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754758AbZHRRhQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 13:37:16 -0400
Received: by ewy3 with SMTP id 3so1786663ewy.18
        for <git@vger.kernel.org>; Tue, 18 Aug 2009 10:37:16 -0700 (PDT)
Received: by 10.210.17.16 with SMTP id 16mr8612577ebq.17.1250617035726;
        Tue, 18 Aug 2009 10:37:15 -0700 (PDT)
Received: from ?192.168.0.196? (cm-84.215.55.206.getinternet.no [84.215.55.206])
        by mx.google.com with ESMTPS id 7sm528684eyg.57.2009.08.18.10.37.14
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 18 Aug 2009 10:37:14 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 ThunderGit/0.1a Mnenhy/0.7.6.666
In-Reply-To: <alpine.LNX.2.00.0908181226160.7195@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126426>

Daniel Barkalow said the following on 18.08.2009 18:51:
> On Tue, 18 Aug 2009, Marius Storm-Olsen wrote:
> 
>> From: Marius Storm-Olsen <mstormo@gmail.com>
>>
>> By using GNU Make we can also compile with the MSVC toolchain.
>> This is a rudementary patch, only meant as an RFC for now!!
>>
>> !! DO NOT COMMIT THIS UPSTREAM !!
>> ---
>>  So, instead of rely on these vcproj files which *will* go stale, we can
>>  simply use the same Makefile system which everyone else is using. :)
>>  After all, we're just compiling with a different compiler. The end result
>>  will still rely on the *msysGit environment* to function, so we already
>>  require it. Thus, GNU Make is present, and we can use it.
>>
>>  This implementation is a quick hack to make it compile (hence the RFC
>>  subject), so please don't even consider basing anything ontop of it ;)
>>
>>  But, do point out all the do's and don'ts, and I'll try to polish it up
>>  to something which we can add to Frank's series..
>>  
>>
>>  Makefile      |   97 +++++++++++++++++++++++++++++++++++++++++++++++---------
>>  compat/msvc.h |   77 +++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 158 insertions(+), 16 deletions(-)
>>
>> diff --git a/Makefile b/Makefile
>> index daf4296..2e14976 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -214,9 +214,13 @@ uname_V := $(shell sh -c 'uname -v 2>/dev/null || echo not')
>>  
>>  CFLAGS = -g -O2 -Wall
>>  LDFLAGS =
>> +ARFLAGS = rcs\ # whitespace intentional
>>  ALL_CFLAGS = $(CFLAGS)
>>  ALL_LDFLAGS = $(LDFLAGS)
>>  STRIP ?= strip
>> +COMPFLAG = -c
>> +COBJFLAG = -o\ # whitespace intended
>> +LOBJFLAG = -o\ # whitespace intended
> 
> I think it's nicer to write the significant whitespace with non-whitespace 
> text using something like:
> 
> empty=
> space=$(empty) $(empty)
> 
> (...)
> 
> ARFLAGS = rcs$(space)
> 
> COBJFLAG = -o$(space)
> 
> On the other hand, I think it would be clearer to put the "rcs" in the 
> default version of $(AR), and have a $(AROBJFLAG) set to nothing there, 
> since the "rcs" isn't actually at all like the "-OUT:" with respect to 
> what it's doing there.
> 
> Possibly also to have two variables for the output of the toolchain 
> wrapper, one that is before the name of the file and one that's attached 
> to the name of the file.

I agree on all accounts. If we don't go for a wrapper script, as Junio 
suggested, then I'll definitely do it like you suggested.

--
.marius
