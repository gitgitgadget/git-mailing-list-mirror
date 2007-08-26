From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH 2/4] gitweb: support filename prefix in git_patchset_body/git_difftree_body
Date: Sun, 26 Aug 2007 17:29:55 +0200
Message-ID: <11881421953009-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Sun Aug 26 17:30:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPK4J-0006Qu-So
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 17:30:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbXHZP37 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Aug 2007 11:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbXHZP37
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 11:29:59 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:54164 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751313AbXHZP36 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 11:29:58 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 38E3E73B5FAC;
	Sun, 26 Aug 2007 17:29:56 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fP5rr75GrbHo; Sun, 26 Aug 2007 17:29:55 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 638AB73B5FA4; Sun, 26 Aug 2007 17:29:55 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56690>

git_treediff supports comparing subdirectories. As the output of
git-difftree is missing the path to the compared directories,
the links in the output would be wrong.

The patch adds two new parameters to add the missing path prefix.

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
This is an updated version. Please use this version
for repo.or.cz instead of the old one.

I don't resend the rest of the series, as they are unchanged.

 gitweb/gitweb.perl |   88 +++++++++++++++++++++++++++++----------------------
 1 files changed, 50 insertions(+), 38 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 90b90e8..c09ff9f 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1176,10 +1176,10 @@ sub format_diff_from_to_header {
 				        $cgi->a({-href=>href(action=>"blobdiff",
 				                             hash_parent=>$diffinfo->{'from_id'}[$i],
 				                             hash_parent_base=>$parents[$i],
-				                             file_parent=>$from->{'file'}[$i],
+				                             file_parent=>$diffinfo->{'from_prefix'}.$from->{'file'}[$i],
 				                             hash=>$diffinfo->{'to_id'},
 				                             hash_base=>$hash,
-				                             file_name=>$to->{'file'}),
+				                             file_name=>$diffinfo->{'to_prefix'}.$to->{'file'}),
 				                 -class=>"path",
 				                 -title=>"diff" . ($i+1)},
 				                $i+1) .
@@ -1222,7 +1222,7 @@ sub format_diff_cc_simplified {
 		$result .= $cgi->a({-href => href(action=>"blob",
 		                                  hash_base=>$hash,
 		                                  hash=>$diffinfo->{'to_id'},
-		                                  file_name=>$diffinfo->{'to_file'}),
+		                                  file_name=>$diffinfo->{'to_prefix'}.$diffinfo->{'to_file'}),
 		                    -class => "path"},
 		                   esc_path($diffinfo->{'to_file'}));
 	} else {
@@ -2030,7 +2030,7 @@ sub parse_from_to_diffinfo {
 				$from->{'href'}[$i] = href(action=>"blob",
 				                           hash_base=>$parents[$i],
 				                           hash=>$diffinfo->{'from_id'}[$i],
-				                           file_name=>$from->{'file'}[$i]);
+				                           file_name=>$diffinfo->{'from_prefix'}.$from->{'file'}[$i]);
 			} else {
 				$from->{'href'}[$i] = undef;
 			}
@@ -2040,7 +2040,7 @@ sub parse_from_to_diffinfo {
 		if ($diffinfo->{'status'} ne "A") { # not new (added) file
 			$from->{'href'} = href(action=>"blob", hash_base=>$hash_parent,
 			                       hash=>$diffinfo->{'from_id'},
-			                       file_name=>$from->{'file'});
+			                       file_name=>$diffinfo->{'from_prefix'}.$from->{'file'});
 		} else {
 			delete $from->{'href'};
 		}
@@ -2050,7 +2050,7 @@ sub parse_from_to_diffinfo {
 	if (!is_deleted($diffinfo)) { # file exists in result
 		$to->{'href'} = href(action=>"blob", hash_base=>$hash,
 		                     hash=>$diffinfo->{'to_id'},
-		                     file_name=>$to->{'file'});
+		                     file_name=>$diffinfo->{'to_prefix'}.$to->{'file'});
 	} else {
 		delete $to->{'href'};
 	}
