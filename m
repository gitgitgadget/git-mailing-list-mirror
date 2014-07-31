From: Tony Finch <dot@dotat.at>
Subject: [PATCH 2/5] gitweb: if the PATH_INFO is incomplete, use it as a
 project_filter
Date: Thu, 31 Jul 2014 13:53:41 +0100
Message-ID: <alpine.LSU.2.00.1407311353400.23775@hermes-1.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 31 14:53:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCpre-00071R-19
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 14:53:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbaGaMxn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 08:53:43 -0400
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:57475 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071AbaGaMxm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 08:53:42 -0400
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-1.csi.cam.ac.uk ([131.111.8.51]:43451)
	by ppsw-50.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.158]:25)
	with esmtpa (EXTERNAL:fanf2) id 1XCprZ-0005Bd-rx (Exim 4.82_3-c0e5623) for git@vger.kernel.org
	(return-path <fanf2@hermes.cam.ac.uk>); Thu, 31 Jul 2014 13:53:41 +0100
Received: from fanf2 by hermes-1.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local id 1XCprZ-0005jp-Ky (Exim 4.72) for git@vger.kernel.org
	(return-path <fanf2@hermes.cam.ac.uk>); Thu, 31 Jul 2014 13:53:41 +0100
X-X-Sender: fanf2@hermes-1.csi.cam.ac.uk
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254566>

Previously gitweb would ignore partial PATH_INFO. For example,
it would produce a project list for the top URL
	https://www.example.org/projects/
and a project summary for
	https://www.example.org/projects/git/git.git
but if you tried to list just the git-related projects with
	https://www.example.org/projects/git/
you would get a list of all projects, same as the top URL.

As well as fixing that omission, this change also makes gitweb
generate PATH_INFO-style URLs for project filter links, such
as in the breadcrumbs.

Signed-off-by: Tony Finch <dot@dotat.at>
---
 gitweb/gitweb.perl | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a9f57d6..12aba8f 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -891,7 +891,17 @@ sub evaluate_path_info {
 	while ($project && !check_head_link("$projectroot/$project")) {
 		$project =~ s,/*[^/]*$,,;
 	}
-	return unless $project;
+	# If there is no project, use the PATH_INFO as a project filter if it
+	# is a directory in the projectroot. (It can't be a subdirectory of a
+	# repo because we just verified that isn't the case.)
+	unless ($project) {
+		if (-d "$projectroot/$path_info") {
+			$path_info =~ s,/+$,,;
+			$input_params{'project_filter'} = $path_info;
+			$path_info = "";
+		}
+		return;
+	}
 	$input_params{'project'} = $project;

 	# do not change any parameters if an action is given using the query string
@@ -1356,6 +1366,18 @@ sub href {
 	}

 	my $use_pathinfo = gitweb_check_feature('pathinfo');
+
+	# we have to check for a project_filter first because handling the full
+	# project-plus-parameters deletes some of the paramaters we check here
+	if (!defined $params{'project'} && $params{'project_filter'} &&
+	    $params{'action'} eq "project_list" &&
+	    (exists $params{-path_info} ? $params{-path_info} : $use_pathinfo)) {
+		$href =~ s,/$,,;
+		$href .= "/".esc_path_info($params{'project_filter'})."/";
+		delete $params{'project_filter'};
+		delete $params{'action'};
+	}
+
 	if (defined $params{'project'} &&
 	    (exists $params{-path_info} ? $params{-path_info} : $use_pathinfo)) {
 		# try to put as many parameters as possible in PATH_INFO:
-- 
2.1.0.rc0.229.gaee38de
