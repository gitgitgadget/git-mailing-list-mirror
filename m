From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Cleaning up history with git rebase
Date: Thu, 04 Aug 2011 14:18:47 -0000
Message-ID: <d62225a3cc5740cda7cb163a94d55892-mfwitten@gmail.com>
References: <0111E44E-B85F-4C90-8052-E52BA9CD3D17@linea.gov.br>
            <34ca77f818944acb9f5c6f19d91df73f-mfwitten@gmail.com>
            <CAMOZ1BvRDSkzJmASNFQvZ-SVBUXZHw6CyfLP4SJqK8CwaMMDUA@mail.gmail.com>
            <317AAE40-449B-4280-AEF1-10EE93FDB9FF@linea.gov.br>
            <7af8ef40e0034e81a63f1d4a53bf082e-mfwitten@gmail.com>
            <1b66c8efe0214915be2c52a5aacd22de-mfwitten@gmail.com>
Cc: Ricky Egeland <rickyegeland@linea.gov.br>, git@vger.kernel.org
To: Patricia Bittencourt Egeland <pbegeland@linea.gov.br>
X-From: git-owner@vger.kernel.org Thu Aug 04 16:22:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoyoN-00009m-TC
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 16:22:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751850Ab1HDOWE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 10:22:04 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:36963 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312Ab1HDOWD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 10:22:03 -0400
Received: by ewy4 with SMTP id 4so908325ewy.19
        for <git@vger.kernel.org>; Thu, 04 Aug 2011 07:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=subject:date:from:to:cc:message-id:in-reply-to:references;
        bh=FS2nbn50p9PSg8HT19febZqkkWLo6qlBzlVeHAqerSg=;
        b=kox2CBZmoRMoq+LKnokbYEhETR0kbp/q9IoITUZF5gtMcNmATNqLAnbM5ogILbjpzD
         xXMZTYBY8gWhZUQaNmLAeqBU+zERjGxnD1h5ulGTf3I6W/NwNrw2SW0KdTwL37aVTxJ3
         4YrtHPWeDUbBCcQQifyFLyHdfMhgdXQ7D/rJc=
Received: by 10.204.136.151 with SMTP id r23mr324433bkt.28.1312467722307;
        Thu, 04 Aug 2011 07:22:02 -0700 (PDT)
Received: from gmail.com (tor6.anonymizer.ccc.de [80.237.226.76])
        by mx.google.com with ESMTPS id q1sm3159210faa.1.2011.08.04.07.21.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 04 Aug 2011 07:22:00 -0700 (PDT)
In-Reply-To: <1b66c8efe0214915be2c52a5aacd22de-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178747>

On Mon, 01 Aug 2011 01:07:33 -0000, Michael Witten wrote:

> Michael Witten wrote:
>
>> On Sun, 31 Jul 2011 18:44:43 -0300, Ricky, Egeland wrote:
>>
>>> On Jul 31, 2011, at 6:33 PM, Michael Witten wrote:
>>> 
>>>> On Sun, Jul 31, 2011 at 20:21, Michael Witten <mfwitten@gmail.com> wrote:
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
>>> Not sure.  Seems that it does not, it makes me resolve the conflict =
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

I noticed that my script has another problem; the line:

  rebase_head=$commit

should be:

  rebase_head=$(git rev-parse HEAD)

I was trying to make an optimization, but it's the wrong
logic :-/

Sorry for the confusion. Here is an updated version of
the entire script:

  git branch saved
  git rev-list HEAD --reverse --first-parent --parents |
  {
    read root
    git reset --hard $root
    rebase_head=$root

    while read commit first_parent other_parents; do

      if [ -z "$other_parents" ]; then

        git cherry-pick $commit

      else

        for parent in $other_parents; do

          if ! git cherry-pick $parent; then

            git reset --hard $rebase_head
            git merge $other_parents
            git rm -rf .
            git checkout $commit -- .
            git commit -aC $commit
            break

          fi

        done

      fi

      rebase_head=$(git rev-parse HEAD)

    done
  }
