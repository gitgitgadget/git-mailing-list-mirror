From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] gitweb: Refactor project list routines
Date: Fri,  6 Nov 2009 16:10:46 +0100
Message-ID: <1257520246-6548-1-git-send-email-pasky@suse.cz>
Cc: Petr Baudis <pasky@suse.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 06 16:19:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6QbO-0006Td-JB
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 16:19:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759361AbZKFPTF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2009 10:19:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759360AbZKFPTA
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 10:19:00 -0500
Received: from rover.dkm.cz ([62.24.64.27]:60943 "EHLO rover.dkm.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759351AbZKFPS7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2009 10:18:59 -0500
X-Greylist: delayed 621 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Nov 2009 10:18:59 EST
Received: by rover.dkm.cz (Postfix, from userid 1001)
	id EC33D165F05; Fri,  6 Nov 2009 16:10:46 +0100 (CET)
X-Mailer: git-send-email 1.5.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132304>

This is a preparatory patch for separation of project list and frontpage
actions; it factors out most logic of git_project_list():

	* git_project_list_all() as a git_project_list_body() wrapper for
	  complete project listing
	* git_project_search_form() for printing the project search form

Also, git_project_list_ctags() is now separated out of
git_project_list_body(), showing tag cloud for given project list.

Signed-off-by: Petr Baudis <pasky@suse.cz>

---
 gitweb/gitweb.perl |   69 +++++++++++++++++++++++++++++++---------------------
 1 files changed, 41 insertions(+), 28 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e4cbfc3..e82ca45 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4201,10 +4201,9 @@ sub git_patchset_body {
 # project in the list, removing invalid projects from returned list
 # NOTE: modifies $projlist, but does not remove entries from it
 sub fill_project_list_info {
-	my ($projlist, $check_forks) = @_;
+	my ($projlist, $check_forks, $show_ctags) = @_;
 	my @projects;
 
-	my $show_ctags = gitweb_check_feature('ctags');
  PROJECT:
 	foreach my $pr (@$projlist) {
 		my (@activity) = git_get_last_activity($pr->{'path'});
@@ -4254,12 +4253,26 @@ sub print_sort_th {
 	}
 }
 
+sub git_project_list_ctags {
+	my ($projects) = @_;
+
+	my %ctags;
+	foreach my $p (@$projects) {
+		foreach my $ct (keys %{$p->{'ctags'}}) {
+			$ctags{$ct} += $p->{'ctags'}->{$ct};
+		}
+	}
+	my $cloud = git_populate_project_tagcloud(\%ctags);
+	print git_show_project_tagcloud($cloud, 64);
+}
+
 sub git_project_list_body {
 	# actually uses global variable $project
 	my ($projlist, $order, $from, $to, $extra, $no_header) = @_;
 
 	my $check_forks = gitweb_check_feature('forks');
-	my @projects = fill_project_list_info($projlist, $check_forks);
+	my $show_ctags = gitweb_check_feature('ctags');
+	my @projects = fill_project_list_info($projlist, $check_forks, $show_ctags);
 
 	$order ||= $default_projects_order;
 	$from = 0 unless defined $from;
@@ -4278,16 +4291,8 @@ sub git_project_list_body {
 		@projects = sort {$a->{$oi->{'key'}} <=> $b->{$oi->{'key'}}} @projects;
 	}
 
-	my $show_ctags = gitweb_check_feature('ctags');
 	if ($show_ctags) {
-		my %ctags;
-		foreach my $p (@projects) {
-			foreach my $ct (keys %{$p->{'ctags'}}) {
-				$ctags{$ct} += $p->{'ctags'}->{$ct};
-			}
-		}
-		my $cloud = git_populate_project_tagcloud(\%ctags);
-		print git_show_project_tagcloud($cloud, 64);
+		git_project_list_ctags(\@projects);
 	}
 
 	print "<table class=\"project_list\">\n";
@@ -4361,6 +4366,28 @@ sub git_project_list_body {
 	print "</table>\n";
 }
 
+sub git_project_search_form {
+	print $cgi->startform(-method => "get") .
+	      "<p class=\"projsearch\">Search:\n" .
+	      $cgi->textfield(-name => "s", -value => $searchtext) . "\n" .
+	      "</p>" .
+	      $cgi->end_form() . "\n";
+}
+
+sub git_project_list_all {
+	my $order = $input_params{'order'};
+	if (defined $order && $order !~ m/none|project|descr|owner|age/) {
+		die_error(400, "Unknown order parameter");
+	}
+
+	my @list = git_get_projects_list();
+	if (!@list) {
+		die_error(404, "No projects found");
+	}
+
+	git_project_list_body(\@list, $order);
+}
+
 sub git_shortlog_body {
 	# uses global variable $project
 	my ($commitlist, $from, $to, $refs, $extra) = @_;
@@ -4630,28 +4657,14 @@ sub git_search_grep_body {
 ## actions
 
 sub git_project_list {
-	my $order = $input_params{'order'};
-	if (defined $order && $order !~ m/none|project|descr|owner|age/) {
-		die_error(400, "Unknown order parameter");
-	}
-
-	my @list = git_get_projects_list();
-	if (!@list) {
-		die_error(404, "No projects found");
-	}
-
 	git_header_html();
 	if (-f $home_text) {
 		print "<div class=\"index_include\">\n";
 		insert_file($home_text);
 		print "</div>\n";
 	}
-	print $cgi->startform(-method => "get") .
-	      "<p class=\"projsearch\">Search:\n" .
-	      $cgi->textfield(-name => "s", -value => $searchtext) . "\n" .
-	      "</p>" .
-	      $cgi->end_form() . "\n";
-	git_project_list_body(\@list, $order);
+	git_project_search_form();
+	git_project_list_all();
 	git_footer_html();
 }
 
-- 
tg: (8cc62c1..) t/frontpage/refactor (depends on: vanilla/master)
