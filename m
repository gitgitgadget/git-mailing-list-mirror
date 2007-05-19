From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH 3/3] gitweb: Clearly distinguish regexp / exact match searches
Date: Sat, 19 May 2007 02:13:39 +0200
Message-ID: <20070519001339.28618.61624.stgit@rover>
References: <20070519001329.28618.31334.stgit@rover>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Jakub Narebski <jnareb@gmail.com>,
	Petr Baudis <pasky@suse.cz>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 19 02:13:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpCZy-0002j4-F8
	for gcvg-git@gmane.org; Sat, 19 May 2007 02:13:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754518AbXESANp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 20:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754717AbXESANp
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 20:13:45 -0400
Received: from rover.dkm.cz ([62.24.64.27]:52350 "EHLO rover.dkm.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754518AbXESANo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 20:13:44 -0400
Received: from [127.0.0.1] (rover [127.0.0.1])
	by rover.dkm.cz (Postfix) with ESMTP id DBA718B722;
	Sat, 19 May 2007 02:13:39 +0200 (CEST)
In-Reply-To: <20070519001329.28618.31334.stgit@rover>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47693>

This patch does a couple of things:

* Makes commit/author/committer search case insensitive

	To be consistent with the grep search; I see no convincing
	reason for the search to be case sensitive, and you might
	get in trouble especially with contributors e.g. from Japan
	or France where they sometimes like to uppercase their last
	name.

* Makes grep search by default grep for fixed strings

	Since we will have a checkbox.

* Introduces 're' checkbox that enables POSIX extended regexp searches

	This works for all the search types. The idea comes from Jakub.

It does not make much sense (and is not easy at all) to untangle most of
these changes from each other, thus they all go in a single patch.

Cc: Jakub Narebski <jnareb@gmail.com>
Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 gitweb/gitweb.perl |   50 +++++++++++++++++++++++++++++++++-----------------
 1 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 4ccb4e3..846392e 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -401,13 +401,15 @@ if (defined $searchtype) {
 	}
 }
 
+our $search_use_regexp = $cgi->param('sr');
+
 our $searchtext = $cgi->param('s');
 our $search_regexp;
 if (defined $searchtext) {
 	if (length($searchtext) < 2) {
 		die_error(undef, "At least two characters are required for search parameter");
 	}
-	$search_regexp = quotemeta $searchtext;
+	$search_regexp = $search_use_regexp ? $searchtext : quotemeta $searchtext;
 }
 
 # now read PATH_INFO and use it as alternative to parameters
@@ -535,6 +537,7 @@ sub href(%) {
 		order => "o",
 		searchtext => "s",
 		searchtype => "st",
+		search_use_regexp => "sr",
 	);
 	my %mapping = @mapping;
 
