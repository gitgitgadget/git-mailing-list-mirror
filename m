From: Elijah Newren <newren@gmail.com>
Subject: [RFC/PATCH 00/18] Add --index-only option to git merge
Date: Thu,  7 Apr 2016 23:58:28 -0700
Message-ID: <1460098726-5958-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 08 08:59:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoQO5-0002VL-Qo
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 08:59:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932603AbcDHG7B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 02:59:01 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34737 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932507AbcDHG67 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 02:58:59 -0400
Received: by mail-pf0-f196.google.com with SMTP id d184so8833728pfc.1
        for <git@vger.kernel.org>; Thu, 07 Apr 2016 23:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=aRCookQ4SJPaoI5NWEaYU4pjhp3X67W/0RLWDF0BYDc=;
        b=eHy9cbGTVZYQtySmq7WVSpcrlDJUQNxLv40ZXqc3NPjh3ZF4MUhnDL3xeGBMtMJvKN
         QgTQMk2Mjt+9sXfqNn2dkMzI4N/I2Lm7cokbMwoEmNH/GaL8Lk/xT7rQabVs51WVRGZf
         QPhxFekfBQVhtQHKNt25UlAoe32acdoNgwgMX0SM2SbMBdulZ3pTxzlnkefnVEOFB5c5
         SYKSjEjiD/ruoDV0NQeBzJMkHJ5atbviMIsHdVUk2huowtlkZZxu+aZqiHWinX+kF2G4
         D8hE4SzQsx84wwQYdP/fKsGcZU0v+xYwsw+Clyax2GFkFd9tSOIEZrwoipFE95JWA6u/
         hGwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aRCookQ4SJPaoI5NWEaYU4pjhp3X67W/0RLWDF0BYDc=;
        b=GO47Ut08MwNAepZd8wFZ3FywO8XXCQjzUXwLnyR/l0ZX4e6zAV2hvQaMyC1Qwmlzbu
         dpxw1D0cF3uScKU/VuoYOna92HVDptOK00xA/c9yzWCb1sp/Z10l5QguQj/jgpLkhYz7
         hpnYu8mCu+TeTL8Olsrsw7iefm0lDw+K+1n+8+G0SYHvw5t6myAv+OiVWPCcI+kn08qI
         OFY3f+sTGjpXTq4a70WlOn5G4U24D30DtW0Wk9KZPucqkDCnQQGMIwusSTzqcaYPWj4m
         20bUZLpzansRxl/F96uEcL98amfqcR0B4KPvep5ZEtcnng+7fjWJGxukH2TlM9ukpf6U
         BSWw==
X-Gm-Message-State: AD7BkJI5anSt7GQKsCdLZh35n6nswBDBkphlXxXubjxpOL3YXnUQ7fRfaKozz1O18BqnSA==
X-Received: by 10.98.11.78 with SMTP id t75mr10414614pfi.72.1460098738156;
        Thu, 07 Apr 2016 23:58:58 -0700 (PDT)
Received: from unknownB8F6B118D3EB.attlocal.net ([2602:30a:2c28:20f0:baf6:b1ff:fe18:d3eb])
        by smtp.gmail.com with ESMTPSA id w62sm16371973pfa.79.2016.04.07.23.58.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Apr 2016 23:58:57 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.18.gc685494
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291007>

This patch series adds an --index-only flag to git merge, the idea
being to allow a merge to be performed entirely in the index without
touching (or even needing) a working tree.

The core fix, to merge-recursive, was actually quite easy.  The
recursive merge logic already had the ability to ignore the working
directory and operate entirely on the index -- it needed to do this
when creating a virtual merge base, i.e. when o->call_depth > 0.  It's
just that o->call_depth was also used for other purposes, so I just
needed to introduce a new flag to disambiguate and switch all the
necessary index-only-related call sites to use it.  It actually seems
to make the code slightly easier to read too, which is a nice bonus.
That was all done in patch 12 of this series.

Adding all the necessary testcases and switching over the other merge
strategies turned out to be the harder part...and still has a problem,
as I'll mention below.


A brief-ish summary of the series:

* Patches 1 and 2 are unrelated cleanups, which could be submitted
  independently.  However, submitting them as separate patches would
  result in a minor conflict, so I'm just including them together.

