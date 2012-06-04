From: NGUYEN Kim Thuat <kim-thuat.nguyen@ensimag.imag.fr>
Subject: [PATCH/RFC] Export file attachements in git-remote-mediawiki
Date: Mon,  4 Jun 2012 22:49:21 +0200
Message-ID: <1338842961-3477-1-git-send-email-nguyenkimthuat@gmail.com>
References: <y>
Cc: nguyenkimthuat <nguyenkimthuat@gmail.com>,
	Pavel Volek <Pavel.Volek@ensimag.imag.fr>,
	NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>,
	ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 04 22:49:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbeDc-0004yL-Ih
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 22:49:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754874Ab2FDUtg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jun 2012 16:49:36 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:41045 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754767Ab2FDUtf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2012 16:49:35 -0400
Received: by weyu7 with SMTP id u7so3123548wey.19
        for <git@vger.kernel.org>; Mon, 04 Jun 2012 13:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=ZSGWH09rMfjP7VwCwoRFabNnavDYyXL32VSCvqxt2RE=;
        b=ZH65MgXRkjd11TfxT0ydoI3E1loEUzjFK45zxtOP2JURPNhaTs4aQwDApKWBgEYimm
         e86aQAhvlkOQiEmss1vWy6+HnCxumxnYKPGMr6rP2tYR6IVWFUPd1VmSlc/y8qALklw4
         1TVWQRxt4DEh7ALal7Ilp+v7gN2GdjciBN9lvo8Lo1Xgcygv1l3b6MxlUTGOjrLiMytJ
         eoKMtUXjVITdfabf+XDasV6qYo97bMn0XSCFxVQ5p1okeoGZWqH69pFFQpYdC30LsXhc
         LFoSJ5z57L5nXM9A0z/CoPi4r5f/yZL5s8NH4T9VwNpquur2yBgWUd9phpD6EUxbjvc8
         h8Kw==
Received: by 10.216.208.87 with SMTP id p65mr11741754weo.162.1338842972197;
        Mon, 04 Jun 2012 13:49:32 -0700 (PDT)
Received: from localhost.localdomain (ip-10.net-80-236-63.issy.rev.numericable.fr. [80.236.63.10])
        by mx.google.com with ESMTPS id q6sm22759684wiy.0.2012.06.04.13.49.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 04 Jun 2012 13:49:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.552.gaa3bb87
In-Reply-To: <y>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199185>

From: nguyenkimthuat <nguyenkimthuat@gmail.com>

The current version of the git-remote-mediawiki supports only import and export of the pages, doesn't support import and export of file attachements which are also exposed by MediaWiki API. This patch add the functionnality to export the file attachements from the local git's repository using the API of mediawiki.
 For the moment, i removed the line: "use enconding 'utf8'" because it's broken, especially when reding a binary file for exemple .pdf or .jpg.

Signed-off-by: Pavel Volek <Pavel.Volek@ensimag.imag.fr>
Signed-off-by: NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>
Signed-off-by: ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/mw-to-git/git-remote-mediawiki | 90 ++++++++++++++++++++++++++++++++--
 1 file changed, 87 insertions(+), 3 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
index c18bfa1..830e2d0 100755
--- a/contrib/mw-to-git/git-remote-mediawiki
+++ b/contrib/mw-to-git/git-remote-mediawiki
@@ -36,7 +36,6 @@
 use strict;
 use MediaWiki::API;
 use DateTime::Format::ISO8601;
-use encoding 'utf8';
 
 # use encoding 'utf8' doesn't change STDERROR
 # but we're going to output UTF-8 filenames to STDERR
@@ -114,6 +113,9 @@ $wiki_name =~ s/[^\/]*:\/\///;
 # and '@' sign, to avoid author like MWUser@HTTPUser@host.com
 $wiki_name =~ s/^.*@//;
 
+# Get the list of file extensions supported by the current version of mediawiki 
+my @list_file_extensions = get_file_extensions();
+
 # Commands parser
 my $entry;
 my @cmd;
