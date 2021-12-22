Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA5AC433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 02:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238742AbhLVCkj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 21:40:39 -0500
Received: from elephants.elehost.com ([216.66.27.132]:16219 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbhLVCkj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 21:40:39 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 1BM2eaSr063260
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 21:40:37 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
Subject: [BUG] Submodule Pull
Date:   Tue, 21 Dec 2021 21:40:31 -0500
Organization: Nexbridge Inc.
Message-ID: <00f001d7f6dd$4d278580$e7769080$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: Adf225x9H6tVcO5oR6m1yb/suCThNQ==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi All,

I have been working with a submodule, with a single local change. Trying to
(accidentally) pull the submodule to pick up changes from upstream resulted
in the change disappearing but blocking the pull/merge. The only way I was
able to recover the situation was to restore the file that was in the pull
error - fortunately, I know what the change was. I should know better, but
this situation escapes me. git version is 2.34.1 on NonStop x86.

What I expected was that the uncommitted change could be stashed
successfully or at least the diff would should up. My suspicion was that the
merge state prevented my ability to view what was going on. I probably
should have done a git merge --abort, which I expect would have cleared the
situation, but it is not intuitive. The log follows - and the user and repo
names are fake. The master branch is being changed to main, but we did not
finish the conversion on this submodule.

--Randall

$: git pull
Password for 'https://bobttester@bitbucket.org':

remote: Enumerating objects: 11, done.
remote: Counting objects: 100% (11/11), done.
remote: Compressing objects: 100% (6/6), done.
remote: Total 6 (delta 4), reused 0 (delta 0), pack-reused 0
Unpacking objects: 100% (6/6), 1.58 KiB | 12.00 KiB/s, done.
From https://bitbucket.org/main/submodule
   ca2d4d3..0bb118a  mybranch -> origin/mybranch
Updating ca2d4d3..0bb118a
error: Your local changes to the following files would be overwritten by
merge:
        Makefile.common
Please commit your changes or stash them before you merge.
Aborting
$ git diff
$ git status
On branch mybranch
Your branch is behind 'origin/mybranch ' by 1 commit, and can be
fast-forwarded.
  (use "git pull" to update your local branch)

nothing to commit, working tree clean
$ git diff --cached
$ git pull
Password for 'https://bobttester@bitbucket.org':

Updating ca2d4d3..0bb118a
error: Your local changes to the following files would be overwritten by
merge:
        Makefile.common
Please commit your changes or stash them before you merge.
Aborting
$ git stash push
No local changes to save
$ git log --oneline --decorate --graph --simplify-by-decoration
* 0bb118a (origin/mybranch) Support for measurement gathering
* ca2d4d3 (HEAD -> mybranch) Corrected usage of VMATCH
* 1739739 (origin/main, main) nsmt.c: Corrected CPU computation
| * ec45c8d (origin/master, origin/HEAD) Reduced the time to beginning of
time
| * bae1662 (master) Add beginning of time check
|/
* 6be05d2 README.md created online with Bitbucket
$ git merge origin/mybranch
Updating ca2d4d3..0bb118a
error: Your local changes to the following files would be overwritten by
merge:
        Makefile.common
Please commit your changes or stash them before you merge.
Aborting
$ git commit -a
On branch mybranch
Your branch is behind 'origin/mybranch' by 1 commit, and can be
fast-forwarded.
  (use "git pull" to update your local branch)

nothing to commit, working tree clean
$ git restore -- Makefile.common
$ git status
On branch mybranch
Your branch is behind 'origin/mybranch' by 1 commit, and can be
fast-forwarded.
  (use "git pull" to update your local branch)

nothing to commit, working tree clean
$ git pull
Password for 'https://bobttester@bitbucket.org':

Updating ca2d4d3..0bb118a
Fast-forward
 Makefile.common |  2 +-
 metra.c         |  6 +++++-
 metra.h         | 30 ++++++++++++++++++++++++------
 nsmt.c          | 32 +++++++++++++++++++++++++++-----
 4 files changed, 57 insertions(+), 13 deletions(-)

