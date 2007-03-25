From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH] gitweb: support filename prefix in git_difftree_body
Date: Sun, 25 Mar 2007 22:34:21 +0200
Message-ID: <11748548621755-git-send-email-mkoegler@auto.tuwien.ac.at>
References: <11748548622888-git-send-email-mkoegler@auto.tuwien.ac.at> <11748548621186-git-send-email-mkoegler@auto.tuwien.ac.at> <11748548623841-git-send-email-mkoegler@auto.tuwien.ac.at> <11748548622060-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 25 22:34:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVZQM-0003O4-2j
	for gcvg-git@gmane.org; Sun, 25 Mar 2007 22:34:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752585AbXCYUea (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Mar 2007 16:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752578AbXCYUe3
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Mar 2007 16:34:29 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:60118 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752536AbXCYUeY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2007 16:34:24 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 19CF4735D748;
	Sun, 25 Mar 2007 22:34:23 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f-xcyamDZs6k; Sun, 25 Mar 2007 22:34:22 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 73A6C735D747; Sun, 25 Mar 2007 22:34:22 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.5
In-Reply-To: <11748548622060-git-send-email-mkoegler@auto.tuwien.ac.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43067>

git_treediff supports comparing subdirectories. As the output of
git-difftree is missing the path to the compared directories,
the links in the output would be wrong.

The patch adds two new parameters to add the missing path prefix.

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 gitweb/gitweb.perl |   40 ++++++++++++++++++++++------------------
 1 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 4195b1a..95723c7 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2182,8 +2182,12 @@ sub git_print_tree_entry {
 ## functions printing large fragments of HTML
 
 sub git_difftree_body {
-	my ($difftree, $hash, $parent) = @_;
+	my ($difftree, $hash, $parent, $file_name, $file_parent) = @_;
 	my ($have_blame) = gitweb_check_feature('blame');
+
+	$file_name = (!defined $file_name)?"":($file_name."/");
+	$file_parent = (!defined $file_parent)?"":($file_parent."/");
+
 	print "<div class=\"list_head\">\n";
 	if ($#{$difftree} > 10) {
 		print(($#{$difftree} + 1) . " files changed:\n");
@@ -2226,7 +2230,7 @@ sub git_difftree_body {
 			$mode_chng   .= "]</span>";
 			print "<td>";
 			print $cgi->a({-href => href(action=>"blob", hash=>$diff{'to_id'},
-			                             hash_base=>$hash, file_name=>$diff{'file'}),
+			                             hash_base=>$hash, file_name=>$file_name.$diff{'file'}),
 			              -class => "list"}, esc_path($diff{'file'}));
 			print "</td>\n";
 			print "<td>$mode_chng</td>\n";
@@ -2238,7 +2242,7 @@ sub git_difftree_body {
 				print " | ";
 			}
 			print $cgi->a({-href => href(action=>"blob", hash=>$diff{'to_id'},
-			                             hash_base=>$hash, file_name=>$diff{'file'})},
+			                             hash_base=>$hash, file_name=>$file_name.$diff{'file'})},
 			              "blob");
 			print "</td>\n";
 
@@ -2246,7 +2250,7 @@ sub git_difftree_body {
 			my $mode_chng = "<span class=\"file_status deleted\">[deleted $from_file_type]</span>";
 			print "<td>";
 			print $cgi->a({-href => href(action=>"blob", hash=>$diff{'from_id'},
-			                             hash_base=>$parent, file_name=>$diff{'file'}),
+			                             hash_base=>$parent, file_name=>$file_parent.$diff{'file'}),
 			               -class => "list"}, esc_path($diff{'file'}));
 			print "</td>\n";
 			print "<td>$mode_chng</td>\n";
@@ -2258,15 +2262,15 @@ sub git_difftree_body {
 				print " | ";
 			}
 			print $cgi->a({-href => href(action=>"blob", hash=>$diff{'from_id'},
-			                             hash_base=>$parent, file_name=>$diff{'file'})},
+			                             hash_base=>$parent, file_name=>$file_parent.$diff{'file'})},
 			              "blob") . " | ";
 			if ($have_blame) {
 				print $cgi->a({-href => href(action=>"blame", hash_base=>$parent,
-				                             file_name=>$diff{'file'})},
+				                             file_name=>$file_parent.$diff{'file'})},
 				              "blame") . " | ";
 			}
 			print $cgi->a({-href => href(action=>"history", hash_base=>$parent,
-			                             file_name=>$diff{'file'})},
+			                             file_name=>$file_parent.$diff{'file'})},
 			              "history");
 			print "</td>\n";
 
