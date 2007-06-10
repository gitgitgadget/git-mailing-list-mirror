From: Sam Vilain <sam@vilain.net>
Subject: [PATCH] git-svn: use git-log rather than rev-list | xargs cat-file
Date: Sun, 10 Jun 2007 21:00:45 +1200
Message-ID: <20070610091259.48F8D13A4F8@magnus.utsl.gen.nz>
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Jun 10 11:13:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxJTv-0000WO-Ko
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 11:13:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752064AbXFJJNF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 05:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751977AbXFJJNE
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 05:13:04 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:53357 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751075AbXFJJNB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 05:13:01 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 1003)
	id 48F8D13A4F8; Sun, 10 Jun 2007 21:12:59 +1200 (NZST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49694>

This saves a bit of time when rebuilding the git-svn index.

Signed-off-by: Sam Vilain <sam@vilain.net>
---
 git-svn.perl |   30 +++++++++++++++++++-----------
 1 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index e350061..610563c 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -802,10 +802,15 @@ sub cmt_metadata {
 
 sub working_head_info {
 	my ($head, $refs) = @_;
-	my ($fh, $ctx) = command_output_pipe('rev-list', $head);
-	while (my $hash = <$fh>) {
-		chomp($hash);
-		my ($url, $rev, $uuid) = cmt_metadata($hash);
+	my ($fh, $ctx) = command_output_pipe('log', $head);
+	my $hash;
+	while (<$fh>) {
+		if ( m{^commit ($::sha1)$} ) {
+			$hash = $1;
+			next;
+		}
+		next unless s{^\s+(git-svn-id:)}{$1};
+		my ($url, $rev, $uuid) = extract_metadata($_);
 		if (defined $url && defined $rev) {
 			if (my $gs = Git::SVN->find_by_url($url)) {
 				my $c = $gs->rev_db_get($rev);
@@ -1964,16 +1969,19 @@ sub rebuild {
 		return;
 	}
 	print "Rebuilding $db_path ...\n";
-	my ($rev_list, $ctx) = command_output_pipe("rev-list", $self->refname);
+	my ($log, $ctx) = command_output_pipe("log", $self->refname);
 	my $latest;
 	my $full_url = $self->full_url;
 	remove_username($full_url);
 	my $svn_uuid;
-	while (<$rev_list>) {
-		chomp;
-		my $c = $_;
-		die "Non-SHA1: $c\n" unless $c =~ /^$::sha1$/o;
-		my ($url, $rev, $uuid) = ::cmt_metadata($c);
+	my $c;
+	while (<$log>) {
+		if ( m{^commit ($::sha1)$} ) {
+			$c = $1;
+			next;
+		}
+		next unless s{^\s*(git-svn-id:)}{$1};
+		my ($url, $rev, $uuid) = ::extract_metadata($_);
 		remove_username($url);
 
 		# ignore merges (from set-tree)
@@ -1991,7 +1999,7 @@ sub rebuild {
 		$self->rev_db_set($rev, $c);
 		print "r$rev = $c\n";
 	}
-	command_close_pipe($rev_list, $ctx);
+	command_close_pipe($log, $ctx);
 	print "Done rebuilding $db_path\n";
 }
 
-- 
1.5.0.4.210.gf8a7c-dirty
