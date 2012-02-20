From: Johan Herland <johan@herland.net>
Subject: [RFC] pre-rebase: Refuse to rewrite commits that are reachable from
 upstream
Date: Mon, 20 Feb 2012 22:07:51 +0100
Message-ID: <1329772071-11301-1-git-send-email-johan@herland.net>
References: <201202111445.33260.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Johan Herland <johan@herland.net>, gitster@pobox.com,
	jnareb@gmail.com, philipoakley@iee.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 20 23:08:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzbPF-0000iZ-3f
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 23:08:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754592Ab2BTWIU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Feb 2012 17:08:20 -0500
Received: from smtp.getmail.no ([84.208.15.66]:60096 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754577Ab2BTWIU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 17:08:20 -0500
X-Greylist: delayed 3601 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Feb 2012 17:08:20 EST
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LZP00KWZMPSMA10@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Mon, 20 Feb 2012 22:08:16 +0100 (MET)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id A80831EA5638_F42B640B	for <git@vger.kernel.org>; Mon,
 20 Feb 2012 21:08:16 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 839E21EA31EB_F42B640F	for <git@vger.kernel.org>; Mon,
 20 Feb 2012 21:08:16 +0000 (GMT)
Received: from alpha.herland ([84.208.177.71]) by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LZP00JAIMPSU410@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Mon, 20 Feb 2012 22:08:16 +0100 (MET)
X-Mailer: git-send-email 1.7.9.1.314.ga9004
In-reply-to: <201202111445.33260.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191119>

Teach the pre-rebase sample hook to refuse rewriting commits on a branch
that are present in that branch's @{upstream}. This is to prevent users
from rewriting commits that have already been published.

If the branch has no @{upstream}, or the commits-to-be-rebased are not
reachable from the upstream (hence assumed to be unpublished), the rebase
is not refused.

This patch is not an ideal solution to the problem, for at least the
following reasons:

 - There is no way for the user to override this check, except skipping
   the pre-rebase hook entirely with --no-verify.

 - The check only works for branches with a configured upstream. If the
   user's workflow does not rely on upstream branches, or uses some other
   method of publishing commits, the check will produce false negatives
   (i.e. allow rebases that should have been refused).

 - The check only applies to rebase. I wanted to add the same check
   on 'commit --amend', but there's no obvious way to detect --amend
   from within the pre-commit hook.

 - There may be other rewrite scenarios where we want to do this check,
   such as 'git reset'. Maybe a pre-rewrite hook should be added?

 - Some (including myself) want this check to be performed by default,
   since it's mostly targeted at newbies that are less likely to enable
   the pre-rebase (pre-rewrite) hook, so maybe the check should be added
   to core git instead.

Discussed-with: Jakub Narebski <jnareb@gmail.com>
Signed-off-by: Johan Herland <johan@herland.net>
---
 templates/hooks--pre-rebase.sample |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/templates/hooks--pre-rebase.sample b/templates/hooks--pre-rebase.sample
index 053f111..4c28b27 100755
--- a/templates/hooks--pre-rebase.sample
+++ b/templates/hooks--pre-rebase.sample
@@ -25,6 +25,20 @@ else
 	exit 0 ;# we do not interrupt rebasing detached HEAD
 fi
 
+# Are we rewriting upstreamed commits?
+upstream=`git rev-parse --verify "${topic#refs/heads/}@{u}" 2>/dev/null`
+if test -n "$upstream"
+then
+	# See if any of the commits to be rebased are reachable from upstream.
+	basecommit=`git rev-parse --verify "$basebranch"`
+	mergebase=`git merge-base "$basecommit" "$upstream"`
+	if test "$basecommit" != "$upstream" -a "$basecommit" = "$mergebase"
+	then
+		echo >&2 "Cannot rebase commits that are in $topic's upstream"
+		exit 1
+	fi
+fi
+
 case "$topic" in
 refs/heads/??/*)
 	;;
-- 
1.7.9.1.314.ga9004
