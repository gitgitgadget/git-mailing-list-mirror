From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v2 00/29] Teach guilt import-commit how to create legal patch names, and more
Date: Tue, 13 May 2014 22:30:36 +0200
Message-ID: <1400013065-27919-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Tue May 13 22:31:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkJMe-0006pp-2q
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 22:31:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752310AbaEMUbt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 16:31:49 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:34642 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751145AbaEMUbr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 16:31:47 -0400
Received: by mail-la0-f47.google.com with SMTP id pn19so708205lab.34
        for <git@vger.kernel.org>; Tue, 13 May 2014 13:31:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kravIx2ro3hFVI8uF9tBvNZitDOpAk5oz4CLf6Jwres=;
        b=XChmbkETsp4vbdH9b8xoWDQ0OiB0Avamc4Gy4MZebZwcKxgP2cAL6bbO9Kh8tGL+ql
         VGJouiXc2Gj3EMiQsn9LLU+RJt3uZXLsUppeNEnRbJWNkGl9mba+MiIo5p7UjJsAMMSs
         la8Otj7qusXWkWafurYXkBjP+NQMqHXc7ahF0HMHEmQzEDu9acJTamDLAbF074wG2jmc
         eq6tih4Ix6ZonKpUWCUntp5F97SuLMMkAro+fr5LxmLj8Ht6BYAD2oq3w1TPpVMQ7HVl
         0NUcD4fP38otAgLXGcGgvbIw2+M5GBZIXvS/PYhpePYksZkwjCjd2+3zErwcg2fAcRNv
         k17g==
X-Gm-Message-State: ALoCoQn4jrArpkHXin8cPegTfVZZZYTVj6g4pFkEBwuuN02E24Nt313XzvzKU5KIvmOKeyxooCiM
X-Received: by 10.152.5.135 with SMTP id s7mr3000092las.55.1400013105704;
        Tue, 13 May 2014 13:31:45 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id m2sm11431763lbp.31.2014.05.13.13.31.43
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 13 May 2014 13:31:44 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248815>

This is version two of the patch series I sent back on 21 Mar 2014.  I
have addressed all feedback to date, updated the coding style, and
added signed-off-by lines from Jeff Sipek for those commits that I
have received an explicit approval from him (but only if I have not
made any other change to that particular commit).

I have also added one more patch: a very limited coding style guide,
and accompanying settings for Emacs.  See the last commit in the
series.  All other commits have retained their numbering.

To see how the patches have evolved, you might find
http://www.lysator.liu.se/~ceder/guilt-oslo-2014-v2/ useful.  It
displays diffs of all the patches, in pdiffdiff output format.

Here is the original blurb for the series, slightly edited:

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

 - The humble beginnings of a coding style guide.

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

29. A coding style guide, with Emacs support.

This patch series is also available on
http://repo.or.cz/w/guilt/ceder.git in the "oslo-2014-v2" branch.  If
you already have a copy of guilt, you should be able to fetch that
branch with something like:

    git remote add ceder http://repo.or.cz/r/guilt/ceder.git
    git fetch ceder refs/heads/oslo-2014-v2:refs/remotes/ceder/oslo-2014-v2

A few of the regression/t-*.out files contain non-ASCII characters.  I
hope they survive the mail transfer; if not, please use the repo above
to fetch the commits.


Per Cederqvist (29):
  The tests should not fail if guilt.diffstat is set.
  Allow "guilt delete -f" to run from a dir which contains spaces.
  Added test case for "guilt delete -f".
  Allow "guilt import-commit" to run from a dir which contains spaces.
  "guilt new": Accept more than 4 arguments.
  Fix the do_get_patch function.
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
  Added a short style guide, and Emacs settings.

 .dir-locals.el             |   3 +
 Documentation/Contributing |  15 ++
 guilt                      |  68 ++++--
 guilt-delete               |   2 +-
 guilt-fork                 |   2 +-
 guilt-graph                |  13 +-
 guilt-header               |  28 ++-
 guilt-import               |   2 +-
 guilt-import-commit        |  30 ++-
 guilt-new                  |   9 +-
 guilt-patchbomb            |   2 +-
 guilt-pop                  |  17 +-
 guilt-push                 |  19 +-
 guilt-rebase               |   2 +-
 regression/run-tests       |  10 +-
 regression/scaffold        |  19 +-
 regression/t-020.out       | 339 +++++++++++++++++++++++++++
 regression/t-020.sh        |  73 +++++-
 regression/t-021.out       |   2 +
 regression/t-021.sh        |   8 +-
 regression/t-025.out       | 426 ++++++++++++++++++++++++++++++++-
 regression/t-025.sh        |  14 +-
 regression/t-026.out       |  15 ++
 regression/t-026.sh        |   5 +-
 regression/t-028.out       |   7 +
 regression/t-028.sh        |   6 +-
 regression/t-032.out       |   4 +-
 regression/t-032.sh        |   2 +-
 regression/t-033.out       |  90 +++++++
 regression/t-033.sh        |  61 +++++
 regression/t-034.out       | 569 +++++++++++++++++++++++++++++++++++++++++++++
 regression/t-034.sh        |  73 ++++++
 regression/t-035.out       | 467 +++++++++++++++++++++++++++++++++++++
 regression/t-035.sh        |  62 +++++
 regression/t-061.out       |   1 -
 regression/t-061.sh        |   8 +-
 regression/t-062.out       | 441 +++++++++++++++++++++++++++++++++++
 regression/t-062.sh        | 137 +++++++++++
 38 files changed, 2966 insertions(+), 85 deletions(-)
 create mode 100644 .dir-locals.el
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
