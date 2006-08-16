From: Martin Waitz <tali@admingilde.org>
Subject: [PATCH] gitweb: continue consolidation of URL generation.
Date: Thu, 17 Aug 2006 00:28:36 +0200
Message-ID: <11557673213372-git-send-email-tali@admingilde.org>
Cc: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Thu Aug 17 00:29:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDTsX-00005o-I4
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 00:28:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932291AbWHPW2q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Aug 2006 18:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbWHPW2q
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Aug 2006 18:28:46 -0400
Received: from agent.admingilde.org ([213.95.21.5]:12488 "EHLO
	mail.admingilde.org") by vger.kernel.org with ESMTP id S932291AbWHPW2p
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Aug 2006 18:28:45 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1GDTsP-0007ON-Nd; Thu, 17 Aug 2006 00:28:41 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.2.rc2.gf055
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25532>

Further use href() instead of URL generation by string concatenation.
Almost all functions are converted now.

Signed-off-by: Martin Waitz <tali@admingilde.org>
---
 gitweb/gitweb.perl |   68 +++++++++++++++++++++++++++-------------------------
 1 files changed, 35 insertions(+), 33 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 37a6284..72e687e 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -204,7 +204,9 @@ sub href(%) {
 
 	my $href = "$my_uri?";
 	$href .= esc_param( join(";",
-		map { "$mapping{$_}=$params{$_}" } keys %params
+		map {
+			"$mapping{$_}=$params{$_}" if $params{$_}
+		} keys %params
 	) );
 
 	return $href;
@@ -1047,7 +1049,7 @@ sub git_footer_html {
 		}
 		print $cgi->a({-href => href(action=>"rss"), -class => "rss_logo"}, "RSS") . "\n";
 	} else {
-		print $cgi->a({-href => "$my_uri?" . esc_param("a=opml"), -class => "rss_logo"}, "OPML") . "\n";
+		print $cgi->a({-href => href(action=>"opml"), -class => "rss_logo"}, "OPML") . "\n";
 	}
 	print "</div>\n" .
 	      "</body>\n" .
@@ -1252,7 +1254,7 @@ sub git_difftree_body {
 			      "<td class=\"link\">" .
 				$cgi->a({-href => href(action=>"blob", hash=>$to_id, hash_base=>$hash, file_name=>$file)}, "blob");
 			if ($to_id ne $from_id) { # modified
-				print $cgi->a({-href => href(action=>"blobdiff", hash=>$to_id, hash_parent=>$from_id, hash_base=>$hash, file_name=>$file)}, "diff");
+				print " | " . $cgi->a({-href => href(action=>"blobdiff", hash=>$to_id, hash_parent=>$from_id, hash_base=>$hash, file_name=>$file)}, "diff");
 			}
 			print " | " . $cgi->a({-href => href(action=>"history", hash_base=>$hash, file_name=>$file)}, "history") . "\n";
 			print "</td>\n";
@@ -1663,16 +1665,16 @@ sub git_project_list {
 			print "<tr class=\"light\">\n";
 		}
 		$alternate ^= 1;
-		print "<td>" . $cgi->a({-href => "$my_uri?" . esc_param("p=$pr->{'path'};a=summary"),
+		print "<td>" . $cgi->a({-href => href(project=>$pr->{'path'}, action=>"summary"),
 		                        -class => "list"}, esc_html($pr->{'path'})) . "</td>\n" .
 		      "<td>" . esc_html($pr->{'descr'}) . "</td>\n" .
 		      "<td><i>" . chop_str($pr->{'owner'}, 15) . "</i></td>\n";
 		print "<td class=\"". age_class($pr->{'commit'}{'age'}) . "\">" .
 		      $pr->{'commit'}{'age_string'} . "</td>\n" .
 		      "<td class=\"link\">" .
-		      $cgi->a({-href => "$my_uri?" . esc_param("p=$pr->{'path'};a=summary")}, "summary")   . " | " .
-		      $cgi->a({-href => "$my_uri?" . esc_param("p=$pr->{'path'};a=shortlog")}, "shortlog") . " | " .
-		      $cgi->a({-href => "$my_uri?" . esc_param("p=$pr->{'path'};a=log")}, "log") .
+		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"summary")}, "summary")   . " | " .
+		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"shortlog")}, "shortlog") . " | " .
+		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"log")}, "log") .
 		      "</td>\n" .
 		      "</tr>\n";
 	}
