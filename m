From: Kim Thuat NGUYEN <kim-thuat.nguyen@ensimag.imag.fr>
Subject: [PATCHv2] git-remote-mediawiki: export File: attachments
Date: Tue, 12 Jun 2012 14:46:16 +0200
Message-ID: <1339505176-2962-1-git-send-email-nguyenkimthuat@gmail.com>
References: <y>
Cc: nguyenkimthuat <nguyenkimthuat@gmail.com>,
	VOLEK Pavel <Pavel.Volek@ensimag.imag.fr>,
	NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>,
	ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 12 14:46:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeQUU-0000D8-V0
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 14:46:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751766Ab2FLMq2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 08:46:28 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:40338 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751168Ab2FLMq1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 08:46:27 -0400
Received: by weyu7 with SMTP id u7so2812299wey.19
        for <git@vger.kernel.org>; Tue, 12 Jun 2012 05:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=Vsot9Il9o1MLBPebhM3dc3tPpBcHvCEXbcD7kmdV0jk=;
        b=dgBEIsx3Dw2aEFQR8MbDrwQdimnXojAIrGgSFeiJfKnU6tIxChxk5CDmMMltCq77CZ
         Eu7IquoYOhdMagaswzaU0aFq7XFt5BuBPNpIexxb+EWUA/c9UHG0okvzI1gqhccw6cuZ
         snD/W5PxXNkdqQ4e3LT12x0mxLOGytG/2HWtPoROu/BRxPFqXiJvhvdtFHmrvF9h8Zgd
         gTEHMXBNccziGlE8maUWnywTwex/c8WhkecNBeJwSYScxi/DlRpywYX+aEbGtNLT9Ix/
         517bLIbALVg3Xi+O80+iP49dS/SaxGs1VUma1yX6hkmdp3nPWIsc7i51YkbK27kEw3Pj
         nZEA==
Received: by 10.216.208.71 with SMTP id p49mr8711725weo.172.1339505185862;
        Tue, 12 Jun 2012 05:46:25 -0700 (PDT)
Received: from nguyenkimthuat-K40IN.grenet.fr (wifi-030059.grenet.fr. [130.190.30.59])
        by mx.google.com with ESMTPS id ei4sm8812644wid.5.2012.06.12.05.46.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 12 Jun 2012 05:46:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.GIT
In-Reply-To: <y>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199781>

From: nguyenkimthuat <nguyenkimthuat@gmail.com>

This patch adds the functionnality to export the 
file attachements from the local git's repository 
using the API of mediawiki.

Signed-off-by: VOLEK Pavel <Pavel.Volek@ensimag.imag.fr>
Signed-off-by: NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>
Signed-off-by: ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/mw-to-git/git-remote-mediawiki | 62 +++++++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
index c18bfa1..8f711e2 100755
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
@@ -644,6 +652,10 @@ sub mw_push_file {
 	my $page_deleted = ($new_sha1 eq NULL_SHA1);
 	$complete_file_name = mediawiki_clean_filename($complete_file_name);
 
+	my $path = "File:".$complete_file_name;
+	my @extensions = split(/\./, $complete_file_name);
+	my $extension = pop(@extensions);
+
 	if (substr($complete_file_name,-3) eq ".mw") {
 		my $title = substr($complete_file_name,0,-3);
 
@@ -687,7 +699,40 @@ sub mw_push_file {
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
+					} )|| die $mediawiki-> {error}->{code} . ':' . $mediawiki->{error}->{details};
+			} else {
+				my $content = run_git_raw("cat-file blob $new_sha1");
+				if ($content ne "") {
+					mw_connect_maybe();
+					$mediawiki->{config}->{upload_url} = "$url/index.php/Special:Upload";
+					my $res = $mediawiki->edit ( {
+						action => 'upload',
+						filename => $complete_file_name,
+						comment => $summary,
+						file => [undef, $complete_file_name, Content => $content ],
+						ignorewarnings=>1,
+						}, {
+								skip_encoding => 1 # Helps with names with accentuated characters
+							} )  || die $mediawiki-> {error}->{code} . ':' . $mediawiki->{error}->{details};
+					my $last_file_page = $mediawiki->get_page({title =>$path});
+					$newrevid = $last_file_page->{revid};
+					print STDERR "Pushed file: $new_sha1 - $complete_file_name\n";
+				} else {
+					print STDERR "Empty file. Can not upload \n ";
+				}
+			}
+		} else {
+			print STDERR "$complete_file_name not a mediawiki file (Not pushable on this version of git-remote-mediawiki).\n";
+		}
 	}
 	return ($newrevid, "ok");
 }
@@ -825,3 +870,18 @@ sub mw_push_revision {
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
1.7.10.GIT
