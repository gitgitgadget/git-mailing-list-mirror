From: Junio C Hamano <junkio@cox.net>
Subject: Re: git and cogito update, gitweb problem
Date: Thu, 10 Nov 2005 09:52:36 -0800
Message-ID: <7vvez0z8yj.fsf@assigned-by-dhcp.cox.net>
References: <20051110120201.GE22064@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 18:54:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaGbJ-0007rj-Fh
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 18:52:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbVKJRwi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 12:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbVKJRwi
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 12:52:38 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:53930 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751050AbVKJRwi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2005 12:52:38 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051110175149.IFTE29333.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 10 Nov 2005 12:51:49 -0500
To: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11496>

Nico -telmich- Schottelius <nico-linux-git@schottelius.org> writes:

> I just wanted to present you an automatic git and cogito updating script,
> but I've still the problem with '+' in filenames in gitweb [0].

Project names (and perhaps tag names) could contain characters
that need to be URL escaped as well.

I think this minimally should fix it for the list of files on
the commit page (a=commit) but I see the same problem in other
pages everywhere.

---

diff --git a/gitweb.cgi b/gitweb.cgi
index b8f1537..7b05fe2 100755
--- a/gitweb.cgi
+++ b/gitweb.cgi
@@ -10,7 +10,7 @@
 use strict;
 use warnings;
 use CGI qw(:standard :escapeHTML -nosticky);
-use CGI::Util qw(unescape);
+use CGI::Util qw(unescape escape);
 use CGI::Carp qw(fatalsToBrowser);
 use Fcntl ':mode';
 
