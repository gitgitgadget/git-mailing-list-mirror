From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Linear history *and* share a branch?
Date: Fri, 06 Apr 2012 02:44:42 -0000
Message-ID: <c9ba22f806704f8689544d29455a242f-mfwitten@gmail.com>
References: <CAE1pOi0-uSaQwgJHMTkw3nqp=idxZxMbyfKtLni0=Xwu-L-_hA@mail.gmail.com>
Cc: git@vger.kernel.org
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 06 04:45:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFzAv-0004ff-9s
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 04:45:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078Ab2DFCpO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Apr 2012 22:45:14 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:39290 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728Ab2DFCpM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2012 22:45:12 -0400
Received: by wibhj6 with SMTP id hj6so179347wib.1
        for <git@vger.kernel.org>; Thu, 05 Apr 2012 19:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:date:from:to:cc:message-id:in-reply-to:references;
        bh=5Wu7t1WMuHQTmld+vLBlHKnLS/xLu7Ky0PWeKVKmGM4=;
        b=RtAW/cihbIXrmp6wLuqBpPYD6VLbN3VEaAgGuZTdSSjoeEL1IlwUJnJOQzp6VyeP3c
         GAfSZcUDWESZTaL5wIp3XsSBg3ZYc+X5VF9QA93XeYS9xVxD2zaf5F4YO+RuG1hT67N2
         gSFtA53+YS1pU4phzcUbDigKWVjyoaq+iMxpOVcl/uj4UqViNd4psNT1gOqZRP+ugNjW
         ZdmIoygZEcAS6S0xZsaRtQwsL4FhGULoqfun4mJu7DO++GJyAVnnT2CKLMihbl0e5A9H
         270wvUQflI8CjRvxbKKX1ltCd3EfC86joA3bZJSh3g5DeZ+7kPkbEbt8/hzz0d16Wmjd
         njow==
Received: by 10.180.102.100 with SMTP id fn4mr8284230wib.1.1333680311508;
        Thu, 05 Apr 2012 19:45:11 -0700 (PDT)
Received: from gmail.com (tor5.anonymizer.ccc.de. [80.237.226.75])
        by mx.google.com with ESMTPS id e6sm2334708wix.8.2012.04.05.19.45.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 05 Apr 2012 19:45:09 -0700 (PDT)
In-Reply-To: <CAE1pOi0-uSaQwgJHMTkw3nqp=idxZxMbyfKtLni0=Xwu-L-_hA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194838>

On Thu, 5 Apr 2012 13:48:23 -0700, Hilco Wijbenga wrote:

> We have been using Git for about a year now in a very small team. So
> far, everyone has worked on their own local branches and been doing
> "git rebase master" to make sure their local branches stay in synch.
> This way we have a nice linear history in master.
>
> Recently, it has become useful to share one of these local branches
> between two devs. Of course, when one of the devs does his usual "git
> rebase master", he screws up the other dev's environment. Our solution
> has been to keep rebasing the shared branch but to actually work on a
> local branch that is rebased on the shared branch. By judiciously
> using "git reset" and "git pull" on the shared branch the two devs can
> keep the shared branch in synch and then use "git rebase
> shared-branch" on their local branch to keep it in synch to. While
> this works, there is probably a better/simpler solution.

I think you can keep doing what you're doing, but simplify the
management. I try to express this more precisely below.

Take all this with a grain of salt; it's kind of off the top of
my head, untested, and probably wrong (all the more so, because
it has been a while since I had to think about these commands
or workflows). Sorry if this is no different than what you're
already doing.

For a branch head `X' and a branch head `Y', let:

  X > Y

mean that X should be periodically rebased on Y.

Your team could have the following repository (that is,
there is a branch head `shared' and a branch head `master',
and `shared' should be periodically rebased on `master'):

  origin:
    shared > master

Developer `A' has a repository with a remote-tracking
branch `origin/shared', and a topic branch `local':

  A:
    local > origin/shared

Similarly for Developer `B':

  B:
    local > origin/shared

The concerns are separated as follows (I'm being a
little more explicit with the commands than what is
probably necessary):

  origin:
    git rebase master shared

  A and B:
    git checkout local
    # do some work with `local'
    # ...
    git pull --rebase origin +shared:remotes/origin/shared
    git push origin local:shared # If this fails, do the pull again.

In actuality, the `origin' maintenance can be done by Developer `A'
or `B', too; from one of their repositories:

    git fetch origin +master:remotes/origin/master \
                     +shared:remotes/origin/shared
    git checkout -b shared origin/shared
    git rebase origin/master shared
    git push origin +shared:shared
    git checkout local
    git branch -D shared

With a suitably set up configuration, you could probably automate a lot
of the command line arguments. For instance, if the `A' and `B' repos
have configurations that look something like the following:

  [remote "origin"]
    fetch = +refs/heads/*:refs/remotes/origin/*
    ...

  [push]
    default = upstream

  [branch "local"]
    remote = origin
    merge  = shared
    rebase = true

then the usual `A' and `B' workflow could simply be:

  git checkout local
  # do some work with `local'
  # ...
  git pull
  git push # If this fails, do the pull again.

and as for rebasing `shared' in `origin', at least the fetch would just
become just `git fetch'.

... I think...

Sincerely,
Michael Witten
