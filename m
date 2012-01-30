From: "Bernhard R. Link" <brl+git@mail.brlink.eu>
Subject: [PATCH v6 3/6] gitweb: add project_filter to limit project list to a
 subdirectory
Date: Mon, 30 Jan 2012 21:07:37 +0100
Message-ID: <20120130200737.GD2584@server.brlink.eu>
References: <20120128165606.GA6770@server.brlink.eu>
 <20120130095252.GA6183@server.brlink.eu>
 <20120130114557.GB9267@server.brlink.eu>
 <201201301657.12944.jnareb@gmail.com>
 <20120130200355.GA2584@server.brlink.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 21:07:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrxVd-0003LX-6L
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 21:07:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752907Ab2A3UHU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 15:07:20 -0500
Received: from server.brlink.eu ([78.46.187.186]:54112 "EHLO server.brlink.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752336Ab2A3UHT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 15:07:19 -0500
Received: from mfs.mathematik.uni-freiburg.de ([132.230.30.170] helo=client.brlink.eu)
	by server.brlink.eu with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <brl@mail.brlink.eu>)
	id 1RrxVW-0005vf-8B; Mon, 30 Jan 2012 21:07:18 +0100
Received: from brl by client.brlink.eu with local (Exim 4.77)
	(envelope-from <brl@mail.brlink.eu>)
	id 1RrxVp-0001Bt-4Y; Mon, 30 Jan 2012 21:07:37 +0100
Content-Disposition: inline
In-Reply-To: <20120130200355.GA2584@server.brlink.eu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189412>

This commit changes the project listing views (project_list,
project_index and opml) to limit the output to only projects in a
subdirectory if the new optional parameter ?pf=directory name is
used.

The implementation of the filter reuses the implementation used for
the 'forks' action (i.e. listing all projects within that directory
from the projects list file (GITWEB_LIST) or only projects in the
given subdirectory of the project root directory without a projects
list file).

Reusing $project instead of adding a new parameter would have been
nicer from a UI point-of-view (including PATH_INFO support) but
would complicate the $project validating code that is currently
being used to ensure nothing is exported that should not be viewable.

Signed-off-by: Bernhard R. Link <brlink@debian.org>

---
changed since v5.5:
	- change page titles to show what directory it is limited to
---
 gitweb/gitweb.perl |   31 +++++++++++++++++++++++++------
 1 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 9a296e2..b895f4c 100755
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
@@ -3734,7 +3742,12 @@ sub run_highlighter {
 sub get_page_title {
 	my $title = to_utf8($site_name);
 
-	return $title unless (defined $project);
+	unless (defined $project) {
+		if (defined $project_filter) {
+			$title .= " - " . to_utf8($project_filter);
+		}
+		return $title;
+	}
 	$title .= " - " . to_utf8($project);
 
 	return $title unless (defined $action);
@@ -5984,7 +5997,7 @@ sub git_project_list {
 		die_error(400, "Unknown order parameter");
 	}
 
-	my @list = git_get_projects_list();
+	my @list = git_get_projects_list($project_filter, $strict_export);
 	if (!@list) {
 		die_error(404, "No projects found");
 	}
@@ -6023,7 +6036,7 @@ sub git_forks {
 }
 
 sub git_project_index {
-	my @projects = git_get_projects_list();
+	my @projects = git_get_projects_list($project_filter, $strict_export);
 	if (!@projects) {
 		die_error(404, "No projects found");
 	}
@@ -7860,7 +7873,7 @@ sub git_atom {
 }
 
 sub git_opml {
-	my @list = git_get_projects_list();
+	my @list = git_get_projects_list($project_filter, $strict_export);
 	if (!@list) {
 		die_error(404, "No projects found");
 	}
@@ -7871,11 +7884,17 @@ sub git_opml {
 		-content_disposition => 'inline; filename="opml.xml"');
 
 	my $title = esc_html($site_name);
+	my $filter = " within subdirectory ";
+	if (defined $project_filter) {
+		$filter .= esc_html($project_filter);
+	} else {
+		$filter = "";
+	}
 	print <<XML;
 <?xml version="1.0" encoding="utf-8"?>
 <opml version="1.0">
 <head>
-  <title>$title OPML Export</title>
+  <title>$title OPML Export$filter</title>
 </head>
 <body>
 <outline text="git RSS feeds">
-- 
1.7.8.3
