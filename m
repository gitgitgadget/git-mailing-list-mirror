From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH 2/5] gitweb: support filename prefix in git_patchset_body/git_difftree_body
Date: Sun,  2 Sep 2007 16:46:05 +0200
Message-ID: <11887443693783-git-send-email-mkoegler@auto.tuwien.ac.at>
References: <11887443682216-git-send-email-mkoegler@auto.tuwien.ac.at> <11887443692839-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sun Sep 02 16:47:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRqjC-0000zE-Pp
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 16:47:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756030AbXIBOqh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 10:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755507AbXIBOqh
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 10:46:37 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:45578 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751332AbXIBOqN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 10:46:13 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 71BF47437392;
	Sun,  2 Sep 2007 16:46:10 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g1OAZU2fvHhV; Sun,  2 Sep 2007 16:46:09 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 262FE7437389; Sun,  2 Sep 2007 16:46:09 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.5
In-Reply-To: <11887443692839-git-send-email-mkoegler@auto.tuwien.ac.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57332>

git_treediff supports comparing subdirectories. As the output of
git-difftree is missing the path to the compared directories,
the links in the output would be wrong.

The patch adds two new parameters to add the missing path prefix.

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 gitweb/gitweb.perl |   88 +++++++++++++++++++++++++++++----------------------
 1 files changed, 50 insertions(+), 38 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 05bfb26..5f67d73 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1173,10 +1173,10 @@ sub format_diff_from_to_header {
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
@@ -1219,7 +1219,7 @@ sub format_diff_cc_simplified {
 		$result .= $cgi->a({-href => href(action=>"blob",
 		                                  hash_base=>$hash,
 		                                  hash=>$diffinfo->{'to_id'},
-		                                  file_name=>$diffinfo->{'to_file'}),
+		                                  file_name=>$diffinfo->{'to_prefix'}.$diffinfo->{'to_file'}),
 		                    -class => "path"},
 		                   esc_path($diffinfo->{'to_file'}));
 	} else {
@@ -2027,7 +2027,7 @@ sub parse_from_to_diffinfo {
 				$from->{'href'}[$i] = href(action=>"blob",
 				                           hash_base=>$parents[$i],
 				                           hash=>$diffinfo->{'from_id'}[$i],
-				                           file_name=>$from->{'file'}[$i]);
+				                           file_name=>$diffinfo->{'from_prefix'}.$from->{'file'}[$i]);
 			} else {
 				$from->{'href'}[$i] = undef;
 			}
@@ -2037,7 +2037,7 @@ sub parse_from_to_diffinfo {
 		if ($diffinfo->{'status'} ne "A") { # not new (added) file
 			$from->{'href'} = href(action=>"blob", hash_base=>$hash_parent,
 			                       hash=>$diffinfo->{'from_id'},
-			                       file_name=>$from->{'file'});
+			                       file_name=>$diffinfo->{'from_prefix'}.$from->{'file'});
 		} else {
 			delete $from->{'href'};
 		}
@@ -2047,7 +2047,7 @@ sub parse_from_to_diffinfo {
 	if (!is_deleted($diffinfo)) { # file exists in result
 		$to->{'href'} = href(action=>"blob", hash_base=>$hash,
 		                     hash=>$diffinfo->{'to_id'},
-		                     file_name=>$to->{'file'});
+		                     file_name=>$diffinfo->{'to_prefix'}.$to->{'file'});
 	} else {
 		delete $to->{'href'};
 	}
