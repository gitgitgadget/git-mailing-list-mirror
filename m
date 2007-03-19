From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: (unknown)
Date: Tue, 20 Mar 2007 11:37:01 +1200
Message-ID: <20070319234722.CF1FF13A382@magnus.utsl.gen.nz>
References: <45FD0804.6010401@vilain.net>
	<20070318110507.5701413A382@magnus.utsl.gen.nz>
	<20070318113210.5843E13A382@magnus.utsl.gen.nz>
	<7vvegyl4nt.fsf@assigned-by-dhcp.cox.net> <45FDB322.10904@vilain.net>
	<7v8xdtkb7p.fsf@assigned-by-dhcp.cox.net>
	<7v4pohka7g.fsf@assigned-by-dhcp.cox.net>
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 20 00:47:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTRZZ-0001Ms-Mm
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 00:47:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965337AbXCSXr0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 19:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965509AbXCSXr0
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 19:47:26 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:36597 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965337AbXCSXrZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 19:47:25 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 1003)
	id CF1FF13A382; Tue, 20 Mar 2007 11:47:22 +1200 (NZST)
In-Reply-To: <7v4pohka7g.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42683>

Junio C Hamano wrote:
> If you want to see if A is an ancestor of
> any of B C D..., the standard and most efficient way to do so is
> with rev-list.
>
> 	git rev-list A --not B C D...
>
> will show _nothing_ only when A is an ancestor of one (or more)
> of B C D..., so you invoke it and upon getting the first line of
> output you declare A cannot be removed without reading the
> remainder of the output.

Sure.  I figured the commands I put would only use about 30MB for a
300,000 commit repository, so it wouldn't be too bad.  But I didn't
think of that.

Here we go, also based upon 'next' rather than the result of my
previous patches of the day.

Subject: [PATCH] git-remote: implement prune -c

It would be nice to be able to prune local refs which just point to
some place in the remote; add an option to git-remote prune, with
documentation.

Signed-off-by: Sam Vilain <sam.vilain@catalyst.net.nz>
---
 Documentation/git-remote.txt |    5 +++++
 git-remote.perl              |   25 +++++++++++++++++++++++--
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index f96b304..6a28e6c 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -54,6 +54,11 @@ Gives some information about the remote <name>.
 Deletes all stale tracking branches under <name>.
 These stale branches have already been removed from the remote repository
 referenced by <name>, but are still locally available in "remotes/<name>".
++
+With `-c` option, all *local* branches that exist in the history of
+any of the mirrored heads from the remote are removed.  This is useful
+for discarding temporary local branches that you did not make any
+commits to.
 
 
 DISCUSSION
diff --git a/git-remote.perl b/git-remote.perl
index 670bafb..84ac534 100755
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
@@ -224,6 +224,24 @@ sub prune_remote {
 		my @v = $git->command(qw(rev-parse --verify), "$prefix/$to_prune");
 		$git->command(qw(update-ref -d), "$prefix/$to_prune", $v[0]);
 	}
+	if ( $clean_local ) {
+		my @remote = map { (split " ")[0] }
+			$git->command(qw(for-each-ref), $prefix);
+		my %local = map { (split " ")[2,0] }
+			$git->command(qw(for-each-ref refs/heads));
+		my %not_remote = map { ($_ => undef) }
+			$git->command("rev-list", keys %local, "--not", @remote);
+		# don't delete the current branch
+		my ($checked_out) = $git->command(qw(symbolic-ref HEAD));
+
+		while ( my ($ref, $rev) = each %local ) {
+			next if $checked_out and $ref eq $checked_out;
+			if ( not exists $not_remote{$rev} ) {
+				print "$ref is obsolete\n";
+				$git->command(qw(update-ref -d), $ref, $rev);
+			}
+		}
+	}
 }
 
 sub show_remote {
@@ -310,6 +328,9 @@ elsif ($ARGV[0] eq 'prune') {
 		if ($ARGV[$i] eq '-n') {
 			$ls_remote = 0;
 		}
+		elsif ($ARGV[$i] eq '-c') {
+			$clean_local = 1;
+		}
 		else {
 			last;
 		}
@@ -319,7 +340,7 @@ elsif ($ARGV[0] eq 'prune') {
 		exit(1);
 	}
 	for (; $i < @ARGV; $i++) {
-		prune_remote($ARGV[$i], $ls_remote);
+		prune_remote($ARGV[$i], $ls_remote, $clean_local);
 	}
 }
 elsif ($ARGV[0] eq 'add') {
-- 
1.5.0.2.214.gb318
