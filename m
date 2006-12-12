X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 1/3] git-svn: enable logging of information not supported by git
Date: Tue, 12 Dec 2006 14:47:00 -0800
Message-ID: <11659636223725-git-send-email-normalperson@yhbt.net>
NNTP-Posting-Date: Tue, 12 Dec 2006 22:47:31 +0000 (UTC)
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: git-send-email 1.4.4.2.g6f98
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34156>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuGPA-0007R3-7r for gcvg-git@gmane.org; Tue, 12 Dec
 2006 23:47:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932528AbWLLWrP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 17:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932533AbWLLWrP
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 17:47:15 -0500
Received: from hand.yhbt.net ([66.150.188.102]:54303 "EHLO hand.yhbt.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S932528AbWLLWrN
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006 17:47:13 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id 62EED7DC02A; Tue, 12 Dec 2006 14:47:11 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 12 Dec 2006
 14:47:02 -0800
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

The changes are now tracked in
  $GIT_DIR/svn/$GIT_SVN_ID/untracked.log

Information in the untracked.log include:
  * the addition and removal of empty directories
    (changes of these will also warn the user)
  * file and directory property changes, including (but not
    limited to) svk:merge and svn:externals
  * revision properties (revprops) are also tracked
  * users will be warned of 'absent' file and directories
    (if users are forbidden access)

Fields in entries are separated by spaces; "unsafe" characters
are URI-encoded so that each entry takes exactly one line.

There is currently no automated parser for dealing with the data
in untracked.log, but it should be possible to write one to
create empty directories on checkout and manage
externals/subprojects.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |  202 ++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 184 insertions(+), 18 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 1f8a3b0..06e89ff 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -21,6 +21,16 @@ $ENV{TZ} = 'UTC';
 $ENV{LC_ALL} = 'C';
 $| = 1; # unbuffer STDOUT
 
+# properties that we do not log:
+my %SKIP = ( 'svn:wc:ra_dav:version-url' => 1,
+             'svn:special' => 1,
+             'svn:executable' => 1,
+             'svn:entry:committed-rev' => 1,
+             'svn:entry:last-author' => 1,
+             'svn:entry:uuid' => 1,
+             'svn:entry:committed-date' => 1,
+);
+
 sub fatal (@) { print STDERR $@; exit 1 }
 # If SVN:: library support is added, please make the dependencies
 # optional and preserve the capability to use the command-line client.
@@ -2902,7 +2912,7 @@ sub libsvn_dup_ra {
 }
 
 sub libsvn_get_file {
-	my ($gui, $f, $rev, $chg) = @_;
+	my ($gui, $f, $rev, $chg, $untracked) = @_;
 	$f =~ s#^/##;
 	print "\t$chg\t$f\n" unless $_q;
 
@@ -2940,11 +2950,25 @@ sub libsvn_get_file {
 		waitpid $pid, 0;
 		$hash =~ /^$sha1$/o or die "not a sha1: $hash\n";
 	}
+	%{$untracked->{file_prop}->{$f}} = %$props;
 	print $gui $mode,' ',$hash,"\t",$f,"\0" or croak $!;
 }
 
+sub uri_encode {
+	my ($f) = @_;
+	$f =~ s#([^a-zA-Z0-9\*!\:_\./\-])#uc sprintf("%%%02x",ord($1))#eg;
+	$f
+}
+
+sub uri_decode {
+	my ($f) = @_;
+	$f =~ tr/+/ /;
+	$f =~ s/%([A-F0-9]{2})/chr hex($1)/ge;
+	$f
+}
+
 sub libsvn_log_entry {
-	my ($rev, $author, $date, $msg, $parents) = @_;
+	my ($rev, $author, $date, $msg, $parents, $untracked) = @_;
 	my ($Y,$m,$d,$H,$M,$S) = ($date =~ /^(\d{4})\-(\d\d)\-(\d\d)T
 					 (\d\d)\:(\d\d)\:(\d\d).\d+Z$/x)
 				or die "Unable to parse date: $date\n";
@@ -2952,8 +2976,65 @@ sub libsvn_log_entry {
 		die "Author: $author not defined in $_authors file\n";
 	}
 	$msg = '' if ($rev == 0 && !defined $msg);
-	return { revision => $rev, date => "+0000 $Y-$m-$d $H:$M:$S",
-		author => $author, msg => $msg."\n", parents => $parents || [] }
+
+	open my $un, '>>', "$GIT_SVN_DIR/unhandled.log" or croak $!;
+	my $h;
+	print $un "r$rev\n" or croak $!;
+	$h = $untracked->{empty};
+	foreach (sort keys %$h) {
+		my $act = $h->{$_} ? '+empty_dir' : '-empty_dir';
+		print $un "  $act: ", uri_encode($_), "\n" or croak $!;
+		warn "W: $act: $_\n";
+	}
+	foreach my $t (qw/dir_prop file_prop/) {
+		$h = $untracked->{$t} or next;
+		foreach my $path (sort keys %$h) {
+			my $ppath = $path eq '' ? '.' : $path;
+			foreach my $prop (sort keys %{$h->{$path}}) {
+				next if $SKIP{$prop};
+				my $v = $h->{$path}->{$prop};
+				if (defined $v) {
+					print $un "  +$t: ",
+						  uri_encode($ppath), ' ',
+						  uri_encode($prop), ' ',
+						  uri_encode($v), "\n"
+						  or croak $!;
+				} else {
+					print $un "  -$t: ",
+						  uri_encode($ppath), ' ',
+						  uri_encode($prop), "\n"
+						  or croak $!;
+				}
+			}
+		}
+	}
+	foreach my $t (qw/absent_file absent_directory/) {
+		$h = $untracked->{$t} or next;
+		foreach my $parent (sort keys %$h) {
+			foreach my $path (sort @{$h->{$parent}}) {
+				print $un "  $t: ",
+				      uri_encode("$parent/$path"), "\n"
+				      or croak $!;
+				warn "W: $t: $parent/$path ",
+				     "Insufficient permissions?\n";
+			}
+		}
+	}
+
+	# revprops (make this optional? it's an extra network trip...)
+	my $pool = SVN::Pool->new;
+	my $rp = $SVN->rev_proplist($rev, $pool);
+	foreach (sort keys %$rp) {
+		next if /^svn:(?:author|date|log)$/;
+		print $un "  rev_prop: ", uri_encode($_), ' ',
+		          uri_encode($rp->{$_}), "\n";
+	}
+	$pool->clear;
+	close $un or croak $!;
+
+	{ revision => $rev, date => "+0000 $Y-$m-$d $H:$M:$S",
+	  author => $author, msg => $msg."\n", parents => $parents || [],
+	  revprops => $rp }
 }
 
 sub process_rm {
@@ -2972,9 +3053,11 @@ sub process_rm {
 		}
 		print "\tD\t$f/\n" unless $q;
 		close $ls or croak $?;
+		return $SVN::Node::dir;
 	} else {
 		print $gui '0 ',0 x 40,"\t",$f,"\0" or croak $!;
 		print "\tD\t$f\n" unless $q;
+		return $SVN::Node::file;
 	}
 }
 
