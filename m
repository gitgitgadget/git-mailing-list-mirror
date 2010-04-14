From: Mark Rada <marada@uwaterloo.ca>
Subject: Re: [PATCHv5 2/6] Gitweb: add support for minifying gitweb.css
Date: Wed, 14 Apr 2010 15:17:44 -0400
Message-ID: <4BC614D8.2000208@mailservices.uwaterloo.ca>
References: <4BB430C3.9030000@mailservices.uwaterloo.ca> <201004140030.47222.jnareb@gmail.com> <4BC55558.1060608@mailservices.uwaterloo.ca> <201004141922.20213.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Mark Rada <marada@uwaterloo.ca>,
	Charles Bailey <charles@hashpling.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 14 21:18:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O286X-0000Ju-Ve
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 21:18:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752369Ab0DNTSZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 15:18:25 -0400
Received: from mailservices.uwaterloo.ca ([129.97.128.141]:52832 "EHLO
	mailchk-m03.uwaterloo.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751047Ab0DNTSY (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Apr 2010 15:18:24 -0400
Received: from karakura.local (static-66-225-153-161.ptr.terago.net [66.225.153.161])
	(authenticated bits=0)
	by mailchk-m03.uwaterloo.ca (8.13.8/8.13.8) with ESMTP id o3EJHik0009651
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 14 Apr 2010 15:17:45 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <201004141922.20213.jnareb@gmail.com>
X-UUID: ef20c2d3-fd93-4d8a-856b-9e19d771766c
X-Miltered: at mailchk-m03 with ID 4BC614D8.003 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: clamav-milter 0.95.3 at mailchk-m03
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (mailchk-m03.uwaterloo.ca [129.97.128.141]); Wed, 14 Apr 2010 15:17:48 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144893>

On 10-04-14 1:22 PM, Jakub Narebski wrote:
> On Wed, 14 Apr 2010, Mark Rada wrote:
>> On 10-04-13 6:30 PM, Jakub Narebski wrote:
>>> On Tue, 13 April 2010, Charles Bailey wrote:
>>>> On 01/04/2010 06:36, Mark Rada wrote:
> 
> [...]
>>>>> +gitweb.cgi: gitweb.perl $(GITWEB_JS) $(GITWEB_CSS)
>>>>>
>>>>
>>>> I have a question about this last line of the patch. Are GITWEB_JS and 
>>>> GITWEB_CSS supposed to be a source path or a URI?
>>>>
>>>> The documentation for install (and my previous assumption) was that they 
>>>> represented the path on the target web server. I'm used to overriding 
>>>> them so that gitweb.cgi can live in my /cgi-bin directory, but the 
>>>> static files are served from /gitweb which is readable but not executable.
>>>>
>>>> After this patch I had to removed $(GITWEB_JS) and $(GITWEB_CSS) from 
>>>> the list of dependencies for gitweb.cgi otherwise make failed.
>>>>
>>>> Have I got the wrong end of the stick?
>>>
>>> Thanks a lot for noticing this bug.
>>>
>>>
>>> GITWEB_JS and GITWEB_CSS were originally meant to be URI to file with
>>> gitweb JavaScript code and default gitweb stylesheet,... but during work
>>> on minification of JavaScript code and CSS file it somehow got confused
>>> to mean source path.
>>>
>>> If I remember correctly the original patch, before adding required
>>> support for minified gitweb.js and gitweb.css to git-instaweb script,
>>> and before support for CSS minification had
>>>
>>>    ifdef JSMIN
>>>    gitweb.cgi: gitweb.perl gitweb.min.js
>>>    else
>>>    gitweb.cgi: gitweb.perl
>>>    endif
>>>
>>> which should probably be replaced in current situation by
>>>
>>>    ifdef JSMIN
>>>    gitweb.cgi : gitweb.min.js
>>>    endif
>>>    ifdef CSSMIN
>>>    gitweb.cgi : gitweb.min.css
>>>    endif
>>>
>>> just adding prerequisites to gitweb.css target in gitweb/Makefile
>>>
>>>
>>> I guess that support for adding minifiction support to git-instaweb
>>> would need to be more complicated. [...]
>>
>> Aw, frig, never thought of using gitweb like that so I made some
>> assumptions to make things cleaner looking.
>>
>> I think this can be fixed by just using different variable names? Or
>> perhaps some nested ifdef's? I'm not sure which will be better.
>>
>> I wasn't at the computer today so I'm just getting to it now, I'll try
>> to have something when in the next day, going to bed now. Good night.
> 
> I think the best solution for prerequisites would be to have multiple 
> target-only (without commands) rules, which according to make 
> documentation would get concatenated.  This means the following code
> in gitweb/Makefile:
> 
>     ifdef JSMIN
>     gitweb.cgi : gitweb.min.js
>     endif
>     ifdef CSSMIN
>     gitweb.cgi : gitweb.min.css
>     endif
> 
> in place of
> 
>    gitweb.cgi: gitweb.perl $(GITWEB_JS) $(GITWEB_CSS)
> 

Hmm, I like this because it is clear (if you know that dependancies
can be joined like that), I was thinking of trying to make a smaller fix
using pathsubst or subst, but that seems to not be as simple as I wanted it
to be.

> For git-instaweb I think that best solution would be to introduce new
> variables holding _source_ of gitweb JavaScript code and CSS, e.g.
> 
>             -e '/@@GITWEB_CSS@@/r $(GITWEB_CSS)' \
> 
> in place of
> 
>             -e '/@@GITWEB_CSS@@/r $(GITWEB_CSS_SOURCE)' \
> 
> ...although GITWEB_CSS might mean something different for Makefile
> and git-instaweb than for gitweb/Makefile and gitweb itself.

Did you get those lines mixed up? I might be not understanding something
here.

I was actually planning something along the lines of 

             -e '/@@GITWEB_CSS@@/r $(GITWEB_CSS_NAME)' \
             -e 's|@@GITWEB_CSS_NAME@@|$(GITWEB_CSS_NAME)|' \

where I introduce the GITWEB_CSS_NAME variable, to be consistent with the
token in instaweb. This way we don't touch GITWEB_JS in the top level
makefile.

Also, I should update dependancies for instaweb, since those were
forgotten last time around. Just creating a short list of what the fix will
need for when I get home tonight.

-- 
Mark Rada
