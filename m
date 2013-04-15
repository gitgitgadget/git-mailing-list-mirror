From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/3] pull: introduce --[no-]autostash and pull.autostash
Date: Mon, 15 Apr 2013 18:01:29 +0530
Message-ID: <CALkWK0mmrvYSjvUCvvjbnav4JmbkVKho2K6c7QAM2AuqWFkEFw@mail.gmail.com>
References: <1365887729-9630-1-git-send-email-artagnon@gmail.com>
 <1365887729-9630-4-git-send-email-artagnon@gmail.com> <7v8v4k2vm0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 14:32:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URia5-000298-5G
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 14:32:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754217Ab3DOMcO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 08:32:14 -0400
Received: from mail-ia0-f173.google.com ([209.85.210.173]:42410 "EHLO
	mail-ia0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754001Ab3DOMcM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 08:32:12 -0400
Received: by mail-ia0-f173.google.com with SMTP id j5so3764355iaf.32
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 05:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=gLLkPRUja8DOdPeMN35a8UVIBVexydMddlS/Q1DVJcU=;
        b=FltYmr9Dq8hSCkukTBtzkv0LLShArrLuRCoXCeZMj+i8bbkQoGztFvN63YH5l72Rgp
         aJ8qM3PyY2Qg7ebsCBT0I1aKEHKm9+CZ8Q2KZvia3t88acFdzZiZ7Iu7QxTp04HiNCKW
         MS2vW7imR4dDeQ+TPsuqtrljGgMMch8xQjGfVro52LrBU5gUk1KdhqSqxUQsbPLF+Xlp
         3FPajA5GNBquKWNdWsxKFmpG/F7WmBfwjuZnhB96mOfRsuG8S8xBjbRu1AH83ouoBbHp
         ZWq9f1FEZNElq8qyt/P7Kio86VlUjQ2qVGdVhNSFBml3QngbOn0LUeqFnKbJQGsgRO2n
         fBCQ==
X-Received: by 10.50.119.102 with SMTP id kt6mr5283541igb.12.1366029130252;
 Mon, 15 Apr 2013 05:32:10 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Mon, 15 Apr 2013 05:31:29 -0700 (PDT)
In-Reply-To: <7v8v4k2vm0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221226>

Junio C Hamano wrote:
> In the end, simple cases (the canonical example being Linus keeping
> a local change to "Name = Unicycling Gorilla" in his Makefile while
> running dozens of "git pull" every day) would not be helped with
> this feature very much because there is rarely overlap, while in a
> complex case the user really needs help to save away his WIP, the
> user is forced to resolve the conflict immediately upon the failed
> "stash pop" at the end of "git pull".  If the conflict turns out to
> be something the user would not want to resolve at that moment, the
> user needs to know the way out, something like:
>
>         git reset --hard                ;# go back to the result of pull
>         git checkout -b wip ORIG_HEAD   ;# start from before the pull
>         git stash pop                   ;# recover his wip
>         ... perhaps work a bit more ...
>         git commit -a -m wip            ;# save it away for safety
>         git checkout -                  ;# result of pull
>
> so that he can come back tomorrow, check out "wip" branch, and
> decide what to do.

What does this have to do with pull at all?  git-pull.sh is a simple
shell script that runs fetch followed by a merge or rebase.  You're
handling a merge now, and there's proper support for it in the tool;
git merge --abort will work with one caveat:  "If there were
uncommitted worktree changes present when the merge started, git merge
--abort will in some cases be unable to reconstruct these changes. It
is therefore recommended to always commit or stash your changes before
running git merge.", to directly quote the manpage.  Really, it has
the same problem as rebase, if you want --abort to work.

"Fixing" git merge --abort and git rebase are topics for another day.
What I'm doing it making it easier to work with the merge/rebase
following the fetch by automatically stashing worktree + index
changes.

> The "--autosquash" option (or not adding either the configuration or
> the option) would encourage the user to think about the nature of
> WIP he has in the working tree before running "git pull".

I'm lost.  What does git rebase --autosquash (or rebase.autosquash)
have anything to do with git pull --autostash?

> Is it a
> too complex beast that may interfere with what others are doing, or
> is it a trivial change that he can stash away and pop it back?  If
> the former, he will be far better off doing "checkout -b", keep
> working until the local change gets into somewhat a better shape and
> "commit", before pulling into the original branch.

A pull-merge person having complex worktree changes should not execute
git pull blindly in the first place.  That's what git fetch is for:
inspect the incoming changes, and decide how to integrate it into the
local branch.  git pull is a tool that serves an entirely different
purpose, in my opinion.

> But I suspect that pull.autostash
> configuration is not a good addition because it encourages a bad,
> pain-inducing workflow.  In simple cases it may not hurt, but when
> local changes are complex, it would actively hurt than not having it,
> and the configuration robs the incentive to choose.

But I'm a pull-rebase guy, and I always want pull.autostash.  Will you
deny me the configuration variable, simply because it is potentially
pain-inducing to pull-merge people who set it blindly and run git pull
blindly?

I'm not arguing linking pull.autostash to pull.rebase either: my
change is admittedly useful to *some* pull-merge people.  And I'm not
arguing for making it true by default.

> The equation is somewhat different for "pull-rebase", as "rebase"
> insists you to start from a clean working tree, so "download and
> then stop" annoyance feels bigger.  I have a suspicion that
> loosening that may be a more productive fix to the real problem.

Rebase performs relatively simple operation on the worktree, and I
would like to keep it that way.  I have no desire to "fix" rebase.

>         (require_clean_work_tree --quiet) || git stash

Good point.  Will fix in the next iteration.

> This "cannot pop stash" is really where the user gets in the deep
> yoghurt and needs help.

Yes, and your point being?  That life would've been easier if the user
had committed all those changes in the first place?  And that the
penalty for not having done that is now a git checkout wip ORIG_HEAD;
git stash pop; git checkout master; git rebase wip?

>         Please resolve conflicts and commit, and then 'git stash pop'.

Cool, will fix.
