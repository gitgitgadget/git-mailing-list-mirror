From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] filter-branch: assume HEAD if no revision supplied
Date: Wed, 30 Jan 2008 13:33:04 -0600
Message-ID: <47A0D0F0.1020800@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 30 20:35:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKIi4-0000Dm-Ol
	for gcvg-git-2@gmane.org; Wed, 30 Jan 2008 20:35:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755015AbYA3TeS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2008 14:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753098AbYA3TeS
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jan 2008 14:34:18 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:34133 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754832AbYA3TeR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2008 14:34:17 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m0UJX5YW008960;
	Wed, 30 Jan 2008 13:33:05 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 30 Jan 2008 13:33:05 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
X-OriginalArrivalTime: 30 Jan 2008 19:33:05.0017 (UTC) FILETIME=[EF2EC690:01C86376]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15694001
X-TM-AS-Result: : Yes--9.019700-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNjQzLTcwMjExMy03MDUx?=
	=?us-ascii?B?MDItNzA0NDI1LTcwNzM5NS03MDIwMzctNzA0NzEyLTcwMjE0My03?=
	=?us-ascii?B?MDI2MDktNzA2NTYxLTcwMDE2MC03MDE0NTUtNzEwNDQyLTcwMDc1?=
	=?us-ascii?B?Ni03MDEyMDItMTA2NDIwLTcwNDQxMC03MDM3MjAtNzAwOTcwLTcw?=
	=?us-ascii?B?NzgwMC0xMDUwNDAtNzAyNzkxLTcwMDQ3Ni03MDc3NTAtNzAyMDQ0?=
	=?us-ascii?B?LTcwMDc4Mi03MDAzMDAtMTg4MDE5LTcwMzcxMi03MDUzODgtNzA5?=
	=?us-ascii?B?ODU5LTcxMDIyNC03MDA3MDEtMTQ4MDM5LTE0ODA1MQ==?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72061>

filter-branch previously took the first non-option argument as the name for
a new branch. Since dfd05e38, it now takes a revision or a revision range
and modifies the current branch. Update to operate on HEAD by default to
conform with standard git interface practice.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


You may think that filter-branch _should_ require the user to specify the
revision. If so, then '--default HEAD' should probably be removed from the
other two places, and the usage and documentation should be updated to
remove the brackets around <rev-list options> so not to imply that it is
optional. The test for at least one non-option argument can still be
removed since it can currently be circumvented by placing -- as the
last argument and because it would allow format-patch to fail with
a much nicer message: "Which ref do you want to rewrite?".

fwiw the behavior this patch implements is what I expected.

-brandon


 git-filter-branch.sh |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index ebf05ca..cd1eeee 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -114,7 +114,6 @@ orig_namespace=refs/original/
 force=
 while :
 do
-	test $# = 0 && usage
 	case "$1" in
 	--)
 		shift
@@ -210,7 +209,7 @@ GIT_WORK_TREE=.
 export GIT_DIR GIT_WORK_TREE
 
 # The refs should be updated if their heads were rewritten
-git rev-parse --no-flags --revs-only --symbolic-full-name "$@" |
+git rev-parse --no-flags --revs-only --symbolic-full-name --default HEAD "$@" |
 sed -e '/^^/d' >"$tempdir"/heads
 
 test -s "$tempdir"/heads ||
-- 
1.5.4.rc5.14.gaa8fc
