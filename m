From: Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>
Subject: Re: [PATCH v2] gitk: add -C <path> commandline parameter to change
 path
Date: Fri, 6 Nov 2015 12:49:41 +0200
Message-ID: <563C85C5.80703@gmail.com>
References: <CAPig+cSs0v88AiQwSrqm-wK7rY4RdykaVf5Axh5jFyij25rfvg@mail.gmail.com>
 <1446715164-19165-1-git-send-email-juhapekka.heikkila@gmail.com>
 <CAPig+cT9K2H_jzVNOHS0vaarU+tfDfp_=Z4c1n6o5EX9wE6JXA@mail.gmail.com>
Reply-To: juhapekka.heikkila@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Paul Mackerras <paulus@samba.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Nov 06 11:49:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZueaV-0001WQ-It
	for gcvg-git-2@plane.gmane.org; Fri, 06 Nov 2015 11:49:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1033189AbbKFKtj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2015 05:49:39 -0500
Received: from mga02.intel.com ([134.134.136.20]:21482 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031997AbbKFKti (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2015 05:49:38 -0500
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP; 06 Nov 2015 02:49:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,251,1444719600"; 
   d="scan'208";a="844605917"
Received: from jheikkil-mobl2.fi.intel.com (HELO [10.237.66.34]) ([10.237.66.34])
  by fmsmga002.fm.intel.com with ESMTP; 06 Nov 2015 02:49:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <CAPig+cT9K2H_jzVNOHS0vaarU+tfDfp_=Z4c1n6o5EX9wE6JXA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280973>

On 06.11.2015 11:48, Eric Sunshine wrote:
> On Thu, Nov 5, 2015 at 4:19 AM, Juha-Pekka Heikkila
> <juhapekka.heikkila@gmail.com> wrote:
>> This patch adds -C (change working directory) parameter to
>> gitk. With this parameter, instead of need to cd to directory
>> with .git folder, one can point the correct folder from
>> commandline.
>
> Thanks, -C makes more sense than --cwd, and is more consistent with
> other commands.
>
> You'll want to also address the patch to Paul Mackerras (I've cc:'d
> him) since he's the gitk maintainer, and Junio pulls gitk from him.
>
>> v2: Adjusted the parameter as per Eric's suggestion. I think
>>      it now work in similar manner as in many GNU tools as well
>>      as git itself.
>
> This sort of explanation of of changes between versions is definitely
> welcome, but should be placed below the "---" line just under your
> sign-off so that it does not become part of the permanent commit
> message.

Ok, I'll make bit later another version. I didn't realize to check where 
to put this comment as some projects want these in the commit message.

>
>> Signed-off-by: Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>
>> ---
>
> You'd place your commentary about changes between patch versions here.
> More below...
>
>>   Documentation/gitk.txt |  7 +++++++
>>   gitk-git/gitk          | 26 +++++++++++++++++---------
>>   2 files changed, 24 insertions(+), 9 deletions(-)
>>
>> diff --git a/gitk-git/gitk b/gitk-git/gitk
>> @@ -12279,20 +12279,14 @@ setui $uicolor
>>
>>   setoptions
>>
>> -# check that we can find a .git directory somewhere...
>> -if {[catch {set gitdir [exec git rev-parse --git-dir]}]} {
>> -    show_error {} . [mc "Cannot find a git repository here."]
>> -    exit 1
>> -}
>> -
>>   set selecthead {}
>>   set selectheadid {}
>>
>>   set revtreeargs {}
>>   set cmdline_files {}
>> -set i 0
>>   set revtreeargscmd {}
>> -foreach arg $argv {
>> +for {set i 0} {$i < [llength $argv]} {incr i} {
>> +       set arg [lindex $argv [expr {$i}]]
>>       switch -glob -- $arg {
>>          "" { }
>>          "--" {
>> @@ -12305,11 +12299,25 @@ foreach arg $argv {
>>          "--argscmd=*" {
>>              set revtreeargscmd [string range $arg 10 end]
>>          }
>> +       "-C*" {
>> +               if {[string length $arg] < 3} {
>> +                       incr i
>> +                       cd [lindex $argv [expr {$i}]]
>
> What happens if no arguments follow -C (that is, the entire
> command-line is "gitk -C")? Will this simply run "cd" with no argument
> or with an empty argument or error out or what? Should there be a
> check for this condition?
>
>> +                       continue
>
> Why does this 'continue' need to be here? Am I missing something obvious?
>

I'll add the missing try/catch for these cd commands, I slowly start to 
understand how tcl work. Earlier catch was not for some reason needed 
here when the loop was ran with 'foreach', error was reported once 
reached UI but now it seem to advertise "error in startup script.." 
'continue' was part of this skipping but doesn't do its trick anymore.

Anyway, I'll make v3 and resend. :)

>> +               } else {
>> +                       cd [string range $arg 2 end]
>> +               }
>> +       }
>>          default {
>>              lappend revtreeargs $arg
>>          }
>>       }
>> -    incr i
>> +}
>> +
>> +# check that we can find a .git directory somewhere...
>> +if {[catch {set gitdir [exec git rev-parse --git-dir]}]} {
>> +    show_error {} . [mc "Cannot find a git repository here."]
>> +    exit 1
>>   }
>>
>>   if {$selecthead eq "HEAD"} {
>> --
>> 1.9.1
