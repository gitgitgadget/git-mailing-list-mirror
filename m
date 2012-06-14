From: Pavel Volek <Pavel.Volek@ensimag.imag.fr>
Subject: [PATCHv4 1/2] git-remote-mediawiki: import "File:" attachments
Date: Thu, 14 Jun 2012 14:26:37 +0200
Message-ID: <1339676798-6286-1-git-send-email-Pavel.Volek@ensimag.imag.fr>
Cc: Pavel Volek <Pavel.Volek@ensimag.imag.fr>,
	NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>,
	ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 14 14:27:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sf99B-00067m-Ld
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jun 2012 14:27:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755742Ab2FNM1c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jun 2012 08:27:32 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:36426 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753396Ab2FNM1a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2012 08:27:30 -0400
Received: by wibhn6 with SMTP id hn6so1875145wib.1
        for <git@vger.kernel.org>; Thu, 14 Jun 2012 05:27:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer
         :x-gm-message-state;
        bh=bHbPpZ3YHuR83b5NtIgff/u3NNYn6RtOHBpolhH3hHM=;
        b=jFWnj3HRFk7YlMaiT3cvcFM+4Bv9m+Z9/3lC6rtUUBtL0DVfKDFtSCA7ZPAlKLHG5D
         ICYsVGHd/CeN6AJqiotTpFC0p7wc5CFE0OA1HOOVFNKK/DtDovQ6tjMDpvKMc0Fd+ImM
         ZxsUPJM1yEupuGJv2NuLh1C3WyvzhfqiOKUTL+E5XpLID3NdV/SXTek55NPIP7ZcjuKK
         AzdCottnxnknVZuggyFzpk0RX+ekzx3zMw/Vct4JLIJUEpVIxcMvuhq0KYo5cV4cSrgy
         pgYCEv7O7RWswdfkbqQJ5YVFTFJDL6RHZIB9ci3HgTCvkwWU6ebntkHhE8QXh7drACF+
         8eNA==
Received: by 10.180.84.6 with SMTP id u6mr46337323wiy.11.1339676848505;
        Thu, 14 Jun 2012 05:27:28 -0700 (PDT)
Received: from volek-HP.grenet.fr (wifi-123088.grenet.fr. [130.190.123.88])
        by mx.google.com with ESMTPS id f19sm19973868wiw.11.2012.06.14.05.27.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 14 Jun 2012 05:27:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.552.gaa3bb87
X-Gm-Message-State: ALoCoQldsOkTm51ByX0eGwuJtbH5lkkifNUbb2w9IXVXctmiW1fVipY3+heK9Ih32B6cgObPN++m
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200002>

The current version of the git-remote-mediawiki supports only import and export
of the pages, doesn't support import and export of file attachments which are
also exposed by MediaWiki API. This patch adds the functionality to import file
attachments and description pages for these files.

Signed-off-by: Pavel Volek <Pavel.Volek@ensimag.imag.fr>
Signed-off-by: NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>
Signed-off-by: ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/mw-to-git/git-remote-mediawiki | 299 +++++++++++++++++++++++++++++----
 1 file changed, 266 insertions(+), 33 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
index c18bfa1..a51e9ab 100755
--- a/contrib/mw-to-git/git-remote-mediawiki
+++ b/contrib/mw-to-git/git-remote-mediawiki
@@ -13,9 +13,6 @@
 #
 # Known limitations:
 #
-# - Only wiki pages are managed, no support for [[File:...]]
-#   attachments.
-#
 # - Poor performance in the best case: it takes forever to check
 #   whether we're up-to-date (on fetch or push) or to fetch a few
 #   revisions from a large wiki, because we use exclusively a
@@ -71,6 +68,9 @@ chomp(@tracked_pages);
 my @tracked_categories = split(/[ \n]/, run_git("config --get-all remote.". $remotename .".categories"));
 chomp(@tracked_categories);
 
+# Import media files too.
+my $import_media = run_git("config --get --bool remote.". $remotename .".mediaimport");
+
 my $wiki_login = run_git("config --get remote.". $remotename .".mwLogin");
 # TODO: ideally, this should be able to read from keyboard, but we're
 # inside a remote helper, so our stdin is connect to git, not to a
