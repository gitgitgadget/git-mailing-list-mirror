From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 1/4] git-svn: bugfix and optimize the 'log' command
Date: Fri, 16 Jun 2006 10:57:23 -0700
Message-ID: <11504806472857-git-send-email-normalperson@yhbt.net>
References: <11504049343825-git-send-email-normalperson@yhbt.net> <11504806463470-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Jun 16 19:57:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrIZX-0006j0-KQ
	for gcvg-git@gmane.org; Fri, 16 Jun 2006 19:57:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbWFPR53 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Jun 2006 13:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbWFPR53
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jun 2006 13:57:29 -0400
Received: from hand.yhbt.net ([66.150.188.102]:10212 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751097AbWFPR52 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Jun 2006 13:57:28 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 859D27DC022;
	Fri, 16 Jun 2006 10:57:27 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri, 16 Jun 2006 10:57:27 -0700
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11504806463470-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21954>

Revisions with long commit messages were being skipped, since
the 'git-svn-id' metadata line was at the end and git-log uses a
32k buffer to print the commits.

Also the last 'git-svn-id' metadata line in a commit is always
the valid one, so make sure we use that, as well.

Made the verbose flag work by passing the correct option switch
('--summary') to git-log.

Finally, optimize -r/--revision argument handling by passing
the appropriate limits to revision

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 contrib/git-svn/git-svn.perl |   60 ++++++++++++++++++++++++++++++++++++------
 1 files changed, 52 insertions(+), 8 deletions(-)

diff --git a/contrib/git-svn/git-svn.perl b/contrib/git-svn/git-svn.perl
index 149149f..417fcf1 100755
--- a/contrib/git-svn/git-svn.perl
+++ b/contrib/git-svn/git-svn.perl
@@ -663,17 +663,15 @@ sub show_log {
 	my $pid = open(my $log,'-|');
 	defined $pid or croak $!;
 	if (!$pid) {
-		my @rl = (qw/git-log --abbrev-commit --pretty=raw
-				--default/, "remotes/$GIT_SVN");
-		push @rl, '--raw' if $_verbose;
-		exec(@rl, @args) or croak $!;
+		exec(git_svn_log_cmd($r_min,$r_max), @args) or croak $!;
 	}
 	setup_pager();
 	my (@k, $c, $d);
+
 	while (<$log>) {
 		if (/^commit ($sha1_short)/o) {
 			my $cmt = $1;
-			if ($c && defined $c->{r} && $c->{r} != $r_last) {
+			if ($c && cmt_showable($c) && $c->{r} != $r_last) {
 				$r_last = $c->{r};
 				process_commit($c, $r_min, $r_max, \@k) or
 								goto out;
@@ -692,8 +690,7 @@ sub show_log {
 		} elsif ($d) {
 			push @{$c->{diff}}, $_;
 		} elsif (/^    (git-svn-id:.+)$/) {
-			my ($url, $rev, $uuid) = extract_metadata($1);
-			$c->{r} = $rev;
+			(undef, $c->{r}, undef) = extract_metadata($1);
 		} elsif (s/^    //) {
 			push @{$c->{l}}, $_;
 		}
@@ -715,6 +712,52 @@ out:
 
 ########################### utility functions #########################
 
+sub cmt_showable {
+	my ($c) = @_;
+	return 1 if defined $c->{r};
+	if ($c->{l} && $c->{l}->[-1] eq "...\n" &&
+				$c->{a_raw} =~ /\@([a-f\d\-]+)>$/) {
+		my @msg = safe_qx(qw/git-cat-file commit/, $c->{c});
+		shift @msg while ($msg[0] ne "\n");
+		shift @msg;
+		@{$c->{l}} = grep !/^git-svn-id: /, @msg;
+
+		(undef, $c->{r}, undef) = extract_metadata(
+				(grep(/^git-svn-id: /, @msg))[-1]);
+	}
+	return defined $c->{r};
+}
+
+sub git_svn_log_cmd {
+	my ($r_min, $r_max) = @_;
+	my @cmd = (qw/git-log --abbrev-commit --pretty=raw
+			--default/, "refs/remotes/$GIT_SVN");
+	push @cmd, '--summary' if $_verbose;
+	return @cmd unless defined $r_max;
+	if ($r_max == $r_min) {
+		push @cmd, '--max-count=1';
+		if (my $c = revdb_get($REVDB, $r_max)) {
+			push @cmd, $c;
+		}
+	} else {
+		my ($c_min, $c_max);
+		$c_max = revdb_get($REVDB, $r_max);
+		$c_min = revdb_get($REVDB, $r_min);
+		if ($c_min && $c_max) {
+			if ($r_max > $r_max) {
+				push @cmd, "$c_min..$c_max";
+			} else {
+				push @cmd, "$c_max..$c_min";
+			}
+		} elsif ($r_max > $r_min) {
+			push @cmd, $c_max;
+		} else {
+			push @cmd, $c_min;
+		}
+	}
+	return @cmd;
+}
+
 sub fetch_child_id {
 	my $id = shift;
 	print "Fetching $id\n";
@@ -2206,6 +2249,7 @@ sub setup_pager { # translated to Perl f
 sub get_author_info {
 	my ($dest, $author, $t, $tz) = @_;
 	$author =~ s/(?:^\s*|\s*$)//g;
+	$dest->{a_raw} = $author;
 	my $_a;
 	if ($_authors) {
 		$_a = $rusers{$author} || undef;
@@ -2440,7 +2484,7 @@ sub svn_grab_base_rev {
 	close $fh;
 	if (defined $c && length $c) {
 		my ($url, $rev, $uuid) = extract_metadata((grep(/^git-svn-id: /,
-			safe_qx(qw/git-cat-file commit/, $c)))[0]);
+			safe_qx(qw/git-cat-file commit/, $c)))[-1]);
 		return ($rev, $c);
 	}
 	return (undef, undef);
-- 
1.4.0
