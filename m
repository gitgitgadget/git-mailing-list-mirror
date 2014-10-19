From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn performance
Date: Sun, 19 Oct 2014 02:33:58 +0000
Message-ID: <20141019023358.GA2946@dcvr.yhbt.net>
References: <CABBCAiv0WXNzo7W9PB_o_enLjtUO_rNRb4UBEqDPeSkBj1k-Ww@mail.gmail.com>
 <20141019003256.GA18532@dcvr.yhbt.net>
 <20141019022953.GA6537@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, stoklund@2pi.dk, sam@vilain.net,
	stevenrwalter@gmail.com, waste.manager@gmx.de, amyrick@apple.com
To: Fabian Schmied <fabian.schmied@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 19 04:34:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XfgJo-0002QA-1Q
	for gcvg-git-2@plane.gmane.org; Sun, 19 Oct 2014 04:34:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751666AbaJSCd7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Oct 2014 22:33:59 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:51263 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751608AbaJSCd6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Oct 2014 22:33:58 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90E551F45D;
	Sun, 19 Oct 2014 02:33:58 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20141019022953.GA6537@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <normalperson@yhbt.net> wrote:
> This reduces hash lookups for looking up cache data and will
> simplify tying data to disk in the next commit.

I considered the following, but GDBM might not be readily available on
non-POSIX platforms.  I think the other problem is the existing caches
are still in memory (whether YAML or Storable) even if disk-backed,
causing a large amount of memory usage anyways.

(Both patches on top of Jakob's)
-------------------------
Subject: [RFC] git-svn: tie cached_mergeinfo to a GDBM_File store

This should reduce per-instance memory usage by allowing
serialization to disk.  Using the existing Memoize::Storable
or YAML backends does not allow fast lookups.

GDBM_File should be available in most Perl installations
and should not pose unnecessary burden
---
 perl/Git/SVN.pm | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index 25dbcd5..3e477c7 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -14,6 +14,7 @@ use IPC::Open3;
 use Memoize;  # core since 5.8.0, Jul 2002
 use Memoize::Storable;
 use POSIX qw(:signal_h);
+use Storable qw(freeze thaw);
 
 use Git qw(
     command
@@ -1713,10 +1714,21 @@ sub mergeinfo_changes {
 
 	# Initialize cache on the first call.
 	unless (defined $cached_mergeinfo) {
-		$cached_mergeinfo = $self->{cached_mergeinfo} = {};
+		my %hash;
+		eval '
+		require File::Temp;
+		use GDBM_File;
+		my $fh = File::Temp->new(TEMPLATE => "mergeinfo.XXXXXXXX");
+		$self->{cached_mergeinfo_fh} = $fh;
+		$fh->unlink_on_destroy(1);
+		tie %hash => "GDBM_File", $fh->filename, GDBM_WRCREAT, 0600;
+		';
+		$cached_mergeinfo = $self->{cached_mergeinfo} = \%hash;
 	}
 
 	my $cached = $cached_mergeinfo->{$old_path};
+	$cached = thaw($cached) if defined $cached;
+
 	if (defined $cached && $cached->[0] == $old_rev) {
 		$old_minfo = $cached->[1];
 	} else {
@@ -1735,11 +1747,12 @@ sub mergeinfo_changes {
 				$props->{"svn:mergeinfo"};
 			$old_minfo = \%omi;
 		}
-		$cached_mergeinfo->{$old_path} = [ $old_rev, $old_minfo ];
+		$cached_mergeinfo->{$old_path} =
+					freeze([ $old_rev, $old_minfo ]);
 	}
 
 	# Cache the new mergeinfo.
-	$cached_mergeinfo->{$path} = [ $rev, \%minfo ];
+	$cached_mergeinfo->{$path} = freeze([ $rev, \%minfo ]);
 
 	my %changes = ();
 	foreach my $p (keys %minfo) {
-- 
EW
