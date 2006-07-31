From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 18] gitweb: Refactor generation of shortlog, tags and heads body
Date: Mon, 31 Jul 2006 11:22:13 +0200
Message-ID: <200607311122.17417.jnareb@gmail.com>
References: <200607292239.11034.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Jul 31 11:23:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7Tyu-0001VE-2j
	for gcvg-git@gmane.org; Mon, 31 Jul 2006 11:22:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbWGaJWN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Jul 2006 05:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbWGaJWN
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 05:22:13 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:45651 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751310AbWGaJWM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jul 2006 05:22:12 -0400
Received: by ug-out-1314.google.com with SMTP id m3so652358ugc
        for <git@vger.kernel.org>; Mon, 31 Jul 2006 02:22:11 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=YdmUcT14gHDM9+oUED79z7M7paSQaVXOR1WSaSioBqrjdzZ6K3csENAK3Ec76zf8n6aJM91tcbfZtWKzTxyz50LED1LFbTYJ8gpUMpNVuk7+4A9FGD/f8y9NRppA1jOEz7d8NHm6tB1uA9nx09SZ6UPtU+S6J3ReYb5rF4l6s/g=
Received: by 10.66.249.11 with SMTP id w11mr2276371ugh;
        Mon, 31 Jul 2006 02:22:11 -0700 (PDT)
Received: from roke.d-201 ( [193.0.122.19])
        by mx.gmail.com with ESMTP id y7sm4123294ugc.2006.07.31.02.22.10;
        Mon, 31 Jul 2006 02:22:10 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200607292239.11034.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24504>

Add git_shortlog_body, git_tags_body and git_heads_body to generate
table with shortlog, tags and heads respectively in git_summary and
git_shortlog, git_tags, git_heads respectively.

Better support for lightweight tags in git_read_refs; currently only
lightweight tag pointing to tag object is not resolved fully.

Shortlog, tags and heads body tables have proper class now (we could
use id instead of class).

Add support for showing full comment on mouseover to tags list when
comment is shortened, similar to how full title of commit was/is
shown on mouseover when title was shortened.  Changed layout of tags
table to better show lightweight tags.

Add showing which branch (head) is current branch (current head),
using "current_head" class (we could use id instead).

Corrected "</table\n>" and hit_header_div instead of git_header_div.


Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Largest patch in the series. Refactoring and unification.
New features (table classes, current head) are fairly unintrusive.

 gitweb/gitweb.cgi |  383 ++++++++++++++++++++++++-----------------------------
 gitweb/gitweb.css |   10 +
 2 files changed, 184 insertions(+), 209 deletions(-)

diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index dab6068..d209af0 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -1102,6 +1102,10 @@ sub git_read_refs {
 			$ref_item{'refid'} = $ref_id;
 			$ref_item{'epoch'} = $co{'committer_epoch'};
 			$ref_item{'age'} = $co{'age_string'};
+		} else {
+			$ref_item{'reftype'} = $type;
+			$ref_item{'name'} = $ref_file;
+			$ref_item{'refid'} = $ref_id;
 		}
 
 		push @reflist, \%ref_item;
@@ -1111,6 +1115,156 @@ sub git_read_refs {
 	return \@reflist;
 }
 
