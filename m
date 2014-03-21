From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT 00/28] Teach guilt import-commit how create legal patch names, and more
Date: Fri, 21 Mar 2014 08:31:38 +0100
Message-ID: <1395387126-13681-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Fri Mar 21 08:33:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQtxB-0001y5-6B
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 08:33:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753360AbaCUHcq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 03:32:46 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:33106 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751488AbaCUHcp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 03:32:45 -0400
Received: by mail-la0-f48.google.com with SMTP id gf5so1390857lab.35
        for <git@vger.kernel.org>; Fri, 21 Mar 2014 00:32:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZlIflGOZJW41xLdezQjS8oZizStkVD3VSxXW34Qv0CE=;
        b=d3LuLqPzKyAO+JO1OyIqNot4sSzh5xe1to/G/MMRFR0WJwwhvliCZfMyijcyrPUYk3
         lRS5sdt7dfVvSUsIperMZm/0JGqtD/rYMot2QDanenua0N72KwLXORRhwDqn/20I1Sfm
         gv4rt5WfakngixoVaDlsSZ6HsVNNlMYaCXxyvv56axX36iuZmbCzoC3KaAFEEOtF5kye
         DIzEC3QKcOrJsLw7Tf5957j6jsxU7AlS2Ii2jRlHBEiBMNRuSqvwxOp3FRyq3bh1mMsp
         AJv0x0HklKZA9GbEXpDLXVk9iHT+MhhUL0p0B6xhEQFINW8VWnX+wTLcbwVcRlRtjrjz
         zePQ==
X-Gm-Message-State: ALoCoQmRVOT4VPNOTPxmcdxxR5gcQ9bmMnI1LuP8DD8hrEk8yqM7lZwu4MjP+LzekrbXh/vU94hQ
X-Received: by 10.152.170.137 with SMTP id am9mr33189438lac.15.1395387163567;
        Fri, 21 Mar 2014 00:32:43 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id j2sm3986624lag.12.2014.03.21.00.32.42
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Mar 2014 00:32:42 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244645>

I recently found myself sitting on a train with a computer in front of
me.  I tried to use "guilt import-commit", which seemed to work, but
when I tried to "guilt push" the commits I had just imported I got
some errors.  It turned out that "guilt import-commit" had generated
invalid patch names.

I decided to fix the issue, and write a test case that demonstrated
the problem.

One thing led to another, and here I am, a few late nights at a hotel
and a return trip on the train later, submitting a patch series in 28
parts.  Sorry about the number of patches, but this is what happens
when you uncover a bug while writing a test case for the bug you
uncovered while writing a test case for your original problem.

The patch series consists of:

 - A number of fixes to the test suite.

 - A number of bug fixes which I hope are non-controversial.  Most of
   the fixes have test cases.

 - Changed behavior: "guilt push" when there is nothing more to push
   now uses exit status 1.  This makes it possible to write shell
   loops such as "while guilt push; do make test||break; done".  Also,
   "guilt pop" when no patches are applied also uses exit status 1.
   (This aligns "guilt push" and "guilt pop" with how "hg qpush" and
   "hg qpop" has worked for several years.)

 - Changed behavior: by default, guilt no longer changes branch when
   you push a patch.  You need to do "git config guilt.reusebranch
   false" to re-enable that.  This patch sets the default value of
   guilt.reusebranch to true; it should in my opinion change to false
   a year or two after the next release.

A more detailed overview of the patches:

1. Some tests fail if "git config guilt.diffstat true" is in effect.

2-4. Some commands fail if run from a directory with spaces in its
     name.

5. "guilt new" had an overly restrictive argument parser.

6-8. guilt.diffstat could break "guilt fold" and "guilt new".

9-10. The test suite did not test exit status properly.

11. Remove pointless redirections in the test suite.

12-13. "guilt header" tried to check if a patch existed, but the check
        was broken.

14-16. Various parts of guilt tried to ensure that patch names were
       legal git branch names, but failed.

17-20. "guilt graph" failed when no patch was applied, and when a
       branch name contained a comma or a quote.

21-23. "git config log.decorate short" caused "guilt import-commit",
       "guilt patchbomb" and "guilt rebase" to fail in various ways.

24. Patches may contain backslashes, but various informative messages
    from guilt did backslash processing.

25-26. "guilt push" and "guilt pop" should fail when there is nothing
       to do.

