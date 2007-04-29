From: Adam Roben <aroben@apple.com>
Subject: [PATCH] git-svn: Add 'find-rev' command
Date: Sun, 29 Apr 2007 01:35:27 -0700
Message-ID: <1177835727239-git-send-email-aroben@apple.com>
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Adam Roben <aroben@apple.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Apr 29 10:36:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hi4sw-0004Ri-TN
	for gcvg-git@gmane.org; Sun, 29 Apr 2007 10:35:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755053AbXD2Ifq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Apr 2007 04:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755055AbXD2Ifq
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Apr 2007 04:35:46 -0400
Received: from mail-out4.apple.com ([17.254.13.23]:52344 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755050AbXD2Ifp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Apr 2007 04:35:45 -0400
Received: from relay6.apple.com (a17-128-113-36.apple.com [17.128.113.36])
	by mail-out4.apple.com (8.13.8/8.13.8) with ESMTP id l3T8Zhe2015451;
	Sun, 29 Apr 2007 01:35:43 -0700 (PDT)
Received: from relay6.apple.com (unknown [127.0.0.1])
	by relay6.apple.com (Symantec Mail Security) with ESMTP id 2E3FE10B44;
	Sun, 29 Apr 2007 01:35:43 -0700 (PDT)
X-AuditID: 11807124-a2ca1bb000000872-f9-463458de5251 
Received: from localhost.localdomain (unknown [17.219.209.216])
	by relay6.apple.com (Apple SCV relay) with ESMTP id 0A5111012C;
	Sun, 29 Apr 2007 01:35:41 -0700 (PDT)
X-Mailer: git-send-email 1.5.2.rc0.75.g959b-dirty
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45823>

This patch adds a new 'find-rev' command to git-svn that lets you easily
translate between SVN revision numbers and git tree-ish.

Signed-off-by: Adam Roben <aroben@apple.com>
---
This is an updated version of my previous patch that takes Eric and Junio's
comments into account.

 Documentation/git-svn.txt |    6 ++++++
 git-svn.perl              |   23 +++++++++++++++++++++++
 2 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index a0d34e0..482c862 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -159,6 +159,12 @@ New features:
 Any other arguments are passed directly to `git log'
 
 --
+'find-rev'::
+	When given an SVN revision number of the form 'rN', returns the
+        corresponding git commit hash (this can optionally be followed by a
+        tree-ish to specify which branch should be searched).  When given a
+        tree-ish, returns the corresponding SVN revision number.
+
 'set-tree'::
 	You should consider using 'dcommit' instead of this command.
 	Commit specified commit or tree objects to SVN.  This relies on
diff --git a/git-svn.perl b/git-svn.perl
index 7b5f8ab..30e4a41 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -141,6 +141,8 @@ my %cmd = (
 			  'color' => \$Git::SVN::Log::color,
 			  'pager=s' => \$Git::SVN::Log::pager,
 			} ],
+	'find-rev' => [ \&cmd_find_rev, "Translate between SVN revision numbers and tree-ish",
+			{ } ],
 	'rebase' => [ \&cmd_rebase, "Fetch and rebase your working directory",
 			{ 'merge|m|M' => \$_merge,
 			  'verbose|v' => \$_verbose,
@@ -428,6 +430,27 @@ sub cmd_dcommit {
 	command_noisy(@finish, $gs->refname);
 }
 
+sub cmd_find_rev {
+	my $revision_or_hash = shift;
+	my $result;
+	if ($revision_or_hash =~ /^r\d+$/) {
+		my $head = shift;
+		$head ||= 'HEAD';
+		my @refs;
+		my (undef, undef, undef, $gs) = working_head_info($head, \@refs);
+		unless ($gs) {
+			die "Unable to determine upstream SVN information from ",
+			    "$head history\n";
+		}
+		my $desired_revision = substr($revision_or_hash, 1);
+		$result = $gs->rev_db_get($desired_revision);
+	} else {
+		my (undef, $rev, undef) = cmt_metadata($revision_or_hash);
+		$result = $rev;
+	}
+	print "$result\n" if $result;
+}
+
 sub cmd_rebase {
 	command_noisy(qw/update-index --refresh/);
 	my ($url, $rev, $uuid, $gs) = working_head_info('HEAD');
-- 
1.5.2.rc0.75.g959b-dirty
