From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: fsck missing dangling commits that are candidate heads?
Date: Wed, 4 Apr 2007 10:46:14 -0400
Message-ID: <20070404144614.GD4628@spearce.org>
References: <loom.20070403T213135-68@post.gmane.org> <20070403194750.GG27706@spearce.org> <loom.20070403T215123-220@post.gmane.org> <loom.20070404T152916-290@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Sergio Callegari <scallegari@arces.unibo.it>
X-From: git-owner@vger.kernel.org Wed Apr 04 16:46:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZ6ki-0001pa-Dl
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 16:46:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753886AbXDDOqV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 10:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753900AbXDDOqV
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 10:46:21 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:45504 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753886AbXDDOqU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2007 10:46:20 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HZ6kU-00039I-TO; Wed, 04 Apr 2007 10:46:11 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id ED3C020FBAE; Wed,  4 Apr 2007 10:46:14 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <loom.20070404T152916-290@post.gmane.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43743>

Sergio Callegari <scallegari@arces.unibo.it> wrote:
> I mean, so that git lost-found can take advantage of it... in fact git gc is
> surely doing the right thing by considering reflogs, but probably git lost-found
> should not (at least wrt its documentation this script appears to be not in its
> best shape right now).

No shorthand, but the following patch might do the trick:

-->8--
[PATCH] Fix lost-found to show commits only referenced by reflogs

Prior to 1.5.0 the git-lost-found utility was useful to locate
commits that were not referenced by any ref.  These were often
amends, or resets, or tips of branches that had been deleted.
Being able to locate a 'lost' commit and recover it by creating a
new branch was a useful feature in those days.

Unfortunately 1.5.0 added the reflogs to the reachability analysis
performed by git-fsck, which means that most commits users would
consider to be lost are still reachable through a reflog.  So most
(or all!) commits are reachable, and nothing gets output from
git-lost-found.

Now git-fsck can be told to ignore reflogs during its reachability
analysis, making git-lost-found useful again to locate commits
that are no longer referenced by a ref itself, but may still be
referenced by a reflog.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Documentation/git-fsck.txt |    8 +++++++-
 builtin-fsck.c             |    8 +++++++-
 git-lost-found.sh          |    2 +-
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
index 058009d..8c68cf0 100644
--- a/Documentation/git-fsck.txt
+++ b/Documentation/git-fsck.txt
@@ -9,7 +9,7 @@ git-fsck - Verifies the connectivity and validity of the objects in the database
 SYNOPSIS
 --------
 [verse]
-'git-fsck' [--tags] [--root] [--unreachable] [--cache]
+'git-fsck' [--tags] [--root] [--unreachable] [--cache] [--no-reflogs]
 		 [--full] [--strict] [<object>*]
 
 DESCRIPTION
@@ -38,6 +38,12 @@ index file and all SHA1 references in .git/refs/* as heads.
 	Consider any object recorded in the index also as a head node for
 	an unreachability trace.
 
+--no-reflogs::
+	Do not consider commits that are referenced only by an
+	entry in a reflog to be reachable.  This option is meant
+	only to search for commits that used to be in a ref, but
+	now aren't, but are still in that corresponding reflog.
+
 --full::
 	Check not just objects in GIT_OBJECT_DIRECTORY
 	($GIT_DIR/objects), but also the ones found in alternate
diff --git a/builtin-fsck.c b/builtin-fsck.c
index 21f1f9e..e467d4b 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -14,6 +14,7 @@
 static int show_root;
 static int show_tags;
 static int show_unreachable;
+static int include_reflogs = 1;
 static int check_full;
 static int check_strict;
 static int keep_cache_objects;
@@ -517,7 +518,8 @@ static int fsck_handle_ref(const char *refname, const unsigned char *sha1, int f
 static void get_default_heads(void)
 {
 	for_each_ref(fsck_handle_ref, NULL);
-	for_each_reflog(fsck_handle_reflog, NULL);
+	if (include_reflogs)
+		for_each_reflog(fsck_handle_reflog, NULL);
 
 	/*
 	 * Not having any default heads isn't really fatal, but
@@ -616,6 +618,10 @@ int cmd_fsck(int argc, char **argv, const char *prefix)
 			keep_cache_objects = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--no-reflogs")) {
+			include_reflogs = 0;
+			continue;
+		}
 		if (!strcmp(arg, "--full")) {
 			check_full = 1;
 			continue;
diff --git a/git-lost-found.sh b/git-lost-found.sh
index 9360804..58570df 100755
--- a/git-lost-found.sh
+++ b/git-lost-found.sh
@@ -12,7 +12,7 @@ fi
 laf="$GIT_DIR/lost-found"
 rm -fr "$laf" && mkdir -p "$laf/commit" "$laf/other" || exit
 
-git fsck --full |
+git fsck --full --no-reflogs |
 while read dangling type sha1
 do
 	case "$dangling" in
-- 
1.5.1.rc3.672.gf5329


-- 
Shawn.
