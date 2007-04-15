From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH 3/7] gitweb: support filename prefix in git_patchset_body/git_difftree_body
Date: Sun, 15 Apr 2007 22:46:06 +0200
Message-ID: <11766699713715-git-send-email-mkoegler@auto.tuwien.ac.at>
References: <11766699702663-git-send-email-mkoegler@auto.tuwien.ac.at> <11766699701308-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 15 22:46:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdBcO-00044c-5f
	for gcvg-git@gmane.org; Sun, 15 Apr 2007 22:46:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753903AbXDOUqT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 16:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753803AbXDOUqT
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 16:46:19 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:58488 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753903AbXDOUqN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 16:46:13 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 3BB517A4D1AA;
	Sun, 15 Apr 2007 22:46:12 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gVOdjdqEihhe; Sun, 15 Apr 2007 22:46:11 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 101F67A4D1A1; Sun, 15 Apr 2007 22:46:11 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.5
In-Reply-To: <11766699701308-git-send-email-mkoegler@auto.tuwien.ac.at>
Message-Id: <201e30b3f69b40aec4f52ca16a22206f7db1c17d.1176659094.git.mkoegler@auto.tuwien.ac.at>
In-Reply-To: <437446e84f3aea71f74fea7ea66db4c1c326fb6b.1176659094.git.mkoegler@auto.tuwien.ac.at>
References: <437446e84f3aea71f74fea7ea66db4c1c326fb6b.1176659094.git.mkoegler@auto.tuwien.ac.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

git_treediff supports comparing subdirectories. As the output of
git-difftree is missing the path to the compared directories,
the links in the output would be wrong.

The patch adds two new parameters to add the missing path prefix.

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---

I renamed the parameters to to/from_prefix.

Modfifing the file name in $diff would require bigger changes and cause new problems:
* new output rewriter for plain view needed
* for modfied files only one file name, but possibly two prefixes

 gitweb/gitweb.perl |   51 ++++++++++++++++++++++++++++++---------------------
 1 files changed, 30 insertions(+), 21 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 790041c..1551d95 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2205,8 +2205,12 @@ sub git_print_tree_entry {
 ## functions printing large fragments of HTML
 
 sub git_difftree_body {
-	my ($difftree, $hash, $parent) = @_;
+	my ($difftree, $hash, $parent, $from_prefix, $to_prefix) = @_;
 	my ($have_blame) = gitweb_check_feature('blame');
+
+	$from_prefix = !defined $from_prefix ? '' : $from_prefix.'/';
+	$to_prefix   = !defined $to_prefix   ? '' : $to_prefix . '/';
+
 	print "<div class=\"list_head\">\n";
 	if ($#{$difftree} > 10) {
 		print(($#{$difftree} + 1) . " files changed:\n");
@@ -2249,7 +2253,7 @@ sub git_difftree_body {
 			$mode_chng   .= "]</span>";
 			print "<td>";
 			print $cgi->a({-href => href(action=>"blob", hash=>$diff{'to_id'},
-			                             hash_base=>$hash, file_name=>$diff{'file'}),
+			                             hash_base=>$hash, file_name=>$to_prefix.$diff{'file'}),
 			              -class => "list"}, esc_path($diff{'file'}));
 			print "</td>\n";
 			print "<td>$mode_chng</td>\n";
@@ -2261,7 +2265,7 @@ sub git_difftree_body {
 				print " | ";
 			}
 			print $cgi->a({-href => href(action=>"blob", hash=>$diff{'to_id'},
-			                             hash_base=>$hash, file_name=>$diff{'file'})},
+			                             hash_base=>$hash, file_name=>$to_prefix.$diff{'file'})},
 			              "blob");
 			print "</td>\n";
 
@@ -2269,7 +2273,7 @@ sub git_difftree_body {
 			my $mode_chng = "<span class=\"file_status deleted\">[deleted $from_file_type]</span>";
 			print "<td>";
 			print $cgi->a({-href => href(action=>"blob", hash=>$diff{'from_id'},
-			                             hash_base=>$parent, file_name=>$diff{'file'}),
+			                             hash_base=>$parent, file_name=>$from_prefix.$diff{'file'}),
 			               -class => "list"}, esc_path($diff{'file'}));
 			print "</td>\n";
 			print "<td>$mode_chng</td>\n";
@@ -2281,15 +2285,15 @@ sub git_difftree_body {
 				print " | ";
 			}
 			print $cgi->a({-href => href(action=>"blob", hash=>$diff{'from_id'},
-			                             hash_base=>$parent, file_name=>$diff{'file'})},
+			                             hash_base=>$parent, file_name=>$from_prefix.$diff{'file'})},
 			              "blob") . " | ";
 			if ($have_blame) {
 				print $cgi->a({-href => href(action=>"blame", hash_base=>$parent,
-				                             file_name=>$diff{'file'})},
+				                             file_name=>$from_prefix.$diff{'file'})},
 				              "blame") . " | ";
 			}
 			print $cgi->a({-href => href(action=>"history", hash_base=>$parent,
-			                             file_name=>$diff{'file'})},
+			                             file_name=>$from_prefix.$diff{'file'})},
 			              "history");
 			print "</td>\n";
 
@@ -2311,7 +2315,7 @@ sub git_difftree_body {
 			}
 			print "<td>";
 			print $cgi->a({-href => href(action=>"blob", hash=>$diff{'to_id'},
-			                             hash_base=>$hash, file_name=>$diff{'file'}),
+			                             hash_base=>$hash, file_name=>$to_prefix.$diff{'file'}),
 			              -class => "list"}, esc_path($diff{'file'}));
 			print "</td>\n";
 			print "<td>$mode_chnge</td>\n";
