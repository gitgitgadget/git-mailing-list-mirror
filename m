From: kim-thuat.nguyen@ensimag.imag.fr
Subject: [PATCHv3] git-remote-mediawiki: export File: attachments
Date: Wed, 13 Jun 2012 09:56:30 +0200
Message-ID: <1339574190-2596-1-git-send-email-Kim-Thuat.Nguyen@ensimag.imag.fr>
References: <y>
Cc: nguyenkimthuat <Kim-Thuat.Nguyen@ensimag.imag.fr>,
	VOLEK Pavel <Pavel.Volek@ensimag.imag.fr>,
	ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 13 09:57:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeiRq-0003Y6-Sr
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jun 2012 09:57:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752097Ab2FMH4o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jun 2012 03:56:44 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:35614 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751679Ab2FMH4m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2012 03:56:42 -0400
Received: by weyu7 with SMTP id u7so271836wey.19
        for <git@vger.kernel.org>; Wed, 13 Jun 2012 00:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=FHbegGSv5XZtPu9qSzOIYXcbq4CTMJ5uaxiKsQOuC8U=;
        b=NmVyl7RypJMvJJCS2D5MjThignfUnWGx5Wg4IEgW9d6iFExZ1ehefK0qql/mZ4S/Cc
         2HCmqF5XqhPd2cBQiqH4rKY4i/Pok+yZlfJfOjwcT5VGN/xbQ5ypnGjTLnmIWEckSPRr
         rnWJxZ3TRAGV8rEbjgon1qmrB5zozTNH66zsv8IsNhgtKcTqEzZqJthTSSqSbEVyHodv
         anAMhMe49FxDoms4e+1/ylyBnDDpcnDdACEjzhDXa2JtQ5NqB1kM6QKQb4EUhFFyiOJS
         2+BWNWQGXGu7ItaGJQVHJSEFqI8O/uhkZfwAZJYkT4+s/tkwXqa9i+xvQ0BzoCxYHpOQ
         02lA==
Received: by 10.216.194.23 with SMTP id l23mr1004973wen.121.1339574201289;
        Wed, 13 Jun 2012 00:56:41 -0700 (PDT)
Received: from nguyenkimthuat-K40IN.grenet.fr (wifi-030059.grenet.fr. [130.190.30.59])
        by mx.google.com with ESMTPS id f19sm6870447wiw.11.2012.06.13.00.56.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Jun 2012 00:56:40 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.rc2.10.g9fb1faf
In-Reply-To: <y>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199877>

From: nguyenkimthuat <Kim-Thuat.Nguyen@ensimag.imag.fr>

This patch adds the functionality to export the 
file attachements from the local git's repository 
using the API of mediawiki.

Signed-off-by: VOLEK Pavel <Pavel.Volek@ensimag.imag.fr>
Signed-off-by: NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>
Signed-off-by: ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/mw-to-git/git-remote-mediawiki | 67 +++++++++++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 2 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
index c18bfa1..e6f8940 100755
--- a/contrib/mw-to-git/git-remote-mediawiki
+++ b/contrib/mw-to-git/git-remote-mediawiki
@@ -275,6 +275,14 @@ sub run_git {
 	return $res;
 }
 
+sub run_git_raw {
+	no encoding 'utf8';
+	open(my $g, "-|", "git " . $_[0]);
+	my $r = do { local $/; <$g> };
+	close($g);
+
+	return $r;
+}
 
 sub get_last_local_revision {
 	# Get note regarding last mediawiki revision
@@ -644,7 +652,11 @@ sub mw_push_file {
 	my $page_deleted = ($new_sha1 eq NULL_SHA1);
 	$complete_file_name = mediawiki_clean_filename($complete_file_name);
 
-	if (substr($complete_file_name,-3) eq ".mw") {
+	my $path = "File:".$complete_file_name;
+	my @extensions = split(/\./, $complete_file_name);
+	my $extension = pop(@extensions);
+
+	if ($extension eq "mw") {
 		my $title = substr($complete_file_name,0,-3);
 
 		my $file_content;
@@ -687,7 +699,43 @@ sub mw_push_file {
 		$newrevid = $result->{edit}->{newrevid};
 		print STDERR "Pushed file: $new_sha1 - $title\n";
 	} else {
-		print STDERR "$complete_file_name not a mediawiki file (Not pushable on this version of git-remote-mediawiki).\n"
+		my %hashFiles = get_file_extensions();
+		if (exists($hashFiles{$extension})) {
+			# Deleting and uploading a file require the priviledge of the user
+			if ($page_deleted) {
+				mw_connect_maybe();
+				my $res = $mediawiki->edit( {
+					action => 'delete',
+					title => $path,
+					reason => $summary
+					} )|| die $mediawiki-> {error}->{code} .
+						':' . $mediawiki->{error}->{details};
+			} else {
+				my $content = run_git_raw("cat-file blob $new_sha1");
+				if ($content ne "") {
+					mw_connect_maybe();
+					$mediawiki->{config}->{upload_url} = "$url/index.php/Special:Upload";
+
+					my $res = $mediawiki->edit ( {
+						action => 'upload',
+						filename => $complete_file_name,
+						comment => $summary,
+						file => [undef, $complete_file_name, Content => $content ],
+						ignorewarnings => 1,
+						}, {
+							skip_encoding => 1 # Helps with names with accentuated characters
+						} )  || die $mediawiki-> {error}->{code} .
+							':' . $mediawiki->{error}->{details};
+					my $last_file_page = $mediawiki->get_page({title =>$path});
+					$newrevid = $last_file_page->{revid};
+					print STDERR "Pushed file: $new_sha1 - $complete_file_name.\n";
+				} else {
+					print STDERR "Empty file. Can not upload.\n ";
+				}
+			}
+		} else {
+			print STDERR "$complete_file_name is not a permitted file. Check the configuration of file uploads in your mediawiki.\n";
+		}
 	}
 	return ($newrevid, "ok");
 }
@@ -825,3 +873,18 @@ sub mw_push_revision {
 	print STDOUT "ok $remote\n";
 	return 1;
 }
+
+sub get_file_extensions {
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
1.7.11.rc2.10.g9fb1faf
