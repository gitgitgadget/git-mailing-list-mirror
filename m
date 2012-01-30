From: "Bernhard R. Link" <brl+git@mail.brlink.eu>
Subject: [PATCH v5 2/5] gitweb: add project_filter to limit project list to a
 subdirectory
Date: Mon, 30 Jan 2012 12:45:57 +0100
Message-ID: <20120130114557.GB9267@server.brlink.eu>
References: <20120128165606.GA6770@server.brlink.eu>
 <m3wr8bcuon.fsf@localhost.localdomain>
 <20120129012234.GD16079@server.brlink.eu>
 <201201291354.50241.jnareb@gmail.com>
 <20120129160615.GA13937@server.brlink.eu>
 <7v7h0afcc2.fsf@alter.siamese.dyndns.org>
 <20120130095252.GA6183@server.brlink.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 12:45:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rrpg7-00084y-Rj
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 12:45:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798Ab2A3Lpl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 06:45:41 -0500
Received: from server.brlink.eu ([78.46.187.186]:54087 "EHLO server.brlink.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751987Ab2A3Lpj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 06:45:39 -0500
Received: from mfs.mathematik.uni-freiburg.de ([132.230.30.170] helo=client.brlink.eu)
	by server.brlink.eu with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <brl@mail.brlink.eu>)
	id 1Rrpg2-0005dk-IA; Mon, 30 Jan 2012 12:45:38 +0100
Received: from brl by client.brlink.eu with local (Exim 4.77)
	(envelope-from <brl@mail.brlink.eu>)
	id 1RrpgL-0002Po-TZ; Mon, 30 Jan 2012 12:45:57 +0100
Content-Disposition: inline
In-Reply-To: <20120130095252.GA6183@server.brlink.eu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189349>

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
 gitweb/gitweb.perl |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index acf1bae..36efc10 100755
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
@@ -5984,7 +5992,7 @@ sub git_project_list {
 		die_error(400, "Unknown order parameter");
 	}
 
-	my @list = git_get_projects_list();
+	my @list = git_get_projects_list($project_filter, $strict_export);
 	if (!@list) {
 		die_error(404, "No projects found");
 	}
@@ -6023,7 +6031,7 @@ sub git_forks {
 }
 
 sub git_project_index {
-	my @projects = git_get_projects_list();
+	my @projects = git_get_projects_list($project_filter, $strict_export);
 	if (!@projects) {
 		die_error(404, "No projects found");
 	}
@@ -7860,7 +7868,7 @@ sub git_atom {
 }
 
 sub git_opml {
-	my @list = git_get_projects_list();
+	my @list = git_get_projects_list($project_filter, $strict_export);
 	if (!@list) {
 		die_error(404, "No projects found");
 	}
-- 
1.7.8.3
