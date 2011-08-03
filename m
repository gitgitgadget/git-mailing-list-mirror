From: pbegeland <pbegeland@linea.gov.br>
Subject: Re: Cleaning up history with git rebase
Date: Wed, 03 Aug 2011 17:58:26 -0300
Message-ID: <80e62eb56a83a138a79e112e382da4ae@linea.gov.br>
References: <0111E44E-B85F-4C90-8052-E52BA9CD3D17@linea.gov.br>
 <34ca77f818944acb9f5c6f19d91df73f-mfwitten@gmail.com>
 <CAMOZ1BvRDSkzJmASNFQvZ-SVBUXZHw6CyfLP4SJqK8CwaMMDUA@mail.gmail.com>
 <317AAE40-449B-4280-AEF1-10EE93FDB9FF@linea.gov.br>
 <7af8ef40e0034e81a63f1d4a53bf082e-mfwitten@gmail.com>
 <1b66c8efe0214915be2c52a5aacd22de-mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: Ricky Egeland <rickyegeland@linea.gov.br>, <git@vger.kernel.org>
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 03 23:05:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qoicu-0007F4-5p
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 23:05:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754918Ab1HCVFL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 17:05:11 -0400
Received: from mx1.linea.gov.br ([200.143.212.2]:40110 "EHLO mx1.linea.gov.br"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754890Ab1HCVFJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 17:05:09 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Aug 2011 17:05:08 EDT
Received: (qmail 25250 invoked from network); 3 Aug 2011 20:58:26 -0000
Received: from unknown (HELO roundcube) (pbegeland@[10.1.1.3])
          (envelope-sender <pbegeland@linea.gov.br>)
          by mx1.linea.gov.br (qmail-ldap-1.03) with SMTP
          for <mfwitten@gmail.com>; 3 Aug 2011 20:58:26 -0000
In-Reply-To: <1b66c8efe0214915be2c52a5aacd22de-mfwitten@gmail.com>
X-Sender: pbegeland@linea.gov.br
User-Agent: RoundCube Webmail/0.4.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178620>

 Dear Michael,

      I tried to run the script in my repo. However, seems like the 'git 
 merge $other_parents' process fails. In the script output I see some 
 lines saying that files were not able to be merged, ie:

 warning: Cannot merge binary files: 
 scienceportal/images/tabs/tabs-gray.png (HEAD vs. 
 84f6fc283861aa7c5798f58769789dd0b91a5e9d)
 warning: Cannot merge binary files: scienceportal/images/waiting.gif 
 (HEAD vs. e033cbbf1e9d24b66cb55a04701c059dc945c1c3)

      Do you have some suggestion?

 Thanks,
 Patricia


 On Mon, 01 Aug 2011 01:07:33 -0000, Michael Witten <mfwitten@gmail.com> 
 wrote:
> Michael Witten wrote:
>
>> On Sun, 31 Jul 2011 18:44:43 -0300, Ricky, Egeland wrote:
>>
>>> On Jul 31, 2011, at 6:33 PM, Michael Witten wrote:
>>>
>>>> On Sun, Jul 31, 2011 at 20:21, Michael Witten <mfwitten@gmail.com> 
>>>> wrote:
>>>>> Why are there conflicts anyway?
>>>>
>>>> Oh...
>>>>
>>>> I guess there were conflicts when the merge commit was made in
>>>> the original repository, and these conflicts were resolved by
>>>> the merge commit itself. Hence, when rebase tries to split up
>>>> a merge by dealing with just the non-merge parents, you end up
>>>> having to deal with the conflict again.
>>>
>>> Yes, I thought it was something like this going on, too. In the
>>> pre-rebase history, when there is a commit with "Conflict:" and
>>> listing file which is in the sub-repository history, this is a
>>> point where rebase stops with a conflict.
>>>
>>>> Shouldn't rebase take this into account?
>>>
>>> Not sure.  Seems that it does not, it makes me resolve the conflict 
>>> =
>>> again.
>>
>> I think git rebase should take this into account is what I'm saying.
>>
>> The following implements what I think `git rebase' should be doing;
>> run it instead of `git rebase' in your repo:
>>
>>   git branch saved
>>   git rev-list HEAD --reverse --first-parent --parents |
>>   {
>>     read root
>>     git reset --hard $root
>>     rebase_head=$root
>>
>>     while read commit first_parent other_parents; do
>>
>>       if [ -z "$other_parents" ]; then
>>
>>         git cherry-pick $commit
>>         rebase_head=$commit
>>
>>       else
>>
>>         for parent in $other_parents; do
>>
>>           if ! git cherry-pick $parent; then
>>
>>             git reset --hard $rebase_head
>>             git merge $other_parents
>>             git rm -rf .
>>             git checkout -- $commit
>>             git commit -aC $commit
>>             break
>>
>>           fi
>>
>>         done
>>
>>         rebase_head=$(git rev-parse HEAD)
>>
>>       fi
>>
>>     done
>>   }
>
> Woops!
>
> This line:
>
>   git checkout -- $commit
>
> should be:
>
>   git checkout $commit -- .