+sub git_shortlog_body {
+	# uses global variable $project
+	my ($revlist, $from, $to, $refs, $extra) = @_;
+	$from = 0 unless defined $from;
+	$to = $#{$revlist} if (!defined $to || $#{$revlist} < $to);
+
+	print "<table class=\"shortlog\" cellspacing=\"0\">\n";
+	my $alternate = 0;
+	for (my $i = $from; $i <= $to; $i++) {
+		my $commit = $revlist->[$i];
+		#my $ref = defined $refs ? git_get_referencing($refs, $commit) : '';
+		my $ref = git_get_referencing($refs, $commit);
+		my %co = git_read_commit($commit);
+		my %ad = date_str($co{'author_epoch'});
+		if ($alternate) {
+			print "<tr class=\"dark\">\n";
+		} else {
+			print "<tr class=\"light\">\n";
+		}
+		$alternate ^= 1;
+		# git_summary() used print "<td><i>$co{'age_string'}</i></td>\n" .
+		print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
+		      "<td><i>" . esc_html(chop_str($co{'author_name'}, 10)) . "</i></td>\n" .
+		      "<td>";
+		if (length($co{'title_short'}) < length($co{'title'})) {
+			print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$commit"),
+			               -class => "list", -title => "$co{'title'}"},
+			      "<b>" . esc_html($co{'title_short'}) . "$ref</b>");
+		} else {
+			print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$commit"),
+			               -class => "list"},
+			      "<b>" . esc_html($co{'title'}) . "$ref</b>");
+		}
+		print "</td>\n" .
+		      "<td class=\"link\">" .
+		      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$commit")}, "commit") . " | " .
+		      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commitdiff;h=$commit")}, "commitdiff") .
+		      "</td>\n" .
+		      "</tr>\n";
+	}
+	if (defined $extra) {
+		print "<tr>\n" .
+		      "<td colspan=\"4\">$extra</td>\n" .
+		      "</tr>\n";
+	}
+	print "</table>\n";
+}
+
+sub git_tags_body {
+	# uses global variable $project
+	my ($taglist, $from, $to, $extra) = @_;
+	$from = 0 unless defined $from;
+	$to = $#{$taglist} if (!defined $to || $#{$taglist} < $to);
+
+	print "<table class=\"tags\" cellspacing=\"0\">\n";
+	my $alternate = 0;
+	for (my $i = $from; $i <= $to; $i++) {
+		my $entry = $taglist->[$i];
+		my %tag = %$entry;
+		my $comment_lines = $tag{'comment'};
+		my $comment = shift @$comment_lines;
+		my $comment_short;
+		if (defined $comment) {
+			$comment_short = chop_str($comment, 30, 5);
+		}
+		if ($alternate) {
+			print "<tr class=\"dark\">\n";
+		} else {
+			print "<tr class=\"light\">\n";
+		}
+		$alternate ^= 1;
+		print "<td><i>$tag{'age'}</i></td>\n" .
+		      "<td>" .
+		      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=$tag{'reftype'};h=$tag{'refid'}"),
+		               -class => "list"}, "<b>" . esc_html($tag{'name'}) . "</b>") .
+		      "</td>\n" .
+		      "<td>";
+		if (defined $comment) {
+			if (length($comment_short) < length($comment)) {
+				print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=tag;h=$tag{'id'}"),
+				               -class => "list", -title => $comment}, $comment_short);
+			} else {
+				print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=tag;h=$tag{'id'}"),
+				               -class => "list"}, $comment);
+			}
+		}
+		print "</td>\n" .
+		      "<td class=\"selflink\">";
+		if ($tag{'type'} eq "tag") {
+			print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=tag;h=$tag{'id'}")}, "tag");
+		} else {
+			print "&nbsp;";
+		}
+		print "</td>\n" .
+		      "<td class=\"link\">" . " | " .
+		      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=$tag{'reftype'};h=$tag{'refid'}")}, $tag{'reftype'});
+		if ($tag{'reftype'} eq "commit") {
+			print " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=shortlog;h=$tag{'name'}")}, "shortlog") .
+			      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=log;h=$tag{'refid'}")}, "log");
+		} elsif ($tag{'reftype'} eq "blob") {
+			print " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob_plain;h=$tag{'refid'}")}, "raw");
+		}
+		print "</td>\n" .
+		      "</tr>";
+	}
+	if (defined $extra) {
+		print "<tr>\n" .
+		      "<td colspan=\"5\">$extra</td>\n" .
+		      "</tr>\n";
+	}
+	print "</table>\n";
+}
+
+sub git_heads_body {
+	# uses global variable $project
+	my ($taglist, $head, $from, $to, $extra) = @_;
+	$from = 0 unless defined $from;
+	$to = $#{$taglist} if (!defined $to || $#{$taglist} < $to);
+
+	print "<table class=\"heads\" cellspacing=\"0\">\n";
+	my $alternate = 0;
+	for (my $i = $from; $i <= $to; $i++) {
+		my $entry = $taglist->[$i];
+		my %tag = %$entry;
+		my $curr = $tag{'id'} eq $head;
+		if ($alternate) {
+			print "<tr class=\"dark\">\n";
+		} else {
+			print "<tr class=\"light\">\n";
+		}
+		$alternate ^= 1;
+		print "<td><i>$tag{'age'}</i></td>\n" .
+		      ($tag{'id'} eq $head ? "<td class=\"current_head\">" : "<td>") .
+		      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=shortlog;h=$tag{'name'}"),
+		               -class => "list"}, "<b>" . esc_html($tag{'name'}) . "</b>") .
+		      "</td>\n" .
+		      "<td class=\"link\">" .
+		      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=shortlog;h=$tag{'name'}")}, "shortlog") . " | " .
+		      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=log;h=$tag{'name'}")}, "log") .
+		      "</td>\n" .
+		      "</tr>";
+	}
+	if (defined $extra) {
+		print "<tr>\n" .
+		      "<td colspan=\"3\">$extra</td>\n" .
+		      "</tr>\n";
+	}
+	print "</table>\n";
+}
+
 sub git_summary {
 	my $descr = git_read_description($project) || "none";
 	my $head = git_read_head($project);
@@ -1139,138 +1293,36 @@ sub git_summary {
 	my $refs = read_info_ref();
 	git_header_html();
 	git_page_nav('summary','', $head);
+
 	print "<div class=\"title\">&nbsp;</div>\n";
 	print "<table cellspacing=\"0\">\n" .
 	      "<tr><td>description</td><td>" . esc_html($descr) . "</td></tr>\n" .
 	      "<tr><td>owner</td><td>$owner</td></tr>\n" .
 	      "<tr><td>last change</td><td>$cd{'rfc2822'}</td></tr>\n" .
 	      "</table>\n";
+
 	open my $fd, "-|", $GIT, "rev-list", "--max-count=17", git_read_head($project) 
 		or die_error(undef, "Open git-rev-list failed.");
 	my @revlist = map { chomp; $_ } <$fd>;
 	close $fd;
 	git_header_div('shortlog');
-	my $i = 16;
-	print "<table cellspacing=\"0\">\n";
-	my $alternate = 0;
-	foreach my $commit (@revlist) {
-		my %co = git_read_commit($commit);
-		my %ad = date_str($co{'author_epoch'});
-		if ($alternate) {
-			print "<tr class=\"dark\">\n";
-		} else {
-			print "<tr class=\"light\">\n";
-		}
-		$alternate ^= 1;
-		if ($i-- > 0) {
-			my $ref = git_get_referencing($refs, $commit);
-			print "<td><i>$co{'age_string'}</i></td>\n" .
-			      "<td><i>" . esc_html(chop_str($co{'author_name'}, 10)) . "</i></td>\n" .
-			      "<td>";
-			if (length($co{'title_short'}) < length($co{'title'})) {
-				print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$commit"), -class => "list", -title => "$co{'title'}"},
-				      "<b>" . esc_html($co{'title_short'}) . "$ref</b>");
-			} else {
-				print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$commit"), -class => "list"},
-				      "<b>" . esc_html($co{'title'}) . "$ref</b>");
-			}
-			print "</td>\n" .
-			      "<td class=\"link\">" .
-			      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$commit")}, "commit") .
-			      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commitdiff;h=$commit")}, "commitdiff") .
-			      "</td>\n" .
-			      "</tr>";
-		} else {
-			print "<td>" . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=shortlog")}, "...") . "</td>\n" .
-			"</tr>";
-			last;
-		}
-	}
-	print "</table\n>";
+	git_shortlog_body(\@revlist, 0, 15, $refs,
+	                  $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=shortlog")}, "..."));
 
 	my $taglist = git_read_refs("refs/tags");
 	if (defined @$taglist) {
 		git_header_div('tags');
-		my $i = 16;
-		print "<table cellspacing=\"0\">\n";
-		my $alternate = 0;
-		foreach my $entry (@$taglist) {
-			my %tag = %$entry;
-			my $comment_lines = $tag{'comment'};
-			my $comment = shift @$comment_lines;
-			if (defined($comment)) {
-				$comment = chop_str($comment, 30, 5);
-			}
-			if ($alternate) {
-				print "<tr class=\"dark\">\n";
-			} else {
-				print "<tr class=\"light\">\n";
-			}
-			$alternate ^= 1;
-			if ($i-- > 0) {
-				print "<td><i>$tag{'age'}</i></td>\n" .
-				      "<td>" .
-				      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=$tag{'reftype'};h=$tag{'refid'}"), -class => "list"},
-				      "<b>" . esc_html($tag{'name'}) . "</b>") .
-				      "</td>\n" .
-				      "<td>";
-				if (defined($comment)) {
-					print $cgi->a({-class => "list", -href => "$my_uri?" . esc_param("p=$project;a=tag;h=$tag{'id'}")}, esc_html($comment));
-				}
-				print "</td>\n" .
-				      "<td class=\"link\">";
-				if ($tag{'type'} eq "tag") {
-					print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=tag;h=$tag{'id'}")}, "tag") . " | ";
-				}
-				print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=$tag{'reftype'};h=$tag{'refid'}")}, $tag{'reftype'});
-				if ($tag{'reftype'} eq "commit") {
-					print " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=shortlog;h=$tag{'name'}")}, "shortlog") .
-					      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=log;h=$tag{'refid'}")}, "log");
-				}
-				print "</td>\n" .
-				      "</tr>";
-			} else {
-				print "<td>" . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=tags")}, "...") . "</td>\n" .
-				"</tr>";
-				last;
-			}
-		}
-		print "</table\n>";
+		git_tags_body($taglist, 0, 15,
+		              $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=tags")}, "..."));
 	}
 
 	my $headlist = git_read_refs("refs/heads");
 	if (defined @$headlist) {
 		git_header_div('heads');
-		my $i = 16;
-		print "<table cellspacing=\"0\">\n";
-		my $alternate = 0;
-		foreach my $entry (@$headlist) {
-			my %tag = %$entry;
-			if ($alternate) {
-				print "<tr class=\"dark\">\n";
-			} else {
-				print "<tr class=\"light\">\n";
-			}
-			$alternate ^= 1;
-			if ($i-- > 0) {
-				print "<td><i>$tag{'age'}</i></td>\n" .
-				      "<td>" .
-				      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=shortlog;h=$tag{'name'}"), -class => "list"},
-				      "<b>" . esc_html($tag{'name'}) . "</b>") .
-				      "</td>\n" .
-				      "<td class=\"link\">" .
-				      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=shortlog;h=$tag{'name'}")}, "shortlog") .
-				      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=log;h=$tag{'name'}")}, "log") .
-				      "</td>\n" .
-				      "</tr>";
-			} else {
-				print "<td>" . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=heads")}, "...") . "</td>\n" .
-				"</tr>";
-				last;
-			}
-		}
-		print "</table\n>";
+		git_heads_body($taglist, $head, 0, 15,
+		               $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=heads")}, "..."));
 	}
