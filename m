From: benoit.person@ensimag.fr
Subject: [PATCH/RFC 2/4] git-mw: Moving some functions from git-remote-mediawiki.perl to GitMediawiki.pm
Date: Thu, 13 Jun 2013 12:07:17 +0200
Message-ID: <1371118039-18925-3-git-send-email-benoit.person@ensimag.fr>
References: <1371118039-18925-1-git-send-email-benoit.person@ensimag.fr>
Cc: Celestin Matte <celestin.matte@ensimag.fr>,
	Jeff King <peff@peff.net>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Benoit Person <benoit.person@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 13 12:07:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Un4Rh-0007zb-U5
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 12:07:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758565Ab3FMKH4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 06:07:56 -0400
Received: from mx1.imag.fr ([129.88.30.5]:36247 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758491Ab3FMKHx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 06:07:53 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5DA7e0s025772
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 13 Jun 2013 12:07:41 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5DA7fnY011008;
	Thu, 13 Jun 2013 12:07:41 +0200
Received: from localhost.localdomain (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r5DA7Wac026514;
	Thu, 13 Jun 2013 12:07:41 +0200
X-Mailer: git-send-email 1.8.3.GIT
In-Reply-To: <1371118039-18925-1-git-send-email-benoit.person@ensimag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 13 Jun 2013 12:07:41 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227713>

From: Benoit Person <benoit.person@ensimag.fr>

Moving mediawiki_clean_filename, mediawiki_smudge_filename and mw_connect_maybe
Since we have a clean namespace in a perl module, we also rename them into more
concise ones (clean_filename, smudge_filename and connect_maybe). It also
delete the side effects of mw_connect_maybe requiring it to be called with
parameters and returning the new instance of the Mediawiki::Api if it needs to
be created

Signed-off-by: Benoit Person <benoit.person@ensimag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>

---
 contrib/mw-to-git/GitMediawiki.pm           | 72 +++++++++++++++++++++++++-
 contrib/mw-to-git/git-remote-mediawiki.perl | 80 +++++------------------------
 2 files changed, 84 insertions(+), 68 deletions(-)

diff --git a/contrib/mw-to-git/GitMediawiki.pm b/contrib/mw-to-git/GitMediawiki.pm
index 8a0ffc7..acf4e43 100644
--- a/contrib/mw-to-git/GitMediawiki.pm
+++ b/contrib/mw-to-git/GitMediawiki.pm
@@ -18,7 +18,77 @@ require Exporter;
 @EXPORT = ();
 
 # Methods which can be called as standalone functions as well:
-@EXPORT_OK = ();
+@EXPORT_OK = qw(clean_filename smudge_filename connect_maybe);
+}
+
+# Mediawiki filenames can contain forward slashes. This variable decides by which pattern they should be replaced
+use constant SLASH_REPLACEMENT => '%2F';
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
+	git_cmd_try {
+		$wiki_login = Git::config("remote.${remote_name}.mwLogin");
+		$wiki_password = Git::config("remote.${remote_name}.mwPassword");
+		$wiki_domain = Git::config("remote.${remote_name}.mwDomain");}
+		"%s failed w/ code %d";
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
index be17e89..d679035 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -13,6 +13,8 @@
 
 use strict;
 use MediaWiki::API;
+use Git;
+use GitMediawiki qw(clean_filename smudge_filename connect_maybe);
 use DateTime::Format::ISO8601;
 
 # By default, use UTF-8 to communicate with Git and the user
@@ -24,9 +26,6 @@ use IPC::Open2;
 
 use warnings;
 
-# Mediawiki filenames can contain forward slashes. This variable decides by which pattern they should be replaced
-use constant SLASH_REPLACEMENT => "%2F";
-
 # It's not always possible to delete pages (may require some
 # privileges). Deleted pages are replaced with this content.
 use constant DELETED_CONTENT => "[[Category:Deleted]]\n";
@@ -159,36 +158,6 @@ while (<STDIN>) {
 # MediaWiki API instance, created lazily.
 my $mediawiki;
 
-sub mw_connect_maybe {
-	if ($mediawiki) {
-		return;
-	}
-	$mediawiki = MediaWiki::API->new;
-	$mediawiki->{config}->{api_url} = "$url/api.php";
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
-			print STDERR "Logged in mediawiki user \"$credential{username}\".\n";
-		} else {
-			print STDERR "Failed to log in mediawiki user \"$credential{username}\" on $url\n";
-			print STDERR "  (error " .
-				$mediawiki->{error}->{code} . ': ' .
-				$mediawiki->{error}->{details} . ")\n";
-			Git::credential(\%credential, 'reject');
-			exit 1;
-		}
-	}
-}
-
 sub fatal_mw_error {
 	my $action = shift;
 	print STDERR "fatal: could not $action.\n";
@@ -293,7 +262,7 @@ sub get_mw_first_pages {
 
 # Get the list of pages to be fetched according to configuration.
 sub get_mw_pages {
-	mw_connect_maybe();
+	$mediawiki = connect_maybe($mediawiki, $remotename, $url);
 
 	print STDERR "Listing pages on remote wiki...\n";
 
@@ -480,7 +449,7 @@ my %basetimestamps;
 # avoid a loop onto all tracked pages. This is useful for the fetch-by-rev
 # option.
 sub get_last_global_remote_rev {
-	mw_connect_maybe();
+	$mediawiki = connect_maybe($mediawiki, $remotename, $url);
 
 	my $query = {
 		action => 'query',
@@ -496,7 +465,7 @@ sub get_last_global_remote_rev {
 # Get the last remote revision concerning the tracked pages and the tracked
 # categories.
 sub get_last_remote_revision {
-	mw_connect_maybe();
+	$mediawiki = connect_maybe($mediawiki, $remotename, $url);
 
 	my %pages_hash = get_mw_pages();
 	my @pages = values(%pages_hash);
@@ -552,29 +521,6 @@ sub mediawiki_smudge {
 	return $string."\n";
 }
 
-sub mediawiki_clean_filename {
-	my $filename = shift;
-	$filename =~ s/@{[SLASH_REPLACEMENT]}/\//g;
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
-	$filename =~ s/\//@{[SLASH_REPLACEMENT]}/g;
-	$filename =~ s/ /_/g;
-	# Decode forbidden characters encoded in mediawiki_clean_filename
-	$filename =~ s/_%_([0-9a-fA-F][0-9a-fA-F])/sprintf("%c", hex($1))/ge;
-	return $filename;
-}
-
 sub literal_data {
 	my ($content) = @_;
 	print STDOUT "data ", bytes::length($content), "\n", $content;
@@ -775,7 +721,7 @@ sub mw_import_ref {
 		return;
 	}
 
-	mw_connect_maybe();
+	$mediawiki = connect_maybe($mediawiki, $remotename, $url);
 
 	print STDERR "Searching revisions...\n";
 	my $last_local = get_last_local_revision();
@@ -888,7 +834,7 @@ sub mw_import_revids {
 		my %commit;
 		$commit{author} = $rev->{user} || 'Anonymous';
 		$commit{comment} = $rev->{comment} || EMPTY_MESSAGE;
-		$commit{title} = mediawiki_smudge_filename($page_title);
+		$commit{title} = smudge_filename($page_title);
 		$commit{mw_revision} = $rev->{revid};
 		$commit{content} = mediawiki_smudge($rev->{'*'});
 
@@ -949,7 +895,7 @@ sub mw_upload_file {
 	}
 	# Deleting and uploading a file requires a priviledged user
 	if ($file_deleted) {
-		mw_connect_maybe();
+		$mediawiki = connect_maybe($mediawiki, $remotename, $url);
 		my $query = {
 			action => 'delete',
 			title => $path,
@@ -965,7 +911,7 @@ sub mw_upload_file {
 		# Don't let perl try to interpret file content as UTF-8 => use "raw"
 		my $content = run_git("cat-file blob $new_sha1", "raw");
 		if ($content ne "") {
-			mw_connect_maybe();
+			$mediawiki = connect_maybe($mediawiki, $remotename, $url);
 			$mediawiki->{config}->{upload_url} =
 				"$url/index.php/Special:Upload";
 			$mediawiki->edit({
@@ -1013,7 +959,7 @@ sub mw_push_file {
 	my $old_sha1 = $diff_info_split[2];
 	my $page_created = ($old_sha1 eq NULL_SHA1);
 	my $page_deleted = ($new_sha1 eq NULL_SHA1);
-	$complete_file_name = mediawiki_clean_filename($complete_file_name);
+	$complete_file_name = clean_filename($complete_file_name);
 
 	my ($title, $extension) = $complete_file_name =~ /^(.*)\.([^\.]*)$/;
 	if (!defined($extension)) {
@@ -1036,7 +982,7 @@ sub mw_push_file {
 			$file_content = run_git("cat-file blob $new_sha1");
 		}
 
-		mw_connect_maybe();
+		$mediawiki = connect_maybe($mediawiki, $remotename, $url);
 
 		my $result = $mediawiki->edit( {
 			action => 'edit',
@@ -1220,7 +1166,7 @@ sub mw_push_revision {
 }
 
 sub get_allowed_file_extensions {
-	mw_connect_maybe();
+	$mediawiki = connect_maybe($mediawiki, $remotename, $url);
 
 	my $query = {
 		action => 'query',
@@ -1244,7 +1190,7 @@ my %cached_mw_namespace_id;
 # Return MediaWiki id for a canonical namespace name.
 # Ex.: "File", "Project".
 sub get_mw_namespace_id {
-	mw_connect_maybe();
+	$mediawiki = connect_maybe($mediawiki, $remotename, $url);
 	my $name = shift;
 
 	if (!exists $namespace_id{$name}) {
-- 
1.8.3.GIT
