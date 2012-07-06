From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 11/12] git-remote-mediawiki: more efficient 'pull' in the best case
Date: Fri,  6 Jul 2012 12:03:14 +0200
Message-ID: <1341568995-12467-12-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqhatl9t4a.fsf@bauges.imag.fr>
 <1341568995-12467-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Simon Perrat <simon.perrat@ensimag.imag.fr>,
	Simon CATHEBRAS <Simon.Cathebras@ensimag.imag.fr>,
	Julien KHAYAT <Julien.Khayat@ensimag.imag.fr>,
	Charles ROUSSEL <Charles.Roussel@ensimag.imag.fr>,
	Guillaume SASDY <Guillaume.Sasdy@ensimag.imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jul 06 12:04:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sn5Of-00071j-NX
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 12:04:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756646Ab2GFKEO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jul 2012 06:04:14 -0400
Received: from mx2.imag.fr ([129.88.30.17]:60796 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756542Ab2GFKEM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2012 06:04:12 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q66A2p0h008111
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 6 Jul 2012 12:02:51 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Sn5OO-0003Za-Sy; Fri, 06 Jul 2012 12:04:04 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Sn5OO-0003Hb-RS; Fri, 06 Jul 2012 12:04:04 +0200
X-Mailer: git-send-email 1.7.11.1.147.g47a574d
In-Reply-To: <1341568995-12467-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 06 Jul 2012 12:02:51 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q66A2p0h008111
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1342173774.01526@K73Yp+F25b+mLLlMtNGgjw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201106>

The only way to fetch new revisions from a wiki before this patch was to
query each page for new revisions. This is good when tracking a small set
of pages on a large wiki, but very inefficient when tracking many pages
on a wiki with little activity.

Implement a new strategy that queries the wiki for its last global
revision, queries each new revision, and filter out pages that are not
tracked.

Signed-off-by: Simon Perrat <simon.perrat@ensimag.imag.fr>
Signed-off-by: Simon CATHEBRAS <Simon.Cathebras@ensimag.imag.fr>
Signed-off-by: Julien KHAYAT <Julien.Khayat@ensimag.imag.fr>
Signed-off-by: Charles ROUSSEL <Charles.Roussel@ensimag.imag.fr>
Signed-off-by: Guillaume SASDY <Guillaume.Sasdy@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/mw-to-git/git-remote-mediawiki   | 114 +++++++++++++++++++++++++------
 contrib/mw-to-git/t/t9364-pull-by-rev.sh |  17 +++++
 2 files changed, 110 insertions(+), 21 deletions(-)
 create mode 100755 contrib/mw-to-git/t/t9364-pull-by-rev.sh

diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
index 9305204..6bf1d1a 100755
--- a/contrib/mw-to-git/git-remote-mediawiki
+++ b/contrib/mw-to-git/git-remote-mediawiki
@@ -13,12 +13,9 @@
 #
 # Known limitations:
 #
-# - Poor performance in the best case: it takes forever to check
-#   whether we're up-to-date (on fetch or push) or to fetch a few
-#   revisions from a large wiki, because we use exclusively a
-#   page-based synchronization. We could switch to a wiki-wide
-#   synchronization when the synchronization involves few revisions
-#   but the wiki is large.
+# - Several strategies are provided to fetch modifications from the
+#   wiki, but no automatic heuristics is provided, the user has
+#   to understand and chose which strategy is appropriate for him.
 #
 # - Git renames could be turned into MediaWiki renames (see TODO
 #   below)
@@ -89,6 +86,21 @@ my $shallow_import = run_git("config --get --bool remote.". $remotename .".shall
 chomp($shallow_import);
 $shallow_import = ($shallow_import eq "true");
 
+# Fetch (clone and pull) by revisions instead of by pages. This behavior
+# is more efficient when we have a wiki with lots of pages and we fetch
+# the revisions quite often so that they concern only few pages.
+# Possible values:
+# - by_rev: perform one query per new revision on the remote wiki
+# - by_page: query each tracked page for new revision
+my $fetch_strategy = run_git("config --get remote.$remotename.fetchStrategy");
+unless ($fetch_strategy) {
+	$fetch_strategy = run_git("config --get mediawiki.fetchStrategy");
+}
+chomp($fetch_strategy);
+unless ($fetch_strategy) {
+	$fetch_strategy = "by_page";
+}
+
 # Dumb push: don't update notes and mediawiki ref to reflect the last push.
 #
 # Configurable with mediawiki.dumbPush, or per-remote with
@@ -533,6 +545,26 @@ sub get_last_local_revision {
 # Remember the timestamp corresponding to a revision id.
 my %basetimestamps;
 
+# Get the last remote revision without taking in account which pages are
+# tracked or not. This function makes a single request to the wiki thus
+# avoid a loop onto all tracked pages. This is useful for the fetch-by-rev
+# option.
+sub get_last_global_remote_rev {
+	mw_connect_maybe();
+
+	my $query = {
+		action => 'query',
+		list => 'recentchanges',
+		prop => 'revisions',
+		rclimit => '1',
+		rcdir => 'older',
+	};
+	my $result = $mediawiki->api($query);
+	return $result->{query}->{recentchanges}[0]->{revid};
+}
+
+# Get the last remote revision concerning the tracked pages and the tracked
+# categories.
 sub get_last_remote_revision {
 	mw_connect_maybe();
 
@@ -803,9 +835,6 @@ sub mw_import_ref {
 
 	mw_connect_maybe();
 
-	my %pages_hash = get_mw_pages();
-	my @pages = values(%pages_hash);
-
 	print STDERR "Searching revisions...\n";
 	my $last_local = get_last_local_revision();
 	my $fetch_from = $last_local + 1;
@@ -814,10 +843,35 @@ sub mw_import_ref {
 	} else {
 		print STDERR ", fetching from here.\n";
 	}
-	my ($n, @revisions) = fetch_mw_revisions(\@pages, $fetch_from);
 
-	# Creation of the fast-import stream
-	print STDERR "Fetching & writing export data...\n";
+	my $n = 0;
+	if ($fetch_strategy eq "by_rev") {
+		print STDERR "Fetching & writing export data by revs...\n";
+		$n = mw_import_ref_by_revs($fetch_from);
+	} elsif ($fetch_strategy eq "by_page") {
+		print STDERR "Fetching & writing export data by pages...\n";
+		$n = mw_import_ref_by_pages($fetch_from);
+	} else {
+		print STDERR "fatal: invalid fetch strategy \"$fetch_strategy\".\n";
+		print STDERR "Check your configuration variables remote.$remotename.fetchStrategy and mediawiki.fetchStrategy\n";
+		exit 1;
+	}
+
+	if ($fetch_from == 1 && $n == 0) {
+		print STDERR "You appear to have cloned an empty MediaWiki.\n";
+		# Something has to be done remote-helper side. If nothing is done, an error is
+		# thrown saying that HEAD is refering to unknown object 0000000000000000000
+		# and the clone fails.
+	}
+}
+
+sub mw_import_ref_by_pages {
+
+	my $fetch_from = shift;
+	my %pages_hash = get_mw_pages();
+	my @pages = values(%pages_hash);
+
+	my ($n, @revisions) = fetch_mw_revisions(\@pages, $fetch_from);
 
 	@revisions = sort {$a->{revid} <=> $b->{revid}} @revisions;
 	my @revision_ids = map $_->{revid}, @revisions;
@@ -825,12 +879,26 @@ sub mw_import_ref {
 	return mw_import_revids($fetch_from, \@revision_ids, \%pages_hash);
 }
 
+sub mw_import_ref_by_revs {
+
+	my $fetch_from = shift;
+	my %pages_hash = get_mw_pages();
+
+	my $last_remote = get_last_global_remote_rev();
+	my @revision_ids = $fetch_from..$last_remote;
+	return mw_import_revids($fetch_from, \@revision_ids, \%pages_hash);
+}
+
+# Import revisions given in second argument (array of integers).
+# Only pages appearing in the third argument (hash indexed by page titles)
+# will be imported.
 sub mw_import_revids {
 	my $fetch_from = shift;
 	my $revision_ids = shift;
 	my $pages = shift;
 
 	my $n = 0;
+	my $n_actual = 0;
 	my $last_timestamp = 0; # Placeholer in case $rev->timestamp is undefined
 
 	foreach my $pagerevid (@$revision_ids) {
@@ -848,9 +916,20 @@ sub mw_import_revids {
 		my $result_page = $result_pages[0];
 		my $rev = $result_pages[0]->{revisions}->[0];
 
+	        # Count page even if we skip it, since we display
+		# $n/$total and $total includes skipped pages.
 		$n++;
 
 		my $page_title = $result_page->{title};
+
+		if (!exists($pages->{$page_title})) {
+			print STDERR "$n/", scalar(@$revision_ids),
+				": Skipping revision #$rev->{revid} of $page_title\n";
+			next;
+		}
+
+		$n_actual++;
+
 		my %commit;
 		$commit{author} = $rev->{user} || 'Anonymous';
 		$commit{comment} = $rev->{comment} || '*Empty MediaWiki Message*';
@@ -875,17 +954,10 @@ sub mw_import_revids {
 		# of a file do one common commit for both file and media page.
 		# Else do commit only for that page.
 		print STDERR "$n/", scalar(@$revision_ids), ": Revision #$rev->{revid} of $commit{title}\n";
-		import_file_revision(\%commit, ($fetch_from == 1), $n, \%mediafile);
-	}
-
-	if ($fetch_from == 1 && $n == 0) {
-		print STDERR "You appear to have cloned an empty MediaWiki.\n";
-		# Something has to be done remote-helper side. If nothing is done, an error is
-		# thrown saying that HEAD is refering to unknown object 0000000000000000000
-		# and the clone fails.
+		import_file_revision(\%commit, ($fetch_from == 1), $n_actual, \%mediafile);
 	}
 
-	return $n;
+	return $n_actual;
 }
 
 sub error_non_fast_forward {
diff --git a/contrib/mw-to-git/t/t9364-pull-by-rev.sh b/contrib/mw-to-git/t/t9364-pull-by-rev.sh
new file mode 100755
index 0000000..5c22457
--- /dev/null
+++ b/contrib/mw-to-git/t/t9364-pull-by-rev.sh
@@ -0,0 +1,17 @@
+#!/bin/sh
+
+test_description='Test the Git Mediawiki remote helper: git pull by revision'
+
+. ./test-gitmw-lib.sh
+. ./push-pull-tests.sh
+. $TEST_DIRECTORY/test-lib.sh
+
+test_check_precond
+
+test_expect_success 'configuration' '
+	git config --global mediawiki.fetchStrategy by_rev
+'
+
+test_push_pull
+
+test_done
-- 
1.7.11.1.147.g47a574d
