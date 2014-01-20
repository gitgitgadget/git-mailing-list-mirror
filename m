From: manjian2006@gmail.com
Subject: [PATCH] improve git svn performance
Date: Mon, 20 Jan 2014 12:37:52 +0800
Message-ID: <1390192672-3827-1-git-send-email-manjian2006@gmail.com>
Cc: linzj <linzj@ucweb.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 20 05:38:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W56cl-0001EO-7g
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jan 2014 05:38:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752644AbaATEiH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jan 2014 23:38:07 -0500
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35659 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752574AbaATEiG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jan 2014 23:38:06 -0500
Received: by mail-pa0-f51.google.com with SMTP id ld10so4218954pab.10
        for <git@vger.kernel.org>; Sun, 19 Jan 2014 20:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=2BPjKe3D6CCZrt4XpcTgO657zTPF1GdtU5Xhsm6AGfQ=;
        b=cFJi3uHJwb22UXniCwOvaBuI06eiWfgGWMav+qp6sIYLhSrNyZLSKo8IEpp84A/5Mr
         l8ylgBqeIpk4PIAumyA41n5aNcL5Ac/iNtLRgpJiyQ+HjC1bS2JynOJsPm47XWf7PfzX
         izduHD/ls4gglcM4ijq/k62L/4zWooad9KbDv4h4ePAmm5h+fP+6qCAcmMsJ8iVeDMVF
         Slcl7mVy9EpU9xG2es+32UWLYzvcPadRT7/iQ1CTPnaX9q9m42W867wUz74O8ymYLcfW
         ObhV7xQMV2Cj7jk0uFwV7Hh1EzY7O9tczLCE1dBxIEihKalYpYo8FfWDJU0KqSQwYHF5
         VIVA==
X-Received: by 10.68.254.230 with SMTP id al6mr16465587pbd.3.1390192684863;
        Sun, 19 Jan 2014 20:38:04 -0800 (PST)
Received: from ubuntu.dhcp.ucweb.local ([70.39.187.196])
        by mx.google.com with ESMTPSA id gn5sm40835421pbc.29.2014.01.19.20.38.02
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 19 Jan 2014 20:38:04 -0800 (PST)
X-Mailer: git-send-email 1.8.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240708>

From: linzj <linzj@ucweb.com>

Hi,
  I am trying to improve git svn's performance according to some profiling data.As the data showed,_rev_list subroutine and rebuild subroutine are consuming a large proportion of time.So I improve _rev_list's performance by memoize its results,and avoid subprocess invocation by memoize rebuild subroutine's key data.Here's my patch:
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
