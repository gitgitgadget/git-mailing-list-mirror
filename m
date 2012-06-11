From: Pavel Volek <Pavel.Volek@ensimag.imag.fr>
Subject: [PATCHv2 2/2] git-remote-mediawiki: refactoring get_mw_pages function
Date: Mon, 11 Jun 2012 21:29:05 +0200
Message-ID: <1339442945-8561-2-git-send-email-Pavel.Volek@ensimag.imag.fr>
References: <1339442945-8561-1-git-send-email-Pavel.Volek@ensimag.imag.fr>
Cc: Volek Pavel <me@pavelvolek.cz>,
	Pavel Volek <Pavel.Volek@ensimag.imag.fr>,
	NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>,
	ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 11 21:30:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeAJW-00030C-39
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 21:30:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250Ab2FKTaD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 15:30:03 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:53539 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068Ab2FKTaC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 15:30:02 -0400
Received: by wgbdr13 with SMTP id dr13so3624740wgb.1
        for <git@vger.kernel.org>; Mon, 11 Jun 2012 12:30:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=RqEixveFmbqS56tALRfd93k3Wr8ns0d0qCJeQNFopHA=;
        b=A9G+AfnGpI28P7qb8o6f8yfMt7WdugaEi5e/MCIDFoGb7P0Z64fQPE1Iyzd7UHk3Uf
         g5YnXa8/uzzW2+5UbLf6wguiLihxrjERxEBZ42VWPKG6BCJ8J4SqyNZc8mDPMfPl/KS4
         g3O7di4nkdC1U17XS7fRoL7jbyn0blbSf39n+SxGv5tv9lpO7NnEnklfd4bi8Z7wttK/
         h5wBIATBM1KEA7RvE1rWrj2bhzMaqM0PdH6zvUJkAIAI+HABBWlGqc9O3cmvhR7TpY/1
         ++242xuGqDbiWZ0dGcRzHfOSv2qGKChImmUTiPb75hsPo3IOCGt66CfwIlXXyOyGpUxe
         ETpA==
Received: by 10.216.210.229 with SMTP id u79mr7748897weo.31.1339443000854;
        Mon, 11 Jun 2012 12:30:00 -0700 (PDT)
Received: from volek-HP.grenet.fr (wifi-123088.grenet.fr. [130.190.123.88])
        by mx.google.com with ESMTPS id i10sm637391wiy.10.2012.06.11.12.29.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Jun 2012 12:30:00 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.552.gaa3bb87
In-Reply-To: <1339442945-8561-1-git-send-email-Pavel.Volek@ensimag.imag.fr>
X-Gm-Message-State: ALoCoQmj60KGsr8/YovEdF6o0txrSuZcfXRnqcGqibs6+komZ3Cyhhh2ZB88kUNGXIcAcN56Kjut
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199714>

From: Volek Pavel <me@pavelvolek.cz>

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
 contrib/mw-to-git/git-remote-mediawiki | 144 ++++++++++++++++++---------------
 1 file changed, 79 insertions(+), 65 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
index 14008ad..c0c0df7 100755
--- a/contrib/mw-to-git/git-remote-mediawiki
+++ b/contrib/mw-to-git/git-remote-mediawiki
@@ -212,91 +212,105 @@ sub get_mw_pages {
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
-		# Get pages of related media files.
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
-			# Get pages of related media files.
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
+		# Attach list of all pages for meadia files from the API,
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
 		}
+		my @slice = @some_pages[0..$last];
+		get_mw_first_pages(\@slice, \%{$pages});
+		@some_pages = @some_pages[51..$#some_pages];
+	}
+
+	# Get pages of related media files.
+	if ($import_media) {
+		get_mw_pages_for_linked_mediafiles(\@tracked_pages, \%{$pages});
+	}
+}
 
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
+
+		# Get pages of related media files.
 		if ($import_media) {
-			# Attach list of all pages for meadia files from the API,
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
