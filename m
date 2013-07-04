From: benoit.person@ensimag.fr
Subject: [PATCH v8 5/7] git-remote-mediawiki: Factoring code between git-remote-mediawiki and Git::Mediawiki
Date: Thu,  4 Jul 2013 22:38:58 +0200
Message-ID: <1372970340-6545-6-git-send-email-benoit.person@ensimag.fr>
References: <1372970340-6545-1-git-send-email-benoit.person@ensimag.fr>
Cc: Celestin Matte <celestin.matte@ensimag.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Benoit Person <benoit.person@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 04 22:39:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuqJe-0007sq-68
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 22:39:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933211Ab3GDUje (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jul 2013 16:39:34 -0400
Received: from mx2.imag.fr ([129.88.30.17]:43248 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933174Ab3GDUja (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jul 2013 16:39:30 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r64Kd91S011157
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 4 Jul 2013 22:39:09 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r64KdB0v020605;
	Thu, 4 Jul 2013 22:39:11 +0200
Received: from localhost.localdomain (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r64Kd3ij025632;
	Thu, 4 Jul 2013 22:39:11 +0200
X-Mailer: git-send-email 1.8.3.1.590.gc07d91b
In-Reply-To: <1372970340-6545-1-git-send-email-benoit.person@ensimag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 04 Jul 2013 22:39:09 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r64Kd91S011157
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: benoit.person@ensimag.fr
MailScanner-NULL-Check: 1373575150.09467@zkC5r5RmoV/G3YCH+8c5Jw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229619>

From: Benoit Person <benoit.person@ensimag.fr>

For now, Git::Mediawiki contains nothing.

This first patch moves some of git-remote-mediawiki.perl's factorisable code
into Git::Mediawiki. In the same time, it removes the side effects of that code
and renames the fucntions and constants moved to expose a better API.

Signed-off-by: Benoit Person <benoit.person@ensimag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
 contrib/mw-to-git/Git/Mediawiki.pm          | 77 +++++++++++++++++++++++++-
 contrib/mw-to-git/git-remote-mediawiki.perl | 85 +++++------------------------
 2 files changed, 89 insertions(+), 73 deletions(-)

diff --git a/contrib/mw-to-git/Git/Mediawiki.pm b/contrib/mw-to-git/Git/Mediawiki.pm
index 805f42a..47fe4f4 100644
--- a/contrib/mw-to-git/Git/Mediawiki.pm
+++ b/contrib/mw-to-git/Git/Mediawiki.pm
@@ -18,7 +18,82 @@ require Exporter;
 @EXPORT = ();
 
 # Methods which can be called as standalone functions as well:
-@EXPORT_OK = ();
+@EXPORT_OK = qw(clean_filename smudge_filename connect_maybe
+				EMPTY HTTP_CODE_OK);
+}
+
+# Mediawiki filenames can contain forward slashes. This variable decides by which pattern they should be replaced
+use constant SLASH_REPLACEMENT => '%2F';
+
+# Used to test for empty strings
+use constant EMPTY => q{};
+
+# HTTP codes
+use constant HTTP_CODE_OK => 200;
+
+sub clean_filename {
+	my $filename = shift;
+	$filename =~ s{@{[SLASH_REPLACEMENT]}}{/}g;
+	# [, ], |, {, and } are forbidden by MediaWiki, even URL-encoded.
+	# Do a variant of URL-encoding, i.e. looks like URL-encoding,
+	# but with _ added to prevent MediaWiki from thinking this is
+	# an actual special character.
+	$filename =~ s/[\[\]\{\}\|]/sprintf("_%%_%x", ord($&))/ge;
+	# If we use the uri escape before
+	# we should unescape here, before anything
+
+	return $filename;
+}
+
+sub smudge_filename {
+	my $filename = shift;
+	$filename =~ s{/}{@{[SLASH_REPLACEMENT]}}g;
+	$filename =~ s/ /_/g;
+	# Decode forbidden characters encoded in clean_filename
+	$filename =~ s/_%_([0-9a-fA-F][0-9a-fA-F])/sprintf('%c', hex($1))/ge;
+	return $filename;
+}
+
+sub connect_maybe {
+	my $wiki = shift;
+	if ($wiki) {
+		return $wiki;
+	}
+
+	my $remote_name = shift;
+	my $remote_url = shift;
+	my ($wiki_login, $wiki_password, $wiki_domain);
+
+	$wiki_login = Git::config("remote.${remote_name}.mwLogin");
+	$wiki_password = Git::config("remote.${remote_name}.mwPassword");
+	$wiki_domain = Git::config("remote.${remote_name}.mwDomain");
+
+	$wiki = MediaWiki::API->new;
+	$wiki->{config}->{api_url} = "${remote_url}/api.php";
+	if ($wiki_login) {
+		my %credential = (
+			'url' => $remote_url,
+			'username' => $wiki_login,
+			'password' => $wiki_password
+		);
+		Git::credential(\%credential);
+		my $request = {lgname => $credential{username},
+			       lgpassword => $credential{password},
+			       lgdomain => $wiki_domain};
+		if ($wiki->login($request)) {
+			Git::credential(\%credential, 'approve');
+			print {*STDERR} qq(Logged in mediawiki user "$credential{username}".\n);
+		} else {
+			print {*STDERR} qq(Failed to log in mediawiki user "$credential{username}" on ${remote_url}\n);
+			print {*STDERR} '  (error ' .
+				$wiki->{error}->{code} . ': ' .
+				$wiki->{error}->{details} . ")\n";
+			Git::credential(\%credential, 'reject');
+			exit 1;
+		}
+	}
+
+	return $wiki;
 }
 
 1; # Famous last words
diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-to-git/git-remote-mediawiki.perl
index 71baf8a..e40c034 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -14,6 +14,8 @@
 use strict;
 use MediaWiki::API;
 use Git;
+use Git::Mediawiki qw(clean_filename smudge_filename connect_maybe
+					EMPTY HTTP_CODE_OK);
 use DateTime::Format::ISO8601;
 use warnings;
 
@@ -23,9 +25,6 @@ binmode STDOUT, ':encoding(UTF-8)';
 
 use URI::Escape;
 
-# Mediawiki filenames can contain forward slashes. This variable decides by which pattern they should be replaced
-use constant SLASH_REPLACEMENT => '%2F';
-
 # It's not always possible to delete pages (may require some
 # privileges). Deleted pages are replaced with this content.
 use constant DELETED_CONTENT => "[[Category:Deleted]]\n";
@@ -40,8 +39,6 @@ use constant NULL_SHA1 => '0000000000000000000000000000000000000000';
 # Used on Git's side to reflect empty edit messages on the wiki
 use constant EMPTY_MESSAGE => '*Empty MediaWiki Message*';
 
-use constant EMPTY => q{};
-
 # Number of pages taken into account at once in submodule get_mw_page_list
 use constant SLICE_SIZE => 50;
 
@@ -50,8 +47,6 @@ use constant SLICE_SIZE => 50;
 # the number of links to be returned (500 links max).
 use constant BATCH_SIZE => 10;
 
-use constant HTTP_CODE_OK => 200;
-
 if (@ARGV != 2) {
 	exit_error_usage();
 }
@@ -199,37 +194,6 @@ sub parse_command {
 # MediaWiki API instance, created lazily.
 my $mediawiki;
 
-sub mw_connect_maybe {
-	if ($mediawiki) {
-		return;
-	}
-	$mediawiki = MediaWiki::API->new;
-	$mediawiki->{config}->{api_url} = "${url}/api.php";
-	if ($wiki_login) {
-		my %credential = (
-			'url' => $url,
-			'username' => $wiki_login,
-			'password' => $wiki_passwd
-		);
-		Git::credential(\%credential);
-		my $request = {lgname => $credential{username},
-			       lgpassword => $credential{password},
-			       lgdomain => $wiki_domain};
-		if ($mediawiki->login($request)) {
-			Git::credential(\%credential, 'approve');
-			print {*STDERR} qq(Logged in mediawiki user "$credential{username}".\n);
-		} else {
-			print {*STDERR} qq(Failed to log in mediawiki user "$credential{username}" on ${url}\n);
-			print {*STDERR} '  (error ' .
-				$mediawiki->{error}->{code} . ': ' .
-				$mediawiki->{error}->{details} . ")\n";
-			Git::credential(\%credential, 'reject');
-			exit 1;
-		}
-	}
-	return;
-}
-
 sub fatal_mw_error {
 	my $action = shift;
 	print STDERR "fatal: could not $action.\n";
@@ -339,7 +303,7 @@ sub get_mw_first_pages {
 
 # Get the list of pages to be fetched according to configuration.
 sub get_mw_pages {
-	mw_connect_maybe();
+	$mediawiki = connect_maybe($mediawiki, $remotename, $url);
 
 	print {*STDERR} "Listing pages on remote wiki...\n";
 
@@ -529,7 +493,7 @@ sub get_last_local_revision {
 # avoid a loop onto all tracked pages. This is useful for the fetch-by-rev
 # option.
 sub get_last_global_remote_rev {
-	mw_connect_maybe();
+	$mediawiki = connect_maybe($mediawiki, $remotename, $url);
 
 	my $query = {
 		action => 'query',
@@ -545,7 +509,7 @@ sub get_last_global_remote_rev {
 # Get the last remote revision concerning the tracked pages and the tracked
 # categories.
 sub get_last_remote_revision {
-	mw_connect_maybe();
+	$mediawiki = connect_maybe($mediawiki, $remotename, $url);
 
 	my %pages_hash = get_mw_pages();
 	my @pages = values(%pages_hash);
@@ -601,29 +565,6 @@ sub mediawiki_smudge {
 	return "${string}\n";
 }
 
-sub mediawiki_clean_filename {
-	my $filename = shift;
-	$filename =~ s{@{[SLASH_REPLACEMENT]}}{/}g;
-	# [, ], |, {, and } are forbidden by MediaWiki, even URL-encoded.
-	# Do a variant of URL-encoding, i.e. looks like URL-encoding,
-	# but with _ added to prevent MediaWiki from thinking this is
-	# an actual special character.
-	$filename =~ s/[\[\]\{\}\|]/sprintf("_%%_%x", ord($&))/ge;
-	# If we use the uri escape before
-	# we should unescape here, before anything
-
-	return $filename;
-}
-
-sub mediawiki_smudge_filename {
-	my $filename = shift;
-	$filename =~ s{/}{@{[SLASH_REPLACEMENT]}}g;
-	$filename =~ s/ /_/g;
-	# Decode forbidden characters encoded in mediawiki_clean_filename
-	$filename =~ s/_%_([0-9a-fA-F][0-9a-fA-F])/sprintf('%c', hex($1))/ge;
-	return $filename;
-}
-
 sub literal_data {
 	my ($content) = @_;
 	print {*STDOUT} 'data ', bytes::length($content), "\n", $content;
@@ -831,7 +772,7 @@ sub mw_import_ref {
 		return;
 	}
 
-	mw_connect_maybe();
+	$mediawiki = connect_maybe($mediawiki, $remotename, $url);
 
 	print {*STDERR} "Searching revisions...\n";
 	my $last_local = get_last_local_revision();
@@ -945,7 +886,7 @@ sub mw_import_revids {
 		my %commit;
 		$commit{author} = $rev->{user} || 'Anonymous';
 		$commit{comment} = $rev->{comment} || EMPTY_MESSAGE;
-		$commit{title} = mediawiki_smudge_filename($page_title);
+		$commit{title} = smudge_filename($page_title);
 		$commit{mw_revision} = $rev->{revid};
 		$commit{content} = mediawiki_smudge($rev->{'*'});
 
@@ -1006,7 +947,7 @@ sub mw_upload_file {
 	}
 	# Deleting and uploading a file requires a priviledged user
 	if ($file_deleted) {
-		mw_connect_maybe();
+		$mediawiki = connect_maybe($mediawiki, $remotename, $url);
 		my $query = {
 			action => 'delete',
 			title => $path,
@@ -1022,7 +963,7 @@ sub mw_upload_file {
 		# Don't let perl try to interpret file content as UTF-8 => use "raw"
 		my $content = run_git("cat-file blob ${new_sha1}", 'raw');
 		if ($content ne EMPTY) {
-			mw_connect_maybe();
+			$mediawiki = connect_maybe($mediawiki, $remotename, $url);
 			$mediawiki->{config}->{upload_url} =
 				"${url}/index.php/Special:Upload";
 			$mediawiki->edit({
@@ -1070,7 +1011,7 @@ sub mw_push_file {
 	my $old_sha1 = $diff_info_split[2];
 	my $page_created = ($old_sha1 eq NULL_SHA1);
 	my $page_deleted = ($new_sha1 eq NULL_SHA1);
-	$complete_file_name = mediawiki_clean_filename($complete_file_name);
+	$complete_file_name = clean_filename($complete_file_name);
 
 	my ($title, $extension) = $complete_file_name =~ /^(.*)\.([^\.]*)$/;
 	if (!defined($extension)) {
@@ -1093,7 +1034,7 @@ sub mw_push_file {
 			$file_content = run_git("cat-file blob ${new_sha1}");
 		}
 
-		mw_connect_maybe();
+		$mediawiki = connect_maybe($mediawiki, $remotename, $url);
 
 		my $result = $mediawiki->edit( {
 			action => 'edit',
@@ -1279,7 +1220,7 @@ sub mw_push_revision {
 }
 
 sub get_allowed_file_extensions {
-	mw_connect_maybe();
+	$mediawiki = connect_maybe($mediawiki, $remotename, $url);
 
 	my $query = {
 		action => 'query',
@@ -1303,7 +1244,7 @@ my %cached_mw_namespace_id;
 # Return MediaWiki id for a canonical namespace name.
 # Ex.: "File", "Project".
 sub get_mw_namespace_id {
-	mw_connect_maybe();
+	$mediawiki = connect_maybe($mediawiki, $remotename, $url);
 	my $name = shift;
 
 	if (!exists $namespace_id{$name}) {
-- 
1.8.3.1.590.gc07d91b
