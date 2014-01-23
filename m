From: manjian2006@gmail.com
Subject: [PATCH v3] git-svn: memoize _rev_list and rebuild
Date: Thu, 23 Jan 2014 10:15:19 +0800
Message-ID: <1390443319-11239-1-git-send-email-manjian2006@gmail.com>
Cc: lin zuojian <manjian2006@gmail.com>
To: git@vger.kernel.org, normalperson@yhbt.net
X-From: git-owner@vger.kernel.org Thu Jan 23 03:15:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W69pn-0001BY-AG
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 03:15:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753419AbaAWCPy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jan 2014 21:15:54 -0500
Received: from mail-pb0-f47.google.com ([209.85.160.47]:55122 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753330AbaAWCPy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jan 2014 21:15:54 -0500
Received: by mail-pb0-f47.google.com with SMTP id rp16so1201229pbb.34
        for <git@vger.kernel.org>; Wed, 22 Jan 2014 18:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=6x8+eKsmZ+t9Mx6TA//SuYze1RTLTpVCDm5WWZy4+k0=;
        b=0D1et65m2KL1PWe57KTBJFWhRtw1aRJ7d1sMoCLmcBLXv+AsunWe7ngXVBPAQOZ6z+
         Tg/XhiJKPhYbtwnoAfhQUwruKue8tHJ8fSwupw5JhjrYgPvbSLIm1AEsfZFWhI16HqOS
         MdJTShGIUBYAKxRpRsHItVz2d+WxI3JWqkpVvfa/lP7FeE7QR9t1ACUHGzk5qxHjUMNK
         1y67JuxFROQxaFTV4tMVPkU/07EY1P/aIOWkWnuYjpm3G/zLfghtISs6fWLl047wTudT
         Za7NCp6l5i+PayDxOvnOSgqe12aTDehAl5MGpgkWrVkHDJxOaSMi5uRoX8d+gYViXlTo
         4miA==
X-Received: by 10.66.189.193 with SMTP id gk1mr5273806pac.105.1390443353581;
        Wed, 22 Jan 2014 18:15:53 -0800 (PST)
Received: from ubuntu.dhcp.ucweb.local ([70.39.187.196])
        by mx.google.com with ESMTPSA id vx10sm55190301pac.17.2014.01.22.18.15.51
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 22 Jan 2014 18:15:52 -0800 (PST)
X-Mailer: git-send-email 1.8.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240897>

From: lin zuojian <manjian2006@gmail.com>

According to profile data, _rev_list and rebuild consume a large
portion of time.  Memoize the results of _rev_list and memoize
rebuild internals to avoid subprocess invocation.

When importing 15152 revisions on a LAN, time improved from 10
hours to 3-4 hours.

Signed-off-by: lin zuojian <manjian2006@gmail.com>
---
 perl/Git/SVN.pm | 41 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index 5273ee8..6e804a2 100644
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
+	if (!$rebuild_verify_status{$verify_key}) {
+		my $verify_result = ::verify_ref($verify_key);
+		if ($verify_result) {
+			$rebuild_verify_status{$verify_key} = 1;
+		}
+	}
+	if (!$rebuild_verify_status{$verify_key}) {
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
