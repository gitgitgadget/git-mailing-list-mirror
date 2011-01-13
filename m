From: Marc Strapetz <marc.strapetz@syntevo.com>
Subject: Re: Applying .gitattributes text/eol changes
Date: Thu, 13 Jan 2011 15:28:03 +0100
Message-ID: <4D2F0BF3.2000808@syntevo.com>
References: <4D220500.2000104@syntevo.com> <4D2C4902.4010705@drmicha.warpmail.net> <4D2C62DF.20706@syntevo.com> <4D2EFCBD.4020402@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Jan 13 15:28:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdO9x-00012a-DZ
	for gcvg-git-2@lo.gmane.org; Thu, 13 Jan 2011 15:28:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756842Ab1AMO2L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jan 2011 09:28:11 -0500
Received: from syntevo.com ([85.214.39.145]:37804 "EHLO syntevo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756755Ab1AMO2K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jan 2011 09:28:10 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1]) with ESMTPSA id 0E8EF174006
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.13) Gecko/20101207 Lightning/1.0b2 Thunderbird/3.1.7
In-Reply-To: <4D2EFCBD.4020402@drmicha.warpmail.net>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165053>

>> case of missing .git/index, Git freshly writes all working tree files,
>> ignoring already existing files which already have the correct content.
>> Maybe this behavior is by intention and makes sense in some cases. In my
>> case it has adverse effects on IDEs and probably other tools which are
>> monitoring the file system.
> 
> ...but changing gitattributes is something you don't do routinely in
> your workflow; so, at worst there would be an occasional unnecessary run
> of your build process.

Our Git-SVN bridge does it, potentially on every pull. This is why we
currently need to run "rm .git/index && git reset --hard" after every
pull, resp. every checkout (switching to another commit may result in
changed .gitattributes as well).

If a "git checkout" would (optionally) make sure that all EOLs are
properly set according to .gitattributes, the problem would be resolved.
As this might be not so easy to implement, my suggestion was to make
"git reset --hard" work more unobtrusive. I think we can provide a
corresponding patch, if it has chances to get accepted.

--
Best regards,
Marc Strapetz
=============
syntevo GmbH
http://www.syntevo.com
http://blog.syntevo.com



On 13.01.2011 14:23, Michael J Gruber wrote:
> Marc Strapetz venit, vidit, dixit 11.01.2011 15:02:
>> On 11.01.2011 13:11, Michael J Gruber wrote:
>>> Marc Strapetz venit, vidit, dixit 03.01.2011 18:18:
>>>> I'm looking for an unobtrusive way to apply (committed) changes for
>>>> text/eol attributes to the working tree. For instance, after having
>>>> changed "*.txt eol=crlf" to "*.txt eol=lf", all *.txt files should be
>>>> converted from CRLF to LF endings. The only advice I found so far is to
>>>> remove .git/index and do a reset --hard. The disadvantage of this
>>>> approach is that every file will be touched:
>>>>
>>>> - although the content does not change, timestamps will be changed. This
>>>
>>> The bytewise content does change.
>>
>> The content has only changed for *.txt files, but the timestamps of
>> *all* files are updated. I guess (but didn't verify from code), that in
> 
> Well, sure...
> 
>> case of missing .git/index, Git freshly writes all working tree files,
>> ignoring already existing files which already have the correct content.
>> Maybe this behavior is by intention and makes sense in some cases. In my
>> case it has adverse effects on IDEs and probably other tools which are
>> monitoring the file system.
> 
> ...but changing gitattributes is something you don't do routinely in
> your workflow; so, at worst there would be an occasional unnecessary run
> of your build process.
> 
>>
>>>> One solution I could think of which might be helpful in other situations
>>>> as well would be to have an "--unobtrusive" option for reset which would
>>>> only replace a file if the content has actually been changed.
>>>
>>> How about
>>>
>>> git ls-files \*.txt | xargs touch -a
>>> git ls-files \*.txt | git checkout
>>
>> That won't be helpful as it requires me to know what has changed.
> 
> But you do know that only (at most) *.txt have changed!
> 
> Michael
> 
> 