27-28. These two commits were things I intended to contribute a while
       back, when contributing the "Change git branch when patches are
       applied" change (commit 67d3af63f422).  These commits makes
       that behavior optional, and it defaults to being disabled, so
       that you can use both Guilt v0.35 (and earlier) and the current
       Guilt code against the same repo.  These commits add some code
       complexity, and you might want to skip them if you think the
       current behavior is better.

This patch series is also available on
http://repo.or.cz/w/guilt/ceder.git in the "oslo-2014" branch.  If you
already have a copy of guilt, you should be able to fetch that branch
with something like:

    git remote add ceder http://repo.or.cz/r/guilt/ceder.git
    git fetch ceder refs/heads/oslo-2014:refs/remotes/ceder/oslo-2014

A few of the regression/t-*.out files contain non-ASCII characters.  I
hope they survive the mail transfer; if not, please use the repo above
to fetch the commits.


Per Cederqvist (28):
  The tests should not fail if guilt.diffstat is set.
  Allow "guilt delete -f" to run from a dir which contains spaces.
  Added test case for "guilt delete -f".
  Allow "guilt import-commit" to run from a dir which contains spaces.
  "guilt new": Accept more than 4 arguments.
  Fix and simplify the do_get_patch function.
  Added test cases for "guilt fold".
  Added more test cases for "guilt new": empty patches.
  Test suite: properly check the exit status of commands.
  Run test_failed if the exit status of a test script is bad.
  test suite: remove pointless redirection.
  "guilt header": more robust header selection.
  Check that "guilt header '.*'" fails.
  Use "git check-ref-format" to validate patch names.
  Produce legal patch names in guilt-import-commit.
  Fix backslash handling when creating names of imported patches.
  "guilt graph" no longer loops when no patches are applied.
  guilt-graph: Handle commas in branch names.
  Check that "guilt graph" works when working on a branch with a comma.
  "guilt graph": Handle patch names containing quotes.
  The log.decorate setting should not influence import-commit.
  The log.decorate setting should not influence patchbomb.
  The log.decorate setting should not influence guilt rebase.
  disp no longer processes backslashes.
  "guilt push" now fails when there are no more patches to push.
  "guilt pop" now fails when there are no more patches to pop.
  Minor testsuite fix.
  Added guilt.reusebranch configuration option.

 guilt                |  76 ++++--
 guilt-delete         |   2 +-
 guilt-fork           |   2 +-
 guilt-graph          |  14 +-
 guilt-header         |  33 ++-
 guilt-import         |   2 +-
 guilt-import-commit  |  32 ++-
 guilt-new            |   9 +-
 guilt-patchbomb      |   2 +-
 guilt-pop            |  13 +-
 guilt-push           |  14 +-
 guilt-rebase         |   2 +-
 regression/run-tests |  11 +-
 regression/scaffold  |  19 +-
 regression/t-020.out | 339 ++++++++++++++++++++++++++
 regression/t-020.sh  |  73 +++++-
 regression/t-021.out |   2 +
 regression/t-021.sh  |   8 +-
 regression/t-025.out | 426 ++++++++++++++++++++++++++++++++-
 regression/t-025.sh  |  14 +-
 regression/t-026.out |  15 ++
 regression/t-026.sh  |   5 +-
 regression/t-028.out |   7 +
 regression/t-028.sh  |   6 +-
 regression/t-032.out |   4 +-
 regression/t-032.sh  |   2 +-
 regression/t-033.out |  87 +++++++
 regression/t-033.sh  |  57 +++++
 regression/t-034.out | 569 ++++++++++++++++++++++++++++++++++++++++++++
 regression/t-034.sh  |  74 ++++++
 regression/t-035.out | 659 +++++++++++++++++++++++++++++++++++++++++++++++++++
 regression/t-035.sh  |  88 +++++++
 regression/t-061.out |   1 -
 regression/t-061.sh  |   9 +-
 regression/t-062.out | 441 ++++++++++++++++++++++++++++++++++
 regression/t-062.sh  | 140 +++++++++++
 36 files changed, 3168 insertions(+), 89 deletions(-)
 create mode 100644 regression/t-033.out
 create mode 100755 regression/t-033.sh
 create mode 100644 regression/t-034.out
 create mode 100755 regression/t-034.sh
 create mode 100644 regression/t-035.out
 create mode 100755 regression/t-035.sh
 create mode 100644 regression/t-062.out
 create mode 100755 regression/t-062.sh

Yours,
    /ceder

-- 
1.8.3.1
