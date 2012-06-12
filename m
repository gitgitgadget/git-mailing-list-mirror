From: Pavel Volek <Pavel.Volek@ensimag.imag.fr>
Subject: [PATCHv3 2/2] git-remote-mediawiki: refactoring get_mw_pages function
Date: Tue, 12 Jun 2012 22:14:51 +0200
Message-ID: <1339532091-25232-2-git-send-email-Pavel.Volek@ensimag.imag.fr>
References: <1339532091-25232-1-git-send-email-Pavel.Volek@ensimag.imag.fr>
Cc: Pavel VOlek <Pavel.Volek@ensimag.imag.fr>,
	NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>,
	ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 12 22:15:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeXVF-0005CI-O6
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 22:15:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753557Ab2FLUPp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 16:15:45 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:53812 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752070Ab2FLUPo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 16:15:44 -0400
Received: by wibhn6 with SMTP id hn6so4535901wib.1
        for <git@vger.kernel.org>; Tue, 12 Jun 2012 13:15:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=mfsvnt+OUHE0b3DGbeiyAzNYAaTF5TV+Zs1z1vFCRok=;
        b=WL+yeoYjpuwTy54cidUDon3gDuuv2pQagXGN+bskHNUU3SkWidH/5QS82Tu04rFkGW
         YeONMLj+tymB2J2+cHOu+hxOAk6jh/V6BPuLkwgoyxpLhUe/Yp30dwFcKzUH0zjsggfp
         XTcJaikldIXLitKvcCZON5rnXDuDCft5k3fKeLX3QskX55gmZiCtte/+OiNN0Uo8zJhk
         tHQEUFPHIT+8RXpfTvcqaz/bbW6EHff8f8TvKvGV0uuzcZQaq4SzJOqr7RH6VVSquOxV
         bIvGzztxRpDhG8BqhgVGP1nrrMgxAolNqWmJVkUYYeTWjdUtohMFP59kCi6eZIrrgmNi
         6WCw==
Received: by 10.216.19.195 with SMTP id n45mr2302477wen.69.1339532142610;
        Tue, 12 Jun 2012 13:15:42 -0700 (PDT)
Received: from volek-HP.rooms.iriga (221.63.68.86.rev.sfr.net. [86.68.63.221])
        by mx.google.com with ESMTPS id z8sm1265159wiy.1.2012.06.12.13.15.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 12 Jun 2012 13:15:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.552.gaa3bb87
In-Reply-To: <1339532091-25232-1-git-send-email-Pavel.Volek@ensimag.imag.fr>
X-Gm-Message-State: ALoCoQn00CMdhxH5l/7uQWjY8s0spz0dhy2vGuitYsE5pRGw2nR8X3V0z+29W+XHraoNOL3m2kA8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199846>

From: Pavel VOlek <Pavel.Volek@ensimag.imag.fr>

Splits the code in the get_mw_pages function into three separate functions.
One for getting list of all pages and all file attachments, second for pages
in category specified in configuration file and files related to these pages
and the last function to get from MW a list of specified pages with related
file attachments.

Chages version2 -> version3:
Fixes in comments.

Signed-off-by: Pavel Volek <Pavel.Volek@ensimag.imag.fr>
Signed-off-by: NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>
Signed-off-by: ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/mw-to-git/git-remote-mediawiki | 140 ++++++++++++++++++---------------
 1 file changed, 77 insertions(+), 63 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
index 04d3959..ace1868 100755
--- a/contrib/mw-to-git/git-remote-mediawiki
+++ b/contrib/mw-to-git/git-remote-mediawiki
@@ -212,89 +212,103 @@ sub get_mw_pages {
 	my $user_defined;
 	if (@tracked_pages) {
 		$user_defined = 1;
-		# The user provided a list of pages titles, but we
-		# still need to query the API to get the page IDs.
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
-			    || die $mediawiki->{error}->{code} . ': ' . $mediawiki->{error}->{details};
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
+		aplimit => 500
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
-			aplimit => 500,
+			apnamespace => get_mw_namespace_id("File"),
+			aplimit => 500
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
+	my @some_pages = @tracked_pages;
+	while (@some_pages) {
+		my $last = 50;
+		if ($#some_pages < $last) {
+			$last = $#some_pages;
+		}
+		my @slice = @some_pages[0..$last];
+		get_mw_first_pages(\@slice, \%{$pages});
+		@some_pages = @some_pages[51..$#some_pages];
+	}
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
-				aplimit => 500
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
