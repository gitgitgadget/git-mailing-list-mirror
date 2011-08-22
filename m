From: Jason Gross <jgross@MIT.EDU>
Subject: [PATCH] git-svn: Destroy the cache when we fail to read it
Date: Sun, 21 Aug 2011 22:17:02 -0400
Message-ID: <1313979422-21286-1-git-send-email-jgross@mit.edu>
Cc: Jason Gross <jgross@mit.edu>, Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 22 04:17:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvK4j-0001pG-9L
	for gcvg-git-2@lo.gmane.org; Mon, 22 Aug 2011 04:17:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756639Ab1HVCRM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Aug 2011 22:17:12 -0400
Received: from DMZ-MAILSEC-SCANNER-2.MIT.EDU ([18.9.25.13]:48330 "EHLO
	dmz-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751887Ab1HVCRL (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Aug 2011 22:17:11 -0400
X-AuditID: 1209190d-b7be0ae000000a16-39-4e51bb6d9f47
Received: from mailhub-auth-4.mit.edu ( [18.7.62.39])
	by dmz-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id A8.FC.02582.D6BB15E4; Sun, 21 Aug 2011 22:14:05 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-4.mit.edu (8.13.8/8.9.2) with ESMTP id p7M2HACp002629;
	Sun, 21 Aug 2011 22:17:10 -0400
Received: from localhost (DR-WILY.MIT.EDU [18.181.0.233])
	(authenticated bits=0)
        (User authenticated as jgross@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id p7M2H9xR021665;
	Sun, 21 Aug 2011 22:17:09 -0400 (EDT)
X-Mailer: git-send-email 1.7.2.3
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsUixG6nrpu7O9DP4PgTY4uuK91MFn92tLBZ
	vL25hNGB2WPnrLvsHp83yQUwRXHZpKTmZJalFunbJXBlnJr3i7mgR6rixeqv7A2Ms0S7GDk5
	JARMJO58amSCsMUkLtxbz9bFyMUhJLCPUeLOyp/sIAkhgQ2MEj0LBCESXxklFk9qYgFJsAko
	SdzeuIgRxBYREJd4e3wmWAOzgJvEnB2rwKYKCzhLNN/bAGazCKhK7DnyCayGV8BO4u33Z2wQ
	mxUkXt1Yyz6BkWcBI8MqRtmU3Crd3MTMnOLUZN3i5MS8vNQiXSO93MwSvdSU0k2MoEDglOTd
	wfjuoNIhRgEORiUe3g6jQD8h1sSy4srcQ4ySHExKorztO4FCfEn5KZUZicUZ8UWlOanFhxgl
	OJiVRHh7VgLleFMSK6tSi/JhUtIcLErivIU7HPyEBNITS1KzU1MLUotgsjIcHEoSvNnAgBcS
	LEpNT61Iy8wpQUgzcXCCDOcBGt4NUsNbXJCYW5yZDpE/xajLMfndiWOMQix5+XmpUuK8pSBF
	AiBFGaV5cHNgEfyKURzoLWHeHJAqHmD0w016BbSECWjJhJUBIEtKEhFSUg2MShH+SQ2lqy3Z
	W3ZnrTPVUH5+7UVVoCGP2JMmyWs/75jmMf36e/eGyblPd7g3n4mwNUlecVqysvAca2BEneoF
	X4N1+n3npszrT3bYI5Zi4Xz2XEhI3eq3axlnLAzSdpuh+fXN1qcHeafEeHF/XvZ8m4LHE8e3
	ntUKse7feyaYLXHY3PFRXVRRiaU4I9FQi7moOBEAyCklErsCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179834>

Previously, we would fail fatally when trying to fetch changes with
mergeinfo on a 32 bit machine, when the repository previously had
fetched changes with mergeinfo on a 64 bit machine.

This fixes bug 618875 (which is also 587650, 635097).  Much of the code
was written by Jonathan Nieder <jrnieder@gmail.com> with suggestions
from Steffen Mueller <smueller@cpan.org> (see
http://lists.debian.org/debian-perl/2011/05/msg00023.html and
http://lists.debian.org/debian-perl/2011/05/msg00026.html).

Signed-off-by: Jason Gross <jgross@mit.edu>
Cc: Jonathan Nieder <jrnieder@gmail.com>
---
 git-svn.perl |   59 +++++++++++++++++++++++++++++++++++----------------------
 1 files changed, 36 insertions(+), 23 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 89f83fd..78ccdc8 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1680,7 +1680,7 @@ use vars qw/$default_repo_id $default_ref_id $_no_metadata $_follow_parent
             $_use_svnsync_props $no_reuse_existing $_minimize_url
 	    $_use_log_author $_add_author_from $_localtime/;
 use Carp qw/croak/;
-use File::Path qw/mkpath/;
+use File::Path qw/mkpath rmtree/;
 use File::Copy qw/copy/;
 use IPC::Open3;
 use Memoize;  # core since 5.8.0, Jul 2002
@@ -3198,28 +3198,41 @@ sub has_no_changes {
 		$memoized = 1;
 
 		my $cache_path = "$ENV{GIT_DIR}/svn/.caches/";
-		mkpath([$cache_path]) unless -d $cache_path;
-
-		tie my %lookup_svn_merge_cache => 'Memoize::Storable',
-		    "$cache_path/lookup_svn_merge.db", 'nstore';
-		memoize 'lookup_svn_merge',
-			SCALAR_CACHE => 'FAULT',
-			LIST_CACHE => ['HASH' => \%lookup_svn_merge_cache],
-		;
-
-		tie my %check_cherry_pick_cache => 'Memoize::Storable',
-		    "$cache_path/check_cherry_pick.db", 'nstore';
-		memoize 'check_cherry_pick',
-			SCALAR_CACHE => 'FAULT',
-			LIST_CACHE => ['HASH' => \%check_cherry_pick_cache],
-		;
-
-		tie my %has_no_changes_cache => 'Memoize::Storable',
-		    "$cache_path/has_no_changes.db", 'nstore';
-		memoize 'has_no_changes',
-			SCALAR_CACHE => ['HASH' => \%has_no_changes_cache],
-			LIST_CACHE => 'FAULT',
-		;
+		my $do_memoization = sub {
+			mkpath([$cache_path]) unless -d $cache_path;
+
+			tie my %lookup_svn_merge_cache => 'Memoize::Storable',
+			    "$cache_path/lookup_svn_merge.db", 'nstore';
+			memoize 'lookup_svn_merge',
+				SCALAR_CACHE => 'FAULT',
+				LIST_CACHE => ['HASH' => \%lookup_svn_merge_cache],
+			;
+
+			tie my %check_cherry_pick_cache => 'Memoize::Storable',
+			    "$cache_path/check_cherry_pick.db", 'nstore';
+			memoize 'check_cherry_pick',
+				SCALAR_CACHE => 'FAULT',
+				LIST_CACHE => ['HASH' => \%check_cherry_pick_cache],
+			;
+
+			tie my %has_no_changes_cache => 'Memoize::Storable',
+			    "$cache_path/has_no_changes.db", 'nstore';
+			memoize 'has_no_changes',
+				SCALAR_CACHE => ['HASH' => \%has_no_changes_cache],
+				LIST_CACHE => 'FAULT',
+			;
+		};
+
+		if (not eval {
+			$do_memoization->();
+			1;
+		}) {
+			my $err = $@ || "Zombie error"; # "Zombie error" to catch clobbered $@ in buggy destructors
+			die $err unless -d $cache_path;
+			print STDERR "Discarding cache and trying again ($@)\n";
+			rmtree([$cache_path]);
+			$do_memoization->();
+		}
 	}
 
 	sub unmemoize_svn_mergeinfo_functions {
-- 
1.7.2.3
