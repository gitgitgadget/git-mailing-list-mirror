From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Cleaning up history with git rebase
Date: Sun, 31 Jul 2011 18:02:31 -0700 (PDT)
Message-ID: <7af8ef40e0034e81a63f1d4a53bf082e-mfwitten@gmail.com>
References: <0111E44E-B85F-4C90-8052-E52BA9CD3D17@linea.gov.br>
            <34ca77f818944acb9f5c6f19d91df73f-mfwitten@gmail.com>
            <CAMOZ1BvRDSkzJmASNFQvZ-SVBUXZHw6CyfLP4SJqK8CwaMMDUA@mail.gmail.com>
            <317AAE40-449B-4280-AEF1-10EE93FDB9FF@linea.gov.br>
Cc: Patricia Bittencourt Egeland <pbegeland@linea.gov.br>,
	git@vger.kernel.org
To: Ricky Egeland <rickyegeland@linea.gov.br>
X-From: git-owner@vger.kernel.org Mon Aug 01 03:02:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qngty-0008AO-MM
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 03:02:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753382Ab1HABCf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jul 2011 21:02:35 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39629 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753323Ab1HABCd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2011 21:02:33 -0400
Received: by fxh19 with SMTP id 19so4039894fxh.19
        for <git@vger.kernel.org>; Sun, 31 Jul 2011 18:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:subject:from:to:cc:message-id:in-reply-to:references;
        bh=iHf/O4qlgHb940uKQ4b/Jf2acYf/XX7T6CBIQAn5GeQ=;
        b=TND17OGlP++d0EV6SYkZaqvKpGiVYWPTZARc8vHw4kHZNZupA3PGoi4NYiSZwLktyL
         WFRqLy/bTywRGjaHe+FUhfBwR7QXVHz7mxG8omHr/cy+UwdvQF2V3kDZ1W4N3T9Ke4cr
         hf3E2gAsGzjcbmr9E/2eOd09iMBDwsxaRs9jM=
Received: by 10.204.141.208 with SMTP id n16mr1014080bku.48.1312160552176;
        Sun, 31 Jul 2011 18:02:32 -0700 (PDT)
Received: from gmail.com (tor-exit-router37-readme.formlessnetworking.net [199.48.147.37])
        by mx.google.com with ESMTPS id p16sm1154379bku.64.2011.07.31.18.02.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 31 Jul 2011 18:02:31 -0700 (PDT)
In-Reply-To: <317AAE40-449B-4280-AEF1-10EE93FDB9FF@linea.gov.br>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178289>

On Sun, 31 Jul 2011 18:44:43 -0300, Ricky, Egeland wrote:

> On Jul 31, 2011, at 6:33 PM, Michael Witten wrote:
> 
>> On Sun, Jul 31, 2011 at 20:21, Michael Witten <mfwitten@gmail.com> wrote:
>>> Why are there conflicts anyway?
>>
>> Oh...
>>
>> I guess there were conflicts when the merge commit was made in
>> the original repository, and these conflicts were resolved by
>> the merge commit itself. Hence, when rebase tries to split up
>> a merge by dealing with just the non-merge parents, you end up
>> having to deal with the conflict again.
> 
> Yes, I thought it was something like this going on, too. In the
> pre-rebase history, when there is a commit with "Conflict:" and
> listing file which is in the sub-repository history, this is a
> point where rebase stops with a conflict.
> 
>> Shouldn't rebase take this into account?
> 
> Not sure.  Seems that it does not, it makes me resolve the conflict =
> again.

I think git rebase should take this into account is what I'm saying.

The following implements what I think `git rebase' should be doing;
run it instead of `git rebase' in your repo:

  git branch saved
  git rev-list HEAD --reverse --first-parent --parents |
  {
    read root
    git reset --hard $root
    rebase_head=$root

    while read commit first_parent other_parents; do

      if [ -z "$other_parents" ]; then

        git cherry-pick $commit
        rebase_head=$commit

      else

        for parent in $other_parents; do

          if ! git cherry-pick $parent; then

            git reset --hard $rebase_head
            git merge $other_parents
            git rm -rf .
            git checkout -- $commit
            git commit -aC $commit 
            break

          fi

        done

        rebase_head=$(git rev-parse HEAD)

      fi

    done
  }

Sincerely,
Michael Witten
