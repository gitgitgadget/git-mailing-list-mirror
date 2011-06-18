From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 0/3] git-svn: Handle git root commits in mergeinfo ranges
Date: Sat, 18 Jun 2011 08:47:57 +0200
Message-ID: <1308379680-17188-1-git-send-email-mhagger@alum.mit.edu>
Cc: gitster@pobox.com, bert.wesarg@googlemail.com,
	normalperson@yhbt.net, git@drmicha.warpmail.net,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 18 08:48:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXpKp-0001bc-6N
	for gcvg-git-2@lo.gmane.org; Sat, 18 Jun 2011 08:48:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751653Ab1FRGsf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jun 2011 02:48:35 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:37955 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750760Ab1FRGse (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jun 2011 02:48:34 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BE9EF0.dip.t-dialin.net [84.190.158.240])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p5I6mO8g000405;
	Sat, 18 Jun 2011 08:48:24 +0200
X-Mailer: git-send-email 1.7.5.4
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175964>

The maint version of git-svn fails if there is a svn:mergeinfo range
that includes a commit that has no parent; for example, "/trunk:1-59".
Similar problems have been discussed before [1,2].

The problem in this case is that git-svn tries to obtain the list of
git revisions brought into the branch by this range by running

    git rev-list "$bottom_commit^..$top_commit"

where $bottom_commit is the SHA1 of the git commit corresponding to
the first commit in the mergeinfo range.  But $bottom_commit is a root
commit and does not have a parent.

As noted in [3], the obvious solution,

    git rev-list "$bottom_commit^!" "$top_commit"

, causes breakage in test 5 of t9151-svn-mergeinfo.sh.  The problem is
that it is important to exclude only those commits reachable from the
*first* parent of $bottom_commit, not *all* parents.

Instead, this patch simply uses "git rev-parse" to determine whether
$bottom_commit has any parents at all.  If not, then the following
command is used instead:

    git rev-list "$top_commit"

I don't believe the extra "git rev-parse" invocation to be a
performance problem, but I am not familiar enough with the code to be
certain.

Michael

[1] http://thread.gmane.org/gmane.comp.version-control.git/146255
[2] http://thread.gmane.org/gmane.comp.version-control.git/171248
[3] http://article.gmane.org/gmane.comp.version-control.git/150416

Michael Haggerty (3):
  git-svn: Demonstrate a bug with root commits in mergeinfo ranges
  git-svn: Disambiguate rev-list arguments to improve error message
  git-svn: Correctly handle root commits in mergeinfo ranges

 git-svn.perl                           |   11 ++++++---
 t/t9159-git-svn-no-parent-mergeinfo.sh |   33 ++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 4 deletions(-)
 create mode 100755 t/t9159-git-svn-no-parent-mergeinfo.sh

-- 
1.7.5.4
