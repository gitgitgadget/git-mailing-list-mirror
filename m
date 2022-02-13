Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C307C433EF
	for <git@archiver.kernel.org>; Sun, 13 Feb 2022 03:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbiBMDZg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Feb 2022 22:25:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbiBMDZg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Feb 2022 22:25:36 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114945F26F
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 19:25:31 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id e7so26482972ejn.13
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 19:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t5y8wRdBwauuQBvl66yrwZ4cORaIlfm2NZ5ZKk6WXwA=;
        b=NaiYQacOSSgFVfgrEjkvDENH35blyU1vq462yHnLjfR2LP9h3zSgiZZ067mE8McpPr
         bNuDx4MG2Wjr/4fc4LoEve6YRvP4jNF5Yz2EHvEvP89oOHZBbZvJkdPMXoOj0Py9Juaj
         qsXFs19YkbS9Hi0fUxRBwiujo2YXQgRslH0Tuk0Sf4/ZVJvaCj4tc47j3nB+qP9z0xRQ
         IfYJyw82mwL/OlVs+gyLeMIoFjhpF+wW4OTSDp5CdOT8w1l5y/1xjLqy6UhMtqIQ2awO
         FP18nbxPjZEm+cw06ZG7kh9s1D0rnyZSMdUddCnMZCuKfkDSCNgFLTlNkFHmAuqHZ4w9
         LP+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t5y8wRdBwauuQBvl66yrwZ4cORaIlfm2NZ5ZKk6WXwA=;
        b=3bnfnc7/RmYVKQaw6bSyrVaP0ey3KXWEA016NwlwIB+j362gv2FgK2Y3MM7RE7O//D
         7QkZqyc3DkAkvzctkHIJDqtF0sScrHoL0YrjJJKlFNSm0jNwxs2QxeLnGQTzZDHLRidM
         Lyecml6P19LPrn7CdbfBStxM6yYzQfzCYIvBxwLBNNA5DH5PoylEPoSygjr/jy/7d50H
         +iRi37xuAZ6AwkDmxxbHlpkROvpCuElM/bwrsj+0HzDd7aLD5ncZ2gVugcqwEKoZmTYw
         hK/Hw/bejzBBh8b7EZ0ol4j41GfoD4Ia5hGW2VbyRexURpDlpBIjAeEqTPIxI0YNFuCM
         VAhw==
X-Gm-Message-State: AOAM532bWKkRV4N83cpUwkoY97JtwTwU+ofZisybsX4S7ibiI/zjHnFW
        x960TKsCFGRpuaZrvfzb/Y2v8fDh6vobyb8eD6RIm2+Mu2Qx9Q==
X-Google-Smtp-Source: ABdhPJywhV9CicyJJXbJHsMkOqk7hN5HbqthOMAFt9xDldevwR75QVdhs4fSdLz8h7P4njGF9dTFvAZYkevDowzGW5g=
X-Received: by 2002:a17:907:6d20:: with SMTP id sa32mr3751396ejc.192.1644722729433;
 Sat, 12 Feb 2022 19:25:29 -0800 (PST)
MIME-Version: 1.0
References: <CAKQMxzSQRL-Q5daxETF+gYhVScmq_n=r2LJAeEuxpM7=jPajZQ@mail.gmail.com>
In-Reply-To: <CAKQMxzSQRL-Q5daxETF+gYhVScmq_n=r2LJAeEuxpM7=jPajZQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 12 Feb 2022 19:25:18 -0800
Message-ID: <CABPp-BE2q5_LVVUw=2Wfys0AF350tTMMr43ZLpfsjE4ecb1Tpw@mail.gmail.com>
Subject: Re: Optimization for "git clean -ffdx"
To:     Patrick Marlier <patrick.marlier@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Patrick,

On Wed, Feb 9, 2022 at 2:42 AM Patrick Marlier
<patrick.marlier@gmail.com> wrote:
>
> Dear git Developers,
>
> In a big repository with a lot of untracked directories and files
> (build in tree), "git clean -ffdx" can be optimized. Indeed, "git
> clean" goes recursively into all untracked and nested directories to
> look for .git files even if "-ff" is specified.

Yeah, seems like a waste of work.  Thanks for digging in.

> Using breakpoint on stat or "strace -e newfstatat", it is possible to
> see the recursing search for ".git" and ".git/HEAD". Also it seems to
> traverse the untracked directories a few times, which I am not sure
> why.

