From: "J.H." <warthog9@kernel.org>
Subject: Re: [PATCH 4/6] GITWEB - Makefile changes
Date: Fri, 11 Dec 2009 08:22:12 -0800
Message-ID: <4B2271B4.2010301@kernel.org>
References: <1260488743-25855-1-git-send-email-warthog9@kernel.org>	<1260488743-25855-2-git-send-email-warthog9@kernel.org>	<1260488743-25855-3-git-send-email-warthog9@kernel.org>	<1260488743-25855-4-git-send-email-warthog9@kernel.org>	<1260488743-25855-5-git-send-email-warthog9@kernel.org> <m3pr6ld1p2.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 11 17:22:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJ8G9-0001I0-7U
	for gcvg-git-2@lo.gmane.org; Fri, 11 Dec 2009 17:22:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751759AbZLKQWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2009 11:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbZLKQWJ
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Dec 2009 11:22:09 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:42943 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750925AbZLKQWI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2009 11:22:08 -0500
Received: from voot-cruiser.eaglescrag.net (76-10-145-13.dsl.ncf.ca [76.10.145.13] (may be forged))
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.1/8.14.1) with ESMTP id nBBGMDFC029966
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 11 Dec 2009 08:22:14 -0800
User-Agent: Thunderbird 2.0.0.23 (X11/20090825)
In-Reply-To: <m3pr6ld1p2.fsf@localhost.localdomain>
X-Enigmail-Version: 0.95.6
X-Virus-Scanned: ClamAV 0.88.7/10149/Thu Dec 10 14:26:20 2009 on shards.monkeyblade.net
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.1.1 (shards.monkeyblade.net [198.137.202.13]); Fri, 11 Dec 2009 08:22:14 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135095>

<snip>

> IMPORTANT!
> 
> A note about this change: I think it would be better to move creating
> gitweb.cgi (and optionally gitweb.min.js) to gitweb/Makefile, and make
> main Makefile call gitweb/Makefile, and not vice versa like in your
> solution.
> 
> If it is possible.

It's quite possible, and I'm fine with doing that.  If no one has any 
objections I can re-work those with the understanding that the build 
process for gitweb shift to the gitweb/ directory instead of the main 
Makefile.

>  
>> diff --git a/Makefile b/Makefile
>> index 4a1e5bc..8db9d01 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -1509,6 +1509,8 @@ $(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl
>>  	chmod +x $@+ && \
>>  	mv $@+ $@
>>  
>> +.PHONY: gitweb
> 
> Why it is here, and not with the .PHONY block at line 1924 of
> Makefile?  It would be nice to have comment supporting this choice in
> email with this patch (or in commit message).

There are 6 other instances of .PHONY in the makefile, having the .PHONY 
localized seemed to make it the most obvious since it was right next to 
the actual target.

> 
>> +gitweb: gitweb/gitweb.cgi
>>  ifdef JSMIN
>>  OTHER_PROGRAMS += gitweb/gitweb.cgi   gitweb/gitweb.min.js
>>  gitweb/gitweb.cgi: gitweb/gitweb.perl gitweb/gitweb.min.js
>> @@ -1537,7 +1539,7 @@ endif
>>  	    -e 's|++GITWEB_JS++|$(GITWEB_JS)|g' \
>>  	    -e 's|++GITWEB_SITE_HEADER++|$(GITWEB_SITE_HEADER)|g' \
>>  	    -e 's|++GITWEB_SITE_FOOTER++|$(GITWEB_SITE_FOOTER)|g' \
>> -	    $< >$@+ && \
>> +	    $(patsubst %.cgi,%.perl,$@) >$@+ && \
> 
> Why this change?

Preparation for a later change.  The change could happen all at the same 
time if it makes more logical sense.

> 
>>  	chmod +x $@+ && \
>>  	mv $@+ $@
>>  
>> diff --git a/gitweb/Makefile b/gitweb/Makefile
>> new file mode 100644
>> index 0000000..8d318b3
>> --- /dev/null
>> +++ b/gitweb/Makefile
>> @@ -0,0 +1,14 @@
>> +SHELL = /bin/bash
> 
> Why is this needed?
> 
>> +
>> +FILES = gitweb.cgi
>> +
>> +.PHONY: $(FILES)
> 
> Why .PHONY?  $(FILES) are created.

 From this makefile I wanted to explicitly call up to the main makefile 
no matter what, the main makefile doesn't consider the targets .PHONY 
and it has all the dependencies that it would expect.

>> +
>> +all: $(FILES)
>> +
>> +$(FILES):
>> +	$(MAKE) $(MFLAGS) -C ../ -f Makefile gitweb/$@
>> +
>> +clean:
>> +	rm -rf $(FILES)
>> +
