From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 3/5] gitweb: Split body of git_search into subroutines
Date: Wed, 22 Jun 2011 17:28:53 +0200
Message-ID: <1308756535-29701-4-git-send-email-jnareb@gmail.com>
References: <1308756535-29701-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>, admin@repo.or.cz,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 22 17:29:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZPNI-0002OT-T3
	for gcvg-git-2@lo.gmane.org; Wed, 22 Jun 2011 17:29:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395Ab1FVP3d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jun 2011 11:29:33 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59791 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932380Ab1FVP31 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2011 11:29:27 -0400
Received: by mail-fx0-f46.google.com with SMTP id 17so714045fxm.19
        for <git@vger.kernel.org>; Wed, 22 Jun 2011 08:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=GGDuuW3uZkdgSau4Dakr5WZ4KyQF/iC95xyFpxASxrY=;
        b=rNTnedTCkWpkaaY8fHN72GZbDE+xpPNEzFLIdW176mUUENdHKMZ6pCdYrVYynh0u94
         49MNFdWUssX1AWryarRgoLuHyW2U0JlnKkV7jcK0WIpTQsrLp5K09E1URhQHxEByw9AR
         1rLqshMw0zxi9TOnJQ/oSzXoMzhhWhhZ5IDGE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=WcSyRQ2oi1WmMX49IHugdKfyNJChmpooal1gKpRtJ73PQY7IckNHowOEJiwpaA/kCm
         uIQdFyaIEbXPtQDdmANs70tiUsOyUhvJ2oAUxM4G/HsO8DkJ5WA04jMGTUmHMuyUQC/1
         CE2LMcZUHajcw8DdmokRz1kKAUpnsik/iImhk=
Received: by 10.223.61.72 with SMTP id s8mr1036956fah.6.1308756567113;
        Wed, 22 Jun 2011 08:29:27 -0700 (PDT)
Received: from localhost.localdomain (abuz77.neoplus.adsl.tpnet.pl [83.8.197.77])
        by mx.google.com with ESMTPS id l26sm400935fah.14.2011.06.22.08.29.24
        (version=SSLv3 cipher=OTHER);
        Wed, 22 Jun 2011 08:29:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.5
In-Reply-To: <1308756535-29701-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176244>

Create separate subroutines for handling each of aspects of searching
the repository:
* git_search_mesaage ('commit', 'author', 'committer')
* git_search_changes ('pickaxe')
* git_search_content_of_files ('grep')

Almost pure code movement (and unindent), which you can check e.g. via

  $ git blame -w --date=short -C -C HEAD^.. -- gitweb/gitweb.perl |
    grep -C 3 -e '^[^^]' | less -S

(assuming that you have this version checked out).  No functional
changes.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |  381 +++++++++++++++++++++++++++-------------------------
 1 files changed, 199 insertions(+), 182 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 32e50b4..c350c05 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5540,6 +5540,197 @@ sub git_remotes_body {
 	}
 }
 
