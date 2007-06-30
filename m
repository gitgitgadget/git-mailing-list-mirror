From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH] git-svn: use git-log rather than rev-list | xargs cat-file
Date: Sat, 30 Jun 2007 20:56:13 +1200
Message-ID: <11831937822346-git-send-email-sam.vilain@catalyst.net.nz>
References: <1183193781941-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937813223-git-send-email-sam.vilain@catalyst.net.nz>
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>,
	Sam Vilain <sam.vilain@catalyst.net.nz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 30 10:57:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4YlM-0006AV-8P
	for gcvg-git@gmane.org; Sat, 30 Jun 2007 10:57:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753819AbXF3I4i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 04:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753836AbXF3I4i
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 04:56:38 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:56643 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753700AbXF3I40 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 04:56:26 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=localhost.localdomain)
	by mail1.catalyst.net.nz with esmtp (Exim 4.50)
	id 1I4Ykg-0008Tx-9g; Sat, 30 Jun 2007 20:56:22 +1200
Received: by localhost.localdomain (Postfix, from userid 1000)
	id 437E15CE00; Sat, 30 Jun 2007 20:56:22 +1200 (NZST)
X-Mailer: git-send-email 1.5.2.1.1131.g3b90-dirty
In-Reply-To: <11831937813223-git-send-email-sam.vilain@catalyst.net.nz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51203>

From: Sam Vilain <sam@vilain.net>

This saves a bit of time when rebuilding the git-svn index.

Signed-off-by: Sam Vilain <sam.vilain@catalyst.net.nz>
---
 git-svn.perl |   36 ++++++++++++++++++++++--------------
 1 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 3033b50..556cd7d 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -782,12 +782,12 @@ sub read_repo_config {
 
 sub extract_metadata {
 	my $id = shift or return (undef, undef, undef);
-	my ($url, $rev, $uuid) = ($id =~ /^git-svn-id:\s(\S+?)\@(\d+)
+	my ($url, $rev, $uuid) = ($id =~ /^\s*git-svn-id:\s+(.*)\@(\d+)
 							\s([a-f\d\-]+)$/x);
 	if (!defined $rev || !$uuid || !$url) {
 		# some of the original repositories I made had
 		# identifiers like this:
-		($rev, $uuid) = ($id =~/^git-svn-id:\s(\d+)\@([a-f\d\-]+)/);
+		($rev, $uuid) = ($id =~/^\s*git-svn-id:\s(\d+)\@([a-f\d\-]+)/);
 	}
 	return ($url, $rev, $uuid);
 }
@@ -799,10 +799,16 @@ sub cmt_metadata {
 
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
+			unshift @$refs, $hash if $hash and $refs;
+			$hash = $1;
+			next;
+		}
+		next unless s{^\s*(git-svn-id:)}{$1};
+		my ($url, $rev, $uuid) = extract_metadata($_);
 		if (defined $url && defined $rev) {
 			if (my $gs = Git::SVN->find_by_url($url)) {
 				my $c = $gs->rev_db_get($rev);
@@ -812,7 +818,6 @@ sub working_head_info {
 				}
 			}
 		}
-		unshift @$refs, $hash if $refs;
 	}
 	command_close_pipe($fh, $ctx);
 	(undef, undef, undef, undef);
@@ -2019,16 +2024,19 @@ sub rebuild {
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
@@ -2046,7 +2054,7 @@ sub rebuild {
 		$self->rev_db_set($rev, $c);
 		print "r$rev = $c\n";
 	}
-	command_close_pipe($rev_list, $ctx);
+	command_close_pipe($log, $ctx);
 	print "Done rebuilding $db_path\n";
 }
 
-- 
1.5.2.1.1131.g3b90
