From: "Bernhard R. Link" <brl+list+git@mail.brlink.eu>
Subject: [PATCH] gitweb: add pf= to limit project list to a subdirectory
Date: Thu, 26 Jan 2012 15:45:22 +0100
Message-ID: <20120126144517.GA4229@server.brlink.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 27 08:07:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rqfu8-0005o0-Q0
	for gcvg-git-2@lo.gmane.org; Fri, 27 Jan 2012 08:07:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752324Ab2A0HHT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jan 2012 02:07:19 -0500
Received: from server.brlink.eu ([78.46.187.186]:54040 "EHLO server.brlink.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751301Ab2A0HHS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jan 2012 02:07:18 -0500
X-Greylist: delayed 58931 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Jan 2012 02:07:16 EST
Received: from mfs.mathematik.uni-freiburg.de ([132.230.30.170] helo=client.brlink.eu)
	by server.brlink.eu with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <brl@mail.brlink.eu>)
	id 1RqQZU-0004cM-CH
	for git@vger.kernel.org; Thu, 26 Jan 2012 15:45:04 +0100
Received: from brl by client.brlink.eu with local (Exim 4.77)
	(envelope-from <brl@mail.brlink.eu>)
	id 1RqQZm-00017F-2g
	for git@vger.kernel.org; Thu, 26 Jan 2012 15:45:22 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189200>

This commit changes the project listings (project_list, project_index
and opml) to limit the output to only projects in a subdirectory if the
new optional parameter ?pf=directory name is used.

It uses the infrastructure already there for 'forks' (which also filters
projects but needs a project called like the filter directory to work).

This feature is disabled if strict_export is used and there is no
projects_list to avoid showing more than intended.
Without strict_export enabled this change should not show any projects
one could not get details from anyway. So if the validate_pathname
checks are not sufficient this would at most make it easier to get a
list of viewable content.

Reusing $project instead of adding a new parameter would have been
nicer from a UI point-of-view (including PATH_INFO support) but
complicate the $project validating code that is currently being
used to ensure nothing is exported that should not be viewable.

Signed-off-by: Bernhard R. Link <brlink@debian.org>

---
As most parameters are not documented in documentation/gitweb.txt,
I did not add documentation for this one either.

 gitweb/gitweb.perl |   26 ++++++++++++++++++++++----
 1 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index abb5a79..00dd79e 100755
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
@@ -994,6 +995,16 @@ sub evaluate_and_validate_params {
 		}
 	}
 
+	our $project_filter = $input_params{'project_filter'};
+	if (defined $project_filter) {
+		if ($strict_export and -d $projects_list) {
+			die_error(404, "project_filter disabled");
+		}
+		if (!validate_pathname($project_filter)) {
+			die_error(404, "Invalid project_filter parameter");
+		}
+	}
+
 	our $file_name = $input_params{'file_name'};
 	if (defined $file_name) {
 		if (!validate_pathname($file_name)) {
@@ -3962,6 +3973,13 @@ sub git_footer_html {
 			              -class => $feed_class}, $format)."\n";
 		}
 
+	} elsif (defined $project_filter) {
+		print $cgi->a({-href => href(project=>undef, action=>"opml",
+		                             project_filter => $project_filter),
+		              -class => $feed_class}, "OPML") . " ";
+		print $cgi->a({-href => href(project=>undef, action=>"project_index",
+		                             project_filter => $project_filter),
+		              -class => $feed_class}, "TXT") . "\n";
 	} else {
 		print $cgi->a({-href => href(project=>undef, action=>"opml"),
 		              -class => $feed_class}, "OPML") . " ";
@@ -5979,7 +5997,7 @@ sub git_project_list {
 		die_error(400, "Unknown order parameter");
 	}
 
-	my @list = git_get_projects_list();
+	my @list = git_get_projects_list($project_filter);
 	if (!@list) {
 		die_error(404, "No projects found");
 	}
@@ -6018,7 +6036,7 @@ sub git_forks {
 }
 
 sub git_project_index {
-	my @projects = git_get_projects_list();
+	my @projects = git_get_projects_list($project_filter);
 	if (!@projects) {
 		die_error(404, "No projects found");
 	}
@@ -7855,7 +7873,7 @@ sub git_atom {
 }
 
 sub git_opml {
-	my @list = git_get_projects_list();
+	my @list = git_get_projects_list($project_filter);
 	if (!@list) {
 		die_error(404, "No projects found");
 	}
-- 
1.7.8.3