+
 	git_footer_html();
 }
 
@@ -1472,48 +1524,11 @@ sub git_tags {
 	git_header_html();
 	git_page_nav('','', $head,undef,$head);
 	git_header_div('summary', $project);
-	print "<table cellspacing=\"0\">\n";
 
 	my $taglist = git_read_refs("refs/tags");
-	my $alternate = 0;
 	if (defined @$taglist) {
-		foreach my $entry (@$taglist) {
-			my %tag = %$entry;
-			my $comment_lines = $tag{'comment'};
-			my $comment = shift @$comment_lines;
-			if (defined($comment)) {
-				$comment = chop_str($comment, 30, 5);
-			}
-			if ($alternate) {
-				print "<tr class=\"dark\">\n";
-			} else {
-				print "<tr class=\"light\">\n";
-			}
-			$alternate ^= 1;
-			print "<td><i>$tag{'age'}</i></td>\n" .
-			      "<td>" .
-			      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=$tag{'reftype'};h=$tag{'refid'}"), -class => "list"},
-			      "<b>" . esc_html($tag{'name'}) . "</b>") .
-			      "</td>\n" .
-			      "<td>";
-			if (defined($comment)) {
-				print $cgi->a({-class => "list", -href => "$my_uri?" . esc_param("p=$project;a=tag;h=$tag{'id'}")}, $comment);
-			}
-			print "</td>\n" .
-			      "<td class=\"link\">";
-			if ($tag{'type'} eq "tag") {
-				print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=tag;h=$tag{'id'}")}, "tag") . " | ";
-			}
-			print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=$tag{'reftype'};h=$tag{'refid'}")}, $tag{'reftype'});
-			if ($tag{'reftype'} eq "commit") {
-				print " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=shortlog;h=$tag{'name'}")}, "shortlog") .
-				      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=log;h=$tag{'refid'}")}, "log");
-			}
-			print "</td>\n" .
-			      "</tr>";
-		}
+		git_tags_body($taglist);
 	}
