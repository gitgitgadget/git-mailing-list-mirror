From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] git-stash: add new 'pop' subcommand
Date: Fri, 22 Feb 2008 16:52:50 -0600
Message-ID: <47BF5242.6090906@nrlssc.navy.mil>
References: <47BF1CD6.70500@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 22 23:53:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSgmD-0004cO-LF
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 23:53:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758552AbYBVWxN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 17:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758078AbYBVWxN
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 17:53:13 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:41510 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758026AbYBVWxL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 17:53:11 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m1MMqp3n031463;
	Fri, 22 Feb 2008 16:52:51 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 22 Feb 2008 16:52:50 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <47BF1CD6.70500@nrlssc.navy.mil>
X-OriginalArrivalTime: 22 Feb 2008 22:52:50.0872 (UTC) FILETIME=[A6CF5B80:01C875A5]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15736001
X-TM-AS-Result: : Yes--10.838400-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNjQzLTEwNTA0MC03MDUw?=
	=?us-ascii?B?NjktNzAwMTYwLTEwNTcwMC03MDI1NjgtNzA0NDEwLTE4ODAxOS03?=
	=?us-ascii?B?MDM0NTQtMTA2NDcwLTcwMDQ3Ni03MDQ1NjgtMTA2NDIwLTcwMzc4?=
	=?us-ascii?B?OC03MDE5MzctNzAyNjM4LTcwNDcxMi03MTA5NzAtNzAyMDM4LTcw?=
	=?us-ascii?B?MDk3MC0xNDgwMzktMTQ4MDUx?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74766>

This combines the existing stash subcommands 'apply' and 'drop' to
allow a single stash entry to be applied and then dropped, in other
words 'popped', from the stash list.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


For completeness, here is stash pop.

-brandon


 Documentation/git-stash.txt |    8 +++++++-
 git-stash.sh                |   10 +++++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index f50c24c..8dc35d4 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -8,7 +8,7 @@ git-stash - Stash the changes in a dirty working directory away
 SYNOPSIS
 --------
 [verse]
-'git-stash' (list | show [<stash>] | apply [<stash>] | clear | drop [<stash>])
+'git-stash' (list | show [<stash>] | apply [<stash>] | clear | drop [<stash>] | pop [<stash>])
 'git-stash' [save [<message>]]
 
 DESCRIPTION
@@ -90,6 +90,12 @@ drop [<stash>]::
 	Remove a single stashed state from the stash list. When no `<stash>`
 	is given, it removes the latest one. i.e. `stash@\{0}`
 
+pop [<stash>]::
+
+	Remove a single stashed state from the stash list and apply on top
+	of the current working tree state. When no `<stash>` is given,
+	`stash@\{0}` is assumed. See also `apply`.
+
 
 DISCUSSION
 ----------
diff --git a/git-stash.sh b/git-stash.sh
index caa0258..297d12d 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 # Copyright (c) 2007, Nanako Shiraishi
 
-USAGE='[  | save | list | show | apply | clear | drop | create ]'
+USAGE='[  | save | list | show | apply | clear | drop | pop | create ]'
 
 SUBDIRECTORY_OK=Yes
 OPTIONS_SPEC=
@@ -253,6 +253,14 @@ drop)
 	shift
 	drop_stash "$@"
 	;;
+pop)
+	shift
+	if apply_stash "$@"
+	then
+		test -z "$unstash_index" || shift
+		drop_stash "$@"
+	fi
+	;;
 *)
 	if test $# -eq 0
 	then
-- 
1.5.4.2.267.g38ea.dirty
