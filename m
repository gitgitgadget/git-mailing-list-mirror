From: Fabian Ruch <bafain@gmail.com>
Subject: Re: Please help provide clarity on git rebase internals
Date: Fri, 19 Sep 2014 15:12:34 +0200
Message-ID: <541C2BC2.3050205@gmail.com>
References: <CAE2xRkHgnXK84u5zeLyVZqAnvu3u+0gSgaB+smFXu6Y7pkY1kQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Colin Yates <colin.yates@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 19 15:12:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XUxzQ-0007zy-5w
	for gcvg-git-2@plane.gmane.org; Fri, 19 Sep 2014 15:12:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755978AbaISNMk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Sep 2014 09:12:40 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:35794 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754085AbaISNMj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2014 09:12:39 -0400
Received: by mail-lb0-f170.google.com with SMTP id n15so1241779lbi.29
        for <git@vger.kernel.org>; Fri, 19 Sep 2014 06:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=rNq8dy3JMrNABRR77W+0NgdOsu9n0RIzvzXmdZUH4Eg=;
        b=VV+oUzgmxXLdoz5OnBpGLxED0eli5hy+FuT67NiyU1TrmB/VoK4xNZed+ZCUheJFly
         pV7Hh5UNr+Wfbvy9NS9EQ8lXbKKGykwLsZ6BK3xgrs6CKBUmKTMwR6JoL1cz1vPLnNnI
         cQrTKdkXu+DftXzhyU19ebugSvcuCpFc9w5iylQxJxJ33svkJdkzqC8Dv8CxwjCBmSH+
         9hTwq/Z2yzKZN/SOW+GmRRwfEX37x8KNT+3PDNcdGDz4B476x541F6LmoP4C00PG3dbB
         rLLTCENq7wM94g6e8ifA4bzMlHAcQtNB+mzKlEf+dyRU3P+w7II2HVucT2Wc+Kzrdy0V
         LEkg==
X-Received: by 10.112.198.163 with SMTP id jd3mr6492548lbc.72.1411132357289;
        Fri, 19 Sep 2014 06:12:37 -0700 (PDT)
Received: from client.googlemail.com (dhcp-185086.eduroam.chalmers.se. [129.16.185.86])
        by mx.google.com with ESMTPSA id as5sm605912lac.46.2014.09.19.06.12.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Sep 2014 06:12:36 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
In-Reply-To: <CAE2xRkHgnXK84u5zeLyVZqAnvu3u+0gSgaB+smFXu6Y7pkY1kQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257284>

Hi Colin,

On 09/08/2014 01:25 PM, Colin Yates wrote:
> My understanding is that rebasing branch B onto branch A unrolls all
> of branch B's commits and then "reduces" them onto the HEAD of branch
> A.
> 
> For example, I took featureA branch from develop three days ago.
> develop subsequently had commits #d1, #d2 and #d3. featureA also had
> #f1 and #f2 and in terms of time they are all intermingled.
> 
> My understanding of rebase is that after issuing "git fetch; git
> rebase origin/develop" in featureA branch a git log should show #f2,
> #f1, #d3, #d2, #d1.

Almost, it will show #f2', #f1', #d3, #d2, #d1. The commits #f1 and #f2
must be recreated because the changes they introduce are being applied
to a different base, that is a different tree. The result of rebasing
#f1 and #f2 will be a tree different from the one at the tip of branch
'featureA'.

> I am seeing this, but sometimes I see something I can't explain and
> that is a merge conflict as if git was doing a merge rather than a
> rebase.

A rebase is a series of patch applications to a base different from the
one they were created in relation to. If a patch context is different in
the new base, the patch cannot be applied by simply replacing '-' lines
with '+' lines and a merge of changes is required. That merge can fail
itself and we see merge conflicts. It's no contradiction that a merge
(of changes) is happening even though git is not doing a merge (of
branches).

> For example, let's imagine that #f1 removed fileA, some time later #d1
> added a line to that file. If I was doing a merge then of course this
> should be a conflict, however applying #f1 to develop HEAD should work
> even if fileA has changed (i.e. #f1 removes the updated fileA).

The commit #f1 does not just record the deletion of the file named
'fileA' but also a patch that removes every single line in that file.
Another way to view the behaviour of 'git rm' is that the command does
not remove names from the tree but objects that are given by both a name
and a content. The replay of #f1 on top of #d3 conflicts because the
patch cannot be applied, the content does not match respectively.

> As it is I am frequently running into merge conflicts in this manner
> when it *appears* git is applying a patch from featureA onto develop
> _as it was then the patch was made_.

I'm not sure if I'm understanding correctly, but I'd say it doesn't just
appear that way. First, git-rebase takes the patch that represents the
changes between develop@{3 days ago} and #f1 and applies it to #d3. The
result is commit #f1'. Then it applies the differences between #f1 and
#f2 to #f1', which in turn results in #f2'.

> I am also seeing merge conflicts that occur between commits in the
> develop branch itself as well, which I assumed would be effectively
> read-only.

You're right, the branch 'develop' shouldn't be touched at all if you
run 'git rebase develop' on branch 'featureA'. Do you mean "between
commits in the *featureA* branch itself" instead, i.e. it is unexpected
if the replay of #f2 fails after the replay of #f1 succeeded?

> In terms of functional programming I thought rebase was a pure reduce
> of a sequence of patches from featureA branch onto HEAD.

I like how you're viewing 'rebase' as, I guess, a right fold with the
base as the initial element and 'apply'/'cherry-pick' as the operator,
but I'm not sure what we can learn from this representation. Is it true
that there is an emphasis on "pure" here suggesting that this is where
the functional interpretation fails?

Cheers,
   Fabian
