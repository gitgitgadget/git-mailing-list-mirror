From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH 2/5] gitweb: support filename prefix in git_patchset_body/git_difftree_body
Date: Sun, 20 May 2007 22:23:29 +0200
Message-ID: <11796926121315-git-send-email-mkoegler@auto.tuwien.ac.at>
References: <11796926121641-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sun May 20 22:23:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HprwR-0003nX-4C
	for gcvg-git@gmane.org; Sun, 20 May 2007 22:23:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756015AbXETUXm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 16:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755969AbXETUXl
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 16:23:41 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:59498 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756015AbXETUXh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 16:23:37 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 1DA927AF1C61;
	Sun, 20 May 2007 22:23:33 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yemV+PmE-NBs; Sun, 20 May 2007 22:23:32 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 5E9DA7AF1C7F; Sun, 20 May 2007 22:23:32 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.5
In-Reply-To: <11796926121641-git-send-email-mkoegler@auto.tuwien.ac.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47906>

git_treediff supports comparing subdirectories. As the output of
git-difftree is missing the path to the compared directories,
the links in the output would be wrong.

The patch adds two new parameters to add the missing path prefix.

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 gitweb/gitweb.perl |   72 +++++++++++++++++++++++++++++-----------------------
 1 files changed, 40 insertions(+), 32 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 63ed14f..33aba86 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2366,9 +2366,13 @@ sub from_ids_eq {
 
 
 sub git_difftree_body {
-	my ($difftree, $hash, @parents) = @_;
+	my ($difftree, $from_prefix, $to_prefix, $hash, @parents) = @_;
 	my ($parent) = $parents[0];
 	my ($have_blame) = gitweb_check_feature('blame');
+
+	$from_prefix = !defined $from_prefix ? '' : $from_prefix.'/';
+	$to_prefix   = !defined $to_prefix   ? '' : $to_prefix . '/';
+
 	print "<div class=\"list_head\">\n";
 	if ($#{$difftree} > 10) {
 		print(($#{$difftree} + 1) . " files changed:\n");
@@ -2405,7 +2409,7 @@ sub git_difftree_body {
 				# file exists in the result (child) commit
 				print "<td>" .
 				      $cgi->a({-href => href(action=>"blob", hash=>$diff->{'to_id'},
-				                             file_name=>$diff->{'to_file'},
+				                             file_name=>$to_prefix.$diff->{'to_file'},
 				                             hash_base=>$hash),
 				              -class => "list"}, esc_path($diff->{'to_file'})) .
 				      "</td>\n";
@@ -2442,7 +2446,7 @@ sub git_difftree_body {
 					      $cgi->a({-href => href(action=>"blob",
 					                             hash_base=>$hash,
 					                             hash=>$from_hash,
-					                             file_name=>$from_path)},
+					                             file_name=>$from_prefix.$from_path)},
 					              "blob" . ($i+1)) .
 					      " | </td>\n";
 				} else {
@@ -2456,8 +2460,8 @@ sub git_difftree_body {
 					                             hash_parent=>$from_hash,
 					                             hash_base=>$hash,
 					                             hash_parent_base=>$hash_parent,
-					                             file_name=>$diff->{'to_file'},
-					                             file_parent=>$from_path)},
+					                             file_name=>$to_prefix.$diff->{'to_file'},
+					                             file_parent=>$from_prefix.$from_path)},
 					              "diff" . ($i+1)) .
 					      " | </td>\n";
 				}
@@ -2467,14 +2471,14 @@ sub git_difftree_body {
 			if ($not_deleted) {
 				print $cgi->a({-href => href(action=>"blob",
 				                             hash=>$diff->{'to_id'},
-				                             file_name=>$diff->{'to_file'},
+				                             file_name=>$to_prefix.$diff->{'to_file'},
 				                             hash_base=>$hash)},
 				              "blob");
 				print " | " if ($has_history);
 			}
 			if ($has_history) {
 				print $cgi->a({-href => href(action=>"history",
-				                             file_name=>$diff->{'to_file'},
+				                             file_name=>$to_prefix.$diff->{'to_file'},
 				                             hash_base=>$hash)},
 				              "history");
 			}
@@ -2508,7 +2512,7 @@ sub git_difftree_body {
 			$mode_chng   .= "]</span>";
 			print "<td>";
 			print $cgi->a({-href => href(action=>"blob", hash=>$diff->{'to_id'},
-			                             hash_base=>$hash, file_name=>$diff->{'file'}),
+			                             hash_base=>$hash, file_name=>$to_prefix.$diff->{'file'}),
 			              -class => "list"}, esc_path($diff->{'file'}));
 			print "</td>\n";
 			print "<td>$mode_chng</td>\n";
@@ -2520,7 +2524,7 @@ sub git_difftree_body {
 				print " | ";
 			}
 			print $cgi->a({-href => href(action=>"blob", hash=>$diff->{'to_id'},
-			                             hash_base=>$hash, file_name=>$diff->{'file'})},
+			                             hash_base=>$hash, file_name=>$to_prefix.$diff->{'file'})},
 			              "blob");
 			print "</td>\n";
 
