From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] diff --no-index: allow pathspec after --
Date: Sun, 21 Sep 2014 16:25:31 +0700
Message-ID: <CACsJy8BYSTWGLv666OetUC5Td+SF8T2yWrMNC_jXU5Vn9hoESA@mail.gmail.com>
References: <1410256584-19562-1-git-send-email-pclouds@gmail.com>
 <xmqqha04o8k7.fsf@gitster.dls.corp.google.com> <xmqq38blmr6g.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 21 11:26:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XVdPQ-0005Xj-1L
	for gcvg-git-2@plane.gmane.org; Sun, 21 Sep 2014 11:26:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbaIUJ0E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Sep 2014 05:26:04 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:38473 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750707AbaIUJ0D (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2014 05:26:03 -0400
Received: by mail-ig0-f170.google.com with SMTP id a13so2805156igq.1
        for <git@vger.kernel.org>; Sun, 21 Sep 2014 02:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=QH4H4ugX7qSlOzXfmYEF1AOWFx3iWKMiHRX4pyZIKa8=;
        b=QDB9i5ege9A9SgIxjtfsaQxYLZMCe1RifgbKRYp7IajZK5DSasLo60/TdmJOo+TT4y
         FwZ1aqcRCPy8yXRd5ilBF8++plhC5jYGzTPqCK24Wn4X7efV5oQNrycdwBQBuRHsBu7L
         Q9RnOhrNETkoG9Ggm3CpHmKEiOmm/zD8Kwnio+AYv/5k6d/h5/uBjozhyqeX9L1krhQq
         i18VQYxt4JT9Po0f1Gnj7FQ0ZqWPIiMqWPJYHR27QTwOx/twUlknjTkEaStSshAmkZhn
         A5PCSfgydlavOI6zbGyfVYTIJ9Z0kbeAtwquyfXRxVy1xiXymc+iQUWBE+IbtqNWWpO2
         12xQ==
X-Received: by 10.50.61.145 with SMTP id p17mr7328956igr.41.1411291561554;
 Sun, 21 Sep 2014 02:26:01 -0700 (PDT)
Received: by 10.107.131.150 with HTTP; Sun, 21 Sep 2014 02:25:31 -0700 (PDT)
In-Reply-To: <xmqq38blmr6g.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257346>

On Sun, Sep 21, 2014 at 1:19 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Coming back to the command line syntax for the new feature, if I had
>> to choose, I would say
>>
>>       git diff --no-index [-<options>] [--] <path> <path> <pathspec>
>>
>> perhaps?  As we never compare anything other than two things,...
>
> Actually, I am not so sure about this anymore.
>
> It is not entirely fair to say that
>
>         git diff --no-index [--options] A B C D
>
> as comparing A and B while using C and D as pathspec and declare a
> person who expects otherwise a moron.  To a person whose brain is
> not rotten by years of use of Git, "we never compare anything other
> than two things with --no-index" is not a given, I am afraid.
>
> It is equally plausible that the same command line may be asking to
> compare A with B and C with D, i.e. producing
>
>         diff --no-git a/A b/B
>         ...
>         diff --no-git a/C b/D
>         ...
>

Heh.. I wrote something like that [1]. An extension of this is feed
all filename pairs via stdin.

[1] http://thread.gmane.org/gmane.comp.version-control.git/188435

> It also equally plausible (taking a cue from "mv A B C Dir/") that
> it is comparing A, B and C with D/A, D/B and D/C, respectively,
> producing
>
>         diff --no-git a/A b/D/A
>         ...
>         diff --no-git a/B b/D/B
>         ...
>         diff --no-git a/C b/D/C
>         ...

This mode is weird... In real world, "A" may match to D/some-path/A
not just D/A. Which brings it back to the previous mode.

> The only unambiguous syntax I can think of that avoids such
> alternative interpretations is something ugly like
>
>     git diff --no-index [-<options>] --src=<path> --dst=<path> [--] <pathspec>
>
> where "src" and "dst" are in line with the existing src/dst-prefix
> options.

Or let the user define a "separator", e.g.

git diff --no-index --pathspec-separator=<sep> [--] <paths...> [<sep>
<pathspec>]

Another option is pathspec magic (I'm not entirely sure how it looks
like at the implementaiton level yet), --src=<path> could become
:(source)path, --dst=path -> :(dst)path and so on..

> Perhaps we could declare that this is the "canonical" way to spell
> pathspec-filtered no-index comparison of two directories, but we
> allow the syntax suggested in the message I am responding to as a
> short-hand, but I am not sure if that would fly well.
>
> This --src/--dst thing could lead to even uglier tangent.  We could
> use these options to specify what is compared with what else
>
>     --{src,dst}-path=<directory in the working tree>
>     --{src,dst}-index
>     --{src,dst}-worktree
>     --{src,dst}-tree=<tree object>
>
> which allows us to express funky combinations like
>
>         git diff --src-index --dst-worktree [--] <pathspec>
>         git diff --src-tree=HEAD --dst-index [--] <pathspec>
>         git diff --src-tree=maint --dst-tree=master [--] <pathspec>
>
> The above three would be ugly ways to spell the traditional "short
> hands", e.g.
>
>         git diff [--] <pathspec>
>         git diff --cached [--] <pathspec>
>         git diff maint master [--] <pathspec>
>
> respectively.  And an obvious fallout of the above is this command
> line:
>
>         git diff --src-path=A --dst-path=B [--] <pathspec>
>
> Because this does not involve any index, tree or worktree, it cannot
> be a Git operation, so we know that is --no-index mode; the command
> line does not need to say --no-index anywhere if we go that route.

Sounds a lot like Jeff's "git-put", except with -- syntax instead of a
special one, and you only look at the diff, not move any content. Also
people who would go with "git diff --no-index A B C D E F..." usually
script it, not type it manually. And stdin would fit better than
command line arguments.
-- 
Duy
