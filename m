From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH WIP] git-stash: add new 'drop' subcommand
Date: Wed, 06 Feb 2008 10:19:18 -0600
Message-ID: <47A9DE06.9050307@nrlssc.navy.mil>
References: <alpine.LSU.1.00.0802051401000.8543@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Wincent Colaiuta <win@wincent.com>, Tim Stoakes <tim@stoakes.net>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 06 17:21:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMn18-0001vB-S3
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 17:20:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751931AbYBFQUZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 11:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751895AbYBFQUZ
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 11:20:25 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:40706 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751868AbYBFQUX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 11:20:23 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m16GJJp3010170;
	Wed, 6 Feb 2008 10:19:54 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 6 Feb 2008 10:19:19 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <alpine.LSU.1.00.0802051401000.8543@racer.site>
X-OriginalArrivalTime: 06 Feb 2008 16:19:19.0044 (UTC) FILETIME=[06745440:01C868DC]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15706001
X-TM-AS-Result: : Yes--12.659300-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNjQzLTcwNzM5NS03MDM3?=
	=?us-ascii?B?MjAtNzEwOTg5LTcwMDE2MC03MDAwNzUtMTM5MDEwLTcwMjcyNi03?=
	=?us-ascii?B?MDI1NjgtNzA0NDIxLTEwNTcwMC03MDI2MzgtNzAxNDYxLTcwNTM4?=
	=?us-ascii?B?OC03MDA1MTYtNzAxMzk1LTcwMzc4OC03MDUwNjktNzA0NDI1LTcw?=
	=?us-ascii?B?MzE3OS03MDEzMDUtNzAyMDg0LTcwMDE3My03MDAyNzAtNzA1OTAx?=
	=?us-ascii?B?LTcwMTYxOC03MDQ0MTAtMTg4MDE5LTcwMzQ1NC0xMDY0NzAtNzAw?=
	=?us-ascii?B?NDc2LTcwNDU2OC0xMDY0MjAtNzAzNzQwLTcwMTkzNy03MTA5NzAt?=
	=?us-ascii?B?NzAyMDM4LTcwMDk3MC03MDc3NTAtNzAwMzczLTcwMDMyNC03MDQ4?=
	=?us-ascii?B?NTItNzA3NDUxLTcwMzcxMi0xNDgwMzktMTQ4MDUxLTEwMDAzLTIw?=
	=?us-ascii?B?MDQw?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72809>

This allows a single stash entry to be deleted. It takes an
optional argument which is a stash reflog entry. If no
arguments are supplied, it drops the most recent stash entry.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


Johannes Schindelin wrote:
> On Tue, 5 Feb 2008, Wincent Colaiuta wrote:
>> I can't remember who/if 
>> has followed up with push/pop/delete patches for "git stash".
>
> The followup was by Brandon (Cc'ed) to add "stash drop":

Here is the same patch rebased on top of next.

This doesn't work perfectly yet. One or both of refs/stash and
logs/refs/stash are not being updated correctly.

When the top-most stash is dropped, refs/stash is not updated to
contain the commit id of the new stash@{0}. A subsequent drop then
produces a warning like:

warning: Log .git/logs/refs/stash unexpectedly ended on Wed, 6 Feb 2008 10:00:20 -0600.

So this is still a work in progress.

Also missing is the ability to drop multiple stash entries at
one time. I think reflog delete will have to be modified to
accommodate this. What happens is that the deletions are performed
in a loop, and each deletion shifts the reflog entries so that they
don't necessarily point to the same thing.

    $ git stash list
    stash@{0} My fourth stash
    stash@{1} My third stash
    stash@{2} My second stash
    stash@{3} My first stash
    $ git reflog delete stash@{1} stash@{2}
    $ git stash list
    stash@{0} My fourth stash
    stash@{1} My second stash

"My third stash" and "My second stash" should have been deleted, but
"My first stash" was deleted instead.

-brandon


 Documentation/git-stash.txt |    7 ++++++-
 git-stash.sh                |   25 ++++++++++++++++++++++++-
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index cd0dc1b..f339a57 100644
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
@@ -82,6 +82,11 @@ clear::
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
1.5.4.1135.g75520
