From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 2/2] introduce "preciousObjects" repository extension
Date: Wed, 24 Jun 2015 17:29:42 +0700
Message-ID: <CACsJy8Ca4J4Q4zi2i-HmySK6WXcNLo=oUZ9H=nPpms7VWhHe1Q@mail.gmail.com>
References: <20150623105042.GA10888@peff.net> <20150623105411.GB12518@peff.net>
 <20150624081224.GA4781@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 24 12:30:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7hwh-00062G-VT
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 12:30:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbbFXKaP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 06:30:15 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:35067 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787AbbFXKaM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2015 06:30:12 -0400
Received: by iebrt9 with SMTP id rt9so30170900ieb.2
        for <git@vger.kernel.org>; Wed, 24 Jun 2015 03:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=6fLWupiYAtZC8ubP5ejMhJMCpxNddXvYFrBDD6sT7gY=;
        b=CvMnUnwaDWm67gzLgr5W2dwlaBbFZuoSHuLuSBAQ34C6luldZwpeFQTumlP2g0PRCc
         FTLwlH8/gsp5S9KEe5FqgDv76EAXwO83c9dQ/bFsO+QjqC/KDE8MVQbb0Aup9Gfeajvo
         MkUfHBWBTr9P6XHf3v1Omyj2m1SOZJr+D8RkteQPHSqV9w5s6aPTVg4ISsgdutwFioma
         EsoTOxwjhd/MTWS/Pc1+cujKGGxoisNBoYp8hx1MRe9WWncb16tHO+fBzM6JOaYIUdTO
         mHFFMKa6RcI39RkgOGo72nRHIZFNatP86pbiPD+ec3tDY7RmnQmjZsqlQtwVS+sIZp8C
         eNJg==
X-Received: by 10.42.244.4 with SMTP id lo4mr8205431icb.65.1435141811981; Wed,
 24 Jun 2015 03:30:11 -0700 (PDT)
Received: by 10.107.16.15 with HTTP; Wed, 24 Jun 2015 03:29:42 -0700 (PDT)
In-Reply-To: <20150624081224.GA4781@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272546>

On Wed, Jun 24, 2015 at 3:12 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Jun 23, 2015 at 06:54:11AM -0400, Jeff King wrote:
>
>> diff --git a/builtin/prune.c b/builtin/prune.c
>> index 0c73246..fc0c8e8 100644
>> --- a/builtin/prune.c
>> +++ b/builtin/prune.c
>> @@ -218,6 +218,9 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
>>               return 0;
>>       }
>>
>> +     if (repository_format_precious_objects)
>> +             die("cannot prune in a precious-objects repo");
>> +
>
> By the way, I originally wrote this patch on an older version of git,
> and was surprised that `git gc` broke when I brought it forward. The
> problem was that gc now runs `git prune --worktree`, and my die() was
> affecting that case.
>
> It really seems misplaced to me to make worktree-pruning part of
> git-prune. I imagine the rationale was "well, we are pruning things, so
> let's add an option to this command rather than make a new one". But I
> do not think that follows our usual pattern with gc, which is:
>
>   1. Individual areas of code handle their own cleanup. E.g., "reflog
>      expire", "rerere gc".
>
>   2. We tie them together with "git gc", not with "git prune".
>
> So it seems weird that "git prune --worktree" is a fundamentally
> different command than "git prune". I think by (1), it should be a
> separate "git prune-worktree" (or better yet, "git worktree prune", as
> the start of a command for manipulating the list of multiple-worktrees).
>
> Not a _huge_ deal, but if we want to change it, it would be nice to do so
> now before it is part of a release. Thoughts?

I was misled by the generic name "prune" :) (OK my bad, the document
clearly says it's about object database). Maybe we should make an
alias prune-objects.. And you caught me too late, I also added
prune_shallow() in there.

Multiple worktree feature is not released yet so I still have some
time to move it out. Yeah "git worktree prune" makes sense. I think I
need a way to list worktrees anyway. I didn't find good enough reason
to create "git worktree" back then just for listing..
-- 
Duy
