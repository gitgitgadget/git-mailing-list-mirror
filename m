From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 4/3] git-svn: allow `info' command to work offline
Date: Wed, 21 Nov 2007 18:23:43 -0800
Message-ID: <20071122022343.GA9992@soma>
References: <1195675039-26746-1-git-send-email-ddkilzer@kilzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "David D. Kilzer" <ddkilzer@kilzer.net>
X-From: git-owner@vger.kernel.org Thu Nov 22 03:24:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iv1jY-0004JA-Hf
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 03:24:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753962AbXKVCXq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 21:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753936AbXKVCXq
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 21:23:46 -0500
Received: from hand.yhbt.net ([66.150.188.102]:37069 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753852AbXKVCXp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 21:23:45 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 2D2E97DC0FE;
	Wed, 21 Nov 2007 18:23:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1195675039-26746-1-git-send-email-ddkilzer@kilzer.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65735>

Cache the repository root whenever we connect to the repository.
This will allow us to notice URL changes if the user changes the
URL in .git/config, too.

If the repository is no longer accessible, or if `git svn info'
is the first and only command run; then '(offline)' will be
displayed for "Repository Root:" in the output.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---

 David:

 I'll apply this once you've verified my fix to 1/3 is correct behavior,
 too.

 git-svn.perl |   26 +++++++++++++++++++++++---
 1 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 7d86870..43e1591 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -782,9 +782,14 @@ sub cmd_info {
 	$result .= "Name: " . basename($path) . "\n" if $file_type ne "dir";
 	$result .= "URL: " . $full_url . "\n";
 
-	my $repos_root = $gs->ra->{repos_root};
-	Git::SVN::remove_username($repos_root);
-	$result .= "Repository Root: $repos_root\n";
+	eval {
+		my $repos_root = $gs->repos_root;
+		Git::SVN::remove_username($repos_root);
+		$result .= "Repository Root: $repos_root\n";
+	};
+	if ($@) {
+		$result .= "Repository Root: (offline)\n";
+	}
 	$result .= "Repository UUID: $uuid\n" unless $diff_status eq "A";
 	$result .= "Revision: " . ($diff_status eq "A" ? 0 : $rev) . "\n";
 
@@ -1773,9 +1778,24 @@ sub ra_uuid {
 	$self->{ra_uuid};
 }
 
+sub _set_repos_root {
+	my ($self, $repos_root) = @_;
+	my $k = "svn-remote.$self->{repo_id}.reposRoot";
+	$repos_root ||= $self->ra->{repos_root};
+	tmp_config($k, $repos_root);
+	$repos_root;
+}
+
+sub repos_root {
+	my ($self) = @_;
+	my $k = "svn-remote.$self->{repo_id}.reposRoot";
+	eval { tmp_config('--get', $k) } || $self->_set_repos_root;
+}
+
 sub ra {
 	my ($self) = shift;
 	my $ra = Git::SVN::Ra->new($self->{url});
+	$self->_set_repos_root($ra->{repos_root});
 	if ($self->use_svm_props && !$self->{svm}) {
 		if ($self->no_metadata) {
 			die "Can't have both 'noMetadata' and ",
-- 
Eric Wong
