From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH] Allow 'svn fetch' on '(no date)' revisions in Subversion.
Date: Sun, 24 Sep 2006 22:50:15 -0400
Message-ID: <20060925025015.GB15603@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Sep 25 04:50:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRgY3-0005ml-LC
	for gcvg-git@gmane.org; Mon, 25 Sep 2006 04:50:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030193AbWIYCuT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Sep 2006 22:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030194AbWIYCuT
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 22:50:19 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:34469 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1030193AbWIYCuS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Sep 2006 22:50:18 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GRgXk-0004yp-WA
	for git@vger.kernel.org; Sun, 24 Sep 2006 22:50:05 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8C1AF20FB16; Sun, 24 Sep 2006 22:50:15 -0400 (EDT)
To: git@vger.kernel.org
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27722>

Added --ignore-nodate to allow 'git svn fetch' to import revisions
from Subversion which have '(no date)' listed as the date of the
revision.  By default 'git svn fetch' will crash with an error
when encountering such a revision.  The user may restart the fetch
operation by adding --ignore-nodate if they want to continue tracking
that repository.

I'm not entirely sure why a centralized version control system such
as Subversion permits revisions to be created with absolutely no
date/time associated with it but it apparently is possible as one
of the Subversion repositories that I'm tracking with 'git svn'
created such a revision on '(no date)' and by '(no user)'.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Uhhh.  Riiiiight.  Getting garbage from a version control system
 is always a good feature for it to have.  Especially a centralized
 one where nobody should be able to subvert the server's concept
 of what time it is.  *sigh*

 Documentation/git-svn.txt |   12 ++++++++++++
 git-svn.perl              |    5 ++++-
 2 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index b7b63f7..1cfa3e3 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -244,6 +244,18 @@ doing.
 
 repo-config key: svn.noignoreexternals
 
+--ignore-nodate::
+Only used with the 'fetch' command.
+
+By default git-svn will crash if it tries to import a revision
+from SVN which has '(no date)' listed as the date of the revision.
+This is repository corruption on SVN's part, plain and simple.
+But sometimes you really need those revisions anyway.
+
+If supplied git-svn will convert '(no date)' entries to the UNIX
+epoch (midnight on Jan. 1, 1970).  Yes, that's probably very wrong.
+SVN was very wrong.
+
 --
 
 Basic Examples
diff --git a/git-svn.perl b/git-svn.perl
index 0290850..8a2ef99 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -52,7 +52,7 @@ my ($_revision,$_stdin,$_no_ignore_ext,$
 	$_template, $_shared, $_no_default_regex, $_no_graft_copy,
 	$_limit, $_verbose, $_incremental, $_oneline, $_l_fmt, $_show_commit,
 	$_version, $_upgrade, $_authors, $_branch_all_refs, @_opt_m,
-	$_merge, $_strategy, $_dry_run);
+	$_merge, $_strategy, $_dry_run, $_ignore_nodate);
 my (@_branch_from, %tree_map, %users, %rusers, %equiv);
 my ($_svn_co_url_revs, $_svn_pg_peg_revs);
 my @repo_path_split_cache;
@@ -65,6 +65,7 @@ my %fc_opts = ( 'no-ignore-externals' =>
 		'repack:i' => \$_repack,
 		'no-metadata' => \$_no_metadata,
 		'quiet|q' => \$_q,
+		'ignore-nodate' => \$_ignore_nodate,
 		'repack-flags|repack-args|repack-opts=s' => \$_repack_flags);
 
 my ($_trunk, $_tags, $_branches);
@@ -1734,6 +1735,8 @@ sub next_log_entry {
 			my $rev = $1;
 			my ($author, $date, $lines) = split(/\s*\|\s*/, $_, 3);
 			($lines) = ($lines =~ /(\d+)/);
+			$date = '1970-01-01 00:00:00 +0000'
+				if ($_ignore_nodate && $date eq '(no date)');
 			my ($Y,$m,$d,$H,$M,$S,$tz) = ($date =~
 					/(\d{4})\-(\d\d)\-(\d\d)\s
 					 (\d\d)\:(\d\d)\:(\d\d)\s([\-\+]\d+)/x)
-- 
1.4.2.1.ga6af-dirty
