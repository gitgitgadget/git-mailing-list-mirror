From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v4] git-remote-mediawiki: import "File:" attachments
Date: Wed,  4 Jul 2012 14:53:36 +0200
Message-ID: <1341406416-1251-1-git-send-email-Matthieu.Moy@imag.fr>
References: <1340806889-23081-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Pavel Volek <Pavel.Volek@ensimag.imag.fr>,
	NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>,
	ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jul 04 14:53:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmP5f-0007uk-IS
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jul 2012 14:53:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751885Ab2GDMxu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jul 2012 08:53:50 -0400
Received: from mx1.imag.fr ([129.88.30.5]:59434 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751341Ab2GDMxt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2012 08:53:49 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q64CqicM017981
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 4 Jul 2012 14:52:44 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SmP5U-0001Nt-4S; Wed, 04 Jul 2012 14:53:44 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SmP5T-0000Kx-VI; Wed, 04 Jul 2012 14:53:44 +0200
X-Mailer: git-send-email 1.7.11.1.147.g47a574d
In-Reply-To: <1340806889-23081-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 04 Jul 2012 14:52:45 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q64CqicM017981
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1342011165.72136@NXHPuuUUkDVjH5LzNpns7A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201003>

From: Pavel Volek <Pavel.Volek@ensimag.imag.fr>

Add the symmetrical feature to the "File:" export support in the previous
patch. Download files from the wiki as needed, and feed them into the
fast-import stream. Import both the file itself, and the corresponding
description page.

Signed-off-by: Pavel Volek <Pavel.Volek@ensimag.imag.fr>
Signed-off-by: NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>
Signed-off-by: ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
This is meant to replace commit 6a9e55b0fc5df40 in branch
mm/mediawiki-file-attachments in pu.

The main problem I fixed is the support for non-english wikis, where
mediafiles can live in namespaces with names different from Image and
File. While I was there, I reworked the code in various places, the
new code should be simpler and easier to read.

 contrib/mw-to-git/git-remote-mediawiki | 241 +++++++++++++++++++++++++++++++--
 1 file changed, 232 insertions(+), 9 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
index 361dbb1..063a978 100755
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
@@ -72,6 +69,11 @@ chomp(@tracked_pages);
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
@@ -261,7 +263,13 @@ sub mw_connect_maybe {
 ## Functions for listing pages on the remote wiki
 sub get_mw_tracked_pages {
 	my $pages = shift;
-	my @some_pages = @tracked_pages;
+	get_mw_page_list(\@tracked_pages, $pages);
+}
+
+sub get_mw_page_list {
+	my $page_list = shift;
+	my $pages = shift;
+	my @some_pages = @$page_list;
 	while (@some_pages) {
 		my $last = 50;
 		if ($#some_pages < $last) {
@@ -363,6 +371,14 @@ sub get_mw_pages {
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
 
@@ -379,6 +395,123 @@ sub run_git {
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
+			my @media_titles;
+			if (defined($page->{links})) {
+				my @link_titles = map $_->{title}, @{$page->{links}};
+				push(@media_titles, @link_titles);
+			}
+			if (defined($page->{images})) {
+				my @image_titles = map $_->{title}, @{$page->{images}};
+				push(@media_titles, @image_titles);
+			}
+			if (@media_titles) {
+				get_mw_page_list(\@media_titles, $pages);
+			}
+		}
+
+		@titles = @titles[($batch+1)..$#titles];
+	}
+}
+
+sub get_mw_mediafile_for_page_revision {
+	# Name of the file on Wiki, with the prefix.
+	my $filename = shift;
+	my $timestamp = shift;
+	my %mediafile;
+
+	# Search if on a media file with given timestamp exists on
+	# MediaWiki. In that case download the file.
+	my $query = {
+		action => 'query',
+		prop => 'imageinfo',
+		titles => "File:" . $filename,
+		iistart => $timestamp,
+		iiend => $timestamp,
+		iiprop => 'timestamp|archivename|url',
+		iilimit => 1
+	};
+	my $result = $mediawiki->api($query);
+
+	my ($fileid, $file) = each( %{$result->{query}->{pages}} );
+	# If not defined it means there is no revision of the file for
+	# given timestamp.
+	if (defined($file->{imageinfo})) {
+		$mediafile{title} = $filename;
+
+		my $fileinfo = pop(@{$file->{imageinfo}});
+		$mediafile{timestamp} = $fileinfo->{timestamp};
+		# Mediawiki::API's download function doesn't support https URLs
+		# and can't download old versions of files.
+		print STDERR "\tDownloading file $mediafile{title}, version $mediafile{timestamp}\n";
+		$mediafile{content} = download_mw_mediafile($fileinfo->{url});
+	}
+	return %mediafile;
+}
+
+sub download_mw_mediafile {
+	my $url = shift;
+
+	my $response = $mediawiki->{ua}->get($url);
+	if ($response->code == 200) {
+		return $response->decoded_content;
+	} else {
+		print STDERR "Error downloading mediafile from :\n";
+		print STDERR "URL: $url\n";
+		print STDERR "Server response: " . $response->code . " " . $response->message . "\n";
+		exit 1;
+	}
+}
+
 sub get_last_local_revision {
 	# Get note regarding last mediawiki revision
 	my $note = run_git("notes --ref=$remotename/mediawiki show refs/mediawiki/$remotename/master 2>/dev/null");
@@ -482,6 +615,16 @@ sub literal_data {
 	print STDOUT "data ", bytes::length($content), "\n", $content;
 }
 
+sub literal_data_raw {
+	# Output possibly binary content.
+	my ($content) = @_;
+	# Avoid confusion between size in bytes and in characters
+	utf8::downgrade($content);
+	binmode STDOUT, ":raw";
+	print STDOUT "data ", bytes::length($content), "\n", $content;
+	binmode STDOUT, ":utf8";
+}
+
 sub mw_capabilities {
 	# Revisions are imported to the private namespace
 	# refs/mediawiki/$remotename/ by the helper and fetched into
@@ -569,6 +712,11 @@ sub import_file_revision {
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
@@ -588,6 +736,10 @@ sub import_file_revision {
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
@@ -683,12 +835,11 @@ sub mw_import_ref {
 
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
 
@@ -699,9 +850,17 @@ sub mw_import_ref {
 		}
 		$commit{date} = DateTime::Format::ISO8601->parse_datetime($last_timestamp);
 
+		# Differentiates classic pages and media files.
+		my ($namespace, $filename) = $page_title =~ /^([^:]*):(.*)$/;
+		my %mediafile;
+		if ($namespace && get_mw_namespace_id($namespace) == get_mw_namespace_id("File")) {
+			%mediafile = get_mw_mediafile_for_page_revision($filename, $rev->{timestamp});
+		}
+		# If this is a revision of the media page for new version
+		# of a file do one common commit for both file and media page.
+		# Else do commit only for that page.
 		print STDERR "$n/", scalar(@revisions), ": Revision #$pagerevid->{revid} of $commit{title}\n";
-
-		import_file_revision(\%commit, ($fetch_from == 1), $n);
+		import_file_revision(\%commit, ($fetch_from == 1), $n, \%mediafile);
 	}
 
 	if ($fetch_from == 1 && $n == 0) {
@@ -1006,3 +1165,67 @@ sub get_allowed_file_extensions {
 
 	return %hashFile;
 }
+
+# In memory cache for MediaWiki namespace ids.
+my %namespace_id;
+
+# Namespaces whose id is cached in the configuration file
+# (to avoid duplicates)
+my %cached_mw_namespace_id;
+
+# Return MediaWiki id for a canonical namespace name.
+# Ex.: "File", "Project".
+sub get_mw_namespace_id {
+	mw_connect_maybe();
+	my $name = shift;
+
+	if (!exists $namespace_id{$name}) {
+		# Look at configuration file, if the record for that namespace is
+		# already cached. Namespaces are stored in form:
+		# "Name_of_namespace:Id_namespace", ex.: "File:6".
+		my @temp = split(/[ \n]/, run_git("config --get-all remote."
+						. $remotename .".namespaceCache"));
+		chomp(@temp);
+		foreach my $ns (@temp) {
+			my ($n, $id) = split(/:/, $ns);
+			$namespace_id{$n} = $id;
+			$cached_mw_namespace_id{$n} = 1;
+		}
+	}
+
+	if (!exists $namespace_id{$name}) {
+		print STDERR "Namespace $name not found in cache, querying the wiki ...\n";
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
+	                if (defined($ns->{id}) && defined($ns->{canonical})) {
+				$namespace_id{$ns->{canonical}} = $ns->{id};
+				if ($ns->{'*'}) {
+					# alias (e.g. french Fichier: as alias for canonical File:)
+					$namespace_id{$ns->{'*'}} = $ns->{id};
+				}
+			}
+	        }
+	}
+
+	my $id = $namespace_id{$name};
+
+	if (defined $id) {
+		# Store explicitely requested namespaces on disk
+		if (!exists $cached_mw_namespace_id{$name}) {
+			run_git("config --add remote.". $remotename
+				.".namespaceCache \"". $name .":". $id ."\"");
+			$cached_mw_namespace_id{$name} = 1;
+		}
+		return $id;
+	} else {
+		die "No such namespace $name on MediaWiki.";
+	}
+}
-- 
1.7.11.1.147.g47a574d
