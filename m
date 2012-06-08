From: Pavel Volek <Pavel.Volek@ensimag.imag.fr>
Subject: [PATCHv1] git-remote-mediawiki: import "File:" attachments
Date: Fri,  8 Jun 2012 16:22:56 +0200
Message-ID: <1339165376-20267-1-git-send-email-Pavel.Volek@ensimag.imag.fr>
Cc: Volek Pavel <me@pavelvolek.cz>,
	Pavel Volek <Pavel.Volek@ensimag.imag.fr>,
	NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>,
	ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 08 16:23:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sd06W-0006ub-MB
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jun 2012 16:23:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934317Ab2FHOXs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jun 2012 10:23:48 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:42350 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932433Ab2FHOXf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2012 10:23:35 -0400
Received: by wgbdr13 with SMTP id dr13so937988wgb.1
        for <git@vger.kernel.org>; Fri, 08 Jun 2012 07:23:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer
         :x-gm-message-state;
        bh=qpqgilob8HS/EbiklL2c9rKV0gUcdQoQnaP6EP5OmXc=;
        b=YOmtJiNEpaV4Mc29yWH3NvrIQCfp2lEQyNvOsyjzpx2ft+36Lpu6Lcv1Gw3sWbOUXn
         LZ27DxckSZBz5rvmWnwaORc8Z8F+aPXoP7hdaMG2x8iUG/44VcKkALms5n7eNKfUnfXS
         ZbFx72bOrEncrPmz9tizbqYOiVHgWyhBKUEQue/FB5SGF+beSZ1Em/BqavAo54AQ8aaw
         v6dN5h0TIwq6RecVacBTUedz0ArV4HErWYnyWQtanOA8KRTYzpjGDuZ7kOGA5N/UhgqE
         uu7KdbGILkGSTnOolQQYZg+xsvHVurlOmP6olV3G8xPDYLSPSRimJnVvDmcKs6v35BVm
         1+ow==
Received: by 10.180.96.106 with SMTP id dr10mr816831wib.3.1339165410934;
        Fri, 08 Jun 2012 07:23:30 -0700 (PDT)
Received: from volek-HP.grenet.fr (wifi-123088.grenet.fr. [130.190.123.88])
        by mx.google.com with ESMTPS id gb9sm1495543wib.8.2012.06.08.07.23.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 08 Jun 2012 07:23:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.552.gaa3bb87
X-Gm-Message-State: ALoCoQlw+OxauRvF0EsxUIz6ZcYlmEiTotE7un078tzdJ2z3mfrsuHtlkXIkhDfnbbhHjiIWEB/m
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199492>

From: Volek Pavel <me@pavelvolek.cz>

The current version of the git-remote-mediawiki supports only import and export
of the pages, doesn't support import and export of file attachements which are
also exposed by MediaWiki API. This patch adds the functionality to import the
last versions of the files and all versions of description pages for these
files.

Signed-off-by: Pavel Volek <Pavel.Volek@ensimag.imag.fr>
Signed-off-by: NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>
Signed-off-by: ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/mw-to-git/git-remote-mediawiki | 290 +++++++++++++++++++++++++++------
 1 file changed, 244 insertions(+), 46 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
