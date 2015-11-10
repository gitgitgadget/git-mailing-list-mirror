From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: improve rebase/mkdirs performance
Date: Tue, 10 Nov 2015 01:46:58 +0000
Message-ID: <20151110014658.GA17298@dcvr.yhbt.net>
References: <1446719175-9860-1-git-send-email-dair@feralinteractive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dair Grant <dair@feralinteractive.com>
X-From: git-owner@vger.kernel.org Tue Nov 10 02:54:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zvy8n-0005fN-DL
	for gcvg-git-2@plane.gmane.org; Tue, 10 Nov 2015 02:54:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbbKJBy3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2015 20:54:29 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:46564 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750727AbbKJBy2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2015 20:54:28 -0500
X-Greylist: delayed 449 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Nov 2015 20:54:28 EST
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id A18D11F4DD;
	Tue, 10 Nov 2015 01:46:58 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1446719175-9860-1-git-send-email-dair@feralinteractive.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281088>

Dair Grant <dair@feralinteractive.com> wrote:
> This takes 10 minutes to process when using a single hash, vs
> 3 seconds with a hash of hashes.
> 
> Signed-off-by: Dair Grant <dair@feralinteractive.com>

Thanks!  I've made some minor edits, will push the following out
to git://bogomips.org/git-svn.git for Junio to pull in a day
or so.

Btw, feel free to Cc: me on any git-(svn|Perl)-related stuff.  Likewise,
Cc: any regular contributor/maintainer on any subsystem you work on.  We
might not always answer, but appreciate being Cc:-ed anyways just in
case.

-------------------------- 8< ---------------------------
From: Dair Grant <dair@feralinteractive.com>
Subject: [PATCH] git-svn: improve rebase/mkdirs performance

Processing empty_dir directives becomes extremely slow for svn
repositories with a large enough history.

This is due to using a single hash to store the list of empty
directories, with the expensive step being purging items from
that hash using grep+delete.

Storing directories in a hash of hashes improves the performance
of this purge step and removes a potentially lengthy delay after
every rebase/mkdirs command.

The svn repository with this behaviour has 110K commits with
unhandled.log containing 170K empty_dir directives.

This takes 10 minutes to process when using a single hash, vs
3 seconds with a hash of hashes.

[ew: wrap comments, shorten initializations, avoid unnecessary spaces]

Signed-off-by: Dair Grant <dair@feralinteractive.com>
Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 perl/Git/SVN.pm | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 76 insertions(+), 8 deletions(-)

diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index 152fb7e..b2c14e2 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -1211,20 +1211,87 @@ sub do_fetch {
 sub mkemptydirs {
 	my ($self, $r) = @_;
 
+	# add/remove/collect a paths table
+	#
+	# Paths are split into a tree of nodes, stored as a hash of hashes.
+	#
+	# Each node contains a 'path' entry for the path (if any) associated
+	# with that node and a 'children' entry for any nodes under that
+	# location.
+	#
+	# Removing a path requires a hash lookup for each component then
+	# dropping that node (and anything under it), which is substantially
+	# faster than a grep slice into a single hash of paths for large
+	# numbers of paths.
+	#
+	# For a large (200K) number of empty_dir directives this reduces
+	# scanning time to 3 seconds vs 10 minutes for grep+delete on a single
+	# hash of paths.
+	sub add_path {
+		my ($paths_table, $path) = @_;
+		my $node_ref;
+
+		foreach my $x (split('/', $path)) {
+			if (!exists($paths_table->{$x})) {
+				$paths_table->{$x} = { children => {} };
+			}
+
+			$node_ref = $paths_table->{$x};
+			$paths_table = $paths_table->{$x}->{children};
+		}
+
+		$node_ref->{path} = $path;
+	}
+
+	sub remove_path {
+		my ($paths_table, $path) = @_;
+		my $nodes_ref;
+		my $node_name;
+
+		foreach my $x (split('/', $path)) {
+			if (!exists($paths_table->{$x})) {
+				return;
+			}
+
+			$nodes_ref = $paths_table;
+			$node_name = $x;
+
+			$paths_table = $paths_table->{$x}->{children};
+		}
+
+		delete($nodes_ref->{$node_name});
+	}
+
+	sub collect_paths {
+		my ($paths_table, $paths_ref) = @_;
+
+		foreach my $v (values %$paths_table) {
+			my $p = $v->{path};
+			my $c = $v->{children};
+
+			collect_paths($c, $paths_ref);
+
+			if (defined($p)) {
+				push(@$paths_ref, $p);
+			}
+		}
+	}
+
 	sub scan {
-		my ($r, $empty_dirs, $line) = @_;
+		my ($r, $paths_table, $line) = @_;
 		if (defined $r && $line =~ /^r(\d+)$/) {
 			return 0 if $1 > $r;
 		} elsif ($line =~ /^  \+empty_dir: (.+)$/) {
-			$empty_dirs->{$1} = 1;
+			add_path($paths_table, $1);
 		} elsif ($line =~ /^  \-empty_dir: (.+)$/) {
-			my @d = grep {m[^\Q$1\E(/|$)]} (keys %$empty_dirs);
-			delete @$empty_dirs{@d};
+			remove_path($paths_table, $1);
 		}
 		1; # continue
 	};
 
-	my %empty_dirs = ();
+	my @empty_dirs;
+	my %paths_table;
+
 	my $gz_file = "$self->{dir}/unhandled.log.gz";
 	if (-f $gz_file) {
 		if (!can_compress()) {
@@ -1235,7 +1302,7 @@ sub mkemptydirs {
 				die "Unable to open $gz_file: $!\n";
 			my $line;
 			while ($gz->gzreadline($line) > 0) {
-				scan($r, \%empty_dirs, $line) or last;
+				scan($r, \%paths_table, $line) or last;
 			}
 			$gz->gzclose;
 		}
@@ -1244,13 +1311,14 @@ sub mkemptydirs {
 	if (open my $fh, '<', "$self->{dir}/unhandled.log") {
 		binmode $fh or croak "binmode: $!";
 		while (<$fh>) {
-			scan($r, \%empty_dirs, $_) or last;
+			scan($r, \%paths_table, $_) or last;
 		}
 		close $fh;
 	}
 
+	collect_paths(\%paths_table, \@empty_dirs);
 	my $strip = qr/\A\Q@{[$self->path]}\E(?:\/|$)/;
-	foreach my $d (sort keys %empty_dirs) {
+	foreach my $d (sort @empty_dirs) {
 		$d = uri_decode($d);
 		$d =~ s/$strip//;
 		next unless length($d);
-- 
EW
