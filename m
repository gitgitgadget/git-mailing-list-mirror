Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DA6F1F991
	for <e@80x24.org>; Mon, 31 Jul 2017 21:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751054AbdGaV0e (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Jul 2017 17:26:34 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:35474 "EHLO
        coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751059AbdGaV0d (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2017 17:26:33 -0400
Received: from localhost (243.103.2.81.in-addr.arpa [81.2.103.243])
        by coral.adamspiers.org (Postfix) with ESMTPSA id 0493A2E01A
        for <git@vger.kernel.org>; Mon, 31 Jul 2017 22:18:51 +0100 (BST)
From:   Adam Spiers <git@adamspiers.org>
To:     git list <git@vger.kernel.org>
Subject: [PATCH 0/1] add git-splice subcommand for non-interactive branch splicing
Date:   Mon, 31 Jul 2017 22:18:48 +0100
Message-Id: <cover.55495badd28b73b39c60ca4107b50aae7ee95028.1501535033.git-series.git@adamspiers.org>
X-Mailer: git-send-email 2.14.0.rc1.2.g921b285a1.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch adds a new subcommand called git-splice, which facilitates
higher-level workflow operations in the area of branch management, for
example moving commits from one branch into another, or decomposing
large branches into smaller, independent branches, or vice-versa.

Motivation
----------

By now git is very mature, and excels at low-level plumbing and
porcelain operations.  However, developer workflows have become
increasingly sophisticated, partially as a result of CI / review
systems supporting development and testing of large numbers of
concurrent patches to the same repository.  These systems can track
dependencies / conflicts between those patches (gerrit) or group
series of related commmits into a single topic (GitLab merge requests;
GitHub pull requests).

This trend towards higher-level workflows has also driven innovations
in branch management tools (e.g. topgit, gitflow, gitwork,
git-series).  I expect this trend to continue, and git UIs to evolve
which make re-organising commits between branches almost as easy as
moving files around a filesystem with a file manager tool.

Of course, any git UI which aids the user in manipulating branches can
already automate the tasks using existing porcelain and plumbing.  But
this will typically require mid-level operations, such as:

  1) removing commits from a branch
  2) porting (copying) commits from one branch into another
  3) moving commits from one branch into another
  4) predicting when any of the above will cause conflicts
  5) decomposing large branches into smaller, independent branches
     in order to reduce conflicts

Performing these operations using existing porcelain is cumbersome,
generally involving manual (i.e. interactive) use of git rebase -i
etc.  However, automated higher-level workflows will need these
operations to be as *non*-interactive as possible.

Therefore there is a risk that each new UI for higher-level workflows
will end up re-implementing these mid-level operations.  This
undesirable situation could be avoided if git itself provided those
mid-level operations.

This is where git-splice comes in.  It handles operations 1) and 2),
and lays the foundation for git-transplant, another git subcommand I
have written which implements 3).  (See below for more info on this,
and on other tools related to 4) and 5)).

Description
-----------

git-splice(1) non-interactively splices the current branch by removing
a range of commits from within it and/or cherry-picking a range of
commits into it.

It's essentially a convenience wrapper around cherry-pick and
interactive rebase, but the workflow state is persisted to disk, and
thereby supports standard --abort and --continue semantics just like
git's other extended workflow commands.  It also handles more complex
cases, as briefly demonstrated by the examples below.

(See git-splice.txt in the patch for full detail.)

Example usage
-------------

    # Remove commits A..B (i.e. excluding A) from the current branch.
    git splice A..B

    # Remove commit A from the current branch.
    git splice A^!

    # Remove commits A..B from the current branch, and cherry-pick
    # commits C..D at the same point.
    git splice A..B C..D

    # Cherry-pick commits C..D, splicing them in just after commit A.
    git splice A C..D

    # Remove all commits since 11am this morning mentioning "foo".
    git splice --since=11am --grep="foo" --

    # Remove commit A and all its ancestors (including the root commit)
    # from the current branch.
    git splice --root A

    # Abort a splice which failed during cherry-pick or rebase.
    git splice --abort

    # Resume a splice after manually fixing conflicts caused by
    # cherry-pick or rebase.
    git splice --continue

Remaining work
--------------

The code does not yet conform 100% to Documentation/CodingGuidelines.
The only known areas of non-conformance are:

    1. It relies on bash arrays, which is a non-POSIX feature.

    2. It does not support i18n.

I would be more than happy to fix these if there is a chance of
git-splice being accepted for inclusion within the git distribution.

I appreciate that adding a new subcommand to git automatically brings
concerns about the increase in maintenance burden.  ICBW but I would
expect git-splice to add significantly less burden than the last
subcommand I wrote (check-ignore), because it only relies on very
mainstream porcelain commands and one plumbing command (update-ref).
OTOH, the test suite makes very heavy use of git's test framework, so
separating it out into a separate tree would presumably be
non-trivial.

Previous and recent work
------------------------

I first announced git-splice just over a year ago:

    https://www.spinics.net/lists/git/msg277346.html
    https://public-inbox.org/git/20160527140811.GB11256@pacific.linksys.moosehall/

I have just fixed all known remaining issues and further beefed up the
test suite, so I think it's now ready for serious consideration.
(Previously I merely provided a URL to a branch, but did not actually
submit a patch.)

Related tools
-------------

I have also implemented git-transplant as a further patch on top of
this one:

    https://github.com/aspiers/git/compare/splice...aspiers:transplant

and other tools which provide additional help with moving/copying
commits from one branch to another, and with predicting and avoiding
any conflicts which could arise.  They are out of scope for this post,
so I will just give links for anyone who is interested:

    https://blog.adamspiers.org/2015/01/19/git-deps/
    https://blog.adamspiers.org/2013/09/19/easier-upstreaming-with-git/

All feedback is of course very welcome!

Thanks,
Adam

Adam Spiers (1):
  add git-splice command for non-interactive branch splicing

 .gitignore                   |   1 +-
 Documentation/git-splice.txt | 125 ++++++-
 Makefile                     |   1 +-
 git-splice.sh                | 737 ++++++++++++++++++++++++++++++++++++-
 t/t7900-splice.sh            | 630 +++++++++++++++++++++++++++++++-
 5 files changed, 1494 insertions(+)
 create mode 100644 Documentation/git-splice.txt
 create mode 100755 git-splice.sh
 create mode 100755 t/t7900-splice.sh

base-commit: 5800c63717ae35286a1441f14ffff753e01f7e2b
-- 
git-series 0.9.1
