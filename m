From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] gitweb: Make search type a popup menu
Date: Tue, 24 Oct 2006 05:15:46 +0200
Message-ID: <20061024031546.2877.51620.stgit@rover>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 24 05:15:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcClb-00047O-T8
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 05:15:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369AbWJXDPs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 23:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932387AbWJXDPs
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 23:15:48 -0400
Received: from rover.dkm.cz ([62.24.64.27]:56450 "EHLO rover.dkm.cz")
	by vger.kernel.org with ESMTP id S932369AbWJXDPs (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Oct 2006 23:15:48 -0400
Received: from [127.0.0.1] (rover [127.0.0.1])
	by rover.dkm.cz (Postfix) with ESMTP id CF1018BC3B;
	Tue, 24 Oct 2006 05:15:46 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
User-Agent: StGIT/0.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29915>

This makes the multiple search types actually usable by the user;
if you don't read the gitweb source, you don't even have an idea
that you can write things like that there.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 gitweb/gitweb.css  |    2 ++
 gitweb/gitweb.perl |   61 ++++++++++++++++++++++++++++++++++++++--------------
 2 files changed, 47 insertions(+), 16 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index 3f62b6d..0eda982 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -333,6 +333,8 @@ div.index_include {
 }
 
 div.search {
+	font-size: 12px;
+	font-weight: normal;
 	margin: 4px 8px;
 	position: absolute;
 	top: 56px;
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 695c632..e77fc11 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -342,6 +342,13 @@ if (defined $searchtext) {
 	$searchtext = quotemeta $searchtext;
 }
 
+our $searchtype = $cgi->param('st');
+if (defined $searchtype) {
+	if ($searchtype =~ m/[^a-z]/) {
+		die_error(undef, "Invalid searchtype parameter");
+	}
+}
+
 # now read PATH_INFO and use it as alternative to parameters
 sub evaluate_path_info {
 	return if defined $project;
@@ -406,6 +413,7 @@ my %actions = (
 	"log" => \&git_log,
 	"rss" => \&git_rss,
 	"search" => \&git_search,
+	"search_help" => \&git_search_help,
 	"shortlog" => \&git_shortlog,
 	"summary" => \&git_summary,
 	"tag" => \&git_tag,
@@ -455,6 +463,7 @@ sub href(%) {
 		page => "pg",
 		order => "o",
 		searchtext => "s",
+		searchtype => "st",
 	);
 	my %mapping = @mapping;
 
@@ -1528,6 +1537,10 @@ #provides backwards capability for those
 		      $cgi->hidden(-name => "p") . "\n" .
 		      $cgi->hidden(-name => "a") . "\n" .
 		      $cgi->hidden(-name => "h") . "\n" .
+		      $cgi->popup_menu(-name => 'st', -default => 'commit',
+				       -values => ['commit', 'author', 'committer', 'pickaxe']) .
+		      $cgi->sup($cgi->a({-href => href(action=>"search_help")}, "?")) .
+		      " search:\n",
 		      $cgi->textfield(-name => "s", -value => $searchtext) . "\n" .
 		      "</div>" .
 		      $cgi->end_form() . "\n";
@@ -3573,18 +3586,8 @@ sub git_search {
 		die_error(undef, "Unknown commit object");
 	}
 
-	my $commit_search = 1;
-	my $author_search = 0;
-	my $committer_search = 0;
-	my $pickaxe_search = 0;
-	if ($searchtext =~ s/^author\\://i) {
-		$author_search = 1;
-	} elsif ($searchtext =~ s/^committer\\://i) {
-		$committer_search = 1;
-	} elsif ($searchtext =~ s/^pickaxe\\://i) {
-		$commit_search = 0;
-		$pickaxe_search = 1;
-
+	$searchtype ||= 'commit';
+	if ($searchtype eq 'pickaxe') {
 		# pickaxe may take all resources of your box and run for several minutes
 		# with every query - so decide by yourself how public you make this feature
 		my ($have_pickaxe) = gitweb_check_feature('pickaxe');
@@ -3592,23 +3595,24 @@ sub git_search {
 			die_error('403 Permission denied', "Permission denied");
 		}
 	}
+
 	git_header_html();
 	git_print_page_nav('','', $hash,$co{'tree'},$hash);
 	git_print_header_div('commit', esc_html($co{'title'}), $hash);
 
 	print "<table cellspacing=\"0\">\n";
 	my $alternate = 1;
-	if ($commit_search) {
+	if ($searchtype eq 'commit' or $searchtype eq 'author' or $searchtype eq 'committer') {
 		$/ = "\0";
 		open my $fd, "-|", git_cmd(), "rev-list", "--header", "--parents", $hash or next;
 		while (my $commit_text = <$fd>) {
 			if (!grep m/$searchtext/i, $commit_text) {
 				next;
 			}
-			if ($author_search && !grep m/\nauthor .*$searchtext/i, $commit_text) {
+			if ($searchtype eq 'author' && !grep m/\nauthor .*$searchtext/i, $commit_text) {
 				next;
 			}
-			if ($committer_search && !grep m/\ncommitter .*$searchtext/i, $commit_text) {
+			if ($searchtype eq 'committer' && !grep m/\ncommitter .*$searchtext/i, $commit_text) {
 				next;
 			}
 			my @commit_lines = split "\n", $commit_text;
@@ -3650,7 +3654,7 @@ sub git_search {
 		close $fd;
 	}
 
-	if ($pickaxe_search) {
+	if ($searchtype eq 'pickaxe') {
 		$/ = "\n";
 		my $git_command = git_cmd_str();
 		open my $fd, "-|", "$git_command rev-list $hash | " .
@@ -3710,6 +3714,31 @@ sub git_search {
 	git_footer_html();
 }
 
+sub git_search_help {
+	git_header_html();
+	git_print_page_nav('','', $hash,$hash,$hash);
+	print <<EOT;
+<dl>
+<dt><b>commit</b></dt>
+<dd>The commit messages and authorship information will be scanned for the given string.</dd>
+<dt><b>author</b></dt>
+<dd>Name and e-mail of the change author and date of birth of the patch will be scanned for the given string.</dd>
+<dt><b>committer</b></dt>
+<dd>Name and e-mail of the committer and date of commit will be scanned for the given string.</dd>
+EOT
+	my ($have_pickaxe) = gitweb_check_feature('pickaxe');
+	if ($have_pickaxe) {
+		print <<EOT;
+<dt><b>pickaxe</b></dt>
+<dd>All commits that caused the string to appear or disappear from any file (changes that
+added, removed or "modified" the string) will be listed. This search can take a while and
+takes a lot of strain on the server, so please use it wisely.</dd>
+EOT
+	}
+	print "</dl>\n";
+	git_footer_html();
+}
+
 sub git_shortlog {
 	my $head = git_get_head_hash($project);
 	if (!defined $hash) {
