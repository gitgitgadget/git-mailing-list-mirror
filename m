From: Pavel Volek <Pavel.Volek@ensimag.imag.fr>
Subject: [PATCHv2 1/2] git-remote-mediawiki: import "File:" attachments
Date: Mon, 11 Jun 2012 21:29:04 +0200
Message-ID: <1339442945-8561-1-git-send-email-Pavel.Volek@ensimag.imag.fr>
Cc: Volek Pavel <me@pavelvolek.cz>,
	Pavel Volek <Pavel.Volek@ensimag.imag.fr>,
	NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>,
	ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 11 21:29:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeAJ8-00028u-Q4
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 21:29:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127Ab2FKT3n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 15:29:43 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:35496 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068Ab2FKT3m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 15:29:42 -0400
Received: by wibhj8 with SMTP id hj8so3258509wib.1
        for <git@vger.kernel.org>; Mon, 11 Jun 2012 12:29:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer
         :x-gm-message-state;
        bh=FxgQg6lzffJkGqdPIZtcASYB/fpsybuTPv9ZH1joHMI=;
        b=mwztvxHCBW1InlaWLp7UPw5IBXp9VOiAy2Ummx2sk3PpxZ/nanTDqIn3mNOjcvX/OV
         P3W/sJa2LuHdCZ5hN2JX/h5/oZe8XtkbZJ2GeE3fVLT5CsHzvdVqzS9BrTar7MAWRVda
         4AvX+1TXkmNpYOUZvHd/6vVEamhyysvqOSOTx9ai2znlT/yQ9Y2l6rfn78JPP9SbSt87
         TX1duK2ck32b/JQFDfa4zwOef4Ss5BHEV4G0JSLC9s+2qfzWZxxrp1B5ySj7CxkaM7JI
         D+aKxSgOhTS+DpzzttnPJHQc/3OFNImhSo5kraU6u7Fxf65v+GTO6uInFazi6IfT9Ovu
         jWbQ==
Received: by 10.216.193.129 with SMTP id k1mr6879158wen.201.1339442980727;
        Mon, 11 Jun 2012 12:29:40 -0700 (PDT)
Received: from volek-HP.grenet.fr (wifi-123088.grenet.fr. [130.190.123.88])
        by mx.google.com with ESMTPS id i10sm637391wiy.10.2012.06.11.12.29.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Jun 2012 12:29:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.552.gaa3bb87
X-Gm-Message-State: ALoCoQnUhQXrw5odXeQyjuvUioiiD1d72yjBXMyCcRb/vULHJc8cwkMq40aGzXvPh00A40CEiTvY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199713>

From: Volek Pavel <me@pavelvolek.cz>

The current version of the git-remote-mediawiki supports only import and export
of the pages, doesn't support import and export of file attachments which are
also exposed by MediaWiki API. This patch adds the functionality to import file
attachments and description pages for these files.

Signed-off-by: Pavel Volek <Pavel.Volek@ensimag.imag.fr>
Signed-off-by: NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>
Signed-off-by: ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/mw-to-git/git-remote-mediawiki | 225 ++++++++++++++++++++++++++++++++-
 1 file changed, 220 insertions(+), 5 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
index c18bfa1..14008ad 100755
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
@@ -225,6 +225,11 @@ sub get_mw_pages {
 			get_mw_first_pages(\@slice, \%pages);
 			@some_pages = @some_pages[51..$#some_pages];
 		}
+
+		# Get pages of related media files.
+		if ($import_media) {
+			get_mw_pages_for_linked_mediafiles(\@tracked_pages, \%pages);
+		}
 	}
 	if (@tracked_categories) {
 		$user_defined = 1;
@@ -244,6 +249,12 @@ sub get_mw_pages {
 			foreach my $page (@{$mw_pages}) {
 				$pages{$page->{title}} = $page;
 			}
+
+			# Get pages of related media files.
+			if ($import_media) {
+				my @titles = map $_->{title}, @{$mw_pages};
+				get_mw_pages_for_linked_mediafiles(\@titles, \%pages);
+			}
 		}
 	}
 	if (!$user_defined) {
@@ -263,10 +274,140 @@ sub get_mw_pages {
 		foreach my $page (@{$mw_pages}) {
 			$pages{$page->{title}} = $page;
 		}
+
+		if ($import_media) {
+			# Attach list of all pages for meadia files from the API,
+			# they are in a different namespace, only one namespace
+			# can be queried at the same moment
+			my $mw_pages = $mediawiki->list({
+				action => 'query',
+				list => 'allpages',
+				apnamespace => get_mw_namespace_id("File"),
+				aplimit => 500
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
+		pllimit => 500
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
+		}
+	}
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
+	# Namespaces are stored in form: "Name_of_namespace:Id_namespace",
+	# Ex.: "File:6".
+	my @tracked_namespaces = split(/[ \n]/, run_git("config --get-all remote.". $remotename .".namespaces"));
+	chomp(@tracked_namespaces);
+	if (@tracked_namespaces) {
+		foreach my $ns (@tracked_namespaces) {
+			my @ns_split = split(/:/, $ns);
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
+		siprop => 'namespaces'
+	};
+	my $result = $mediawiki->api($query);
+
+	while (my ($id, $ns) = each(%{$result->{query}->{namespaces}})) {
+		if (defined($ns->{canonical}) && ($ns->{canonical} eq $name)) {
+			run_git("config --add remote.". $remotename .".namespaces ". $name .":". $ns->{id});
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
 sub run_git {
 	open(my $git, "-|:encoding(UTF-8)", "git " . $_[0]);
 	my $res = do { local $/; <$git> };
@@ -466,6 +607,13 @@ sub import_file_revision {
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
@@ -485,6 +633,10 @@ sub import_file_revision {
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
@@ -525,6 +677,52 @@ sub get_more_refs {
 	}
 }
 
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
 sub mw_import {
 	# multiple import commands can follow each other.
 	my @refs = (shift, get_more_refs("import"));
@@ -580,6 +778,7 @@ sub mw_import_ref {
 
 		$n++;
 
+		my $page_title = $result->{query}->{pages}->{$pagerevid->{pageid}}->{title};
 		my %commit;
 		$commit{author} = $rev->{user} || 'Anonymous';
 		$commit{comment} = $rev->{comment} || '*Empty MediaWiki Message*';
@@ -596,9 +795,25 @@ sub mw_import_ref {
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
