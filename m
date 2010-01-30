From: Andrew Myrick <amyrick@apple.com>
Subject: [PATCH] git-svn: persistent memoization
Date: Sat, 30 Jan 2010 03:14:22 +0000
Message-ID: <1264821262-28322-1-git-send-email-amyrick@apple.com>
Content-Transfer-Encoding: 7BIT
Cc: normalperson@yhbt.net, sam@vilain.net,
	Andrew Myrick <amyrick@apple.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 30 04:14:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nb3nC-0004Vx-Ks
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 04:14:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756219Ab0A3DOd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 22:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755216Ab0A3DOd
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 22:14:33 -0500
Received: from mail-out3.apple.com ([17.254.13.22]:56725 "EHLO
	mail-out3.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755187Ab0A3DOc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 22:14:32 -0500
Received: from relay11.apple.com (relay11.apple.com [17.128.113.48])
	by mail-out3.apple.com (Postfix) with ESMTP id 39C2882AE02D
	for <git@vger.kernel.org>; Fri, 29 Jan 2010 19:14:32 -0800 (PST)
X-AuditID: 11807130-b7b0aae00000102c-f0-4b63a41897fd
Received: from gertie.apple.com (gertie.apple.com [17.151.62.15])
	by relay11.apple.com (Apple SCV relay) with SMTP id 59.21.04140.814A36B4; Fri, 29 Jan 2010 19:14:32 -0800 (PST)
Received: from localhost.localdomain (agility.apple.com [17.201.24.116])
 by gertie.apple.com
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPSA id <0KX100E47IC47240@gertie.apple.com> for git@vger.kernel.org;
 Fri, 29 Jan 2010 19:14:32 -0800 (PST)
X-Mailer: git-send-email 1.6.6.1.4.g3df0a5.dirty
X-Brightmail-Tracker: AAAAAQAAAZE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138433>

Make memoization of the svn:mergeinfo processing functions persistent with
Memoize::Storable so that the memoization tables don't need to be regenerated
every time the user runs git-svn fetch.

The Memoize::Storable hashes are stored in ENV{GIT_DIR}/svn/caches.

Signed-off-by: Andrew Myrick <amyrick@apple.com>
---
 git-svn.perl |   42 +++++++++++++++++++++++++++++++++++++-----
 1 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 1f201e4..f7a9410 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1632,10 +1632,11 @@ use vars qw/$default_repo_id $default_ref_id $_no_metadata $_follow_parent
             $_use_svnsync_props $no_reuse_existing $_minimize_url
 	    $_use_log_author $_add_author_from $_localtime/;
 use Carp qw/croak/;
-use File::Path qw/mkpath/;
+use File::Path qw/mkpath make_path/;
 use File::Copy qw/copy/;
 use IPC::Open3;
 use Memoize;  # core since 5.8.0, Jul 2002
+use Memoize::Storable;
 
 my ($_gc_nr, $_gc_period);
 
@@ -3078,10 +3079,39 @@ sub has_no_changes {
 		command_oneline("rev-parse", "$commit~1^{tree}"));
 }
 
-BEGIN {
-	memoize 'lookup_svn_merge';
-	memoize 'check_cherry_pick';
-	memoize 'has_no_changes';
+# The GIT_DIR environment variable is not always set until after the command
+# line arguments are processed, so we can't memoize in a BEGIN block.
+{
+	my $memoized = 0;
+
+	sub memoize_svn_mergeinfo_functions {
+		return if $memoized;
+		$memoized = 1;
+
+		my $cache_path = "$ENV{GIT_DIR}/svn/caches/";
+		make_path($cache_path) unless -d $cache_path;
+
+		tie my %lookup_svn_merge_cache =>
+			'Memoize::Storable',"$cache_path/lookup_svn_merge.db", 'nstore';
+		memoize 'lookup_svn_merge',
+			SCALAR_CACHE => 'FAULT',
+			LIST_CACHE => ['HASH' => \%lookup_svn_merge_cache],
+		;
+
+		tie my %check_cherry_pick_cache =>
+			'Memoize::Storable',"$cache_path/check_cherry_pick.db", 'nstore';
+		memoize 'check_cherry_pick',
+			SCALAR_CACHE => 'FAULT',
+			LIST_CACHE => ['HASH' => \%check_cherry_pick_cache],
+		;
+
+		tie my %has_no_changes_cache =>
+			'Memoize::Storable',"$cache_path/has_no_changes.db", 'nstore';
+		memoize 'has_no_changes',
+			SCALAR_CACHE => ['HASH' => \%has_no_changes_cache],
+			LIST_CACHE => 'FAULT',
+		;
+	}
 }
 
 sub parents_exclude {
@@ -3125,6 +3155,8 @@ sub find_extra_svn_parents {
 	my ($self, $ed, $mergeinfo, $parents) = @_;
 	# aha!  svk:merge property changed...
 
+	memoize_svn_mergeinfo_functions();
+
 	# We first search for merged tips which are not in our
 	# history.  Then, we figure out which git revisions are in
 	# that tip, but not this revision.  If all of those revisions
-- 
1.6.6.1.4.g3df0a5.dirty
