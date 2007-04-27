From: Adam Roben <aroben@apple.com>
Subject: [PATCH] git-svn: Added 'find-rev' command
Date: Fri, 27 Apr 2007 11:57:53 -0700
Message-ID: <117770027350-git-send-email-aroben@apple.com>
Cc: git@vger.kernel.org, Adam Roben <aroben@apple.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Apr 27 21:10:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhVpj-0007AY-QJ
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 21:10:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757148AbXD0TIw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 15:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757063AbXD0S63
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 14:58:29 -0400
Received: from mail-out3.apple.com ([17.254.13.22]:50682 "EHLO
	mail-out3.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757068AbXD0S6H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2007 14:58:07 -0400
Received: from relay6.apple.com (a17-128-113-36.apple.com [17.128.113.36])
	by mail-out3.apple.com (8.13.8/8.13.8) with ESMTP id l3RIw6Xl025531;
	Fri, 27 Apr 2007 11:58:06 -0700 (PDT)
Received: from relay6.apple.com (unknown [127.0.0.1])
	by relay6.apple.com (Symantec Mail Security) with ESMTP id 953B210B5C;
	Fri, 27 Apr 2007 11:58:06 -0700 (PDT)
X-AuditID: 11807124-a049cbb000000872-3d-463247be806e 
Received: from localhost.localdomain (il0301a-dhcp30.apple.com [17.203.14.158])
	by relay6.apple.com (Apple SCV relay) with ESMTP id 78E28100FB;
	Fri, 27 Apr 2007 11:58:06 -0700 (PDT)
X-Mailer: git-send-email 1.5.2.rc0.75.g959b-dirty
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45743>

This patch adds a new 'find-rev' command to git-svn that lets you easily
translate between SVN revision numbers and git tree-ish.

Signed-off-by: Adam Roben <aroben@apple.com>
---
 Documentation/git-svn.txt |    5 +++++
 git-svn.perl              |   24 ++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index a0d34e0..a35b9de 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -159,6 +159,11 @@ New features:
 Any other arguments are passed directly to `git log'
 
 --
+'find-rev'::
+	When given an SVN revision number of the form 'rN', returns the
+	corresponding git commit hash.  When given a tree-ish, returns the
+	corresponding SVN revision number.
+
 'set-tree'::
 	You should consider using 'dcommit' instead of this command.
 	Commit specified commit or tree objects to SVN.  This relies on
diff --git a/git-svn.perl b/git-svn.perl
index 7b5f8ab..4be8576 100755
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
@@ -428,6 +430,28 @@ sub cmd_dcommit {
 	command_noisy(@finish, $gs->refname);
 }
 
+sub cmd_find_rev {
+	my $revision_or_hash = shift;
+	my $result;
+	if ($revision_or_hash =~ /^r\d+$/) {
+		my $desired_revision = substr($revision_or_hash, 1);
+		my ($fh, $ctx) = command_output_pipe('rev-list', 'HEAD');
+		while (my $hash = <$fh>) {
+			chomp($hash);
+			my (undef, $rev, undef) = cmt_metadata($hash);
+			if ($rev && $rev eq $desired_revision) {
+				$result = $hash;
+				last;
+			}
+		}
+		command_close_pipe($fh, $ctx);
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
