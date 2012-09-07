From: Jim Cromie <jim.cromie@gmail.com>
Subject: help doing a hotfix bisect: cherry-pick -m ??
Date: Fri, 7 Sep 2012 12:44:06 -0600
Message-ID: <CAJfuBxwBn-WFw+nci1MpdWQvyXkrhyB3maXPwMAsxggTE3gz3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 07 20:44:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TA3Y0-0006T6-EG
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 20:44:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756623Ab2IGSol (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Sep 2012 14:44:41 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:45425 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756540Ab2IGSoi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2012 14:44:38 -0400
Received: by weyx8 with SMTP id x8so1958505wey.19
        for <git@vger.kernel.org>; Fri, 07 Sep 2012 11:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=440gKrdawsV/QkKOvri5OUA6VronkbKaoYxk+8Flr4Q=;
        b=L40OxtU9OlJiiZQc8sDTZh7ZE4UZyeB5k2e/mRQUXwM5X1DGI2mpzEqieTTR2VOAWB
         Q4U/M3vAPlLXexhhM0qzcGpNXG84xZvnRzsY31dtSjqY8ifWcNQiBIibOZdcV78wXf5Q
         bGUo3If9Yrn3TY1R310AmCdy+TxLWjBFezSPwYrCXiNlxuGq3DugG09Xxki+Q+jB2U5S
         e71bwgilrlsxqqH33piTcAMDhWIyR5VIHJCyTZ7Ml1ED//ccHbWQbyienMRvYlS71pt9
         +DblikVQGTjuVkIZdv3UvEdTXkfjJ9yuHI8btiPOP81g/6emM0ERITgKuE3aTeMSNWmj
         y2Mw==
Received: by 10.180.79.69 with SMTP id h5mr194068wix.6.1347043477114; Fri, 07
 Sep 2012 11:44:37 -0700 (PDT)
Received: by 10.223.201.197 with HTTP; Fri, 7 Sep 2012 11:44:06 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204986>

hi all.

Im trying to add a jumplabel implementation into dynamic-debug,
and have run into an include-dependency problem.
Ive managed to resolve 1 problem, and am now stuck on how to use cherry-pick -m

1st, the problem Ive handled (just for setup, story)

I did a simple hotfix bisection, adding:

--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h

+#include <linux/jump_label.h>
+

This bisect run pointed to:

    commit b202952075f62603bea9bfb6ebc6b0420db11949
    Author: Gleb Natapov <gleb@redhat.com>
    Date:   Sun Nov 27 17:59:09 2011 +0200

        perf, core: Rate limit perf_sched_events jump_label patching

        jump_lable patching is very expensive operation that involves pausing al
        cpus. The patching of perf_sched_events jump_label is easily controllabl
        from userspace by unprivileged user.
        ...

That commit adds #include <linux/workqueue.h> to dynamic_debug.h,
so I split the workqueue and _deferred elements out to jump_label_deferred.h,
and updated the _deferred users.  The result builds cleanly and boots.


However, once I try adding the above hotfix patch again, I get another handful
of compile-errs (minus 1 that got fixed by above)

And now Im running into bisection troubles.
There are a 1/2 dozen patches to jump-label between Gleb's and -rc4,
which make my patch against rc4 inapplicable.

Ive tried to use the cherry-pick example from the help to pick them all up:
but it craps out (tech term)

git rev-list --reverse b2029520..dyndbg/jump-3a --
include/linux/jump_label.h  | git cherry-pick -n --stdin
error: could not apply c5905af... static keys: Introduce 'struct
static_key', static_key_true()/false() and static_key_slow_[inc|dec]()
hint: after resolving the conflicts, mark the corrected paths
hint: with 'git add <paths>' or 'git rm <paths>'

So I tried again, adding kernel/jump_label.c

git rev-list --reverse b2029520..dyndbg/jump-3a --
include/linux/jump_label.h kernel/jump_label.c | git cherry-pick -n
--stdin
error: Commit 9e31905f293ae84e4f120ed9e414031eaefa0bdf is a merge but
no -m option was given.
fatal: cherry-pick failed

Ive tried several variations on -m <arg>, trying 1, 2, parent-sha,
(thats quite wrong)
I keep getting this err:

git rev-list --reverse b2029520..dyndbg/jump-3a --
include/linux/jump_label.h kernel/jump_label.c | git cherry-pick -n
--stdin -m 1
error: Mainline was specified but commit
9cdbe1cbac4ec318037297175587a0080acc9d11 is not a merge.

I find the -m help text completely unenlightening.
what is a parent number ?
where does it start from ?

Im trying to cherry pick from master to hotfix-2, I presume thats a
normal/natural usage.

are parent numbers relative to the branch Im on, or the branch Im
cherry-picking from ?
or something else completely.

Broader question:
presuming I do manage to cherry-pick the right set commits, should I
drop the -n ?
Im thinking that having a hotfix branch, and merging --no-commit would
work better,
especially when bisection lands on a commit which already contains
some of those in the hotfix branch.
Am I thinking rightly ?  Anything else to add ??


Since concrete, in-context advice would be so much more helpful than
tips using foo, bar, etc,
Ive pushed my branch to github, user jimc, branch dyndbg/jump-3a

git://github.com/jimc/linux-2.6.git
https://github.com/jimc/linux-2.6.git
https://github.com/jimc/linux-2.6/tree/dyndbg/jump-3a

thanks in advance.
