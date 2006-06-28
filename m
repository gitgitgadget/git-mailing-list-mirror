From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 5/5] git-svn: be verbose by default on fetch/commit, add -q/--quiet option
Date: Tue, 27 Jun 2006 19:39:14 -0700
Message-ID: <11514623622980-git-send-email-normalperson@yhbt.net>
References: <11514623542848-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Jun 28 04:39:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvPxl-0007c1-RF
	for gcvg-git@gmane.org; Wed, 28 Jun 2006 04:39:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422926AbWF1CjZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Jun 2006 22:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422930AbWF1CjZ
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jun 2006 22:39:25 -0400
Received: from hand.yhbt.net ([66.150.188.102]:28375 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1422929AbWF1CjX (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jun 2006 22:39:23 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 260F47DC026;
	Tue, 27 Jun 2006 19:39:22 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 27 Jun 2006 19:39:22 -0700
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.1.rc1.g3cc8
In-Reply-To: <11514623542848-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22769>

Slower connections can make git-svn look as if it's doing
nothing for a long time; leaving the user wondering if we're
actually doing anything.  Now we print some file progress just
to assure the user that something is going on while they're
waiting.

Added the -q/--quiet option to users to revert to the old method
if they preferred it.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 contrib/git-svn/git-svn.perl |   34 +++++++++++++++++++++++-----------
 1 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/contrib/git-svn/git-svn.perl b/contrib/git-svn/git-svn.perl
index 33fd82a..464d94e 100755
--- a/contrib/git-svn/git-svn.perl
+++ b/contrib/git-svn/git-svn.perl
@@ -46,7 +46,7 @@ my $sha1 = qr/[a-f\d]{40}/;
 my $sha1_short = qr/[a-f\d]{4,40}/;
 my ($_revision,$_stdin,$_no_ignore_ext,$_no_stop_copy,$_help,$_rmdir,$_edit,
 	$_find_copies_harder, $_l, $_cp_similarity, $_cp_remote,
-	$_repack, $_repack_nr, $_repack_flags,
+	$_repack, $_repack_nr, $_repack_flags, $_q,
 	$_message, $_file, $_follow_parent, $_no_metadata,
 	$_template, $_shared, $_no_default_regex, $_no_graft_copy,
 	$_limit, $_verbose, $_incremental, $_oneline, $_l_fmt, $_show_commit,
@@ -62,6 +62,7 @@ my %fc_opts = ( 'no-ignore-externals' =>
 		'authors-file|A=s' => \$_authors,
 		'repack:i' => \$_repack,
 		'no-metadata' => \$_no_metadata,
+		'quiet|q' => \$_q,
 		'repack-flags|repack-args|repack-opts=s' => \$_repack_flags);
 
 my ($_trunk, $_tags, $_branches);
@@ -1457,12 +1458,12 @@ sub libsvn_checkout_tree {
 	foreach my $m (sort { $o{$a->{chg}} <=> $o{$b->{chg}} } @$mods) {
 		my $f = $m->{chg};
 		if (defined $o{$f}) {
-			$ed->$f($m);
+			$ed->$f($m, $_q);
 		} else {
 			croak "Invalid change type: $f\n";
 		}
 	}
-	$ed->rmdirs if $_rmdir;
+	$ed->rmdirs($_q) if $_rmdir;
 	return $mods;
 }
 
@@ -2688,6 +2689,7 @@ sub libsvn_fetch {
 		my $m = $paths->{$f}->action();
 		$f =~ s#^/+##;
 		if ($m =~ /^[DR]$/) {
+			print "\t$m\t$f\n" unless $_q;
 			process_rm($gui, $last_commit, $f);
 			next if $m eq 'D';
 			# 'R' can be file replacements, too, right?
@@ -2696,14 +2698,17 @@ sub libsvn_fetch {
 		my $t = $SVN->check_path($f, $rev, $pool);
 		if ($t == $SVN::Node::file) {
 			if ($m =~ /^[AMR]$/) {
-				push @amr, $f;
+				push @amr, [ $m, $f ];
 			} else {
 				die "Unrecognized action: $m, ($f r$rev)\n";
 			}
 		}
 		$pool->clear;
 	}
-	libsvn_get_file($gui, $_, $rev) foreach (@amr);
+	foreach (@amr) {
+		print "\t$_->[0]\t$_->[1]\n" unless $_q;
+		libsvn_get_file($gui, $_->[1], $rev)
+	}
 	close $gui or croak $?;
 	return libsvn_log_entry($rev, $author, $date, $msg, [$last_commit]);
 }
@@ -2776,6 +2781,7 @@ sub libsvn_traverse {
 		if ($t == $SVN::Node::dir) {
 			libsvn_traverse($gui, $cwd, $d, $rev);
 		} elsif ($t == $SVN::Node::file) {
+			print "\tA\t$cwd/$d\n" unless $_q;
 			libsvn_get_file($gui, "$cwd/$d", $rev);
 		}
 	}
@@ -3105,7 +3111,7 @@ sub url_path {
 }
 
 sub rmdirs {
-	my ($self) = @_;
+	my ($self, $q) = @_;
 	my $rm = $self->{rm};
 	delete $rm->{''}; # we never delete the url we're tracking
 	return unless %$rm;
@@ -3146,6 +3152,7 @@ sub rmdirs {
 	foreach my $d (sort { $b =~ tr#/#/# <=> $a =~ tr#/#/# } keys %$rm) {
 		$self->close_directory($bat->{$d}, $p);
 		my ($dn) = ($d =~ m#^(.*?)/?(?:[^/]+)$#);
+		print "\tD+\t/$d/\n" unless $q;
 		$self->SUPER::delete_entry($d, $r, $bat->{$dn}, $p);
 		delete $bat->{$d};
 	}
@@ -3186,21 +3193,23 @@ sub ensure_path {
 }
 
 sub A {
-	my ($self, $m) = @_;
+	my ($self, $m, $q) = @_;
 	my ($dir, $file) = split_path($m->{file_b});
 	my $pbat = $self->ensure_path($dir);
 	my $fbat = $self->add_file($self->repo_path($m->{file_b}), $pbat,
 					undef, -1);
+	print "\tA\t$m->{file_b}\n" unless $q;
 	$self->chg_file($fbat, $m);
 	$self->close_file($fbat,undef,$self->{pool});
 }
 
 sub C {
-	my ($self, $m) = @_;
+	my ($self, $m, $q) = @_;
 	my ($dir, $file) = split_path($m->{file_b});
 	my $pbat = $self->ensure_path($dir);
 	my $fbat = $self->add_file($self->repo_path($m->{file_b}), $pbat,
 				$self->url_path($m->{file_a}), $self->{r});
+	print "\tC\t$m->{file_a} => $m->{file_b}\n" unless $q;
 	$self->chg_file($fbat, $m);
 	$self->close_file($fbat,undef,$self->{pool});
 }
@@ -3214,11 +3223,12 @@ sub delete_entry {
 }
 
 sub R {
-	my ($self, $m) = @_;
+	my ($self, $m, $q) = @_;
 	my ($dir, $file) = split_path($m->{file_b});
 	my $pbat = $self->ensure_path($dir);
 	my $fbat = $self->add_file($self->repo_path($m->{file_b}), $pbat,
 				$self->url_path($m->{file_a}), $self->{r});
+	print "\tR\t$m->{file_a} => $m->{file_b}\n" unless $q;
 	$self->chg_file($fbat, $m);
 	$self->close_file($fbat,undef,$self->{pool});
 
@@ -3228,11 +3238,12 @@ sub R {
 }
 
 sub M {
-	my ($self, $m) = @_;
+	my ($self, $m, $q) = @_;
 	my ($dir, $file) = split_path($m->{file_b});
 	my $pbat = $self->ensure_path($dir);
 	my $fbat = $self->open_file($self->repo_path($m->{file_b}),
 				$pbat,$self->{r},$self->{pool});
+	print "\t$m->{chg}\t$m->{file_b}\n" unless $q;
 	$self->chg_file($fbat, $m);
 	$self->close_file($fbat,undef,$self->{pool});
 }
@@ -3281,9 +3292,10 @@ sub chg_file {
 }
 
 sub D {
-	my ($self, $m) = @_;
+	my ($self, $m, $q) = @_;
 	my ($dir, $file) = split_path($m->{file_b});
 	my $pbat = $self->ensure_path($dir);
+	print "\tD\t$m->{file_b}\n" unless $q;
 	$self->delete_entry($m->{file_b}, $pbat);
 }
 
-- 
1.4.1.rc1.g3cc8
