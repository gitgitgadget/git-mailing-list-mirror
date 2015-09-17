From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: Bug after removing a local branch and restore the remote branch
 during a rebase
Date: Thu, 17 Sep 2015 09:44:12 -0700
Message-ID: <CA+P7+xpKQasAQ3Qx4bbQWX7N4kQqknKGW7Xei6xCNEY=p7CraA@mail.gmail.com>
References: <CF93B86B-8CCF-483D-918A-47C910CEE8BA@surialabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Robert Strobl <robert.strobl@surialabs.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 18:44:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZccIW-0002v7-IU
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 18:44:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752027AbbIQQod convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Sep 2015 12:44:33 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:33850 "EHLO
	mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751488AbbIQQoc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Sep 2015 12:44:32 -0400
Received: by iofb144 with SMTP id b144so28504592iof.1
        for <git@vger.kernel.org>; Thu, 17 Sep 2015 09:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=VCxojPYFnYShmKklZARqProiDCJ2w6YOwbdihN+msyE=;
        b=LIERYLnb4v64qAQW0mKhcO0IN/4ObRtq4q/1t8cc/4MnUXIc9gXZFBFany8YjgJ5jF
         1RIsGbey233ro5PpdlCJax60OMT9RsXgpqEDtsH/T7SyGkc9dkaAv/ikKSIPBS0bYSmm
         AUDRUG/5tOy+7LT6DQFmzvgzUYScUrCy9wUYoL1GHbPkpgXMW8zfQxokFMB8b9aygHOu
         nGHkiu02A33y5wcwr0J1F+8D7SepPL4UspPXOV2m+ujejzrPFlSCRxXA1IlyEG5lII1J
         j6eUkXQPLz55AylNVC1OC3Hq6c60LEoZVnx/HHlXQqdpP7DOSgmD2MqKRmH19hFUi6Ga
         uD1Q==
X-Received: by 10.107.130.220 with SMTP id m89mr7889785ioi.146.1442508271721;
 Thu, 17 Sep 2015 09:44:31 -0700 (PDT)
Received: by 10.107.132.155 with HTTP; Thu, 17 Sep 2015 09:44:12 -0700 (PDT)
In-Reply-To: <CF93B86B-8CCF-483D-918A-47C910CEE8BA@surialabs.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278134>

Hi,

On Thu, Sep 17, 2015 at 3:12 AM, Robert Strobl
<robert.strobl@surialabs.com> wrote:
> It might be an unusual workflow, however it leads to a bug:
>
> git checkout feature_branch
> git rebase master
>

Ok so you are performing the rebase...

> # a couple of conflicts occur, which I don=E2=80=99t want to fix. the=
re is an updated version on origin
> # so I=E2=80=99d like to go with that one
>
> git add .
> git stash
> git checkout master
> git branch -D feature_branch
> git pull
> git checkout feature_branch
> git status
>

So you delete the branch, but the rebase stores the branch it's
working on by name, *and* you then re-create the branch again by "git
checkout feature_branch"

> # On branch feature_branch
> # You are currently rebasing branch =E2=80=98feature_branch' on '1952=
69d'.
> #  (all conflicts fixed: run "git rebase --continue")
>
> # nothing to commit, working directory clean
>
> # It still thinks that I=E2=80=99m rebasing the branch, so let=E2=80=99=
s try:


You are still rebasing.

>
> git rebase =E2=80=94abort
>
> # On branch feature_branch
> # Your branch and =E2=80=98origin/feature_branch' have diverged,
> # and have 104 and 77 different commits each, respectively.
> #  (use "git pull" to merge the remote branch into yours)
> # nothing to commit, working directory clean
>
> I=E2=80=99m aware that I should have aborted the rebase and then fetc=
h the remote branch.
> However, I still think that when I delete a local branch, it should a=
lso abort the rebase that is attached to it.
>

So what happened here is the rebase --abort tries to return you to the
starting situation when you began the rebase. Normally if you change
the current checked out branch to a new one, ie: git checkout master,
it will say "not returning to ORIG_HEAD"... however... you are on the
same branch name, thus rebase --abort returns you to your position.

> I hope you find that useful. If it makes sense, I would be happy writ=
ing a patch for it :)
>

I don't think anything needs to happen. You admit that you should have
run "git rebase --abort" first. Second, you actually re-create the
same branch name again...

After fixing up the rebase --abort, just perform a git reset to fix
your tree where you want it.

In fact I prefer current behavior which has lower risk of lost work,
since abort puts you back to where you were before... I don't think
that supporting "I deleted a branch" makes sense here.

a) there is an easy known practice for this flow... rebase --abort firs=
t

b) there is an easy fix after you rebase --abort late: git reset --hard=
 master

Between these two things I don't think we should change rebase to stop
recovering the history.

Regards,
Jake

> Cheers,
> Robert--