There are two steps -- collect the list of things that are removable,
and then a separate step to remove the things that are removable.  It
can be the case that we recurse into the same directory twice, once
for each step.  For the first step, see the fill_directory() call.  If
you left off "-x" or only had one "-f", or your directories had some
tracked files, then fill_directory()'s job is finding out which things
are removable and it'd likely only be a subset of those directories.
For the second step, some of those removable things may be entire
directories.  So when it hits one of those and later calls
remove_dirs() to remove it, it has to recurse again.

> Using "-ff" should not check for nested .git and no need to recurse if
> the directory is already untracked.

Not quite; the -x and lack of -e options is critical here, otherwise
we cannot just nuke the whole directory.  (Also, -d is important, but
that just kind of goes without saying.)

> Doing the following, it seems to avoid looking for nested .git and all
> tests are passing.
>
> @@ -1007,6 +1008,12 @@ int cmd_clean(int argc, const char **argv,
> const char *prefix)
>                  * the code clearer to exclude it, though.
>                  */
>                 dir.flags |= DIR_KEEP_UNTRACKED_CONTENTS;
> +
> +               /*
> +                * No need to go to deeper in directories if already untracked
> +                */
> +               if (rm_flags == 0)
> +                       dir.flags |= DIR_NO_GITLINKS;
>         }
>
>         if (read_cache() < 0)
>
> However reading the documentation of DIR_NO_GITLINKS seems to say that
> is not the right fix.

I think DIR_NO_GITLINKS has an unfortunately poor description.  The
fill_directory() API has many different callers who use it
differently, see commit 8d92fb2927 ("dir: replace exponential
algorithm with a linear one", 2020-04-01) for some description of
this.  I often ran into problems where descriptions of variables and
items in the documentation tended to focus on one of those modes in
such a way as to make the other modes that also called in be
confusing.  I think the author of the current text was just thinking
of one of those other callers, probably 'git status'.  Looking at the
code, it's intended purpose is just what you're using it for.  (Also,
I probably should have documented DIR_SKIP_NESTED_GIT when I added it
in commit 09487f2cba ("clean: avoid removing untracked files in a
nested git repository", 2019-09-17); the fact that it is similar and
undocumented isn't helping matters, although at the time I didn't know
there was documentation for any of the flags given that they were in
an entirely separate file.)

Anyway, documentation issues aside, I think this is the flag you want
to use, but this is not the right place to set it.  I think you should
set it where rm_flags is set to 0 instead.

Further, setting this flag is only solving part of the performance
problem.  We'll still recurse into the directories to look for ignored
files, which should be avoided since we don't need to differentiate.
That basically means that we need to avoid all the code in the current

   if (remove_directories && !ignored_only)

block, whenever (remove_directories && ignored && !exclude_list.nr &&
force > 1).

> Another thing to note is that it shows "Removing XXX" but it shows it
> when the directory is already gone. So we could change to "Removed
> XXX" or display the "Removing XXX" before starting to remove the
> directory.

I commented on Bagas' patch, but I think this is minutiae that won't
be relevant to the end user, and would rather either ignore it or just
move the print statement earlier rather than increasing work for
translators.  That is, unless we tend to use past tense elsewhere in
the UI and we want to make a concerted effort to convert to using past
tense.

> Thanks in advance for any fix or help in getting it right.

You've clearly taken the time to investigate, and you found the basic
solution too.  That's pretty good, especially considering that you're
dealing with the dragons in dir.[ch].  We could potentially have 1-3
patches here:
  * avoiding the unnecessary checks for is_nonbare_repository_dir()
via setting DIR_NO_GITLINKS.  This is basically your change, just
moved slightly.
  * avoiding the unnecessary attempts to differentiate untracked and
ignored via avoiding the "if (remove_directories && !ignored_only)"
code block when appropriate, as highlighted above
  * fixing up the documentation for DIR_NO_GITLINKS and adding some
for DIR_SKIP_NESTED_GIT.

You've already done most the work for the first one, you'd just need
to move the line elsewhere and add a commit message (though adding a
testcase might be nice too).  Are you up for that?  Would you also
like to tackle either of the other two items?  If you combine the
first and the second, you might find be able to generate a good
testcase by running
    GIT_TRACE2_PERF="$(pwd)/.git/trace.output" git clean -ffdx
and then grepping the trace.output file for "directories-visited" and
"paths-visited" and checking that the new flags indeed reduce both of
those numbers.  Anyway, I'll be happy to review your patch(es) and
will take whichever parts you don't want to tackle.

Thanks for digging in, reporting, and helping make Git better!
