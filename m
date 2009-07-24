From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH v2 2/3] Introduce git-discard
Date: Fri, 24 Jul 2009 18:24:35 +0200
Message-ID: <cf51e6aa92ea98fc9409826cc0468a01fdf7b01e.1248452530.git.trast@student.ethz.ch>
References: <2d756f643fc7d1b50cf590c95467fa029b49ff46.1248426652.git.trast@student.ethz.ch>
Cc: Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 24 18:25:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUNZu-0004JF-Hi
	for gcvg-git-2@gmane.org; Fri, 24 Jul 2009 18:25:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752833AbZGXQYu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 12:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752637AbZGXQYs
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 12:24:48 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:52303 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752451AbZGXQYr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 12:24:47 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 24 Jul 2009 18:24:46 +0200
Received: from localhost.localdomain ([77.56.221.170]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 24 Jul 2009 18:24:45 +0200
X-Mailer: git-send-email 1.6.4.rc2.217.g74c0b.dirty
In-Reply-To: <2d756f643fc7d1b50cf590c95467fa029b49ff46.1248426652.git.trast@student.ethz.ch>
X-OriginalArrivalTime: 24 Jul 2009 16:24:45.0859 (UTC) FILETIME=[41D6D730:01CA0C7B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123926>

The new command 'git discard' is precisely the same as 'git checkout --'.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/git-discard.txt |   29 +++++++++++++++++++++++++++++
 Makefile                      |    1 +
 git-discard.sh                |   22 ++++++++++++++++++++++
 wt-status.c                   |    2 +-
 4 files changed, 53 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/git-discard.txt
 create mode 100644 git-discard.sh

diff --git a/Documentation/git-discard.txt b/Documentation/git-discard.txt
new file mode 100644
index 0000000..4db14f0
--- /dev/null
+++ b/Documentation/git-discard.txt
@@ -0,0 +1,29 @@
+git-discard(1)
+==============
+
+NAME
+----
+git-discard - Remove changes to a file from the worktree
+
+
+SYNOPSIS
+--------
+[verse]
+'git discard' <paths> ...
+
+
+DESCRIPTION
+-----------
+
+Overwrites your edits to the 'paths' with the values from the staging
+area, effectively throwing them away entirely.
+
+*WARNING:* All unstaged changes to the 'paths' are *irreversibly*
+lost.
+
+(This is the same as `git checkout \-- <paths>`.)
+
+
+SEE ALSO
+--------
+linkgit:git-checkout[1]
diff --git a/Makefile b/Makefile
index 9e48fdc..814d4b6 100644
--- a/Makefile
+++ b/Makefile
@@ -312,6 +312,7 @@ TEST_PROGRAMS =
 SCRIPT_SH += git-am.sh
 SCRIPT_SH += git-bisect.sh
 SCRIPT_SH += git-difftool--helper.sh
+SCRIPT_SH += git-discard.sh
 SCRIPT_SH += git-filter-branch.sh
 SCRIPT_SH += git-lost-found.sh
 SCRIPT_SH += git-merge-octopus.sh
diff --git a/git-discard.sh b/git-discard.sh
new file mode 100644
index 0000000..595df98
--- /dev/null
+++ b/git-discard.sh
@@ -0,0 +1,22 @@
+#!/bin/sh
+
+SUBDIRECTORY_OK=Yes
+OPTIONS_KEEPDASHDASH=
+OPTIONS_SPEC="\
+git discard file ...
+--"
+
+. git-sh-setup
+
+
+case "$1" in
+    --)
+	if [ $# -eq 1 ]; then
+	    die "You must specify at least one file to discard changes from"
+	fi
+	exec git checkout "$@"
+	;;
+    *)
+	usage
+	;;
+esac
diff --git a/wt-status.c b/wt-status.c
index f1a74a4..1dd4bed 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -75,7 +75,7 @@ static void wt_status_print_dirty_header(struct wt_status *s,
 		color_fprintf_ln(s->fp, c, "#   (use \"git add <file>...\" to update what will be committed)");
 	else
 		color_fprintf_ln(s->fp, c, "#   (use \"git add/rm <file>...\" to update what will be committed)");
-	color_fprintf_ln(s->fp, c, "#   (use \"git checkout -- <file>...\" to discard changes in working directory)");
+	color_fprintf_ln(s->fp, c, "#   (use \"git discard <file>...\" to discard changes in working directory)");
 	color_fprintf_ln(s->fp, c, "#");
 }
 
-- 
1.6.4.rc2.217.g74c0b.dirty
