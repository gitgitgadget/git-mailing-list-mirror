From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 1/2] git-svn: add --prefix= option to multi-init
Date: Sun,  7 Jan 2007 19:35:40 -0800
Message-ID: <11682273413995-git-send-email-normalperson@yhbt.net>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Jan 08 04:35:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3lIY-00052k-Kt
	for gcvg-git@gmane.org; Mon, 08 Jan 2007 04:35:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030472AbXAHDfo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 22:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030477AbXAHDfo
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 22:35:44 -0500
Received: from hand.yhbt.net ([66.150.188.102]:34334 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030472AbXAHDfn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 22:35:43 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id C60DC7DC094;
	Sun,  7 Jan 2007 19:35:41 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sun, 07 Jan 2007 19:35:41 -0800
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.5.0.rc0.ge21b-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36234>

Also, document --{trunk,branches,tags} options while we're
documenting multi-init options.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 Documentation/git-svn.txt |   18 ++++++++++++++++++
 git-svn.perl              |    8 +++++---
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index ce63def..8df43cb 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -139,6 +139,24 @@ manually joining branches on commit.
 	where the repository URL ends and where the repository path
 	begins.
 
+-T<trunk_subdir>::
+--trunk=<trunk_subdir>::
+-t<tags_subdir>::
+--tags=<tags_subdir>::
+-b<branches_subdir>::
+--branches=<branches_subdir>::
+	These are the command-line options for multi-init.  Each of
+	these flags can point to a relative repository path
+	(--tags=project/tags') or a full url
+	(--tags=https://foo.org/project/tags)
+
+--prefix=<prefix>
+	This allows one to specify a prefix which is prepended to the
+	names of remotes.  The prefix does not automatically include a
+	trailing slash, so be sure you include one in the argument if
+	that is what you want.  This is useful if you wish to track
+	multiple projects that share a common repository.
+
 'multi-fetch'::
 	This runs fetch on all known SVN branches we're tracking.  This
 	will NOT discover new branches (unlike git-svnimport), so
diff --git a/git-svn.perl b/git-svn.perl
index 1da31fd..a092be8 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -70,7 +70,7 @@ my ($_revision,$_stdin,$_no_ignore_ext,$_no_stop_copy,$_help,$_rmdir,$_edit,
 	$_version, $_upgrade, $_authors, $_branch_all_refs, @_opt_m,
 	$_merge, $_strategy, $_dry_run, $_ignore_nodate, $_non_recursive,
 	$_username, $_config_dir, $_no_auth_cache,
-	$_pager, $_color);
+	$_pager, $_color, $_prefix);
 my (@_branch_from, %tree_map, %users, %rusers, %equiv);
 my ($_svn_can_do_switch);
 my @repo_path_split_cache;
@@ -134,6 +134,7 @@ my %cmd = (
 			 'username=s' => \$_username,
 			 'config-dir=s' => \$_config_dir,
 			 'no-auth-cache' => \$_no_auth_cache,
+			 'prefix=s' => \$_prefix,
 			} ],
 	'multi-fetch' => [ \&multi_fetch,
 			'Fetch multiple trees (like git-svnimport)',
@@ -595,8 +596,9 @@ sub multi_init {
 			command_noisy('repo-config', 'svn.trunk', $trunk_url);
 		}
 	}
-	complete_url_ls_init($url, $_branches, '--branches/-b', '');
-	complete_url_ls_init($url, $_tags, '--tags/-t', 'tags/');
+	$_prefix = '' unless defined $_prefix;
+	complete_url_ls_init($url, $_branches, '--branches/-b', $_prefix);
+	complete_url_ls_init($url, $_tags, '--tags/-t', $_prefix . 'tags/');
 }
 
 sub multi_fetch {
-- 
1.5.0.rc0.ge21b-dirty
