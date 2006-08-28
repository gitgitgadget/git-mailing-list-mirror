From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 5/5] gitweb: Add diff tree, with links to patches, to commitdiff view
Date: Mon, 28 Aug 2006 14:48:14 +0200
Message-ID: <11567692951193-git-send-email-jnareb@gmail.com>
References: <11567692943154-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 28 14:48:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHgXT-0005XD-RY
	for gcvg-git@gmane.org; Mon, 28 Aug 2006 14:48:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbWH1MsY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Aug 2006 08:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWH1MsY
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Aug 2006 08:48:24 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:8626 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S1750729AbWH1MsV (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Aug 2006 08:48:21 -0400
Received: from front.fuw.edu.pl (front.fuw.edu.pl [193.0.83.59])
	by mail.fuw.edu.pl (8.13.6/8.13.6) with ESMTP id k7SCl3fb031919
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 28 Aug 2006 14:47:04 +0200
Received: from front.fuw.edu.pl (IDENT:10582@localhost [127.0.0.1])
	by front.fuw.edu.pl (8.13.3/8.12.4) with ESMTP id k7SCmFsk017632;
	Mon, 28 Aug 2006 14:48:15 +0200
Received: (from jnareb@localhost)
	by front.fuw.edu.pl (8.13.3/8.12.4/Submit) id k7SCmFEE017631;
	Mon, 28 Aug 2006 14:48:15 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.0
In-Reply-To: <11567692943154-git-send-email-jnareb@gmail.com>
X-Scanned-By: MIMEDefang 2.56 on 193.0.80.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26148>

Added/uncommented git_difftree_body invocation in git_commitdiff.
Added anchors (via 'id' attribute) to patches in patchset.
git_difftree_body is modified to link to patch anchor when called from
git_commitdiff, instead of link to blobdiff.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   71 ++++++++++++++++++++++++++++++++++++----------------
 1 files changed, 49 insertions(+), 22 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 8987967..ef09cf5 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1447,6 +1447,7 @@ sub git_difftree_body {
 
 	print "<table class=\"diff_tree\">\n";
 	my $alternate = 0;
+	my $patchno = 0;
 	foreach my $line (@{$difftree}) {
 		my %diff = parse_difftree_raw_line($line);
 
@@ -1487,8 +1488,14 @@ sub git_difftree_body {
 			      "<td class=\"link\">" .
 			      $cgi->a({-href => href(action=>"blob", hash=>$diff{'to_id'},
 			                             hash_base=>$hash, file_name=>$diff{'file'})},
-			              "blob") .
-			      "</td>\n";
+			              "blob");
+			if ($action == "commitdiff") {
+				# link to patch
+				$patchno++;
+				print " | " .
+				      $cgi->a({-href => "#patch$patchno"}, "patch");
+			}
+			print "</td>\n";
 
 		} elsif ($diff{'status'} eq "D") { # deleted
 			my $mode_chng = "<span class=\"file_status deleted\">[deleted $from_file_type]</span>";
@@ -1502,8 +1509,14 @@ sub git_difftree_body {
 			      $cgi->a({-href => href(action=>"blob", hash=>$diff{'from_id'},
 			                             hash_base=>$parent, file_name=>$diff{'file'})},
 			              "blob") .
-			      " | " .
-			      $cgi->a({-href => href(action=>"history", hash_base=>$parent,
+			      " | ";
+			if ($action == "commitdiff") {
+				# link to patch
+				$patchno++;
+				print " | " .
+				      $cgi->a({-href => "#patch$patchno"}, "patch");
+			}
+			print $cgi->a({-href => href(action=>"history", hash_base=>$parent,
 			                             file_name=>$diff{'file'})},
 			              "history") .
 			      "</td>\n";
@@ -1539,16 +1552,23 @@ sub git_difftree_body {
 			print "</td>\n" .
 			      "<td>$mode_chnge</td>\n" .
 			      "<td class=\"link\">" .
-				$cgi->a({-href => href(action=>"blob", hash=>$diff{'to_id'},
-				                       hash_base=>$hash, file_name=>$diff{'file'})},
-				        "blob");
+			      $cgi->a({-href => href(action=>"blob", hash=>$diff{'to_id'},
+			                             hash_base=>$hash, file_name=>$diff{'file'})},
+			              "blob");
 			if ($diff{'to_id'} ne $diff{'from_id'}) { # modified
-				print " | " .
-					$cgi->a({-href => href(action=>"blobdiff",
-					                       hash=>$diff{'to_id'}, hash_parent=>$diff{'from_id'},
-					                       hash_base=>$hash, hash_parent_base=>$parent,
-					                       file_name=>$diff{'file'})},
-					        "diff");
+				if ($action == "commitdiff") {
+					# link to patch
+					$patchno++;
+					print " | " .
+						$cgi->a({-href => "#patch$patchno"}, "patch");
+				} else {
+					print " | " .
+						$cgi->a({-href => href(action=>"blobdiff",
+						                       hash=>$diff{'to_id'}, hash_parent=>$diff{'from_id'},
+						                       hash_base=>$hash, hash_parent_base=>$parent,
+						                       file_name=>$diff{'file'})},
+						        "diff");
+				}
 			}
 			print " | " .
 				$cgi->a({-href => href(action=>"history",
@@ -1578,12 +1598,19 @@ sub git_difftree_body {
 			                             hash=>$diff{'to_id'}, file_name=>$diff{'to_file'})},
 			              "blob");
 			if ($diff{'to_id'} ne $diff{'from_id'}) {
-				print " | " .
-					$cgi->a({-href => href(action=>"blobdiff",
-					                       hash=>$diff{'to_id'}, hash_parent=>$diff{'from_id'},
-					                       hash_base=>$hash, hash_parent_base=>$parent,
-					                       file_name=>$diff{'to_file'}, file_parent=>$diff{'from_file'})},
-					        "diff");
+				if ($action == "commitdiff") {
+					# link to patch
+					$patchno++;
+					print " | " .
+						$cgi->a({-href => "#patch$patchno"}, "patch");
+				} else {
+					print " | " .
+						$cgi->a({-href => href(action=>"blobdiff",
+						                       hash=>$diff{'to_id'}, hash_parent=>$diff{'from_id'},
+						                       hash_base=>$hash, hash_parent_base=>$parent,
+						                       file_name=>$diff{'to_file'}, file_parent=>$diff{'from_file'})},
+						        "diff");
+				}
 			}
 			print "</td>\n";
 
@@ -1616,7 +1643,7 @@ sub git_patchset_body {
 				# first patch in patchset
 				$patch_found = 1;
 			}
-			print "<div class=\"patch\">\n";
+			print "<div class=\"patch\" id=\"patch". ($patch_idx+1) ."\">\n";
 
 			if (ref($difftree->[$patch_idx]) eq "HASH") {
 				$diffinfo = $difftree->[$patch_idx];
@@ -2958,8 +2985,8 @@ TEXT
 
 	# write patch
 	if ($format eq 'html') {
-		#git_difftree_body(\@difftree, $hash, $hash_parent);
-		#print "<br/>\n";
+		git_difftree_body(\@difftree, $hash, $hash_parent);
+		print "<br/>\n";
 
 		git_patchset_body($fd, \@difftree, $hash, $hash_parent);
 		close $fd;
-- 
1.4.1.1
