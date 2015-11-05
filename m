From: Dair Grant <dair@feralinteractive.com>
Subject: [PATCH] git-svn: improve rebase/mkdirs performance
Date: Thu,  5 Nov 2015 10:26:15 +0000
Message-ID: <1446719175-9860-1-git-send-email-dair@feralinteractive.com>
Cc: Dair Grant <dair@feralinteractive.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 05 11:26:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuHkR-0004Qd-1e
	for gcvg-git-2@plane.gmane.org; Thu, 05 Nov 2015 11:26:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031170AbbKEK0X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2015 05:26:23 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37364 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031105AbbKEK0V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2015 05:26:21 -0500
Received: by wmll128 with SMTP id l128so9217668wml.0
        for <git@vger.kernel.org>; Thu, 05 Nov 2015 02:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=feralinteractive_com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=y+ZLCzydpZaWhfGrTaJ+Y0BgTOZwgqE5NCyIXKEVTUo=;
        b=ybcXMRWav+Q7xcIz62luKLhJqQBaSBpQSoxBCOTWZzqoQ/p0AQt06hLmJ2C6Jaxbl8
         Q4UI9c3zaaCVFECzR+apRWOlB/j+hMecl+mCxIINe7gxImxlZmzZ504cJYKRM325QzcK
         I7GelixmMg0ZpmdbKsbzju+jUHS3y56aQ8gHhc6QVPGRUklsH3qvjFF6+NrBBRtMu9R7
         dRBcHeUO8T74I9f7b9iix3L/lds5abmOf1ZRp/RIGR/tfZTkYCC/OCDiScZYzMp9qQLT
         HTex/hW23bSD55Vtck9F7hKViN7D9XcWWoCQS4bmXfplUZ2T6iVUQoBm0FdToIZssTpX
         PtkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=y+ZLCzydpZaWhfGrTaJ+Y0BgTOZwgqE5NCyIXKEVTUo=;
        b=gKzL7XFFKRxg6oOLuogkuaKTqyttyGmEcbRLeMyd4VnhhMOgJJmjRgad3+nqyWf4dX
         nqTzThxbwvPIILpf9dvd9vDDrFPZl3coIpdG076JyrD4R1UehOTzvRCS5jiUVOaVmgfV
         oj9LtNJynYMIxKew77UzLXIohfOjJjALcm8O7/iaPdX0qJx9omVW4MOBzpgz4eq6Aped
         iLn4W/d2xapSLx/rKk3SQWQv1Rn73Y9OwkbL37L7F7g5wXBfOKzlG7Mmp/SEFniYjqBQ
         Uq+WHu5c7OtilABkjERL6wYqKwqQCRTkH44G6pNgBvicPEMw0k4/uk2IKl7dTjAswqDm
         LjuQ==
X-Gm-Message-State: ALoCoQkBRPlnn9oRtCN6uLm+JF2FoSHXN9rATsCuPETmarx/fQXhiD112lpisTFRZH99xO/L3DNK
X-Received: by 10.28.11.71 with SMTP id 68mr2746286wml.77.1446719179916;
        Thu, 05 Nov 2015 02:26:19 -0800 (PST)
Received: from localhost.localdomain ([80.71.2.213])
        by smtp.gmail.com with ESMTPSA id 184sm7635305wmk.10.2015.11.05.02.26.19
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Nov 2015 02:26:19 -0800 (PST)
X-Mailer: git-send-email 2.6.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280919>

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

Signed-off-by: Dair Grant <dair@feralinteractive.com>
---
 perl/Git/SVN.pm | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 74 insertions(+), 8 deletions(-)

diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index 152fb7e..ebbdd37 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -1211,20 +1211,85 @@ sub do_fetch {
 sub mkemptydirs {
 	my ($self, $r) = @_;
 
+	# add/remove/collect a paths table
+	#
+	# Paths are split into a tree of nodes, stored as a hash of hashes.
+	#
+	# Each node contains a 'path' entry for the path (if any) associated with
+	# that node and a 'children' entry for any nodes under that location.
+	#
+	# Removing a path requires a hash lookup for each component then dropping
+	# that node (and anything under it), which is substantially faster than a
+	# grep slice into a single hash of paths for large numbers of paths.
+	#
+	# For a large (200K) number of empty_dir directives this reduces scanning
+	# time to 3 seconds vs 10 minutes for grep+delete on a single hash of paths.
+	sub add_path {
+		my ($paths_table, $path) = @_;
+		my $node_ref = undef;
+
+		foreach my $x (split('/', $path)) {
+			if (!exists($paths_table->{$x})) {
+				$paths_table->{$x}             = {};
+				$paths_table->{$x}{"children"} = {};
+			}
+
+			$node_ref    = $paths_table->{$x};
+			$paths_table = $paths_table->{$x}{"children"};
+		}
+
+		$node_ref->{"path"} = $path;
+	}
+
+	sub remove_path {
+		my ($paths_table, $path) = @_;
+		my $nodes_ref = undef;
+		my $node_name = undef;
+
+		foreach my $x (split('/', $path)) {
+			if (!exists($paths_table->{$x})) {
+				return;
+			}
+
+			$nodes_ref = $paths_table;
+			$node_name = $x;
+
+			$paths_table = $paths_table->{$x}{"children"};
+		}
+	
+		delete($nodes_ref->{$node_name});
+	}
+
+	sub collect_paths {
+		my ($paths_table, $paths_ref) = @_;
+
+		foreach my $v (values %$paths_table) {
+			my $p = $v->{"path"};
+			my $c = $v->{"children"};
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
+	my @empty_dirs  = ();
+	my %paths_table = ();
+
 	my $gz_file = "$self->{dir}/unhandled.log.gz";
 	if (-f $gz_file) {
 		if (!can_compress()) {
@@ -1235,7 +1300,7 @@ sub mkemptydirs {
 				die "Unable to open $gz_file: $!\n";
 			my $line;
 			while ($gz->gzreadline($line) > 0) {
-				scan($r, \%empty_dirs, $line) or last;
+				scan($r, \%paths_table, $line) or last;
 			}
 			$gz->gzclose;
 		}
@@ -1244,13 +1309,14 @@ sub mkemptydirs {
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
2.6.2
