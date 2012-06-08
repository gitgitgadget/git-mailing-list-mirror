From: Kim Thuat NGUYEN <kim-thuat.nguyen@ensimag.imag.fr>
Subject: [PATCHv1] Export file in git-remote-mediawiki
Date: Fri,  8 Jun 2012 15:27:04 +0200
Message-ID: <1339162024-3120-1-git-send-email-nguyenkimthuat@gmail.com>
References: <y>
Cc: nguyenkimthuat <nguyenkimthuat@gmail.com>,
	VOLEK Pavel <Pavel.Volek@ensimag.imag.fr>,
	NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>,
	ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 08 15:27:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SczDm-0006Uy-Lw
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jun 2012 15:27:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754292Ab2FHN1R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jun 2012 09:27:17 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:36939 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090Ab2FHN1Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2012 09:27:16 -0400
Received: by weyu7 with SMTP id u7so601469wey.19
        for <git@vger.kernel.org>; Fri, 08 Jun 2012 06:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=+L+yAyDRg0ZL6w+QS/fauJy+xonRl0WdDwwCudQI2m8=;
        b=VzgZv2M1zD8t379qd+/a95+0sMkILRBM2kR+jMZy11YqqWChwXSRWASvxjUWcdg0z5
         2APg9rL2JpiPG3sx6xYWNpfGwfVFCoKRQmxDqD+9y8nxDN0NG6CxUciM1E2B9Hw7RFd3
         wDNXItJTOweSH0jS3DAyKiaasYCX9KX1QNd7sXEEl2gDX5vuTbmtoxhfKTFlxUrF+5jn
         TYwTRFGDtVCALBZDJ8e88OEcuMCs8gZK9K3tt1nTClnQHAnAK6bNwIx+TR4z4fDli/Sa
         uzb1QbqpqUsaBunSShooTA7ftEmG+orQGG/Ciksz9IXfPSxWvnmNE43HGONJNdqPpgXj
         6X5Q==
Received: by 10.180.93.99 with SMTP id ct3mr363454wib.13.1339162034508;
        Fri, 08 Jun 2012 06:27:14 -0700 (PDT)
Received: from nguyenkimthuat-K40IN.grenet.fr (wifi-029122.grenet.fr. [130.190.29.122])
        by mx.google.com with ESMTPS id fo7sm1232143wib.9.2012.06.08.06.27.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 08 Jun 2012 06:27:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.552.gaa3bb87
In-Reply-To: <y>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199488>

From: nguyenkimthuat <nguyenkimthuat@gmail.com>

This patch adds the functionnality to export the file attachements from the local git's repository using the API of mediawiki. It also provides the possibility for
an user to delete a page in the local repository Git which means the page  will be deleted in the wiki site after user do the 'push'.

Signed-off-by: VOLEK Pavel <Pavel.Volek@ensimag.imag.fr>
Signed-off-by: NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>
Signed-off-by: ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/mw-to-git/git-remote-mediawiki | 126 +++++++++++++++++++++++++--------
 1 file changed, 98 insertions(+), 28 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
index c18bfa1..2fd0e5b 100755
--- a/contrib/mw-to-git/git-remote-mediawiki
+++ b/contrib/mw-to-git/git-remote-mediawiki
@@ -275,6 +275,14 @@ sub run_git {
 	return $res;
 }
 
