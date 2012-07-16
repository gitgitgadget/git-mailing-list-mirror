From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 3/8] git-remote-mediawiki: make mediafiles export optional
Date: Mon, 16 Jul 2012 21:46:37 +0200
Message-ID: <1342468002-31818-4-git-send-email-Matthieu.Moy@imag.fr>
References: <1342440053-3058-1-git-send-email-Matthieu.Moy@imag.fr>
 <1342468002-31818-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Asheesh Laroia <asheesh@asheesh.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jul 16 21:48:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqrHW-0000yu-Nf
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 21:48:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753706Ab2GPTsa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 15:48:30 -0400
Received: from mx1.imag.fr ([129.88.30.5]:43810 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753715Ab2GPTs2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2012 15:48:28 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q6GJjeOY012461
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 16 Jul 2012 21:45:40 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SqrGG-0001SB-8i; Mon, 16 Jul 2012 21:47:16 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SqrGG-0008IQ-7D; Mon, 16 Jul 2012 21:47:16 +0200
X-Mailer: git-send-email 1.7.11.2.258.g5ff3cdf.dirty
In-Reply-To: <1342468002-31818-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 16 Jul 2012 21:45:40 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q6GJjeOY012461
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1343072743.88361@qN1v2v85xPpRynbWvChDhw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201563>

It is possible to use git-remote-mediawiki on a tree with both .mw files
and other files. Before git-remote-mediawiki learnt how to export
mediafiles, such mixed trees allowed the user to maintain both the wiki
and other files for the same project in the same repository. With the
newly added support for exporting mediafiles, pushing such mixed trees
would upload unrelated files as mediafiles, which may not be desired.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/mw-to-git/git-remote-mediawiki | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
index a2da52f..8e46e4e 100755
--- a/contrib/mw-to-git/git-remote-mediawiki
+++ b/contrib/mw-to-git/git-remote-mediawiki
@@ -66,11 +66,16 @@ chomp(@tracked_pages);
 my @tracked_categories = split(/[ \n]/, run_git("config --get-all remote.". $remotename .".categories"));
 chomp(@tracked_categories);
 
-# Import media files too.
+# Import media files on pull
 my $import_media = run_git("config --get --bool remote.". $remotename .".mediaimport");
 chomp($import_media);
 $import_media = ($import_media eq "true");
 
+# Export media files on push
+my $export_media = run_git("config --get --bool remote.". $remotename .".mediaexport");
+chomp($export_media);
+$export_media = !($export_media eq "false");
+
 my $wiki_login = run_git("config --get remote.". $remotename .".mwLogin");
 # Note: mwPassword is discourraged. Use the credential system instead.
 my $wiki_passwd = run_git("config --get remote.". $remotename .".mwPassword");
@@ -1068,6 +1073,11 @@ sub mw_push_file {
 		$extension = "";
 	}
 	if ($extension eq "mw") {
+		my $ns = get_mw_namespace_id_for_page($complete_file_name);
+		if ($ns && $ns == get_mw_namespace_id("File") && (!$export_media)) {
+			print STDERR "Ignoring media file related page: $complete_file_name\n";
+			return ($oldrevid, "ok");
+		}
 		my $file_content;
 		if ($page_deleted) {
 			# Deleting a page usually requires
@@ -1107,10 +1117,12 @@ sub mw_push_file {
 		}
 		$newrevid = $result->{edit}->{newrevid};
 		print STDERR "Pushed file: $new_sha1 - $title\n";
-	} else {
+	} elsif ($export_media) {
 		$newrevid = mw_upload_file($complete_file_name, $new_sha1,
 					   $extension, $page_deleted,
 					   $summary);
+	} else {
+		print STDERR "Ignoring media file $title\n";
 	}
 	$newrevid = ($newrevid or $oldrevid);
 	return ($newrevid, "ok");
@@ -1328,3 +1340,11 @@ sub get_mw_namespace_id {
 		die "No such namespace $name on MediaWiki.";
 	}
 }
+
+sub get_mw_namespace_id_for_page {
+	if (my ($namespace) = $_[0] =~ /^([^:]*):/) {
+		return get_mw_namespace_id($namespace);
+	} else {
+		return;
+	}
+}
-- 
1.7.11.2.258.g5ff3cdf.dirty