* Patches 3 and 4 add some testcases and a fix for a separate issue
  found while testing this series which could be split off and
  submitted separately, but fixing this problem and enforcing the
  starting state I expected permitted me to reduce the range of
  testcases I needed to consider for the --index-only merges.  So I
  thought it made sense to include in this series.

  In particular, I was worried about how git merge behaved when the
  index differed from HEAD prior to the merge starting.  I discovered
  that it wasn't just allowed for fast-forward merges (where behavior
  is well-defined) but that it was also (accidentally I'm assuming)
  allowed for octopus merges with weird/surprising behavior.

* Patches 5-10 add testcases for the --index-only option for each of
  the merge strategies/cases: recursive, fast-forward update, resolve,
  octopus, ours, subtree.

* Patch 11 adds the --index-only option to the code and adds the
  documentation, while patches 12-18 implement the --index-only option
  for each of the strategies/cases.


Some things I am concerned about:

* The option name (--index-only) may be slightly misleading since the
  index isn't the only thing modified within the git directory, other
  normal things under there are still modified (e.g. writing MERGE_*
  files, sticking blobs/trees/commits in objects/*, and updating refs
  and reflogs).  I personally prefer this name and think the confusion
  would be minor, but I'm a bit unsure and wanted some other opinions
  on this.

* I didn't add this option to the separate git-merge-recursive
  executable and make the worktree-optional modification to the git
  subcommands merge-recursive, merge-recursive-ours,
  merge-recursive-theirs, and merge-subtree in git.c.  Should I, or
  are these separate binaries and subcommands just present for
  historical backward compatibility reasons with people expected to
  call e.g. "git merge -s recursive" these days?

* The addition of --index-only to the various git-merge*.sh scripts is
  lacking in flexibility (e.g. has to be passed as the first
  argument).  These scripts seemed to have fairly rigid calling
  conventions already, suggesting there's not much value in making
  them flexible, but perhaps that was the wrong conclusion to draw.

* Expanding on the last item, git-merge-one-file.sh is of particular
  concern; it seemed to strongly assume exactly seven arguments and
  that the position of each mattered.  I didn't want to break that, so
  I added --index-only as an optional 8th argument, even though it
  seems slightly odd force an option argument to always come after
  positional ones (and it made the changes to merge_entry in
  merge-index.c slightly easier to implement).  Does that seem okay?

* For a long time I had two remaining bugs, one of which was in
  checkout_fast_forward.  I was feeling kind of sheepish about that,
  because how much simpler could it be than handling a fast-forward
  merge (with possible uncommited index entries to carry forward)?
  Getting stuck on a simple case like that would be embarrassing.
  Luckily, I figured out that bug.  So, that leaves just one case left
  that I can't seem to figure out: read_tree_trivial.  So much better,
  right?  Even it's name is sitting there, mocking me.  "Ha ha, I'm
  read_tree_*trivial* and you can't figure me out."  read_tree_trivial
  is a jerk.


Elijah Newren (18):
  Remove duplicate code
  Avoid checking working copy when creating a virtual merge base
  Document weird bug in octopus merges via testcases
  merge-octopus: Abort if index not clean
  Add testcase for --index-only merges needing the recursive strategy
  Add testcase for --index-only merges needing an ff update
  Add testcase for --index-only merges with the resolve strategy
  Add testcase for --index-only merges with the octopus strategy
  Add testcase for --index-only merges with the ours strategy
  Add testcase for --index-only merges with the subtree strategy
  merge: Add a new --index-only option, not yet implemented
  Add --index-only support for recursive merges
  Add --index-only support with read_tree_trivial merges, kind of
  Add --index-only support for ff_only merges
  merge: Pass --index-only along to external merge strategy programs
  git-merge-one-file.sh: support --index-only option
  git-merge-resolve.sh: support --index-only option
  git-merge-octopus.sh: support --index-only option

 Documentation/git-merge.txt              |  14 +
 builtin/merge-index.c                    |   9 +-
 builtin/merge.c                          |  13 +-
 builtin/pull.c                           |   4 +-
 cache.h                                  |   3 +-
 git-merge-octopus.sh                     |  19 +-
 git-merge-one-file.sh                    |  44 ++-
 git-merge-resolve.sh                     |  12 +-
 git.c                                    |   2 +-
 merge-recursive.c                        |  40 +--
 merge-recursive.h                        |   1 +
 merge.c                                  |   8 +-
 sequencer.c                              |   4 +-
 t/t6043-merge-index-only.sh              | 443 +++++++++++++++++++++++++++++++
 t/t6044-merge-unrelated-index-changes.sh | 156 +++++++++++
 15 files changed, 730 insertions(+), 42 deletions(-)
 create mode 100755 t/t6043-merge-index-only.sh
 create mode 100755 t/t6044-merge-unrelated-index-changes.sh

-- 
2.8.0.18.gc685494
