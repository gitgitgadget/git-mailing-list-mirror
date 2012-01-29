From: "Bernhard R. Link" <brl+git@mail.brlink.eu>
Subject: [PATCH v3] gitweb: add project_filter to limit project list to a
 subdirectory
Date: Sun, 29 Jan 2012 02:22:35 +0100
Message-ID: <20120129012234.GD16079@server.brlink.eu>
References: <20120128165606.GA6770@server.brlink.eu>
 <m3wr8bcuon.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 29 02:23:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrJTv-0008Mg-Q2
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jan 2012 02:23:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752156Ab2A2BWb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jan 2012 20:22:31 -0500
Received: from server.brlink.eu ([78.46.187.186]:54064 "EHLO server.brlink.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752024Ab2A2BWa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jan 2012 20:22:30 -0500
Received: from p5483e188.dip.t-dialin.net ([84.131.225.136] helo=client.brlink.eu)
	by server.brlink.eu with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <brl@mail.brlink.eu>)
	id 1RrJTO-0003N4-8i; Sun, 29 Jan 2012 02:22:26 +0100
Received: from brl by client.brlink.eu with local (Exim 4.77)
	(envelope-from <brl@mail.brlink.eu>)
	id 1RrJTX-0004O7-Cl; Sun, 29 Jan 2012 02:22:38 +0100
Content-Disposition: inline
In-Reply-To: <m3wr8bcuon.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189270>

This commit changes the project listing views (project_list,
project_index and opml) to limit the output to only projects in a
subdirectory if the new optional parameter ?pf=directory name is used.

The change is quite minimal as git_get_projects_list already can limit
itself to a subdirectory (though that was previously only used for
'forks').

If there is a GITWEB_LIST file, the contents are just filtered like
with the forks action.

Without a GITWEB_LIST file only the given subdirectory is searched
for projects (like with forks) unless GITWEB_STRICT_EXPORT is enabled.
In the later case GITWEB_PROJECTROOT is traversed normally (unlike
with forks) and projects not in the directory ignored.
(As there is no check if the filter_path would have been found in
the usual search as the project path is checked with forks).

Reusing $project instead of adding a new parameter would have been
nicer from a UI point-of-view (including PATH_INFO support) but
would complicate the $project validating code that is currently being
used to ensure nothing is exported that should not be viewable.

Additionally change html page headers to not only link the project
root and the currently selected project but also the directories in
between using project_filter.

Signed-off-by: Bernhard R. Link <brlink@debian.org>
---

changes since v2:
        improve description
        remove || 0 for boolean argument
        merge with patch using this feature
        use user-visible configuration names instead of internal ones

* Jakub Narebski <jnareb@gmail.com> [120128 23:45]:
> "Bernhard R. Link" <brl+git@mail.brlink.eu> writes:
> > If strict_export is enabled and there is no projects_list, it still
> > traverses the full tree and only filters afterwards to avoid anything
> > getting visible by this. Otherwise only the subtree needs to be
> > traversed, significantly reducing load times.
> >
> I still don't understand interaction between project_filter ('pf'),
> $strict_export and $projects_list being either directory or a file
> with a list of projects.
> 
> Does it mean, that when $projects_list is a file with a list of projects,
> and we use project_filter, then:
> 
> * if $strict_export is false, then $project_list is ignored, and the
>   filtered list of projects is created by scanning
>   "$projectroot/$project_filter"

No. If project_list is set, i.e. a file, then this is always used.
If it is a directory (because it is not set thus set to projectroot),
then with forks it still traverses that directory (as that was checked
before to be a reachable project with a previous call to
git_get_projects_list). In the case of project_filter only the directory
is traversed without strict_export and the whole projectroot is
traversed with strict_export.

Is the new description better.

