From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH 5/5] git-svn: convert SVN 1.5+ / svnmerge.py svn:mergeinfo props to parents
Date: Tue, 20 Oct 2009 15:42:03 +1300
Message-ID: <1256006523-5493-6-git-send-email-sam.vilain@catalyst.net.nz>
References: <1256006523-5493-1-git-send-email-sam.vilain@catalyst.net.nz>
 <1256006523-5493-2-git-send-email-sam.vilain@catalyst.net.nz>
 <1256006523-5493-3-git-send-email-sam.vilain@catalyst.net.nz>
 <1256006523-5493-4-git-send-email-sam.vilain@catalyst.net.nz>
 <1256006523-5493-5-git-send-email-sam.vilain@catalyst.net.nz>
Cc: Sam Vilain <sam.vilain@catalyst.net.nz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 20 04:43:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N04hZ-0008AQ-DH
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 04:43:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758261AbZJTCnh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 22:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756339AbZJTCng
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 22:43:36 -0400
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:42729 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758253AbZJTCnf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 22:43:35 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.catalyst.net.nz (Postfix) with ESMTP id 1DA603236D;
	Tue, 20 Oct 2009 15:43:39 +1300 (NZDT)
X-Virus-Scanned: Debian amavisd-new at catalyst.net.nz
Received: from mail.catalyst.net.nz ([127.0.0.1])
	by localhost (bertrand.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZIOzL9844lfN; Tue, 20 Oct 2009 15:43:36 +1300 (NZDT)
Received: from localhost.localdomain (leibniz.catalyst.net.nz [202.78.240.7])
	by mail.catalyst.net.nz (Postfix) with ESMTP id 13B3732395;
	Tue, 20 Oct 2009 15:43:36 +1300 (NZDT)
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1256006523-5493-5-git-send-email-sam.vilain@catalyst.net.nz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130752>

This feature is long overdue; convert SVN's merge representation to git's
as revisions are imported.  This works by converting the list of revisions
in each line of the svn:mergeinfo into git revision ranges, and then
checking the latest of each of these revision ranges for A) being new and
B) now being completely merged.

Signed-off-by: Sam Vilain <sam.vilain@catalyst.net.nz>
---
   There's much more implemented here than is tested...
 git-svn.perl             |   93 ++++++++++++++++++++++++++++++++++++++++++++++
 t/t9151-svn-mergeinfo.sh |   21 ++++++++++
 2 files changed, 114 insertions(+), 0 deletions(-)
 create mode 100644 t/t9151-svn-mergeinfo.sh

diff --git a/git-svn.perl b/git-svn.perl
index 3c2534c..244e40d 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2916,6 +2916,93 @@ sub find_extra_svk_parents {
 	}
 }
 
+# note: this function should only be called if the various dirprops
+# have actually changed
+sub find_extra_svn_parents {
+	my ($self, $ed, $mergeinfo, $parents) = @_;
+	# aha!  svk:merge property changed...
+
+	# We first search for merged tips which are not in our
+	# history.  Then, we figure out which git revisions are in
+	# that tip, but not this revision.  If all of those revisions
+	# are now marked as merge, we can add the tip as a parent.
+	my @merges = split "\n", $mergeinfo;
+	my @merge_tips;
+	my @merged_commit_ranges;
+	my $url = $self->rewrite_root || $self->{url};
+	for my $merge ( @merges ) {
+		my ($source, $revs) = split ":", $merge;
+		my $path = $source;
+		$path =~ s{^/}{};
+		my $gs = Git::SVN->find_by_url($url.$source, $url, $path);
+		if ( !$gs ) {
+			warn "Couldn't find revmap for $url$source\n";
+			next;
+		}
+		my @ranges = split ",", $revs;
+		my ($tip, $tip_commit);
+		# find the tip
+		for my $range ( @ranges ) {
+			my ($bottom, $top) = split "-", $range;
+			$top ||= $bottom;
+			my $bottom_commit =
+				$gs->rev_map_get($bottom, $self->ra_uuid) ||
+				$gs->rev_map_get($bottom+1, $self->ra_uuid);
+			my $top_commit =
+				$gs->rev_map_get($top, $self->ra_uuid);
+
+			unless ($top_commit and $bottom_commit) {
+				warn "W:unknown path/rev in svn:mergeinfo "
+					."dirprop: $source:$range\n";
+				next;
+			}
+
+			push @merged_commit_ranges,
+				"$bottom_commit..$top_commit";
+
+			if ( !defined $tip or $top > $tip ) {
+				$tip = $top;
+				$tip_commit = $top_commit;
+			}
+		}
+		unless (!$tip_commit or
+				grep { $_ eq $tip_commit } @$parents ) {
+			push @merge_tips, $tip_commit;
+		}
+		else {
+			push @merge_tips, undef;
+		}
+	}
+	for my $merge_tip ( @merge_tips ) {
+		my $spec = shift @merges;
+		next unless $merge_tip;
+		my @cmd = ('rev-list', "-1", $merge_tip,
+			   "--not", @$parents );
+		my ($msg_fh, $ctx) = command_output_pipe(@cmd);
+		my $new;
+		while ( <$msg_fh> ) {
+			$new=1;last;
+		}
+		command_close_pipe($msg_fh, $ctx);
+		if ( $new ) {
+			push @cmd, @merged_commit_ranges;
+			my ($msg_fh, $ctx) = command_output_pipe(@cmd);
+			my $unmerged;
+			while ( <$msg_fh> ) {
+				$unmerged=1;last;
+			}
+			command_close_pipe($msg_fh, $ctx);
+			if ( $unmerged ) {
+				warn "W:svn cherry-pick ignored ($spec)\n";
+			}
+			else {
+				warn "Found merge parent (svn:mergeinfo prop): $merge_tip\n";
+				push @$parents, $merge_tip;
+			}
+		}
+	}
+}
+
 sub make_log_entry {
 	my ($self, $rev, $parents, $ed) = @_;
 	my $untracked = $self->get_untracked($ed);
@@ -2928,6 +3015,12 @@ sub make_log_entry {
 			$self->find_extra_svk_parents
 				($ed, $props->{"svk:merge"}, \@parents);
 		}
+		if ( $props->{"svn:mergeinfo"} ) {
+			$self->find_extra_svn_parents
+				($ed,
+				 $props->{"svn:mergeinfo"},
+				 \@parents);
+		}
 	}
 
 	open my $un, '>>', "$self->{dir}/unhandled.log" or croak $!;
diff --git a/t/t9151-svn-mergeinfo.sh b/t/t9151-svn-mergeinfo.sh
new file mode 100644
index 0000000..7eb36e5
--- /dev/null
+++ b/t/t9151-svn-mergeinfo.sh
@@ -0,0 +1,21 @@
+#!/bin/sh
+#
+# Copyright (c) 2007, 2009 Sam Vilain
+#
+
+test_description='git-svn svn mergeinfo properties'
+
+. ./lib-git-svn.sh
+
+test_expect_success 'load svn dump' "
+	svnadmin load -q '$rawsvnrepo' < '../t9151/svn-mergeinfo.dump' &&
+	git svn init --minimize-url -R svnmerge \
+	  -T trunk -b branches '$svnrepo' &&
+	git svn fetch --all
+	"
+
+test_expect_success 'svn merges were represented coming in' "
+	[ `git cat-file commit HEAD | grep parent | wc -l` -eq 2 ]
+	"
+
+test_done
-- 
1.6.3.3