+sub run_git_raw {
+	no encoding 'utf8';
+	open(my $g,"-|","git " . $_[0]); 
+	my $r = do { local $/; <$g> };
+	close($g);
+
+	return $r;
+}
 
 sub get_last_local_revision {
 	# Get note regarding last mediawiki revision
@@ -644,6 +652,11 @@ sub mw_push_file {
 	my $page_deleted = ($new_sha1 eq NULL_SHA1);
 	$complete_file_name = mediawiki_clean_filename($complete_file_name);
 
+	my %hashFiles = get_file_extensions_maybe($complete_file_name);
+	my $path = "File:".$complete_file_name;
+	my @extensions = split(/\./, $complete_file_name);
+	my $extension = pop(@extensions);
+
 	if (substr($complete_file_name,-3) eq ".mw") {
 		my $title = substr($complete_file_name,0,-3);
 
@@ -653,39 +666,74 @@ sub mw_push_file {
 			# special priviledges. A common
 			# convention is to replace the page
 			# with this content instead:
-			$file_content = DELETED_CONTENT;
+			mw_connect_maybe();
+			my $re = $mediawiki->edit( {
+				action => 'delete',
+				title => $title,
+				reason => $summary 
+				} )|| die $mediawiki-> {error}->{code} . ':' . $mediawiki->{error}->{details};
 		} else {
 			$file_content = run_git("cat-file blob $new_sha1");
-		}
-
-		mw_connect_maybe();
 
-		my $result = $mediawiki->edit( {
-			action => 'edit',
-			summary => $summary,
-			title => $title,
-			basetimestamp => $basetimestamps{$newrevid},
-			text => mediawiki_clean($file_content, $page_created),
-				  }, {
-					  skip_encoding => 1 # Helps with names with accentuated characters
-				  });
-		if (!$result) {
-			if ($mediawiki->{error}->{code} == 3) {
-				# edit conflicts, considered as non-fast-forward
-				print STDERR 'Warning: Error ' .
-				    $mediawiki->{error}->{code} .
-				    ' from mediwiki: ' . $mediawiki->{error}->{details} .
-				    ".\n";
-				return ($newrevid, "non-fast-forward");
-			} else {
-				# Other errors. Shouldn't happen => just die()
-				die 'Fatal: Error ' .
-				    $mediawiki->{error}->{code} .
-				    ' from mediwiki: ' . $mediawiki->{error}->{details};
+			mw_connect_maybe();
+	
+			my $result = $mediawiki->edit( {
+				action => 'edit',
+				summary => $summary,
+				title => $title,
+				basetimestamp => $basetimestamps{$newrevid},
+				text => mediawiki_clean($file_content, $page_created),
+					  }, {
+						  skip_encoding => 1 # Helps with names with accentuated characters
+					  });
+			if (!$result) {
+				if ($mediawiki->{error}->{code} == 3) {
+					# edit conflicts, considered as non-fast-forward
+					print STDERR 'Warning: Error ' .
+					    $mediawiki->{error}->{code} .
+				   	 ' from mediwiki: ' . $mediawiki->{error}->{details} .".\n";
+					return ($newrevid, "non-fast-forward");
+				} else {
+					# Other errors. Shouldn't happen => just die()
+					die 'Fatal: Error ' .
+					    $mediawiki->{error}->{code} . ' from mediwiki: ' . $mediawiki->{error}->{details};
+				}
 			}
+			$newrevid = $result->{edit}->{newrevid};
+			print STDERR "Pushed file: $new_sha1 - $title\n";
+		}
+	elsif (exists($hashFiles{$extension}))      
+	{		
+		# Deleting and uploading a file require the priviledge of the user
+		if ($page_deleted) {       
+			mw_connect_maybe();
+			my $res = $mediawiki->edit( {
+				action => 'delete',
+				title => $path,
+				reason => $summary
+				} )|| die $mediawiki-> {error}->{code} . ':' . $mediawiki->{error}->{details};	
+		} else {
+			my $content = run_git_raw("cat-file blob $new_sha1");	
+			if ($content ne "") { 
+				mw_connect_maybe();	
+				$mediawiki->{config}->{upload_url} = "$url/index.php/Special:Upload";
+			
+				my $res = $mediawiki->edit ( {
+					action => 'upload',
+					filename => $complete_file_name,
+					comment => $summary,
+					file => [undef, $complete_file_name, Content => $content ],
+					ignorewarnings=>1,
+					}, {
+						  skip_encoding => 1 # Helps with names with accentuated characters
+						} ) || die $mediawiki-> {error}->{code} . ':' . $mediawiki->{error}->{details};
+				my $last_file_page = $mediawiki->get_page({title =>$path});
+				$newrevid = $last_file_page->{revid};
+				print STDERR "Pushed file: $new_sha1 - $complete_file_name\n";
+			} else {
+				print STDERR "Empty file. Can not upload \n ";
+				}
 		}
-		$newrevid = $result->{edit}->{newrevid};
-		print STDERR "Pushed file: $new_sha1 - $title\n";
 	} else {
 		print STDERR "$complete_file_name not a mediawiki file (Not pushable on this version of git-remote-mediawiki).\n"
 	}
@@ -825,3 +873,25 @@ sub mw_push_revision {
 	print STDOUT "ok $remote\n";
 	return 1;
 }
+
+sub get_file_extensions_maybe {
+	my $file_name = shift;
+	my $est_mw_page = substr($file_name,-3) eq ".mw";
+	if(!$est_mw_page) {
+		mw_connect_maybe();
+
+        	my $query = {
+			action => 'query',
+			meta => 'siteinfo',
+			siprop => 'fileextensions'
+			};
+
+		my $result = $mediawiki->api($query);
+		my @file_extensions= map $_->{ext},@{$result->{query}->{fileextensions}};
+		my %hashFile = map {$_ => 1}@file_extensions;
+
+		return %hashFile;
+	} else {
+		return ;
+	}
+}
-- 
1.7.10.2.552.gaa3bb87
