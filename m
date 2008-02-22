From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 4/4] git-stash: add new 'drop' subcommand
Date: Fri, 22 Feb 2008 13:04:54 -0600
Message-ID: <47BF1CD6.70500@nrlssc.navy.mil>
References: <47BF18DF.6050100@nrlssc.navy.mil> <1203706541-21719-1-git-send-email-casey@nrlssc.navy.mil> <1203706541-21719-2-git-send-email-casey@nrlssc.navy.mil> <1203706541-21719-3-git-send-email-casey@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 22 20:08:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSdE7-0002mJ-4r
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 20:06:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757090AbYBVTFx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 14:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757049AbYBVTFw
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 14:05:52 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:43898 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753602AbYBVTFu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 14:05:50 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m1MJ4s2h027494;
	Fri, 22 Feb 2008 13:04:54 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 22 Feb 2008 13:04:53 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <1203706541-21719-3-git-send-email-casey@nrlssc.navy.mil>
X-OriginalArrivalTime: 22 Feb 2008 19:04:53.0848 (UTC) FILETIME=[CEAB1D80:01C87585]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15736001
X-TM-AS-Result: : Yes--6.696800-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNjQzLTcwNzM5NS03MDM3?=
	=?us-ascii?B?MjAtNzEwOTg5LTcwMDE2MC03MDQ0MTAtMTg4MDE5LTcwMzQ1NC0x?=
	=?us-ascii?B?MDY0NzAtNzAwNDc2LTcwNDU2OC0xMDY0MjAtNzAzNzQwLTcwMzc4?=
	=?us-ascii?B?OC03MDE5MzctNzEwOTcwLTcwMjAzOC03MDA5NzAtNzA3NzUwLTcw?=
	=?us-ascii?B?MDM3My03MDAzMjQtNzA1MDY5LTcwNDg1Mi03MDc0NTEtNzAzNzEy?=
	=?us-ascii?B?LTE0ODAzOS0xNDgwNTE=?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74750>

This allows a single stash entry to be deleted. It takes an
optional argument which is a stash reflog entry. If no
arguments are supplied, it drops the most recent stash entry.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 Documentation/git-stash.txt |    7 ++++++-
 git-stash.sh                |   25 ++++++++++++++++++++++++-
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 48e6f5a..f50c24c 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -8,7 +8,7 @@ git-stash - Stash the changes in a dirty working directory away
 SYNOPSIS
 --------
 [verse]
-'git-stash' (list | show [<stash>] | apply [<stash>] | clear)
+'git-stash' (list | show [<stash>] | apply [<stash>] | clear | drop [<stash>])
 'git-stash' [save [<message>]]
 
 DESCRIPTION
@@ -85,6 +85,11 @@ clear::
 	Remove all the stashed states. Note that those states will then
 	be subject to pruning, and may be difficult or impossible to recover.
 
+drop [<stash>]::
+
+	Remove a single stashed state from the stash list. When no `<stash>`
+	is given, it removes the latest one. i.e. `stash@\{0}`
+
 
 DISCUSSION
 ----------
diff --git a/git-stash.sh b/git-stash.sh
index b00f888..caa0258 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 # Copyright (c) 2007, Nanako Shiraishi
 
-USAGE='[  | save | list | show | apply | clear | create ]'
+USAGE='[  | save | list | show | apply | clear | drop | create ]'
 
 SUBDIRECTORY_OK=Yes
 OPTIONS_SPEC=
@@ -196,6 +196,25 @@ apply_stash () {
 	fi
 }
 
+drop_stash () {
+	have_stash || die 'No stash entries to drop'
+
+	test $# = 0 && set -- "$ref_stash@{0}"
+
+	# Verify supplied argument looks like a stash entry
+	s=$(git rev-parse --revs-only --no-flags "$@") &&
+	git rev-parse --verify "$s:"   > /dev/null 2>&1 &&
+	git rev-parse --verify "$s^1:" > /dev/null 2>&1 &&
+	git rev-parse --verify "$s^2:" > /dev/null 2>&1 ||
+		die "$*: not a valid stashed state"
+
+	git reflog delete --updateref --rewrite "$@" &&
+		echo "Dropped $* ($s)" || die "$*: Could not drop stash entry"
+
+	# clear_stash if we just dropped the last stash entry
+	git rev-parse --verify "$ref_stash@{0}" > /dev/null 2>&1 || clear_stash
+}
+
 # Main command set
 case "$1" in
 list)
@@ -230,6 +249,10 @@ create)
 	fi
 	create_stash "$*" && echo "$w_commit"
 	;;
+drop)
+	shift
+	drop_stash "$@"
+	;;
 *)
 	if test $# -eq 0
 	then
-- 
1.5.4.2.267.g38ea