@@ -2528,7 +2532,7 @@ sub git_difftree_body {
 			my $mode_chng = "<span class=\"file_status deleted\">[deleted $from_file_type]</span>";
 			print "<td>";
 			print $cgi->a({-href => href(action=>"blob", hash=>$diff->{'from_id'},
-			                             hash_base=>$parent, file_name=>$diff->{'file'}),
+			                             hash_base=>$parent, file_name=>$from_prefix.$diff->{'file'}),
 			               -class => "list"}, esc_path($diff->{'file'}));
 			print "</td>\n";
 			print "<td>$mode_chng</td>\n";
@@ -2540,15 +2544,15 @@ sub git_difftree_body {
 				print " | ";
 			}
 			print $cgi->a({-href => href(action=>"blob", hash=>$diff->{'from_id'},
-			                             hash_base=>$parent, file_name=>$diff->{'file'})},
+			                             hash_base=>$parent, file_name=>$from_prefix.$diff->{'file'})},
 			              "blob") . " | ";
 			if ($have_blame) {
 				print $cgi->a({-href => href(action=>"blame", hash_base=>$parent,
-				                             file_name=>$diff->{'file'})},
+				                             file_name=>$from_prefix.$diff->{'file'})},
 				              "blame") . " | ";
 			}
 			print $cgi->a({-href => href(action=>"history", hash_base=>$parent,
-			                             file_name=>$diff->{'file'})},
+			                             file_name=>$from_prefix.$diff->{'file'})},
 			              "history");
 			print "</td>\n";
 
@@ -2570,7 +2574,7 @@ sub git_difftree_body {
 			}
 			print "<td>";
 			print $cgi->a({-href => href(action=>"blob", hash=>$diff->{'to_id'},
-			                             hash_base=>$hash, file_name=>$diff->{'file'}),
+			                             hash_base=>$hash, file_name=>$to_prefix.$diff->{'file'}),
 			              -class => "list"}, esc_path($diff->{'file'}));
 			print "</td>\n";
 			print "<td>$mode_chnge</td>\n";
@@ -2585,20 +2589,21 @@ sub git_difftree_body {
 				print $cgi->a({-href => href(action=>"blobdiff",
 				                             hash=>$diff->{'to_id'}, hash_parent=>$diff->{'from_id'},
 				                             hash_base=>$hash, hash_parent_base=>$parent,
-				                             file_name=>$diff->{'file'})},
+				                             file_name=>$to_prefix.$diff->{'file'},
+				                             file_parent=>$from_prefix.$diff->{'file'})},
 				              "diff") .
 				      " | ";
 			}
 			print $cgi->a({-href => href(action=>"blob", hash=>$diff->{'to_id'},
-			                             hash_base=>$hash, file_name=>$diff->{'file'})},
+			                             hash_base=>$hash, file_name=>$to_prefix.$diff->{'file'})},
 			               "blob") . " | ";
 			if ($have_blame) {
 				print $cgi->a({-href => href(action=>"blame", hash_base=>$hash,
-				                             file_name=>$diff->{'file'})},
+				                             file_name=>$to_prefix.$diff->{'file'})},
 				              "blame") . " | ";
 			}
 			print $cgi->a({-href => href(action=>"history", hash_base=>$hash,
-			                             file_name=>$diff->{'file'})},
+			                             file_name=>$to_prefix.$diff->{'file'})},
 			              "history");
 			print "</td>\n";
 
@@ -2612,11 +2617,11 @@ sub git_difftree_body {
 			}
 			print "<td>" .
 			      $cgi->a({-href => href(action=>"blob", hash_base=>$hash,
-			                             hash=>$diff->{'to_id'}, file_name=>$diff->{'to_file'}),
+			                             hash=>$diff->{'to_id'}, file_name=>$to_prefix.$diff->{'to_file'}),
 			              -class => "list"}, esc_path($diff->{'to_file'})) . "</td>\n" .
 			      "<td><span class=\"file_status $nstatus\">[$nstatus from " .
 			      $cgi->a({-href => href(action=>"blob", hash_base=>$parent,
-			                             hash=>$diff->{'from_id'}, file_name=>$diff->{'from_file'}),
+			                             hash=>$diff->{'from_id'}, file_name=>$from_prefix.$diff->{'from_file'}),
 			              -class => "list"}, esc_path($diff->{'from_file'})) .
 			      " with " . (int $diff->{'similarity'}) . "% similarity$mode_chng]</span></td>\n" .
 			      "<td class=\"link\">";
