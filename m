From: "Bernhard R. Link" <brl+git@mail.brlink.eu>
Subject: [PATCH v2 1/2] gitweb: add project_filter to limit project list to a
 subdirectory
Date: Sat, 28 Jan 2012 17:56:10 +0100
Message-ID: <20120128165606.GA6770@server.brlink.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 28 18:40:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrCFm-0000o9-9d
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jan 2012 18:39:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752025Ab2A1Qz5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jan 2012 11:55:57 -0500
Received: from server.brlink.eu ([78.46.187.186]:54052 "EHLO server.brlink.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751477Ab2A1Qz4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jan 2012 11:55:56 -0500
Received: from mfs.mathematik.uni-freiburg.de ([132.230.30.170] helo=client.brlink.eu)
	by server.brlink.eu with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <brl@mail.brlink.eu>)
	id 1RrBZA-00039Z-MA
	for git@vger.kernel.org; Sat, 28 Jan 2012 17:55:52 +0100
Received: from brl by client.brlink.eu with local (Exim 4.77)
	(envelope-from <brl@mail.brlink.eu>)
	id 1RrBZS-0001lR-Bn
	for git@vger.kernel.org; Sat, 28 Jan 2012 17:56:10 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189260>

This commit changes the project listings (project_list, project_index
and opml) to limit the output to only projects in a subdirectory if the
new optional parameter ?pf=directory name is used.

The change is quite minimal as git_get_projects_list already can limit
itself to a subdirectory (though that was previously only used for
'forks').

If strict_export is enabled and there is no projects_list, it still
traverses the full tree and only filters afterwards to avoid anything
getting visible by this. Otherwise only the subtree needs to be
traversed, significantly reducing load times.

Reusing $project instead of adding a new parameter would have been
nicer from a UI point-of-view (including PATH_INFO support) but
would complicate the $project validating code that is currently being
used to ensure nothing is exported that should not be viewable.

Signed-off-by: Bernhard R. Link <brlink@debian.org>
---
 Changed since version 1:
   - improve description
   - simplify as suggested by Jakub Narebski
   - support the strict_exports + no projects_list case

 gitweb/gitweb.perl |   29 ++++++++++++++++++++++-------
 1 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index abb5a79..a114bd4 100755
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
+	my $paranoid = shift || 0;
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
@@ -3963,9 +3976,11 @@ sub git_footer_html {
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
@@ -5979,7 +5994,7 @@ sub git_project_list {
 		die_error(400, "Unknown order parameter");
 	}
 
-	my @list = git_get_projects_list();
+	my @list = git_get_projects_list($project_filter, $strict_export);
 	if (!@list) {
 		die_error(404, "No projects found");
 	}
@@ -6018,7 +6033,7 @@ sub git_forks {
 }
 
 sub git_project_index {
-	my @projects = git_get_projects_list();
+	my @projects = git_get_projects_list($project_filter, $strict_export);
 	if (!@projects) {
 		die_error(404, "No projects found");
 	}
@@ -7855,7 +7870,7 @@ sub git_atom {
 }
 
 sub git_opml {
-	my @list = git_get_projects_list();
+	my @list = git_get_projects_list($project_filter, $strict_export);
 	if (!@list) {
 		die_error(404, "No projects found");
 	}
-- 
1.7.8.3
