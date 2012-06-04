From: Pavel Volek <Pavel.Volek@ensimag.imag.fr>
Subject: [PATCH/RFC] file import functionality for git-remote-mw
Date: Mon,  4 Jun 2012 21:15:51 +0200
Message-ID: <1338837351-8996-1-git-send-email-Pavel.Volek@ensimag.imag.fr>
References: <y>
Cc: Volek Pavel <me@pavelvolek.cz>,
	Pavel Volek <Pavel.Volek@ensimag.imag.fr>,
	NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>,
	ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 04 21:19:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbcoG-0006yr-Rf
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 21:19:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755116Ab2FDTTU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jun 2012 15:19:20 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:48538 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490Ab2FDTTT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2012 15:19:19 -0400
Received: by wgbdr13 with SMTP id dr13so4362260wgb.1
        for <git@vger.kernel.org>; Mon, 04 Jun 2012 12:19:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=K+eXQ8URTLXIfdDvywJKGP2SxOacQnnX7KkQ2jcjmjM=;
        b=kbVHPbugluGMsbU0iBiSKy5QAo3FrQAe5ZhMAvDT9Kxo8xY0e18QPXrkKraQKI3L5b
         zK9UQborcS/aNUydNROhHDtmfh7Z8J8j7IlPIKPStQV4ap2z4LkdBqRc8AGEgmj2cZ4q
         7ZHFZ8ul2X45RNgrfwtV2IiMDbtF6urFKxokCM+bSbTiB7HmFcyHdjBOQY2fr7jvjHpk
         0Tp6BzzmFLTbowO+VdDROLX/6kFKEJFtIvvoG0HsMsAAwPg/+6YWD4UMIn6sA5d+0spt
         WSRa67M5mI6/iQueATDn0atS5amKoDDLxMhkgoszLy/ZqvGcgbvHzvxMB65k5L1gYGyF
         S0FQ==
Received: by 10.216.144.199 with SMTP id n49mr7401391wej.25.1338837558045;
        Mon, 04 Jun 2012 12:19:18 -0700 (PDT)
Received: from volek-HP.rooms.iriga (AGrenoble-257-1-124-53.w90-27.abo.wanadoo.fr. [90.27.155.53])
        by mx.google.com with ESMTPS id eb8sm21872509wib.11.2012.06.04.12.19.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 04 Jun 2012 12:19:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.552.gaa3bb87
In-Reply-To: <y>
X-Gm-Message-State: ALoCoQlSsQxzfKf8oCfhIf4jlRxL01DfOTedPFjqWETMT8YYKpBKt6Pgx1Zanf5xVvxh2i2tWciE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199169>

From: Volek Pavel <me@pavelvolek.cz>

The current version of the git-remote-mediawiki supports only import and export of the pages, doesn't support import and export of file attachements which are also exposed by MediaWiki API. This patch adds the functionality to import the last versions of the files and all versions of description pages for these files.

Signed-off-by: Pavel Volek <Pavel.Volek@ensimag.imag.fr>
Signed-off-by: NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>
Signed-off-by: ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/mw-to-git/git-remote-mediawiki | 128 +++++++++++++++++++++++++++++++--
 1 file changed, 123 insertions(+), 5 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
index c18bfa1..4168218 100755
--- a/contrib/mw-to-git/git-remote-mediawiki
+++ b/contrib/mw-to-git/git-remote-mediawiki
@@ -267,6 +267,39 @@ sub get_mw_pages {
 	return values(%pages);
 }
 
