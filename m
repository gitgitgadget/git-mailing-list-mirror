From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH v2 1/3] Introduce git-unstage
Date: Fri, 24 Jul 2009 18:24:34 +0200
Message-ID: <683ed99f389d643d21bda6750bd2ee9caf287625.1248452530.git.trast@student.ethz.ch>
References: <2d756f643fc7d1b50cf590c95467fa029b49ff46.1248426652.git.trast@student.ethz.ch>
Cc: Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 24 18:25:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUNZt-0004JF-Pv
	for gcvg-git-2@gmane.org; Fri, 24 Jul 2009 18:25:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752651AbZGXQYs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 12:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752478AbZGXQYs
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 12:24:48 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:7152 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752356AbZGXQYr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 12:24:47 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 24 Jul 2009 18:24:46 +0200
Received: from localhost.localdomain ([77.56.221.170]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 24 Jul 2009 18:24:45 +0200
X-Mailer: git-send-email 1.6.4.rc2.217.g74c0b.dirty
In-Reply-To: <2d756f643fc7d1b50cf590c95467fa029b49ff46.1248426652.git.trast@student.ethz.ch>
X-OriginalArrivalTime: 24 Jul 2009 16:24:45.0452 (UTC) FILETIME=[4198BCC0:01CA0C7B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123925>

The new command 'git unstage' is the precise opposite of 'git stage'
(i.e., git-add).  As such, it is the same as 'git reset --' unless the
current branch is unborn.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

So I decided I had wished for these frequently enough to actually
implement them.  I ran out of time before getting to the tests, but
the rest should be there.

v1 had a bug where it would not correctly detect the changed files,
this is fixed in the new patch (now 3/3).


 Documentation/git-unstage.txt |   26 ++++++++++++++++++++++++++
 Makefile                      |    1 +
 git-unstage.sh                |   26 ++++++++++++++++++++++++++
 wt-status.c                   |    6 +-----
 4 files changed, 54 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/git-unstage.txt
 create mode 100644 git-unstage.sh

diff --git a/Documentation/git-unstage.txt b/Documentation/git-unstage.txt
new file mode 100644
index 0000000..49d09fb
--- /dev/null
+++ b/Documentation/git-unstage.txt
@@ -0,0 +1,26 @@
+git-unstage(1)
+==============
+
+NAME
+----
+git-unstage - Remove changes to a file from the staging area
+
+
+SYNOPSIS
+--------
+[verse]
+'git unstage' <paths> ...
+
+
+DESCRIPTION
+-----------
+
+Overwrites the staged changes to the 'paths' with the values from
+HEAD, so that they are not included in the next commit.  The worktree
+is not affected.  (This is the same as `git reset \-- <paths>` unless
+you are on an unborn branch.)
+
+
+SEE ALSO
+--------
+linkgit:git-reset[1]
diff --git a/Makefile b/Makefile
index 75b9dcb..9e48fdc 100644
--- a/Makefile
+++ b/Makefile
@@ -329,6 +329,7 @@ SCRIPT_SH += git-request-pull.sh
 SCRIPT_SH += git-sh-setup.sh
 SCRIPT_SH += git-stash.sh
 SCRIPT_SH += git-submodule.sh
+SCRIPT_SH += git-unstage.sh
 SCRIPT_SH += git-web--browse.sh
 
 SCRIPT_PERL += git-add--interactive.perl
diff --git a/git-unstage.sh b/git-unstage.sh
new file mode 100644
index 0000000..7f99adf
--- /dev/null
+++ b/git-unstage.sh
@@ -0,0 +1,26 @@
+#!/bin/sh
+
+SUBDIRECTORY_OK=Yes
+OPTIONS_KEEPDASHDASH=
+OPTIONS_SPEC="\
+git unstage file ...
+--"
+
+. git-sh-setup
+
+
+case "$1" in
+    --)
+	if [ $# -eq 1 ]; then
+	    die "You must specify at least one file to unstage"
+	fi
+	if git rev-parse -q --verify HEAD >/dev/null; then
+	    exec git reset "$@"
+	else
+	    exec git rm --cached "$@"
+	fi
+	;;
+    *)
+	usage
+	;;
+esac
diff --git a/wt-status.c b/wt-status.c
index 47735d8..f1a74a4 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -62,11 +62,7 @@ static void wt_status_print_cached_header(struct wt_status *s)
 {
 	const char *c = color(WT_STATUS_HEADER);
 	color_fprintf_ln(s->fp, c, "# Changes to be committed:");
-	if (!s->is_initial) {
-		color_fprintf_ln(s->fp, c, "#   (use \"git reset %s <file>...\" to unstage)", s->reference);
-	} else {
-		color_fprintf_ln(s->fp, c, "#   (use \"git rm --cached <file>...\" to unstage)");
-	}
+	color_fprintf_ln(s->fp, c, "#   (use \"git unstage %s <file>...\" to unstage)", s->reference);
 	color_fprintf_ln(s->fp, c, "#");
 }
 
-- 
1.6.4.rc2.217.g74c0b.dirty