@@ -2995,13 +3078,14 @@ sub libsvn_fetch_delta {
 	unless ($ed->{git_commit_ok}) {
 		die "SVN connection failed somewhere...\n";
 	}
-	libsvn_log_entry($rev, $author, $date, $msg, [$last_commit]);
+	libsvn_log_entry($rev, $author, $date, $msg, [$last_commit], $ed);
 }
 
 sub libsvn_fetch_full {
 	my ($last_commit, $paths, $rev, $author, $date, $msg) = @_;
 	open my $gui, '| git-update-index -z --index-info' or croak $!;
 	my %amr;
+	my $ut = { empty => {}, dir_prop => {}, file_prop => {} };
 	my $p = $SVN->{svn_path};
 	foreach my $f (keys %$paths) {
 		my $m = $paths->{$f}->action();
@@ -3012,8 +3096,11 @@ sub libsvn_fetch_full {
 			$f =~ s#^/##;
 		}
 		if ($m =~ /^[DR]$/) {
-			process_rm($gui, $last_commit, $f, $_q);
-			next if $m eq 'D';
+			my $t = process_rm($gui, $last_commit, $f, $_q);
+			if ($m eq 'D') {
+				$ut->{empty}->{$f} = 0 if $t == $SVN::Node::dir;
+				next;
+			}
 			# 'R' can be file replacements, too, right?
 		}
 		my $pool = SVN::Pool->new;
@@ -3026,18 +3113,32 @@ sub libsvn_fetch_full {
 			}
 		} elsif ($t == $SVN::Node::dir && $m =~ /^[AR]$/) {
 			my @traversed = ();
-			libsvn_traverse($gui, '', $f, $rev, \@traversed);
-			foreach (@traversed) {
-				$amr{$_} = $m;
+			libsvn_traverse($gui, '', $f, $rev, \@traversed, $ut);
+			if (@traversed) {
+				foreach (@traversed) {
+					$amr{$_} = $m;
+				}
+			} else {
+				my ($dir, $file) = ($f =~ m#^(.*?)/?([^/]+)$#);
+				delete $ut->{empty}->{$dir};
+				$ut->{empty}->{$f} = 1;
 			}
 		}
 		$pool->clear;
 	}
 	foreach (keys %amr) {
-		libsvn_get_file($gui, $_, $rev, $amr{$_});
+		libsvn_get_file($gui, $_, $rev, $amr{$_}, $ut);
+		my ($d) = ($_ =~ m#^(.*?)/?(?:[^/]+)$#);
+		delete $ut->{empty}->{$d};
+	}
+	unless (exists $ut->{dir_prop}->{''}) {
+		my $pool = SVN::Pool->new;
+		my (undef, undef, $props) = $SVN->get_dir('', $rev, $pool);
+		%{$ut->{dir_prop}->{''}} = %$props;
+		$pool->clear;
 	}
 	close $gui or croak $?;
-	return libsvn_log_entry($rev, $author, $date, $msg, [$last_commit]);
+	libsvn_log_entry($rev, $author, $date, $msg, [$last_commit], $ut);
 }
 
 sub svn_grab_base_rev {
@@ -3098,25 +3199,38 @@ sub libsvn_parse_revision {
 }
 
 sub libsvn_traverse {
-	my ($gui, $pfx, $path, $rev, $files) = @_;
+	my ($gui, $pfx, $path, $rev, $files, $untracked) = @_;
 	my $cwd = length $pfx ? "$pfx/$path" : $path;
 	my $pool = SVN::Pool->new;
 	$cwd =~ s#^\Q$SVN->{svn_path}\E##;
+	my $nr = 0;
 	my ($dirent, $r, $props) = $SVN->get_dir($cwd, $rev, $pool);
+	%{$untracked->{dir_prop}->{$cwd}} = %$props;
 	foreach my $d (keys %$dirent) {
 		my $t = $dirent->{$d}->kind;
 		if ($t == $SVN::Node::dir) {
-			libsvn_traverse($gui, $cwd, $d, $rev, $files);
+			my $i = libsvn_traverse($gui, $cwd, $d, $rev,
+			                        $files, $untracked);
+			if ($i) {
+				$nr += $i;
+			} else {
+				$untracked->{empty}->{"$cwd/$d"} = 1;
+			}
 		} elsif ($t == $SVN::Node::file) {
+			$nr++;
 			my $file = "$cwd/$d";
 			if (defined $files) {
 				push @$files, $file;
 			} else {
-				libsvn_get_file($gui, $file, $rev, 'A');
+				libsvn_get_file($gui, $file, $rev, 'A',
+				                $untracked);
+				my ($dir) = ($file =~ m#^(.*?)/?(?:[^/]+)$#);
+				delete $untracked->{empty}->{$dir};
 			}
 		}
 	}
 	$pool->clear;
+	$nr;
 }
 
 sub libsvn_traverse_ignore {
@@ -3255,6 +3369,7 @@ sub libsvn_new_tree {
 		return $log_entry;
 	}
 	my ($paths, $rev, $author, $date, $msg) = @_;
+	my $ut;
 	if ($_xfer_delta) {
 		my $pool = SVN::Pool->new;
 		my $ed = SVN::Git::Fetcher->new({q => $_q});
@@ -3266,12 +3381,14 @@ sub libsvn_new_tree {
 		unless ($ed->{git_commit_ok}) {
 			die "SVN connection failed somewhere...\n";
 		}
+		$ut = $ed;
 	} else {
+		$ut = { empty => {}, dir_prop => {}, file_prop => {} };
 		open my $gui, '| git-update-index -z --index-info' or croak $!;
-		libsvn_traverse($gui, '', $SVN->{svn_path}, $rev);
+		libsvn_traverse($gui, '', $SVN->{svn_path}, $rev, undef, $ut);
 		close $gui or croak $?;
 	}
-	return libsvn_log_entry($rev, $author, $date, $msg);
+	libsvn_log_entry($rev, $author, $date, $msg, [], $ut);
 }
 
 sub find_graft_path_commit {
@@ -3456,13 +3573,28 @@ sub new {
 	$self->{gui} = $gui;
 	$self->{c} = $git_svn->{c} if exists $git_svn->{c};
 	$self->{q} = $git_svn->{q};
+	$self->{empty} = {};
+	$self->{dir_prop} = {};
+	$self->{file_prop} = {};
+	$self->{absent_dir} = {};
+	$self->{absent_file} = {};
 	require Digest::MD5;
 	$self;
 }
 
+sub open_root {
+	{ path => '' };
+}
+
+sub open_directory {
+	my ($self, $path, $pb, $rev) = @_;
+	{ path => $path };
+}
+
 sub delete_entry {
 	my ($self, $path, $rev, $pb) = @_;
-	process_rm($self->{gui}, $self->{c}, $path, $self->{q});
+	my $t = process_rm($self->{gui}, $self->{c}, $path, $self->{q});
+	$self->{empty}->{$path} = 0 if $t == $SVN::Node::dir;
 	undef;
 }
 
@@ -3479,10 +3611,41 @@ sub open_file {
 
 sub add_file {
 	my ($self, $path, $pb, $cp_path, $cp_rev) = @_;
+	my ($dir, $file) = ($path =~ m#^(.*?)/?([^/]+)$#);
+	delete $self->{empty}->{$dir};
 	{ path => $path, mode_a => 100644, mode_b => 100644,
 	  pool => SVN::Pool->new, action => 'A' };
 }
 
+sub add_directory {
+	my ($self, $path, $cp_path, $cp_rev) = @_;
+	my ($dir, $file) = ($path =~ m#^(.*?)/?([^/]+)$#);
+	delete $self->{empty}->{$dir};
+	$self->{empty}->{$path} = 1;
+	{ path => $path };
+}
+
+sub change_dir_prop {
+	my ($self, $db, $prop, $value) = @_;
+	$self->{dir_prop}->{$db->{path}} ||= {};
+	$self->{dir_prop}->{$db->{path}}->{$prop} = $value;
+	undef;
+}
+
+sub absent_directory {
+	my ($self, $path, $pb) = @_;
+	$self->{absent_dir}->{$pb->{path}} ||= [];
+	push @{$self->{absent_dir}->{$pb->{path}}}, $path;
+	undef;
+}
+
+sub absent_file {
+	my ($self, $path, $pb) = @_;
+	$self->{absent_file}->{$pb->{path}} ||= [];
+	push @{$self->{absent_file}->{$pb->{path}}}, $path;
+	undef;
+}
+
 sub change_file_prop {
 	my ($self, $fb, $prop, $value) = @_;
 	if ($prop eq 'svn:executable') {
@@ -3491,6 +3654,9 @@ sub change_file_prop {
 		}
 	} elsif ($prop eq 'svn:special') {
 		$fb->{mode_b} = defined $value ? 120000 : 100644;
+	} else {
+		$self->{file_prop}->{$fb->{path}} ||= {};
+		$self->{file_prop}->{$fb->{path}}->{$prop} = $value;
 	}
 	undef;
 }
-- 
1.4.4.2.g6f98
