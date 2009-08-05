From: Nazri Ramliy <ayiehere@gmail.com>
Subject: [PATCH] RFC - Say goodbye to the rodent
Date: Wed,  5 Aug 2009 17:51:40 +0800
Message-ID: <1249465906-3940-1-git-send-email-ayiehere@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 05 11:58:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYdGC-00060Q-To
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 11:58:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934091AbZHEJ6J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 05:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934076AbZHEJ6I
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 05:58:08 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:58745 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934086AbZHEJ6H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 05:58:07 -0400
Received: by wa-out-1112.google.com with SMTP id j5so710573wah.21
        for <git@vger.kernel.org>; Wed, 05 Aug 2009 02:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer;
        bh=op1n7latUeNiSqkxEdsUyui6xCVktKi+tIxcEJ9J7Eo=;
        b=q5JGGiC4RPIP5u1LdD6QYHoeVJeuVsR0NDB8KkX5wyB/irDeDpHWAL0GpGMv7prgkC
         O9t11JSkHFW8ojz9PYb5o+rISFwu386sI4jiLEZ4FAnYKfnC+ER1IuEEgUHJHGQ/sUkI
         4zdOP+IfUzAaVsxFmA0IOsOxFzpu5PgOxOUk0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        b=sknGSN0KooauBBhHZRlDh/dOtVHWs0g1VkzpMCk27bYRCktOgdFDOBCeZovW9z8B6c
         ALbY5vBO4FGnzSv+ho+enEI4HiGqFJSmC8ZzWzBqfpQ7OD8kHcAxjgBDCe42qY5mPoS7
         rHWC1u4RbrFFAnnIKh/FGFmgbe/zYU/3H56Kc=
Received: by 10.115.55.4 with SMTP id h4mr9199354wak.34.1249465805935;
        Wed, 05 Aug 2009 02:50:05 -0700 (PDT)
Received: from localhost.localdomain ([115.132.128.228])
        by mx.google.com with ESMTPS id k14sm13017099waf.25.2009.08.05.02.50.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 05 Aug 2009 02:50:05 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.13.ge6580
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124892>

Hello list,

Git status provides a list of modified/staged files etc.

Normally I use the mouse to cut and paste the filenames in subsequent git
operations.

Oftentimes I get tired of moving my hand away from the comfort of the home rows
of my keybard in order to grab the mouse to highlight the files that I'd like
to operate on.

This patch is my attempt at scratching this itch.  It is, at best, works fine;
albeit a little bit experimental.  I may have overlooked a dozen things -
variable names, places where I define the variables etc. If people find this useful
I'll look into polishing the code. All seem to work well. Running make test
does not break anything. I have not written test case for them.

The idea is that "git status --id" shows a unique id for each file in its output
(modified/staged/unknown/etc). The ids and the corresponding filenames are
stored in .git/FILE_IDS. This file gets overwritten everytime you run "git
status --id"

Subsequent git operations can be taught to accept the --id command line option
to tell them what files to operate on. They will read the FILE_IDS to find out
which file to operate based on the given id.  In the patch series I have taught
the add, checkout, commit, rm and reset commands the --id option.

Example:

$ git status --id
# On branch local
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#       modified:   builtin-write-tree.c (m1)
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       file1.c (x1)
#       file2.c (x2)


Note the id at the end of the files.

Now we can do the following:

$ git add --id m1

Ids are specified via the --id command line option, and can be separated with
commas if you want to specify more than one of them:

$ git add --id m1,x2

You get the idea ...

What do you guys think about this new approach of "cut-and-paste" from the
command line?

Where would be the best place to put the file id? end? beginning? before ':'?
The argument to --id could be improved so that it understand regexes for file ids.

Comments are welcomed.

Nazri.

-- 

 builtin-add.c      |   19 +++++--
 builtin-checkout.c |   26 ++++++---
 builtin-commit.c   |    4 +-
 builtin-reset.c    |   32 +++++++----
 builtin-rm.c       |   11 ++++-
 cache.h            |    1 +
 path.c             |   44 ++++++++++++++++
 wt-status.c        |  146 ++++++++++++++++++++++++++++++++++++++++++++++++----
 wt-status.h        |    1 +
 9 files changed, 245 insertions(+), 39 deletions(-)
