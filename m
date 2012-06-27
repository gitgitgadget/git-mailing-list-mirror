From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 4/5] git-remote-mediawiki: split get_mw_pages into smaller functions
Date: Wed, 27 Jun 2012 11:10:19 +0200
Message-ID: <1340788220-10084-5-git-send-email-Matthieu.Moy@imag.fr>
References: <1340726673-25496-1-git-send-email-Matthieu.Moy@imag.fr>
 <1340788220-10084-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Pavel.Volek@ensimag.imag.fr, Kim-Thuat.Nguyen@ensimag.imag.fr,
	roucherj@ensimag.imag.fr, Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jun 27 11:11:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjoHC-0005rw-7Y
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jun 2012 11:11:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756539Ab2F0JKw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jun 2012 05:10:52 -0400
Received: from mx2.imag.fr ([129.88.30.17]:41223 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752201Ab2F0JKs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2012 05:10:48 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q5R99uNT020877
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 27 Jun 2012 11:09:56 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SjoGm-0003PP-Tq; Wed, 27 Jun 2012 11:10:40 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SjoGm-0002dp-Se; Wed, 27 Jun 2012 11:10:40 +0200
X-Mailer: git-send-email 1.7.11.5.g0c7e058.dirty
In-Reply-To: <1340788220-10084-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 27 Jun 2012 11:09:57 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5R99uNT020877
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1341392999.47159@66IV3JuNsA/WxRhJdjz+nA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200708>


Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/mw-to-git/git-remote-mediawiki | 106 +++++++++++++++++++--------------
 1 file changed, 62 insertions(+), 44 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
index 3405772..76d8824 100755
--- a/contrib/mw-to-git/git-remote-mediawiki
+++ b/contrib/mw-to-git/git-remote-mediawiki
@@ -258,6 +258,64 @@ sub mw_connect_maybe {
 	}
 }
 
+## Functions for listing pages on the remote wiki
+sub get_mw_tracked_pages {
+	my $pages = shift;
+	my @some_pages = @tracked_pages;
+	while (@some_pages) {
+		my $last = 50;
+		if ($#some_pages < $last) {
+			$last = $#some_pages;
+		}
+		my @slice = @some_pages[0..$last];
+		get_mw_first_pages(\@slice, $pages);
+		@some_pages = @some_pages[51..$#some_pages];
+	}
+}
+
+sub get_mw_tracked_categories {
+	my $pages = shift;
+	foreach my $category (@tracked_categories) {
+		if (index($category, ':') < 0) {
+			# Mediawiki requires the Category
+			# prefix, but let's not force the user
+			# to specify it.
+			$category = "Category:" . $category;
+		}
+		my $mw_pages = $mediawiki->list( {
+			action => 'query',
+			list => 'categorymembers',
+			cmtitle => $category,
+			cmlimit => 'max' } )
+			|| die $mediawiki->{error}->{code} . ': '
+				. $mediawiki->{error}->{details};
+		foreach my $page (@{$mw_pages}) {
+			$pages->{$page->{title}} = $page;
+		}
+	}
+}
+
+sub get_mw_all_pages {
+	my $pages = shift;
+	# No user-provided list, get the list of pages from the API.
+	my $mw_pages = $mediawiki->list({
+		action => 'query',
+		list => 'allpages',
+		aplimit => 'max'
+	});
+	if (!defined($mw_pages)) {
+		print STDERR "fatal: could not get the list of wiki pages.\n";
+		print STDERR "fatal: '$url' does not appear to be a mediawiki\n";
+		print STDERR "fatal: make sure '$url/api.php' is a valid page.\n";
+		exit 1;
+	}
+	foreach my $page (@{$mw_pages}) {
+		$pages->{$page->{title}} = $page;
+	}
+}
+
+# queries the wiki for a set of pages. Meant to be used within a loop
+# querying the wiki for slices of page list.
 sub get_mw_first_pages {
 	my $some_pages = shift;
 	my @some_pages = @{$some_pages};
@@ -286,6 +344,7 @@ sub get_mw_first_pages {
 	}
 }
 
+# Get the list of pages to be fetched according to configuration.
 sub get_mw_pages {
 	mw_connect_maybe();
 
@@ -295,55 +354,14 @@ sub get_mw_pages {
 		$user_defined = 1;
 		# The user provided a list of pages titles, but we
 		# still need to query the API to get the page IDs.
-
-		my @some_pages = @tracked_pages;
-		while (@some_pages) {
-			my $last = 50;
-			if ($#some_pages < $last) {
-				$last = $#some_pages;
-			}
-			my @slice = @some_pages[0..$last];
-			get_mw_first_pages(\@slice, \%pages);
-			@some_pages = @some_pages[51..$#some_pages];
-		}
+		get_mw_tracked_pages(\%pages);
 	}
 	if (@tracked_categories) {
 		$user_defined = 1;
-		foreach my $category (@tracked_categories) {
-			if (index($category, ':') < 0) {
-				# Mediawiki requires the Category
-				# prefix, but let's not force the user
-				# to specify it.
-				$category = "Category:" . $category;
-			}
-			my $mw_pages = $mediawiki->list( {
-				action => 'query',
-				list => 'categorymembers',
-				cmtitle => $category,
-				cmlimit => 'max' } )
-			    || die $mediawiki->{error}->{code} . ': ' . $mediawiki->{error}->{details};
-			foreach my $page (@{$mw_pages}) {
-				$pages{$page->{title}} = $page;
-			}
-		}
+		get_mw_tracked_categories(\%pages);
 	}
 	if (!$user_defined) {
-		# No user-provided list, get the list of pages from
-		# the API.
-		my $mw_pages = $mediawiki->list({
-			action => 'query',
-			list => 'allpages',
-			aplimit => 500,
-		});
-		if (!defined($mw_pages)) {
-			print STDERR "fatal: could not get the list of wiki pages.\n";
-			print STDERR "fatal: '$url' does not appear to be a mediawiki\n";
-			print STDERR "fatal: make sure '$url/api.php' is a valid page.\n";
-			exit 1;
-		}
-		foreach my $page (@{$mw_pages}) {
-			$pages{$page->{title}} = $page;
-		}
+		get_mw_all_pages(\%pages);
 	}
 	return values(%pages);
 }
-- 
1.7.11.5.g0c7e058.dirty