-	print "</table\n>";
 	git_footer_html();
 }
 
@@ -1521,32 +1536,13 @@ sub git_heads {
 	my $head = git_read_head($project);
 	git_header_html();
 	git_page_nav('','', $head,undef,$head);
-	hit_header_div('summary', $project);
-	print "<table cellspacing=\"0\">\n";
+	git_header_div('summary', $project);
 
 	my $taglist = git_read_refs("refs/heads");
 	my $alternate = 0;
 	if (defined @$taglist) {
-		foreach my $entry (@$taglist) {
-			my %tag = %$entry;
-			if ($alternate) {
-				print "<tr class=\"dark\">\n";
-			} else {
-				print "<tr class=\"light\">\n";
-			}
-			$alternate ^= 1;
-			print "<td><i>$tag{'age'}</i></td>\n" .
-			      "<td>" .
-			      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=shortlog;h=$tag{'name'}"), -class => "list"}, "<b>" . esc_html($tag{'name'}) . "</b>") .
-			      "</td>\n" .
-			      "<td class=\"link\">" .
-			      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=shortlog;h=$tag{'name'}")}, "shortlog") .
-			      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=log;h=$tag{'name'}")}, "log") .
-			      "</td>\n" .
-			      "</tr>";
-		}
+		git_heads_body($taglist, $head);
 	}
-	print "</table\n>";
 	git_footer_html();
 }
 
