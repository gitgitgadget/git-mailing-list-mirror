From: Martin Waitz <tali@admingilde.org>
Subject: [PATCH] gitweb: consolidate action URL generation.
Date: Wed, 16 Aug 2006 00:24:30 +0200
Message-ID: <20060815222429.GD14459@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Aug 16 00:24:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GD7Kt-0004TS-5X
	for gcvg-git@gmane.org; Wed, 16 Aug 2006 00:24:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWHOWYc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Aug 2006 18:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbWHOWYc
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Aug 2006 18:24:32 -0400
Received: from agent.admingilde.org ([213.95.21.5]:29107 "EHLO
	mail.admingilde.org") by vger.kernel.org with ESMTP
	id S1750751AbWHOWYb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Aug 2006 18:24:31 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1GD7Ko-0000Zx-63
	for git@vger.kernel.org; Wed, 16 Aug 2006 00:24:30 +0200
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25490>

Use the href() function instead of string concatenation to generate
most URLs to our own CGI.
This is a work in progress, not everything has been converted yet.

Signed-off-by: Martin Waitz <tali@admingilde.org>
---
 gitweb/gitweb.perl |  171 ++++++++++++++++++++++++++--------------------------
 1 files changed, 84 insertions(+), 87 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 726dd66..3d171ae 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -384,7 +384,7 @@ sub format_log_line_html {
 	if ($line =~ m/([0-9a-fA-F]{40})/) {
 		my $hash_text = $1;
 		if (git_get_type($hash_text) eq "commit") {
-			my $link = $cgi->a({-class => "text", -href => "$my_uri?" . esc_param("p=$project;a=commit;h=$hash_text")}, $hash_text);
+			my $link = $cgi->a({-class => "text", -href => href(action=>"commit", hash=>$hash_text)}, $hash_text);
 			$line =~ s/$hash_text/$link/;
 		}
 	}
@@ -421,16 +421,15 @@ sub format_ref_marker {
 
 # format, perhaps shortened and with markers, title line
 sub format_subject_html {
-	my ($long, $short, $query, $extra) = @_;
+	my ($long, $short, $href, $extra) = @_;
 	$extra = '' unless defined($extra);
 
 	if (length($short) < length($long)) {
-		return $cgi->a({-href => "$my_uri?" . esc_param($query),
-		               -class => "list", -title => $long},
+		return $cgi->a({-href => $href, -class => "list",
+		                -title => $long},
 		       esc_html($short) . $extra);
 	} else {
-		return $cgi->a({-href => "$my_uri?" . esc_param($query),
-		               -class => "list"},
+		return $cgi->a({-href => $href, -class => "list"},
 		       esc_html($long)  . $extra);
 	}
 }
@@ -994,8 +993,7 @@ EOF
 	if (defined $project) {
 		printf('<link rel="alternate" title="%s log" '.
 		       'href="%s" type="application/rss+xml"/>'."\n",
-		       esc_param($project),
-		       esc_param("$my_uri?p=$project;a=rss"));
+		       esc_param($project), href(action=>"rss"));
 	}
 
 	print "</head>\n" .
@@ -1006,7 +1004,7 @@ EOF
 	      "</a>\n";
 	print $cgi->a({-href => esc_param($home_link)}, $home_link_str) . " / ";
 	if (defined $project) {
-		print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=summary")}, esc_html($project));
+		print $cgi->a({-href => href(action=>"summary")}, esc_html($project));
 		if (defined $action) {
 			print " / $action";
 		}
@@ -1043,7 +1041,7 @@ sub git_footer_html {
 		if (defined $descr) {
 			print "<div class=\"page_footer_text\">" . esc_html($descr) . "</div>\n";
 		}
-		print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=rss"), -class => "rss_logo"}, "RSS") . "\n";
+		print $cgi->a({-href => href(action=>"rss"), -class => "rss_logo"}, "RSS") . "\n";
 	} else {
 		print $cgi->a({-href => "$my_uri?" . esc_param("a=opml"), -class => "rss_logo"}, "OPML") . "\n";
 	}
@@ -1078,27 +1076,25 @@ sub git_print_page_nav {
 		@navs = grep { $_ ne $suppress } @navs;
 	}
 
-	my %arg = map { $_, ''} @navs;
+	my %arg = map { $_ => {action=>$_} } @navs;
 	if (defined $head) {
 		for (qw(commit commitdiff)) {
-			$arg{$_} = ";h=$head";
+			$arg{$_}{hash} = $head;
 		}
 		if ($current =~ m/^(tree | log | shortlog | commit | commitdiff | search)$/x) {
 			for (qw(shortlog log)) {
-				$arg{$_} = ";h=$head";
+				$arg{$_}{hash} = $head;
 			}
 		}
 	}
-	$arg{tree} .= ";h=$treehead" if defined $treehead;
-	$arg{tree} .= ";hb=$treebase" if defined $treebase;
+	$arg{tree}{hash} = $treehead if defined $treehead;
+	$arg{tree}{hash_base} = $treebase if defined $treebase;
 
 	print "<div class=\"page_nav\">\n" .
 		(join " | ",
-		 map { $_ eq $current
-					 ? $_
-					 : $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=$_$arg{$_}")}, "$_")
-				 }
-		 @navs);
+		 map { $_ eq $current ?
+		       $_ : $cgi->a({-href => href(%{$arg{$_}})}, "$_")
+		 } @navs);
 	print "<br/>\n$extra<br/>\n" .
 	      "</div>\n";
 }
@@ -1109,14 +1105,14 @@ sub format_paging_nav {
 
 
 	if ($hash ne $head || $page) {
-		$paging_nav .= $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=$action")}, "HEAD");
+		$paging_nav .= $cgi->a({-href => href(action=>$action)}, "HEAD");
 	} else {
 		$paging_nav .= "HEAD";
 	}
 
 	if ($page > 0) {
 		$paging_nav .= " &sdot; " .
-			$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=$action;h=$hash;pg=" . ($page-1)),
+			$cgi->a({-href => href(action=>$action, hash=>$hash, page=>$page-1),
 			         -accesskey => "p", -title => "Alt-p"}, "prev");
 	} else {
 		$paging_nav .= " &sdot; prev";
@@ -1124,7 +1120,7 @@ sub format_paging_nav {
 
 	if ($nrevs >= (100 * ($page+1)-1)) {
 		$paging_nav .= " &sdot; " .
-			$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=$action;h=$hash;pg=" . ($page+1)),
+			$cgi->a({-href => href(action=>$action, hash=>$hash, page=>$page+1),
 			         -accesskey => "n", -title => "Alt-n"}, "next");
 	} else {
 		$paging_nav .= " &sdot; next";
@@ -1138,15 +1134,16 @@ ## functions printing or outputting HTML
 
 sub git_print_header_div {
 	my ($action, $title, $hash, $hash_base) = @_;
-	my $rest = '';
+	my %args = ();
 
-	$rest .= ";h=$hash" if $hash;
-	$rest .= ";hb=$hash_base" if $hash_base;
+	$args{action} = $action;
+	$args{hash} = $hash if $hash;
+	$args{hash_base} = $hash_base if $hash_base;
 
 	print "<div class=\"header\">\n" .
-	      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=$action$rest"),
-	               -class => "title"}, $title ? $title : $action) . "\n" .
-	      "</div>\n";
+	      $cgi->a({-href => href(%args), -class => "title"},
+	      $title ? $title : $action) .
+	      "\n</div>\n";
 }
 
 sub git_print_page_path {
@@ -1157,7 +1154,7 @@ sub git_print_page_path {
 		print "<div class=\"page_path\"><b>/</b></div>\n";
 	} elsif (defined $type && $type eq 'blob') {
 		print "<div class=\"page_path\"><b>" .
-			$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob_plain;f=$file_name")}, esc_html($name)) . "</b><br/></div>\n";
+			$cgi->a({-href => href(action=>"blob_plain", file_name=>$file_name)}, esc_html($name)) . "</b><br/></div>\n";
 	} else {
 		print "<div class=\"page_path\"><b>" . esc_html($name) . "</b><br/></div>\n";
 	}
@@ -1204,22 +1201,22 @@ sub git_difftree_body {
 				$mode_chng = sprintf(" with mode: %04o", (oct $to_mode) & 0777);
 			}
 			print "<td>" .
-			      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$to_id;hb=$hash;f=$file"),
+			      $cgi->a({-href => href(action=>"blob", hash=>$to_id, hash_base=>$hash, file_name=>$file),
 			              -class => "list"}, esc_html($file)) .
 			      "</td>\n" .
 			      "<td><span class=\"file_status new\">[new " . file_type($to_mode) . "$mode_chng]</span></td>\n" .
 			      "<td class=\"link\">" .
-			      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$to_id;hb=$hash;f=$file")}, "blob") .
+			      $cgi->a({-href => href(action=>"blob", hash=>$to_id, hash_base=>$hash, file_name=>$file)}, "blob") .
 			      "</td>\n";
 
 		} elsif ($status eq "D") { # deleted
 			print "<td>" .
-			      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$from_id;hb=$parent;f=$file"),
+			      $cgi->a({-href => href(action=>"blob", hash=>$from_id, hash_base=>$parent, file_name=>$file),
 			               -class => "list"}, esc_html($file)) . "</td>\n" .
 			      "<td><span class=\"file_status deleted\">[deleted " . file_type($from_mode). "]</span></td>\n" .
 			      "<td class=\"link\">" .
-			      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$from_id;hb=$parent;f=$file")}, "blob") . " | " .
-			      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=history;hb=$parent;f=$file")}, "history") .
+			      $cgi->a({-href => href(action=>"blob", hash=>$from_id, hash_base=>$parent, file_name=>$file)}, "blob") . " | " .
+			      $cgi->a({-href => href(action=>"history", hash_base=>$parent, file_name=>$file)}, "history") .
 			      "</td>\n"
 
 		} elsif ($status eq "M" || $status eq "T") { # modified, or type changed
@@ -1240,20 +1237,20 @@ sub git_difftree_body {
 			}
 			print "<td>";
 			if ($to_id ne $from_id) { # modified
-				print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blobdiff;h=$to_id;hp=$from_id;hb=$hash;f=$file"),
+				print $cgi->a({-href => href(action=>"blobdiff", hash=>$to_id, hash_parent=>$from_id, hash_base=>$hash, file_name=>$file),
 				              -class => "list"}, esc_html($file));
 			} else { # mode changed
-				print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$to_id;hb=$hash;f=$file"),
+				print $cgi->a({-href => href(action=>"blob", hash=>$to_id, hash_base=>$hash, file_name=>$file),
 				              -class => "list"}, esc_html($file));
 			}
 			print "</td>\n" .
 			      "<td>$mode_chnge</td>\n" .
 			      "<td class=\"link\">" .
-			      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$to_id;hb=$hash;f=$file")}, "blob");
+				$cgi->a({-href => href(action=>"blob", hash=>$to_id, hash_base=>$hash, file_name=>$file)}, "blob");
 			if ($to_id ne $from_id) { # modified
-				print " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blobdiff;h=$to_id;hp=$from_id;hb=$hash;f=$file")}, "diff");
+				print $cgi->a({-href => href(action=>"blobdiff", hash=>$to_id, hash_parent=>$from_id, hash_base=>$hash, file_name=>$file)}, "diff");
 			}
-			print " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=history;hb=$hash;f=$file")}, "history") . "\n";
+			print " | " . $cgi->a({-href => href(action=>"history", hash_base=>$hash, file_name=>$file)}, "history") . "\n";
 			print "</td>\n";
 
 		} elsif ($status eq "R") { # renamed
@@ -1263,14 +1260,14 @@ sub git_difftree_body {
 				$mode_chng = sprintf(", mode: %04o", (oct $to_mode) & 0777);
 			}
 			print "<td>" .
-			      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$to_id;hb=$hash;f=$to_file"),
+			      $cgi->a({-href => href(action=>"blob", hash=>$to_id, hash_base=>$hash, file_name=>$to_file),
 			              -class => "list"}, esc_html($to_file)) . "</td>\n" .
 			      "<td><span class=\"file_status moved\">[moved from " .
-			      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$from_id;hb=$parent;f=$from_file"),
+			      $cgi->a({-href => href(action=>"blob", hash=>$from_id, hash_base=>$parent, file_name=>$from_file),
 			              -class => "list"}, esc_html($from_file)) .
 			      " with " . (int $similarity) . "% similarity$mode_chng]</span></td>\n" .
 			      "<td class=\"link\">" .
-			      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$to_id;hb=$hash;f=$to_file")}, "blob");
+			      $cgi->a({-href => href(action=>"blob", hash=>$to_id, hash_base=>$hash, file_name=>$to_file)}, "blob");
 			if ($to_id ne $from_id) {
 				print " | " .
 				      $cgi->a({-href => "$my_uri?" .
@@ -1285,14 +1282,14 @@ sub git_difftree_body {
 				$mode_chng = sprintf(", mode: %04o", (oct $to_mode) & 0777);
 			}
 			print "<td>" .
-			      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$to_id;hb=$hash;f=$to_file"),
+			      $cgi->a({-href => href(action=>"blob", hash=>$to_id, hash_base=>$hash, file_name=>$to_file),
 			              -class => "list"}, esc_html($to_file)) . "</td>\n" .
 			      "<td><span class=\"file_status copied\">[copied from " .
-			      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$from_id;hb=$parent;f=$from_file"),
+			      $cgi->a({-href => href(action=>"blob", hash=>$from_id, hash_base=>$parent, file_name=>$from_file),
 			              -class => "list"}, esc_html($from_file)) .
 			      " with " . (int $similarity) . "% similarity$mode_chng]</span></td>\n" .
 			      "<td class=\"link\">" .
-			      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$to_id;hb=$hash;f=$to_file")}, "blob");
+			      $cgi->a({-href => href(action=>"blob", hash=>$to_id, hash_base=>$hash, file_name=>$to_file)}, "blob");
 			if ($to_id ne $from_id) {
 				print " | " .
 				      $cgi->a({-href => "$my_uri?" .
@@ -1328,11 +1325,11 @@ sub git_shortlog_body {
 		print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
 		      "<td><i>" . esc_html(chop_str($co{'author_name'}, 10)) . "</i></td>\n" .
 		      "<td>";
-		print format_subject_html($co{'title'}, $co{'title_short'}, "p=$project;a=commit;h=$commit", $ref);
+		print format_subject_html($co{'title'}, $co{'title_short'}, href(action=>"commit", hash=>$commit), $ref);
 		print "</td>\n" .
 		      "<td class=\"link\">" .
-		      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$commit")}, "commit") . " | " .
-		      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commitdiff;h=$commit")}, "commitdiff") .
+		      $cgi->a({-href => href(action=>"commit", hash=>$commit)}, "commit") . " | " .
+		      $cgi->a({-href => href(action=>"commitdiff", hash=>$commit)}, "commitdiff") .
 		      "</td>\n" .
 		      "</tr>\n";
 	}
@@ -1374,12 +1371,12 @@ sub git_history_body {
 		      "<td><i>" . esc_html(chop_str($co{'author_name'}, 15, 3)) . "</i></td>\n" .
 		      "<td>";
 		# originally git_history used chop_str($co{'title'}, 50)
-		print format_subject_html($co{'title'}, $co{'title_short'}, "p=$project;a=commit;h=$commit", $ref);
+		print format_subject_html($co{'title'}, $co{'title_short'}, href(action=>"commit", hash=>$commit), $ref);
 		print "</td>\n" .
 		      "<td class=\"link\">" .
-		      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$commit")}, "commit") . " | " .
-		      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commitdiff;h=$commit")}, "commitdiff") . " | " .
-		      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=$ftype;hb=$commit;f=$file_name")}, $ftype);
+		      $cgi->a({-href => href(action=>"commit", hash=>$commit)}, "commit") . " | " .
+		      $cgi->a({-href => href(action=>"commitdiff", hash=>$commit)}, "commitdiff") . " | " .
+		      $cgi->a({-href => href(action=>$ftype, hash_base=>$commit, file_name=>$file_name)}, $ftype);
 
 		if ($ftype eq 'blob') {
 			my $blob_current = git_get_hash_by_path($hash_base, $file_name);
@@ -1387,7 +1384,7 @@ sub git_history_body {
 			if (defined $blob_current && defined $blob_parent &&
 					$blob_current ne $blob_parent) {
 				print " | " .
-					$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blobdiff;h=$blob_current;hp=$blob_parent;hb=$commit;f=$file_name")},
+					$cgi->a({-href => href(action=>"blobdiff", hash=>$blob_current, hash_parent=>$blob_parent, hash_base=>$commit, file_name=>$file_name)},
 					        "diff to current");
 			}
 		}
@@ -1427,28 +1424,28 @@ sub git_tags_body {
 		$alternate ^= 1;
 		print "<td><i>$tag{'age'}</i></td>\n" .
 		      "<td>" .
-		      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=$tag{'reftype'};h=$tag{'refid'}"),
+		      $cgi->a({-href => href(action=>$tag{'reftype'}, hash=>$tag{'refid'}),
 		               -class => "list"}, "<b>" . esc_html($tag{'name'}) . "</b>") .
 		      "</td>\n" .
 		      "<td>";
 		if (defined $comment) {
-			print format_subject_html($comment, $comment_short, "p=$project;a=tag;h=$tag{'id'}");
+			print format_subject_html($comment, $comment_short, href(action=>"tag", hash=>$tag{'id'}));
 		}
 		print "</td>\n" .
 		      "<td class=\"selflink\">";
 		if ($tag{'type'} eq "tag") {
-			print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=tag;h=$tag{'id'}")}, "tag");
+			print $cgi->a({-href => href(action=>"tag", hash=>$tag{'id'})}, "tag");
 		} else {
 			print "&nbsp;";
 		}
 		print "</td>\n" .
 		      "<td class=\"link\">" . " | " .
-		      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=$tag{'reftype'};h=$tag{'refid'}")}, $tag{'reftype'});
+		      $cgi->a({-href => href(action=>$tag{'reftype'}, hash=>$tag{'refid'})}, $tag{'reftype'});
 		if ($tag{'reftype'} eq "commit") {
-			print " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=shortlog;h=$tag{'name'}")}, "shortlog") .
-			      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=log;h=$tag{'refid'}")}, "log");
+			print " | " . $cgi->a({-href => href(action=>"shortlog", hash=>$tag{'name'})}, "shortlog") .
+			      " | " . $cgi->a({-href => href(action=>"log", hash=>$tag{'refid'})}, "log");
 		} elsif ($tag{'reftype'} eq "blob") {
-			print " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob_plain;h=$tag{'refid'}")}, "raw");
+			print " | " . $cgi->a({-href => href(action=>"blob_plain", hash=>$tag{'refid'})}, "raw");
 		}
 		print "</td>\n" .
 		      "</tr>";
@@ -1481,12 +1478,12 @@ sub git_heads_body {
 		$alternate ^= 1;
 		print "<td><i>$tag{'age'}</i></td>\n" .
 		      ($tag{'id'} eq $head ? "<td class=\"current_head\">" : "<td>") .
-		      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=shortlog;h=$tag{'name'}"),
+		      $cgi->a({-href => href(action=>"shortlog", hash=>$tag{'name'}),
 		               -class => "list"}, "<b>" . esc_html($tag{'name'}) . "</b>") .
 		      "</td>\n" .
 		      "<td class=\"link\">" .
-		      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=shortlog;h=$tag{'name'}")}, "shortlog") . " | " .
-		      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=log;h=$tag{'name'}")}, "log") .
+		      $cgi->a({-href => href(action=>"shortlog", hash=>$tag{'name'})}, "shortlog") . " | " .
+		      $cgi->a({-href => href(action=>"log", hash=>$tag{'name'})}, "log") .
 		      "</td>\n" .
 		      "</tr>";
 	}
@@ -1704,20 +1701,20 @@ sub git_summary {
 	close $fd;
 	git_print_header_div('shortlog');
 	git_shortlog_body(\@revlist, 0, 15, $refs,
-	                  $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=shortlog")}, "..."));
+	                  $cgi->a({-href => href(action=>"shortlog")}, "..."));
 
 	my $taglist = git_get_refs_list("refs/tags");
 	if (defined @$taglist) {
 		git_print_header_div('tags');
 		git_tags_body($taglist, 0, 15,
-		              $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=tags")}, "..."));
+		              $cgi->a({-href => href(action=>"tags")}, "..."));
 	}
 
 	my $headlist = git_get_refs_list("refs/heads");
 	if (defined @$headlist) {
 		git_print_header_div('heads');
 		git_heads_body($headlist, $head, 0, 15,
-		               $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=heads")}, "..."));
+		               $cgi->a({-href => href(action=>"heads")}, "..."));
 	}
 
 	git_footer_html();
@@ -1733,8 +1730,8 @@ sub git_tag {
 	      "<table cellspacing=\"0\">\n" .
 	      "<tr>\n" .
 	      "<td>object</td>\n" .
-	      "<td>" . $cgi->a({-class => "list", -href => "$my_uri?" . esc_param("p=$project;a=$tag{'type'};h=$tag{'object'}")}, $tag{'object'}) . "</td>\n" .
-	      "<td class=\"link\">" . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=$tag{'type'};h=$tag{'object'}")}, $tag{'type'}) . "</td>\n" .
+	      "<td>" . $cgi->a({-class => "list", -href => href(action=>$tag{'type'}, hash=>$tag{'object'})}, $tag{'object'}) . "</td>\n" .
+	      "<td class=\"link\">" . $cgi->a({-href => href(action=>$tag{'type'}, hash=>$tag{'object'})}, $tag{'type'}) . "</td>\n" .
 	      "</tr>\n";
 	if (defined($tag{'author'})) {
 		my %ad = parse_date($tag{'epoch'}, $tag{'tz'});
@@ -1773,8 +1770,8 @@ sub git_blame2 {
 		or die_error(undef, "Open git-blame failed");
 	git_header_html();
 	my $formats_nav =
-		$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$hash;hb=$hash_base;f=$file_name")}, "blob") .
-		" | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blame;f=$file_name")}, "head");
+		$cgi->a({-href => href(action=>"blobl", hash=>$hash, hash_base=>$hash_base, file_name=>$file_name)}, "blob") .
+		" | " . $cgi->a({-href => href(action=>"blame", file_name=>$file_name)}, "head");
 	git_print_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
 	git_print_header_div('commit', esc_html($co{'title'}), $hash_base);
 	git_print_page_path($file_name, $ftype);
@@ -1800,7 +1797,7 @@ sub git_blame2 {
 		}
 		print "<tr class=\"$rev_color[$current_color]\">\n";
 		print "<td class=\"sha1\">" .
-			$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$full_rev;f=$file_name")}, esc_html($rev)) . "</td>\n";
+			$cgi->a({-href => href(action=>"commit", hash=>$full_rev, file_name=>$file_name)}, esc_html($rev)) . "</td>\n";
 		print "<td class=\"linenr\"><a id=\"l$lineno\" href=\"#l$lineno\" class=\"linenr\">" . esc_html($lineno) . "</a></td>\n";
 		print "<td class=\"pre\">" . esc_html($data) . "</td>\n";
 		print "</tr>\n";
@@ -1827,8 +1824,8 @@ sub git_blame {
 		or die_error(undef, "Open git-annotate failed");
 	git_header_html();
 	my $formats_nav =
-		$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$hash;hb=$hash_base;f=$file_name")}, "blob") .
-		" | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blame;f=$file_name")}, "head");
+		$cgi->a({-href => href(action=>"blobl", hash=>$hash, hash_base=>$hash_base, file_name=>$file_name)}, "blob") .
+		" | " . $cgi->a({-href => href(action=>"blame", file_name=>$file_name)}, "head");
 	git_print_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
 	git_print_header_div('commit', esc_html($co{'title'}), $hash_base);
 	git_print_page_path($file_name, 'blob');
@@ -1883,7 +1880,7 @@ HTML
 
 		print <<HTML;
   <tr class="$line_class[$line_class_num]">
-    <td class="sha1"><a href="$my_uri?${\esc_param ("p=$project;a=commit;h=$long_rev")}" class="text">$short_rev..</a></td>
+    <td class="sha1"><a href="${\href (action=>"commit", hash=>$long_rev)}" class="text">$short_rev..</a></td>
     <td class="$age_class">$age_str</td>
     <td>$author</td>
     <td class="linenr"><a id="$lineno" href="#$lineno" class="linenr">$lineno</a></td>
@@ -1979,13 +1976,13 @@ sub git_blob {
 	if (defined $hash_base && (my %co = parse_commit($hash_base))) {
 		if (defined $file_name) {
 			if ($have_blame) {
-				$formats_nav .= $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blame;h=$hash;hb=$hash_base;f=$file_name")}, "blame") . " | ";
+				$formats_nav .= $cgi->a({-href => href(action=>"blame", hash=>$hash, hash_base=>$hash_base, file_name=>$file_name)}, "blame") . " | ";
 			}
 			$formats_nav .=
-				$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob_plain;h=$hash;f=$file_name")}, "plain") .
-				" | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;hb=HEAD;f=$file_name")}, "head");
+				$cgi->a({-href => href(action=>"blob_plain", hash=>$hash, file_name=>$file_name)}, "plain") .
+				" | " . $cgi->a({-href => href(action=>"blob", hash_base=>"HEAD", file_name=>$file_name)}, "head");
 		} else {
-			$formats_nav .= $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob_plain;h=$hash")}, "plain");
+			$formats_nav .= $cgi->a({-href => href(action=>"blob_plain", hash=>$hash)}, "plain");
 		}
 		git_print_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
 		git_print_header_div('commit', esc_html($co{'title'}), $hash_base);
@@ -2129,8 +2126,8 @@ sub git_log {
 		               $commit);
 		print "<div class=\"title_text\">\n" .
 		      "<div class=\"log_link\">\n" .
-		      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$commit")}, "commit") .
-		      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commitdiff;h=$commit")}, "commitdiff") .
+		      $cgi->a({-href => href(action=>"commit", hash=>$commit)}, "commit") .
+		      " | " . $cgi->a({-href => href(action=>"commitdiff", hash=>$commit)}, "commitdiff") .
 		      "<br/>\n" .
 		      "</div>\n" .
 		      "<i>" . esc_html($co{'author_name'}) .  " [$ad{'rfc2822'}]</i><br/>\n" .
@@ -2187,7 +2184,7 @@ sub git_commit {
 	my $formats_nav = '';
 	if (defined $file_name && defined $co{'parent'}) {
 		my $parent = $co{'parent'};
-		$formats_nav .= $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blame;hb=$parent;f=$file_name")}, "blame");
+		$formats_nav .= $cgi->a({-href => href(action=>"blame", hash_parent=>$parent, file_name=>$file_name)}, "blame");
 	}
 	git_header_html(undef, $expires);
 	git_print_page_nav('commit', defined $co{'parent'} ? '' : 'commitdiff',
@@ -2217,19 +2214,19 @@ sub git_commit {
 	print "<tr>" .
 	      "<td>tree</td>" .
 	      "<td class=\"sha1\">" .
-	      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=tree;h=$co{'tree'};hb=$hash"), class => "list"}, $co{'tree'}) .
+	      $cgi->a({-href => href(action=>"tree", hash=>$co{'tree'}, hash_base=>$hash), class => "list"}, $co{'tree'}) .
 	      "</td>" .
-	      "<td class=\"link\">" . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=tree;h=$co{'tree'};hb=$hash")}, "tree") .
+	      "<td class=\"link\">" . $cgi->a({-href => href(action=>"tree", hash=>$co{'tree'}, hash_base=>$hash)}, "tree") .
 	      "</td>" .
 	      "</tr>\n";
 	my $parents = $co{'parents'};
 	foreach my $par (@$parents) {
 		print "<tr>" .
 		      "<td>parent</td>" .
-		      "<td class=\"sha1\">" . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$par"), class => "list"}, $par) . "</td>" .
+		      "<td class=\"sha1\">" . $cgi->a({-href => href(action=>"commit", hash=>$par), class => "list"}, $par) . "</td>" .
 		      "<td class=\"link\">" .
-		      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$par")}, "commit") .
-		      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commitdiff;h=$hash;hp=$par")}, "commitdiff") .
+		      $cgi->a({-href => href(action=>"commit", hash=>$par)}, "commit") .
+		      " | " . $cgi->a({-href => href(action=>"commitdiff", hash=>$hash, hash_parent=>$par)}, "commitdiff") .
 		      "</td>" .
 		      "</tr>\n";
 	}
-- 
1.4.2.rc2.gf055

-- 
Martin Waitz
