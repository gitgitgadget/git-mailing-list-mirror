From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 5/5] git-remote-mediawiki: import "File:" attachments
Date: Wed, 27 Jun 2012 11:10:20 +0200
Message-ID: <1340788220-10084-6-git-send-email-Matthieu.Moy@imag.fr>
References: <1340726673-25496-1-git-send-email-Matthieu.Moy@imag.fr>
 <1340788220-10084-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Pavel.Volek@ensimag.imag.fr, Kim-Thuat.Nguyen@ensimag.imag.fr,
	roucherj@ensimag.imag.fr, Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jun 27 11:11:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjoHC-0005rw-O0
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jun 2012 11:11:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756504Ab2F0JKz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jun 2012 05:10:55 -0400
Received: from mx1.imag.fr ([129.88.30.5]:50983 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755159Ab2F0JKr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2012 05:10:47 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q5R9A5gP020098
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 27 Jun 2012 11:10:05 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SjoGp-0003Pr-Ss; Wed, 27 Jun 2012 11:10:43 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SjoGp-0002ds-RZ; Wed, 27 Jun 2012 11:10:43 +0200
X-Mailer: git-send-email 1.7.11.5.g0c7e058.dirty
In-Reply-To: <1340788220-10084-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 27 Jun 2012 11:10:05 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5R9A5gP020098
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1341393006.16216@f3wf1XYIXVQB2zL3thgpyg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200706>

From: Pavel Volek <Pavel.Volek@ensimag.imag.fr>

Add the symmetrical feature to the "File:" export support in the previous
patch. Download files from the wiki as needed, and feed them into the
fast-import stream. Import both the file itself, and the corresponding
description page.

Signed-off-by: Pavel Volek <Pavel.Volek@ensimag.imag.fr>
Signed-off-by: NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>
Signed-off-by: ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/mw-to-git/git-remote-mediawiki | 255 +++++++++++++++++++++++++++++++--
 1 file changed, 247 insertions(+), 8 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
index 76d8824..15a55ba 100755
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
@@ -36,6 +33,7 @@
 use strict;
 use MediaWiki::API;
 use DateTime::Format::ISO8601;
+use FileHandle;
 
 # By default, use UTF-8 to communicate with Git and the user
 binmode STDERR, ":utf8";
@@ -72,6 +70,11 @@ chomp(@tracked_pages);
 my @tracked_categories = split(/[ \n]/, run_git("config --get-all remote.". $remotename .".categories"));
 chomp(@tracked_categories);
 
+# Import media files too.
+my $import_media = run_git("config --get --bool remote.". $remotename .".mediaimport");
+chomp($import_media);
+$import_media = ($import_media eq "true");
+
 my $wiki_login = run_git("config --get remote.". $remotename .".mwLogin");
 # TODO: ideally, this should be able to read from keyboard, but we're
 # inside a remote helper, so our stdin is connect to git, not to a
@@ -87,6 +90,9 @@ my $shallow_import = run_git("config --get --bool remote.". $remotename .".shall
 chomp($shallow_import);
 $shallow_import = ($shallow_import eq "true");
 
+# Cache for MediaWiki namespace ids.
+my %namespace_id;
+
 # Dumb push: don't update notes and mediawiki ref to reflect the last push.
 #
 # Configurable with mediawiki.dumbPush, or per-remote with
@@ -363,6 +369,14 @@ sub get_mw_pages {
 	if (!$user_defined) {
 		get_mw_all_pages(\%pages);
 	}
+	if ($import_media) {
+		print STDERR "Getting media files for selected pages...\n";
+		if ($user_defined) {
+			get_linked_mediafiles(\%pages);
+		} else {
+			get_all_mediafiles(\%pages);
+		}
+	}
 	return values(%pages);
 }
 
@@ -379,6 +393,152 @@ sub run_git {
 }
 
 
+sub get_all_mediafiles {
+	my $pages = shift;
+	# Attach list of all pages for media files from the API,
+	# they are in a different namespace, only one namespace
+	# can be queried at the same moment
+	my $mw_pages = $mediawiki->list({
+		action => 'query',
+		list => 'allpages',
+		apnamespace => get_mw_namespace_id("File"),
+		aplimit => 'max'
+	});
+	if (!defined($mw_pages)) {
+		print STDERR "fatal: could not get the list of pages for media files.\n";
+		print STDERR "fatal: '$url' does not appear to be a mediawiki\n";
+		print STDERR "fatal: make sure '$url/api.php' is a valid page.\n";
+		exit 1;
+	}
+	foreach my $page (@{$mw_pages}) {
+		$pages->{$page->{title}} = $page;
+	}
+}
+
+sub get_linked_mediafiles {
+	my $pages = shift;
+	my @titles = map $_->{title}, values(%{$pages});
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
 sub get_last_local_revision {
 	# Get note regarding last mediawiki revision
 	my $note = run_git("notes --ref=$remotename/mediawiki show refs/mediawiki/$remotename/master 2>/dev/null");
@@ -482,6 +642,14 @@ sub literal_data {
 	print STDOUT "data ", bytes::length($content), "\n", $content;
 }
 
+sub literal_data_raw {
+	# Output possibly binary content.
+	my ($content) = @_;
+	binmode STDOUT, ":raw";
+	print STDOUT "data ", bytes::length($content), "\n", $content;
+	binmode STDOUT, ":utf8";
+}
+
 sub mw_capabilities {
 	# Revisions are imported to the private namespace
 	# refs/mediawiki/$remotename/ by the helper and fetched into
@@ -569,6 +737,11 @@ sub import_file_revision {
 	my %commit = %{$commit};
 	my $full_import = shift;
 	my $n = shift;
+	my $mediafile = shift;
+	my %mediafile;
+	if ($mediafile) {
+		%mediafile = %{$mediafile};
+	}
 
 	my $title = $commit{title};
 	my $comment = $commit{comment};
@@ -588,6 +761,10 @@ sub import_file_revision {
 	if ($content ne DELETED_CONTENT) {
 		print STDOUT "M 644 inline $title.mw\n";
 		literal_data($content);
+		if (%mediafile) {
+			print STDOUT "M 644 inline $mediafile{title}\n";
+			literal_data_raw($mediafile{content});
+		}
 		print STDOUT "\n\n";
 	} else {
 		print STDOUT "D $title.mw\n";
@@ -683,12 +860,11 @@ sub mw_import_ref {
 
 		$n++;
 
+		my $page_title = $result->{query}->{pages}->{$pagerevid->{pageid}}->{title};
 		my %commit;
 		$commit{author} = $rev->{user} || 'Anonymous';
 		$commit{comment} = $rev->{comment} || '*Empty MediaWiki Message*';
-		$commit{title} = mediawiki_smudge_filename(
-			$result->{query}->{pages}->{$pagerevid->{pageid}}->{title}
-		    );
+		$commit{title} = mediawiki_smudge_filename($page_title);
 		$commit{mw_revision} = $pagerevid->{revid};
 		$commit{content} = mediawiki_smudge($rev->{'*'});
 
@@ -699,9 +875,25 @@ sub mw_import_ref {
 		}
 		$commit{date} = DateTime::Format::ISO8601->parse_datetime($last_timestamp);
 
-		print STDERR "$n/", scalar(@revisions), ": Revision #$pagerevid->{revid} of $commit{title}\n";
+		# Differentiates classic pages and media files.
+		my @prefix = split(":", $page_title);
 
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
+			import_file_revision(\%commit, ($fetch_from == 1), $n, \%mediafile);
+		} else {
+			import_file_revision(\%commit, ($fetch_from == 1), $n);
+		}
 	}
 
 	if ($fetch_from == 1 && $n == 0) {
@@ -1006,3 +1198,50 @@ sub get_allowed_file_extensions {
 
 	return %hashFile;
 }
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
-- 
1.7.11.5.g0c7e058.dirty
