From: Jakob Stoklund Olesen <stoklund@2pi.dk>
Subject: [PATCH 1/2] git-svn: only look at the new parts of svn:mergeinfo
Date: Wed, 16 Apr 2014 23:54:05 -0700
Message-ID: <1397717646-54248-1-git-send-email-stoklund@2pi.dk>
Cc: Eric Wong <normalperson@yhbt.net>, Sam Vilain <sam@vilain.net>,
	Steven Walter <stevenrwalter@gmail.com>,
	Peter Baumann <waste.manager@gmx.de>,
	Andrew Myrick <amyrick@apple.com>,
	Jakob Stoklund Olesen <stoklund@2pi.dk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 17 08:55:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WagE8-0007qE-PZ
	for gcvg-git-2@plane.gmane.org; Thu, 17 Apr 2014 08:55:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751686AbaDQGzJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2014 02:55:09 -0400
Received: from hapkido.dreamhost.com ([66.33.216.122]:42476 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751046AbaDQGzI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2014 02:55:08 -0400
Received: from homiemail-a115.g.dreamhost.com (sub5.mail.dreamhost.com [208.113.200.129])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 0D76492E03
	for <git@vger.kernel.org>; Wed, 16 Apr 2014 23:55:08 -0700 (PDT)
Received: from homiemail-a115.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a115.g.dreamhost.com (Postfix) with ESMTP id 6F817440E;
	Wed, 16 Apr 2014 23:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=2pi.dk; h=from:to:cc
	:subject:date:message-id; s=2pi.dk; bh=Uk27Idtn79I2S59pUdEHwWwC6
	tQ=; b=lpsnoBA9BcfunvdStIRA1SIA5Tpl4jHte44A8kgx6n6jQaGvlunH3NKwV
	sdBqbLDuizOI/hpYjPst+bXdyfiheevhlQm48GfU58gulg+opQV6qpEwpsqy3LF/
	gXB3LVhxQFPgDNGVJP9z92cM1eNYd25IJhQTug6xZSqzbOkdQU=
Received: from localhost.localdomain (173-228-90-133.dsl.dynamic.sonic.net [173.228.90.133])
	(using TLSv1 with cipher ADH-SEED-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: stoklund@2pi.dk)
	by homiemail-a115.g.dreamhost.com (Postfix) with ESMTPSA id ED8C55629;
	Wed, 16 Apr 2014 23:54:56 -0700 (PDT)
X-Mailer: git-send-email 1.8.5.2 (Apple Git-48)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246410>

In a Subversion repository where many feature branches are merged into a
trunk, the svn:mergeinfo property can grow very large. This severely
slows down git-svn's make_log_entry() because it is checking all
mergeinfo entries every time the property changes.

In most cases, the additions to svn:mergeinfo since the last commit are
pretty small, and there is nothing to gain by checking merges that were
already checked for the last commit in the branch.

Add a mergeinfo_changes() function which computes the set of interesting
changes to svn:mergeinfo since the last commit. Filter out merged
branches whose ranges haven't changed, and remove a common prefix of
ranges from other merged branches.

This speeds up "git svn fetch" by several orders of magnitude on a large
repository where thousands of feature branches have been merged.

Signed-off-by: Jakob Stoklund Olesen <stoklund@2pi.dk>
---
 perl/Git/SVN.pm | 84 ++++++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 72 insertions(+), 12 deletions(-)

diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index a59564f..d3785ab 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -1178,7 +1178,7 @@ sub find_parent_branch {
 			  or die "SVN connection failed somewhere...\n";
 		}
 		print STDERR "Successfully followed parent\n" unless $::_q > 1;
-		return $self->make_log_entry($rev, [$parent], $ed);
+		return $self->make_log_entry($rev, [$parent], $ed, $r0, $branch_from);
 	}
 	return undef;
 }
