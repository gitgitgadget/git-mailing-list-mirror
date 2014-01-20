From: manjian2006@gmail.com
Subject: [PATCH] improve git svn performance Hi,   I am trying to improve git svn's performance according to some profiling data.As the data showed,_rev_list subroutine and rebuild subroutine are consuming a large proportion of time.So I improve _rev_list's performance by memoize its results,and avoid subprocess invocation by memoize rebuild subroutine's key data.Here's my patch:
Date: Mon, 20 Jan 2014 12:36:19 +0800
Message-ID: <1390192579-3635-1-git-send-email-manjian2006@gmail.com>
Cc: linzj <linzj@ucweb.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 20 05:36:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W56bH-0000lL-4n
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jan 2014 05:36:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753334AbaATEgf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jan 2014 23:36:35 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:64646 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753329AbaATEgd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jan 2014 23:36:33 -0500
Received: by mail-pa0-f43.google.com with SMTP id rd3so6531037pab.2
        for <git@vger.kernel.org>; Sun, 19 Jan 2014 20:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=xFHrY65OqBH80b4WUbtSiBJ1WlNxqe8N7CFdJos2N2A=;
        b=kVh8WEVEuri9kd2lEO8HAVDyJA0fEB8538wuffEIRbTT/M8wT07mXqIcFzsUu5G243
         Ok/OmrG+zjWbuQgTaw9oJw9q/5eKZ9PFOprCePX0U0ur+eCOfmj0pP40PNSVn/rHRe7P
         FCFWmN3BZ8bDlwh0Y16maIuXnAjZMonxnsmIGdZRuyJGZPUbNLWs+zRimSpK5EYDoHzf
         y5F+5o2aHyssIXgZ+wDoVKRviV24vV6xLPy8aM+lmQCq85W9hWOku1ofoXzft6aMDd15
         lmU7Rtda9AbnpngSPhon7Vwd9YvqW1TDx3zsPcEY8n+PvbRW+c0Z6vmMk5vam7FmEJk9
         /h+Q==
X-Received: by 10.68.196.69 with SMTP id ik5mr1197443pbc.132.1390192592970;
        Sun, 19 Jan 2014 20:36:32 -0800 (PST)
Received: from ubuntu.dhcp.ucweb.local ([70.39.187.196])
        by mx.google.com with ESMTPSA id e6sm40858961pbg.4.2014.01.19.20.36.30
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 19 Jan 2014 20:36:32 -0800 (PST)
X-Mailer: git-send-email 1.8.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240707>

From: linzj <linzj@ucweb.com>

---
 perl/Git/SVN.pm | 63 ++++++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 49 insertions(+), 14 deletions(-)

diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index 5273ee8..3cd1c8f 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -1599,27 +1599,36 @@ sub tie_for_persistent_memoization {
 		my %lookup_svn_merge_cache;
 		my %check_cherry_pick_cache;
 		my %has_no_changes_cache;
+		my %_rev_list_cache;
 
 		tie_for_persistent_memoization(\%lookup_svn_merge_cache,
-		    "$cache_path/lookup_svn_merge");
+				"$cache_path/lookup_svn_merge");
 		memoize 'lookup_svn_merge',
-			SCALAR_CACHE => 'FAULT',
-			LIST_CACHE => ['HASH' => \%lookup_svn_merge_cache],
-		;
+				SCALAR_CACHE => 'FAULT',
+				LIST_CACHE => ['HASH' => \%lookup_svn_merge_cache],
+				;
 
 		tie_for_persistent_memoization(\%check_cherry_pick_cache,
-		    "$cache_path/check_cherry_pick");
+				"$cache_path/check_cherry_pick");
 		memoize 'check_cherry_pick',
-			SCALAR_CACHE => 'FAULT',
-			LIST_CACHE => ['HASH' => \%check_cherry_pick_cache],
-		;
+				SCALAR_CACHE => 'FAULT',
+				LIST_CACHE => ['HASH' => \%check_cherry_pick_cache],
+				;
 
 		tie_for_persistent_memoization(\%has_no_changes_cache,
-		    "$cache_path/has_no_changes");
+				"$cache_path/has_no_changes");
 		memoize 'has_no_changes',
-			SCALAR_CACHE => ['HASH' => \%has_no_changes_cache],
-			LIST_CACHE => 'FAULT',
-		;
+				SCALAR_CACHE => ['HASH' => \%has_no_changes_cache],
+				LIST_CACHE => 'FAULT',
+				;
+
+		tie_for_persistent_memoization(\%_rev_list_cache,
+				"$cache_path/_rev_list");
+		memoize '_rev_list',
+				SCALAR_CACHE => 'FAULT',
+				LIST_CACHE => ['HASH' => \%_rev_list_cache],
+				;
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
+my %rebuildStatus;
+#define a global associate map to record rebuild verify status
+my %rebuildVerifyStatus;
+
 sub rebuild {
 	my ($self) = @_;
 	my $map_path = $self->map_path;
 	my $partial = (-e $map_path && ! -z $map_path);
-	return unless ::verify_ref($self->refname.'^0');
+    my $verifyKey = $self->refname.'^0';
+    if (! exists $rebuildVerifyStatus{$verifyKey} || ! defined $rebuildVerifyStatus{$verifyKey} ) {
+        my $verifyResult = ::verify_ref($verifyKey);
+        if ($verifyResult) {
+            $rebuildVerifyStatus{$verifyKey} = 1;
+        }
+    }
+    if (! exists $rebuildVerifyStatus{$verifyKey}) {
+        return;
+    }
 	if (!$partial && ($self->use_svm_props || $self->no_metadata)) {
 		my $rev_db = $self->rev_db_path;
 		$self->rebuild_from_rev_db($rev_db);
@@ -1977,10 +2001,21 @@ sub rebuild {
 	print "Rebuilding $map_path ...\n" if (!$partial);
 	my ($base_rev, $head) = ($partial ? $self->rev_map_max_norebuild(1) :
 		(undef, undef));
+    my $keyValue = ($head ? "$head.." : "") . $self->refname;
+    if (exists $rebuildStatus{$keyValue}) {
+        print "Done rebuilding $map_path\n" if (!$partial || !$head);
+        my $rev_db_path = $self->rev_db_path;
+        if (-f $self->rev_db_path) {
+            unlink $self->rev_db_path or croak "unlink: $!";
+        }
+        $self->unlink_rev_db_symlink;
+		return;
+    }
 	my ($log, $ctx) =
 	    command_output_pipe(qw/rev-list --pretty=raw --reverse/,
-				($head ? "$head.." : "") . $self->refname,
+			    $keyValue,	
 				'--');
+    $rebuildStatus{$keyValue} = 1;
 	my $metadata_url = $self->metadata_url;
 	remove_username($metadata_url);
 	my $svn_uuid = $self->rewrite_uuid || $self->ra_uuid;
-- 
1.8.3.2