@@ -2544,48 +2540,19 @@ sub git_shortlog {
 	close $fd;
 
 	my $paging_nav = git_get_paging_nav('shortlog', $hash, $head, $page, $#revlist);
+	my $next_link = '';
+	if ($#revlist >= (100 * ($page+1)-1)) {
+		$next_link =
+			$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=shortlog;h=$hash;pg=" . ($page+1)),
+			         -title => "Alt-n"}, "next");
+	}
+
 
 	git_header_html();
 	git_page_nav('shortlog','', $hash,$hash,$hash, $paging_nav);
 	git_header_div('summary', $project);
 
-	print "<table cellspacing=\"0\">\n";
-	my $alternate = 0;
-	for (my $i = ($page * 100); $i <= $#revlist; $i++) {
-		my $commit = $revlist[$i];
-		my $ref = git_get_referencing($refs, $commit);
-		my %co = git_read_commit($commit);
-		my %ad = date_str($co{'author_epoch'});
-		if ($alternate) {
-			print "<tr class=\"dark\">\n";
-		} else {
-			print "<tr class=\"light\">\n";
-		}
-		$alternate ^= 1;
-		print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
-		      "<td><i>" . esc_html(chop_str($co{'author_name'}, 10)) . "</i></td>\n" .
-		      "<td>";
-		if (length($co{'title_short'}) < length($co{'title'})) {
-			print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$commit"), -class => "list", -title => "$co{'title'}"},
-			      "<b>" . esc_html($co{'title_short'}) . "$ref</b>");
-		} else {
-			print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$commit"), -class => "list"},
-			      "<b>" . esc_html($co{'title_short'}) . "$ref</b>");
-		}
-		print "</td>\n" .
-		      "<td class=\"link\">" .
-		      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commit;h=$commit")}, "commit") .
-		      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=commitdiff;h=$commit")}, "commitdiff") .
-		      "</td>\n" .
-		      "</tr>";
-	}
-	if ($#revlist >= (100 * ($page+1)-1)) {
-		print "<tr>\n" .
-		      "<td>" .
-		      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=shortlog;h=$hash;pg=" . ($page+1)), -title => "Alt-n"}, "next") .
-		      "</td>\n" .
-		      "</tr>\n";
-	}
-	print "</table\n>";
+	git_shortlog_body(\@revlist, ($page * 100), $#revlist, $refs, $next_link);
+
 	git_footer_html();
 }
diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index fffdb13..460e728 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -181,12 +181,16 @@ td {
 	vertical-align: top;
 }
 
-td.link {
+td.link, td.selflink {
 	padding: 2px 5px;
 	font-family: sans-serif;
 	font-size: 10px;
 }
 
+td.selflink {
+	padding-right: 0px;
+}
+
 td.sha1 {
 	font-family: monospace;
 }
@@ -196,6 +200,10 @@ td.error {
 	background-color: yellow;
 }
 
+td.current_head {
+	text-decoration: underline;
+}
+
 table.diff_tree span.file_status.new {
 	color: #008000;
 }
-- 
1.4.0