@@ -2326,20 +2330,21 @@ sub git_difftree_body {
 				print $cgi->a({-href => href(action=>"blobdiff",
 				                             hash=>$diff{'to_id'}, hash_parent=>$diff{'from_id'},
 				                             hash_base=>$hash, hash_parent_base=>$parent,
-				                             file_name=>$diff{'file'})},
+				                             file_name=>$to_prefix.$diff{'file'},
+				                             file_parent=>$from_prefix.$diff{'file'})},
 				              "diff") .
 				      " | ";
 			}
 			print $cgi->a({-href => href(action=>"blob", hash=>$diff{'to_id'},
-			                             hash_base=>$hash, file_name=>$diff{'file'})},
+			                             hash_base=>$hash, file_name=>$to_prefix.$diff{'file'})},
 			               "blob") . " | ";
 			if ($have_blame) {
 				print $cgi->a({-href => href(action=>"blame", hash_base=>$hash,
-				                             file_name=>$diff{'file'})},
+				                             file_name=>$to_prefix.$diff{'file'})},
 				              "blame") . " | ";
 			}
 			print $cgi->a({-href => href(action=>"history", hash_base=>$hash,
-			                             file_name=>$diff{'file'})},
+			                             file_name=>$to_prefix.$diff{'file'})},
 			              "history");
 			print "</td>\n";
 
@@ -2353,11 +2358,11 @@ sub git_difftree_body {
 			}
 			print "<td>" .
 			      $cgi->a({-href => href(action=>"blob", hash_base=>$hash,
-			                             hash=>$diff{'to_id'}, file_name=>$diff{'to_file'}),
+			                             hash=>$diff{'to_id'}, file_name=>$to_prefix.$diff{'to_file'}),
 			              -class => "list"}, esc_path($diff{'to_file'})) . "</td>\n" .
 			      "<td><span class=\"file_status $nstatus\">[$nstatus from " .
 			      $cgi->a({-href => href(action=>"blob", hash_base=>$parent,
-			                             hash=>$diff{'from_id'}, file_name=>$diff{'from_file'}),
+			                             hash=>$diff{'from_id'}, file_name=>$from_prefix.$diff{'from_file'}),
 			              -class => "list"}, esc_path($diff{'from_file'})) .
 			      " with " . (int $diff{'similarity'}) . "% similarity$mode_chng]</span></td>\n" .
 			      "<td class=\"link\">";
@@ -2371,20 +2376,20 @@ sub git_difftree_body {
 				print $cgi->a({-href => href(action=>"blobdiff",
 				                             hash=>$diff{'to_id'}, hash_parent=>$diff{'from_id'},
 				                             hash_base=>$hash, hash_parent_base=>$parent,
-				                             file_name=>$diff{'to_file'}, file_parent=>$diff{'from_file'})},
+				                             file_name=>$to_prefix.$diff{'to_file'}, file_parent=>$from_prefix.$diff{'from_file'})},
 				              "diff") .
 				      " | ";
 			}
 			print $cgi->a({-href => href(action=>"blob", hash=>$diff{'to_id'},
-			                             hash_base=>$parent, file_name=>$diff{'to_file'})},
+			                             hash_base=>$hash, file_name=>$to_prefix.$diff{'to_file'})},
 			              "blob") . " | ";
 			if ($have_blame) {
 				print $cgi->a({-href => href(action=>"blame", hash_base=>$hash,
-				                             file_name=>$diff{'to_file'})},
+				                             file_name=>$to_prefix.$diff{'to_file'})},
 				              "blame") . " | ";
 			}
 			print $cgi->a({-href => href(action=>"history", hash_base=>$hash,
-			                            file_name=>$diff{'to_file'})},
+			                            file_name=>$to_prefix.$diff{'to_file'})},
 			              "history");
 			print "</td>\n";
 
@@ -2395,7 +2400,7 @@ sub git_difftree_body {
 }
 
 sub git_patchset_body {
-	my ($fd, $difftree, $hash, $hash_parent) = @_;
+	my ($fd, $difftree, $hash, $hash_parent, $from_prefix, $to_prefix) = @_;
 
 	my $patch_idx = 0;
 	my $patch_number = 0;
@@ -2403,6 +2408,9 @@ sub git_patchset_body {
 	my $diffinfo;
 	my (%from, %to);
 
+	$from_prefix = !defined $from_prefix ? '' : $from_prefix.'/';
+	$to_prefix   = !defined $to_prefix   ? '' : $to_prefix . '/';
+
 	print "<div class=\"patchset\">\n";
 
 	# skip to first patch
@@ -2459,17 +2467,18 @@ sub git_patchset_body {
 			}
 			$from{'file'} = $diffinfo->{'from_file'} || $diffinfo->{'file'};
 			$to{'file'}   = $diffinfo->{'to_file'}   || $diffinfo->{'file'};
+
 			if ($diffinfo->{'status'} ne "A") { # not new (added) file
 				$from{'href'} = href(action=>"blob", hash_base=>$hash_parent,
 				                     hash=>$diffinfo->{'from_id'},
-				                     file_name=>$from{'file'});
+				                     file_name=>$from_prefix.$from{'file'});
 			} else {
 				delete $from{'href'};
 			}
 			if ($diffinfo->{'status'} ne "D") { # not deleted file
 				$to{'href'} = href(action=>"blob", hash_base=>$hash,
 				                   hash=>$diffinfo->{'to_id'},
-				                   file_name=>$to{'file'});
+				                   file_name=>$to_prefix.$to{'file'});
 			} else {
 				delete $to{'href'};
 			}
-- 
1.5.1.1.85.gf1888