@@ -86,6 +86,9 @@ my $shallow_import = run_git("config --get --bool remote.". $remotename .".shall
 chomp($shallow_import);
 $shallow_import = ($shallow_import eq "true");
 
+# Cache for MediaWiki namespace ids.
+my %namespace_id;
+
 # Dumb push: don't update notes and mediawiki ref to reflect the last push.
 #
 # Configurable with mediawiki.dumbPush, or per-remote with
@@ -183,25 +186,34 @@ sub get_mw_first_pages {
 
 	my $pages = shift;
 
-	# pattern 'page1|page2|...' required by the API
-	my $titles = join('|', @some_pages);
+	my $batch = 50;
+	while (@some_pages) {
+		if ($#some_pages < $batch) {
+			$batch = $#some_pages;
+		}
+		my @slice = @some_pages[0..$batch];
 
-	my $mw_pages = $mediawiki->api({
-		action => 'query',
-		titles => $titles,
-	});
-	if (!defined($mw_pages)) {
-		print STDERR "fatal: could not query the list of wiki pages.\n";
-		print STDERR "fatal: '$url' does not appear to be a mediawiki\n";
-		print STDERR "fatal: make sure '$url/api.php' is a valid page.\n";
-		exit 1;
-	}
-	while (my ($id, $page) = each(%{$mw_pages->{query}->{pages}})) {
-		if ($id < 0) {
-			print STDERR "Warning: page $page->{title} not found on wiki\n";
-		} else {
-			$pages->{$page->{title}} = $page;
+		# pattern 'page1|page2|...' required by the API
+		my $titles = join('|', @slice);
+
+		my $mw_pages = $mediawiki->api({
+			action => 'query',
+			titles => $titles,
+		});
+		if (!defined($mw_pages)) {
+			print STDERR "fatal: could not query the list of wiki pages.\n";
+			print STDERR "fatal: '$url' does not appear to be a mediawiki\n";
+			print STDERR "fatal: make sure '$url/api.php' is a valid page.\n";
+			exit 1;
+		}
+		while (my ($id, $page) = each(%{$mw_pages->{query}->{pages}})) {
+			if ($id < 0) {
+				print STDERR "Warning: page $page->{title} not found on wiki\n";
+			} else {
+				$pages->{$page->{title}} = $page;
+			}
 		}
+		@some_pages = @some_pages[($batch+1)..$#some_pages];
 	}
 }
 
@@ -214,16 +226,10 @@ sub get_mw_pages {
 		$user_defined = 1;
 		# The user provided a list of pages titles, but we
 		# still need to query the API to get the page IDs.
+		get_mw_first_pages(\@tracked_pages, \%pages);
 
-		my @some_pages = @tracked_pages;
-		while (@some_pages) {
-			my $last = 50;
-			if ($#some_pages < $last) {
-				$last = $#some_pages;
-			}
-			my @slice = @some_pages[0..$last];
-			get_mw_first_pages(\@slice, \%pages);
-			@some_pages = @some_pages[51..$#some_pages];
+		if ($import_media) {
+			get_mw_pages_for_linked_mediafiles(\@tracked_pages, \%pages);
 		}
 	}
 	if (@tracked_categories) {
@@ -240,10 +246,16 @@ sub get_mw_pages {
 				list => 'categorymembers',
 				cmtitle => $category,
 				cmlimit => 'max' } )
-			    || die $mediawiki->{error}->{code} . ': ' . $mediawiki->{error}->{details};
+				|| die $mediawiki->{error}->{code} . ': '
+					. $mediawiki->{error}->{details};
 			foreach my $page (@{$mw_pages}) {
 				$pages{$page->{title}} = $page;
 			}
+
+			if ($import_media) {
+				my @titles = map $_->{title}, @{$mw_pages};
+				get_mw_pages_for_linked_mediafiles(\@titles, \%pages);
+			}
 		}
 	}
 	if (!$user_defined) {
@@ -252,7 +264,7 @@ sub get_mw_pages {
 		my $mw_pages = $mediawiki->list({
 			action => 'query',
 			list => 'allpages',
-			aplimit => 500,
+			aplimit => 'max'
 		});
 		if (!defined($mw_pages)) {
 			print STDERR "fatal: could not get the list of wiki pages.\n";
@@ -263,10 +275,203 @@ sub get_mw_pages {
 		foreach my $page (@{$mw_pages}) {
 			$pages{$page->{title}} = $page;
 		}
+
+		if ($import_media) {
+			# Attach list of all pages for media files from the API,
+			# they are in a different namespace, only one namespace
+			# can be queried at the same moment
+			my $mw_pages = $mediawiki->list({
+				action => 'query',
+				list => 'allpages',
+				apnamespace => get_mw_namespace_id("File"),
+				aplimit => 'max'
+			});
+			if (!defined($mw_pages)) {
+				print STDERR "fatal: could not get the list of pages for media files.\n";
+				print STDERR "fatal: '$url' does not appear to be a mediawiki\n";
+				print STDERR "fatal: make sure '$url/api.php' is a valid page.\n";
+				exit 1;
+			}
+			foreach my $page (@{$mw_pages}) {
+				$pages{$page->{title}} = $page;
+			}
+		}
 	}
 	return values(%pages);
 }
 
+sub get_mw_pages_for_linked_mediafiles {
+	my $titles = shift;
+	my @titles = @{$titles};
+	my $pages = shift;
+
+	# The query is split in small batches because of the MW API limit of
+	# the number of links to be returned (500 links max).
+	my $batch = 10;
+	while (@titles) {
+		if ($#titles < $batch) {
+			$batch = $#titles;
+		}
+		my @slice = @titles[0..$batch];
+
+		# pattern 'page1|page2|...' required by the API
+		my $mw_titles = join('|', @slice);
+
+		# Media files could be included or linked from
+		# a page, get all related
+		my $query = {
+			action => 'query',
+			prop => 'links|images',
+			titles => $mw_titles,
+			plnamespace => get_mw_namespace_id("File"),
+			pllimit => 'max'
+		};
+		my $result = $mediawiki->api($query);
+
+		while (my ($id, $page) = each(%{$result->{query}->{pages}})) {
+			my @titles;
+			if (defined($page->{links})) {
+				my @link_titles = map $_->{title}, @{$page->{links}};
+				push(@titles, @link_titles);
+			}
+			if (defined($page->{images})) {
+				my @image_titles = map $_->{title}, @{$page->{images}};
+				push(@titles, @image_titles);
+			}
+			if (@titles) {
+				get_mw_first_pages(\@titles, \%{$pages});
+			}
+		}
+
+		@titles = @titles[($batch+1)..$#titles];
+	}
+}
+
+# Return MediaWiki id for a canonical namespace name.
+# Ex.: "File", "Project".
+# Looks for the namespace id in the local configuration
+# variables, if it is not found asks MW API.
+sub get_mw_namespace_id {
+	mw_connect_maybe();
+	my $name = shift;
+
+	if (!exists $namespace_id{$name}) {
+		# Look at configuration file, if the record for that namespace is
+		# already stored. Namespaces are stored in form:
+		# "Name_of_namespace:Id_namespace", ex.: "File:6".
+		my @temp = split(/[ \n]/, run_git("config --get-all remote."
+						. $remotename .".namespaces"));
+		chomp(@temp);
+		foreach my $ns (@temp) {
+			my ($n, $s) = split(/:/, $ns);
+			$namespace_id{$n} = $s;
+		}
+	}
+
+	if (!exists $namespace_id{$name}) {
+		# NS not found => get namespace id from MW and store it in
+	        # configuration file.
+	        my $query = {
+	                action => 'query',
+	                meta => 'siteinfo',
+	                siprop => 'namespaces'
+	        };
+	        my $result = $mediawiki->api($query);
+
+	        while (my ($id, $ns) = each(%{$result->{query}->{namespaces}})) {
+	                if (defined($ns->{canonical}) && ($ns->{canonical} eq $name)) {
+	                        run_git("config --add remote.". $remotename
+					.".namespaces ". $name .":". $ns->{id});
+				$namespace_id{$name} = $ns->{id};
+	                }
+	        }
+	}
+
+	if (exists $namespace_id{$name}) {
+		return $namespace_id{$name};
+	} else {
+		die "No such namespace $name on MediaWiki.";
+	}
+}
+
+sub get_mw_mediafile_for_page_revision {
+	# Name of the file on Wiki, with the prefix.
+	my $mw_filename = shift;
+	my $timestamp = shift;
+	my %mediafile;
+
+	# Search if on MediaWiki exists a media file with given
+	# timestamp. In that case download the file.
+	my $query = {
+		action => 'query',
+		prop => 'imageinfo',
+		titles => $mw_filename,
+		iistart => $timestamp,
+		iiend => $timestamp,
+		iiprop => 'timestamp|archivename|url',
+		iilimit => 1
+	};
+	my $result = $mediawiki->api($query);
+
+	my ($fileid, $file) = each ( %{$result->{query}->{pages}} );
+	# If not defined it means there is no revision of the file for
+	# given timestamp.
+	if (defined($file->{imageinfo})) {
+		# Get real name of media file.
+		my $filename;
+		if (index($mw_filename, 'File:') == 0) {
+			$filename = substr $mw_filename, 5;
+		} else {
+			$filename = substr $mw_filename, 6;
+		}
+		$mediafile{title} = $filename;
+
+		my $fileinfo = pop(@{$file->{imageinfo}});
+		$mediafile{timestamp} = $fileinfo->{timestamp};
+		# If this is an old version of the file, the file has to be
+		# obtained from the archive. Otherwise it can be downloaded
+		# by MediaWiki API download() function.
+		if (defined($fileinfo->{archivename})) {
+			$mediafile{content} = download_mw_mediafile_from_archive($fileinfo->{url});
+		} else {
+			$mediafile{content} = download_mw_mediafile($mw_filename);
+		}
+	}
+	return %mediafile;
+}
+
+sub download_mw_mediafile_from_archive {
+	my $url = shift;
+	my $file;
+
+	my $ua = LWP::UserAgent->new;
+	my $response = $ua->get($url);
+	if ($response->code) {
+		$file = $response->decoded_content;
+	} else {
+		print STDERR "Error downloading a file from archive.\n";
+	}
+
+	return $file;
+}
+
+sub download_mw_mediafile {
+	my $filename = shift;
+
+	$mediawiki->{config}->{files_url} = $url;
+
+	my $file_content = $mediawiki->download( { title => $filename } );
+	if (!defined($file_content)) {
+		print STDERR "\tFile \'$filename\' could not be downloaded.\n";
+		exit 1;
+	} elsif ($file_content eq "") {
+		print STDERR "\tFile \'$filename\' does not exist on the wiki.\n";
+		exit 1;
+	} else {
+		return $file_content;
+	}
+}
+
 sub run_git {
 	open(my $git, "-|:encoding(UTF-8)", "git " . $_[0]);
 	my $res = do { local $/; <$git> };
@@ -466,6 +671,13 @@ sub import_file_revision {
 	my %commit = %{$commit};
 	my $full_import = shift;
 	my $n = shift;
+	my $mediafile_import = shift;
+	my $mediafile;
+	my %mediafile;
+	if ($mediafile_import) {
+		$mediafile = shift;
+		%mediafile = %{$mediafile};
+	}
 
 	my $title = $commit{title};
 	my $comment = $commit{comment};
@@ -485,6 +697,10 @@ sub import_file_revision {
 	if ($content ne DELETED_CONTENT) {
 		print STDOUT "M 644 inline $title.mw\n";
 		literal_data($content);
+		if ($mediafile_import) {
+			print STDOUT "M 644 inline $mediafile{title}\n";
+			literal_data($mediafile{content});
+		}
 		print STDOUT "\n\n";
 	} else {
 		print STDOUT "D $title.mw\n";
@@ -580,6 +796,7 @@ sub mw_import_ref {
 
 		$n++;
 
+		my $page_title = $result->{query}->{pages}->{$pagerevid->{pageid}}->{title};
 		my %commit;
 		$commit{author} = $rev->{user} || 'Anonymous';
 		$commit{comment} = $rev->{comment} || '*Empty MediaWiki Message*';
@@ -596,9 +813,25 @@ sub mw_import_ref {
 		}
 		$commit{date} = DateTime::Format::ISO8601->parse_datetime($last_timestamp);
 
-		print STDERR "$n/", scalar(@revisions), ": Revision #$pagerevid->{revid} of $commit{title}\n";
+		# Differentiates classic pages and media files.
+		my @prefix = split (":", $page_title);
 
-		import_file_revision(\%commit, ($fetch_from == 1), $n);
+		my %mediafile;
+		if ($prefix[0] eq "File" || $prefix[0] eq "Image") {
+			# The name of the file is the same as the media page.
+			my $filename = $page_title;
+			%mediafile = get_mw_mediafile_for_page_revision($filename, $rev->{timestamp});
+		}
+		# If this is a revision of the media page for new version
+		# of a file do one common commit for both file and media page.
+		# Else do commit only for that page.
+		print STDERR "$n/", scalar(@revisions), ": Revision #$pagerevid->{revid} of $commit{title}\n";
+		if (%mediafile) {
+			print STDERR "\tDownloading file $mediafile{title}, version $mediafile{timestamp}\n";
+			import_file_revision(\%commit, ($fetch_from == 1), $n, 1, \%mediafile);
+		} else {
+			import_file_revision(\%commit, ($fetch_from == 1), $n, 0);
+		}
 	}
 
 	if ($fetch_from == 1 && $n == 0) {
-- 
1.7.10.2.552.gaa3bb87