@@ -2795,9 +2795,13 @@ sub is_deleted {
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
@@ -2854,7 +2858,7 @@ sub git_difftree_body {
 				# file exists in the result (child) commit
 				print "<td>" .
 				      $cgi->a({-href => href(action=>"blob", hash=>$diff->{'to_id'},
-				                             file_name=>$diff->{'to_file'},
+				                             file_name=>$to_prefix.$diff->{'to_file'},
 				                             hash_base=>$hash),
 				              -class => "list"}, esc_path($diff->{'to_file'})) .
 				      "</td>\n";
@@ -2891,7 +2895,7 @@ sub git_difftree_body {
 					      $cgi->a({-href => href(action=>"blob",
 					                             hash_base=>$hash,
 					                             hash=>$from_hash,
-					                             file_name=>$from_path)},
+					                             file_name=>$from_prefix.$from_path)},
 					              "blob" . ($i+1)) .
 					      " | </td>\n";
 				} else {
@@ -2905,8 +2909,8 @@ sub git_difftree_body {
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
@@ -2916,14 +2920,14 @@ sub git_difftree_body {
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
@@ -2957,7 +2961,7 @@ sub git_difftree_body {
 			$mode_chng   .= "]</span>";
 			print "<td>";
 			print $cgi->a({-href => href(action=>"blob", hash=>$diff->{'to_id'},
-			                             hash_base=>$hash, file_name=>$diff->{'file'}),
+			                             hash_base=>$hash, file_name=>$to_prefix.$diff->{'file'}),
 			              -class => "list"}, esc_path($diff->{'file'}));
 			print "</td>\n";
 			print "<td>$mode_chng</td>\n";
@@ -2969,7 +2973,7 @@ sub git_difftree_body {
 				print " | ";
 			}
 			print $cgi->a({-href => href(action=>"blob", hash=>$diff->{'to_id'},
-			                             hash_base=>$hash, file_name=>$diff->{'file'})},
+			                             hash_base=>$hash, file_name=>$to_prefix.$diff->{'file'})},
 			              "blob");
 			print "</td>\n";
 
@@ -2977,7 +2981,7 @@ sub git_difftree_body {
 			my $mode_chng = "<span class=\"file_status deleted\">[deleted $from_file_type]</span>";
 			print "<td>";
 			print $cgi->a({-href => href(action=>"blob", hash=>$diff->{'from_id'},
-			                             hash_base=>$parent, file_name=>$diff->{'file'}),
+			                             hash_base=>$parent, file_name=>$from_prefix.$diff->{'file'}),
 			               -class => "list"}, esc_path($diff->{'file'}));
 			print "</td>\n";
 			print "<td>$mode_chng</td>\n";
@@ -2989,15 +2993,15 @@ sub git_difftree_body {
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
 
@@ -3019,7 +3023,7 @@ sub git_difftree_body {
 			}
 			print "<td>";
 			print $cgi->a({-href => href(action=>"blob", hash=>$diff->{'to_id'},
-			                             hash_base=>$hash, file_name=>$diff->{'file'}),
+			                             hash_base=>$hash, file_name=>$to_prefix.$diff->{'file'}),
 			              -class => "list"}, esc_path($diff->{'file'}));
 			print "</td>\n";
 			print "<td>$mode_chnge</td>\n";
@@ -3034,20 +3038,21 @@ sub git_difftree_body {
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
 
@@ -3061,11 +3066,11 @@ sub git_difftree_body {
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
@@ -3079,20 +3084,20 @@ sub git_difftree_body {
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
 
@@ -3104,7 +3109,7 @@ sub git_difftree_body {
 }
 
 sub git_patchset_body {
-	my ($fd, $difftree, $hash, @hash_parents) = @_;
+	my ($fd, $difftree, $from_prefix, $to_prefix, $hash, @hash_parents) = @_;
 	my ($hash_parent) = $hash_parents[0];
 
 	my $patch_idx = 0;
@@ -3113,6 +3118,9 @@ sub git_patchset_body {
 	my $diffinfo;
 	my (%from, %to);
 
+	$from_prefix = !defined $from_prefix ? '' : $from_prefix.'/';
+	$to_prefix   = !defined $to_prefix   ? '' : $to_prefix . '/';
+
 	print "<div class=\"patchset\">\n";
 
 	# skip to first patch
@@ -3160,6 +3168,8 @@ sub git_patchset_body {
 		    $diffinfo->{'to_id'} eq $to_id) {
 			# this is continuation of a split patch
 			print "<div class=\"patch cont\">\n";
+			$diffinfo->{'from_prefix'} = $from_prefix;
+			$diffinfo->{'to_prefix'} = $to_prefix;
 		} else {
 			# advance raw git-diff output if needed
 			$patch_idx++ if defined $diffinfo;
@@ -3191,6 +3201,8 @@ sub git_patchset_body {
 				}
 			} until (!defined $to_name || $to_name eq $diffinfo->{'to_file'} ||
 			         $patch_idx > $#$difftree);
+			$diffinfo->{'from_prefix'} = $from_prefix;
+			$diffinfo->{'to_prefix'} = $to_prefix;
 			# modifies %from, %to hashes
 			parse_from_to_diffinfo($diffinfo, \%from, \%to, @hash_parents);
 			if ($diffinfo->{'nparents'}) {
@@ -3205,7 +3217,7 @@ sub git_patchset_body {
 						$from{'href'}[$i] = href(action=>"blob",
 						                         hash_base=>$hash_parents[$i],
 						                         hash=>$diffinfo->{'from_id'}[$i],
-						                         file_name=>$from{'file'}[$i]);
+						                         file_name=>$from_prefix.$from{'file'}[$i]);
 					} else {
 						$from{'href'}[$i] = undef;
 					}
@@ -3215,7 +3227,7 @@ sub git_patchset_body {
 				if ($diffinfo->{'status'} ne "A") { # not new (added) file
 					$from{'href'} = href(action=>"blob", hash_base=>$hash_parent,
 					                     hash=>$diffinfo->{'from_id'},
-					                     file_name=>$from{'file'});
+					                     file_name=>$from_prefix.$from{'file'});
 				} else {
 					delete $from{'href'};
 				}
@@ -3225,7 +3237,7 @@ sub git_patchset_body {
 			if (!is_deleted($diffinfo)) { # file exists in result
 				$to{'href'} = href(action=>"blob", hash_base=>$hash,
 				                   hash=>$diffinfo->{'to_id'},
-				                   file_name=>$to{'file'});
+				                   file_name=>$to_prefix.$to{'file'});
 			} else {
 				delete $to{'href'};
 			}
@@ -4587,7 +4599,7 @@ sub git_commit {
 	git_print_log($co{'comment'});
 	print "</div>\n";
 
-	git_difftree_body(\@difftree, $hash, @$parents);
+	git_difftree_body(\@difftree, undef, undef, $hash, @$parents);
 
 	git_footer_html();
 }
@@ -4745,7 +4757,7 @@ sub git_blobdiff {
 	if ($format eq 'html') {
 		print "<div class=\"page_body\">\n";
 
-		git_patchset_body($fd, [ \%diffinfo ], $hash_base, $hash_parent_base);
+		git_patchset_body($fd, [ \%diffinfo ], undef, undef, $hash_base, $hash_parent_base);
 		close $fd;
 
 		print "</div>\n"; # class="page_body"
@@ -4928,11 +4940,11 @@ TEXT
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
1.5.3.rc7.849.g2f5f
