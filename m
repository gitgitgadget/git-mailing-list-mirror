From: Mark Rada <marada@uwaterloo.ca>
Subject: Re: [PATCHv5 2/6] Gitweb: add support for minifying gitweb.css
Date: Wed, 14 Apr 2010 01:40:40 -0400
Message-ID: <4BC55558.1060608@mailservices.uwaterloo.ca>
References: <4BB430C3.9030000@mailservices.uwaterloo.ca> <4BC4D3F0.5020107@hashpling.org> <201004140030.47222.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Charles Bailey <charles@hashpling.org>,
	Mark Rada <marada@uwaterloo.ca>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 14 07:41:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1vLW-00036x-TI
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 07:41:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752378Ab0DNFk7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 01:40:59 -0400
Received: from mailservices.uwaterloo.ca ([129.97.128.141]:37389 "EHLO
	mailchk-m05.uwaterloo.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751235Ab0DNFk6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Apr 2010 01:40:58 -0400
Received: from [192.168.26.20] (bas1-toronto01-1177657813.dsl.bell.ca [70.49.161.213])
	(authenticated bits=0)
	by mailchk-m05.uwaterloo.ca (8.13.8/8.13.8) with ESMTP id o3E5edR0032307
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 14 Apr 2010 01:40:40 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <201004140030.47222.jnareb@gmail.com>
X-UUID: 4be7569a-5dac-41aa-9332-bd366f306a85
X-Miltered: at mailchk-m05 with ID 4BC55557.002 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: clamav-milter 0.95.2 at mailchk-m05
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (mailchk-m05.uwaterloo.ca [129.97.128.141]); Wed, 14 Apr 2010 01:40:43 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144850>

On 10-04-13 6:30 PM, Jakub Narebski wrote:
> On Tue, 13 April 2010, Charles Bailey wrote:
>> On 01/04/2010 06:36, Mark Rada wrote:
>>> @@ -84,13 +92,14 @@ endif
>>>
>>>   all:: gitweb.cgi
>>>
>>> +FILES = gitweb.cgi
>>>   ifdef JSMIN
>>> -FILES=gitweb.cgi gitweb.min.js
>>> -gitweb.cgi: gitweb.perl gitweb.min.js
>>> -else # !JSMIN
>>> -FILES=gitweb.cgi
>>> -gitweb.cgi: gitweb.perl
>>> -endif # JSMIN
>>> +FILES += gitweb.min.js
>>> +endif
>>> +ifdef CSSMIN
>>> +FILES += gitweb.min.css
>>> +endif
>>> +gitweb.cgi: gitweb.perl $(GITWEB_JS) $(GITWEB_CSS)
>>>
>>
>> I have a question about this last line of the patch. Are GITWEB_JS and 
>> GITWEB_CSS supposed to be a source path or a URI?
>>
>> The documentation for install (and my previous assumption) was that they 
>> represented the path on the target web server. I'm used to overriding 
>> them so that gitweb.cgi can live in my /cgi-bin directory, but the 
>> static files are served from /gitweb which is readable but not executable.
>>
>> After this patch I had to removed $(GITWEB_JS) and $(GITWEB_CSS) from 
>> the list of dependencies for gitweb.cgi otherwise make failed.
>>
>> Have I got the wrong end of the stick?
> 
> Thanks a lot for noticing this bug.
> 
> 
> GITWEB_JS and GITWEB_CSS were originally meant to be URI to file with
> gitweb JavaScript code and default gitweb stylesheet,... but during work
> on minification of JavaScript code and CSS file it somehow got confused
> to mean source path.
> 
> If I remember correctly the original patch, before adding required
> support for minified gitweb.js and gitweb.css to git-instaweb script,
> and before support for CSS minification had
> 
>    ifdef JSMIN
>    gitweb.cgi: gitweb.perl gitweb.min.js
>    else
>    gitweb.cgi: gitweb.perl
>    endif
> 
> which should probably be replaced in current situation by
> 
>    ifdef JSMIN
>    gitweb.cgi : gitweb.min.js
>    endif
>    ifdef CSSMIN
>    gitweb.cgi : gitweb.min.css
>    endif
> 
> just adding prerequisites to gitweb.css target in gitweb/Makefile
> 
> 
> I guess that support for adding minifiction support to git-instaweb
> would need to be more complicated.  Perhaps
> 
>   $(notdir $(GITWEB_JS))   # Makefile function
> 
> or
> 
>   $(basename $GITWEB_JS)   # shell command
> 
> But I guess that it wouldn't work for all cases...
>

Aw, frig, never thought of using gitweb like that so I made some
assumptions to make things cleaner looking.

I think this can be fixed by just using different variable names? Or
perhaps some nested ifdef's? I'm not sure which will be better.

I wasn't at the computer today so I'm just getting to it now, I'll try
to have something when in the next day, going to bed now. Good night.

-- 
Mark Rada
