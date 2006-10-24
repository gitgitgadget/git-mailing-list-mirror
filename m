From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] gitweb: Support for 'forks'
Date: Tue, 24 Oct 2006 05:33:17 +0200
Message-ID: <20061024033317.7549.42852.stgit@rover>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 24 05:33:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcD2b-0007q9-JQ
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 05:33:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932408AbWJXDdU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 23:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932409AbWJXDdU
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 23:33:20 -0400
Received: from rover.dkm.cz ([62.24.64.27]:43652 "EHLO rover.dkm.cz")
	by vger.kernel.org with ESMTP id S932408AbWJXDdT (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Oct 2006 23:33:19 -0400
Received: from [127.0.0.1] (rover [127.0.0.1])
	by rover.dkm.cz (Postfix) with ESMTP id BB5528BC3B;
	Tue, 24 Oct 2006 05:33:17 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
User-Agent: StGIT/0.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29919>

On repo.or.cz, I want to support project 'forks', which are meant
for repositories which are spinoffs of a given project and share
its objects database through the alternates mechanism. But another
(and perhaps even greater) incentive for that is that those 'forked
projects' do not clutter the main project index but are completely
grouped inside of the project view.

A forked project is just like a normal project, but given project
$projectroot/$projname.git, the forked project resides in directory
$projectroot/$projname/$forkname.git. This is a somewhat arbitrary
naming rule, but I think that for now it's fine; if someone will need
something wildly different, let them submit a patch. The 'forked'
mode is by default off and can be turned on in runtime gitweb
configuration just like other features.

A project having forks is marked by a '+' (pointing to the list of
forks) in the project list (this could become some cutesy AJAXy
DHTML in the future), there is a forks section in the project
summary similar to the heads and tags sections, and of course
a forks view which looks the same as the root project list.

Forks can be recursive.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 gitweb/gitweb.perl |  256 +++++++++++++++++++++++++++++++++++-----------------
 1 files changed, 174 insertions(+), 82 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 81adc71..f957aee 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -164,6 +164,21 @@ our %feature = (
 	'pathinfo' => {
 		'override' => 0,
 		'default' => [0]},
+
+	# Make gitweb consider projects in project root subdirectories
+	# to be forks of existing projects. Given project $projname.git,
+	# projects matching $projname/*.git will not be shown in the main
+	# projects list, instead a '+' mark will be added to $projname
+	# there and a 'forks' view will be enabled for the project, listing
+	# all the forks. This feature is supported only if project list
+	# is taken from a directory, not file.
+
+	# To enable system wide have in $GITWEB_CONFIG
+	# $feature{'forks'}{'default'} = [1];
+	# Project specific override is not supported.
+	'forks' => {
+		'override' => 0,
+		'default' => [0]},
 );
 
 sub gitweb_check_feature {
@@ -409,6 +424,7 @@ my %actions = (
 	"commitdiff" => \&git_commitdiff,
 	"commitdiff_plain" => \&git_commitdiff_plain,
 	"commit" => \&git_commit,
+	"forks" => \&git_forks,
 	"heads" => \&git_heads,
 	"history" => \&git_history,
 	"log" => \&git_log,
@@ -896,13 +912,19 @@ sub git_get_project_url_list {
 }
 
 sub git_get_projects_list {
+	my ($filter) = @_;
 	my @list;
 
+	$filter ||= '';
+	$filter =~ s/\.git$//;
+
 	if (-d $projects_list) {
 		# search in directory
-		my $dir = $projects_list;
+		my $dir = $projects_list . ($filter ? "/$filter" : '');
 		my $pfxlen = length("$dir");
 
+		my $check_forks = gitweb_check_feature('forks');
+
 		File::Find::find({
 			follow_fast => 1, # follow symbolic links
 			dangling_symlinks => 0, # ignore dangling symlinks, silently
@@ -914,8 +936,10 @@ sub git_get_projects_list {
 
 				my $subdir = substr($File::Find::name, $pfxlen + 1);
 				# we check related file in $projectroot
-				if (check_export_ok("$projectroot/$subdir")) {
-					push @list, { path => $subdir };
+				if ($check_forks and $subdir =~ m#/.#) {
+					$File::Find::prune = 1;
+				} elsif (check_export_ok("$projectroot/$filter/$subdir")) {
+					push @list, { path => ($filter ? "$filter/" : '') . $subdir };
 					$File::Find::prune = 1;
 				}
 			},
@@ -2160,6 +2184,124 @@ sub git_patchset_body {
 
 # . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
 
+sub git_project_list_body {
+	my ($projlist, $order, $from, $to, $extra, $no_header) = @_;
+
+	my $check_forks = gitweb_check_feature('forks');
+
+	my @projects;
+	foreach my $pr (@$projlist) {
+		my (@aa) = git_get_last_activity($pr->{'path'});
+		unless (@aa) {
+			next;
+		}
+		($pr->{'age'}, $pr->{'age_string'}) = @aa;
+		if (!defined $pr->{'descr'}) {
+			my $descr = git_get_project_description($pr->{'path'}) || "";
+			$pr->{'descr'} = chop_str($descr, 25, 5);
+		}
+		if (!defined $pr->{'owner'}) {
+			$pr->{'owner'} = get_file_owner("$projectroot/$pr->{'path'}") || "";
+		}
+		if ($check_forks) {
+			my $pname = $pr->{'path'};
+			$pname =~ s/\.git$//;
+			$pr->{'forks'} = -d "$projectroot/$pname";
+		}
+		push @projects, $pr;
+	}
+
+	$order ||= "project";
+	$from = 0 unless defined $from;
+	$to = $#projects if (!defined $to || $#projects < $to);
+
+	print "<table class=\"project_list\">\n";
+	unless ($no_header) {
+		print "<tr>\n";
+		if ($check_forks) {
+			print "<th></th>\n";
+		}
+		if ($order eq "project") {
+			@projects = sort {$a->{'path'} cmp $b->{'path'}} @projects;
+			print "<th>Project</th>\n";
+		} else {
+			print "<th>" .
+			      $cgi->a({-href => href(project=>undef, order=>'project'),
+				       -class => "header"}, "Project") .
+			      "</th>\n";
+		}
+		if ($order eq "descr") {
+			@projects = sort {$a->{'descr'} cmp $b->{'descr'}} @projects;
+			print "<th>Description</th>\n";
+		} else {
+			print "<th>" .
+			      $cgi->a({-href => href(project=>undef, order=>'descr'),
+				       -class => "header"}, "Description") .
+			      "</th>\n";
+		}
+		if ($order eq "owner") {
+			@projects = sort {$a->{'owner'} cmp $b->{'owner'}} @projects;
+			print "<th>Owner</th>\n";
+		} else {
+			print "<th>" .
+			      $cgi->a({-href => href(project=>undef, order=>'owner'),
+				       -class => "header"}, "Owner") .
+			      "</th>\n";
+		}
+		if ($order eq "age") {
+			@projects = sort {$a->{'age'} <=> $b->{'age'}} @projects;
+			print "<th>Last Change</th>\n";
+		} else {
+			print "<th>" .
+			      $cgi->a({-href => href(project=>undef, order=>'age'),
+				       -class => "header"}, "Last Change") .
+			      "</th>\n";
+		}
+		print "<th></th>\n" .
+		      "</tr>\n";
+	}
+	my $alternate = 1;
+	for (my $i = $from; $i <= $to; $i++) {
+		my $pr = $projects[$i];
+		if ($alternate) {
+			print "<tr class=\"dark\">\n";
+		} else {
+			print "<tr class=\"light\">\n";
+		}
+		$alternate ^= 1;
+		if ($check_forks) {
+			print "<td>";
+			if ($pr->{'forks'}) {
+				print $cgi->a({-href => href(project=>$pr->{'path'}, action=>"forks")}, "+");
+			}
+			print "</td>\n";
+		}
+		print "<td>" . $cgi->a({-href => href(project=>$pr->{'path'}, action=>"summary"),
+		                        -class => "list"}, esc_html($pr->{'path'})) . "</td>\n" .
+		      "<td>" . esc_html($pr->{'descr'}) . "</td>\n" .
+		      "<td><i>" . chop_str($pr->{'owner'}, 15) . "</i></td>\n";
+		print "<td class=\"". age_class($pr->{'age'}) . "\">" .
+		      $pr->{'age_string'} . "</td>\n" .
+		      "<td class=\"link\">" .
+		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"summary")}, "summary")   . " | " .
+		      $cgi->a({-href => '/git-browser/by-commit.html?r='.$pr->{'path'}}, "graphiclog") . " | " .
+		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"log")}, "log") . " | " .
+		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"tree")}, "tree") .
+		      ($pr->{'forks'} ? " | " . $cgi->a({-href => href(project=>$pr->{'path'}, action=>"forks")}, "forks") : '') .
+		      "</td>\n" .
+		      "</tr>\n";
+	}
+	if (defined $extra) {
+		print "<tr>\n";
+		if ($check_forks) {
+			print "<td></td>\n";
+		}
+		print "<td colspan=\"5\">$extra</td>\n" .
+		      "</tr>\n";
+	}
+	print "</table>\n";
+}
+
 sub git_shortlog_body {
 	# uses global variable $project
 	my ($revlist, $from, $to, $refs, $extra) = @_;
@@ -2378,25 +2520,9 @@ sub git_project_list {
 	}
 
 	my @list = git_get_projects_list();
-	my @projects;
 	if (!@list) {
 		die_error(undef, "No projects found");
 	}
-	foreach my $pr (@list) {
-		my (@aa) = git_get_last_activity($pr->{'path'});
-		unless (@aa) {
-			next;
-		}
-		($pr->{'age'}, $pr->{'age_string'}) = @aa;
-		if (!defined $pr->{'descr'}) {
-			my $descr = git_get_project_description($pr->{'path'}) || "";
-			$pr->{'descr'} = chop_str($descr, 25, 5);
-		}
-		if (!defined $pr->{'owner'}) {
-			$pr->{'owner'} = get_file_owner("$projectroot/$pr->{'path'}") || "";
-		}
-		push @projects, $pr;
-	}
 
 	git_header_html();
 	if (-f $home_text) {
@@ -2406,75 +2532,30 @@ sub git_project_list {
 		close $fd;
 		print "</div>\n";
 	}
-	print "<table class=\"project_list\">\n" .
-	      "<tr>\n";
-	$order ||= "project";
-	if ($order eq "project") {
-		@projects = sort {$a->{'path'} cmp $b->{'path'}} @projects;
-		print "<th>Project</th>\n";
-	} else {
-		print "<th>" .
-		      $cgi->a({-href => href(project=>undef, order=>'project'),
-		               -class => "header"}, "Project") .
-		      "</th>\n";
-	}
-	if ($order eq "descr") {
-		@projects = sort {$a->{'descr'} cmp $b->{'descr'}} @projects;
-		print "<th>Description</th>\n";
-	} else {
-		print "<th>" .
-		      $cgi->a({-href => href(project=>undef, order=>'descr'),
-		               -class => "header"}, "Description") .
-		      "</th>\n";
-	}
-	if ($order eq "owner") {
-		@projects = sort {$a->{'owner'} cmp $b->{'owner'}} @projects;
-		print "<th>Owner</th>\n";
-	} else {
-		print "<th>" .
-		      $cgi->a({-href => href(project=>undef, order=>'owner'),
-		               -class => "header"}, "Owner") .
-		      "</th>\n";
-	}
-	if ($order eq "age") {
-		@projects = sort {$a->{'age'} <=> $b->{'age'}} @projects;
-		print "<th>Last Change</th>\n";
-	} else {
-		print "<th>" .
-		      $cgi->a({-href => href(project=>undef, order=>'age'),
-		               -class => "header"}, "Last Change") .
-		      "</th>\n";
+	git_project_list_body(\@list, $order);
+	git_footer_html();
+}
+
+sub git_forks {
+	my $order = $cgi->param('o');
+	if (defined $order && $order !~ m/project|descr|owner|age/) {
+		die_error(undef, "Unknown order parameter");
 	}
-	print "<th></th>\n" .
-	      "</tr>\n";
-	my $alternate = 1;
-	foreach my $pr (@projects) {
-		if ($alternate) {
-			print "<tr class=\"dark\">\n";
-		} else {
-			print "<tr class=\"light\">\n";
-		}
-		$alternate ^= 1;
-		print "<td>" . $cgi->a({-href => href(project=>$pr->{'path'}, action=>"summary"),
-		                        -class => "list"}, esc_html($pr->{'path'})) . "</td>\n" .
-		      "<td>" . esc_html($pr->{'descr'}) . "</td>\n" .
-		      "<td><i>" . chop_str($pr->{'owner'}, 15) . "</i></td>\n";
-		print "<td class=\"". age_class($pr->{'age'}) . "\">" .
-		      $pr->{'age_string'} . "</td>\n" .
-		      "<td class=\"link\">" .
-		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"summary")}, "summary")   . " | " .
-		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"shortlog")}, "shortlog") . " | " .
-		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"log")}, "log") . " | " .
-		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"tree")}, "tree") .
-		      "</td>\n" .
-		      "</tr>\n";
+
+	my @list = git_get_projects_list($project);
+	if (!@list) {
+		die_error(undef, "No forks found");
 	}
-	print "</table>\n";
+
+	git_header_html();
+	git_print_page_nav('','');
+	git_print_header_div('summary', "$project forks");
+	git_project_list_body(\@list, $order);
 	git_footer_html();
 }
 
 sub git_project_index {
-	my @projects = git_get_projects_list();
+	my @projects = git_get_projects_list($project);
 
 	print $cgi->header(
 		-type => 'text/plain',
@@ -2517,6 +2598,10 @@ sub git_summary {
 			push @taglist, $ref;
 		}
 	}
+	my @forklist;
+	if (gitweb_check_feature('forks')) {
+		@forklist = git_get_projects_list($project);
+	}
 
 	git_header_html();
 	git_print_page_nav('summary','', $head);
@@ -2567,6 +2652,13 @@ sub git_summary {
 		               $cgi->a({-href => href(action=>"heads")}, "..."));
 	}
 
+	if (@forklist) {
+		git_print_header_div('forks');
+		git_project_list_body(\@forklist, undef, 0, 15,
+		                      $cgi->a({-href => href(action=>"forks")}, "..."),
+				      'noheader');
+	}
+
 	git_footer_html();
 }
 
