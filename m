From: Chris Ridd <chris.ridd@isode.com>
Subject: Re: [PATCH] Improve sed portability
Date: Wed, 11 Jun 2008 16:29:53 +0100
Message-ID: <484FEF71.2030909@isode.com>
References: <1213189759-11565-1-git-send-email-chris.ridd@isode.com>
            <484FDB5D.7060606@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Wed Jun 11 17:31:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6SIE-0003ze-VG
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 17:31:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760725AbYFKP36 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 11:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760633AbYFKP36
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 11:29:58 -0400
Received: from rufus.isode.com ([62.3.217.251]:34833 "EHLO rufus.isode.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758874AbYFKP35 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 11:29:57 -0400
Received: from [172.16.0.138] (shiny.isode.com [62.3.217.250]) 
          by rufus.isode.com (submission channel) via TCP with ESMTPSA 
          id <SE=vcQBZBLpQ@rufus.isode.com> for <git@vger.kernel.org>;
          Wed, 11 Jun 2008 16:29:53 +0100
User-Agent: Thunderbird 2.0.0.14 (X11/20080507)
In-Reply-To: <484FDB5D.7060606@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84619>

Johannes Sixt wrote:
> Chris Ridd schrieb:
>> On Solaris /usr/bin/sed apparently fails to process input that doesn't
>> end in a \n. Consequently constructs like
>>
>>   re=$(printf '%s' foo | sed -e 's/bar/BAR/g' $)
>>
>> cause re to be set to the empty string.
> 
> So does /usr/bin/sed of AIX 4.3!

I ought to have mentioned this occurs on Solaris 8, 10, build 90 of 
OpenSolaris, and on HP-UX 11iv1. I stared at that regex for quite a 
while before realising the problem was with the input :-)

>> @@ -73,7 +73,7 @@ resolve_relative_url ()
>>  module_name()
>>  {
>>  	# Do we have "submodule.<something>.path = $1" defined in .gitmodules file?
>> -	re=$(printf '%s' "$1" | sed -e 's/[].[^$\\*]/\\&/g')
>> +	re=$(printf "%s\n" "$1" | sed -e 's/[].[^$\\*]/\\&/g')
> 
> You change sq into dq. Is this not dangerous? Shouldn't backslash-en be
> hidden from the shell so that printf can interpret it?

It is necessary to use double quotes. This:

     printf '%s\n' foobar

prints a literal \, a literal n, and no newline:

     foobar\n

Not desirable :-(

Of course, using a plain old:

     echo "$1"

should work well too. Why is printf being used here and not echo, anyway?

>>  	name=$( git config -f .gitmodules --get-regexp '^submodule\..*\.path$' |
>>  		sed -n -e 's|^submodule\.\(.*\)\.path '"$re"'$|\1|p' )
> 
> I trust you have tested this. But I wonder whether this leaves a stray
> newline in $re that gets in the way inside the sed expression...

Yes, I've tested this as we use submodules heavily. I think the $( .. ) 
notation will remove the trailing \n printed by sed, but to be sure I 
inserted a 'set -x' at the top of the module_name() function and 
double-checked that the re variable didn't get any stray \n 
character(s). Bash versions 2 and 3 were used.

So without the change, on Solaris I get:

     No submodule mapping found in .gitmodules for path 'foobar'

for the first submodule that we use, and the repository clone fails.

With the change, all our repositories clone OK.

Cheers,

Chris
