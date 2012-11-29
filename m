From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 2/2 v2] git-remote-mediawiki: escape ", \, and LF in file names
Date: Thu, 29 Nov 2012 18:00:55 +0100
Message-ID: <1354208455-21228-2-git-send-email-Matthieu.Moy@imag.fr>
References: <vpq624omjn4.fsf@grenoble-inp.fr>
 <1354208455-21228-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Nov 29 18:02:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Te7VC-00047z-MJ
	for gcvg-git-2@plane.gmane.org; Thu, 29 Nov 2012 18:02:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185Ab2K2RCA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 12:02:00 -0500
Received: from mx1.imag.fr ([129.88.30.5]:54548 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751069Ab2K2RCA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 12:02:00 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id qATGquCt001871
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 29 Nov 2012 17:52:56 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Te7UC-0008L6-1j; Thu, 29 Nov 2012 18:01:16 +0100
Received: from moy by anie with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Te7UB-0005X4-Un; Thu, 29 Nov 2012 18:01:15 +0100
X-Mailer: git-send-email 1.8.0.319.g8abfee4
In-Reply-To: <1354208455-21228-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 29 Nov 2012 17:52:56 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: qATGquCt001871
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1354812777.13315@pUSUMLh1r+HQTs2Mw1zjZg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210847>

A mediawiki page can contain, and even start with a " character, we have
to escape it when generating the fast-export stream, as well as \
character. While we're there, also escape newlines, but I don't think we
can get them from MediaWiki pages.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/mw-to-git/git-remote-mediawiki      | 16 +++++++++++++---
 contrib/mw-to-git/t/t9362-mw-to-git-utf8.sh | 26 ++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
index 68555d4..094129d 100755
--- a/contrib/mw-to-git/git-remote-mediawiki
+++ b/contrib/mw-to-git/git-remote-mediawiki
@@ -711,6 +711,14 @@ sub fetch_mw_revisions {
 	return ($n, @revisions);
 }
 
+sub fe_escape_path {
+    my $path = shift;
+    $path =~ s/\\/\\\\/g;
+    $path =~ s/"/\\"/g;
+    $path =~ s/\n/\\n/g;
+    return '"' . $path . '"';
+}
+
 sub import_file_revision {
 	my $commit = shift;
 	my %commit = %{$commit};
@@ -738,15 +746,17 @@ sub import_file_revision {
 		print STDOUT "from refs/mediawiki/$remotename/master^0\n";
 	}
 	if ($content ne DELETED_CONTENT) {
-		print STDOUT "M 644 inline $title.mw\n";
+		print STDOUT "M 644 inline " .
+		    fe_escape_path($title . ".mw") . "\n";
 		literal_data($content);
 		if (%mediafile) {
-			print STDOUT "M 644 inline $mediafile{title}\n";
+			print STDOUT "M 644 inline "
+			    . fe_escape_path($mediafile{title}) . "\n";
 			literal_data_raw($mediafile{content});
 		}
 		print STDOUT "\n\n";
 	} else {
-		print STDOUT "D $title.mw\n";
+		print STDOUT "D " . fe_escape_path($title . ".mw") . "\n";
 	}
 
 	# mediawiki revision number in the git note
diff --git a/contrib/mw-to-git/t/t9362-mw-to-git-utf8.sh b/contrib/mw-to-git/t/t9362-mw-to-git-utf8.sh
index 246d47d..b6405ce 100755
--- a/contrib/mw-to-git/t/t9362-mw-to-git-utf8.sh
+++ b/contrib/mw-to-git/t/t9362-mw-to-git-utf8.sh
@@ -318,4 +318,30 @@ test_expect_success 'git push with \ in format control' '
 '
 
 
+test_expect_success 'fast-import meta-characters in page name (mw -> git)' '
+	wiki_reset &&
+	wiki_editpage \"file\"_\\_foo "expect to be called \"file\"_\\_foo" false &&
+	git clone mediawiki::'"$WIKI_URL"' mw_dir_21 &&
+	test_path_is_file mw_dir_21/\"file\"_\\_foo.mw &&
+	wiki_getallpage ref_page_21 &&
+	test_diff_directories mw_dir_21 ref_page_21
+'
+
+
+test_expect_success 'fast-import meta-characters in page name (git -> mw) ' '
+	wiki_reset &&
+	git clone mediawiki::'"$WIKI_URL"' mw_dir_22 &&
+	(
+		cd mw_dir_22 &&
+		echo "this file is called \"file\"_\\_foo.mw" >\"file\"_\\_foo &&
+		git add . &&
+		git commit -am "file \"file\"_\\_foo" &&
+		git pull &&
+		git push
+	) &&
+	wiki_getallpage ref_page_22 &&
+	test_diff_directories mw_dir_22 ref_page_22
+'
+
+
 test_done
-- 
1.8.0.319.g8abfee4
