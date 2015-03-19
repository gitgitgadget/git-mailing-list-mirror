From: Tony Finch <dot@dotat.at>
Subject: [PATCH 2/5] gitweb: if the PATH_INFO is incomplete, use it as a
 project_filter
Date: Thu, 19 Mar 2015 15:39:59 +0000
Message-ID: <alpine.LSU.2.00.1503191539570.23307@hermes-1.csi.cam.ac.uk>
References: <5e56772f50d3d1498361d8831c4f2fba38d197b4.1426779553.git.dot@dotat.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 19 16:50:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYchz-0001E6-H7
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 16:50:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753549AbbCSPuB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 11:50:01 -0400
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:45739 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753177AbbCSPt7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 11:49:59 -0400
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-1.csi.cam.ac.uk ([131.111.8.51]:39675)
	by ppsw-52.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.159]:25)
	with esmtpa (EXTERNAL:fanf2) id 1YYcYB-0001em-Ds (Exim 4.82_3-c0e5623) for git@vger.kernel.org
	(return-path <fanf2@hermes.cam.ac.uk>); Thu, 19 Mar 2015 15:39:59 +0000
Received: from fanf2 by hermes-1.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local id 1YYcYB-0007wL-80 (Exim 4.72) for git@vger.kernel.org
	(return-path <fanf2@hermes.cam.ac.uk>); Thu, 19 Mar 2015 15:39:59 +0000
X-X-Sender: fanf2@hermes-1.csi.cam.ac.uk
In-Reply-To: <5e56772f50d3d1498361d8831c4f2fba38d197b4.1426779553.git.dot@dotat.at>
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265810>

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
index 7a5b23a..073f324 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -895,7 +895,17 @@ sub evaluate_path_info {
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
@@ -1360,6 +1370,18 @@ sub href {
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
2.2.1.68.g56d9796
