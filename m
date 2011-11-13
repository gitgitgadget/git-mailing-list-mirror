From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 0/7] New sequencer workflow!
Date: Sun, 13 Nov 2011 16:16:14 +0530
Message-ID: <1321181181-23923-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 13 11:48:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPXbZ-0000NY-T0
	for gcvg-git-2@lo.gmane.org; Sun, 13 Nov 2011 11:48:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751794Ab1KMKsA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Nov 2011 05:48:00 -0500
Received: from mail-pz0-f42.google.com ([209.85.210.42]:50926 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174Ab1KMKr7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Nov 2011 05:47:59 -0500
Received: by pzk36 with SMTP id 36so9315254pzk.1
        for <git@vger.kernel.org>; Sun, 13 Nov 2011 02:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=tMZWlq4t1mz6s2LU0+nSQLWanw9e0QJs+T4mW/v3U/I=;
        b=GH8aGt11Ze6/L8TLYoh5360lfHrEFM6ix9q0rqL7KAo2E/PVd4ejP7awZdvlJWjDG3
         RSpdYP8PbVJjD7iJljDyHX/9pYSFhDQqoqF+HgJyhpOf4zy0N6wt+lMAFSX15geRFQWd
         rRAMCsEvC8V2VWEnRgu9QziqMaHrt2ogFBL54=
Received: by 10.68.25.101 with SMTP id b5mr40039400pbg.24.1321181279094;
        Sun, 13 Nov 2011 02:47:59 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id g8sm28723464pbe.11.2011.11.13.02.47.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 13 Nov 2011 02:47:58 -0800 (PST)
X-Mailer: git-send-email 1.7.6.351.gb35ac.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185330>

Hi,

After days of bending my mind around the backward-compatibility
problem, I'm happy to announce that we finally have an implementation!
This series preserves the old workflow:

  $ git cherry-pick foo
  ... conflict ...
  $ echo "resolved" >problematicfile
  $ git add problematicfile
  $ git commit

  $ git cherry-pick foo..bar
  ... conflict ...
  $ echo "resolved" >problematicfile
  $ git add problematicfile
  $ git commit
  $ git revert --continue # No, there are no typos

And introduces a brand new workflow:

  $ git cherry-pick foo
  ... conflict ...
  $ echo "resolved" >problematicfile
  $ git add problematicfile
  $ git sequencer --continue

  $ git cherry-pick foo..bar
  ... conflict ...
  $ echo "resolved" >problematicfile
  $ git add problematicfile
  $ git sequencer --continue

  $ git revert moo..baz
  ... conflict ...
  $ echo "resolved" >problematicfile
  $ git add problematicfile
  $ git sequencer --continue

In other words, it just doesn't matter how you started what sequencing
operation: you can always continue a it with "git sequencer
--continue" and reset it with "git sequencer --reset".

This series is reasonably well-polished and based on
rr/revert-cherry-pick (since the topic hasn't made it to 'master'
yet).  The only downside is that it's very complicated, and I've tried
my best to explain the motivation for everything in the commit
messages.  Needless to say, it requires a huge amount of testing to
catch unpleasant corner cases.

Part 1 moves a lot of code from builtin/revert.c to sequencer.c.

Parts 2, 3, 4 carefully work around some complex issues related to
'.git/CHERRY_PICK_HEAD'.

Part 5 introduces a new git-sequencer builtin.  Although it's
empty'ish now, I'd argue that adding it now helps think about the
unified interface.  Any suggestions on what concrete function it
should implement?  I'm thinking of something along the lines of
'rebase -i'.

Part 6 is the patch that tells the sequencer "how to continue".  As
more commands grow sequencer functionalities, it will become clear
that committing isn't the only way to continue, but I think it's good
for the moment.

Part 7 is the icing on the cake.  Enjoy.

I'd sent out $gmane/184859 last week as a sanity check: thanks to
Junio and Jonathan for looking at it.  It's always comforting to know
that I haven't lost my head yet :)

If you're looking to get involved before this series hits 'pu', use
the "sequencer" branch of my Git fork on Github:
http://github.com/artagnon/git

Thanks.

-- Ram

Ramkumar Ramachandra (7):
  sequencer: factor code out of revert builtin
  sequencer: invalidate sequencer state without todo
  sequencer: handle single-commit pick as special case
  sequencer: handle cherry-pick conflict in last commit
  sequencer: introduce git-sequencer builtin
  sequencer: teach '--continue' how to commit
  sequencer: teach parser about CHERRY_PICK_HEAD

 .gitignore                                         |    1 +
 Documentation/git-sequencer.txt                    |   33 +
 Makefile                                           |    1 +
 builtin.h                                          |    1 +
 builtin/revert.c                                   |  821 +-------------------
 builtin/sequencer.c                                |   52 ++
 git.c                                              |    1 +
 sequencer.c                                        |  842 +++++++++++++++++++-
 sequencer.h                                        |   26 +
 ...-cherry-pick-sequence.sh => t3510-sequencer.sh} |  140 +---
 ...-sequence.sh => t3511-cherry-pick-sequencer.sh} |  124 +---
 11 files changed, 1002 insertions(+), 1040 deletions(-)
 create mode 100644 Documentation/git-sequencer.txt
 create mode 100644 builtin/sequencer.c
 copy t/{t3510-cherry-pick-sequence.sh => t3510-sequencer.sh} (60%)
 rename t/{t3510-cherry-pick-sequence.sh => t3511-cherry-pick-sequencer.sh} (59%)

-- 
1.7.6.351.gb35ac.dirty
