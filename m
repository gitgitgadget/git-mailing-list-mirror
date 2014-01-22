From: manjian2006@gmail.com
Subject: [PATCH v2] improve git svn performance
Date: Wed, 22 Jan 2014 16:08:23 +0800
Message-ID: <1390378103-24392-1-git-send-email-manjian2006@gmail.com>
Cc: manjian2006 <manjian2006@gmail.com>
To: git@vger.kernel.org, normalperson@yhbt.net
X-From: git-owner@vger.kernel.org Wed Jan 22 09:08:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5srZ-00041o-Ph
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 09:08:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752265AbaAVIIh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jan 2014 03:08:37 -0500
Received: from mail-pb0-f44.google.com ([209.85.160.44]:62545 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750850AbaAVIIg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jan 2014 03:08:36 -0500
Received: by mail-pb0-f44.google.com with SMTP id rq2so58573pbb.17
        for <git@vger.kernel.org>; Wed, 22 Jan 2014 00:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=X7IO4Pox3SViOPoC14RS5B9U/ck8X2WQ5TB2reMKmnE=;
        b=Lk2pY6NX9JPcg9qLR6Pr82/jMwkEPb0GS7YfuDwvVQMByCkYJ2mQOq8KtNyCPmwm0s
         xHSd+lT5kuq6oL1aQX5JGgagT9sn7r9pgb5BhXhP5LTuyN36qJsp2nkDPf+xU9z833+8
         Y+naQGWRFZbbrubwNBX441DbFbCMORWLmVxK19bYtFoWn5G3L50Uj2THMJmL6Zesg7B4
         lMhpR3csROMQhy458jOPUar794ph8LiRdeO2cn2UicszVFVOwlbORWz5rZ9NhMJ3VNcE
         Dg80nrLoZS6dfbxQo4MhaRnJQkNHB0RZrCszfNGx8KLeEOX5LGBptjX3XcABt26Of3fs
         ITqw==
X-Received: by 10.66.26.115 with SMTP id k19mr64639pag.87.1390378116381;
        Wed, 22 Jan 2014 00:08:36 -0800 (PST)
Received: from ubuntu.dhcp.ucweb.local ([70.39.187.196])
        by mx.google.com with ESMTPSA id sg1sm19963800pbb.16.2014.01.22.00.08.34
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 22 Jan 2014 00:08:35 -0800 (PST)
X-Mailer: git-send-email 1.8.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240816>

From: manjian2006 <manjian2006@gmail.com>


* perl/Git/SVN.pm
  Modified according to Eric Wong <normalperson@yhbt.net>

>Hi, I'm interested in this.  How much did performance improve by
>(and how many revisions is the repository)>
Our svn server are built in a LAN,15152 revisions.Not optimized git-svn used 10 hours or more to accomplish,
while optimized one using only 3-4 hours.


According to some profiling data,_rev_list subroutine and rebuild subroutine are consuming a large proportion of time.
So I improve _rev_list's performance by memoize its results,and avoid subprocess invocation by memoize rebuild subroutine's key data.

Signed-off-by: manjian2006 <manjian2006@gmail.com>
---
 perl/Git/SVN.pm | 41 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index 5273ee8..dc7942b 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -1599,6 +1599,7 @@ sub tie_for_persistent_memoization {
 		my %lookup_svn_merge_cache;
 		my %check_cherry_pick_cache;
 		my %has_no_changes_cache;
+		my %_rev_list_cache;
 
 		tie_for_persistent_memoization(\%lookup_svn_merge_cache,
 		    "$cache_path/lookup_svn_merge");
@@ -1620,6 +1621,14 @@ sub tie_for_persistent_memoization {
 			SCALAR_CACHE => ['HASH' => \%has_no_changes_cache],
 			LIST_CACHE => 'FAULT',
 		;
+
+		tie_for_persistent_memoization(\%_rev_list_cache,
+		    "$cache_path/_rev_list");
+		memoize '_rev_list',
+			SCALAR_CACHE => 'FAULT',
+			LIST_CACHE => ['HASH' => \%_rev_list_cache],
+		;
+
 	}
 
 	sub unmemoize_svn_mergeinfo_functions {
@@ -1629,6 +1638,7 @@ sub tie_for_persistent_memoization {
 		Memoize::unmemoize 'lookup_svn_merge';
 		Memoize::unmemoize 'check_cherry_pick';
 		Memoize::unmemoize 'has_no_changes';
+		Memoize::unmemoize '_rev_list';
 	}
 
 	sub clear_memoized_mergeinfo_caches {
@@ -1959,11 +1969,25 @@ sub rebuild_from_rev_db {
 	unlink $path or croak "unlink: $!";
 }
 
+#define a global associate map to record rebuild status
+my %rebuild_status;
+#define a global associate map to record rebuild verify status
+my %rebuild_verify_status;
+
 sub rebuild {
 	my ($self) = @_;
 	my $map_path = $self->map_path;
 	my $partial = (-e $map_path && ! -z $map_path);
-	return unless ::verify_ref($self->refname.'^0');
+	my $verify_key = $self->refname.'^0';
+	if (! exists $rebuild_verify_status{$verify_key} || ! defined $rebuild_verify_status{$verify_key} ) {
+		my $verify_result = ::verify_ref($verify_key);
+		if ($verify_result) {
+			$rebuild_verify_status{$verify_key} = 1;
+		}
+	}
+	if (! exists $rebuild_verify_status{$verify_key}) {
+		return;
+	}
 	if (!$partial && ($self->use_svm_props || $self->no_metadata)) {
 		my $rev_db = $self->rev_db_path;
 		$self->rebuild_from_rev_db($rev_db);
@@ -1977,10 +2001,21 @@ sub rebuild {
 	print "Rebuilding $map_path ...\n" if (!$partial);
 	my ($base_rev, $head) = ($partial ? $self->rev_map_max_norebuild(1) :
 		(undef, undef));
+	my $key_value = ($head ? "$head.." : "") . $self->refname;
+	if (exists $rebuild_status{$key_value}) {
+		print "Done rebuilding $map_path\n" if (!$partial || !$head);
+		my $rev_db_path = $self->rev_db_path;
+		if (-f $self->rev_db_path) {
+			unlink $self->rev_db_path or croak "unlink: $!";
+		}
+		$self->unlink_rev_db_symlink;
+		return;
+	}
 	my ($log, $ctx) =
-	    command_output_pipe(qw/rev-list --pretty=raw --reverse/,
-				($head ? "$head.." : "") . $self->refname,
+		command_output_pipe(qw/rev-list --pretty=raw --reverse/,
+				$key_value,	
 				'--');
+	$rebuild_status{$key_value} = 1;
 	my $metadata_url = $self->metadata_url;
 	remove_username($metadata_url);
 	my $svn_uuid = $self->rewrite_uuid || $self->ra_uuid;
-- 
1.8.3.2
