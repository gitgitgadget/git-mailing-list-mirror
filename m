From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: style done with stylesheet
Date: Tue, 20 Jun 2006 14:58:12 +0000 (UTC)
Message-ID: <11508154583352-git-send-email-jnareb@gmail.com>
Reply-To: Jakub Narebski <jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 20 16:58:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fshfp-0004x6-JP
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 16:57:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbWFTO5q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Jun 2006 10:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbWFTO5q
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jun 2006 10:57:46 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:4796 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S1751259AbWFTO5p (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jun 2006 10:57:45 -0400
Received: from front.fuw.edu.pl (front.fuw.edu.pl [193.0.83.59])
	by mail.fuw.edu.pl (8.13.6/8.13.6) with ESMTP id k5KEvJOl013258
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 20 Jun 2006 16:57:19 +0200
Received: from front.fuw.edu.pl (IDENT:10582@localhost [127.0.0.1])
	by front.fuw.edu.pl (8.13.3/8.12.4) with ESMTP id k5KEvc7o011890;
	Tue, 20 Jun 2006 16:57:38 +0200
Received: (from jnareb@localhost)
	by front.fuw.edu.pl (8.13.3/8.12.4/Submit) id k5KEvchZ011889;
	Tue, 20 Jun 2006 16:57:38 +0200
To: git@vger.kernel.org
Date: wto, 20 cze 2006 16:57:38 +0200
X-Mailer: git-send-email 1.3.0
X-Scanned-By: MIMEDefang 2.56 on 193.0.80.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22205>

Replace (almost) all 'style' attributes with 'class' attribute
and adding rule to CSS file. Some tables use CSS for styling
instead of legacy styling attributes.

---
This patch needs readable CSS style file gitweb/gitweb.css
introduced in previous patch.

It applies on top of next.

 gitweb/gitweb.cgi |   80 ++++++++++++++++++++++--------------------
 gitweb/gitweb.css |  101 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 136 insertions(+), 45 deletions(-)

eaa8afc21044fcce134777b35bdcfb3e97f8ab8f
diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index 1b254df..89224e6 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -252,6 +252,19 @@ sub unquote {
 	return $str;
 }
 
+# CSS class for given age value (in seconds)
+sub age_class {
+	my $age = shift;
+
+	if ($age < 60*60*2) {
+		return "age0";
+	} elsif ($age < 60*60*24*2) {
+		return "age1";
+	} else {
+		return "age2";
+	}
+}
+
 sub git_header_html {
 	my $status = shift || "200 OK";
 	my $expires = shift;
@@ -600,13 +613,13 @@ sub git_diff_print {
 		while (my $line = <$fd>) {
 			chomp($line);
 			my $char = substr($line, 0, 1);
-			my $color = "";
+			my $diff_class = "";
 			if ($char eq '+') {
-				$color = " style=\"color:#008800;\"";
+				$diff_class = " add";
 			} elsif ($char eq "-") {
-				$color = " style=\"color:#cc0000;\"";
+				$diff_class = " rem";
 			} elsif ($char eq "@") {
-				$color = " style=\"color:#990099;\"";
+				$diff_class = " chunk_header";
 			} elsif ($char eq "\\") {
 				# skip errors
 				next;
@@ -617,7 +630,7 @@ sub git_diff_print {
 					$line =~ s/\t/$spaces/;
 				}
 			}
-			print "<div class=\"pre\"$color>" . esc_html($line) . "</div>\n";
+			print "<div class=\"diff$diff_class\">" . esc_html($line) . "</div>\n";
 		}
 	}
 	close $fd;
@@ -849,7 +862,7 @@ sub git_project_list {
 		close $fd;
 		print "</div>\n";
 	}
-	print "<table cellspacing=\"0\">\n" .
+	print "<table class=\"project_list\">\n" .
 	      "<tr>\n";
 	if (!defined($order) || (defined($order) && ($order eq "project"))) {
 		@projects = sort {$a->{'path'} cmp $b->{'path'}} @projects;
@@ -888,15 +901,7 @@ sub git_project_list {
 		print "<td>" . $cgi->a({-href => "$my_uri?" . esc_param("p=$pr->{'path'};a=summary"), -class => "list"}, esc_html($pr->{'path'})) . "</td>\n" .
 		      "<td>$pr->{'descr'}</td>\n" .
 		      "<td><i>" . chop_str($pr->{'owner'}, 15) . "</i></td>\n";
-		my $colored_age;
-		if ($pr->{'commit'}{'age'} < 60*60*2) {
-			$colored_age = "<span style =\"color: #009900;\"><b><i>$pr->{'commit'}{'age_string'}</i></b></span>";
-		} elsif ($pr->{'commit'}{'age'} < 60*60*24*2) {
-			$colored_age = "<span style =\"color: #009900;\"><i>$pr->{'commit'}{'age_string'}</i></span>";
-		} else {
-			$colored_age = "<i>$pr->{'commit'}{'age_string'}</i>";
-		}
-		print "<td>$colored_age</td>\n" .
+		print "<td class=\"". age_class($pr->{'commit'}{'age'}) . "\">" . $pr->{'commit'}{'age_string'} . "</td>\n" .
 		      "<td class=\"link\">" .
 		      $cgi->a({-href => "$my_uri?" . esc_param("p=$pr->{'path'};a=summary")}, "summary") .
 		      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$pr->{'path'};a=shortlog")}, "shortlog") .
@@ -1240,7 +1245,7 @@ sub git_blame {
 	print "<div class=\"page_path\"><b>" . esc_html($file_name) . "</b></div>\n";
 	print "<div class=\"page_body\">\n";
 	print <<HTML;
-<table style="border-collapse: collapse;">
+<table class="blame">
   <tr>
     <th>Commit</th>
     <th>Age</th>
@@ -1261,7 +1266,7 @@ HTML
 		my $data;
 		my $age;
 		my $age_str;
-		my $age_style;
+		my $age_class;
 
 		chomp $line;
 		$line_class_num = ($line_class_num + 1) % $line_class_len;
@@ -1273,16 +1278,14 @@ HTML
 			$lineno   = $4;
 			$data     = $5;
 		} else {
-			print qq(  <tr><td colspan="5" style="color: red; background-color: yellow;">Unable to parse: $line</td></tr>\n);
+			print qq(  <tr><td colspan="5" class="error">Unable to parse: $line</td></tr>\n);
 			next;
 		}
 		$short_rev  = substr ($long_rev, 0, 8);
 		$age        = time () - $time;
 		$age_str    = age_string ($age);
 		$age_str    =~ s/ /&nbsp;/g;
-		$age_style  = 'font-style: italic;';
-		$age_style .= ' color: #009900; background: transparent;' if ($age < 60*60*24*2);
-		$age_style .= ' font-weight: bold;' if ($age < 60*60*2);
+		$age_class  = age_class($age);
 		$author     = esc_html ($author);
 		$author     =~ s/ /&nbsp;/g;
 		# escape tabs
@@ -1293,15 +1296,14 @@ HTML
 			}
 		}
 		$data = esc_html ($data);
-		$data =~ s/ /&nbsp;/g;
 
 		print <<HTML;
   <tr class="$line_class[$line_class_num]">
-    <td style="font-family: monospace;"><a href="$my_uri?${\esc_param ("p=$project;a=commit;h=$long_rev")}" class="text">$short_rev..</a></td>
-    <td style="$age_style">$age_str</td>
+    <td class="sha1"><a href="$my_uri?${\esc_param ("p=$project;a=commit;h=$long_rev")}" class="text">$short_rev..</a></td>
+    <td class="$age_class">$age_str</td>
     <td>$author</td>
-    <td style="text-align: right;"><a id="$lineno" href="#$lineno" class="linenr">$lineno</a></td>
-    <td style="font-family: monospace;">$data</td>
+    <td class="linenr"><a id="$lineno" href="#$lineno" class="linenr">$lineno</a></td>
+    <td class="pre">$data</td>
   </tr>
 HTML
 	} # while (my $line = <$fd>)
@@ -1646,7 +1648,7 @@ sub git_tree {
 			print "<tr class=\"light\">\n";
 		}
 		$alternate ^= 1;
-		print "<td style=\"font-family:monospace\">" . mode_str($t_mode) . "</td>\n";
+		print "<td class=\"mode\">" . mode_str($t_mode) . "</td>\n";
 		if ($t_type eq "blob") {
 			print "<td class=\"list\">" .
 			      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$t_hash$base_key;f=$base$t_name"), -class => "list"}, esc_html($t_name)) .
@@ -1912,7 +1914,7 @@ sub git_commit {
 	      "<tr>" .
 	      "<td></td><td> $ad{'rfc2822'}";
 	if ($ad{'hour_local'} < 6) {
-		printf(" (<span style=\"color: #cc0000;\">%02d:%02d</span> %s)", $ad{'hour_local'}, $ad{'minute_local'}, $ad{'tz_local'});
+		printf(" (<span class=\"atnight\">%02d:%02d</span> %s)", $ad{'hour_local'}, $ad{'minute_local'}, $ad{'tz_local'});
 	} else {
 		printf(" (%02d:%02d %s)", $ad{'hour_local'}, $ad{'minute_local'}, $ad{'tz_local'});
 	}
@@ -1920,10 +1922,10 @@ sub git_commit {
 	      "</tr>\n";
 	print "<tr><td>committer</td><td>" . esc_html($co{'committer'}) . "</td></tr>\n";
 	print "<tr><td></td><td> $cd{'rfc2822'}" . sprintf(" (%02d:%02d %s)", $cd{'hour_local'}, $cd{'minute_local'}, $cd{'tz_local'}) . "</td></tr>\n";
-	print "<tr><td>commit</td><td style=\"font-family:monospace\">$co{'id'}</td></tr>\n";
+	print "<tr><td>commit</td><td class=\"sha1\">$co{'id'}</td></tr>\n";
 	print "<tr>" .
 	      "<td>tree</td>" .
-	      "<td style=\"font-family:monospace\">" .
+	      "<td class=\"sha1\">" .
 	      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=tree;h=$co{'tree'};hb=$hash"), class => "list"}, $co{'tree'}) .
 	      "</td>" .
 	      "<td class=\"link\">" . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=tree;h=$co{'tree'};hb=$hash")}, "tree") .
@@ -1933,7 +1935,7 @@ sub git_commit {
 	foreach my $par (@$parents) {
 		print "<tr>" .
 		      "<td>parent</td>" .
-		      "<td style=\"font-family:monospace\">" . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$par"), class => "list"}, $par) . "</td>" .
+		      "<td class=\"sha1\">" . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$par"), class => "list"}, $par) . "</td>" .
 		      "<td class=\"link\">" .
 		      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$par")}, "commit") .
 		      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commitdiff;h=$hash;hp=$par")}, "commitdiff") .
@@ -1958,7 +1960,7 @@ sub git_commit {
 		}
 		if ($line =~ m/^ *(signed[ \-]off[ \-]by[ :]|acked[ \-]by[ :]|cc[ :])/i) {
 			$signed = 1;
-			print "<span style=\"color: #888888\">" . esc_html($line) . "</span><br/>\n";
+			print "<span class=\"signoff\">" . esc_html($line) . "</span><br/>\n";
 		} else {
 			$signed = 0;
 			print format_log_line_html($line) . "<br/>\n";
@@ -1970,7 +1972,7 @@ sub git_commit {
 		print(($#difftree + 1) . " files changed:\n");
 	}
 	print "</div>\n";
-	print "<table cellspacing=\"0\">\n";
+	print "<table class=\"diff_tree\">\n";
 	my $alternate = 0;
 	foreach my $line (@difftree) {
 		# ':100644 100644 03b218260e99b78c6df0ed378e59ed9205ccc96d 3b93d5e7cc7f7dd4ebed13a5cc1a4ad976fc94d8 M      ls-files.c'
@@ -1998,12 +2000,12 @@ sub git_commit {
 			}
 			print "<td>" .
 			      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$to_id;hb=$hash;f=$file"), -class => "list"}, esc_html($file)) . "</td>\n" .
-			      "<td><span style=\"color: #008000;\">[new " . file_type($to_mode) . "$mode_chng]</span></td>\n" .
+			      "<td><span class=\"file_status new\">[new " . file_type($to_mode) . "$mode_chng]</span></td>\n" .
 			      "<td class=\"link\">" . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$to_id;hb=$hash;f=$file")}, "blob") . "</td>\n";
 		} elsif ($status eq "D") {
 			print "<td>" .
 			      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$from_id;hb=$hash;f=$file"), -class => "list"}, esc_html($file)) . "</td>\n" .
-			      "<td><span style=\"color: #c00000;\">[deleted " . file_type($from_mode). "]</span></td>\n" .
+			      "<td><span class=\"file_status deleted\">[deleted " . file_type($from_mode). "]</span></td>\n" .
 			      "<td class=\"link\">" .
 			      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$from_id;hb=$hash;f=$file")}, "blob") .
 			      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=history;h=$hash;f=$file")}, "history") .
@@ -2011,7 +2013,7 @@ sub git_commit {
 		} elsif ($status eq "M" || $status eq "T") {
 			my $mode_chnge = "";
 			if ($from_mode != $to_mode) {
-				$mode_chnge = " <span style=\"color: #777777;\">[changed";
+				$mode_chnge = " <span class=\"file_status mode_chnge\">[changed";
 				if (((oct $from_mode) & S_IFMT) != ((oct $to_mode) & S_IFMT)) {
 					$mode_chnge .= " from " . file_type($from_mode) . " to " . file_type($to_mode);
 				}
@@ -2047,7 +2049,7 @@ sub git_commit {
 			}
 			print "<td>" .
 			      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$to_id;hb=$hash;f=$to_file"), -class => "list"}, esc_html($to_file)) . "</td>\n" .
-			      "<td><span style=\"color: #777777;\">[moved from " .
+			      "<td><span class=\"file_status moved\">[moved from " .
 			      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$from_id;hb=$hash;f=$from_file"), -class => "list"}, esc_html($from_file)) .
 			      " with " . (int $similarity) . "% similarity$mode_chng]</span></td>\n" .
 			      "<td class=\"link\">" .
@@ -2407,7 +2409,7 @@ sub git_search {
 					my $match = esc_html($2) || "";
 					my $trail = esc_html($3) || "";
 					$trail = chop_str($trail, 30, 10);
-					my $text = "$lead<span style=\"color:#e00000\">$match</span>$trail";
+					my $text = "$lead<span class=\"match\">$match</span>$trail";
 					print chop_str($text, 80, 5) . "<br/>\n";
 				}
 			}
@@ -2456,7 +2458,7 @@ sub git_search {
 					while (my $setref = shift @files) {
 						my %set = %$setref;
 						print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob;h=$set{'id'};hb=$co{'id'};f=$set{'file'}"), class => "list"},
-						      "<span style=\"color:#e00000\">" . esc_html($set{'file'}) . "</span>") .
+						      "<span class=\"match\">" . esc_html($set{'file'}) . "</span>") .
 						      "<br/>\n";
 					}
 					print "</td>\n" .
diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index da53eb4..98410f5 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -89,14 +89,18 @@ span.age {
 	position: relative;
 	float: left;
 	width: 142px;
-	font-style:italic;
+	font-style: italic;
+}
+
+div.page_body span.signoff {
+	color: #888888;
 }
 
 div.log_link {
 	padding: 0px 8px;
 	font-size: 10px;
 	font-family: sans-serif;
-	font-style:normal;
+	font-style: normal;
 	position: relative;
 	float: left;
 	width: 136px;
@@ -138,6 +142,14 @@ table {
 	padding: 8px 4px;
 }
 
+table.project_list, table.diff_tree {
+	border-spacing: 0;
+}
+
+table.blame {
+	border-collapse: collapse;
+}
+
 th {
 	padding: 2px 5px;
 	font-size: 12px;
@@ -156,11 +168,10 @@ tr.dark:hover {
 	background-color: #edece6;
 }
 
-
 td {
 	padding: 2px 5px;
 	font-size: 12px;
-	vertical-align:top;
+	vertical-align: top;
 }
 
 td.link {
@@ -169,10 +180,77 @@ td.link {
 	font-size: 10px;
 }
 
-div.pre {
+td.sha1 {
+	font-family: monospace;
+}
+
+td.error {
+	color: red;
+	background-color: yellow;
+}
+
+table.diff_tree span.file_status.new {
+	color: #008000;
+}
+
+table.diff_tree span.file_status.deleted {
+	color: #c00000;
+}
+
+table.diff_tree span.file_status.moved,
+table.diff_tree span.file_status.mode_chnge {
+	color: #777777;
+}
+
+/* age2: 60*60*24*2 <= age */
+table.project_list td.age2, table.blame td.age2 {
+	font-style: italic;
+}
+
+/* age1: 60*60*2 <= age < 60*60*24*2 */
+table.project_list td.age1 {
+	color: #009900;
+	font-style: italic;
+}
+
+table.blame td.age1 {
+	color: #009900;
+	background: transparent;
+}
+
+/* age0: age < 60*60*2 */
+table.project_list td.age0 {
+	color: #009900;
+	font-style: italic;
+	font-weight: bold;
+}
+
+table.blame td.age0 {
+	color: #009900;
+	background: transparent;
+	font-weight: bold;
+}
+
+td.pre, div.pre, div.diff {
 	font-family: monospace;
 	font-size: 12px;
 	white-space: pre;
+}
+
+td.mode {
+	font-family: monospace;
+}
+
+div.diff.add {
+	color: #008800;
+}
+
+div.diff.rem {
+	color: #cc0000;
+}
+
+div.diff.chunk_header {
+	color: #990099;
 }
 
 div.diff_info {
@@ -196,6 +273,10 @@ div.search {
 	right: 12px
 }
 
+td.linenr {
+	text-align: right;
+}
+
 a.linenr {
 	color: #999999;
 	text-decoration: none
@@ -229,3 +310,11 @@ span.tag {
 	border: 1px solid;
 	border-color: #ffffcc #ffee00 #ffee00 #ffffcc;
 }
+
+span.atnight {
+	color: #cc0000;
+}
+
+span.match {
+	color: #e00000;
+}
-- 
1.3.0