+sub get_mw_media_pages {
+	mw_connect_maybe();
+
+	my %pages; # hash on page titles to avoid duplicates
+
+	# get all pages for mediafiles (they are in different namespace)
+	# only one namespace can be queried at the same moment
+	my $mw_pages = $mediawiki->list({
+		action => 'query',
+		list => 'allpages',
+		apnamespace => get_mw_namespace_id("File"),
+		aplimit => 500,
+	});
+	if (!defined($mw_pages)) {
+		print STDERR "fatal: could not get the list of media file pages.\n";
+		print STDERR "fatal: '$url' does not appear to be a mediawiki\n";
+		print STDERR "fatal: make sure '$url/api.php' is a valid page.\n";
+		exit 1;
+	}
+	foreach my $page (@{$mw_pages}) {
+		$pages{$page->{title}} = $page;
+	}
+	return values(%pages);
+}
+
+sub get_all_mw_pages() {
+	my @pages = get_mw_pages();
+	my @media_pages = get_mw_media_pages();
+	push(@pages,@media_pages);
+
+	return @pages;
+}
+
 sub run_git {
 	open(my $git, "-|:encoding(UTF-8)", "git " . $_[0]);
 	my $res = do { local $/; <$git> };
@@ -300,7 +333,7 @@ my %basetimestamps;
 sub get_last_remote_revision {
 	mw_connect_maybe();
 
-	my @pages = get_mw_pages();
+	my @pages = get_all_mw_pages();
 
 	my $max_rev_num = 0;
 
@@ -403,6 +436,25 @@ sub mw_option {
 	print STDOUT "unsupported\n";
 }
 
+# Returns MediaWiki id for a canonical namespace name. Ex.: "File", "Project".
+sub get_mw_namespace_id() {
+	mw_connect_maybe();
+	my $name = shift;
+	my $query = {
+		action => 'query',
+		meta => 'siteinfo',
+		siprop => 'namespaces',
+	};
+	my $result = $mediawiki->api($query);
+
+	while (my ($id, $ns) = each(%{$result->{query}->{namespaces}})) {
+		if (defined($ns->{canonical}) && ($ns->{canonical} eq $name)) {
+			return $ns->{id};
+		}
+	}
+	die "Namespace $name was not found on MediaWiki.";
+}
+
 sub fetch_mw_revisions_for_page {
 	my $page = shift;
 	my $id = shift;
@@ -461,11 +513,37 @@ sub fetch_mw_revisions {
 	return ($n, @revisions);
 }
 
+sub download_mw_mediafile {
+	my $filename = shift;
+
+	$mediawiki->{config}->{files_url} = $url;
+
+	my $file = $mediawiki->download( { title => $filename } )
+			|| die 'Fatal: Error ' .
+				$mediawiki->{error}->{code} .
+				' from mediwiki: ' . $mediawiki->{error}->{details};
+	if (!defined($file)){
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
 sub import_file_revision {
 	my $commit = shift;
 	my %commit = %{$commit};
 	my $full_import = shift;
 	my $n = shift;
+	my $mediafile_import = shift;
+	my $mediafile;my %mediafile;
+	if ($mediafile_import) {
+		$mediafile = shift;
+		%mediafile = %{$mediafile};
+	}
 
 	my $title = $commit{title};
 	my $comment = $commit{comment};
@@ -485,6 +563,10 @@ sub import_file_revision {
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
@@ -547,7 +629,7 @@ sub mw_import_ref {
 
 	mw_connect_maybe();
 
-	my @pages = get_mw_pages();
+	my @pages = get_all_mw_pages();
 
 	print STDERR "Searching revisions...\n";
 	my $last_local = get_last_local_revision();
@@ -580,6 +662,7 @@ sub mw_import_ref {
 
 		$n++;
 
+		my $page_title = $result->{query}->{pages}->{$pagerevid->{pageid}}->{title};
 		my %commit;
 		$commit{author} = $rev->{user} || 'Anonymous';
 		$commit{comment} = $rev->{comment} || '*Empty MediaWiki Message*';
@@ -596,9 +679,44 @@ sub mw_import_ref {
 		}
 		$commit{date} = DateTime::Format::ISO8601->parse_datetime($last_timestamp);
 
-		print STDERR "$n/", scalar(@revisions), ": Revision #$pagerevid->{revid} of $commit{title}\n";
-
-		import_file_revision(\%commit, ($fetch_from == 1), $n);
+		# differentiates classic pages and media pages
+		my @prefix = split (":",$page_title);
+		if ($prefix[0] eq "File" || $prefix[0] eq "Image") {
+			# check if there is a corresponding mediafile with the same timestamp => it is page
+			# for new verion of the file (not only for new version of the description of the file)
+			# => download corresponding file version
+			$query = {
+				action => 'query',
+				prop => 'imageinfo',
+				titles => $page_title,
+				iistart => $rev->{timestamp},
+				iiend => $rev->{timestamp},
+				iiprop => 'timestamp|archivename',
+				iilimit => 1,
+			};
+			$result = $mediawiki->api($query);
+
+			my ($imageid,$imageinfo) = each ( %{$result->{query}->{pages}} );
+			# page has a related version of the file
+			if (defined($imageinfo->{imageinfo})) {
+				foreach ( @{$imageinfo->{imageinfo}} ) {
+					my %mediafile;
+					if ($prefix[0] eq "File") { $mediafile{title} = substr $page_title, 5; }
+					else { $mediafile{title} = substr $page_title, 6; }
+
+					$mediafile{content} = download_mw_mediafile("File:".$mediafile{title});
+					print STDERR "$n/", scalar(@revisions), ": Revision #$pagerevid->{revid} of $commit{title}\n";
+					import_file_revision(\%commit, ($fetch_from == 1), $n, 1, \%mediafile);
+				}
+			# page has no related version of the file, do commit only for the page
+			} else {
+				print STDERR "$n/", scalar(@revisions), ": Revision #$pagerevid->{revid} of $commit{title}\n";
+				import_file_revision(\%commit, ($fetch_from == 1), $n, 0);
+			}
+		} else {
+			print STDERR "$n/", scalar(@revisions), ": Revision #$pagerevid->{revid} of $commit{title}\n";
+			import_file_revision(\%commit, ($fetch_from == 1), $n, 0);
+		}
 	}
 
 	if ($fetch_from == 1 && $n == 0) {
-- 
1.7.10.2.552.gaa3bb87
