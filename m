From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn init/clone --stdlayout option to default-init trunk/tags/branches
Date: Wed, 22 Aug 2007 23:10:09 -0700
Message-ID: <20070823061009.GA10547@soma>
References: <1184405128718-git-send-email-madduck@madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "martin f. krafft" <madduck@madduck.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 23 08:10:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IO5u4-0001xM-Ll
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 08:10:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753287AbXHWGKO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 02:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753186AbXHWGKO
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 02:10:14 -0400
Received: from hand.yhbt.net ([66.150.188.102]:37722 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753176AbXHWGKM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 02:10:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id B4F2B2DC08D;
	Wed, 22 Aug 2007 23:10:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1184405128718-git-send-email-madduck@madduck.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56458>

Here's a cleaned up version of this patch with my tweaks.

>From f5b6da6bc4e2d879ca200993f0d3806486e8fb21 Mon Sep 17 00:00:00 2001
From: martin f. krafft <madduck@madduck.net>
Date: Sat, 14 Jul 2007 11:25:28 +0200
Subject: [PATCH] git-svn init/clone --stdlayout option to default-init trunk/tags/branches

The --stdlayout option to git-svn init/clone initialises the default
Subversion values of trunk,tags,branches: -T trunk -b branches -t tags.
If any of the -T/-t/-b options are given in addition, they are given
preference.

[ew: fixed whitespace and added "-s" shortcut]

Signed-off-by: martin f. krafft <madduck@madduck.net>
Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 Documentation/git-svn.txt |    7 ++++++-
 git-svn.perl              |   11 +++++++++--
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index fbc5887..3e2a63b 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -44,10 +44,15 @@ COMMANDS
 --tags=<tags_subdir>;;
 -b<branches_subdir>;;
 --branches=<branches_subdir>;;
+-s;;
+--stdlayout;;
 	These are optional command-line options for init.  Each of
 	these flags can point to a relative repository path
 	(--tags=project/tags') or a full url
-	(--tags=https://foo.org/project/tags)
+	(--tags=https://foo.org/project/tags). The option --stdlayout is
+	a shorthand way of setting trunk,tags,branches as the relative paths,
+	which is the Subversion default. If any of the other options are given
+	as well, they take precedence.
 --no-metadata;;
 	Set the 'noMetadata' option in the [svn-remote] config.
 --use-svm-props;;
diff --git a/git-svn.perl b/git-svn.perl
index 7a8ffd5..4e325b7 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -77,11 +77,12 @@ my %fc_opts = ( 'follow-parent|follow!' => \$Git::SVN::_follow_parent,
 		   \$Git::SVN::_repack_flags,
 		%remote_opts );
 
-my ($_trunk, $_tags, $_branches);
+my ($_trunk, $_tags, $_branches, $_stdlayout);
 my %icv;
 my %init_opts = ( 'template=s' => \$_template, 'shared:s' => \$_shared,
                   'trunk|T=s' => \$_trunk, 'tags|t=s' => \$_tags,
                   'branches|b=s' => \$_branches, 'prefix=s' => \$_prefix,
+                  'stdlayout|s' => \$_stdlayout,
                   'minimize-url|m' => \$Git::SVN::_minimize_url,
 		  'no-metadata' => sub { $icv{noMetadata} = 1 },
 		  'use-svm-props' => sub { $icv{useSvmProps} = 1 },
@@ -292,7 +293,8 @@ sub init_subdir {
 sub cmd_clone {
 	my ($url, $path) = @_;
 	if (!defined $path &&
-	    (defined $_trunk || defined $_branches || defined $_tags) &&
+	    (defined $_trunk || defined $_branches || defined $_tags ||
+	     defined $_stdlayout) &&
 	    $url !~ m#^[a-z\+]+://#) {
 		$path = $url;
 	}
@@ -302,6 +304,11 @@ sub cmd_clone {
 }
 
 sub cmd_init {
+	if (defined $_stdlayout) {
+		$_trunk = 'trunk' if (!defined $_trunk);
+		$_tags = 'tags' if (!defined $_tags);
+		$_branches = 'branches' if (!defined $_branches);
+	}
 	if (defined $_trunk || defined $_branches || defined $_tags) {
 		return cmd_multi_init(@_);
 	}
-- 
Eric Wong
