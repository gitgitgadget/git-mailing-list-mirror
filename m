From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH (WIP)] git-svn: cache SVN::Ra functions in a more Perl GC-friendly way
Date: Tue, 17 Apr 2007 02:40:00 -0700
Message-ID: <20070417094000.GA2778@muzzle>
References: <4623F613.5010108@midwinter.com> <20070417093743.GA9222@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 11:40:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdkAR-0002OR-RB
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 11:40:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753105AbXDQJkE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 05:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753109AbXDQJkE
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 05:40:04 -0400
Received: from hand.yhbt.net ([66.150.188.102]:54785 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753105AbXDQJkC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 05:40:02 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 6A95B7DC0A0;
	Tue, 17 Apr 2007 02:40:00 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 17 Apr 2007 02:40:00 -0700
Content-Disposition: inline
In-Reply-To: <20070417093743.GA9222@muzzle>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44748>

The dirent hash objects returned by get_dir() rely on the
temporary pool allocated within our wrapper function itself.
Apparently pushing the pool into global storage that was used in
its creation does not seem to be enough to avoid it from being
garbage-collected; so duplicate that into a plain-old nested
hash...

This should not cause data from imports to be corrupted, as
get_dir is only used between the fetching of revisions and not
the revision data itself.  The memory usage done during the
actual data fetches (which is checksummed) only relies on newly
allocated pools.

Also, put our caches for get_dir and check_path calls directly
into the SVN::Ra object so they auto-expire when it is
destroyed.

Since calling rev_proplist repeatedly per-revision is no longer
needed in git-svn, we do not cache calls to it.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |   68 +++++++++++++++++++++++++++++++++++----------------------
 1 files changed, 42 insertions(+), 26 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 7ebd07b..eb3b79c 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1360,7 +1360,7 @@ sub traverse_ignore {
 		}
 	}
 	foreach (sort keys %$dirent) {
-		next if $dirent->{$_}->kind != $SVN::Node::dir;
+		next if $dirent->{$_}->{kind} != $SVN::Node::dir;
 		$self->traverse_ignore($fh, "$path/$_", $r);
 	}
 }
@@ -2855,7 +2855,7 @@ my ($can_do_switch, %ignored_err, $RA);
 BEGIN {
 	# enforce temporary pool usage for some simple functions
 	my $e;
-	foreach (qw/get_latest_revnum get_uuid get_repos_root/) {
+	foreach (qw/rev_proplist get_latest_revnum get_uuid get_repos_root/) {
 		$e .= "sub $_ {
 			my \$self = shift;
 			my \$pool = SVN::Pool->new;
@@ -2864,29 +2864,7 @@ BEGIN {
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
@@ -2919,9 +2897,47 @@ sub new {
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
@@ -3136,7 +3152,7 @@ sub match_globs {
 		return unless scalar @x == 3;
 		my $dirents = $x[0];
 		foreach my $de (keys %$dirents) {
-			next if $dirents->{$de}->kind != $SVN::Node::dir;
+			next if $dirents->{$de}->{kind} != $SVN::Node::dir;
 			my $p = $g->{path}->full_path($de);
 			next if $exists->{$p};
 			next if (length $g->{path}->{right} &&
-- 
Eric Wong