@@ -2036,11 +2038,11 @@ sub git_tree {
 	my $refs = git_get_references();
 	my $ref = format_ref_marker($refs, $hash_base);
 	git_header_html();
-	my $base_key = "";
+	my %base_key = ();
 	my $base = "";
 	my $have_blame = git_get_project_config_bool ('blame');
 	if (defined $hash_base && (my %co = parse_commit($hash_base))) {
-		$base_key = ";hb=$hash_base";
+		$base_key{hash_base} = $hash_base;
 		git_print_page_nav('tree','', $hash_base);
 		git_print_header_div('commit', esc_html($co{'title'}) . $ref, $hash_base);
 	} else {
@@ -2071,23 +2073,23 @@ sub git_tree {
 		print "<td class=\"mode\">" . mode_str($t_mode) . "</td>\n";
 		if ($t_type eq "blob") {
 			print "<td class=\"list\">" .
-			      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$t_hash$base_key;f=$base$t_name"), -class => "list"}, esc_html($t_name)) .
+			      $cgi->a({-href => href(action=>"blob", hash=>$t_hash, file_name=>"$base$t_name", %base_key), -class => "list"}, esc_html($t_name)) .
 			      "</td>\n" .
 			      "<td class=\"link\">" .
-			      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$t_hash$base_key;f=$base$t_name")}, "blob");
+			      $cgi->a({-href => href(action=>"blob", hash=>$t_hash, file_name=>"$base$t_name", %base_key)}, "blob");
 			if ($have_blame) {
-				print " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blame;h=$t_hash$base_key;f=$base$t_name")}, "blame");
+				print " | " . $cgi->a({-href => href(action=>"blame", hash=>$t_hash, file_name=>"$base$t_name", %base_key)}, "blame");
 			}
-			print " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=history;h=$t_hash;hb=$hash_base;f=$base$t_name")}, "history") .
-			      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob_plain;h=$t_hash;f=$base$t_name")}, "raw") .
+			print " | " . $cgi->a({-href => href(action=>"history", hash=>$t_hash, hash_base=>$hash_base, file_name=>"$base$t_name")}, "history") .
+			      " | " . $cgi->a({-href => href(action=>"blob_plain", hash=>$t_hash, file_name=>"$base$t_name")}, "raw") .
 			      "</td>\n";
 		} elsif ($t_type eq "tree") {
 			print "<td class=\"list\">" .
-			      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=tree;h=$t_hash$base_key;f=$base$t_name")}, esc_html($t_name)) .
+			      $cgi->a({-href => href(action=>"tree", hash=>$t_hash, file_name=>"$base$t_name", %base_key)}, esc_html($t_name)) .
 			      "</td>\n" .
 			      "<td class=\"link\">" .
-			      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=tree;h=$t_hash$base_key;f=$base$t_name")}, "tree") .
-			      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=history;hb=$hash_base;f=$base$t_name")}, "history") .
+			      $cgi->a({-href => href(action=>"tree", hash=>$t_hash, file_name=>"$base$t_name", %base_key)}, "tree") .
+			      " | " . $cgi->a({-href => href(action=>"history", hash_base=>$hash_base, file_name=>"$base$t_name")}, "history") .
 			      "</td>\n";
 		}
 		print "</tr>\n";
