From: Tony Finch <dot@dotat.at>
Subject: [PATCH 4/5] gitweb: optionally set project category from its
 pathname
Date: Thu, 31 Jul 2014 13:53:51 +0100
Message-ID: <alpine.LSU.2.00.1407311353500.23775@hermes-1.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 31 14:53:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCprp-00079Q-QM
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 14:53:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbaGaMxx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 08:53:53 -0400
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:44794 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071AbaGaMxx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 08:53:53 -0400
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-1.csi.cam.ac.uk ([131.111.8.51]:41097)
	by ppsw-52.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.159]:25)
	with esmtpa (EXTERNAL:fanf2) id 1XCprj-00012M-EL (Exim 4.82_3-c0e5623) for git@vger.kernel.org
	(return-path <fanf2@hermes.cam.ac.uk>); Thu, 31 Jul 2014 13:53:51 +0100
Received: from fanf2 by hermes-1.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local id 1XCprj-0005kd-9c (Exim 4.72) for git@vger.kernel.org
	(return-path <fanf2@hermes.cam.ac.uk>); Thu, 31 Jul 2014 13:53:51 +0100
X-X-Sender: fanf2@hermes-1.csi.cam.ac.uk
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254568>

When repositories are organized in a hierarchial directory tree
it is convenient if gitweb project categories can be set
automatically based on their parent directory, so that users
do not have to set the same information twice.

Signed-off-by: Tony Finch <dot@dotat.at>
---
 Documentation/gitweb.conf.txt |  6 ++++++
 gitweb/gitweb.perl            | 13 ++++++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.txt
index 29f1e06..7c0de18 100644
--- a/Documentation/gitweb.conf.txt
+++ b/Documentation/gitweb.conf.txt
@@ -492,6 +492,12 @@ $projects_list_group_categories::
 	`$GIT_DIR/category` file or the `gitweb.category` variable in each
 	repository's configuration.  Disabled by default (set to 0).

+$projects_list_directory_is_category::
+	Whether to set a project's category to its parent directory, i.e. its
+	pathname excluding the `/repo.git` leaf name. This is only used if
+	the repo has no explicit setting, and if the pathname has more than
+	one component. Disabled by default (set to 0).
+
 $project_list_default_category::
 	Default category for projects for which none is specified.  If this is
 	set to the empty string, such projects will remain uncategorized and
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index d1e6b79..edbc058 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -129,6 +129,10 @@ our $projects_list_description_width = 25;
 # (enabled if this variable evaluates to true)
 our $projects_list_group_categories = 0;

+# project's category defaults to its parent directory
+# (enabled if this variable evaluates to true)
+our $projects_list_directory_is_category = 0;
+
 # default category if none specified
 # (leave the empty string for no category)
 our $project_list_default_category = "";
@@ -2904,7 +2908,11 @@ sub git_get_project_description {

 sub git_get_project_category {
 	my $path = shift;
-	return git_get_file_or_project_config($path, 'category');
+	my $cat = git_get_file_or_project_config($path, 'category');
+	return $cat if $cat;
+	return $1 if $projects_list_directory_is_category
+		  && $path =~ m,^(.*)/[^/]*$,;
+	return $project_list_default_category;
 }


@@ -5618,8 +5626,7 @@ sub fill_project_list_info {
 		}
 		if ($projects_list_group_categories &&
 		    project_info_needs_filling($pr, $filter_set->('category'))) {
-			my $cat = git_get_project_category($pr->{'path'}) ||
-			                                   $project_list_default_category;
+			my $cat = git_get_project_category($pr->{'path'});
 			$pr->{'category'} = to_utf8($cat);
 		}

-- 
2.1.0.rc0.229.gaee38de