> A few nitpicks with respect to patch itself.
> 
> >  -2827,6 +2835,7 @@ sub git_get_project_url_list {
> >  
> >  sub git_get_projects_list {
> >  	my $filter = shift || '';
> > +	my $paranoid = shift || 0;
> >  	my @list;
> >  
> 
> First, undefined value is false in Perl, so there is no need for
> " || 0" in setting $paranoid variable.

I thought it make it clearer that the argument might not be set and
what the default is. But that is personal taste.

> Second, why not use global variable $strict_export instead of adding
> another parameter to git_get_projects_list()?

That would change the action=forks behaviour to traverse the whole
projectroot two times. This way paranoia is only activated if
strict_mode is set _and_ the argument was not yet checked to be
reachable.


 gitweb/gitweb.perl |   52 ++++++++++++++++++++++++++++++++++++++++++++--------
 1 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index abb5a79..089d45d 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -760,6 +760,7 @@ our @cgi_param_mapping = (
 	search_use_regexp => "sr",
 	ctag => "by_tag",
 	diff_style => "ds",
+	project_filter => "pf",
 	# this must be last entry (for manipulation from JavaScript)
 	javascript => "js"
 );
@@ -976,7 +977,7 @@ sub evaluate_path_info {
 
 our ($action, $project, $file_name, $file_parent, $hash, $hash_parent, $hash_base,
      $hash_parent_base, @extra_options, $page, $searchtype, $search_use_regexp,
-     $searchtext, $search_regexp);
+     $searchtext, $search_regexp, $project_filter);
 sub evaluate_and_validate_params {
 	our $action = $input_params{'action'};
 	if (defined $action) {
@@ -994,6 +995,13 @@ sub evaluate_and_validate_params {
 		}
 	}
 
+	our $project_filter = $input_params{'project_filter'};
+	if (defined $project_filter) {
+		if (!validate_pathname($project_filter)) {
+			die_error(404, "Invalid project_filter parameter");
+		}
+	}
+
 	our $file_name = $input_params{'file_name'};
 	if (defined $file_name) {
 		if (!validate_pathname($file_name)) {
@@ -2827,6 +2835,7 @@ sub git_get_project_url_list {
 
 sub git_get_projects_list {
 	my $filter = shift || '';
+	my $paranoid = shift;
 	my @list;
 
 	$filter =~ s/\.git$//;
@@ -2839,7 +2848,7 @@ sub git_get_projects_list {
 		my $pfxlen = length("$dir");
 		my $pfxdepth = ($dir =~ tr!/!!);
 		# when filtering, search only given subdirectory
-		if ($filter) {
+		if ($filter and not $paranoid) {
 			$dir .= "/$filter";
 			$dir =~ s!/+$!!;
 		}
@@ -2864,6 +2873,10 @@ sub git_get_projects_list {
 				}
 
 				my $path = substr($File::Find::name, $pfxlen + 1);
+				# paranoidly only filter here
+				if ($paranoid && $filter && $path !~ m!^\Q$filter\E/!) {
+					next;
+				}
 				# we check related file in $projectroot
 				if (check_export_ok("$projectroot/$path")) {
 					push @list, { path => $path };
@@ -3828,7 +3841,18 @@ sub print_nav_breadcrumbs {
 
 	print $cgi->a({-href => esc_url($home_link)}, $home_link_str) . " / ";
 	if (defined $project) {
-		print $cgi->a({-href => href(action=>"summary")}, esc_html($project));
+		my @dirname = split '/', $project;
+		my $projectbasename = pop @dirname;
+		my $dirprefix = undef;
+		while (my $part = shift @dirname) {
+			$dirprefix .= "/" if defined $dirprefix;
+			$dirprefix .= $part;
+			print $cgi->a({-href => href(project => undef,
+			                             project_filter => $dirprefix,
+			                             action=>"project_list")},
+			              esc_html($part)) . " / ";
+		}
+		print $cgi->a({-href => href(action=>"summary")}, esc_html($projectbasename));
 		if (defined $action) {
 			my $action_print = $action ;
 			if (defined $opts{-action_extra}) {
@@ -3841,6 +3865,16 @@ sub print_nav_breadcrumbs {
 			print " / $opts{-action_extra}";
 		}
 		print "\n";
+	} elsif (defined $project_filter) {
+		my @dirname = split '/', $project_filter;
+		my $dirprefix = undef;
+		while (my $part = shift @dirname) {
+			$dirprefix .= "/" if defined $dirprefix;
+			$dirprefix .= $part;
+			print $cgi->a({-href => href(project_filter => $dirprefix,
+			                             action=>"project_list")},
+			              esc_html($part)) . " / ";
+		}
 	}
 }
 
@@ -3963,9 +3997,11 @@ sub git_footer_html {
 		}
 
 	} else {
-		print $cgi->a({-href => href(project=>undef, action=>"opml"),
+		print $cgi->a({-href => href(project=>undef, action=>"opml",
+		                             project_filter => $project_filter),
 		              -class => $feed_class}, "OPML") . " ";
-		print $cgi->a({-href => href(project=>undef, action=>"project_index"),
+		print $cgi->a({-href => href(project=>undef, action=>"project_index",
+		                             project_filter => $project_filter),
 		              -class => $feed_class}, "TXT") . "\n";
 	}
 	print "</div>\n"; # class="page_footer"
@@ -5979,7 +6015,7 @@ sub git_project_list {
 		die_error(400, "Unknown order parameter");
 	}
 
-	my @list = git_get_projects_list();
+	my @list = git_get_projects_list($project_filter, $strict_export);
 	if (!@list) {
 		die_error(404, "No projects found");
 	}
@@ -6018,7 +6054,7 @@ sub git_forks {
 }
 
 sub git_project_index {
-	my @projects = git_get_projects_list();
+	my @projects = git_get_projects_list($project_filter, $strict_export);
 	if (!@projects) {
 		die_error(404, "No projects found");
 	}
@@ -7855,7 +7891,7 @@ sub git_atom {
 }
 
 sub git_opml {
-	my @list = git_get_projects_list();
+	my @list = git_get_projects_list($project_filter, $strict_export);
 	if (!@list) {
 		die_error(404, "No projects found");
 	}
-- 
1.7.8.3
