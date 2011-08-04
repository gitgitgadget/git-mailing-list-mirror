From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Cleaning up history with git rebase
Date: Thu, 04 Aug 2011 14:35:19 -0000
Message-ID: <b3e1c29767984546a61e2d10fb180188-mfwitten@gmail.com>
References: <0111E44E-B85F-4C90-8052-E52BA9CD3D17@linea.gov.br>
            <34ca77f818944acb9f5c6f19d91df73f-mfwitten@gmail.com>
            <CAMOZ1BvRDSkzJmASNFQvZ-SVBUXZHw6CyfLP4SJqK8CwaMMDUA@mail.gmail.com>
            <317AAE40-449B-4280-AEF1-10EE93FDB9FF@linea.gov.br>
            <7af8ef40e0034e81a63f1d4a53bf082e-mfwitten@gmail.com>
            <1b66c8efe0214915be2c52a5aacd22de-mfwitten@gmail.com>
            <80e62eb56a83a138a79e112e382da4ae@linea.gov.br>
Cc: Ricky Egeland <rickyegeland@linea.gov.br>, <git@vger.kernel.org>
To: Patricia Bittencourt Egeland <pbegeland@linea.gov.br>
X-From: git-owner@vger.kernel.org Thu Aug 04 16:38:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qoz3j-00010Q-FB
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 16:38:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754363Ab1HDOhv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 10:37:51 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:55875 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753774Ab1HDOhu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 10:37:50 -0400
Received: by eyx24 with SMTP id 24so491768eyx.19
        for <git@vger.kernel.org>; Thu, 04 Aug 2011 07:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=subject:date:from:to:cc:message-id:in-reply-to:references;
        bh=XYTenQG5RryYHUMmQ5lMJHS+4ZD8YwJc7GBiA9KsIsk=;
        b=amvFMN0EIEBe5PqgsyZCuyWlveISbvRkWGQtkJychK8lhyXprhD3P2qCi5XUg3Z0GI
         23mmw52LQDv8NMS+q6l3OLLpjGt5eXVQ0fh+VzvoP0Ruif/pSW5ucBSn0oixNGGhQrHS
         G3Xf379gpMyINwBfNQ2oHHYrKn4CcfnpgeLTA=
Received: by 10.213.27.146 with SMTP id i18mr700195ebc.34.1312468668551;
        Thu, 04 Aug 2011 07:37:48 -0700 (PDT)
Received: from gmail.com (bouazizi.torservers.net [74.120.13.132])
        by mx.google.com with ESMTPS id t1sm36092eeb.40.2011.08.04.07.37.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 04 Aug 2011 07:37:47 -0700 (PDT)
In-Reply-To: <80e62eb56a83a138a79e112e382da4ae@linea.gov.br>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178748>

[Put your reply text below the quoted text.]

On Wed, 03 Aug 2011 17:58:26 -0300, Patricia Egeland wrote:

> On Mon, 01 Aug 2011 01:07:33 -0000, Michael Witten wrote:
>
>> Michael Witten wrote:
>>
>>> On Sun, 31 Jul 2011 18:44:43 -0300, Ricky, Egeland wrote:
>>>
>>>> On Jul 31, 2011, at 6:33 PM, Michael Witten wrote:
>>>>
>>>>> On Sun, Jul 31, 2011 at 20:21, Michael Witten <mfwitten@gmail.com> 
>>>>> wrote:
>>>>>> Why are there conflicts anyway?
>>>>>
>>>>> Oh...
>>>>>
>>>>> I guess there were conflicts when the merge commit was made in
>>>>> the original repository, and these conflicts were resolved by
>>>>> the merge commit itself. Hence, when rebase tries to split up
>>>>> a merge by dealing with just the non-merge parents, you end up
>>>>> having to deal with the conflict again.
>>>>
>>>> Yes, I thought it was something like this going on, too. In the
>>>> pre-rebase history, when there is a commit with "Conflict:" and
>>>> listing file which is in the sub-repository history, this is a
>>>> point where rebase stops with a conflict.
>>>>
>>>>> Shouldn't rebase take this into account?
>>>>
>>>> Not sure.  Seems that it does not, it makes me resolve the conflict 
>>>> =
>>>> again.
>>>
>>> I think git rebase should take this into account is what I'm saying.
>>>
>>> The following implements what I think `git rebase' should be doing;
>>> run it instead of `git rebase' in your repo:
>>>
>>>   git branch saved
>>>   git rev-list HEAD --reverse --first-parent --parents |
>>>   {
>>>     read root
>>>     git reset --hard $root
>>>     rebase_head=$root
>>>
>>>     while read commit first_parent other_parents; do
>>>
>>>       if [ -z "$other_parents" ]; then
>>>
>>>         git cherry-pick $commit
>>>         rebase_head=$commit
>>>
>>>       else
>>>
>>>         for parent in $other_parents; do
>>>
>>>           if ! git cherry-pick $parent; then
>>>
>>>             git reset --hard $rebase_head
>>>             git merge $other_parents
>>>             git rm -rf .
>>>             git checkout -- $commit
>>>             git commit -aC $commit
>>>             break
>>>
>>>           fi
>>>
>>>         done
>>>
>>>         rebase_head=$(git rev-parse HEAD)
>>>
>>>       fi
>>>
>>>     done
>>>   }
>>
>> Woops!
>>
>> This line:
>>
>>   git checkout -- $commit
>>
>> should be:
>>
>>   git checkout $commit -- .
>
>      I tried to run the script in my repo. However, seems like the 'git 
> merge $other_parents' process fails. In the script output I see some 
> lines saying that files were not able to be merged, ie:
>
> warning: Cannot merge binary files: 
> scienceportal/images/tabs/tabs-gray.png (HEAD vs. 
> 84f6fc283861aa7c5798f58769789dd0b91a5e9d)
> warning: Cannot merge binary files: scienceportal/images/waiting.gif 
> (HEAD vs. e033cbbf1e9d24b66cb55a04701c059dc945c1c3)
>
>      Do you have some suggestion?

That's probably as expected; the script is coming across the conflict, but
it should be taking care of the conflict automatically.

Unfortunately, though, the results probably end up being almost completely
similar to the original un-rebased branch because the original script
actually has ANOTHER mistake (sorry!). See the updated version here (or
in your inbox):

  http://marc.info/?l=git&m=131246773005168&w=2
  Message-ID: <d62225a3cc5740cda7cb163a94d55892-mfwitten@gmail.com>
