Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44BBE2036D
	for <e@80x24.org>; Sun, 19 Nov 2017 01:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750982AbdKSBxi (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Nov 2017 20:53:38 -0500
Received: from sdaoden.eu ([217.144.132.164]:39152 "EHLO sdaoden.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750954AbdKSBxh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Nov 2017 20:53:37 -0500
X-Greylist: delayed 505 seconds by postgrey-1.27 at vger.kernel.org; Sat, 18 Nov 2017 20:53:36 EST
Received: by sdaoden.eu (Postfix, from userid 1000)
        id BF38716045; Sun, 19 Nov 2017 02:45:09 +0100 (CET)
Date:   Sun, 19 Nov 2017 02:45:08 +0100
From:   Steffen Nurpmeso <steffen@sdaoden.eu>
To:     git@vger.kernel.org
Subject: v2.15.0: commits become falsely joined when rebasing
 (interactively)
Message-ID: <20171119014508.OOpRb%steffen@sdaoden.eu>
Mail-Followup-To: git@vger.kernel.org,
 Steffen Nurpmeso <steffen@sdaoden.eu>
User-Agent: s-nail v14.9.5-29-gab03c38f
OpenPGP: id=232C220BCB5690A37BD22FFDEB66022795F382CE;
 url=https://www.sdaoden.eu/downloads/steffen.asc
BlahBlahBlah: Any stupid boy can crush a beetle. But all the professors in
 the world can make no bugs.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello again,

i see an error with v2.15.0 that happened already back in early
October (AlpineLinux [edge] pretty much up-to-date with newest git
but please don't ask exact version).  I failed to reproduce it
back then, but now again, here is how.

- It seems related to having a hook (pre-commit), and the "reword"
  action.
- Doing a rebase interactively to move (two) commits back from
  HEAD downwards in a linear hierarchy, as in
    * 306b5c7e (HEAD -> refs/heads/notpushed) [-] COMMIT 1
    * 7e34d5fa [-] COMMIT 2
  the above two to be moved down
    * 65d216c3 (refs/remotes/origin/notpushed)...
    ...
    * 5ff5ef05 (refs/remotes/origin/next, refs/heads/next) [-]..
  to end up stacked upon and as new [next]

- COMMIT 2 is to be picked, but COMMIT 1 shall be "r"eworded.

Now what happens is that COMMIT 2 is rebased ok, but instead of
simply opening the editor to allow rewording of the commit message
of COMMIT 2 the pre-commit hook runs, and it has to complain in
this case (lines too long), but i "commit -n" that once
i committed first.  Anyway git says

  You can amend the commit now, with

    git commit --amend

  Once you are satisfied with your changes, run

    git rebase --continue

Which i have not asked for!  More:

  ?1[steffen@essex nail.git]$ git status
  interactive rebase in progress; onto 6d437ab6
  Last commands done (12 commands done):
     pick 7e34d5fa [-] COMMIT 2
     r 306b5c7e [-] COMMIT 1
    (see more in file .git/rebase-merge/done)
  Next commands to do (27 remaining commands):
  ...
    (use "git rebase --edit-todo" to view and edit)
  You are currently rebasing branch 'notpushed' on '6d437ab6'.
    (all conflicts fixed: run "git rebase --continue")

  Changes to be committed:
    (use "git reset HEAD <file>..." to unstage)

          modified:   gen-okeys.h

  Untracked files not listed (use -u option to show untracked files)

So far so good, but now:

  ?0[steffen@essex nail.git]$ git rec
alias: rebase --continue
  [detached HEAD ca77a94a] COMMIT 1 with adjusted commit message
   Date: Sun Nov 19 02:19:30 2017 +0100
   9 files changed, 357 insertions(+), 339 deletions(-)
  Successfully rebased and updated refs/heads/notpushed.

Uh!  It joined COMMIT 1 with COMMIT 2!
Thanks for git!

Ciao,

--steffen
|
|Der Kragenbaer,                The moon bear,
|der holt sich munter           he cheerfully and one by one
|einen nach dem anderen runter  wa.ks himself off
|(By Robert Gernhardt)
