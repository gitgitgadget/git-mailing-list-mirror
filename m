From: Martin Waitz <tali@admingilde.org>
Subject: [PATCH] gitweb: support for "fp" parameter.
Date: Thu, 17 Aug 2006 00:28:38 +0200
Message-ID: <1155767325181-git-send-email-tali@admingilde.org>
References: <11557673213372-git-send-email-tali@admingilde.org> <11557673212235-git-send-email-tali@admingilde.org>
Cc: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Thu Aug 17 00:29:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDTss-0000AM-M5
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 00:29:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbWHPW2w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Aug 2006 18:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbWHPW2w
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Aug 2006 18:28:52 -0400
Received: from agent.admingilde.org ([213.95.21.5]:13768 "EHLO
	mail.admingilde.org") by vger.kernel.org with ESMTP id S932295AbWHPW2u
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Aug 2006 18:28:50 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1GDTsT-0007OU-D2; Thu, 17 Aug 2006 00:28:46 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.2.rc2.gf055
In-Reply-To: <11557673212235-git-send-email-tali@admingilde.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25537>

The "fp" (file name parent) parameter was previously generated for
blob diffs of renamed files.  However, it was not used in any code.

Now href() can generate "fp" parameters and they are used by the
blobdiff code to show the correct file name.

Signed-off-by: Martin Waitz <tali@admingilde.org>
---
 gitweb/gitweb.perl |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index ed6bd0e..a022569 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -124,6 +124,13 @@ if (defined $file_name) {
 	}
 }
 
+our $file_parent = $cgi->param('fp');
+if (defined $file_parent) {
+	if (!validate_input($file_parent)) {
+		die_error(undef, "Invalid file parent parameter");
+	}
+}
+
 our $hash = $cgi->param('h');
 if (defined $hash) {
 	if (!validate_input($hash)) {
@@ -197,6 +204,7 @@ sub href(%) {
 		action => "a",
 		project => "p",
 		file_name => "f",
+		file_parent => "fp",
 		hash => "h",
 		hash_parent => "hp",
 		hash_base => "hb",
@@ -1282,8 +1290,7 @@ sub git_difftree_body {
 			      $cgi->a({-href => href(action=>"blob", hash=>$to_id, hash_base=>$hash, file_name=>$to_file)}, "blob");
 			if ($to_id ne $from_id) {
 				print " | " .
-				      $cgi->a({-href => "$my_uri?" .
-				              esc_param("p=$project;a=blobdiff;h=$to_id;hp=$from_id;hb=$hash;f=$to_file;fp=$from_file")}, "diff");
+				      $cgi->a({-href => href(action=>"blobdiff", hash=>$to_id, hash_parent=>$from_id, hash_base=>$hash, file_name=>$to_file, file_parent=>$from_file)}, "diff");
 			}
 			print "</td>\n";
 
@@ -1304,8 +1311,7 @@ sub git_difftree_body {
 			      $cgi->a({-href => href(action=>"blob", hash=>$to_id, hash_base=>$hash, file_name=>$to_file)}, "blob");
 			if ($to_id ne $from_id) {
 				print " | " .
-				      $cgi->a({-href => "$my_uri?" .
-				              esc_param("p=$project;a=blobdiff;h=$to_id;hp=$from_id;hb=$hash;f=$to_file;fp=$from_file")}, "diff");
+				      $cgi->a({-href => href(action=>"blobdiff", hash=>$to_id, hash_parent=>$from_id, hash_base=>$hash, file_name=>$to_file, file_parent=>$from_file)}, "diff");
 			}
 			print "</td>\n";
 		} # we should not encounter Unmerged (U) or Unknown (X) status
@@ -2290,7 +2296,7 @@ sub git_blobdiff {
 	git_print_page_path($file_name, "blob");
 	print "<div class=\"page_body\">\n" .
 	      "<div class=\"diff_info\">blob:" .
-	      $cgi->a({-href => href(action=>"blob", hash=>$hash_parent, hash_base=>$hash_base, file_name=>$file_name)}, $hash_parent) .
+	      $cgi->a({-href => href(action=>"blob", hash=>$hash_parent, hash_base=>$hash_base, file_name=>($file_parent || $file_name))}, $hash_parent) .
 	      " -> blob:" .
 	      $cgi->a({-href => href(action=>"blob", hash=>$hash, hash_base=>$hash_base, file_name=>$file_name)}, $hash) .
 	      "</div>\n";
-- 
1.4.2.rc2.gf055
