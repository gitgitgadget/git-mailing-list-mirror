From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/2] Pull out remote listing functions in git-remote.
Date: Fri, 2 Feb 2007 00:05:55 -0500
Message-ID: <20070202050554.GA20505@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Feb 02 06:06:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCqcj-0003H4-FP
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 06:06:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423003AbXBBFGA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 00:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423007AbXBBFGA
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 00:06:00 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:35887 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423003AbXBBFF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 00:05:59 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HCqcL-000859-CP; Fri, 02 Feb 2007 00:05:45 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7F9E620FBAE; Fri,  2 Feb 2007 00:05:55 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38453>

I want to reuse the stale branch detection to implement a new
'git remote prune' subcommand.  Easiest way to do that is to use
the same logic that 'git remote show' uses to determine the stale
tracking branches, then delete those.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 git-remote.perl |   43 +++++++++++++++++++++++--------------------
 1 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/git-remote.perl b/git-remote.perl
index c813fe1..969d33b 100755
--- a/git-remote.perl
+++ b/git-remote.perl
@@ -130,7 +130,7 @@ sub update_ls_remote {
 	$info->{'LS_REMOTE'} = \@ref;
 }
 
-sub show_wildcard_mapping {
+sub list_wildcard_mapping {
 	my ($forced, $ours, $ls) = @_;
 	my %refs;
 	for (@$ls) {
@@ -156,25 +156,14 @@ sub show_wildcard_mapping {
 			push @tracked, $_;
 		}
 	}
-	if (@new) {
-		print "  New remote branches (next fetch will store in remotes/$ours)\n";
-		print "    @new\n";
-	}
-	if (@stale) {
-		print "  Stale tracking branches in remotes/$ours (you'd better remove them)\n";
-		print "    @stale\n";
-	}
-	if (@tracked) {
-		print "  Tracked remote branches\n";
-		print "    @tracked\n";
-	}
+	return \@new, \@stale, \@tracked;
 }
 
-sub show_mapping {
+sub list_mapping {
 	my ($name, $info) = @_;
 	my $fetch = $info->{'FETCH'};
 	my $ls = $info->{'LS_REMOTE'};
-	my (@stale, @tracked);
+	my (@new, @stale, @tracked);
 
 	for (@$fetch) {
 		next unless (/(\+)?([^:]+):(.*)/);
@@ -182,7 +171,11 @@ sub show_mapping {
 		if ($theirs eq 'refs/heads/*' &&
 		    $ours =~ /^refs\/remotes\/(.*)\/\*$/) {
 			# wildcard mapping
-			show_wildcard_mapping($forced, $1, $ls);
+			my ($w_new, $w_stale, $w_tracked)
+				= list_wildcard_mapping($forced, $1, $ls);
+			push @new, @$w_new;
+			push @stale, @$w_stale;
+			push @tracked, @$w_tracked;
 		}
 		elsif ($theirs =~ /\*/ || $ours =~ /\*/) {
 			print STDERR "Warning: unrecognized mapping in remotes.$name.fetch: $_\n";
@@ -196,13 +189,23 @@ sub show_mapping {
 			}
 		}
 	}
-	if (@stale) {
+	return \@new, \@stale, \@tracked;
+}
+
+sub show_mapping {
+	my ($name, $info) = @_;
+	my ($new, $stale, $tracked) = list_mapping($name, $info);
+	if (@$new) {
+		print "  New remote branches (next fetch will store in remotes/$name)\n";
+		print "    @$new\n";
+	}
+	if (@$stale) {
 		print "  Stale tracking branches in remotes/$name (you'd better remove them)\n";
-		print "    @stale\n";
+		print "    @$stale\n";
 	}
-	if (@tracked) {
+	if (@$tracked) {
 		print "  Tracked remote branches\n";
-		print "    @tracked\n";
+		print "    @$tracked\n";
 	}
 }
 
-- 
1.5.0.rc3.1.ge4b0e
