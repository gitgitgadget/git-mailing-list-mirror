From: Josef Assad <josef@josefassad.com>
Subject: Re: [PATCH] more meaningful error message in gitk when git binary
 is not available
Date: Mon, 01 Oct 2012 19:24:01 +0200
Message-ID: <5069D1B1.3030703@josefassad.com>
References: <50694380.4090108@josefassad.com> <7va9w6dsnq.fsf@alter.siamese.dyndns.org> <5069D0FE.4000609@josefassad.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 01 19:31:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIjj9-00058N-8i
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 19:24:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211Ab2JARYG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2012 13:24:06 -0400
Received: from li144-85.members.linode.com ([109.74.197.85]:38351 "EHLO
	li144-85.members.linode.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750991Ab2JARYE (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Oct 2012 13:24:04 -0400
Received: from [192.168.1.11] (unknown [2.107.83.160])
	by li144-85.members.linode.com (Postfix) with ESMTPA id 9AFA21CB1D;
	Mon,  1 Oct 2012 13:24:02 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <5069D0FE.4000609@josefassad.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206743>

On 10/01/2012 07:21 PM, Josef Assad wrote:
> On 10/01/2012 07:11 PM, Junio C Hamano wrote:
>> Josef Assad <josef@josefassad.com> writes:
>>
>>> Signed-off-by: Josef Assad <josef@josefassad.com>
>>> ---
>>>  gitk-git/gitk |    6 ++++++
>>>  1 files changed, 6 insertions(+), 0 deletions(-)
>>
>> Thanks.
>>
>>> diff --git a/gitk-git/gitk b/gitk-git/gitk
>>> index d93bd99..7e2e0a7 100755
>>> --- a/gitk-git/gitk
>>> +++ b/gitk-git/gitk
>>> @@ -11680,6 +11680,12 @@ setui $uicolor
>>>
>>>  setoptions
>>>
>>> +# check that the git executables are available for use
>>> +if [catch {set gitexists [exec which git]}] {
>>> +    show_error {} . [mc "Cannot find a suitable git executable."]
>>> +    exit 1
>>> +}
>>> +
>>>  # check that we can find a .git directory somewhere...
>>>  if {[catch {set gitdir [exec git rev-parse --git-dir]}]} {
>>>      show_error {} . [mc "Cannot find a git repository here."]
>>
>> It is somewhat a stupid solution to add an extra fork that will only
>> waste cycles in the normal non-error case, especially when we
>> already have an error codepath that acts on lack of the "git"
>> command anyway, isn't it?
> 
> I don't think it's actually _stupid_, but I also think your solution
> works better if you're trying to avoid one more exec call.
> 
> Mine has one less level of indentation though, and it has clearer
> delineation between checking for and handling two distinct error
> conditions. :)
> 
>> The "rev-parse" you see in the post-context will fail when we are
>> not in a git repository, but it will also fail when we do not have
>> git.
>>
>> You can add the new check to if {[catch {... git rev-parse }]} block;
>> before unconditionally saying "cannot find a git repo", you check if
>> "git" even exists, and give an appropriate error message.  That way,
>> you do not punish normal use case with an extra useless fork.
>>
>> Something like this, I presume.
>>
>>
>>  gitk | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/gitk b/gitk
>> index d93bd99..60794a7 100755
>> --- a/gitk
>> +++ b/gitk
>> @@ -11682,7 +11682,12 @@ setoptions
>>  
>>  # check that we can find a .git directory somewhere...
>>  if {[catch {set gitdir [exec git rev-parse --git-dir]}]} {
>> -    show_error {} . [mc "Cannot find a git repository here."]
>> +    # we could have failed because there is no git to begin with
>> +    if {[catch {exec git version}]} {
>> +        show_error {} . [mc "You do not seem to have 'git' command."]
>> +    } else {
>> +        show_error {} . [mc "Cannot find a git repository here."]
>> +    }
>>      exit 1
>>  }
> 
> I'm neutral though and not married to my patch in any way, just trying
> to be helpful. In my opinon, yours is cleaner, mine is a tiny bit more
> readable in a file already closing on 12k lines.
> 

Bah, forgot to Cc list. My bad.