+sub git_search_message {
+	my %co = @_;
+
+	my $greptype;
+	if ($searchtype eq 'commit') {
+		$greptype = "--grep=";
+	} elsif ($searchtype eq 'author') {
+		$greptype = "--author=";
+	} elsif ($searchtype eq 'committer') {
+		$greptype = "--committer=";
+	}
+	$greptype .= $searchtext;
+	my @commitlist = parse_commits($hash, 101, (100 * $page), undef,
+	                               $greptype, '--regexp-ignore-case',
+	                               $search_use_regexp ? '--extended-regexp' : '--fixed-strings');
+
+	my $paging_nav = '';
+	if ($page > 0) {
+		$paging_nav .=
+			$cgi->a({-href => href(action=>"search", hash=>$hash,
+			                       searchtext=>$searchtext,
+			                       searchtype=>$searchtype)},
+			        "first");
+		$paging_nav .= " &sdot; " .
+			$cgi->a({-href => href(-replay=>1, page=>$page-1),
+			         -accesskey => "p", -title => "Alt-p"}, "prev");
+	} else {
+		$paging_nav .= "first";
+		$paging_nav .= " &sdot; prev";
+	}
+	my $next_link = '';
+	if ($#commitlist >= 100) {
+		$next_link =
+			$cgi->a({-href => href(-replay=>1, page=>$page+1),
+			         -accesskey => "n", -title => "Alt-n"}, "next");
+		$paging_nav .= " &sdot; $next_link";
+	} else {
+		$paging_nav .= " &sdot; next";
+	}
+
+	git_print_page_nav('','', $hash,$co{'tree'},$hash, $paging_nav);
+	git_print_header_div('commit', esc_html($co{'title'}), $hash);
+	if ($page == 0 && !@commitlist) {
+		print "<p>No match.</p>\n";
+	} else {
+		git_search_grep_body(\@commitlist, 0, 99, $next_link);
+	}
+}
+
+sub git_search_changes {
+	my %co = @_;
+
+	git_print_page_nav('','', $hash,$co{'tree'},$hash);
+	git_print_header_div('commit', esc_html($co{'title'}), $hash);
+
+	print "<table class=\"pickaxe search\">\n";
+	my $alternate = 1;
+	local $/ = "\n";
+	open my $fd, '-|', git_cmd(), '--no-pager', 'log', @diff_opts,
+		'--pretty=format:%H', '--no-abbrev', '--raw', "-S$searchtext",
+		($search_use_regexp ? '--pickaxe-regex' : ());
+	undef %co;
+	my @files;
+	while (my $line = <$fd>) {
+		chomp $line;
+		next unless $line;
+
+		my %set = parse_difftree_raw_line($line);
+		if (defined $set{'commit'}) {
+			# finish previous commit
+			if (%co) {
+				print "</td>\n" .
+				      "<td class=\"link\">" .
+				      $cgi->a({-href => href(action=>"commit", hash=>$co{'id'})}, "commit") .
+				      " | " .
+				      $cgi->a({-href => href(action=>"tree", hash=>$co{'tree'}, hash_base=>$co{'id'})}, "tree");
+				print "</td>\n" .
+				      "</tr>\n";
+			}
+
+			if ($alternate) {
+				print "<tr class=\"dark\">\n";
+			} else {
+				print "<tr class=\"light\">\n";
+			}
+			$alternate ^= 1;
+			%co = parse_commit($set{'commit'});
+			my $author = chop_and_escape_str($co{'author_name'}, 15, 5);
+			print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
+			      "<td><i>$author</i></td>\n" .
+			      "<td>" .
+			      $cgi->a({-href => href(action=>"commit", hash=>$co{'id'}),
+			              -class => "list subject"},
+			              chop_and_escape_str($co{'title'}, 50) . "<br/>");
+		} elsif (defined $set{'to_id'}) {
+			next if ($set{'to_id'} =~ m/^0{40}$/);
+
+			print $cgi->a({-href => href(action=>"blob", hash_base=>$co{'id'},
+			                             hash=>$set{'to_id'}, file_name=>$set{'to_file'}),
+			              -class => "list"},
+			              "<span class=\"match\">" . esc_path($set{'file'}) . "</span>") .
+			      "<br/>\n";
+		}
+	}
+	close $fd;
+
+	# finish last commit (warning: repetition!)
+	if (%co) {
+		print "</td>\n" .
+		      "<td class=\"link\">" .
+		      $cgi->a({-href => href(action=>"commit", hash=>$co{'id'})}, "commit") .
+		      " | " .
+		      $cgi->a({-href => href(action=>"tree", hash=>$co{'tree'}, hash_base=>$co{'id'})}, "tree");
+		print "</td>\n" .
+		      "</tr>\n";
+	}
+
+	print "</table>\n";
+}
+
+sub git_search_files {
+	my %co = @_;
+
+	git_print_page_nav('','', $hash,$co{'tree'},$hash);
+	git_print_header_div('commit', esc_html($co{'title'}), $hash);
+
+	print "<table class=\"grep_search\">\n";
+	my $alternate = 1;
+	my $matches = 0;
+	local $/ = "\n";
+	open my $fd, "-|", git_cmd(), 'grep', '-n',
+		$search_use_regexp ? ('-E', '-i') : '-F',
+		$searchtext, $co{'tree'};
+	my $lastfile = '';
+	while (my $line = <$fd>) {
+		chomp $line;
+		my ($file, $lno, $ltext, $binary);
+		last if ($matches++ > 1000);
+		if ($line =~ /^Binary file (.+) matches$/) {
+			$file = $1;
+			$binary = 1;
+		} else {
+			(undef, $file, $lno, $ltext) = split(/:/, $line, 4);
+		}
+		if ($file ne $lastfile) {
+			$lastfile and print "</td></tr>\n";
+			if ($alternate++) {
+				print "<tr class=\"dark\">\n";
+			} else {
+				print "<tr class=\"light\">\n";
+			}
+			print "<td class=\"list\">".
+				$cgi->a({-href => href(action=>"blob", hash=>$co{'hash'},
+						       file_name=>"$file"),
+					-class => "list"}, esc_path($file));
+			print "</td><td>\n";
+			$lastfile = $file;
+		}
+		if ($binary) {
+			print "<div class=\"binary\">Binary file</div>\n";
+		} else {
+			$ltext = untabify($ltext);
+			if ($ltext =~ m/^(.*)($search_regexp)(.*)$/i) {
+				$ltext = esc_html($1, -nbsp=>1);
+				$ltext .= '<span class="match">';
+				$ltext .= esc_html($2, -nbsp=>1);
+				$ltext .= '</span>';
+				$ltext .= esc_html($3, -nbsp=>1);
+			} else {
+				$ltext = esc_html($ltext, -nbsp=>1);
+			}
+			print "<div class=\"pre\">" .
+				$cgi->a({-href => href(action=>"blob", hash=>$co{'hash'},
+						       file_name=>"$file").'#l'.$lno,
+					-class => "linenr"}, sprintf('%4i', $lno))
+				. ' ' .  $ltext . "</div>\n";
+		}
+	}
+	if ($lastfile) {
+		print "</td></tr>\n";
+		if ($matches > 1000) {
+			print "<div class=\"diff nodifferences\">Too many matches, listing trimmed</div>\n";
+		}
+	} else {
+		print "<div class=\"diff nodifferences\">No matches found</div>\n";
+	}
+	close $fd;
+
+	print "</table>\n";
+}
+
 sub git_search_grep_body {
 	my ($commitlist, $from, $to, $extra) = @_;
 	$from = 0 unless defined $from;
@@ -7127,190 +7318,16 @@ sub git_search {
 
 	git_header_html();
 
-	if ($searchtype eq 'commit' or $searchtype eq 'author' or $searchtype eq 'committer') {
-		my $greptype;
-		if ($searchtype eq 'commit') {
-			$greptype = "--grep=";
-		} elsif ($searchtype eq 'author') {
-			$greptype = "--author=";
-		} elsif ($searchtype eq 'committer') {
-			$greptype = "--committer=";
-		}
-		$greptype .= $searchtext;
-		my @commitlist = parse_commits($hash, 101, (100 * $page), undef,
-		                               $greptype, '--regexp-ignore-case',
-		                               $search_use_regexp ? '--extended-regexp' : '--fixed-strings');
-
-		my $paging_nav = '';
-		if ($page > 0) {
-			$paging_nav .=
-				$cgi->a({-href => href(action=>"search", hash=>$hash,
-				                       searchtext=>$searchtext,
-				                       searchtype=>$searchtype)},
-				        "first");
-			$paging_nav .= " &sdot; " .
-				$cgi->a({-href => href(-replay=>1, page=>$page-1),
-				         -accesskey => "p", -title => "Alt-p"}, "prev");
-		} else {
-			$paging_nav .= "first";
-			$paging_nav .= " &sdot; prev";
-		}
-		my $next_link = '';
-		if ($#commitlist >= 100) {
-			$next_link =
-				$cgi->a({-href => href(-replay=>1, page=>$page+1),
-				         -accesskey => "n", -title => "Alt-n"}, "next");
-			$paging_nav .= " &sdot; $next_link";
-		} else {
-			$paging_nav .= " &sdot; next";
-		}
-
-		git_print_page_nav('','', $hash,$co{'tree'},$hash, $paging_nav);
-		git_print_header_div('commit', esc_html($co{'title'}), $hash);
-		if ($page == 0 && !@commitlist) {
-			print "<p>No match.</p>\n";
-		} else {
-			git_search_grep_body(\@commitlist, 0, 99, $next_link);
-		}
+	if ($searchtype eq 'commit' ||
+	    $searchtype eq 'author' ||
+	    $searchtype eq 'committer') {
+		git_search_message(%co);
+	} elsif ($searchtype eq 'pickaxe') {
+		git_search_changes(%co);
+	} elsif ($searchtype eq 'grep') {
+		git_search_files(%co);
 	}
 
-	if ($searchtype eq 'pickaxe') {
-		git_print_page_nav('','', $hash,$co{'tree'},$hash);
-		git_print_header_div('commit', esc_html($co{'title'}), $hash);
-
-		print "<table class=\"pickaxe search\">\n";
-		my $alternate = 1;
-		local $/ = "\n";
-		open my $fd, '-|', git_cmd(), '--no-pager', 'log', @diff_opts,
-			'--pretty=format:%H', '--no-abbrev', '--raw', "-S$searchtext",
-			($search_use_regexp ? '--pickaxe-regex' : ());
-		undef %co;
-		my @files;
-		while (my $line = <$fd>) {
-			chomp $line;
-			next unless $line;
-
-			my %set = parse_difftree_raw_line($line);
-			if (defined $set{'commit'}) {
-				# finish previous commit
-				if (%co) {
-					print "</td>\n" .
-					      "<td class=\"link\">" .
-					      $cgi->a({-href => href(action=>"commit", hash=>$co{'id'})}, "commit") .
-					      " | " .
-					      $cgi->a({-href => href(action=>"tree", hash=>$co{'tree'}, hash_base=>$co{'id'})}, "tree");
-					print "</td>\n" .
-					      "</tr>\n";
-				}
-
-				if ($alternate) {
-					print "<tr class=\"dark\">\n";
-				} else {
-					print "<tr class=\"light\">\n";
-				}
-				$alternate ^= 1;
-				%co = parse_commit($set{'commit'});
-				my $author = chop_and_escape_str($co{'author_name'}, 15, 5);
-				print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
-				      "<td><i>$author</i></td>\n" .
-				      "<td>" .
-				      $cgi->a({-href => href(action=>"commit", hash=>$co{'id'}),
-				              -class => "list subject"},
-				              chop_and_escape_str($co{'title'}, 50) . "<br/>");
-			} elsif (defined $set{'to_id'}) {
-				next if ($set{'to_id'} =~ m/^0{40}$/);
-
-				print $cgi->a({-href => href(action=>"blob", hash_base=>$co{'id'},
-				                             hash=>$set{'to_id'}, file_name=>$set{'to_file'}),
-				              -class => "list"},
-				              "<span class=\"match\">" . esc_path($set{'file'}) . "</span>") .
-				      "<br/>\n";
-			}
-		}
-		close $fd;
-
-		# finish last commit (warning: repetition!)
-		if (%co) {
-			print "</td>\n" .
-			      "<td class=\"link\">" .
-			      $cgi->a({-href => href(action=>"commit", hash=>$co{'id'})}, "commit") .
-			      " | " .
-			      $cgi->a({-href => href(action=>"tree", hash=>$co{'tree'}, hash_base=>$co{'id'})}, "tree");
-			print "</td>\n" .
-			      "</tr>\n";
-		}
-
-		print "</table>\n";
-	}
-
-	if ($searchtype eq 'grep') {
-		git_print_page_nav('','', $hash,$co{'tree'},$hash);
-		git_print_header_div('commit', esc_html($co{'title'}), $hash);
-
-		print "<table class=\"grep_search\">\n";
-		my $alternate = 1;
-		my $matches = 0;
-		local $/ = "\n";
-		open my $fd, "-|", git_cmd(), 'grep', '-n',
-			$search_use_regexp ? ('-E', '-i') : '-F',
-			$searchtext, $co{'tree'};
-		my $lastfile = '';
-		while (my $line = <$fd>) {
-			chomp $line;
-			my ($file, $lno, $ltext, $binary);
-			last if ($matches++ > 1000);
-			if ($line =~ /^Binary file (.+) matches$/) {
-				$file = $1;
-				$binary = 1;
-			} else {
-				(undef, $file, $lno, $ltext) = split(/:/, $line, 4);
-			}
-			if ($file ne $lastfile) {
-				$lastfile and print "</td></tr>\n";
-				if ($alternate++) {
-					print "<tr class=\"dark\">\n";
-				} else {
-					print "<tr class=\"light\">\n";
-				}
-				print "<td class=\"list\">".
-					$cgi->a({-href => href(action=>"blob", hash=>$co{'hash'},
-							       file_name=>"$file"),
-						-class => "list"}, esc_path($file));
-				print "</td><td>\n";
-				$lastfile = $file;
-			}
-			if ($binary) {
-				print "<div class=\"binary\">Binary file</div>\n";
-			} else {
-				$ltext = untabify($ltext);
-				if ($ltext =~ m/^(.*)($search_regexp)(.*)$/i) {
-					$ltext = esc_html($1, -nbsp=>1);
-					$ltext .= '<span class="match">';
-					$ltext .= esc_html($2, -nbsp=>1);
-					$ltext .= '</span>';
-					$ltext .= esc_html($3, -nbsp=>1);
-				} else {
-					$ltext = esc_html($ltext, -nbsp=>1);
-				}
-				print "<div class=\"pre\">" .
-					$cgi->a({-href => href(action=>"blob", hash=>$co{'hash'},
-							       file_name=>"$file").'#l'.$lno,
-						-class => "linenr"}, sprintf('%4i', $lno))
-					. ' ' .  $ltext . "</div>\n";
-			}
-		}
-		if ($lastfile) {
-			print "</td></tr>\n";
-			if ($matches > 1000) {
-				print "<div class=\"diff nodifferences\">Too many matches, listing trimmed</div>\n";
-			}
-		} else {
-			print "<div class=\"diff nodifferences\">No matches found</div>\n";
-		}
-		close $fd;
-
-		print "</table>\n";
-	}
 	git_footer_html();
 }
 
-- 
1.7.5
