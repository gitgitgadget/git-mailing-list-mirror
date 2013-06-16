From: benoit.person@ensimag.fr
Subject: [PATCH V3 2/4] git-mw: Move some functions from git-remote-mediawiki.perl to GitMediawiki.pm
Date: Sun, 16 Jun 2013 04:31:31 +0200
Message-ID: <1371349893-7789-3-git-send-email-benoit.person@ensimag.fr>
References: <1371349893-7789-1-git-send-email-benoit.person@ensimag.fr>
Cc: Celestin Matte <celestin.matte@ensimag.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Benoit Person <benoit.person@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 16 04:32:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uo2lk-0007eC-Ie
	for gcvg-git-2@plane.gmane.org; Sun, 16 Jun 2013 04:32:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754888Ab3FPCc0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Jun 2013 22:32:26 -0400
Received: from mx1.imag.fr ([129.88.30.5]:48200 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754803Ab3FPCcR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jun 2013 22:32:17 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5G2WFaV015978
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 16 Jun 2013 04:32:15 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5G2WFk1013552;
	Sun, 16 Jun 2013 04:32:15 +0200
Received: from localhost.localdomain (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r5G2W1eK020162;
	Sun, 16 Jun 2013 04:32:15 +0200
X-Mailer: git-send-email 1.8.3.GIT
In-Reply-To: <1371349893-7789-1-git-send-email-benoit.person@ensimag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 16 Jun 2013 04:32:16 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227985>

From: Benoit Person <benoit.person@ensimag.fr>

Move and rename subs 'mediawiki_clean_filename' into 'clean_filename',
'mediawiki_smudge_filename' into 'smudge_filename' and
'mw_connect_maybe' into 'connect_maybe' since we have a cleaner namespace in
a perl module.
Move constants 'EMPTY', 'SLASH_REPLACEMENT' and 'HTTP_CODE_OK'.
Remove side effects in those functions to provide a cleaner API.
Update git-remote-mediawiki for those changes.

Signed-off-by: Benoit Person <benoit.person@ensimag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>

---

changes from the V2:
  - Move more constants to GitMediawiki.pm.
  - Remove the encapsulation of Git::config calls into a git_cmd_try one.

 contrib/mw-to-git/GitMediawiki.pm           | 77 +++++++++++++++++++++++++-
 contrib/mw-to-git/git-remote-mediawiki.perl | 85 +++++------------------------
 2 files changed, 89 insertions(+), 73 deletions(-)

diff --git a/contrib/mw-to-git/GitMediawiki.pm b/contrib/mw-to-git/GitMediawiki.pm
index 8a0ffc7..beae6d0 100644
--- a/contrib/mw-to-git/GitMediawiki.pm
+++ b/contrib/mw-to-git/GitMediawiki.pm
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
\ No newline at end of file
diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-to-git/git-remote-mediawiki.perl
index 9ff45fd..3b6422b 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -14,6 +14,8 @@
 use strict;
 use MediaWiki::API;
 use Git;
+use GitMediawiki qw(clean_filename smudge_filename connect_maybe
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
 my $remotename = $ARGV[0];
 my $url = $ARGV[1];
 
@@ -184,37 +179,6 @@ sub parse_command {
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
@@ -324,7 +288,7 @@ sub get_mw_first_pages {
 
 # Get the list of pages to be fetched according to configuration.
 sub get_mw_pages {
-	mw_connect_maybe();
+	$mediawiki = connect_maybe($mediawiki, $remotename, $url);
 
 	print {*STDERR} "Listing pages on remote wiki...\n";
 
@@ -514,7 +478,7 @@ sub get_last_local_revision {
 # avoid a loop onto all tracked pages. This is useful for the fetch-by-rev
 # option.
 sub get_last_global_remote_rev {
-	mw_connect_maybe();
+	$mediawiki = connect_maybe($mediawiki, $remotename, $url);
 
 	my $query = {
 		action => 'query',
@@ -530,7 +494,7 @@ sub get_last_global_remote_rev {
 # Get the last remote revision concerning the tracked pages and the tracked
 # categories.
 sub get_last_remote_revision {
-	mw_connect_maybe();
+	$mediawiki = connect_maybe($mediawiki, $remotename, $url);
 
 	my %pages_hash = get_mw_pages();
 	my @pages = values(%pages_hash);
@@ -586,29 +550,6 @@ sub mediawiki_smudge {
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
@@ -816,7 +757,7 @@ sub mw_import_ref {
 		return;
 	}
 
-	mw_connect_maybe();
+	$mediawiki = connect_maybe($mediawiki, $remotename, $url);
 
 	print {*STDERR} "Searching revisions...\n";
 	my $last_local = get_last_local_revision();
@@ -930,7 +871,7 @@ sub mw_import_revids {
 		my %commit;
 		$commit{author} = $rev->{user} || 'Anonymous';
 		$commit{comment} = $rev->{comment} || EMPTY_MESSAGE;
-		$commit{title} = mediawiki_smudge_filename($page_title);
+		$commit{title} = smudge_filename($page_title);
 		$commit{mw_revision} = $rev->{revid};
 		$commit{content} = mediawiki_smudge($rev->{'*'});
 
@@ -991,7 +932,7 @@ sub mw_upload_file {
 	}
 	# Deleting and uploading a file requires a priviledged user
 	if ($file_deleted) {
-		mw_connect_maybe();
+		$mediawiki = connect_maybe($mediawiki, $remotename, $url);
 		my $query = {
 			action => 'delete',
 			title => $path,
@@ -1007,7 +948,7 @@ sub mw_upload_file {
 		# Don't let perl try to interpret file content as UTF-8 => use "raw"
 		my $content = run_git("cat-file blob ${new_sha1}", 'raw');
 		if ($content ne EMPTY) {
-			mw_connect_maybe();
+			$mediawiki = connect_maybe($mediawiki, $remotename, $url);
 			$mediawiki->{config}->{upload_url} =
 				"${url}/index.php/Special:Upload";
 			$mediawiki->edit({
@@ -1055,7 +996,7 @@ sub mw_push_file {
 	my $old_sha1 = $diff_info_split[2];
 	my $page_created = ($old_sha1 eq NULL_SHA1);
 	my $page_deleted = ($new_sha1 eq NULL_SHA1);
-	$complete_file_name = mediawiki_clean_filename($complete_file_name);
+	$complete_file_name = clean_filename($complete_file_name);
 
 	my ($title, $extension) = $complete_file_name =~ /^(.*)\.([^\.]*)$/;
 	if (!defined($extension)) {
@@ -1078,7 +1019,7 @@ sub mw_push_file {
 			$file_content = run_git("cat-file blob ${new_sha1}");
 		}
 
-		mw_connect_maybe();
+		$mediawiki = connect_maybe($mediawiki, $remotename, $url);
 
 		my $result = $mediawiki->edit( {
 			action => 'edit',
@@ -1264,7 +1205,7 @@ sub mw_push_revision {
 }
 
 sub get_allowed_file_extensions {
-	mw_connect_maybe();
+	$mediawiki = connect_maybe($mediawiki, $remotename, $url);
 
 	my $query = {
 		action => 'query',
@@ -1288,7 +1229,7 @@ my %cached_mw_namespace_id;
 # Return MediaWiki id for a canonical namespace name.
 # Ex.: "File", "Project".
 sub get_mw_namespace_id {
-	mw_connect_maybe();
+	$mediawiki = connect_maybe($mediawiki, $remotename, $url);
 	my $name = shift;
 
 	if (!exists $namespace_id{$name}) {
-- 
1.8.3.GIT
