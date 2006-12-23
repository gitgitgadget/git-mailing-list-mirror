From: Robert Fitzsimons <robfitz@273k.net>
Subject: [PATCH] gitweb: Paginate commit/author/committer search output
Date: Sat, 23 Dec 2006 14:57:12 +0000
Message-ID: <20061223145712.GE11474@localhost>
References: <11668449162618-git-send-email-robfitz@273k.net> <emiomr$f4m$1@sea.gmane.org> <20061223122841.GD11474@localhost> <200612231400.18774.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robert Fitzsimons <robfitz@273k.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 23 15:57:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gy8JO-0005CS-VG
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 15:57:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753565AbWLWO5S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 09:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753569AbWLWO5S
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 09:57:18 -0500
Received: from igraine.blacknight.ie ([81.17.252.25]:58115 "EHLO
	igraine.blacknight.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753559AbWLWO5R (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 09:57:17 -0500
Received: from [194.125.99.166] (helo=localhost)
	by igraine.blacknight.ie with esmtp (Exim 4.60)
	(envelope-from <robfitz@273k.net>)
	id 1Gy8J1-0004WK-GE; Sat, 23 Dec 2006 14:57:00 +0000
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <200612231400.18774.jnareb@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-blacknight-igraine-MailScanner-Information: Please contact the ISP for more information
X-blacknight-igraine-MailScanner: Found to be clean
X-blacknight-igraine-MailScanner-SpamCheck: not spam,
	SpamAssassin (not cached, score=-2, required 7, autolearn=disabled,
	RCVD_IN_NERDS_IE -2.00)
X-MailScanner-From: robfitz@273k.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35322>

Paginate commit/author/committer search output to only show 100 commits
at a time, added appropriate nav links.

Signed-off-by: Robert Fitzsimons <robfitz@273k.net>
---


> Although with search you have additional complication with marking match,
> and "log" view like rather than "shortlog" like view... so I'm not sure
> if it would truly help. On the other hand you can use --skip option you
> have introduced...

I used the slower non--skip workflow for the moment, so at least there
is no need to upgrade the core git commands.

Robert


 gitweb/gitweb.perl |  148 ++++++++++++++++++++++++++++++++++++----------------
 1 files changed, 103 insertions(+), 45 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index cc6bd0c..e4378b9 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2837,6 +2837,58 @@ sub git_heads_body {
 	print "</table>\n";
 }
 
+sub git_search_grep_body {
+	my ($greplist, $from, $to, $extra) = @_;
+	$from = 0 unless defined $from;
+	$to = $#{$greplist} if (!defined $to || $#{$greplist} < $to);
+
+	print "<table class=\"grep\" cellspacing=\"0\">\n";
+	my $alternate = 1;
+	for (my $i = $from; $i <= $to; $i++) {
+		my $commit = $greplist->[$i];
+		my %co = parse_commit($commit);
+		if (!%co) {
+			next;
+		}
+		if ($alternate) {
+			print "<tr class=\"dark\">\n";
+		} else {
+			print "<tr class=\"light\">\n";
+		}
+		$alternate ^= 1;
+		print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
+		      "<td><i>" . esc_html(chop_str($co{'author_name'}, 15, 5)) . "</i></td>\n" .
+		      "<td>" .
+		      $cgi->a({-href => href(action=>"commit", hash=>$co{'id'}), -class => "list subject"},
+			       esc_html(chop_str($co{'title'}, 50)) . "<br/>");
+		my $comment = $co{'comment'};
+		foreach my $line (@$comment) {
+			if ($line =~ m/^(.*)($searchtext)(.*)$/i) {
+				my $lead = esc_html($1) || "";
+				$lead = chop_str($lead, 30, 10);
+				my $match = esc_html($2) || "";
+				my $trail = esc_html($3) || "";
+				$trail = chop_str($trail, 30, 10);
+				my $text = "$lead<span class=\"match\">$match</span>$trail";
+				print chop_str($text, 80, 5) . "<br/>\n";
+			}
+		}
+		print "</td>\n" .
+		      "<td class=\"link\">" .
+		      $cgi->a({-href => href(action=>"commit", hash=>$co{'id'})}, "commit") .
+		      " | " .
+		      $cgi->a({-href => href(action=>"tree", hash=>$co{'tree'}, hash_base=>$co{'id'})}, "tree");
+		print "</td>\n" .
+		      "</tr>\n";
+	}
+	if (defined $extra) {
+		print "<tr>\n" .
+		      "<td colspan=\"3\">$extra</td>\n" .
+		      "</tr>\n";
+	}
+	print "</table>\n";
+}
+
 ## ======================================================================
 ## ======================================================================
 ## actions
@@ -4154,6 +4206,9 @@ sub git_search {
 	if (!%co) {
 		die_error(undef, "Unknown commit object");
 	}
+	if (!defined $page) {
+		$page = 0;
+	}
 
 	$searchtype ||= 'commit';
 	if ($searchtype eq 'pickaxe') {
@@ -4166,11 +4221,7 @@ sub git_search {
 	}
 
 	git_header_html();
-	git_print_page_nav('','', $hash,$co{'tree'},$hash);
-	git_print_header_div('commit', esc_html($co{'title'}), $hash);
 
-	print "<table cellspacing=\"0\">\n";
-	my $alternate = 1;
 	if ($searchtype eq 'commit' or $searchtype eq 'author' or $searchtype eq 'committer') {
 		my $greptype;
 		if ($searchtype eq 'commit') {
@@ -4180,52 +4231,58 @@ sub git_search {
 		} elsif ($searchtype eq 'committer') {
 			$greptype = "--committer=";
 		}
-		$/ = "\0";
 		open my $fd, "-|", git_cmd(), "rev-list",
-			"--header", "--parents", ($greptype . $searchtext),
-			 $hash, "--"
+			("--max-count=" . (100 * ($page+1))),
+			($greptype . $searchtext),
+			$hash, "--"
 			or next;
-		while (my $commit_text = <$fd>) {
-			my @commit_lines = split "\n", $commit_text;
-			my %co = parse_commit(undef, \@commit_lines);
-			if (!%co) {
-				next;
-			}
-			if ($alternate) {
-				print "<tr class=\"dark\">\n";
-			} else {
-				print "<tr class=\"light\">\n";
-			}
-			$alternate ^= 1;
-			print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
-			      "<td><i>" . esc_html(chop_str($co{'author_name'}, 15, 5)) . "</i></td>\n" .
-			      "<td>" .
-			      $cgi->a({-href => href(action=>"commit", hash=>$co{'id'}), -class => "list subject"},
-			               esc_html(chop_str($co{'title'}, 50)) . "<br/>");
-			my $comment = $co{'comment'};
-			foreach my $line (@$comment) {
-				if ($line =~ m/^(.*)($searchtext)(.*)$/i) {
-					my $lead = esc_html($1) || "";
-					$lead = chop_str($lead, 30, 10);
-					my $match = esc_html($2) || "";
-					my $trail = esc_html($3) || "";
-					$trail = chop_str($trail, 30, 10);
-					my $text = "$lead<span class=\"match\">$match</span>$trail";
-					print chop_str($text, 80, 5) . "<br/>\n";
-				}
-			}
-			print "</td>\n" .
-			      "<td class=\"link\">" .
-			      $cgi->a({-href => href(action=>"commit", hash=>$co{'id'})}, "commit") .
-			      " | " .
-			      $cgi->a({-href => href(action=>"tree", hash=>$co{'tree'}, hash_base=>$co{'id'})}, "tree");
-			print "</td>\n" .
-			      "</tr>\n";
-		}
+		my @revlist = map { chomp; $_ } <$fd>;
 		close $fd;
+
+		my $paging_nav = '';
+		if ($page > 0) {
+			$paging_nav .=
+				$cgi->a({-href => href(action=>"search", hash=>$hash,
+						       searchtext=>$searchtext, searchtype=>$searchtype)},
+					"first");
+			$paging_nav .= " &sdot; " .
+				$cgi->a({-href => href(action=>"search", hash=>$hash,
+						       searchtext=>$searchtext, searchtype=>$searchtype,
+						       page=>$page-1),
+					 -accesskey => "p", -title => "Alt-p"}, "prev");
+		} else {
+			$paging_nav .= "first";
+			$paging_nav .= " &sdot; prev";
+		}
+		if ($#revlist >= (100 * ($page+1)-1)) {
+			$paging_nav .= " &sdot; " .
+				$cgi->a({-href => href(action=>"search", hash=>$hash,
+						       searchtext=>$searchtext, searchtype=>$searchtype,
+						       page=>$page+1),
+					 -accesskey => "n", -title => "Alt-n"}, "next");
+		} else {
+			$paging_nav .= " &sdot; next";
+		}
+		my $next_link = '';
+		if ($#revlist >= (100 * ($page+1)-1)) {
+			$next_link =
+				$cgi->a({-href => href(action=>"search", hash=>$hash,
+						       searchtext=>$searchtext, searchtype=>$searchtype,
+						       page=>$page+1),
+					 -accesskey => "n", -title => "Alt-n"}, "next");
+		}
+
+		git_print_page_nav('','', $hash,$co{'tree'},$hash, $paging_nav);
+		git_print_header_div('commit', esc_html($co{'title'}), $hash);
+		git_search_grep_body(\@revlist, ($page * 100), $#revlist, $next_link);
 	}
 
 	if ($searchtype eq 'pickaxe') {
+		git_print_page_nav('','', $hash,$co{'tree'},$hash);
+		git_print_header_div('commit', esc_html($co{'title'}), $hash);
+
+		print "<table cellspacing=\"0\">\n";
+		my $alternate = 1;
 		$/ = "\n";
 		my $git_command = git_cmd_str();
 		open my $fd, "-|", "$git_command rev-list $hash | " .
@@ -4280,8 +4337,9 @@ sub git_search {
 			}
 		}
 		close $fd;
+
+		print "</table>\n";
 	}
-	print "</table>\n";
 	git_footer_html();
 }
 
-- 
1.4.4.3.gae7ae3
