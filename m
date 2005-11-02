From: Penny Leach <penny@catalyst.net.nz>
Subject: [PATCH] Gitweb: Per-head rss feeds and per-project opml.
Date: Wed, 2 Nov 2005 15:03:11 +1300
Message-ID: <11308969914190-git-send-email-penny@catalyst.net.nz>
Reply-To: Penny Leach <penny@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Penny Leach <penny@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Wed Nov 02 03:04:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EX7yF-0001YY-Vg
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 03:03:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbVKBCDR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Nov 2005 21:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbVKBCDR
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Nov 2005 21:03:17 -0500
Received: from godel.catalyst.net.nz ([202.78.240.40]:35049 "EHLO
	mail1.catalyst.net.nz") by vger.kernel.org with ESMTP
	id S932193AbVKBCDP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Nov 2005 21:03:15 -0500
Received: from locke.catalyst.net.nz ([202.78.240.39])
	by mail1.catalyst.net.nz with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1EX7y4-0002pf-DO; Wed, 02 Nov 2005 15:03:13 +1300
Received: from localhost ([127.0.0.1] helo=locke)
	by locke.catalyst.net.nz with smtp (Exim 4.50)
	id 1EX7y3-0007Gw-Tl; Wed, 02 Nov 2005 15:03:11 +1300
In-Reply-To: 
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10990>

Signed-off-by: Penny Leach <penny@catalyst.net.nz>


---

 gitweb.cgi |  104 +++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 91 insertions(+), 13 deletions(-)

ad295087a0969c6816d6acf57f39053666327f2e
diff --git a/gitweb.cgi b/gitweb.cgi
--- a/gitweb.cgi
+++ b/gitweb.cgi
@@ -52,12 +52,18 @@ if (defined $action) {
 	if ($action eq "git-logo.png") {
 		git_logo();
 		exit;
-	} elsif ($action eq "opml") {
-		git_opml();
-		exit;
 	}
 }
 
+my $show_rss = 0;
+my $show_opml = 0;
+if (!defined($action) || $action eq 'summary' || $action eq 'heads' || $action eq 'log' || $action eq 'shortlog') {
+    $show_rss = 1;
+}
+if (!defined($action) || $action eq 'summary') {
+    $show_opml = 1;
+}
+
 my $order = $cgi->param('o');
 if (defined $order) {
 	if ($order =~ m/[^0-9a-zA-Z_]/) {
@@ -80,11 +86,17 @@ if (defined $project) {
 		undef $project;
 		die_error(undef, "No such project.");
 	}
-	$rss_link = "<link rel=\"alternate\" title=\"$project log\" href=\"$my_uri?p=$project;a=rss\" type=\"application/rss+xml\"/>";
+	
+	if ($show_rss) {
+	    $rss_link = "<link rel=\"alternate\" title=\"$project log\" href=\"$my_uri?p=$project;a=rss\" type=\"application/rss+xml\"/>";
+	}
+
 	$ENV{'GIT_DIR'} = "$projectroot/$project";
 } else {
-	git_project_list();
-	exit;
+        if (!defined($action)) {
+	    git_project_list();
+	    exit;
+	}
 }
 
 my $file_name = $cgi->param('f');
@@ -96,11 +108,16 @@ if (defined $file_name) {
 }
 
 my $hash = $cgi->param('h');
+my $rsshead;
 if (defined $hash) {
 	$hash = validate_input($hash);
 	if (!defined($hash)) {
 		die_error(undef, "Invalid hash parameter.");
 	}
+	if ($show_rss) { #override it
+	        $rss_link = "<link rel=\"alternate\" title=\"$project#$hash log\" href=\"$my_uri?p=$project;a=rss;h=$hash\" type=\"application/rss+xml\"/>";
+	}
+	$rsshead = $hash;
 }
 
 my $hash_parent = $cgi->param('hp');
@@ -202,6 +219,10 @@ if (!defined $action || $action eq "summ
 } elsif ($action eq "tag") {
 	git_tag();
 	exit;
+# moved to here so $project gets validated first
+} elsif ($action eq "opml") {
+	git_opml();
+	exit;
 } else {
 	undef $action;
 	die_error(undef, "Unknown action.");
@@ -280,6 +301,13 @@ a.rss_logo {
 	color:#ffffff; background-color:#ff6600;
 	font-weight:bold; font-family:sans-serif; font-size:10px;
 	text-align:center; text-decoration:none;
+        margin:2px;
+}
+a.rss_logo_small {
+    border:1px solid; border-color:#fcc7a5 #7d3302 #3e1a01 #ff954e;
+    color:#ffffff; background-color:#ff6600;
+    font-weight:bold; font-family:sans-serif; font-size:10px;
+    text-align:center; text-decoration:none;
 }
 a.rss_logo:hover { background-color:#ee5500; }
 </style>
@@ -327,9 +355,21 @@ sub git_footer_html {
 		if (defined $descr) {
 			print "<div class=\"page_footer_text\">" . escapeHTML($descr) . "</div>\n";
 		}
-		print $cgi->a({-href => "$my_uri?p=$project;a=rss", -class => "rss_logo"}, "RSS") . "\n";
+		if ($show_rss) {
+		        if (defined($rsshead)) {
+  			        print $cgi->a({-href => "$my_uri?p=$project;a=rss;h=$rsshead", -class => "rss_logo"}, "RSS") . "\n";
+  		        }  else {
+				print $cgi->a({-href => "$my_uri?p=$project;a=rss", -class => "rss_logo"}, "RSS") . "\n";
+			}
+		}
+		if ($show_opml) {
+			print $cgi->a({-href => "$my_uri?p=$project;a=opml", -class => "rss_logo"}, "OPML") . "\n";
+		}
+
 	} else {
-		print $cgi->a({-href => "$my_uri?a=opml", -class => "rss_logo"}, "OPML") . "\n";
+	        if ($show_opml) {
+		    	print $cgi->a({-href => "$my_uri?a=opml", -class => "rss_logo"}, "OPML") . "\n";
+		}
 	}
 	print "</div>\n" .
 	      "</body>\n" .
@@ -864,6 +904,7 @@ sub git_project_list {
 		      $cgi->a({-href => "$my_uri?p=$pr->{'path'};a=summary"}, "summary") .
 		      " | " . $cgi->a({-href => "$my_uri?p=$pr->{'path'};a=shortlog"}, "shortlog") .
 		      " | " . $cgi->a({-href => "$my_uri?p=$pr->{'path'};a=log"}, "log") .
+		      " | " . $cgi->a({-href => "$my_uri?p=$pr->{'path'};a=opml", -class => "rss_logo_small"}, "OPML") . 
 		      "</td>\n" .
 		      "</tr>\n";
 	}
@@ -1095,6 +1136,7 @@ sub git_summary {
 				      "<td class=\"link\">" .
 				      $cgi->a({-href => "$my_uri?p=$project;a=shortlog;h=$tag{'name'}"}, "shortlog") .
 				      " | " . $cgi->a({-href => "$my_uri?p=$project;a=log;h=$tag{'name'}"}, "log") .
+				      " | " . $cgi->a({-href => "$my_uri?p=$project;a=rss;h=$tag{'name'}", -class => "rss_logo_small"}, "RSS") .
 				      "</td>\n" .
 				      "</tr>";
 			} else {
@@ -1240,6 +1282,7 @@ sub git_heads {
 			      "<td class=\"link\">" .
 			      $cgi->a({-href => "$my_uri?p=$project;a=shortlog;h=$tag{'name'}"}, "shortlog") .
 			      " | " . $cgi->a({-href => "$my_uri?p=$project;a=log;h=$tag{'name'}"}, "log") .
+			      " | " . $cgi->a({-href => "$my_uri?p=$project;a=rss;h=$tag{'name'}", -class => "rss_logo_small"}, "RSS") . 
 			      "</td>\n" .
 			      "</tr>";
 		}
@@ -1428,16 +1471,31 @@ sub git_tree {
 
 sub git_rss {
 	# http://www.notestips.com/80256B3A007F2692/1/NAMO5P9UPQ
-	open my $fd, "-|", "$gitbin/git-rev-list --max-count=150 " . git_read_hash("$project/HEAD") or die_error(undef, "Open failed.");
+        my $read_hash;
+	if (!defined($hash)) {
+	    $read_hash = git_read_hash("$project/HEAD");
+	} else {
+	    $read_hash = $hash; 
+	}
+
+	open my $fd, "-|", "$gitbin/git-rev-list --max-count=150 $read_hash " or die_error(undef, "Open failed.");
 	my (@revlist) = map { chomp; $_ } <$fd>;
 	close $fd or die_error(undef, "Reading rev-list failed.");
 	print $cgi->header(-type => 'text/xml', -charset => 'utf-8');
 	print "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n".
 	      "<rss version=\"2.0\" xmlns:content=\"http://purl.org/rss/1.0/modules/content/\">\n";
 	print "<channel>\n";
-	print "<title>$project</title>\n".
-	      "<link>" . escapeHTML("$my_url?p=$project;a=summary") . "</link>\n".
-	      "<description>$project log</description>\n".
+	my $title = $project;
+	my $link = escapeHTML("$my_url?p=$project;a=summary");
+	my $description = "$project log";
+	if (defined($hash)) {
+	    $title .= "#$hash";
+	    $link  .= escapeHTML(";h=$hash");
+	    $description = $project."#".$hash." log";
+	}
+	print "<title>$title</title>\n".
+	      "<link>$link</link>\n".
+	      "<description>$description</description>\n".
 	      "<language>en</language>\n";
 
 	for (my $i = 0; $i <= $#revlist; $i++) {
@@ -1482,7 +1540,13 @@ sub git_rss {
 }
 
 sub git_opml {
-	my @list = git_read_projects();
+	my @list;
+	
+	if (defined($project)) {
+	    @list = ( { 'path' => $project } );
+	} else {
+	    @list = git_read_projects();
+	}
 
 	print $cgi->header(-type => 'text/xml', -charset => 'utf-8');
 	print "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n".
@@ -1509,6 +1573,20 @@ sub git_opml {
 		my $rss =  "$my_url?p=$proj{'path'};a=rss";
 		my $html =  "$my_url?p=$proj{'path'};a=summary";
 		print "<outline type=\"rss\" text=\"$path\" title=\"$path\" xmlUrl=\"$rss\" htmlUrl=\"$html\"/>\n";
+		
+		$project = $proj{'path'};
+		my $taglist = git_read_refs('refs/heads');
+
+		if (defined @$taglist) {
+		    foreach my $entry (@$taglist) {
+                        my %tag = %$entry;
+			my $path = escapeHTML(chop_str($proj{'path'}.'#'.$tag{'name'},25,5));
+			my $rss = "$my_url?p=$proj{'path'};h=$tag{'name'};a=rss";
+			my $html = "$my_url?p=$proj{'path'};h=$tag{'name'};a=summary";
+			print "<outline type=\"rss\" text=\"$path\" title=\"$path\" xmlUrl=\"$rss\" htmlUrl=\"$html\"/>\n";
+		    }
+                }
+		
 	}
 	print "</outline>\n".
 	      "</body>\n".
