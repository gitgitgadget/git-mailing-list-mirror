From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] gitweb: Polish the content tags support
Date: Fri,  6 Nov 2009 16:10:55 +0100
Message-ID: <1257520255-12698-1-git-send-email-pasky@suse.cz>
Cc: Petr Baudis <pasky@suse.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 06 16:19:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6QbP-0006Td-3P
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 16:19:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759005AbZKFPTN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2009 10:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759351AbZKFPTE
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 10:19:04 -0500
Received: from rover.dkm.cz ([62.24.64.27]:34890 "EHLO rover.dkm.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759355AbZKFPS7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2009 10:18:59 -0500
Received: by rover.dkm.cz (Postfix, from userid 1001)
	id 3E5A8165F0C; Fri,  6 Nov 2009 16:10:55 +0100 (CET)
X-Mailer: git-send-email 1.5.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132306>

This patch integrates the tag filtering CGI parameter into the framework
for parameter passing, dropping 'by_tag' and instead using query name 't'
and symbolic name 'ctag_filter'. Compatibility support for 'by_tag' query
name is retained.

This means that content tag links are now created using $cgi->a() and
the href() method, and that they now point to the proper action;
project_list in case of global content tags, forks in case of per-fork
content tags. Also any other arguments like sorting order of projects
are replayed within the links.

Signed-off-by: Petr Baudis <pasky@suse.cz>

---
 gitweb/gitweb.perl |   37 +++++++++++++++++++++++--------------
 1 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e82ca45..97e88b4 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -566,6 +566,7 @@ our @cgi_param_mapping = (
 	searchtext => "s",
 	searchtype => "st",
 	snapshot_format => "sf",
+	ctag_filter => 't',
 	extra_options => "opt",
 	search_use_regexp => "sr",
 );
@@ -622,6 +623,11 @@ while (my ($name, $symbol) = each %cgi_param_mapping) {
 	}
 }
 
+# Backwards compatibility - by_tag= <=> t=
+if ($cgi->param('by_tag')) {
+	$input_params{'ctag_filter'} = $cgi->param('by_tag');
+}
+
 # now read PATH_INFO and update the parameter list for missing parameters
 sub evaluate_path_info {
 	return if defined $input_params{'project'};
@@ -2257,7 +2263,7 @@ sub git_get_project_ctags {
 }
 
 sub git_populate_project_tagcloud {
-	my $ctags = shift;
+	my ($ctags, $action) = @_;
 
 	# First, merge different-cased tags; tags vote on casing
 	my %ctags_lc;
@@ -2280,7 +2286,8 @@ sub git_populate_project_tagcloud {
 			$title =~ s/ /&nbsp;/g;
 			$title =~ s/^/&nbsp;/g;
 			$title =~ s/$/&nbsp;/g;
-			$cloud->add($title, $home_link."?by_tag=".$_, $ctags_lc{$_}->{count});
+			$cloud->add($title, href(-replay=>1, action=>$action, ctag_filter=>$_),
+			            $ctags_lc{$_}->{count});
 		}
 	} else {
 		$cloud = \%ctags_lc;
@@ -2289,14 +2296,15 @@ sub git_populate_project_tagcloud {
 }
 
 sub git_show_project_tagcloud {
-	my ($cloud, $count) = @_;
+	my ($cloud, $count, $action) = @_;
 	print STDERR ref($cloud)."..\n";
 	if (ref $cloud eq 'HTML::TagCloud') {
 		return $cloud->html_and_css($count);
 	} else {
 		my @tags = sort { $cloud->{$a}->{count} <=> $cloud->{$b}->{count} } keys %$cloud;
 		return '<p align="center">' . join (', ', map {
-			"<a href=\"$home_link?by_tag=$_\">$cloud->{$_}->{topname}</a>"
+			$cgi->a({-href => href(-replay=>1, action=>$action, ctag_filter=>$_)},
+				$cloud->{$_}->{topname});
 		} splice(@tags, 0, $count)) . '</p>';
 	}
 }
@@ -4254,7 +4262,8 @@ sub print_sort_th {
 }
 
 sub git_project_list_ctags {
-	my ($projects) = @_;
+	my ($projects, $action) = @_;
+	$action ||= 'project_list';
 
 	my %ctags;
 	foreach my $p (@$projects) {
@@ -4262,13 +4271,13 @@ sub git_project_list_ctags {
 			$ctags{$ct} += $p->{'ctags'}->{$ct};
 		}
 	}
-	my $cloud = git_populate_project_tagcloud(\%ctags);
-	print git_show_project_tagcloud($cloud, 64);
+	my $cloud = git_populate_project_tagcloud(\%ctags, $action);
+	print git_show_project_tagcloud($cloud, 64, $action);
 }
 
 sub git_project_list_body {
 	# actually uses global variable $project
-	my ($projlist, $order, $from, $to, $extra, $no_header) = @_;
+	my ($projlist, $order, $from, $to, $extra, $no_header, $ctags_action) = @_;
 
 	my $check_forks = gitweb_check_feature('forks');
 	my $show_ctags = gitweb_check_feature('ctags');
@@ -4292,7 +4301,7 @@ sub git_project_list_body {
 	}
 
 	if ($show_ctags) {
-		git_project_list_ctags(\@projects);
+		git_project_list_ctags(\@projects, $ctags_action);
 	}
 
 	print "<table class=\"project_list\">\n";
@@ -4309,7 +4318,7 @@ sub git_project_list_body {
 		      "</tr>\n";
 	}
 	my $alternate = 1;
-	my $tagfilter = $cgi->param('by_tag');
+	my $tagfilter = $input_params{'ctag_filter'};
 	for (my $i = $from; $i <= $to; $i++) {
 		my $pr = $projects[$i];
 
@@ -4682,7 +4691,7 @@ sub git_forks {
 	git_header_html();
 	git_print_page_nav('','');
 	git_print_header_div('summary', "$project forks");
-	git_project_list_body(\@list, $order);
+	git_project_list_body(\@list, $order, undef, undef, undef, undef, 'forks');
 	git_footer_html();
 }
 
@@ -4756,12 +4765,12 @@ sub git_summary {
 	my $show_ctags = gitweb_check_feature('ctags');
 	if ($show_ctags) {
 		my $ctags = git_get_project_ctags($project);
-		my $cloud = git_populate_project_tagcloud($ctags);
+		my $cloud = git_populate_project_tagcloud($ctags, 'project_list');
 		print "<tr id=\"metadata_ctags\"><td>Content tags:<br />";
 		print "</td>\n<td>" unless %$ctags;
 		print "<form action=\"$show_ctags\" method=\"post\"><input type=\"hidden\" name=\"p\" value=\"$project\" />Add: <input type=\"text\" name=\"t\" size=\"8\" /></form>";
 		print "</td>\n<td>" if %$ctags;
-		print git_show_project_tagcloud($cloud, 48);
+		print git_show_project_tagcloud($cloud, 48, 'project_list');
 		print "</td></tr>";
 	}
 
@@ -4805,7 +4814,7 @@ sub git_summary {
 		git_project_list_body(\@forklist, 'age', 0, 15,
 		                      $#forklist <= 15 ? undef :
 		                      $cgi->a({-href => href(action=>"forks")}, "..."),
-		                      'no_header');
+		                      'no_header', 'forks');
 	}
 
 	git_footer_html();
-- 
tg: (73bafe5..) t/frontpage/ctags (depends on: t/frontpage/refactor)
