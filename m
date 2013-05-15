From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC] New kind of upstream branch: base branch
Date: Wed, 15 May 2013 18:18:47 -0500
Message-ID: <CAMP44s2BXoUWGPWof+0u6=_UQXpPjA3jtBh0sKS+hhsd-=ViVg@mail.gmail.com>
References: <5193efe6.c42ab60a.0319.5f2c@mx.google.com>
	<7vzjvvanro.fsf@alter.siamese.dyndns.org>
	<7vvc6jame7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 16 01:18:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UckyE-0006eS-1D
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 01:18:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753491Ab3EOXSu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 19:18:50 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:41232 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753315Ab3EOXSt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 19:18:49 -0400
Received: by mail-la0-f44.google.com with SMTP id fr10so2370581lab.3
        for <git@vger.kernel.org>; Wed, 15 May 2013 16:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=aDWZ0ir0dqtfFG1qQXHaB8z8DeqWvFD5oLNJD8HETTU=;
        b=UHFUwx52vRxJTBVIeXYbvIPXwvrByQns/Gqiy89dRAFwjJ2XyWpD8fiQ7r4L+Nsk3B
         KLlAxtYAiDbl0cWhQMddXRr4EERxUPX0pSa8HpSFL7L61CL+5Y9y78qem3mfBt217NVX
         l8wNQDgdLf4Hnl/7JickWck9N3gcFgIGwV7JU1TY9HDiJbUNyGqO6J6BHzFZqrNIUeu5
         OkLN7L1mPt8Wj7ReZuuNMnp4vktZF1vBNtr9MQJujV+9zhnd5+akKw5pnMiMcg0n6EBu
         5uQ4a0YUGAOCEgbvKSHA/Hu9vGUmU4WUdZ7CEK0V7au7lOeaGV6BXm9m09zK+uki7+RE
         ebFA==
X-Received: by 10.152.27.132 with SMTP id t4mr9781678lag.46.1368659927922;
 Wed, 15 May 2013 16:18:47 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Wed, 15 May 2013 16:18:47 -0700 (PDT)
In-Reply-To: <7vvc6jame7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224456>

On Wed, May 15, 2013 at 5:50 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> I however am not yet convinced if that direction is what you really
>> want go in, though.  What should your 'git pull' on that branch do,
>> for example?
>>
>> When you are on foobar and want to integrate with the branch you
>> based your work on (i.e. local 'master'), you can do one of these:
>>
>>     $ git pull
>>     $ git pull --rebase
>>
>> to "fetch the upstream branch and integrate with it", without having
>> to even care if that upstream branch is from the remote, or happens
>> to be truly local.  By making 'git fetch' to go to the remote origin
>> site, what will you be merging (or rebasing on) when you do the
>> above two?
>>
>> Incidentally, I suspect you can do exactly the same thing without
>> introducing a new concept "base" and instead special casing a remote
>> whose URL is "."; you essentially declare that "The upstream of this
>> branch whose branch.$name.remote is set to '.' lives locally", which
>> is not all that different from saying "The upstream of this branch
>> whose branch.$name.base exists lives locally", which is what you
>> seem to be proposing.  One of the things this alternative approach
>> would "special case" such remote is probably to cause "git fetch" to
>> ignore such a branch.$name.remote setting and instead go fetch from
>> 'origin', just like your "if there is branch.$name.base, but no
>> branch.$name.remote, fetch will go to 'origin'" does.
>>
>> But it has exactly the same "what happens when you do 'git pull'"
>> problem, so even though it is conceptually a lot simpler, it has the
>> same brokenness.
>
> I do not think of a good way to fix the 'git pull' confusion; the
> desire to 'fetch from the overall upstream repository regardless of
> which branch I am on' is a valid and understandable one, but that
> does not mesh well with "'git pull' is 'git fetch' followed by
> either merge or rebase to integrate the result"

But that is not true. It's only true when merge.defaulttoupstream=true.

> and "git merge or
> git rebase pays attention to the other branch that is specified to
> integrate with".  The best we could do might be to simply forbid
> "git pull" if your current branch is marked with branch.$name.base
> but still allow "git fetch".

Why forbid it? Why not leave it as it is?

> The changes that are involved are:
>
>  * Do not change anything to @{upstream}'s definition, that is,
>    "checkout -t -b A localbranch" will set branch.A.remote to '.',
>    and "git log A@{u}..A" will stand for "git log localbranch..A".

Yes, but in addition it would set 'branch.A.base'.

>  * Current 'git fetch' pays attention to branch.A.remote when you
>    are on branch A, and tries to fetch from there.  Stop doing that
>    when branch.A.remote is set to '.' (the current repository) and
>    let other rules in the current implementation decide what remote
>    to fetch from. Also teach it to error out when branch.A.remote is
>    set to '.' when a new --forbid-local option is passed.

I don't see the point of --forbid-local, but otherwise yeah.

> Ah, alternatively, instead of adding --forbid-local, we could modify
> the changes for 'git fetch' and 'git pull' to read like this:
>
>  * Current 'git fetch' pays attention to branch.A.remote when you
>    are on branch A, and tries to fetch from there.  Stop doing that
>    when branch.A.remote is set to '.' (the current repository) and
>    let other rules in the current implementation decide what remote
>    to fetch from, unless a new --allow-fetch-from-local option is
>    passed.
>
>  * Teach 'git pull' to pass --allow-fetch-from-local to 'git fetch'.

Perhaps.

> If we did this, we can keep the "git pull [--rebase]" as a way to
> integrate with what you specified as your upstream, which is a
> common expectation, without forcing you to say "git fetch origin".

I'm starting to change my mind. Perhaps instead of aiming to change
the behavior 'git rebase', it would make more sense to change the
behavior of 'git push'. So that 'git rebase', 'git fetch' and 'git
pull' all use 'upstream' as is currently the case, but 'git push'
would use something different. That would solve my 'origin/master' vs.
'github/master' distinction. But I would like 'git checkout -b foo
master' to automatically setup 'upstream', and 'git checkout -t -b foo
master' to in addition set this other kind that only affects 'git
push'. This would be a much more intrusive change though.

So, 'branch.A.merge' would become 'branch.A.upstream' and have the
full tracking branch (e.g. 'refs/remotes/github/master'), and
'branch.A.remote' would only affect 'git push'.

-- 
Felipe Contreras