@@ -275,6 +277,13 @@ sub run_git {
 	return $res;
 }
 
+sub run_git_raw {
+        open(my $g,"-|","git " . $_[0]);   
+        my $r = do { local $/; <$g> };
+        close($g);
+
+        return $r;
+}
 
 sub get_last_local_revision {
 	# Get note regarding last mediawiki revision
@@ -642,8 +651,14 @@ sub mw_push_file {
 	my $old_sha1 = $diff_info_split[2];
 	my $page_created = ($old_sha1 eq NULL_SHA1);
 	my $page_deleted = ($new_sha1 eq NULL_SHA1);
+	my $file_deleted = ($new_sha1 eq NULL_SHA1);
 	$complete_file_name = mediawiki_clean_filename($complete_file_name);
 
+	my %hashFiles = map {$_ => 1}@list_file_extensions;
+	my $path = "File:".$complete_file_name;
+	my @extensions = split(/\./,$complete_file_name);
+	my $extension = pop(@extensions);
+
 	if (substr($complete_file_name,-3) eq ".mw") {
 		my $title = substr($complete_file_name,0,-3);
 
@@ -686,8 +701,34 @@ sub mw_push_file {
 		}
 		$newrevid = $result->{edit}->{newrevid};
 		print STDERR "Pushed file: $new_sha1 - $title\n";
-	} else {
-		print STDERR "$complete_file_name not a mediawiki file (Not pushable on this version of git-remote-mediawiki).\n"
+	} elsif (exists($hashFiles{$extension})) {
+		# Deleting and uploading a file require the priviledge of the user
+		if ($file_deleted) {
+			mw_connect_maybe();
+			my $res = $mediawiki->edit( {
+			action => 'delete',
+			title => $path,
+			reason => $summary } )
+			|| die $mediawiki-> {error}->{code} . ':' . $mediawiki->{error}->{details};
+
+		} else {
+			my $content = run_git_raw("cat-file blob $new_sha1");
+			mw_connect_maybe();
+				$mediawiki->{config}->{upload_url} = "$url/index.php/Special:Upload";
+
+				$mediawiki->upload( {
+				title => $complete_file_name,
+				summary => $summary,
+				data => $content,
+				ignorewarnings=>1
+                                  }, {
+					skip_encoding => 1 # Helps with names with accentuated characters
+			} ) || die $mediawiki-> {error}->{code} . ':' . $mediawiki->{error}->{details};
+			$newrevid = get_reviId_filepage();
+			print STDERR "Pushed file: $new_sha1 - $complete_file_name\n";
+			 }
+	else {
+		print STDERR "$complete_file_name is not supported on this version of Mediawiki.\n"
 	}
 	return ($newrevid, "ok");
 }
@@ -825,3 +866,46 @@ sub mw_push_revision {
 	print STDOUT "ok $remote\n";
 	return 1;
 }
+
+sub get_reviId_filepage() {
+	mw_connect_maybe();
+
+	my $max_rev_num_file = 0;
+
+	my @list_file_pages = get_mw_media_pages();
+
+	foreach my $file_page (@list_file_pages) {
+	my $id = $file_page->{pageid};
+        
+	my $query = {
+		action => 'query',
+		prop => 'revisions',
+		rvprop => 'ids',
+		pageids => $id,
+		};
+
+		my $result = $mediawiki->api($query);
+
+		my $lastrev = pop(@{$result->{query}->{pages}->{$id}->{revisions}});
+	}
+}
+
+sub get_file_extensions {
+	mw_connect_maybe();
+
+	my $query = {
+	action => 'query',
+	meta => 'siteinfo',
+	siprop => 'fileextensions'
+	};
+
+	my $result = $mediawiki->api($query);
+
+	my @file_extensions = map $_->{ext},@{$result->{query}->{fileextensions}};
+
+	return @file_extensions;
+}
+
+
+
+
-- 
1.7.10.2.552.gaa3bb87
