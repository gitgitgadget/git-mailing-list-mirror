From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn performance
Date: Sun, 19 Oct 2014 02:29:53 +0000
Message-ID: <20141019022953.GA6537@dcvr.yhbt.net>
References: <CABBCAiv0WXNzo7W9PB_o_enLjtUO_rNRb4UBEqDPeSkBj1k-Ww@mail.gmail.com>
 <20141019003256.GA18532@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, stoklund@2pi.dk, sam@vilain.net,
	stevenrwalter@gmail.com, waste.manager@gmx.de, amyrick@apple.com
To: Fabian Schmied <fabian.schmied@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 19 04:30:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XfgG4-0001Ec-UB
	for gcvg-git-2@plane.gmane.org; Sun, 19 Oct 2014 04:30:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751674AbaJSC3z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Oct 2014 22:29:55 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:51231 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751661AbaJSC3y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Oct 2014 22:29:54 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 116D61F45D;
	Sun, 19 Oct 2014 02:29:54 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20141019003256.GA18532@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <normalperson@yhbt.net> wrote:
> Hin-Tak (Cc-ed) reported good improvements with them, but also
> a large memory increase:

This might reduce the pathname and internal hash overheads:
------------------------8<-----------------------
From: Eric Wong <normalperson@yhbt.net>
Date: Sun, 19 Oct 2014 02:26:53 +0000
Subject: [PATCH] git-svn: simplify cached_mergeinfo layout

This reduces hash lookups for looking up cache data and will
simplify tying data to disk in the next commit.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 perl/Git/SVN.pm | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index b1a84d0..25dbcd5 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -1708,15 +1708,17 @@ sub mergeinfo_changes {
 	my %minfo = map {split ":", $_ } split "\n", $mergeinfo_prop;
 	my $old_minfo = {};
 
+	# layout: $path => [ $rev, \%mergeinfo ]
+	my $cached_mergeinfo = $self->{cached_mergeinfo};
+
 	# Initialize cache on the first call.
-	unless (defined $self->{cached_mergeinfo_rev}) {
-		$self->{cached_mergeinfo_rev} = {};
-		$self->{cached_mergeinfo} = {};
+	unless (defined $cached_mergeinfo) {
+		$cached_mergeinfo = $self->{cached_mergeinfo} = {};
 	}
 
-	my $cached_rev = $self->{cached_mergeinfo_rev}{$old_path};
-	if (defined $cached_rev && $cached_rev == $old_rev) {
-		$old_minfo = $self->{cached_mergeinfo}{$old_path};
+	my $cached = $cached_mergeinfo->{$old_path};
+	if (defined $cached && $cached->[0] == $old_rev) {
+		$old_minfo = $cached->[1];
 	} else {
 		my $ra = $self->ra;
 		# Give up if $old_path isn't in the repo.
@@ -1733,13 +1735,11 @@ sub mergeinfo_changes {
 				$props->{"svn:mergeinfo"};
 			$old_minfo = \%omi;
 		}
-		$self->{cached_mergeinfo}{$old_path} = $old_minfo;
-		$self->{cached_mergeinfo_rev}{$old_path} = $old_rev;
+		$cached_mergeinfo->{$old_path} = [ $old_rev, $old_minfo ];
 	}
 
 	# Cache the new mergeinfo.
-	$self->{cached_mergeinfo}{$path} = \%minfo;
-	$self->{cached_mergeinfo_rev}{$path} = $rev;
+	$cached_mergeinfo->{$path} = [ $rev, \%minfo ];
 
 	my %changes = ();
 	foreach my $p (keys %minfo) {
-- 
EW
