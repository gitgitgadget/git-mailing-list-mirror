From: Pavel Volek <Pavel.Volek@ensimag.imag.fr>
Subject: [PATCHv4 2/2] git-remote-mediawiki: refactoring get_mw_pages function
Date: Thu, 14 Jun 2012 14:26:38 +0200
Message-ID: <1339676798-6286-2-git-send-email-Pavel.Volek@ensimag.imag.fr>
References: <1339676798-6286-1-git-send-email-Pavel.Volek@ensimag.imag.fr>
Cc: Pavel Volek <Pavel.Volek@ensimag.imag.fr>,
	NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>,
	ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 14 14:27:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sf99M-0004G5-JP
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jun 2012 14:27:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755784Ab2FNM1k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jun 2012 08:27:40 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:35668 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755463Ab2FNM1j (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2012 08:27:39 -0400
Received: by weyu7 with SMTP id u7so1212616wey.19
        for <git@vger.kernel.org>; Thu, 14 Jun 2012 05:27:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=ipvqMlpPyNIckSNuNFDdEs/64chsoG/zQic1SsxAh+0=;
        b=T/CWfqr8+klytdgXkxzg9QGLzeqa4PcgeHljuiWlLif9y2EUPYiIW2gAGgeAHgcg+Y
         8kvUxjJ+AfHU5uIfHXAEGLUZJFXZcNT56vVgRfzR4KvsLgf17ThBfZaZUseZIzsmQPX4
         EDt/5S6aH4mL9jctH5LU27BEqcmAeCQ8gTphYC8IcnnOtakimMlI88d3oSu42gbqNWRA
         tNOvvPy7CO7iVh3zsIRML20sR1GUEF289k+qpsEM+/z3Cc77Ie7wH2M3Ncxwz0lzVkX4
         GsjneS95REpq29zIPRKABJF8xqE+I75LHK6DTgm8FdZlkDH40twKzLUGcKT9JEcXQVpt
         yTFg==
Received: by 10.216.142.167 with SMTP id i39mr928078wej.94.1339676858116;
        Thu, 14 Jun 2012 05:27:38 -0700 (PDT)
Received: from volek-HP.grenet.fr (wifi-123088.grenet.fr. [130.190.123.88])
        by mx.google.com with ESMTPS id f19sm19973868wiw.11.2012.06.14.05.27.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 14 Jun 2012 05:27:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.552.gaa3bb87
In-Reply-To: <1339676798-6286-1-git-send-email-Pavel.Volek@ensimag.imag.fr>
X-Gm-Message-State: ALoCoQk+IAETVg4UQNYYrg6+KyEIxJ+Mz4xFAU8mFE3N7dWUrTHCzYldVVM16olCgOKCtPcdh4qi
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200003>

Splits the code in the get_mw_pages function into three separate functions.
One for getting list of all pages and all file attachments, second for pages
in category specified in configuration file and files related to these pages
and the last function to get from MW a list of specified pages with related
file attachments.

Signed-off-by: Pavel Volek <Pavel.Volek@ensimag.imag.fr>
Signed-off-by: NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>
Signed-off-by: ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/mw-to-git/git-remote-mediawiki | 120 ++++++++++++++++++---------------
 1 file changed, 67 insertions(+), 53 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
index a51e9ab..866bd6f 100755
--- a/contrib/mw-to-git/git-remote-mediawiki
+++ b/contrib/mw-to-git/git-remote-mediawiki
@@ -224,80 +224,94 @@ sub get_mw_pages {
 	my $user_defined;
 	if (@tracked_pages) {
 		$user_defined = 1;
-		# The user provided a list of pages titles, but we
-		# still need to query the API to get the page IDs.
-		get_mw_first_pages(\@tracked_pages, \%pages);
-
-		if ($import_media) {
-			get_mw_pages_for_linked_mediafiles(\@tracked_pages, \%pages);
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
-				|| die $mediawiki->{error}->{code} . ': '
-					. $mediawiki->{error}->{details};
-			foreach my $page (@{$mw_pages}) {
-				$pages{$page->{title}} = $page;
-			}
-
-			if ($import_media) {
-				my @titles = map $_->{title}, @{$mw_pages};
-				get_mw_pages_for_linked_mediafiles(\@titles, \%pages);
-			}
-		}
+		get_mw_tracked_categories(\%pages);
 	}
 	if (!$user_defined) {
-		# No user-provided list, get the list of pages from
-		# the API.
+		get_mw_all_pages(\%pages);
+	}
+	return values(%pages);
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
+
+	if ($import_media) {
+		# Attach list of all pages for media files from the API,
+		# they are in a different namespace, only one namespace
+		# can be queried at the same moment
 		my $mw_pages = $mediawiki->list({
 			action => 'query',
 			list => 'allpages',
+			apnamespace => get_mw_namespace_id("File"),
 			aplimit => 'max'
 		});
 		if (!defined($mw_pages)) {
-			print STDERR "fatal: could not get the list of wiki pages.\n";
+			print STDERR "fatal: could not get the list of pages for media files.\n";
 			print STDERR "fatal: '$url' does not appear to be a mediawiki\n";
 			print STDERR "fatal: make sure '$url/api.php' is a valid page.\n";
 			exit 1;
 		}
 		foreach my $page (@{$mw_pages}) {
-			$pages{$page->{title}} = $page;
+			$pages->{$page->{title}} = $page;
+		}
+	}
+}
+
+sub get_mw_tracked_pages {
+	my $pages = shift;
+	# The user provided a list of pages titles, but we
+	# still need to query the API to get the page IDs.
+	get_mw_first_pages(\@tracked_pages, \%{$pages});
+
+	if ($import_media) {
+		get_mw_pages_for_linked_mediafiles(\@tracked_pages, \%{$pages});
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
 		}
 
 		if ($import_media) {
-			# Attach list of all pages for media files from the API,
-			# they are in a different namespace, only one namespace
-			# can be queried at the same moment
-			my $mw_pages = $mediawiki->list({
-				action => 'query',
-				list => 'allpages',
-				apnamespace => get_mw_namespace_id("File"),
-				aplimit => 'max'
-			});
-			if (!defined($mw_pages)) {
-				print STDERR "fatal: could not get the list of pages for media files.\n";
-				print STDERR "fatal: '$url' does not appear to be a mediawiki\n";
-				print STDERR "fatal: make sure '$url/api.php' is a valid page.\n";
-				exit 1;
-			}
-			foreach my $page (@{$mw_pages}) {
-				$pages{$page->{title}} = $page;
-			}
+			my @titles = map $_->{title}, @{$mw_pages};
+			get_mw_pages_for_linked_mediafiles(\@titles, \%{$pages});
 		}
 	}
-	return values(%pages);
 }
 
 sub get_mw_pages_for_linked_mediafiles {
-- 
1.7.10.2.552.gaa3bb87
