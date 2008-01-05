From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] git-stash: add new 'drop' subcommand
Date: Fri, 04 Jan 2008 19:31:00 -0600
Message-ID: <477EDDD4.5060509@nrlssc.navy.mil>
References: <1199495198-26270-1-git-send-email-casey@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 02:31:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAxt0-0003mS-J0
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 02:31:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754303AbYAEBbJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 20:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754356AbYAEBbI
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 20:31:08 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:50197 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754143AbYAEBbH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 20:31:07 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m051V1NC002823;
	Fri, 4 Jan 2008 19:31:01 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 4 Jan 2008 19:31:01 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <1199495198-26270-1-git-send-email-casey@nrlssc.navy.mil>
X-OriginalArrivalTime: 05 Jan 2008 01:31:01.0190 (UTC) FILETIME=[A13D3660:01C84F3A]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15638001
X-TM-AS-Result: : Yes--2.840600-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNjQzLTcwNzM5NS03MDM3?=
	=?us-ascii?B?MjAtNzEwOTg5LTcwMDE2MC03MDMzNzEtNzAxNTEzLTcwMTYxOC03?=
	=?us-ascii?B?MDA3NTYtNzAyMzU4LTcwMzQ1NC03MDM3MTItNzA5NTg0LTcxMDIw?=
	=?us-ascii?B?Ny03MDIwNDQtMTA2NDIwLTcwMjc2Mi03MDc0NTEtNzAwNDQ1LTcw?=
	=?us-ascii?B?Njg5MS03MDIxMzQtNzA5MjUxLTcwODc5Ny03MDQ0MTAtMTg4MDE5?=
	=?us-ascii?B?LTEwNjQ3MC03MDA0NzYtNzA0NTY4LTcwMzc0MC03MDM3ODgtNzAx?=
	=?us-ascii?B?OTM3LTcxMDk3MC03MDIwMzgtNzAwMzczLTcwMjYwOS03MDc3NTAt?=
	=?us-ascii?B?NzAwMzI0LTcwNTA2OS03MDQ4NTItNzAwOTcwLTE0ODAzOS0xNDgw?=
	=?us-ascii?B?NTE=?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69627>

This allows a single stash entry to be deleted. It takes an
optional argument which is a stash reflog entry. If no
arguments are supplied, stash@{0} is used.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


Thus far I haven't been a big user of git stash, but I plan to
use it more and I expect to use 'drop' more often than
'clear'. I expect in the common case there will be a single
stash, and 'drop' will be sufficient. For the case where there
are many stashes and I want to remove one, 'drop' is required.
'git stash clear' will become a command that I give special
attention to just like 'rm -f *'.

I'm not sure if there is a proper way to get 'stash@{0}' from
'refs/stash' so I kept my usage of that former string outside
of the drop_stash() function.

Comments welcome, especially if there is a more appropriate
way to do this.

-brandon


 Documentation/git-stash.txt |    7 ++++++-
 git-stash.sh                |   29 ++++++++++++++++++++++++++++-
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index c0147b9..b89eadb 100644
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
index 06cb177..a789a53 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 # Copyright (c) 2007, Nanako Shiraishi
 
-USAGE='[  | save | list | show | apply | clear | create ]'
+USAGE='[  | save | list | show | apply | clear | create | drop ]'
 
 SUBDIRECTORY_OK=Yes
 OPTIONS_SPEC=
@@ -192,6 +192,24 @@ apply_stash () {
 	fi
 }
 
+drop_stash () {
+	if ! have_stash
+	then
+		echo >&2 'No stash entries to drop'
+		exit 0
+	fi
+
+	# Verify supplied argument looks like a stash entry
+	s=$(git rev-parse --revs-only --no-flags --default $ref_stash "$@") &&
+	git rev-parse --verify "$s:"   > /dev/null 2>&1 &&
+	git rev-parse --verify "$s^1:" > /dev/null 2>&1 &&
+	git rev-parse --verify "$s^2:" > /dev/null 2>&1 ||
+		die "$*: not a valid stashed state"
+
+	git reflog delete "$@" && echo "Dropped $@ ($s)" ||
+		die "$*: Could not drop stash entry"
+}
+
 # Main command set
 case "$1" in
 list)
@@ -225,6 +243,15 @@ create)
 	fi
 	create_stash "$*" && echo "$w_commit"
 	;;
+drop)
+	shift
+	if test $# = 0
+	then
+		set -- "stash@{0}"
+	fi
+	drop_stash "$@" &&
+	(git rev-parse --verify "stash@{0}" > /dev/null 2>&1 || clear_stash)
+	;;
 *)
 	if test $# -eq 0
 	then
-- 
1.5.4.rc2.1119.g6fdf-dirty
