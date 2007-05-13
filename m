From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 1/2] git-svn: clean up caching of SVN::Ra functions
Date: Sun, 13 May 2007 01:04:43 -0700
Message-ID: <11790434841909-git-send-email-normalperson@yhbt.net>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 13 10:05:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hn95B-00046Z-Ga
	for gcvg-git@gmane.org; Sun, 13 May 2007 10:05:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757967AbXEMIEs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 04:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757939AbXEMIEs
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 04:04:48 -0400
Received: from hand.yhbt.net ([66.150.188.102]:53279 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757961AbXEMIEq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 04:04:46 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id E4E987DC0A3;
	Sun, 13 May 2007 01:04:44 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sun, 13 May 2007 01:04:44 -0700
X-Mailer: git-send-email 1.5.2.rc3.18.gf0c86
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47127>

This patch was originally intended to make the Perl GC more
sensitive to the SVN::Pool objects and not accidentally clean
them up when they shouldn't be (causing segfaults).  That didn't
work, but this patch makes the code a bit cleaner regardless

Put our caches for get_dir and check_path calls directly into
the SVN::Ra object so they auto-expire when it is destroyed.

dirents returned by get_dir() no longer needs the pool object
stored persistently along with the cache data, as they'll be
converted to native Perl hash references.

Since calling rev_proplist repeatedly per-revision is no longer
needed in git-svn, we do not cache calls to it.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |   68 +++++++++++++++++++++++++++++++++++----------------------
 1 files changed, 42 insertions(+), 26 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 2e80d41..ee69598 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1390,7 +1390,7 @@ sub traverse_ignore {
 		}
 	}
 	foreach (sort keys %$dirent) {
-		next if $dirent->{$_}->kind != $SVN::Node::dir;
+		next if $dirent->{$_}->{kind} != $SVN::Node::dir;
 		$self->traverse_ignore($fh, "$path/$_", $r);
 	}
 }
@@ -2888,7 +2888,7 @@ my ($can_do_switch, %ignored_err, $RA);
 BEGIN {
 	# enforce temporary pool usage for some simple functions
 	my $e;
-	foreach (qw/get_latest_revnum get_uuid get_repos_root/) {
+	foreach (qw/rev_proplist get_latest_revnum get_uuid get_repos_root/) {
 		$e .= "sub $_ {
 			my \$self = shift;
 			my \$pool = SVN::Pool->new;
@@ -2897,29 +2897,7 @@ BEGIN {
 			wantarray ? \@ret : \$ret[0]; }\n";
 	}
 
-	# get_dir needs $pool held in cache for dirents to work,
-	# check_path is cacheable and rev_proplist is close enough
-	# for our purposes.
-	foreach (qw/check_path get_dir rev_proplist/) {
-		$e .= "my \%${_}_cache; my \$${_}_rev = 0; sub $_ {
-			my \$self = shift;
-			my \$r = pop;
-			my \$k = join(\"\\0\", \@_);
-			if (my \$x = \$${_}_cache{\$r}->{\$k}) {
-				return wantarray ? \@\$x : \$x->[0];
-			}
-			my \$pool = SVN::Pool->new;
-			my \@ret = \$self->SUPER::$_(\@_, \$r, \$pool);
-			if (\$r != \$${_}_rev) {
-				\%${_}_cache = ( pool => [] );
-				\$${_}_rev = \$r;
-			}
-			\$${_}_cache{\$r}->{\$k} = \\\@ret;
-			push \@{\$${_}_cache{pool}}, \$pool;
-			wantarray ? \@ret : \$ret[0]; }\n";
-	}
-	$e .= "\n1;";
-	eval $e or die $@;
+	eval "$e; 1;" or die $@;
 }
 
 sub new {
@@ -2952,9 +2930,47 @@ sub new {
 	$self->{svn_path} = $url;
 	$self->{repos_root} = $self->get_repos_root;
 	$self->{svn_path} =~ s#^\Q$self->{repos_root}\E(/|$)##;
+	$self->{cache} = { check_path => { r => 0, data => {} },
+	                   get_dir => { r => 0, data => {} } };
 	$RA = bless $self, $class;
 }
 
+sub check_path {
+	my ($self, $path, $r) = @_;
+	my $cache = $self->{cache}->{check_path};
+	if ($r == $cache->{r} && exists $cache->{data}->{$path}) {
+		return $cache->{data}->{$path};
+	}
+	my $pool = SVN::Pool->new;
+	my $t = $self->SUPER::check_path($path, $r, $pool);
+	$pool->clear;
+	if ($r != $cache->{r}) {
+		%{$cache->{data}} = ();
+		$cache->{r} = $r;
+	}
+	$cache->{data}->{$path} = $t;
+}
+
+sub get_dir {
+	my ($self, $dir, $r) = @_;
+	my $cache = $self->{cache}->{get_dir};
+	if ($r == $cache->{r}) {
+		if (my $x = $cache->{data}->{$dir}) {
+			return wantarray ? @$x : $x->[0];
+		}
+	}
+	my $pool = SVN::Pool->new;
+	my ($d, undef, $props) = $self->SUPER::get_dir($dir, $r, $pool);
+	my %dirents = map { $_ => { kind => $d->{$_}->kind } } keys %$d;
+	$pool->clear;
+	if ($r != $cache->{r}) {
+		%{$cache->{data}} = ();
+		$cache->{r} = $r;
+	}
+	$cache->{data}->{$dir} = [ \%dirents, $r, $props ];
+	wantarray ? (\%dirents, $r, $props) : \%dirents;
+}
+
 sub DESTROY {
 	# do not call the real DESTROY since we store ourselves in $RA
 }
@@ -3175,7 +3191,7 @@ sub match_globs {
 		return unless scalar @x == 3;
 		my $dirents = $x[0];
 		foreach my $de (keys %$dirents) {
-			next if $dirents->{$de}->kind != $SVN::Node::dir;
+			next if $dirents->{$de}->{kind} != $SVN::Node::dir;
 			my $p = $g->{path}->full_path($de);
 			next if $exists->{$p};
 			next if (length $g->{path}->{right} &&
-- 
1.5.2.rc3.18.gf0c86