@@ -1579,7 +1582,7 @@ sub parse_commit {
 }
 
 sub parse_commits {
-	my ($commit_id, $maxcount, $skip, $arg, $filename) = @_;
+	my ($commit_id, $maxcount, $skip, $filename, @args) = @_;
 	my @cos;
 
 	$maxcount ||= 1;
@@ -1589,7 +1592,7 @@ sub parse_commits {
 
 	open my $fd, "-|", git_cmd(), "rev-list",
 		"--header",
-		($arg ? ($arg) : ()),
+		@args,
 		("--max-count=" . $maxcount),
 		("--skip=" . $skip),
 		$commit_id,
@@ -2007,6 +2010,9 @@ EOF
 		      $cgi->sup($cgi->a({-href => href(action=>"search_help")}, "?")) .
 		      " search:\n",
 		      $cgi->textfield(-name => "s", -value => $searchtext) . "\n" .
+		      "<span title=\"Extended regular expression\">" .
+		      $cgi->checkbox(-name => 'sr', -value => 1, -checked => $search_use_regexp, -label => 're') .
+		      "</span>" .
 		      "</div>" .
 		      $cgi->end_form() . "\n";
 	}
@@ -4655,7 +4661,7 @@ sub git_history {
 		$ftype = git_get_type($hash);
 	}
 
-	my @commitlist = parse_commits($hash_base, 101, (100 * $page), "--full-history", $file_name);
+	my @commitlist = parse_commits($hash_base, 101, (100 * $page), $file_name, "--full-history");
 
 	my $paging_nav = '';
 	if ($page > 0) {
@@ -4745,7 +4751,9 @@ sub git_search {
 			$greptype = "--committer=";
 		}
 		$greptype .= $search_regexp;
-		my @commitlist = parse_commits($hash, 101, (100 * $page), $greptype);
+		my @commitlist = parse_commits($hash, 101, (100 * $page), undef,
+		                               $greptype, $search_use_regexp ? ('--extended-regexp') : (),
+					       '--regexp-ignore-case');
 
 		my $paging_nav = '';
 		if ($page > 0) {
@@ -4795,8 +4803,9 @@ sub git_search {
 		my $git_command = git_cmd_str();
 		my $searchqtext = $searchtext;
 		$searchqtext =~ s/'/'\\''/;
+		my $pickaxe_flags = $search_use_regexp ? '--pickaxe-regex' : '';
 		open my $fd, "-|", "$git_command rev-list $hash | " .
-			"$git_command diff-tree -r --stdin -S\'$searchqtext\'";
+			"$git_command diff-tree -r --stdin -S\'$searchqtext\' $pickaxe_flags";
 		undef %co;
 		my @files;
 		while (my $line = <$fd>) {
@@ -4859,7 +4868,9 @@ sub git_search {
 		my $alternate = 1;
 		my $matches = 0;
 		$/ = "\n";
-		open my $fd, "-|", git_cmd(), 'grep', '-n', '-i', '-E', $searchtext, $co{'tree'};
+		open my $fd, "-|", git_cmd(), 'grep', '-n',
+			$search_use_regexp ? ('-E', '-i') : '-F',
+			$searchtext, $co{'tree'};
 		my $lastfile = '';
 		while (my $line = <$fd>) {
 			chomp $line;
@@ -4889,7 +4900,7 @@ sub git_search {
 				print "<div class=\"binary\">Binary file</div>\n";
 			} else {
 				$ltext = untabify($ltext);
-				if ($ltext =~ m/^(.*)($searchtext)(.*)$/i) {
+				if ($ltext =~ m/^(.*)($search_regexp)(.*)$/i) {
 					$ltext = esc_html($1, -nbsp=>1);
 					$ltext .= '<span class="match">';
 					$ltext .= esc_html($2, -nbsp=>1);
@@ -4924,27 +4935,31 @@ sub git_search_help {
 	git_header_html();
 	git_print_page_nav('','', $hash,$hash,$hash);
 	print <<EOT;
+<p><strong>Pattern</strong> is by default a normal string that is matched precisely (but without
+regard to case, except in the case of pickaxe). However, when you check the <em>re</em> checkbox,
+the pattern entered is recognized as the POSIX extended
+<a href="http://en.wikipedia.org/wiki/Regular_expression">regular expression</a> (also case
+insensitive).</p>
 <dl>
 <dt><b>commit</b></dt>
-<dd>The commit messages and authorship information will be scanned for the given string.</dd>
+<dd>The commit messages and authorship information will be scanned for the given pattern.</dd>
 EOT
 	my ($have_grep) = gitweb_check_feature('grep');
 	if ($have_grep) {
 		print <<EOT;
 <dt><b>grep</b></dt>
 <dd>All files in the currently selected tree (HEAD unless you are explicitly browsing
-    a different one) are searched for the given
-<a href="http://en.wikipedia.org/wiki/Regular_expression">regular expression</a>
-(POSIX extended) and the matches are listed. On large
-trees, this search can take a while and put some strain on the server, so please use it with
-some consideration.</dd>
+    a different one) are searched for the given pattern. On large trees, this search can take
+a while and put some strain on the server, so please use it with some consideration. Note that
+due to git-grep peculiarity, currently if regexp mode is turned off, the matches are
+case-sensitive.</dd>
 EOT
 	}
 	print <<EOT;
 <dt><b>author</b></dt>
-<dd>Name and e-mail of the change author and date of birth of the patch will be scanned for the given string.</dd>
+<dd>Name and e-mail of the change author and date of birth of the patch will be scanned for the given pattern.</dd>
 <dt><b>committer</b></dt>
-<dd>Name and e-mail of the committer and date of commit will be scanned for the given string.</dd>
+<dd>Name and e-mail of the committer and date of commit will be scanned for the given pattern.</dd>
 EOT
 	my ($have_pickaxe) = gitweb_check_feature('pickaxe');
 	if ($have_pickaxe) {
@@ -4952,7 +4967,8 @@ EOT
 <dt><b>pickaxe</b></dt>
 <dd>All commits that caused the string to appear or disappear from any file (changes that
 added, removed or "modified" the string) will be listed. This search can take a while and
-takes a lot of strain on the server, so please use it wisely.</dd>
+takes a lot of strain on the server, so please use it wisely. Note that since you may be
+interested even in changes just changing the case as well, this search is case sensitive.</dd>
 EOT
 	}
 	print "</dl>\n";
