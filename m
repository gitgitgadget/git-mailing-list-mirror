From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 00/23] replace "checkout --to" with "worktree add"
Date: Fri,  3 Jul 2015 20:17:09 -0400
Message-ID: <1435969052-540-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 04 02:18:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZBBAK-00004v-Hb
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jul 2015 02:18:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755804AbbGDAS3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2015 20:18:29 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:37868 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752714AbbGDAS1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2015 20:18:27 -0400
Received: by igblr2 with SMTP id lr2so84923440igb.0
        for <git@vger.kernel.org>; Fri, 03 Jul 2015 17:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=TLpG+x0dkqid8FgGsWx5jUxcwFT8atff2QTHg04jdJQ=;
        b=kU4p5kZVf0Q9JgpGZYainhnM9XA2ICoUbqWiH49DpuUEVgz3T8UiWjAns7BKhI4JET
         t8/kw1hZK7kXZ0lMjGyfiybt0pxK/zSb2NbN05cnizN1gnlOE6NaXRz3Yb/3ugk9mlzm
         xPZWFpKYuyyLPdJxm/OaTgJAcRxzY+F0WcrEzKVFAk7Mi0TG64hj6UNL0BQ/tJmx4Pra
         PVfPvE4uuD3Qmb5s/+wprSiQ/0ii7UNw0n/E5yaR7sdZpbOQS8CrVoJX51c/Np4KqFJP
         +/ce4gCVSma6i11S5ncoAe28kOdK2D+mXQ9NAqsQtNWgYOwIPyOnoDSAKN0LBs+gpS2/
         jTag==
X-Received: by 10.43.171.70 with SMTP id nt6mr19924261icc.73.1435969106484;
        Fri, 03 Jul 2015 17:18:26 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id z195sm7246110iod.33.2015.07.03.17.18.25
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Jul 2015 17:18:26 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.197.g417e668
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273316>

This is v2 of the series to replace "git checkout --to" with "git
worktree add". It's built atop Duy's df0b6cf (worktree: new place for
"git prune --worktrees", 2015-06-29) which introduces the git-worktree
command and replaces "git prune --worktrees" with "git worktree prune".

Although v1[*1*] consisted of only 1 patch, v2 is just a wee bit
longer at 23 patches. Sorry for the length. Fortunately, most patches
are quite small, thus (hopefully) easy to review.

v2 goes a bit beyond v1 by implementing Duy's suggestion[*2*] of
allowing <branch> in "git worktree add <path> <branch>" to be omitted,
in which case, as a convenience, it auto-vivifies a new branch named
after <path>, as if it had been invoked as "git worktree add -b
$(basename <path>) <path> HEAD". Moreover, unlike "git checkout -b
<newbranch> --to <path> <branch>", the <branch> in "git worktree add -b
<newbranch> <path> <branch>" is also optional, and defaults to HEAD.

v2 does not attempt either of the suggestions by Junio[*3*] or Duy[*4*]
for eliminating git-checkout from the equation, which would allow us to
remove the final couple bits of code in git-checkout which require
intimate knowledge that the checkout is occurring in a newly created
linked worktree. This series is already too long, and I didn't want it
to grow further by implementing either of those ideas. Instead, this
series leaves git-worktree at a state where one or the other of those
suggestions can be done as follow-on patches touching only the
underlying machinery, without affecting the user-facing interface.

[*1*]: http://thread.gmane.org/gmane.comp.version-control.git/273032
[*2*]: http://thread.gmane.org/gmane.comp.version-control.git/273032/focus=273035
[*3*]: via private email which suggested using "git-reset --hard" rather
       than "git checkout" to populate the new linked worktree.
[*4*]: http://thread.gmane.org/gmane.comp.version-control.git/273032/focus=273226

Eric Sunshine (23):
  Documentation/git-checkout: fix incorrect worktree prune command
  Documentation/git-worktree: associate options with commands
  Documentation: move linked worktree description from checkout to
    worktree
  Documentation/git-worktree: add BUGS section
  Documentation/git-worktree: split technical info from general
    description
  Documentation/git-worktree: add high-level 'lock' overview
  Documentation/git-worktree: add EXAMPLES section
  checkout: fix bug with --to and relative HEAD
  checkout: relocate --to's "no branch specified" check
  checkout: prepare_linked_checkout: drop now-unused 'new' argument
  checkout: make --to unconditionally verbose
  checkout: drop 'checkout_opts' dependency from prepare_linked_checkout
  worktree: introduce "add" command
  worktree: add --force option
  worktree: add --detach option
  worktree: add -b/-B options
  tests: worktree: retrofit "checkout --to" tests for "worktree add"
  checkout: retire --to option
  checkout: require worktree unconditionally
  worktree: extract basename computation to new function
  worktree: add: make -b/-B default to HEAD when <branch> is omitted
  worktree: add: auto-vivify new branch when <branch> is omitted
  checkout: retire --ignore-other-worktrees in favor of --force

 Documentation/git-checkout.txt                    |  78 +--------
 Documentation/git-worktree.txt                    | 141 +++++++++++++++-
 builtin/checkout.c                                | 161 +-----------------
 builtin/worktree.c                                | 193 ++++++++++++++++++++++
 git.c                                             |   2 +-
 t/{t2025-checkout-to.sh => t2025-worktree-add.sh} |  68 +++++---
 t/t2026-prune-linked-checkouts.sh                 |   2 +-
 t/t7410-submodule-checkout-to.sh                  |   4 +-
 8 files changed, 383 insertions(+), 266 deletions(-)
 rename t/{t2025-checkout-to.sh => t2025-worktree-add.sh} (51%)

-- 
2.5.0.rc1.197.g417e668