@@ -2798,9 +2798,13 @@ sub is_deleted {
 }
 
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
@@ -2857,7 +2861,7 @@ sub git_difftree_body {
 				# file exists in the result (child) commit
 				print "<td>" .
 				      $cgi->a({-href => href(action=>"blob", hash=>$diff->{'to_id'},
-				                             file_name=>$diff->{'to_file'},
+				                             file_name=>$to_prefix.$diff->{'to_file'},
 				                             hash_base=>$hash),
 				              -class => "list"}, esc_path($diff->{'to_file'})) .
 				      "</td>\n";
@@ -2894,7 +2898,7 @@ sub git_difftree_body {
 					      $cgi->a({-href => href(action=>"blob",
 					                             hash_base=>$hash,
 					                             hash=>$from_hash,
-					                             file_name=>$from_path)},
+					                             file_name=>$from_prefix.$from_path)},
 					              "blob" . ($i+1)) .
 					      " | </td>\n";
 				} else {
@@ -2908,8 +2912,8 @@ sub git_difftree_body {
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
@@ -2919,14 +2923,14 @@ sub git_difftree_body {
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
@@ -2960,7 +2964,7 @@ sub git_difftree_body {
 			$mode_chng   .= "]</span>";
 			print "<td>";
 			print $cgi->a({-href => href(action=>"blob", hash=>$diff->{'to_id'},
-			                             hash_base=>$hash, file_name=>$diff->{'file'}),
+			                             hash_base=>$hash, file_name=>$to_prefix.$diff->{'file'}),
 			              -class => "list"}, esc_path($diff->{'file'}));
 			print "</td>\n";
 			print "<td>$mode_chng</td>\n";
@@ -2972,7 +2976,7 @@ sub git_difftree_body {
 				print " | ";
 			}
 			print $cgi->a({-href => href(action=>"blob", hash=>$diff->{'to_id'},
-			                             hash_base=>$hash, file_name=>$diff->{'file'})},
+			                             hash_base=>$hash, file_name=>$to_prefix.$diff->{'file'})},
 			              "blob");
 			print "</td>\n";
 
@@ -2980,7 +2984,7 @@ sub git_difftree_body {
 			my $mode_chng = "<span class=\"file_status deleted\">[deleted $from_file_type]</span>";
 			print "<td>";
 			print $cgi->a({-href => href(action=>"blob", hash=>$diff->{'from_id'},
-			                             hash_base=>$parent, file_name=>$diff->{'file'}),
+			                             hash_base=>$parent, file_name=>$from_prefix.$diff->{'file'}),
 			               -class => "list"}, esc_path($diff->{'file'}));
 			print "</td>\n";
 			print "<td>$mode_chng</td>\n";
@@ -2992,15 +2996,15 @@ sub git_difftree_body {
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
 
@@ -3022,7 +3026,7 @@ sub git_difftree_body {
 			}
 			print "<td>";
 			print $cgi->a({-href => href(action=>"blob", hash=>$diff->{'to_id'},
-			                             hash_base=>$hash, file_name=>$diff->{'file'}),
+			                             hash_base=>$hash, file_name=>$to_prefix.$diff->{'file'}),
 			              -class => "list"}, esc_path($diff->{'file'}));
 			print "</td>\n";
 			print "<td>$mode_chnge</td>\n";
@@ -3037,20 +3041,21 @@ sub git_difftree_body {
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
 
@@ -3064,11 +3069,11 @@ sub git_difftree_body {
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
@@ -3082,20 +3087,20 @@ sub git_difftree_body {
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
 
@@ -3107,7 +3112,7 @@ sub git_difftree_body {
 }
 
 sub git_patchset_body {
-	my ($fd, $difftree, $hash, @hash_parents) = @_;
+	my ($fd, $difftree, $from_prefix, $to_prefix, $hash, @hash_parents) = @_;
 	my ($hash_parent) = $hash_parents[0];
 
 	my $patch_idx = 0;
@@ -3116,6 +3121,9 @@ sub git_patchset_body {
 	my $diffinfo;
 	my (%from, %to);
 
+	$from_prefix = !defined $from_prefix ? '' : $from_prefix.'/';
+	$to_prefix   = !defined $to_prefix   ? '' : $to_prefix . '/';
+
 	print "<div class=\"patchset\">\n";
 
 	# skip to first patch
@@ -3163,6 +3171,8 @@ sub git_patchset_body {
 		    $diffinfo->{'to_id'} eq $to_id) {
 			# this is continuation of a split patch
 			print "<div class=\"patch cont\">\n";
+			$diffinfo->{'from_prefix'} = $from_prefix;
+			$diffinfo->{'to_prefix'} = $to_prefix;
 		} else {
 			# advance raw git-diff output if needed
 			$patch_idx++ if defined $diffinfo;
@@ -3194,6 +3204,8 @@ sub git_patchset_body {
 				}
 			} until (!defined $to_name || $to_name eq $diffinfo->{'to_file'} ||
 			         $patch_idx > $#$difftree);
+			$diffinfo->{'from_prefix'} = $from_prefix;
+			$diffinfo->{'to_prefix'} = $to_prefix;
 			# modifies %from, %to hashes
 			parse_from_to_diffinfo($diffinfo, \%from, \%to, @hash_parents);
 			if ($diffinfo->{'nparents'}) {
@@ -3208,7 +3220,7 @@ sub git_patchset_body {
 						$from{'href'}[$i] = href(action=>"blob",
 						                         hash_base=>$hash_parents[$i],
 						                         hash=>$diffinfo->{'from_id'}[$i],
-						                         file_name=>$from{'file'}[$i]);
+						                         file_name=>$from_prefix.$from{'file'}[$i]);
 					} else {
 						$from{'href'}[$i] = undef;
 					}
@@ -3218,7 +3230,7 @@ sub git_patchset_body {
 				if ($diffinfo->{'status'} ne "A") { # not new (added) file
 					$from{'href'} = href(action=>"blob", hash_base=>$hash_parent,
 					                     hash=>$diffinfo->{'from_id'},
-					                     file_name=>$from{'file'});
+					                     file_name=>$from_prefix.$from{'file'});
 				} else {
 					delete $from{'href'};
 				}
@@ -3228,7 +3240,7 @@ sub git_patchset_body {
 			if (!is_deleted($diffinfo)) { # file exists in result
 				$to{'href'} = href(action=>"blob", hash_base=>$hash,
 				                   hash=>$diffinfo->{'to_id'},
-				                   file_name=>$to{'file'});
+				                   file_name=>$to_prefix.$to{'file'});
 			} else {
 				delete $to{'href'};
 			}
@@ -4590,7 +4602,7 @@ sub git_commit {
 	git_print_log($co{'comment'});
 	print "</div>\n";
 
-	git_difftree_body(\@difftree, $hash, @$parents);
+	git_difftree_body(\@difftree, undef, undef, $hash, @$parents);
 
 	git_footer_html();
 }
@@ -4748,7 +4760,7 @@ sub git_blobdiff {
 	if ($format eq 'html') {
 		print "<div class=\"page_body\">\n";
 
-		git_patchset_body($fd, [ \%diffinfo ], $hash_base, $hash_parent_base);
+		git_patchset_body($fd, [ \%diffinfo ], undef, undef, $hash_base, $hash_parent_base);
 		close $fd;
 
 		print "</div>\n"; # class="page_body"
@@ -4931,11 +4943,11 @@ TEXT
 	if ($format eq 'html') {
 		my $use_parents = !defined $hash_parent ||
 			$hash_parent eq '-c' || $hash_parent eq '--cc';
-		git_difftree_body(\@difftree, $hash,
+		git_difftree_body(\@difftree, undef, undef, $hash,
 		                  $use_parents ? @{$co{'parents'}} : $hash_parent);
 		print "<br/>\n";
 
-		git_patchset_body($fd, \@difftree, $hash,
+		git_patchset_body($fd, \@difftree, undef, undef, $hash,
 		                  $use_parents ? @{$co{'parents'}} : $hash_parent);
 		close $fd;
 		print "</div>\n"; # class="page_body"
-- 
1.5.3.rc0.843.g9779f
