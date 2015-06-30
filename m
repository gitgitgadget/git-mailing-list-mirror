From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC/PATCH] worktree: replace "checkout --to" with "worktree new"
Date: Tue, 30 Jun 2015 16:23:09 +0700
Message-ID: <CACsJy8BYeYq-fQX=M1h2r4daQSsemXQT4Y+ww2Z3Y54brUS3QQ@mail.gmail.com>
References: <1435640202-95945-1-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jun 30 11:23:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9rle-0001ek-B6
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 11:23:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbbF3JXl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2015 05:23:41 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:35786 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846AbbF3JXj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 05:23:39 -0400
Received: by igblr2 with SMTP id lr2so70656189igb.0
        for <git@vger.kernel.org>; Tue, 30 Jun 2015 02:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=UaruwAdQ18pXMPabmiSD+NDFHynafwm9e/sBF0Kx+vQ=;
        b=s6y3/dBk3sS8u9m8HNMc1Pgucy88kdBXNfZfMj45mEidBAI1UuHYfjNw7aOOnc2Fkh
         J/wZsK2mQ3mSxks7YMq5uz+EvT4RcQ+itY77bE6qteRhgl1LqOzTYiUb7BJuLdICnMMh
         0HLgXOc/A8tT8JNOzfX3XpyYehh0hCGtclBroIDumdTHRfCWphtAVzDk2pDqqc+t+ikj
         uplDoHRxUsvKq/Kyygmi+H7cSOImbLLdr+PffQYKpBE3BDaX4Xg2gPQhDgkKv71NcySR
         /j4mYQrKFhb8UB7BPXAChTDgg/TOaSsPRxeUC5oM76dbGtCDLTnoSVNlgGON5NqjVXmD
         QzEg==
X-Received: by 10.43.172.68 with SMTP id nx4mr23106335icc.48.1435656218824;
 Tue, 30 Jun 2015 02:23:38 -0700 (PDT)
Received: by 10.107.16.15 with HTTP; Tue, 30 Jun 2015 02:23:09 -0700 (PDT)
In-Reply-To: <1435640202-95945-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273035>

On Tue, Jun 30, 2015 at 11:56 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> The command "git checkout --to <path>" is something of an anachronism,
> encompassing functionality somewhere between "checkout" and "clone".
> The introduction of the git-worktree command, however, provides a proper
> and intuitive place to house such functionality. Consequently,
> re-implement "git checkout --to" as "git worktree new".
>
> As a side-effect, linked worktree creation becomes much more
> discoverable with its own dedicated command, whereas `--to` was easily
> overlooked amid the plethora of options recognized by git-checkout.
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>
> I've long felt that Duy's linked-worktree functionality was a bit oddly
> named as "git checkout --to", but, since I could never come up with a
> better name, I never made mention of it. However, with Duy's
> introduction of the git-worktree command[1], we now have a much more
> appropriate and discoverable place to house the "git checkout --to"
> functionality, and upon seeing his patch, I was ready to reply with the
> suggestion to relocate "git checkout --to" to "git worktree new",
> however, Junio beat me to it[2].

Didn't know you guys were so eager to move this code around :D Jokes
aside, it's good that it's raised now before --to is set in stone.

I think this is like "git checkout -b" vs "git branch". We pack so
many things in 'checkout' that it's a source of both convenience and
confusion. I never use "git branch" to create a new branch and if I
had a way to tell checkout to "move away and delete previous branch",
I would probably stop using "git branch -d/-D" too. "--to" is another
"-b" in this sense.

"git worktree new" definitely makes sense (maybe stick with verbs like
"create", I'm not sure if we have some convention in existing
commands), but should we remove "git checkout --to"? I could do "git
co -b foo --to bar" for example. Maybe "--to" is not used that often
that "git worktree new" would feel less convenient as a replacement.
If we are not sure about "--to" (I'm not), I think we just remove it
now because we can always add it back later.

> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> index 41103e5..8f13281 100644
> --- a/Documentation/git-worktree.txt
> +++ b/Documentation/git-worktree.txt
> @@ -9,16 +9,85 @@ git-worktree - Manage multiple worktrees
>  SYNOPSIS
>  --------
>  [verse]
> +'git worktree new' [-f] <path> [<checkout-options>] <branch>

Should we follow clone syntax and put the <path> (as destination)
after <branch> ("source")? Maybe not, because in the clone case,
explicit destination is optional, not like this.. Or.. maybe <branch>
could be optional in this case. 'git worktree new' without a branch
will create a new branch, named closely after the destination.
Existing branch can be specified via an option..
-- 
Duy
