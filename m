From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 3/5] git-remote-mediawiki: send "File:" attachments to a remote wiki
Date: Wed, 27 Jun 2012 11:10:18 +0200
Message-ID: <1340788220-10084-4-git-send-email-Matthieu.Moy@imag.fr>
References: <1340726673-25496-1-git-send-email-Matthieu.Moy@imag.fr>
 <1340788220-10084-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Pavel.Volek@ensimag.imag.fr, Kim-Thuat.Nguyen@ensimag.imag.fr,
	roucherj@ensimag.imag.fr, Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jun 27 11:11:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjoHB-0005rw-NR
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jun 2012 11:11:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756452Ab2F0JKs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jun 2012 05:10:48 -0400
Received: from mx1.imag.fr ([129.88.30.5]:52346 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756051Ab2F0JKo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2012 05:10:44 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q5R99xjx020049
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 27 Jun 2012 11:09:59 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SjoGk-0003Of-2E; Wed, 27 Jun 2012 11:10:38 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SjoGk-0002dm-15; Wed, 27 Jun 2012 11:10:38 +0200
X-Mailer: git-send-email 1.7.11.5.g0c7e058.dirty
In-Reply-To: <1340788220-10084-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 27 Jun 2012 11:09:59 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5R99xjx020049
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1341393001.13264@6PMQ/nW60ETnf7TShMj1vA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200705>

From: NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>

The current version of the git-remote-mediawiki supports only import and
export of plain wiki pages. This patch adds the functionality to export
file attachments (i.e. the content of the File: MediaWiki namespace),
which are also exposed by MediaWiki API.

This requires a recent version of MediaWiki::API (Version 0.37 works.
Version 0.34 doesn't).

Signed-off-by: Pavel Volek <Pavel.Volek@ensimag.imag.fr>
Signed-off-by: NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>
Signed-off-by: ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/mw-to-git/git-remote-mediawiki | 98 +++++++++++++++++++++++++++++++---
 1 file changed, 90 insertions(+), 8 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
index f2e841e..3405772 100755
--- a/contrib/mw-to-git/git-remote-mediawiki
+++ b/contrib/mw-to-git/git-remote-mediawiki
@@ -348,8 +348,12 @@ sub get_mw_pages {
 	return values(%pages);
 }
 
+# usage: $out = run_git("command args");
+#        $out = run_git("command args", "raw"); # don't interpret output as UTF-8.
 sub run_git {
-	open(my $git, "-|:encoding(UTF-8)", "git " . $_[0]);
+	my $args = shift;
+	my $encoding = (shift || "encoding(UTF-8)");
+	open(my $git, "-|:$encoding", "git " . $args);
 	my $res = do { local $/; <$git> };
 	close($git);
 
@@ -705,6 +709,63 @@ sub error_non_fast_forward {
 	return 0;
 }
 
+sub mw_upload_file {
+	my $complete_file_name = shift;
+	my $new_sha1 = shift;
+	my $extension = shift;
+	my $file_deleted = shift;
+	my $summary = shift;
+	my $newrevid;
+	my $path = "File:" . $complete_file_name;
+	my %hashFiles = get_allowed_file_extensions();
+	if (!exists($hashFiles{$extension})) {
+		print STDERR "$complete_file_name is not a permitted file on this wiki.\n";
+		print STDERR "Check the configuration of file uploads in your mediawiki.\n";
+		return $newrevid;
+	}
+	# Deleting and uploading a file requires a priviledged user
+	if ($file_deleted) {
+		mw_connect_maybe();
+		my $query = {
+			action => 'delete',
+			title => $path,
+			reason => $summary
+		};
+		if (!$mediawiki->edit($query)) {
+			print STDERR "Failed to delete file on remote wiki\n";
+			print STDERR "Check your permissions on the remote site. Error code:\n";
+			print STDERR $mediawiki->{error}->{code} . ':' . $mediawiki->{error}->{details};
+			exit 1;
+		}
+	} else {
+		# Don't let perl try to interpret file content as UTF-8 => use "raw"
+		my $content = run_git("cat-file blob $new_sha1", "raw");
+		if ($content ne "") {
+			mw_connect_maybe();
+			$mediawiki->{config}->{upload_url} =
+				"$url/index.php/Special:Upload";
+			$mediawiki->edit({
+				action => 'upload',
+				filename => $complete_file_name,
+				comment => $summary,
+				file => [undef,
+					 $complete_file_name,
+					 Content => $content],
+				ignorewarnings => 1,
+			}, {
+				skip_encoding => 1
+			} ) || die $mediawiki->{error}->{code} . ':'
+				 . $mediawiki->{error}->{details};
+			my $last_file_page = $mediawiki->get_page({title => $path});
+			$newrevid = $last_file_page->{revid};
+			print STDERR "Pushed file: $new_sha1 - $complete_file_name.\n";
+		} else {
+			print STDERR "Empty file $complete_file_name not pushed.\n";
+		}
+	}
+	return $newrevid;
+}
+
 sub mw_push_file {
 	my $diff_info = shift;
 	# $diff_info contains a string in this format:
@@ -717,7 +778,8 @@ sub mw_push_file {
 	my $summary = shift;
 	# MediaWiki revision number. Keep the previous one by default,
 	# in case there's no edit to perform.
-	my $newrevid = shift;
+	my $oldrevid = shift;
+	my $newrevid;
 
 	my $new_sha1 = $diff_info_split[3];
 	my $old_sha1 = $diff_info_split[2];
@@ -725,9 +787,11 @@ sub mw_push_file {
 	my $page_deleted = ($new_sha1 eq NULL_SHA1);
 	$complete_file_name = mediawiki_clean_filename($complete_file_name);
 
-	if (substr($complete_file_name,-3) eq ".mw") {
-		my $title = substr($complete_file_name,0,-3);
-
+	my ($title, $extension) = $complete_file_name =~ /^(.*)\.([^\.]*)$/;
+	if (!defined($extension)) {
+		$extension = "";
+	}
+	if ($extension eq "mw") {
 		my $file_content;
 		if ($page_deleted) {
 			# Deleting a page usually requires
@@ -745,7 +809,7 @@ sub mw_push_file {
 			action => 'edit',
 			summary => $summary,
 			title => $title,
-			basetimestamp => $basetimestamps{$newrevid},
+			basetimestamp => $basetimestamps{$oldrevid},
 			text => mediawiki_clean($file_content, $page_created),
 				  }, {
 					  skip_encoding => 1 # Helps with names with accentuated characters
@@ -757,7 +821,7 @@ sub mw_push_file {
 				    $mediawiki->{error}->{code} .
 				    ' from mediwiki: ' . $mediawiki->{error}->{details} .
 				    ".\n";
-				return ($newrevid, "non-fast-forward");
+				return ($oldrevid, "non-fast-forward");
 			} else {
 				# Other errors. Shouldn't happen => just die()
 				die 'Fatal: Error ' .
@@ -768,8 +832,11 @@ sub mw_push_file {
 		$newrevid = $result->{edit}->{newrevid};
 		print STDERR "Pushed file: $new_sha1 - $title\n";
 	} else {
-		print STDERR "$complete_file_name not a mediawiki file (Not pushable on this version of git-remote-mediawiki).\n"
+		$newrevid = mw_upload_file($complete_file_name, $new_sha1,
+					   $extension, $page_deleted,
+					   $summary);
 	}
+	$newrevid = ($newrevid or $oldrevid);
 	return ($newrevid, "ok");
 }
 
@@ -906,3 +973,18 @@ sub mw_push_revision {
 	print STDOUT "ok $remote\n";
 	return 1;
 }
+
+sub get_allowed_file_extensions {
+	mw_connect_maybe();
+
+	my $query = {
+		action => 'query',
+		meta => 'siteinfo',
+		siprop => 'fileextensions'
+		};
+	my $result = $mediawiki->api($query);
+	my @file_extensions= map $_->{ext},@{$result->{query}->{fileextensions}};
+	my %hashFile = map {$_ => 1}@file_extensions;
+
+	return %hashFile;
+}
-- 
1.7.11.5.g0c7e058.dirty