@@ -1393,7 +1395,7 @@ sub git_tree {
 		my $t_type = $2;
 		my $t_hash = $3;
 		my $t_name = $4;
-		$file_key = ";f=$base$t_name";
+		$file_key = ";f=" . escape("$base$t_name");
 		if ($alternate) {
 			print "<tr class=\"dark\">\n";
 		} else {
@@ -1628,23 +1630,26 @@ sub git_commit {
 		$expires = "+1d";
 	}
 	git_header_html(undef, $expires);
+
+	my $eproject = escape($project);
+
 	print "<div class=\"page_nav\">\n" .
-	      $cgi->a({-href => "$my_uri?p=$project;a=summary"}, "summary") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=shortlog;h=$hash"}, "shortlog") .
-	      " | " . $cgi->a({-href => "$my_uri?p=$project;a=log;h=$hash"}, "log") .
+	      $cgi->a({-href => "$my_uri?p=$eproject;a=summary"}, "summary") .
+	      " | " . $cgi->a({-href => "$my_uri?p=$eproject;a=shortlog;h=$hash"}, "shortlog") .
+	      " | " . $cgi->a({-href => "$my_uri?p=$eproject;a=log;h=$hash"}, "log") .
 	      " | commit";
 	if (defined $co{'parent'}) {
-		print " | " . $cgi->a({-href => "$my_uri?p=$project;a=commitdiff;h=$hash"}, "commitdiff");
+		print " | " . $cgi->a({-href => "$my_uri?p=$eproject;a=commitdiff;h=$hash"}, "commitdiff");
 	}
-	print " | " . $cgi->a({-href => "$my_uri?p=$project;a=tree;h=$co{'tree'};hb=$hash"}, "tree") . "\n" .
+	print " | " . $cgi->a({-href => "$my_uri?p=$eproject;a=tree;h=$co{'tree'};hb=$hash"}, "tree") . "\n" .
 	      "<br/><br/></div>\n";
 	if (defined $co{'parent'}) {
 		print "<div>\n" .
-		      $cgi->a({-href => "$my_uri?p=$project;a=commitdiff;h=$hash", -class => "title"}, escapeHTML($co{'title'})) . "\n" .
+		      $cgi->a({-href => "$my_uri?p=$eproject;a=commitdiff;h=$hash", -class => "title"}, escapeHTML($co{'title'})) . "\n" .
 		      "</div>\n";
 	} else {
 		print "<div>\n" .
-		      $cgi->a({-href => "$my_uri?p=$project;a=tree;h=$co{'tree'};hb=$hash", -class => "title"}, escapeHTML($co{'title'})) . "\n" .
+		      $cgi->a({-href => "$my_uri?p=$eproject;a=tree;h=$co{'tree'};hb=$hash", -class => "title"}, escapeHTML($co{'title'})) . "\n" .
 		      "</div>\n";
 	}
 	print "<div class=\"title_text\">\n" .
@@ -1665,19 +1670,19 @@ sub git_commit {
 	print "<tr>" .
 	      "<td>tree</td>" .
 	      "<td style=\"font-family:monospace\">" .
-	      $cgi->a({-href => "$my_uri?p=$project;a=tree;h=$co{'tree'};hb=$hash", class => "list"}, $co{'tree'}) .
+	      $cgi->a({-href => "$my_uri?p=$eproject;a=tree;h=$co{'tree'};hb=$hash", class => "list"}, $co{'tree'}) .
 	      "</td>" .
-	      "<td class=\"link\">" . $cgi->a({-href => "$my_uri?p=$project;a=tree;h=$co{'tree'};hb=$hash"}, "tree") .
+	      "<td class=\"link\">" . $cgi->a({-href => "$my_uri?p=$eproject;a=tree;h=$co{'tree'};hb=$hash"}, "tree") .
 	      "</td>" .
 	      "</tr>\n";
 	my $parents  = $co{'parents'};
 	foreach my $par (@$parents) {
 		print "<tr>" .
 		      "<td>parent</td>" .
-		      "<td style=\"font-family:monospace\">" . $cgi->a({-href => "$my_uri?p=$project;a=commit;h=$par", class => "list"}, $par) . "</td>" .
+		      "<td style=\"font-family:monospace\">" . $cgi->a({-href => "$my_uri?p=$eproject;a=commit;h=$par", class => "list"}, $par) . "</td>" .
 		      "<td class=\"link\">" .
-		      $cgi->a({-href => "$my_uri?p=$project;a=commit;h=$par"}, "commit") .
-		      " | " . $cgi->a({-href => "$my_uri?p=$project;a=commitdiff;h=$hash;hp=$par"}, "commitdiff") .
+		      $cgi->a({-href => "$my_uri?p=$eproject;a=commit;h=$par"}, "commit") .
+		      " | " . $cgi->a({-href => "$my_uri?p=$eproject;a=commitdiff;h=$hash;hp=$par"}, "commitdiff") .
 		      "</td>" .
 		      "</tr>\n";
 	}
@@ -1726,6 +1731,7 @@ sub git_commit {
 		my $status = $5;
 		my $similarity = $6;
 		my $file = $7;
+		my $efile = escape($file);
 		if ($alternate) {
 			print "<tr class=\"dark\">\n";
 		} else {
@@ -1738,16 +1744,16 @@ sub git_commit {
 				$mode_chng = sprintf(" with mode: %04o", (oct $to_mode) & 0777);
 			}
 			print "<td>" .
-			      $cgi->a({-href => "$my_uri?p=$project;a=blob;h=$to_id;hb=$hash;f=$file", -class => "list"}, escapeHTML($file)) . "</td>\n" .
+			      $cgi->a({-href => "$my_uri?p=$eproject;a=blob;h=$to_id;hb=$hash;f=$efile", -class => "list"}, escapeHTML($file)) . "</td>\n" .
 			      "<td><span style=\"color: #008000;\">[new " . file_type($to_mode) . "$mode_chng]</span></td>\n" .
-			      "<td class=\"link\">" . $cgi->a({-href => "$my_uri?p=$project;a=blob;h=$to_id;hb=$hash;f=$file"}, "blob") . "</td>\n";
+			      "<td class=\"link\">" . $cgi->a({-href => "$my_uri?p=$eproject;a=blob;h=$to_id;hb=$hash;f=$efile"}, "blob") . "</td>\n";
 		} elsif ($status eq "D") {
 			print "<td>" .
-			      $cgi->a({-href => "$my_uri?p=$project;a=blob;h=$from_id;hb=$hash;f=$file", -class => "list"}, escapeHTML($file)) . "</td>\n" .
+			      $cgi->a({-href => "$my_uri?p=$eproject;a=blob;h=$from_id;hb=$hash;f=$efile", -class => "list"}, escapeHTML($file)) . "</td>\n" .
 			      "<td><span style=\"color: #c00000;\">[deleted " . file_type($from_mode). "]</span></td>\n" .
 			      "<td class=\"link\">" .
-			      $cgi->a({-href => "$my_uri?p=$project;a=blob;h=$from_id;hb=$hash;f=$file"}, "blob") .
-			      " | " . $cgi->a({-href => "$my_uri?p=$project;a=history;h=$hash;f=$file"}, "history") .
+			      $cgi->a({-href => "$my_uri?p=$eproject;a=blob;h=$from_id;hb=$hash;f=$efile"}, "blob") .
+			      " | " . $cgi->a({-href => "$my_uri?p=$eproject;a=history;h=$hash;f=$efile"}, "history") .
 			      "</td>\n"
 		} elsif ($status eq "M" || $status eq "T") {
 			my $mode_chnge = "";
@@ -1767,18 +1773,18 @@ sub git_commit {
 			}
 			print "<td>";
 			if ($to_id ne $from_id) {
-				print $cgi->a({-href => "$my_uri?p=$project;a=blobdiff;h=$to_id;hp=$from_id;hb=$hash;f=$file", -class => "list"}, escapeHTML($file));
+				print $cgi->a({-href => "$my_uri?p=$eproject;a=blobdiff;h=$to_id;hp=$from_id;hb=$hash;f=$efile", -class => "list"}, escapeHTML($file));
 			} else {
-				print $cgi->a({-href => "$my_uri?p=$project;a=blob;h=$to_id;hb=$hash;f=$file", -class => "list"}, escapeHTML($file));
+				print $cgi->a({-href => "$my_uri?p=$eproject;a=blob;h=$to_id;hb=$hash;f=$efile", -class => "list"}, escapeHTML($file));
 			}
 			print "</td>\n" .
 			      "<td>$mode_chnge</td>\n" .
 			      "<td class=\"link\">";
-			print $cgi->a({-href => "$my_uri?p=$project;a=blob;h=$to_id;hb=$hash;f=$file"}, "blob");
+			print $cgi->a({-href => "$my_uri?p=$eproject;a=blob;h=$to_id;hb=$hash;f=$efile"}, "blob");
 			if ($to_id ne $from_id) {
-				print " | " . $cgi->a({-href => "$my_uri?p=$project;a=blobdiff;h=$to_id;hp=$from_id;hb=$hash;f=$file"}, "diff");
+				print " | " . $cgi->a({-href => "$my_uri?p=$eproject;a=blobdiff;h=$to_id;hp=$from_id;hb=$hash;f=$efile"}, "diff");
 			}
-			print " | " . $cgi->a({-href => "$my_uri?p=$project;a=history;h=$hash;f=$file"}, "history") . "\n";
+			print " | " . $cgi->a({-href => "$my_uri?p=$eproject;a=history;h=$hash;f=$efile"}, "history") . "\n";
 			print "</td>\n";
 		} elsif ($status eq "R") {
 			my ($from_file, $to_file) = split "\t", $file;
@@ -1787,14 +1793,14 @@ sub git_commit {
 				$mode_chng = sprintf(", mode: %04o", (oct $to_mode) & 0777);
 			}
 			print "<td>" .
-			      $cgi->a({-href => "$my_uri?p=$project;a=blob;h=$to_id;hb=$hash;f=$to_file", -class => "list"}, escapeHTML($to_file)) . "</td>\n" .
+			      $cgi->a({-href => "$my_uri?p=$eproject;a=blob;h=$to_id;hb=$hash;f=$to_file", -class => "list"}, escapeHTML($to_file)) . "</td>\n" .
 			      "<td><span style=\"color: #777777;\">[moved from " .
-			      $cgi->a({-href => "$my_uri?p=$project;a=blob;h=$from_id;hb=$hash;f=$from_file", -class => "list"}, escapeHTML($from_file)) .
+			      $cgi->a({-href => "$my_uri?p=$eproject;a=blob;h=$from_id;hb=$hash;f=$from_file", -class => "list"}, escapeHTML($from_file)) .
 			      " with " . (int $similarity) . "% similarity$mode_chng]</span></td>\n" .
 			      "<td class=\"link\">" .
-			      $cgi->a({-href => "$my_uri?p=$project;a=blob;h=$to_id;hb=$hash;f=$to_file"}, "blob");
+			      $cgi->a({-href => "$my_uri?p=$eproject;a=blob;h=$to_id;hb=$hash;f=$to_file"}, "blob");
 			if ($to_id ne $from_id) {
-				print " | " . $cgi->a({-href => "$my_uri?p=$project;a=blobdiff;h=$to_id;hp=$from_id;hb=$hash;f=$to_file"}, "diff");
+				print " | " . $cgi->a({-href => "$my_uri?p=$eproject;a=blobdiff;h=$to_id;hp=$from_id;hb=$hash;f=$to_file"}, "diff");
 			}
 			print "</td>\n";
 		}