@@ -2630,20 +2635,20 @@ sub git_difftree_body {
 				print $cgi->a({-href => href(action=>"blobdiff",
 				                             hash=>$diff->{'to_id'}, hash_parent=>$diff->{'from_id'},
 				                             hash_base=>$hash, hash_parent_base=>$parent,
-				                             file_name=>$diff->{'to_file'}, file_parent=>$diff->{'from_file'})},
+				                             file_name=>$to_prefix.$diff->{'to_file'}, file_parent=>$from_prefix.$diff->{'from_file'})},
 				              "diff") .
 				      " | ";
 			}
 			print $cgi->a({-href => href(action=>"blob", hash=>$diff->{'to_id'},
-			                             hash_base=>$parent, file_name=>$diff->{'to_file'})},
+			                             hash_base=>$parent, file_name=>$to_prefix.$diff->{'to_file'})},
 			              "blob") . " | ";
 			if ($have_blame) {
 				print $cgi->a({-href => href(action=>"blame", hash_base=>$hash,
-				                             file_name=>$diff->{'to_file'})},
+				                             file_name=>$to_prefix.$diff->{'to_file'})},
 				              "blame") . " | ";
 			}
 			print $cgi->a({-href => href(action=>"history", hash_base=>$hash,
-			                            file_name=>$diff->{'to_file'})},
+			                            file_name=>$to_prefix.$diff->{'to_file'})},
 			              "history");
 			print "</td>\n";
 
@@ -2654,7 +2659,7 @@ sub git_difftree_body {
 }
 
 sub git_patchset_body {
-	my ($fd, $difftree, $hash, @hash_parents) = @_;
+	my ($fd, $difftree, $from_prefix, $to_prefix, $hash, @hash_parents) = @_;
 	my ($hash_parent) = $hash_parents[0];
 
 	my $patch_idx = 0;
@@ -2663,6 +2668,9 @@ sub git_patchset_body {
 	my $diffinfo;
 	my (%from, %to);
 
+	$from_prefix = !defined $from_prefix ? '' : $from_prefix.'/';
+	$to_prefix   = !defined $to_prefix   ? '' : $to_prefix . '/';
+
 	print "<div class=\"patchset\">\n";
 
 	# skip to first patch
@@ -2733,7 +2741,7 @@ sub git_patchset_body {
 						$from{'href'}[$i] = href(action=>"blob",
 						                         hash_base=>$hash_parents[$i],
 						                         hash=>$diffinfo->{'from_id'}[$i],
-						                         file_name=>$from{'file'}[$i]);
+						                         file_name=>$from_prefix.$from{'file'}[$i]);
 					} else {
 						$from{'href'}[$i] = undef;
 					}
@@ -2743,7 +2751,7 @@ sub git_patchset_body {
 				if ($diffinfo->{'status'} ne "A") { # not new (added) file
 					$from{'href'} = href(action=>"blob", hash_base=>$hash_parent,
 					                     hash=>$diffinfo->{'from_id'},
-					                     file_name=>$from{'file'});
+					                     file_name=>$from_prefix.$from{'file'});
 				} else {
 					delete $from{'href'};
 				}
@@ -2753,7 +2761,7 @@ sub git_patchset_body {
 			if ($diffinfo->{'to_id'} ne ('0' x 40)) { # file exists in result
 				$to{'href'} = href(action=>"blob", hash_base=>$hash,
 				                   hash=>$diffinfo->{'to_id'},
-				                   file_name=>$to{'file'});
+				                   file_name=>$to_prefix.$to{'file'});
 			} else {
 				delete $to{'href'};
 			}
@@ -4180,7 +4188,7 @@ sub git_commit {
 	git_print_log($co{'comment'});
 	print "</div>\n";
 
-	git_difftree_body(\@difftree, $hash, @$parents);
+	git_difftree_body(\@difftree, undef, undef, $hash, @$parents);
 
 	git_footer_html();
 }
@@ -4338,7 +4346,7 @@ sub git_blobdiff {
 	if ($format eq 'html') {
 		print "<div class=\"page_body\">\n";
 
-		git_patchset_body($fd, [ \%diffinfo ], $hash_base, $hash_parent_base);
+		git_patchset_body($fd, [ \%diffinfo ], undef, undef, $hash_base, $hash_parent_base);
 		close $fd;
 
 		print "</div>\n"; # class="page_body"
@@ -4495,10 +4503,10 @@ TEXT
 
 	# write patch
 	if ($format eq 'html') {
-		git_difftree_body(\@difftree, $hash, $hash_parent || @{$co{'parents'}});
+		git_difftree_body(\@difftree, undef, undef, $hash, $hash_parent || @{$co{'parents'}});
 		print "<br/>\n";
 
-		git_patchset_body($fd, \@difftree, $hash, $hash_parent || @{$co{'parents'}});
+		git_patchset_body($fd, \@difftree, undef, undef, $hash, $hash_parent || @{$co{'parents'}});
 		close $fd;
 		print "</div>\n"; # class="page_body"
 		git_footer_html();
-- 
1.5.2.rc3.802.g4b4b7
