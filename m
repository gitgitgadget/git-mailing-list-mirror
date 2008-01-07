From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] git-stash: add new 'drop' subcommand
Date: Mon, 07 Jan 2008 11:12:21 -0600
Message-ID: <47825D75.2020105@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 07 18:14:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBvY7-0007ww-G2
	for gcvg-git-2@gmane.org; Mon, 07 Jan 2008 18:14:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755369AbYAGRNk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2008 12:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754814AbYAGRNk
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 12:13:40 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:54773 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753858AbYAGRNj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2008 12:13:39 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m07HCM3U028191;
	Mon, 7 Jan 2008 11:12:22 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 7 Jan 2008 11:12:22 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
References: loom.20080105T053356-853@post.gmane.org
X-OriginalArrivalTime: 07 Jan 2008 17:12:22.0153 (UTC) FILETIME=[7757B790:01C85150]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15652001
X-TM-AS-Result: : Yes--7.345700-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNjQzLTcwNzM5NS03MDM3?=
	=?us-ascii?B?MjAtNzEwOTg5LTcwMDE2MC03MDI2MzgtNzEwOTcwLTcwMzI2Ny03?=
	=?us-ascii?B?MDQ0MTAtMTg4MDE5LTcwMzQ1NC0xMDY0NzAtNzAwNDc2LTcwNDU2?=
	=?us-ascii?B?OC0xMDY0MjAtNzAzNzQwLTcwMzc4OC03MDE5MzctNzAyMDM4LTcw?=
	=?us-ascii?B?MDk3MC03MDc3NTAtNzAwMzczLTcwMDMyNC03MDUwNjktNzA0ODUy?=
	=?us-ascii?B?LTcwNzQ1MS03MDM3MTItMTQ4MDM5LTE0ODA1MQ==?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69796>

This allows a single stash entry to be deleted. It takes an
optional argument which is a stash reflog entry. If no
arguments are supplied, it drops the most recent stash entry.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


This implements the suggested changes on top of latest next.
We can leave the discussion of naming and any other issues
until after 1.5.4 so not to cause a distraction unless
people feel otherwise.

-brandon


 Documentation/git-stash.txt |    7 ++++++-
 git-stash.sh                |   25 ++++++++++++++++++++++++-
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 9889806..7afc8d3 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -8,7 +8,7 @@ git-stash - Stash the changes in a dirty working directory away
 SYNOPSIS
 --------
 [verse]
-'git-stash' (list | show [<stash>] | apply [<stash>] | clear)
+'git-stash' (list | show [<stash>] | apply [<stash>] | clear | drop [<stash>])
 'git-stash' [save] [message...]
 
 DESCRIPTION
@@ -81,6 +81,11 @@ clear::
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
index b00f888..d6d77fa 100755
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
+	git reflog delete "$@" && echo "Dropped $* ($s)" ||
+		die "$*: Could not drop stash entry"
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
1.5.3.6
