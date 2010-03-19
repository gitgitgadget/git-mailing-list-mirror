From: Mark Rada <marada@uwaterloo.ca>
Subject: Re: [PATCH] instaweb: use minified gitweb.js if available
Date: Fri, 19 Mar 2010 10:07:53 -0400
Message-ID: <4BA38539.8060503@mailservices.uwaterloo.ca>
References: <4BA3138F.1010201@mailservices.uwaterloo.ca> <4BA32961.6080901@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Mar 19 15:12:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nscvj-00015I-Gz
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 15:12:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752460Ab0CSOLu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 10:11:50 -0400
Received: from mailservices.uwaterloo.ca ([129.97.128.141]:47646 "EHLO
	mailchk-m02.uwaterloo.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752265Ab0CSOLt (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Mar 2010 10:11:49 -0400
Received: from bas1-toronto01-1177657629.dsl.bell.ca (bas1-toronto01-1177657629.dsl.bell.ca [70.49.161.29])
	(authenticated bits=0)
	by mailchk-m02.uwaterloo.ca (8.13.8/8.13.8) with ESMTP id o2JE7rub000710
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 19 Mar 2010 10:08:25 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.7) Gecko/20100111 Thunderbird/3.0.1
In-Reply-To: <4BA32961.6080901@viscovery.net>
X-UUID: cd14c16d-3b69-41a8-8f2a-ff35544598ac
X-Miltered: at mailchk-m02 with ID 4BA38539.003 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: clamav-milter 0.95.3 at mailchk-m02
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (mailchk-m02.uwaterloo.ca [129.97.128.141]); Fri, 19 Mar 2010 10:08:27 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142599>

On 10-03-19 3:36 AM, Johannes Sixt wrote:
> Mark Rada schrieb:
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -1551,12 +1551,12 @@ gitweb:
>>  	$(QUIET_SUBDIR0)gitweb $(QUIET_SUBDIR1) all
>>   ifdef JSMIN
>> -OTHER_PROGRAMS += gitweb/gitweb.cgi   gitweb/gitweb.min.js
>> -gitweb/gitweb.cgi: gitweb/gitweb.perl gitweb/gitweb.min.js
>> +GITWEB_JS=gitweb/gitweb.min.js
>>  else
>> -OTHER_PROGRAMS += gitweb/gitweb.cgi
>> -gitweb/gitweb.cgi: gitweb/gitweb.perl
>> +GITWEB_JS=gitweb/gitweb.js
>>  endif
>> +OTHER_PROGRAMS += gitweb/gitweb.cgi $(GITWEB_JS)
>> +gitweb/gitweb.cgi: gitweb/gitweb.perl $(GITWEB_PROGRAMS)
>>  	$(QUIET_SUBDIR0)gitweb $(QUIET_SUBDIR1) $(patsubst gitweb/%,%,$@)
>>   ifdef JSMIN
>> @@ -1574,12 +1574,13 @@ git-instaweb: git-instaweb.sh gitweb/gitweb.cgi gitweb/gitweb.css gitweb/gitweb.
>>  	    -e '/@@GITWEB_CGI@@/d' \
>>  	    -e '/@@GITWEB_CSS@@/r gitweb/gitweb.css' \
>>  	    -e '/@@GITWEB_CSS@@/d' \
>> -	    -e '/@@GITWEB_JS@@/r gitweb/gitweb.js' \
>> +	    -e '/@@GITWEB_JS@@/r $(GITWEB_JS)' \
>>  	    -e '/@@GITWEB_JS@@/d' \
>>  	    -e 's|@@PERL@@|$(PERL_PATH_SQ)|g' \
>>  	    $@.sh > $@+ && \
>>  	chmod +x $@+ && \
>> -	mv $@+ $@
>> +	mv $@+ $@ && \
>> +	sed -i '' -e 's/min\.js/js/' $@
> 
> sed -i is not portable. But do you need it at all? Can't you add this
> change to the -e list above?

Hmm, the reason I made the change in a separate command was that
the only place that min.js needed to be modified was in gitweb.cgi
and only after it has been copied into git-instaweb.

We want to leave the actual gitweb.cgi as using gitweb.min.js, but
the way instaweb creates the gitweb directory makes it create a
gitweb.js no matter what (this is a bug if you create a minified
gitweb.js because gitweb.cgi will look for a non-existant
gitweb.min.js).

I figured that the smallest solution was to just edit the copied
gitweb.cgi to use gitweb.js again, but since it is not portable I
will have to either have messier code to do the same thing or
make git-instaweb change the name of gitweb.js only in the case
that we are using a minified gitweb.js.

Since I see no advantage or disadvantage to either, I'll flip a
coin to decide this later on when I have some time.


>> --- a/git-instaweb.sh
>> +++ b/git-instaweb.sh
>> @@ -397,6 +397,7 @@ EOFGITWEB
>>  gitweb_js () {
>>  	cat > "$1" <<\EOFGITWEB
>>  @@GITWEB_JS@@
>> +
>>  EOFGITWEB
>>  }
>>  -- 1.7.0.1.300.gd855a
> 
> This new blank line is an accident, isn't it?

Nope, this new line is here because the minifier I used cut the
extra new line from the end of gitweb.js and then the EOFGITWEB
token ended up on the same line as gitweb.js.

> -- Hannes
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Mark Rada (ferrous26)
marada@uwaterloo.ca
