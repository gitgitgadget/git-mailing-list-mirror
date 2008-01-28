From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] filter-branch.sh: remove temporary directory on failure
Date: Mon, 28 Jan 2008 15:16:02 -0600
Message-ID: <479E4612.6030006@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 22:17:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJbLv-0005QF-LJ
	for gcvg-git-2@gmane.org; Mon, 28 Jan 2008 22:17:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752549AbYA1VQm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 16:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752633AbYA1VQm
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 16:16:42 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:47402 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690AbYA1VQl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 16:16:41 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m0SLG3RJ015860;
	Mon, 28 Jan 2008 15:16:03 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 28 Jan 2008 15:16:03 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
X-OriginalArrivalTime: 28 Jan 2008 21:16:03.0018 (UTC) FILETIME=[FCBB6AA0:01C861F2]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15694001
X-TM-AS-Result: : Yes--9.938600-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNjQzLTcwMDE2MC0xMzk1?=
	=?us-ascii?B?MDQtMTA2NDIwLTEzNjA3MC03MDA4NDktNzAzODAyLTcwMzc4OC03?=
	=?us-ascii?B?MDE0NTUtNzAzNzQ3LTcwMzA5Ni03MDA3NTYtNzAzNzEyLTcwMjcz?=
	=?us-ascii?B?Ny03MDc0NTEtMTIxNTM0LTcwMDQ3Ni0xMDYyMzAtNzAyMDUwLTcw?=
	=?us-ascii?B?ODE3OS0xMjEyNzAtNzA0NzE0LTcwMTI0OS03MDIwNDQtNzA3ODAw?=
	=?us-ascii?B?LTcwNzY1NC03MDc3NTAtMTg4MTIxLTE4ODAxOS0xMjE2MjQtNzA1?=
	=?us-ascii?B?Mzg4LTcwMDk3MS03MDA5NzAtNzA5ODU5LTE0ODAzOS0xNDgwNTE=?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71901>

From: Brandon Casey <casey@nrlssc.navy.mil>

One of the first things filter-branch does is to create a temporary
directory. This directory is eventually removed by the script during
normal operation, but is not removed if the script encounters an error.

Set a trap to remove it when the script terminates for any reason.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


Even though this directory may be useful for debugging when you encounter
a problem, I wonder if the normal "error" will be _user_ error. In which
case the user will adjust the command line parameters and try to rerun.
Currently the user would then receive the message

     "$tempdir already exists, please remove it"

Then, rm -rf the tempdir, then rerun.

Is this necessary? Maybe anyone with the know-how to debug would also have the
know-how to comment out the 'trap' in the script (or direct someone asking for
help on the mailing list to do so).

If we really want to leave this temporary directory around on failure, maybe
we can at least remove it for some simple errors like:

    line 198: die "Namespace $orig_namespace not empty"
    line 217: die "Which ref do you want to rewrite?"
    etc.

by moving the 'trap - 0' higher up.

-brandon


 git-filter-branch.sh |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index ebf05ca..75970a9 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -189,6 +189,9 @@ cd "$tempdir/t" &&
 workdir="$(pwd)" ||
 die ""
 
+# Remove tempdir on exit
+trap 'cd ../..; rm -rf "$tempdir"' 0
+
 # Make sure refs/original is empty
 git for-each-ref > "$tempdir"/backup-refs
 while read sha1 type name
@@ -406,6 +409,8 @@ fi
 cd ../..
 rm -rf "$tempdir"
 
+trap - 0
+
 unset GIT_DIR GIT_WORK_TREE GIT_INDEX_FILE
 test -z "$ORIG_GIT_DIR" || GIT_DIR="$ORIG_GIT_DIR" && export GIT_DIR
 test -z "$ORIG_GIT_WORK_TREE" || GIT_WORK_TREE="$ORIG_GIT_WORK_TREE" &&
-- 
1.5.4.rc5.2.g9a6d-dirty
