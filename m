From: Scott Sandler <scott.m.sandler@gmail.com>
Subject: Re: Git push race condition?
Date: Tue, 25 Mar 2014 09:45:20 -0400
Message-ID: <CAAyEjTPtaKExJJSc3yrxVNzx0DmOyeUFH-Uxz3dn0iezqc5VKA@mail.gmail.com>
References: <CAAyEjTN53+5B9Od9wW698wODNL3hR6Upot8-ZLwEksn3ir_zjA@mail.gmail.com>
	<20140324225434.GB17080@sigill.intra.peff.net>
	<557DE2F7-1024-42A5-8192-ACE910CE6C81@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Nasser Grainawi <nasser@codeaurora.org>
X-From: git-owner@vger.kernel.org Tue Mar 25 14:45:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSRfT-0001Kv-LJ
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 14:45:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752348AbaCYNpX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2014 09:45:23 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:42483 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751624AbaCYNpW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 09:45:22 -0400
Received: by mail-la0-f48.google.com with SMTP id gf5so374818lab.21
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 06:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=XYoSjGeX+9ONOYzCzuiuDv0WnfOoWLhEejqymOxBy68=;
        b=kFwOzd/OfsLbm6WbQbDY8/ZoWeUMDv0VRKzkl+2pIjyIfZjbQAqbrR+9KQSGJKbcim
         rTU22e2AieCavPE40N0FtE5zKVPGM+8GwIY5IJKbP4R82WDwDtgUdx1y9tmDLZ+uK2dj
         ryN++GEg75MjSSk9e5U06y82eBOLQZDDOqdx+PE3N1obesDAbsrRWTQPhjWDsUzeTEjD
         2EX4/Px/IyPT6oGSAjanFar3A2Hf/DS0qNeddCFVwB0Bfu5+KY5GqGTB5tJHwLbyD2mn
         qAbFTwnKEb36DWVDNH2mTKA10Yc3L2zx7kwUAD6jEYj0HgC89C6MoWO613nu8IffJfwh
         7jVQ==
X-Received: by 10.152.37.99 with SMTP id x3mr49379919laj.7.1395755120938; Tue,
 25 Mar 2014 06:45:20 -0700 (PDT)
Received: by 10.114.64.103 with HTTP; Tue, 25 Mar 2014 06:45:20 -0700 (PDT)
In-Reply-To: <557DE2F7-1024-42A5-8192-ACE910CE6C81@codeaurora.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245035>

Version of git on the server? git version 1.8.3-rc0

Is there a hook or cron job that updates or gcs this repository or any
refs? No. No cron jobs touching the repo at all, and all the hooks are
read-only. There are pre-receive hooks that either reject a push or
don't based on some checks, there are post-receive hooks that curl to
notify external services like jenkins, and there is gitlab's update
hook which just either allows or denies a push based on gitlab's own
permissions check, and then updates a redis queue
(https://github.com/gitlabhq/gitlab-shell/blob/master/lib/gitlab_update.rb).

Am I absolutely positively sure that it's not a force push? I'm pretty
confident they're not force pushing. This has happened now to 5
different pairs of developers using a variety of Git clients (Git
bash, git cli on mac and linux, sourcetree) and most of them didn't
even know what force push was until I asked them if they had done it.
They're all using ssh URLs for the git remote, not http, in case
that's relevant, and they showed me their git configurations and
nothing looks amiss.

After the first time it happened I also put a pre-receive hook in the
repository to prevent force pushes to master, since I thought that's
what had happened:

while read OLDREV NEWREV REFNAME
do
  if [ "$REFNAME" == "refs/heads/master" -a "$OLDREV" != $(git
merge-base $OLDREV $NEWREV) ]; then
    echo "ERROR: It seems like you are trying to force-push on master."
    exit 1
  fi
done

I did this so that people could still force push on other branches if
they really wanted to (since many mentioned they do this on their
remote branches sometimes). I'm under the impression this hook works
properly since it rejects my attempted force pushes to master.


On Mon, Mar 24, 2014 at 6:59 PM, Nasser Grainawi <nasser@codeaurora.org> wrote:
> On Mar 24, 2014, at 4:54 PM, Jeff King <peff@peff.net> wrote:
>
>> On Mon, Mar 24, 2014 at 03:18:14PM -0400, Scott Sandler wrote:
>>
>>> I've noticed that a few times in the past several weeks, we've had
>>> events where pushes have been lost when two people pushed at just
>>> about the same time. The scenario is that two users both have commits
>>> based on commit A, call them B and B'. The user with commit B pushes
>>> at about the same time as the user who pushes B'. Both pushes are
>>> determined to be fast-forwards and both succeed, but B' overwrites B
>>> and B is no longer on origin/master. The server does have B in its
>>> .git directory but the commit isn't on any branch.
>>
>> What version of git are you running on the server? Is it possible that
>> there is a simultaneous process running `git pack-refs` (e.g., a `git
>> gc` run by a cron job or similar)?
>
> `git gc --auto` could be getting triggered as well, so if you suspect
> that you could set gc.auto=0 on the server side.
>
>>
>> There were some race conditions fixed last year wherein git could see
>> stale values of refs, but I do not think they could impact writing to a
>> ref like this.  When we take the lock on the ref, we always go straight
>> to the filesystem, so the value we see is up-to-date.
>>
>> -Peff
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --
> The Qualcomm Innovation Center, Inc. is a member of Code Aurora
> Forum, hosted by The Linux Foundation
>