@@ -2276,7 +2278,7 @@ sub git_blobdiff {
 	git_header_html();
 	if (defined $hash_base && (my %co = parse_commit($hash_base))) {
 		my $formats_nav =
-			$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blobdiff_plain;h=$hash;hp=$hash_parent")}, "plain");
+			$cgi->a({-href => href(action=>"blobdiff_plain", hash=>$hash, hash_parent=>$hash_parent)}, "plain");
 		git_print_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
 		git_print_header_div('commit', esc_html($co{'title'}), $hash_base);
 	} else {
@@ -2287,9 +2289,9 @@ sub git_blobdiff {
 	git_print_page_path($file_name, "blob");
 	print "<div class=\"page_body\">\n" .
 	      "<div class=\"diff_info\">blob:" .
-	      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$hash_parent;hb=$hash_base;f=$file_name")}, $hash_parent) .
+	      $cgi->a({-href => href(action=>"blob", hash=>$hash_parent, hash_base=>$hash_base, file_name=>$file_name)}, $hash_parent) .
 	      " -> blob:" .
-	      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$hash;hb=$hash_base;f=$file_name")}, $hash) .
+	      $cgi->a({-href => href(action=>"blob", hash=>$hash, hash_base=>$hash_base, file_name=>$file_name)}, $hash) .
 	      "</div>\n";
 	git_diff_print($hash_parent, $file_name || $hash_parent, $hash, $file_name || $hash);
 	print "</div>";
@@ -2324,7 +2326,7 @@ sub git_commitdiff {
 	my $refs = git_get_references();
 	my $ref = format_ref_marker($refs, $co{'id'});
 	my $formats_nav =
-		$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commitdiff_plain;h=$hash;hp=$hash_parent")}, "plain");
+		$cgi->a({-href => href(action=>"commitdiff_plain", hash=>$hash, hash_parent=>$hash_parent)}, "plain");
 	git_header_html(undef, $expires);
 	git_print_page_nav('commitdiff','', $hash,$co{'tree'},$hash, $formats_nav);
 	git_print_header_div('commit', esc_html($co{'title'}) . $ref, $hash);
@@ -2367,22 +2369,22 @@ sub git_commitdiff {
 		my $file = validate_input(unquote($6));
 		if ($status eq "A") {
 			print "<div class=\"diff_info\">" . file_type($to_mode) . ":" .
-			      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$to_id;hb=$hash;f=$file")}, $to_id) . "(new)" .
+			      $cgi->a({-href => href(action=>"blob", hash=>$to_id, hash_base=>$hash, file_name=>$file)}, $to_id) . "(new)" .
 			      "</div>\n";
 			git_diff_print(undef, "/dev/null", $to_id, "b/$file");
 		} elsif ($status eq "D") {
 			print "<div class=\"diff_info\">" . file_type($from_mode) . ":" .
-			      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$from_id;hb=$hash_parent;f=$file")}, $from_id) . "(deleted)" .
+			      $cgi->a({-href => href(action=>"blob", hash=>$from_id, hash_base=>$hash_parent, file_name=>$file)}, $from_id) . "(deleted)" .
 			      "</div>\n";
 			git_diff_print($from_id, "a/$file", undef, "/dev/null");
 		} elsif ($status eq "M") {
 			if ($from_id ne $to_id) {
 				print "<div class=\"diff_info\">" .
 				      file_type($from_mode) . ":" .
-				      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$from_id;hb=$hash_parent;f=$file")}, $from_id) .
+				      $cgi->a({-href => href(action=>"blob", hash=>$from_id, hash_base=>$hash_parent, file_name=>$file)}, $from_id) .
 				      " -> " .
 				      file_type($to_mode) . ":" .
-				      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$to_id;hb=$hash;f=$file")}, $to_id);
+				      $cgi->a({-href => href(action=>"blob", hash=>$to_id, hash_base=>$hash, file_name=>$file)}, $to_id) .
 				print "</div>\n";
 				git_diff_print($from_id, "a/$file",  $to_id, "b/$file");
 			}
@@ -2544,7 +2546,7 @@ sub git_search {
 			print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
 			      "<td><i>" . esc_html(chop_str($co{'author_name'}, 15, 5)) . "</i></td>\n" .
 			      "<td>" .
-			      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$co{'id'}"), -class => "list"}, "<b>" . esc_html(chop_str($co{'title'}, 50)) . "</b><br/>");
+			      $cgi->a({-href => href(action=>"commit", hash=>$co{'id'}) -class => "list"}, "<b>" . esc_html(chop_str($co{'title'}, 50)) . "</b><br/>");
 			my $comment = $co{'comment'};
 			foreach my $line (@$comment) {
 				if ($line =~ m/^(.*)($searchtext)(.*)$/i) {
@@ -2559,8 +2561,8 @@ sub git_search {
 			}
 			print "</td>\n" .
 			      "<td class=\"link\">" .
-			      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$co{'id'}")}, "commit") .
-			      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=tree;h=$co{'tree'};hb=$co{'id'}")}, "tree");
+			      $cgi->a({-href => href(action=>"commit", hash=>$co{'id'})}, "commit") .
+			      " | " . $cgi->a({-href => href(action=>"tree", hash=>$co{'tree'}, hash_base=>$co{'id'})}, "tree");
 			print "</td>\n" .
 			      "</tr>\n";
 		}
@@ -2597,18 +2599,18 @@ sub git_search {
 					print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
 					      "<td><i>" . esc_html(chop_str($co{'author_name'}, 15, 5)) . "</i></td>\n" .
 					      "<td>" .
-					      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$co{'id'}"), -class => "list"}, "<b>" .
+					      $cgi->a({-href => href(action=>"commit", hash=>$co{'id'}), -class => "list"}, "<b>" .
 					      esc_html(chop_str($co{'title'}, 50)) . "</b><br/>");
 					while (my $setref = shift @files) {
 						my %set = %$setref;
-						print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$set{'id'};hb=$co{'id'};f=$set{'file'}"), class => "list"},
+						print $cgi->a({-href => href(action=>"blob", hash=>$set{'id'}, hash_base=>$co{'id'}, file_name=>$set{'file'}), class => "list"},
 						      "<span class=\"match\">" . esc_html($set{'file'}) . "</span>") .
 						      "<br/>\n";
 					}
 					print "</td>\n" .
 					      "<td class=\"link\">" .
-					      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$co{'id'}")}, "commit") .
-					      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=tree;h=$co{'tree'};hb=$co{'id'}")}, "tree");
+					      $cgi->a({-href => href(action=>"commit", hash=>$co{'id'})}, "commit") .
+					      " | " . $cgi->a({-href => href(action=>"tree", hash=>$co{'tree'}, hash_base=>$co{'id'})}, "tree");
 					print "</td>\n" .
 					      "</tr>\n";
 				}
@@ -2641,7 +2643,7 @@ sub git_shortlog {
 	my $next_link = '';
 	if ($#revlist >= (100 * ($page+1)-1)) {
 		$next_link =
-			$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=shortlog;h=$hash;pg=" . ($page+1)),
+			$cgi->a({-href => href(action=>"shortlog", hash=>$hash, page=>$page+1),
 			         -title => "Alt-n"}, "next");
 	}
 
-- 
1.4.2.rc2.gf055
