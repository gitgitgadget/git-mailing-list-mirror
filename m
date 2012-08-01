From: Chris Webb <chris@arachsys.com>
Subject: Cherry-picking commits with empty messages
Date: Wed, 1 Aug 2012 12:16:59 +0100
Message-ID: <20120801111658.GA21272@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 01 13:17:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwWvx-0008Tg-GQ
	for gcvg-git-2@plane.gmane.org; Wed, 01 Aug 2012 13:17:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751944Ab2HALRB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Aug 2012 07:17:01 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:51642 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930Ab2HALRA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2012 07:17:00 -0400
Received: from [81.2.114.212] (helo=arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.72)
	(envelope-from <chris@arachsys.com>)
	id 1SwWvD-0001XR-NM
	for git@vger.kernel.org; Wed, 01 Aug 2012 12:17:00 +0100
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202710>

Whilst doing some extra sanity checking of my git-rebase--interactive.sh
patch yesterday, I came across a behaviour which has been present for some
time, but seems surprising. You can reproduce with

  $ git init -q foo && cd foo
  $ touch one && git add one && git commit -q -m one
  $ touch two && git add two && git commit -q -m two
  $ touch three && git add three && git commit -q -m '' --allow-empty-message
  $ touch four && git add four && git commit -q -m '' --allow-empty-message
  $ git rebase -i HEAD~3 # and swap the two commits with empty messages
  Aborting commit due to empty commit message.
  Could not apply 59a8fde... 

This happens on my ancient laptop which is apparently running 1.7.8.3, as well
as current master, so is unconnected to recent changes.

The reason is that git cherry-pick won't pick a commit with an empty commit
message, even when that message is unmodified from the original:

  $ git rebase --abort
  $ git checkout -q HEAD~2
  $ git cherry-pick 59a8fde
  Aborting commit due to empty commit message.

I can see that this check could make sense when the message has been
modified, but it seems strange when it hasn't, and isn't ideal behaviour
when called from rebase -i. (We otherwise make sure we call git commit with
--allow-empty-message to avoid problems with reordering or editing empty
commits.)

I could just remove the check in the 'message unmodified' case with
something like

diff --git a/sequencer.c b/sequencer.c
index bf078f2..cf8bc05 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -306,6 +306,7 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 	if (!opts->edit) {
 		argv_array_push(&array, "-F");
 		argv_array_push(&array, defmsg);
+		argv_array_push(&array, "--allow-empty-message");
 	}
 
 	if (allow_empty)

but perhaps there are other users of the sequencer for whom this check is
desirable? If so, would an --allow-empty-message to git cherry-pick be a
better plan, which git rebase -i can use where appropriate?

Best wishes,

Chris.