index c18bfa1..9f21217 100755
--- a/contrib/mw-to-git/git-remote-mediawiki
+++ b/contrib/mw-to-git/git-remote-mediawiki
@@ -212,59 +212,230 @@ sub get_mw_pages {
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
+		 get_mw_all_pages(\%pages);
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
+		aplimit => 500,
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
+	# Attach list of all pages for meadia files from the API,
+	# they are in a different namespace, only one namespace
+	# can be queried at the same moment
+	my $mw_mediapages = $mediawiki->list({
+		action => 'query',
+		list => 'allpages',
+		apnamespace => get_mw_namespace_id("File"),
+		aplimit => 500,
+	});
+	if (!defined($mw_mediapages)) {
+		print STDERR "fatal: could not get the list of media file pages.\n";
+		print STDERR "fatal: '$url' does not appear to be a mediawiki\n";
+		print STDERR "fatal: make sure '$url/api.php' is a valid page.\n";
+		exit 1;
+	}
+	foreach my $page (@{$mw_mediapages}) {
+		$pages->{$page->{title}} = $page;
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
+	# Get pages of related media files.
+	get_mw_linked_mediapages(\@tracked_pages, \%{$pages});
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
 		}
+		my $mw_pages = $mediawiki->list( {
+			action => 'query',
+			list => 'categorymembers',
+			cmtitle => $category,
+			cmlimit => 'max' } )
+			|| die $mediawiki->{error}->{code} . ': '
+				. $mediawiki->{error}->{details};
 		foreach my $page (@{$mw_pages}) {
-			$pages{$page->{title}} = $page;
+			$pages->{$page->{title}} = $page;
+		}
+
+		my @titles = map $_->{title}, @{$mw_pages};
+		# Get pages of related media files.
+		get_mw_linked_mediapages(\@titles, \%{$pages});
+	}
+}
+
+sub get_mw_linked_mediapages {
+	my $titles = shift;
+	my @titles = @{$titles};
+	my $pages = shift;
+
+	# pattern 'page1|page2|...' required by the API
+	my $mw_titles = join('|', @titles);
+
+	# Media files could be included or linked from
+	# a page, get all related
+	my $query = {
+		action => 'query',
+		prop => 'links|images',
+		titles => $mw_titles,
+		plnamespace => get_mw_namespace_id("File"),
+		pllimit => 500,
+	};
+	my $result = $mediawiki->api($query);
+
+	while (my ($id, $page) = each(%{$result->{query}->{pages}})) {
+		my @titles;
+		if (defined($page->{links})) {
+			my @link_titles = map $_->{title}, @{$page->{links}};
+			push(@titles, @link_titles);
+		}
+		if (defined($page->{images})) {
+			my @image_titles = map $_->{title}, @{$page->{images}};
+			push(@titles, @image_titles);
+		}
+		if (@titles) {
+			get_mw_first_pages(\@titles, \%{$pages});
 		}
 	}
-	return values(%pages);
+}
+
+sub get_mw_medafile_for_mediapage_revision {
+	# Name of the file on Wiki, with the prefix.
+	my $mw_filename = shift;
+	my $timestamp = shift;
+	my %mediafile;
+
+	# Search if on MediaWiki exists a media file with given
+	# timestamp and in that case download the file.
+	my $query = {
+		action => 'query',
+		prop => 'imageinfo',
+		titles => $mw_filename,
+		iistart => $timestamp,
+		iiend => $timestamp,
+		iiprop => 'timestamp|archivename',
+		iilimit => 1,
+	};
+	my $result = $mediawiki->api($query);
+
+	my ($fileid, $file) = each ( %{$result->{query}->{pages}} );
+	if (defined($file->{imageinfo})) {
+		my $fileinfo = pop(@{$file->{imageinfo}});
+		if (defined($fileinfo->{archivename})) {
+			return; # now we are not able to download files from archive
+		}
+
+		my $filename; # real filename without prefix
+		if (index($mw_filename, 'File:') == 0) {
+			$filename = substr $mw_filename, 5;
+		} else {
+			$filename = substr $mw_filename, 6;
+		}
+
+		$mediafile{title} = $filename;
+		$mediafile{content} = download_mw_mediafile($mw_filename);
+	}
+	return %mediafile;
+}
+
+# Returns MediaWiki id for a canonical namespace name.
+# Ex.: "File", "Project".
+# Looks for the namespace id in the local configuration
+# variables, if it is not found asks MW API.
+sub get_mw_namespace_id {
+	mw_connect_maybe();
+
+	my $name = shift;
+
+	# Look at configuration file, if the record
+	# for that namespace is already stored.
+	my @tracked_namespaces = split(/[ \n]/, run_git("config --get-all remote.". $remotename .".namespaces"));
+	chomp(@tracked_namespaces);
+	if (@tracked_namespaces) {
+		foreach my $ns (@tracked_namespaces) {
+			my @ns_split = split(/=/, $ns);
+			if ($ns_split[0] eq $name) {
+				return $ns_split[1];
+			}
+		}
+	}
+
+	# NS not found => get namespace id from MW and store it in
+	# configuration file.
+	my $query = {
+		action => 'query',
+		meta => 'siteinfo',
+		siprop => 'namespaces',
+	};
+	my $result = $mediawiki->api($query);
+
+	while (my ($id, $ns) = each(%{$result->{query}->{namespaces}})) {
+		if (defined($ns->{canonical}) && ($ns->{canonical} eq $name)) {
+			run_git("config --add remote.". $remotename .".namespaces ". $name ."=". $ns->{id});
+			return $ns->{id};
+		}
+	}
+	die "Namespace $name was not found on MediaWiki.";
+}
+
+sub download_mw_mediafile {
+	my $filename = shift;
+
+	$mediawiki->{config}->{files_url} = $url;
+
+	my $file = $mediawiki->download( { title => $filename } );
+	if (!defined($file)) {
+		print STDERR "\tFile \'$filename\' could not be downloaded.\n";
+		exit 1;
+	} elsif ($file eq "") {
+		print STDERR "\tFile \'$filename\' does not exist on the wiki.\n";
+		exit 1;
+	} else {
+		return $file;
+	}
 }
 
 sub run_git {
@@ -466,6 +637,13 @@ sub import_file_revision {
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
@@ -485,6 +663,10 @@ sub import_file_revision {
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
@@ -580,6 +762,7 @@ sub mw_import_ref {
 
 		$n++;
 
+		my $page_title = $result->{query}->{pages}->{$pagerevid->{pageid}}->{title};
 		my %commit;
 		$commit{author} = $rev->{user} || 'Anonymous';
 		$commit{comment} = $rev->{comment} || '*Empty MediaWiki Message*';
@@ -596,9 +779,24 @@ sub mw_import_ref {
 		}
 		$commit{date} = DateTime::Format::ISO8601->parse_datetime($last_timestamp);
 
-		print STDERR "$n/", scalar(@revisions), ": Revision #$pagerevid->{revid} of $commit{title}\n";
+		# differentiates classic pages and media pages
+		my @prefix = split (":", $page_title);
 
-		import_file_revision(\%commit, ($fetch_from == 1), $n);
+		my %mediafile;
+		if ($prefix[0] eq "File" || $prefix[0] eq "Image") {
+			# The name of the file is the same as the media page.
+			my $filename = $page_title;
+			%mediafile = get_mw_medafile_for_mediapage_revision($filename, $rev->{timestamp});
+		}
+		# If this is a revision of the media page for new version
+		# of a file do one common commit for both file and media page.
+		# Else do commit only for that page.
+		print STDERR "$n/", scalar(@revisions), ": Revision #$pagerevid->{revid} of $commit{title}\n";
+		if (%mediafile) {
+			import_file_revision(\%commit, ($fetch_from == 1), $n, 1, \%mediafile);
+		} else {
+			import_file_revision(\%commit, ($fetch_from == 1), $n, 0);
+		}
 	}
 
 	if ($fetch_from == 1 && $n == 0) {
-- 
1.7.10.2.552.gaa3bb87