@@ -1210,7 +1210,7 @@ sub do_fetch {
 	unless ($self->ra->gs_do_update($last_rev, $rev, $self, $ed)) {
 		die "SVN connection failed somewhere...\n";
 	}
-	$self->make_log_entry($rev, \@parents, $ed);
+	$self->make_log_entry($rev, \@parents, $ed, $last_rev);
 }
 
 sub mkemptydirs {
@@ -1478,9 +1478,9 @@ sub find_extra_svk_parents {
 sub lookup_svn_merge {
 	my $uuid = shift;
 	my $url = shift;
-	my $merge = shift;
+	my $source = shift;
+	my $revs = shift;
 
-	my ($source, $revs) = split ":", $merge;
 	my $path = $source;
 	$path =~ s{^/}{};
 	my $gs = Git::SVN->find_by_url($url.$source, $url, $path);
@@ -1702,6 +1702,62 @@ sub parents_exclude {
 	return @excluded;
 }
 
+# Compute what's new in svn:mergeinfo.
+sub mergeinfo_changes {
+	my ($self, $old_path, $old_rev, $path, $rev, $mergeinfo_prop) = @_;
+	my %minfo = map {split ":", $_ } split "\n", $mergeinfo_prop;
+	my $old_minfo = {};
+
+	# Initialize cache on the first call.
+	unless (defined $self->{cached_mergeinfo_rev}) {
+		$self->{cached_mergeinfo_rev} = {};
+		$self->{cached_mergeinfo} = {};
+	}
+
+	my $cached_rev = $self->{cached_mergeinfo_rev}{$old_path};
+	if (defined $cached_rev && $cached_rev == $old_rev) {
+		$old_minfo = $self->{cached_mergeinfo}{$old_path};
+	} else {
+		my $ra = $self->ra;
+		# Give up if $old_path isn't in the repo.
+		# This is probably a merge on a subtree.
+		if ($ra->check_path($old_path, $old_rev) != $SVN::Node::dir) {
+			warn "W: ignoring svn:mergeinfo on $old_path, ",
+				"directory didn't exist in r$old_rev\n";
+			return {};
+		}
+		my (undef, undef, $props) =
+			$self->ra->get_dir($old_path, $old_rev);
+		if (defined $props->{"svn:mergeinfo"}) {
+			my %omi = map {split ":", $_ } split "\n",
+				$props->{"svn:mergeinfo"};
+			$old_minfo = \%omi;
+		}
+		$self->{cached_mergeinfo}{$old_path} = $old_minfo;
+		$self->{cached_mergeinfo_rev}{$old_path} = $old_rev;
+	}
+
+	# Cache the new mergeinfo.
+	$self->{cached_mergeinfo}{$path} = \%minfo;
+	$self->{cached_mergeinfo_rev}{$path} = $rev;
+
+	my %changes = ();
+	foreach my $p (keys %minfo) {
+		my $a = $old_minfo->{$p} || "";
+		my $b = $minfo{$p};
+		# Omit merged branches whose ranges lists are unchanged.
+		next if $a eq $b;
+		# Remove any common range list prefix.
+		($a ^ $b) =~ /^[\0]*/;
+		my $common_prefix = rindex $b, ",", $+[0] - 1;
+		$changes{$p} = substr $b, $common_prefix + 1;
+	}
+	print STDERR "Checking svn:mergeinfo changes since r$old_rev: ",
+		scalar(keys %minfo), " sources, ",
+		scalar(keys %changes), " changed\n";
+
+	return \%changes;
+}
 
 # note: this function should only be called if the various dirprops
 # have actually changed
@@ -1715,14 +1771,15 @@ sub find_extra_svn_parents {
 	# history.  Then, we figure out which git revisions are in
 	# that tip, but not this revision.  If all of those revisions
 	# are now marked as merge, we can add the tip as a parent.
-	my @merges = split "\n", $mergeinfo;
+	my @merges = sort keys %$mergeinfo;
 	my @merge_tips;
 	my $url = $self->url;
 	my $uuid = $self->ra_uuid;
 	my @all_ranges;
 	for my $merge ( @merges ) {
 		my ($tip_commit, @ranges) =
-			lookup_svn_merge( $uuid, $url, $merge );
+			lookup_svn_merge( $uuid, $url,
+					  $merge, $mergeinfo->{$merge} );
 		unless (!$tip_commit or
 				grep { $_ eq $tip_commit } @$parents ) {
 			push @merge_tips, $tip_commit;
@@ -1738,8 +1795,9 @@ sub find_extra_svn_parents {
 	# check merge tips for new parents
 	my @new_parents;
 	for my $merge_tip ( @merge_tips ) {
-		my $spec = shift @merges;
+		my $merge = shift @merges;
 		next unless $merge_tip and $excluded{$merge_tip};
+		my $spec = "$merge:$mergeinfo->{$merge}";
 
 		# check out 'new' tips
 		my $merge_base;
@@ -1770,7 +1828,7 @@ sub find_extra_svn_parents {
 				.@incomplete." commit(s) (eg $incomplete[0])\n";
 		} else {
 			warn
-				"Found merge parent (svn:mergeinfo prop): ",
+				"Found merge parent ($spec): ",
 					$merge_tip, "\n";
 			push @new_parents, $merge_tip;
 		}
@@ -1797,7 +1855,7 @@ sub find_extra_svn_parents {
 }
 
 sub make_log_entry {
-	my ($self, $rev, $parents, $ed) = @_;
+	my ($self, $rev, $parents, $ed, $parent_rev, $parent_path) = @_;
 	my $untracked = $self->get_untracked($ed);
 
 	my @parents = @$parents;
@@ -1809,10 +1867,12 @@ sub make_log_entry {
 				($ed, $props->{"svk:merge"}, \@parents);
 		}
 		if ( $props->{"svn:mergeinfo"} ) {
+			my $mi_changes = $self->mergeinfo_changes
+				($parent_path || $path, $parent_rev,
+				 $path, $rev,
+				 $props->{"svn:mergeinfo"});
 			$self->find_extra_svn_parents
-				($ed,
-				 $props->{"svn:mergeinfo"},
-				 \@parents);
+				($ed, $mi_changes, \@parents);
 		}
 	}
 
-- 
1.8.5.2 (Apple Git-48)
