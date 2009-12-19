From: Sam Vilain <sam@vilain.net>
Subject: [PATCH 2/5] git-svn: memoize conversion of SVN merge ticket info to git commit ranges
Date: Sun, 20 Dec 2009 05:33:52 +1300
Message-ID: <1261240435-8948-3-git-send-email-sam@vilain.net>
References: <1261240435-8948-1-git-send-email-sam@vilain.net>
 <1261240435-8948-2-git-send-email-sam@vilain.net>
Cc: Eric Wong <normalperson@yhbt.net>,
	Andrew Myrick <amyrick@gmail.com>, Sam Vilain <sam@vilain.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 19 17:34:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NM2GK-000123-2Q
	for gcvg-git-2@lo.gmane.org; Sat, 19 Dec 2009 17:34:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752857AbZLSQe0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Dec 2009 11:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752807AbZLSQeY
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Dec 2009 11:34:24 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:52467 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752682AbZLSQeW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Dec 2009 11:34:22 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id CF8CB21C5A9; Sun, 20 Dec 2009 05:34:17 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from denix (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 2BAE021C475;
	Sun, 20 Dec 2009 05:34:12 +1300 (NZDT)
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
	by denix with esmtp (Exim 4.69)
	(envelope-from <sam@vilain.net>)
	id 1NM2Fx-0002Lt-LM; Sun, 20 Dec 2009 05:34:13 +1300
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1261240435-8948-2-git-send-email-sam@vilain.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135488>

Each time the svn mergeinfo ticket changes, we look it up in the rev_map;
when there are a lot of merged branches, this will result in many repeated
lookups of the same information for subsequent commits.  Arrange the slow
part of the function so that it may be memoized, and memoize it.  The more
expensive revision walking operation can be memoized separately.

Signed-off-by: Sam Vilain <sam@vilain.net>
---
 git-svn.perl |   91 ++++++++++++++++++++++++++++++++++-----------------------
 1 files changed, 54 insertions(+), 37 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index a4b052c..3b17a83 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1634,6 +1634,7 @@ use Carp qw/croak/;
 use File::Path qw/mkpath/;
 use File::Copy qw/copy/;
 use IPC::Open3;
+use Memoize;  # core since 5.8.0, Jul 2002
 
 my ($_gc_nr, $_gc_period);
 
@@ -2967,6 +2968,55 @@ sub find_extra_svk_parents {
 	}
 }
 
+sub lookup_svn_merge {
+	my $uuid = shift;
+	my $url = shift;
+	my $merge = shift;
+
+	my ($source, $revs) = split ":", $merge;
+	my $path = $source;
+	$path =~ s{^/}{};
+	my $gs = Git::SVN->find_by_url($url.$source, $url, $path);
+	if ( !$gs ) {
+		warn "Couldn't find revmap for $url$source\n";
+		next;
+	}
+	my @ranges = split ",", $revs;
+	my ($tip, $tip_commit);
+	my @merged_commit_ranges;
+	# find the tip
+	for my $range ( @ranges ) {
+		my ($bottom, $top) = split "-", $range;
+		$top ||= $bottom;
+		my $bottom_commit =
+			$gs->rev_map_get($bottom, $uuid) ||
+			$gs->rev_map_get($bottom+1, $uuid);
+		my $top_commit;
+		for (; !$top_commit && $top >= $bottom; --$top) {
+			$top_commit =
+				$gs->rev_map_get($top, $uuid);
+		}
+
+		unless ($top_commit and $bottom_commit) {
+			warn "W:unknown path/rev in svn:mergeinfo "
+				."dirprop: $source:$range\n";
+			next;
+		}
+
+		push @merged_commit_ranges,
+			"$bottom_commit..$top_commit";
+
+		if ( !defined $tip or $top > $tip ) {
+			$tip = $top;
+			$tip_commit = $top_commit;
+		}
+	}
+	return ($tip_commit, @merged_commit_ranges);
+}
+BEGIN {
+	memoize 'lookup_svn_merge';
+}
+
 # note: this function should only be called if the various dirprops
 # have actually changed
 sub find_extra_svn_parents {
@@ -2981,44 +3031,11 @@ sub find_extra_svn_parents {
 	my @merge_tips;
 	my @merged_commit_ranges;
 	my $url = $self->rewrite_root || $self->{url};
+	my $uuid = $self->ra_uuid;
 	for my $merge ( @merges ) {
-		my ($source, $revs) = split ":", $merge;
-		my $path = $source;
-		$path =~ s{^/}{};
-		my $gs = Git::SVN->find_by_url($url.$source, $url, $path);
-		if ( !$gs ) {
-			warn "Couldn't find revmap for $url$source\n";
-			next;
-		}
-		my @ranges = split ",", $revs;
-		my ($tip, $tip_commit);
-		# find the tip
-		for my $range ( @ranges ) {
-			my ($bottom, $top) = split "-", $range;
-			$top ||= $bottom;
-			my $bottom_commit =
-				$gs->rev_map_get($bottom, $self->ra_uuid) ||
-				$gs->rev_map_get($bottom+1, $self->ra_uuid);
-			my $top_commit;
-			for (; !$top_commit && $top >= $bottom; --$top) {
-				$top_commit =
-					$gs->rev_map_get($top, $self->ra_uuid);
-			}
-
-			unless ($top_commit and $bottom_commit) {
-				warn "W:unknown path/rev in svn:mergeinfo "
-					."dirprop: $source:$range\n";
-				next;
-			}
-
-			push @merged_commit_ranges,
-				"$bottom_commit..$top_commit";
-
-			if ( !defined $tip or $top > $tip ) {
-				$tip = $top;
-				$tip_commit = $top_commit;
-			}
-		}
+		my ($tip_commit, @ranges) =
+			lookup_svn_merge( $uuid, $url, $merge );
+		push @merged_commit_ranges, @ranges;
 		unless (!$tip_commit or
 				grep { $_ eq $tip_commit } @$parents ) {
 			push @merge_tips, $tip_commit;
-- 
1.6.3.3
