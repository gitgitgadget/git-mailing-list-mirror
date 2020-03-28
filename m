Return-Path: <SRS0=KP1k=5N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E010C43331
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 12:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A3B7206F6
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 12:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgC1MYu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Mar 2020 08:24:50 -0400
Received: from chiark.greenend.org.uk ([212.13.197.229]:59559 "EHLO
        chiark.greenend.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbgC1MYu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Mar 2020 08:24:50 -0400
X-Greylist: delayed 1730 seconds by postgrey-1.27 at vger.kernel.org; Sat, 28 Mar 2020 08:24:47 EDT
Received: by chiark.greenend.org.uk (Debian Exim 4.84_2 #1) with local
        (return-path ijackson@chiark.greenend.org.uk)
        id 1jIA4B-0002CS-BR; Sat, 28 Mar 2020 11:55:55 +0000
From:   Ian Jackson <ijackson@chiark.greenend.org.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed;
         boundary="zlLKc6YI0d"
Content-Transfer-Encoding: 7bit
Message-ID: <24191.15179.253629.878217@chiark.greenend.org.uk>
Date:   Sat, 28 Mar 2020 11:55:55 +0000
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Paul Gevers <elbrus@debian.org>,
        Elijah Newren <newren@gmail.com>
Subject: Re: git-rebase ignores or squashes GIT_REFLOG_ACTION
In-Reply-To: <20200328023438.GA202996@google.com>
References: <6776c32d-35f5-3134-35c7-1c9b803d8c37@debian.org>
        <24190.33234.108820.211871@chiark.greenend.org.uk>
        <20200328023438.GA202996@google.com>
X-Mailer: VM 8.2.0b under 24.4.1 (i586-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--zlLKc6YI0d
Content-Type: text/plain; charset=us-ascii
Content-Description: message body text
Content-Transfer-Encoding: 7bit

Jonathan Nieder writes ("Re: git-rebase ignores or squashes GIT_REFLOG_ACTION"):
> The main relevant change is that "git rebase" switched its default
> backend from "apply" to "merge".  This makes it more robust by using
> three-way merges in a similar way to "git cherry-pick".  The "merge"
> backend was historically already used for interactive rebases.

Ah.  Interesting.  A co-worker had a case recently where "merge" did
the wrong thing (silently misapplied a hunk!) but "apply" did the
right thing and I remmber thinking that "merge" ought to be the
default (since it can do a better job by using all of the available
information).  So I applaud that change.

> If I am reading
> 
>  commit 13a5a9f0fdcf36270dcc2dcb7752c281bbea06f1
>  Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>  Date:   Thu Nov 29 11:09:21 2018 -0800
> 
>      rebase: fix GIT_REFLOG_ACTION regression
> 
> correctly, then dgit requires that to be '-i' for interactive rebases.
> Are we sure that that's not the issue here?

git-debrebase invokes git-rebase both with and without -i, depending
on the user's own choice.  In this case, git-debrebase is invoking
git-rebase *without* -i.

But maybe I have misunderstood.  Maybe you mean `are you sure the test
case doesn't demand that "-i" appears in the reflog' ?  In which case,
yes.  The failing line in the test case (which is a shell script) is:
  git reflog | egrep 'debrebase new-upstream.*checkout'

Here is a repro for the problem.  Run the attached script, optionally
with "-i" as a single argument.  The script will "rm -rf d" and
recreate it.  It sets GIT_REFLOG_ACTION="plim" and does a nontrivial
rebase in a fresh tree, and prints the resulting reflog.

On older git, without -i, quoting only the relevant bits:
  fc9165e HEAD@{0}: rebase finished: returning to refs/heads/master
  fc9165e HEAD@{1}: plim: 3
  ebf6515 HEAD@{2}: plim: checkout HEAD~2
This is right except for the final finish message.

On older git, with -i:
  4f6cff0 HEAD@{0}: plim: checkout HEAD~2: returning to refs/heads/master
  4f6cff0 HEAD@{1}: plim: checkout HEAD~2: 3
  9f5e72d HEAD@{2}: plim: checkout HEAD~2
This seems to be wrong for all but the initial checkout.

On newer git, I get this output both with and without -i:
  30067e1 HEAD@{0}: rebase (finish): returning to refs/heads/master
  30067e1 HEAD@{1}: rebase (pick): 3
  8a9a5fd HEAD@{2}: rebase (start): checkout HEAD~2
This is wrong because it doesn't mention "plim" at all.  That's
what is spotted by my test case.

I think the best output would be this:
  30067e1 HEAD@{0}: plim (finish): returning to refs/heads/master
  30067e1 HEAD@{1}: plim (pick): 3
  8a9a5fd HEAD@{2}: plim (start): checkout HEAD~2
or this:
  30067e1 HEAD@{0}: plim: rebase (finish): returning to refs/heads/master
  30067e1 HEAD@{1}: plim: rebase (pick): 3
  8a9a5fd HEAD@{2}: plim: rebase (start): checkout HEAD~2

Which of those two is better depends on whether you think callers
ought to put something to do with "rebase" in GIT_REFLOG_ACTION
somewhere.  In this particular case, git-debrebase sets it to
something like
  debrebase new-upstream $new_version: rebase
because it thinks that its GIT_REFLOG_ACTION value will replace
the usual "rebase", rather than supplementing it.

I think either choice on git-rebase's part would be reasonable and the
output with current git-debrebase behaviour is good enough either way.
The former choice on git-rebase's part would produce the prettiest
output with my current setting of GIT_REFLOG_ACTION.  And it allows
the caller the most control over the reflog messages.  Unconditionally
adding the top-level command being invoked could be simulated by the
caller (whereas adding things like "(finish)" cannot).  So if it were
up to me I would have git-rebase produce the first of my two expected
outputs, ie
  30067e1 HEAD@{0}: plim (finish): returning to refs/heads/master
etc.

But my test case merely demands that "plim" appears *somewhere*.


Aside:

Obviously with an interactive rebase, it might well stop, and the user
will then later presumably git-rebase --continue (or maybe --abort)
etc.  Those commands will no longer (necessarily) have
GIT_REFLOG_ACTION in their environment.  So, with the obvious
implementation, depending on the circumstances the reflog for later
parts of the rebase might not contain all the relevant information.

This is unavoidable unless git-rebase were to make a note of the value
of GIT_REFLOG_ACTION somewhere - and even in that case, it wouldn't
affect git commit (which is often a thing that is run in the middle of
an interactive rebase) unless this note had a global effect.  It seems
to me that it would be a bad idea for git-rebase to do anything like
this.  Not only would it have to squirrel away GIT_REFLOG_ACTION and
(perhaps surprisingly) honour it later, it would presumably have to
try to combine it with the value in force during later commands.

This would all be complicated and provide plenty of opportunity for
weird corner case bugs, in order to do something which (to say the
least) it's not clear is desirable.

Instead, I think that the GIT_REFLOG_ACTION in the environment of
git-rebase should take effect for all the things that are done
by or on behalf of that git-rebase command until that git-rebase
command has exited.  Future commands should honour the
GIT_REFLOG_ACTION in force at that later time.  I hope you
agree :-), and I'm giving this aside for completeness.


I hope this is helpful.

Ian.


--zlLKc6YI0d
Content-Type: text/plain;
	 name="t.sh"
Content-Disposition: inline;
	 filename="t.sh"
Content-Transfer-Encoding: 7bit

#!/bin/bash
set -e
rm -rf d
mkdir d
cd d

export EDITOR=true
export VISUAL=true

git init

for x in 1 2 3; do
    echo $x >$x
    git add $x
    git commit -m $x
done

git branch old

GIT_REFLOG_ACTION=plim git rebase "$@" --onto HEAD~2 HEAD~1

git reflog |cat

--zlLKc6YI0d
Content-Type: text/plain; charset=us-ascii
Content-Description: .signature
Content-Transfer-Encoding: 7bit


-- 
Ian Jackson <ijackson@chiark.greenend.org.uk>   These opinions are my own.

If I emailed you from an address @fyvzl.net or @evade.org.uk, that is
a private address which bypasses my fierce spamfilter.

--zlLKc6YI0d--
