From: Bryan Larsen <bryan@larsen.st>
Subject: Re: [PATCH] Allow PERL_PATH="/usr/bin/env perl"
Date: Thu, 03 May 2007 18:58:00 -0400
Message-ID: <463A68F8.4010709@larsen.st>
References: <463A472D.5000007@larsen.st> <20070503212618.GC16538@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri May 04 00:56:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjkDh-0008Hn-1p
	for gcvg-git@gmane.org; Fri, 04 May 2007 00:56:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754262AbXECW4J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 May 2007 18:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754287AbXECW4J
	(ORCPT <rfc822;git-outgoing>); Thu, 3 May 2007 18:56:09 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:55419 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754320AbXECW4H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2007 18:56:07 -0400
Received: by py-out-1112.google.com with SMTP id a29so549104pyi
        for <git@vger.kernel.org>; Thu, 03 May 2007 15:56:05 -0700 (PDT)
Received: by 10.65.188.14 with SMTP id q14mr4454724qbp.1178232965541;
        Thu, 03 May 2007 15:56:05 -0700 (PDT)
Received: from ?192.168.1.91? ( [206.248.190.98])
        by mx.google.com with ESMTP id e13sm1963243qba.2007.05.03.15.55.59;
        Thu, 03 May 2007 15:56:04 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.0 (X11/20070326)
In-Reply-To: <20070503212618.GC16538@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46113>

Shawn O. Pearce wrote:
> Bryan Larsen <bryan@larsen.st> wrote:
>> The perl scripts start with "#!/usr/bin/perl".  There is a mechanism 
>> PERL_PATH in the Makefile to change this, but it currently doesn't work 
>> with PERL_PATH="/usr/bin/env perl".  This is causing problems in 
>> MacPorts, where we wish to work with the MacPorts perl if it is 
>> installed, but fall back to the system perl if it isn't.
>>
>> Signed-off-by: Bryan Larsen <bryan@larsen.st>
>> ---
>>  perl/Makefile |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/perl/Makefile b/perl/Makefile
>> index 17d004e..2832cb4 100644
>> --- a/perl/Makefile
>> +++ b/perl/Makefile
>> @@ -33,7 +33,7 @@ $(makfile): ../GIT-CFLAGS Makefile
>>         echo '  echo $(instdir_SQ)' >> $@
>>  else
>>  $(makfile): Makefile.PL ../GIT-CFLAGS
>> -       '$(PERL_PATH_SQ)' $< PREFIX='$(prefix_SQ)'
>> +       $(PERL_PATH_SQ) $< PREFIX='$(prefix_SQ)'
>>  endif
> 
> This will break if someone actually had ' in their PERL_PATH:
> 
> 	PERL_PATH="/path'to'perl"
> 
> as PERL_PATH_SQ tries to close the single quoted string you don't
> open anymore.  That is because it is defined to be PERL_PATH,
> but with all ' replaced by '\''.

Actually, we should just use $(PERL_PATH) with no _SQ and no quotes. 
The user is passing in something that is designed to go in a shebang 
line: their funny characters are going to be interpreted by the 
interactive shell to load the perl interpreter; we want "make" to do the 
same thing.

> 
> This change also breaks for anyone who had spaces in their PERL_PATH.

Actually a space didn't work before, but with my patch it works like 
you'd expect in a shebang line, as the delimiter between the command and 
it's arguments.

> 
> Can I ask why you can't just supply a small wrapper shellscript
> with MacPorts
> 
> 	cat >perl <<EOF
> 	#!/bin/sh
> 	exec env perl "$@"
> 	EOF
> 	chmod a+x perl
> 
> ?  Or better yet, supply Git the correct Perl path?  If/when we ever
> go to native Perl libraries again a Git Perl library compiled for
> the system perl may not work later when the user installs a newer
> MacPorts perl.  Switching automatically to the MacPorts perl without
> recompiling the native extensions is a little evil...
> 

At that point we just add a single line "depends_lib port:perl5.8" to 
the Portfile and everything magically works for the user.  Right now 
it's only in the git-svnimport part of the Portfile, which is nice: the 
user doesn't get multiple megabytes worth of perl unless we also need to 
install p5-svn-simple.

An even better fix can be to drop PERL_PATH from the Makefile and 
replace the shebang line with "#!/usr/bin/env perl".  Much simpler, and 
the right thing to do, in my opinion.

cheers,
Bryan
