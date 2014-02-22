From: Thomas Rast <tr@thomasrast.ch>
Subject: [PATCH v2 0/8] log --remerge-diff
Date: Sat, 22 Feb 2014 10:17:48 +0100
Message-ID: <cover.1393059605.git.tr@thomasrast.ch>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 22 10:18:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WH8iq-0003Ns-V9
	for gcvg-git-2@plane.gmane.org; Sat, 22 Feb 2014 10:18:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751640AbaBVJSH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Feb 2014 04:18:07 -0500
Received: from ip1.thgersdorf.net ([148.251.9.194]:34823 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751009AbaBVJSB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Feb 2014 04:18:01 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 6A3BC4D6593;
	Sat, 22 Feb 2014 10:17:59 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id f2v2HGP0Hp22; Sat, 22 Feb 2014 10:17:58 +0100 (CET)
Received: from linux.local (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id E78A44D64BD;
	Sat, 22 Feb 2014 10:17:57 +0100 (CET)
X-Mailer: git-send-email 1.9.0.313.g3d0a325
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242514>

This is the second iteration of

  http://thread.gmane.org/gmane.comp.version-control.git/241565

Changes since the last version:

* Dropped patches 4 and 5 (log --merge-bases)

* Implemented the "full-file conflict" scheme explained in the
  previous cover letter: if the conflicted version is lacking one
  stage of a file, it synthesizes a conflict file of the form

    <<<<<<<
    =======
    content of the stage that exists
    >>>>>>>

  (or the other way around if stage3 is missing).  This occurs at
  least with delete/modify conflicts.

* Implemented some basic handling of directory/file conflicts.  I'm
  not completely happy yet -- see the NEEDSWORK comments -- but at
  least it gives consistent input to the diffing stage.

  This required access to the dir hash, so there's a new patch 7 that
  makes this possible.

Patches 1-6 (used to be 1-3 and 6-8) are unchanged.


Thomas Rast (8):
  merge-recursive: remove dead conditional in update_stages()
  merge-recursive: internal flag to avoid touching the worktree
  merge-recursive: -Xindex-only to leave worktree unchanged
  combine-diff: do not pass revs->dense_combined_merges redundantly
  Fold all merge diff variants into an enum
  merge-recursive: allow storing conflict hunks in index
  name-hash: allow dir hashing even when !ignore_case
  log --remerge-diff: show what the conflict resolution changed

 Documentation/merge-strategies.txt |   9 ++
 Documentation/rev-list-options.txt |   7 +
 builtin/diff-files.c               |   5 +-
 builtin/diff-tree.c                |   2 +-
 builtin/diff.c                     |  12 +-
 builtin/fmt-merge-msg.c            |   2 +-
 builtin/log.c                      |   9 +-
 builtin/merge.c                    |   1 -
 cache.h                            |   2 +
 combine-diff.c                     |  13 +-
 diff-lib.c                         |  13 +-
 diff.h                             |   6 +-
 log-tree.c                         | 304 ++++++++++++++++++++++++++++++++++++-
 merge-recursive.c                  |  52 ++++---
 merge-recursive.h                  |   3 +
 name-hash.c                        |  19 ++-
 revision.c                         |  15 +-
 revision.h                         |  24 ++-
 submodule.c                        |   3 +-
 t/t3030-merge-recursive.sh         |  33 ++++
 t/t4213-log-remerge-diff.sh        | 222 +++++++++++++++++++++++++++
 21 files changed, 678 insertions(+), 78 deletions(-)
 create mode 100755 t/t4213-log-remerge-diff.sh

-- 
1.9.0.313.g3d0a325
