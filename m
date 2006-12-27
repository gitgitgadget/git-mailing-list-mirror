From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Create 'git gc' to perform common maintenance operations.
Date: Wed, 27 Dec 2006 02:05:41 -0500
Message-ID: <20061227070541.GA22982@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 27 08:05:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzSrH-0005WF-21
	for gcvg-git@gmane.org; Wed, 27 Dec 2006 08:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932936AbWL0HFs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Dec 2006 02:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932944AbWL0HFs
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Dec 2006 02:05:48 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:54532 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932936AbWL0HFr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Dec 2006 02:05:47 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GzSrH-0003O1-IV; Wed, 27 Dec 2006 02:05:51 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E4ABE20FB65; Wed, 27 Dec 2006 02:05:41 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35447>

Junio asked for a 'git gc' utility which users can execute on a
regular basis to perform basic repository actions such as:

 * prune
 * repack -a -d
 * reflog expire
 * rerere gc
 * pack-refs --prune

So here is a command which does exactly that.  The parameters fed
to reflog's expire subcommand can be chosen by the user by setting
configuration options in .git/config (or ~/.gitconfig), as users may
want different expiration windows for each repository but shouldn't
be bothered to remember what they are all of the time.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .gitignore               |    1 +
 Documentation/git-gc.txt |   55 ++++++++++++++++++++++++++++++++++++++++++++++
 Makefile                 |    2 +-
 git-gc.sh                |   30 +++++++++++++++++++++++++
 4 files changed, 87 insertions(+), 1 deletions(-)

diff --git a/.gitignore b/.gitignore
index 91e6966..f92e359 100644
--- a/.gitignore
+++ b/.gitignore
@@ -41,6 +41,7 @@ git-fmt-merge-msg
 git-for-each-ref
 git-format-patch
 git-fsck-objects
+git-gc
 git-get-tar-commit-id
 git-grep
 git-hash-object
diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
new file mode 100644
index 0000000..a494b1f
--- /dev/null
+++ b/Documentation/git-gc.txt
@@ -0,0 +1,55 @@
+git-gc(1)
+===========
+
+NAME
+----
+git-gc - Cleanup unnecessary files and optimize the local repository.
+
+
+SYNOPSIS
+--------
+'git-gc'
+
+DESCRIPTION
+-----------
+Runs a number of housekeeping tasks within the current repository,
+such as compressing file revisions (to reduce disk space and increase
+performance) and removing unreachable objects which may have been
+created from prior invocations of gitlink:git-add[1].
+
+Users are encouraged to run this task on a regular basis within
+each repository to maintain good disk space utilization and good
+operating performance.
+
+Configuration
+-------------
+
+The optional configuration variable 'gc.reflogExpire' can be
+set to indicate how long historical entries within each branch's
+reflog should remain available in this repository.  The setting is
+expressed as a length of time, for example '90 days' or '3 months'.
+It defaults to '90 days'.
+
+The optional configuration variable 'gc.reflogExpireUnreachable'
+can be set to indicate how long historical reflog entries which
+are not part of the current branch should remain available in
+this repository.  These types of entries are generally created as
+a result of using `git commit \--amend` or `git rebase` and are the
+commits prior to the amend or rebase occuring.  Since these changes
+are not part of the current project most users will want to expire
+them sooner.  This option defaults to '60 days'.
+
+See Also
+--------
+gitlink:git-prune[1]
+gitlink:git-repack[1]
+gitlink:git-rerere[1]
+
+Author
+------
+Written by Shawn O. Pearce <spearce@spearce.org>
+
+GIT
+---
+Part of the gitlink:git[7] suite
+
diff --git a/Makefile b/Makefile
index b8b746f..fb6ba27 100644
--- a/Makefile
+++ b/Makefile
@@ -157,7 +157,7 @@ BASIC_LDFLAGS =
 SCRIPT_SH = \
 	git-bisect.sh git-checkout.sh \
 	git-clean.sh git-clone.sh git-commit.sh \
-	git-fetch.sh \
+	git-fetch.sh git-gc.sh \
 	git-ls-remote.sh \
 	git-merge-one-file.sh git-parse-remote.sh \
 	git-pull.sh git-rebase.sh \
diff --git a/git-gc.sh b/git-gc.sh
new file mode 100644
index 0000000..cb70412
--- /dev/null
+++ b/git-gc.sh
@@ -0,0 +1,30 @@
+#!/bin/sh
+#
+# Copyright (c) 2006, Shawn O. Pearce
+#
+# Cleanup unreachable files and optimize the repository.
+
+USAGE=''
+SUBDIRECTORY_OK=Yes
+. git-sh-setup
+
+reflog_expire=$(git-repo-config gc.reflogExpire)
+if [ -z "$reflog_expire" ]
+then
+	reflog_expire="90 days"
+fi
+
+reflog_unreachable=$(git-repo-config gc.reflogExpireUnreachable)
+if [ -z "$reflog_unreachable" ]
+then
+	reflog_unreachable="60 days"
+fi
+
+git-pack-refs --prune &&
+git-reflog expire \
+	--expire="$reflog_expire" \
+	--expire-unreachable="$reflog_unreachable" \
+	--all &&
+git-prune &&
+git-repack -a -d &&
+git-rerere gc || exit
-- 
1.4.4.3.gd2e4