@@ -2288,7 +2292,7 @@ sub git_difftree_body {
 			}
 			print "<td>";
 			print $cgi->a({-href => href(action=>"blob", hash=>$diff{'to_id'},
-			                             hash_base=>$hash, file_name=>$diff{'file'}),
+			                             hash_base=>$hash, file_name=>$file_name.$diff{'file'}),
 			              -class => "list"}, esc_path($diff{'file'}));
 			print "</td>\n";
 			print "<td>$mode_chnge</td>\n";
@@ -2303,20 +2307,20 @@ sub git_difftree_body {
 				print $cgi->a({-href => href(action=>"blobdiff",
 				                             hash=>$diff{'to_id'}, hash_parent=>$diff{'from_id'},
 				                             hash_base=>$hash, hash_parent_base=>$parent,
-				                             file_name=>$diff{'file'})},
+				                             file_name=>$file_name.$diff{'file'})},
 				              "diff") .
 				      " | ";
 			}
 			print $cgi->a({-href => href(action=>"blob", hash=>$diff{'to_id'},
-			                             hash_base=>$hash, file_name=>$diff{'file'})},
+			                             hash_base=>$hash, file_name=>$file_name.$diff{'file'})},
 			               "blob") . " | ";
 			if ($have_blame) {
 				print $cgi->a({-href => href(action=>"blame", hash_base=>$hash,
-				                             file_name=>$diff{'file'})},
+				                             file_name=>$file_name.$diff{'file'})},
 				              "blame") . " | ";
 			}
 			print $cgi->a({-href => href(action=>"history", hash_base=>$hash,
-			                             file_name=>$diff{'file'})},
+			                             file_name=>$file_name.$diff{'file'})},
 			              "history");
 			print "</td>\n";
 
@@ -2330,11 +2334,11 @@ sub git_difftree_body {
 			}
 			print "<td>" .
 			      $cgi->a({-href => href(action=>"blob", hash_base=>$hash,
-			                             hash=>$diff{'to_id'}, file_name=>$diff{'to_file'}),
+			                             hash=>$diff{'to_id'}, file_name=>$file_name.$diff{'to_file'}),
 			              -class => "list"}, esc_path($diff{'to_file'})) . "</td>\n" .
 			      "<td><span class=\"file_status $nstatus\">[$nstatus from " .
 			      $cgi->a({-href => href(action=>"blob", hash_base=>$parent,
-			                             hash=>$diff{'from_id'}, file_name=>$diff{'from_file'}),
+			                             hash=>$diff{'from_id'}, file_name=>$file_parent.$diff{'from_file'}),
 			              -class => "list"}, esc_path($diff{'from_file'})) .
 			      " with " . (int $diff{'similarity'}) . "% similarity$mode_chng]</span></td>\n" .
 			      "<td class=\"link\">";
@@ -2348,20 +2352,20 @@ sub git_difftree_body {
 				print $cgi->a({-href => href(action=>"blobdiff",
 				                             hash=>$diff{'to_id'}, hash_parent=>$diff{'from_id'},
 				                             hash_base=>$hash, hash_parent_base=>$parent,
-				                             file_name=>$diff{'to_file'}, file_parent=>$diff{'from_file'})},
+				                             file_name=>$file_name.$diff{'to_file'}, file_parent=>$file_parent.$diff{'from_file'})},
 				              "diff") .
 				      " | ";
 			}
 			print $cgi->a({-href => href(action=>"blob", hash=>$diff{'to_id'},
-			                             hash_base=>$parent, file_name=>$diff{'to_file'})},
+			                             hash_base=>$parent, file_name=>$file_name.$diff{'to_file'})},
 			              "blob") . " | ";
 			if ($have_blame) {
 				print $cgi->a({-href => href(action=>"blame", hash_base=>$hash,
-				                             file_name=>$diff{'to_file'})},
+				                             file_name=>$file_name.$diff{'to_file'})},
 				              "blame") . " | ";
 			}
 			print $cgi->a({-href => href(action=>"history", hash_base=>$hash,
-			                            file_name=>$diff{'to_file'})},
+			                            file_name=>$file_name.$diff{'to_file'})},
 			              "history");
 			print "</td>\n";
 
-- 
1.5.1.rc1.51.gb08b-dirty
