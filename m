From: John Keeping <john@keeping.me.uk>
Subject: [PATCH] git-svn: teach find-rev to find near matches
Date: Thu, 17 Jan 2013 22:19:33 +0000
Message-ID: <20130117221933.GK4574@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 17 23:20:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvxoX-0001jQ-SV
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jan 2013 23:20:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752879Ab3AQWTl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2013 17:19:41 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:53126 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751869Ab3AQWTk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2013 17:19:40 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id EBE326064EB;
	Thu, 17 Jan 2013 22:19:39 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -11
X-Spam-Level: 
X-Spam-Status: No, score=-11 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 77dseH-ihNJs; Thu, 17 Jan 2013 22:19:39 +0000 (GMT)
Received: from aardwolf.aluminati.org (aardwolf.aluminati.org [10.0.7.189])
	by coyote.aluminati.org (Postfix) with ESMTP id 613266064CF;
	Thu, 17 Jan 2013 22:19:39 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by aardwolf.aluminati.org (Postfix) with ESMTP id 347DD276DFE;
	Thu, 17 Jan 2013 22:19:39 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from aardwolf.aluminati.org ([127.0.0.1])
	by localhost (aardwolf.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F6jhVn9t9Xcr; Thu, 17 Jan 2013 22:19:39 +0000 (GMT)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by aardwolf.aluminati.org (Postfix) with ESMTPSA id 23F8D276DFB;
	Thu, 17 Jan 2013 22:19:35 +0000 (GMT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213883>

When a single SVN repository is split into multiple Git repositories
many SVN revisions will exist in only one of the Git repositories
created.  For some projects the only way to build a working artifact is
to check out corresponding versions of various repositories, with no
indication of what those are in the Git world - in the SVN world the
revision numbers are sufficient.

By adding "--before" to "git-svn find-rev" we can say "tell me what this
repository looked like when that other repository looked like this":

    git svn find-rev --before \
        r$(git --git-dir=/over/there.git svn find-rev HEAD)

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 Documentation/git-svn.txt | 10 ++++++++++
 git-svn.perl              | 12 ++++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 69decb1..34d438b 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -346,6 +346,16 @@ Any other arguments are passed directly to 'git log'
 	corresponding git commit hash (this can optionally be followed by a
 	tree-ish to specify which branch should be searched).  When given a
 	tree-ish, returns the corresponding SVN revision number.
++
+--before;;
+	Don't require an exact match if given an SVN revision, instead find
+	the commit corresponding to the state of the SVN repository (on the
+	current branch) at the specified revision.
++
+--after;;
+	Don't require an exact match if given an SVN revision; if there is
+	not an exact match return the closest match searching forward in the
+	history.
 
 'set-tree'::
 	You should consider using 'dcommit' instead of this command.
diff --git a/git-svn.perl b/git-svn.perl
index bd5266c..d086694 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -114,6 +114,7 @@ my ($_stdin, $_help, $_edit,
 	$_message, $_file, $_branch_dest,
 	$_template, $_shared,
 	$_version, $_fetch_all, $_no_rebase, $_fetch_parent,
+	$_before, $_after,
 	$_merge, $_strategy, $_preserve_merges, $_dry_run, $_local,
 	$_prefix, $_no_checkout, $_url, $_verbose,
 	$_commit_url, $_tag, $_merge_info, $_interactive);
@@ -258,7 +259,8 @@ my %cmd = (
 			} ],
 	'find-rev' => [ \&cmd_find_rev,
 	                "Translate between SVN revision numbers and tree-ish",
-			{} ],
+			{ 'before' => \$_before,
+			  'after' => \$_after } ],
 	'rebase' => [ \&cmd_rebase, "Fetch and rebase your working directory",
 			{ 'merge|m|M' => \$_merge,
 			  'verbose|v' => \$_verbose,
@@ -1191,7 +1193,13 @@ sub cmd_find_rev {
 			    "$head history\n";
 		}
 		my $desired_revision = substr($revision_or_hash, 1);
-		$result = $gs->rev_map_get($desired_revision, $uuid);
+		if ($_before) {
+			$result = $gs->find_rev_before($desired_revision, 1);
+		} elsif ($_after) {
+			$result = $gs->find_rev_after($desired_revision, 1);
+		} else {
+			$result = $gs->rev_map_get($desired_revision, $uuid);
+		}
 	} else {
 		my (undef, $rev, undef) = cmt_metadata($revision_or_hash);
 		$result = $rev;
-- 
1.8.1.1
