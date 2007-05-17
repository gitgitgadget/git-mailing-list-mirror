From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] gitweb: Add support for grep searches
Date: Thu, 17 May 2007 04:31:12 +0200
Message-ID: <20070517023112.21056.62390.stgit@rover>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 17 04:31:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoVlw-00042A-1s
	for gcvg-git@gmane.org; Thu, 17 May 2007 04:31:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755177AbXEQCbP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 May 2007 22:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756309AbXEQCbP
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 22:31:15 -0400
Received: from rover.dkm.cz ([62.24.64.27]:54559 "EHLO rover.dkm.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755177AbXEQCbO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 22:31:14 -0400
Received: from [127.0.0.1] (rover [127.0.0.1])
	by rover.dkm.cz (Postfix) with ESMTP id CB1DC8B660;
	Thu, 17 May 2007 04:31:12 +0200 (CEST)
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47488>

The 'grep' type of search greps the currently selected tree for given
regexp and shows the results in a fancy table with links into blob view.
The number of shown matches is limited to 1000 and the whole feature
can be turned off (grepping linux-2.6.git already makes repo.or.cz a bit
unhappy).

This second revision makes it in documentation explicit that grep accepts
regexps, and makes grep accept extended regexps instead of basic regexps.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 gitweb/gitweb.css  |    4 ++
 gitweb/gitweb.perl |  123 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 125 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index 02623cb..9f0822f 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -484,3 +484,7 @@ span.atnight {
 span.match {
 	color: #e00000;
 }
+
+div.binary {
+	font-style: italic;
+}
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 549e027..f37fa0c 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -146,6 +146,19 @@ our %feature = (
 		'override' => 0,
 		'default' => [1]},
 
+	# Enable grep search, which will list the files in currently selected
+	# tree containing the given string. Enabled by default. This can be
+	# potentially CPU-intensive, of course.
+
+	# To enable system wide have in $GITWEB_CONFIG
+	# $feature{'grep'}{'default'} = [1];
+	# To have project specific config enable override in $GITWEB_CONFIG
+	# $feature{'grep'}{'override'} = 1;
+	# and in project config gitweb.grep = 0|1;
+	'grep' => {
+		'override' => 0,
+		'default' => [1]},
+
 	# Enable the pickaxe search, which will list the commits that modified
 	# a given string in a file. This can be practical and quite faster
 	# alternative to 'blame', but still potentially CPU-intensive.
@@ -245,6 +258,18 @@ sub gitweb_have_snapshot {
 	return $have_snapshot;
 }
 
+sub feature_grep {
+	my ($val) = git_get_project_config('grep', '--bool');
+
+	if ($val eq 'true') {
+		return (1);
+	} elsif ($val eq 'false') {
+		return (0);
+	}
+
+	return ($_[0]);
+}
+
 sub feature_pickaxe {
 	my ($val) = git_get_project_config('pickaxe', '--bool');
 
@@ -364,10 +389,17 @@ if (defined $page) {
 	}
 }
 
+our $searchtype = $cgi->param('st');
+if (defined $searchtype) {
+	if ($searchtype =~ m/[^a-z]/) {
+		die_error(undef, "Invalid searchtype parameter");
+	}
+}
+
 our $searchtext = $cgi->param('s');
 our $search_regexp;
 if (defined $searchtext) {
-	if ($searchtext =~ m/[^a-zA-Z0-9_\.\/\-\+\:\@ ]/) {
+	if ($searchtype ne 'grep' and $searchtext =~ m/[^a-zA-Z0-9_\.\/\-\+\:\@ ]/) {
 		die_error(undef, "Invalid search parameter");
 	}
 	if (length($searchtext) < 2) {
@@ -1923,7 +1955,7 @@ EOF
 		      $cgi->hidden(-name => "a") . "\n" .
 		      $cgi->hidden(-name => "h") . "\n" .
 		      $cgi->popup_menu(-name => 'st', -default => 'commit',
-		                       -values => ['commit', 'author', 'committer', 'pickaxe']) .
+		                       -values => ['commit', 'grep', 'author', 'committer', 'pickaxe']) .
 		      $cgi->sup($cgi->a({-href => href(action=>"search_help")}, "?")) .
 		      " search:\n",
 		      $cgi->textfield(-name => "s", -value => $searchtext) . "\n" .
@@ -4615,6 +4647,12 @@ sub git_search {
 			die_error('403 Permission denied', "Permission denied");
 		}
 	}
+	if ($searchtype eq 'grep') {
+		my ($have_grep) = gitweb_check_feature('grep');
+		if (!$have_grep) {
+			die_error('403 Permission denied', "Permission denied");
+		}
+	}
 
 	git_header_html();
 
@@ -4731,6 +4769,73 @@ sub git_search {
 
 		print "</table>\n";
 	}
+
+	if ($searchtype eq 'grep') {
+		git_print_page_nav('','', $hash,$co{'tree'},$hash);
+		git_print_header_div('commit', esc_html($co{'title'}), $hash);
+
+		print "<table cellspacing=\"0\">\n";
+		my $alternate = 1;
+		my $matches = 0;
+		$/ = "\n";
+		open my $fd, "-|", git_cmd(), 'grep', '-n', '-i', '-E', $searchtext, $co{'tree'};
+		my $lastfile = '';
+		while (my $line = <$fd>) {
+			chomp $line;
+			my ($file, $lno, $ltext, $binary);
+			last if ($matches++ > 1000);
+			if ($line =~ /^Binary file (.+) matches$/) {
+				$file = $1;
+				$binary = 1;
+			} else {
+				(undef, $file, $lno, $ltext) = split(/:/, $line, 4);
+			}
+			if ($file ne $lastfile) {
+				$lastfile and print "</td></tr>\n";
+				if ($alternate++) {
+					print "<tr class=\"dark\">\n";
+				} else {
+					print "<tr class=\"light\">\n";
+				}
+				print "<td class=\"list\">".
+					$cgi->a({-href => href(action=>"blob", hash=>$co{'hash'},
+							       file_name=>"$file"),
+						-class => "list"}, esc_path($file));
+				print "</td><td>\n";
+				$lastfile = $file;
+			}
+			if ($binary) {
+				print "<div class=\"binary\">Binary file</div>\n";
+			} else {
+				$ltext = untabify($ltext);
+				if ($ltext =~ m/^(.*)($searchtext)(.*)$/i) {
+					$ltext = esc_html($1, -nbsp=>1);
+					$ltext .= '<span class="match">';
+					$ltext .= esc_html($2, -nbsp=>1);
+					$ltext .= '</span>';
+					$ltext .= esc_html($3, -nbsp=>1);
+				} else {
+					$ltext = esc_html($ltext, -nbsp=>1);
+				}
+				print "<div class=\"pre\">" .
+					$cgi->a({-href => href(action=>"blob", hash=>$co{'hash'},
+							       file_name=>"$file").'#l'.$lno,
+						-class => "linenr"}, sprintf('%4i', $lno))
+					. ' ' .  $ltext . "</div>\n";
+			}
+		}
+		if ($lastfile) {
+			print "</td></tr>\n";
+			if ($matches > 1000) {
+				print "<div class=\"diff nodifferences\">Too many matches, listing trimmed</div>\n";
+			}
+		} else {
+			print "<div class=\"diff nodifferences\">No matches found</div>\n";
+		}
+		close $fd;
+
+		print "</table>\n";
+	}
 	git_footer_html();
 }
 
@@ -4741,6 +4846,20 @@ sub git_search_help {
 <dl>
 <dt><b>commit</b></dt>
 <dd>The commit messages and authorship information will be scanned for the given string.</dd>
+EOT
+	my ($have_grep) = gitweb_check_feature('grep');
+	if ($have_grep) {
+		print <<EOT;
+<dt><b>grep</b></dt>
+<dd>All files in the currently selected tree (HEAD unless you are explicitly browsing
+    a different one) are searched for the given
+<a href="http://en.wikipedia.org/wiki/Regular_expression">regular expression</a>
+(POSIX extended) and the matches are listed. On large
+trees, this search can take a while and put some strain on the server, so please use it with
+some consideration.</dd>
+EOT
+	}
+	print <<EOT;
 <dt><b>author</b></dt>
 <dd>Name and e-mail of the change author and date of birth of the patch will be scanned for the given string.</dd>
 <dt><b>committer</b></dt>
