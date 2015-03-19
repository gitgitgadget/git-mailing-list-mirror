From: Tony Finch <dot@dotat.at>
Subject: [PATCH 4/5] gitweb: optionally set project category from its
 pathname
Date: Thu, 19 Mar 2015 15:40:16 +0000
Message-ID: <alpine.LSU.2.00.1503191540150.23307@hermes-1.csi.cam.ac.uk>
References: <5e56772f50d3d1498361d8831c4f2fba38d197b4.1426779553.git.dot@dotat.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 19 16:50:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYchn-00017j-LO
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 16:49:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751767AbbCSPtu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 11:49:50 -0400
Received: from ppsw-40.csi.cam.ac.uk ([131.111.8.140]:50282 "EHLO
	ppsw-40.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951AbbCSPtt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 11:49:49 -0400
X-Greylist: delayed 594 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Mar 2015 11:49:49 EDT
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-1.csi.cam.ac.uk ([131.111.8.51]:44287)
	by ppsw-40.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.156]:25)
	with esmtpa (EXTERNAL:fanf2) id 1YYcYS-000076-kG (Exim 4.82_3-c0e5623) for git@vger.kernel.org
	(return-path <fanf2@hermes.cam.ac.uk>); Thu, 19 Mar 2015 15:40:16 +0000
Received: from fanf2 by hermes-1.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local id 1YYcYS-0007yN-7T (Exim 4.72) for git@vger.kernel.org
	(return-path <fanf2@hermes.cam.ac.uk>); Thu, 19 Mar 2015 15:40:16 +0000
X-X-Sender: fanf2@hermes-1.csi.cam.ac.uk
In-Reply-To: <5e56772f50d3d1498361d8831c4f2fba38d197b4.1426779553.git.dot@dotat.at>
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265806>

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
index 9abc5bc..0aab3e0 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -133,6 +133,10 @@ our $projects_list_description_width = 25;
 # (enabled if this variable evaluates to true)
 our $projects_list_group_categories = 0;

+# project's category defaults to its parent directory
+# (enabled if this variable evaluates to true)
+our $projects_list_directory_is_category = 0;
+
 # default category if none specified
 # (leave the empty string for no category)
 our $project_list_default_category = "";
@@ -2908,7 +2912,11 @@ sub git_get_project_description {

 sub git_get_project_category {
 	my $path = shift;
-	return git_get_file_or_project_config($path, 'category');
+	my $cat = git_get_file_or_project_config($path, 'category');
+	return $cat if $cat;
+	return $1 if $projects_list_directory_is_category
+		  && $path =~ m,^(.*)/[^/]*$,;
+	return $project_list_default_category;
 }


@@ -5622,8 +5630,7 @@ sub fill_project_list_info {
 		}
 		if ($projects_list_group_categories &&
 		    project_info_needs_filling($pr, $filter_set->('category'))) {
-			my $cat = git_get_project_category($pr->{'path'}) ||
-			                                   $project_list_default_category;
+			my $cat = git_get_project_category($pr->{'path'});
 			$pr->{'category'} = to_utf8($cat);
 		}

-- 
2.2.1.68.g56d9796
