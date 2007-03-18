From: Sam Vilain <sam@vilain.net>
Subject: Re: [wishlist] git branch -d -r remotename
Date: Sun, 18 Mar 2007 23:01:33 +1200
Message-ID: <20070318113210.5843E13A382@magnus.utsl.gen.nz>
References: <45FD0804.6010401@vilain.net> <20070318110507.5701413A382@magnus.utsl.gen.nz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 18 12:32:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HStch-0006qA-Of
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 12:32:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375AbXCRLcN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 07:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbXCRLcN
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 07:32:13 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:57717 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932375AbXCRLcM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 07:32:12 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 1003)
	id 5843E13A382; Sun, 18 Mar 2007 23:32:10 +1200 (NZST)
In-Reply-To: <20070318110507.5701413A382@magnus.utsl.gen.nz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42491>

One time again, this time with the call to porcelain command
`git-branch` replaced with the plumbing command `symbolic-ref HEAD`

I also changed the output to be a little less "Got here\n" style.

Subject: [PATCH] git-remote: implement prune -c

It would be nice to prune local refs which are irrelevant; add an
option to git-remote prune, with documentation.

Signed-off-by: Sam Vilain <sam@vilain.net>
---
 Documentation/git-remote.txt |    4 ++++
 git-remote.perl              |   29 +++++++++++++++++++++++++++--
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index ab04b86..7381b08 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -63,6 +63,10 @@ referenced by <name>, but are still locally available in
 With `-n` option, the remote heads are not confirmed first with `git
 ls-remote <name>`; cached information is used instead.  Use with
 caution.
++
+With `-c` option, all *local* branches that can be found via this
+remote are removed.  Useful for cleaning up old style remote branches,
+or temporary branches.
 
 'fetch'::
 
diff --git a/git-remote.perl b/git-remote.perl
index 20f9f54..0ed8a77 100755
--- a/git-remote.perl
+++ b/git-remote.perl
@@ -210,7 +210,7 @@ sub show_mapping {
 }
 
 sub prune_remote {
-	my ($name, $ls_remote) = @_;
+	my ($name, $ls_remote, $clean_local) = @_;
 	if (!exists $remote->{$name}) {
 		print STDERR "No such remote $name\n";
 		return;
@@ -224,6 +224,28 @@ sub prune_remote {
 		my @v = $git->command(qw(rev-parse --verify), "$prefix/$to_prune");
 		$git->command(qw(update-ref -d), "$prefix/$to_prune", $v[0]);
 	}
+	if ( $clean_local ) {
+		my @refs = map { (split " ")[0] }
+			$git->command(qw(for-each-ref), $prefix);
+		print "fetching revs for ".@refs." remote refs\n";
+		my %r = map { ($_ => undef) }
+			$git->command("rev-list", @refs);
+		print "fetched ".(keys %r)." revs\n";
+		my %l = map { (split " ")[2,0] }
+			$git->command(qw(for-each-ref refs/heads));
+		print "checking ".(keys %l)." local heads\n";
+
+		# don't delete the current branch
+		my ($checked_out) = $git->command(qw(symbolic-ref HEAD));
+
+		while ( my ($ref, $rev) = each %l ) {
+			next if $checked_out and $ref eq $checked_out;
+			if ( exists $r{$rev} ) {
+				print "$ref is obsolete\n";
+				$git->command(qw(update-ref -d), $ref, $rev);
+			}
+		}
+	}
 }
 
 sub show_remote {
@@ -344,6 +366,9 @@ elsif ($ARGV[0] eq 'prune') {
 		if ($ARGV[$i] eq '-n') {
 			$ls_remote = 0;
 		}
+		elsif ($ARGV[$i] eq '-c') {
+			$clean_local = 1;
+		}
 		else {
 			last;
 		}
@@ -353,7 +378,7 @@ elsif ($ARGV[0] eq 'prune') {
 		exit(1);
 	}
 	for (; $i < @ARGV; $i++) {
-		prune_remote($ARGV[$i], $ls_remote);
+		prune_remote($ARGV[$i], $ls_remote, $clean_local);
 	}
 }
 elsif ($ARGV[0] eq 'add') {
-- 
1.5.0.4.210.gf8a7c-dirty
