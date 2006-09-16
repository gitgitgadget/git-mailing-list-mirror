From: Martin Waitz <tali@admingilde.org>
Subject: [PATCH] gitweb: more support for PATH_INFO based URLs
Date: Sat, 16 Sep 2006 23:08:32 +0200
Message-ID: <20060916210832.GV17042@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Sep 16 23:08:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOhP9-0000rL-FH
	for gcvg-git@gmane.org; Sat, 16 Sep 2006 23:08:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816AbWIPVIf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Sep 2006 17:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751817AbWIPVIf
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Sep 2006 17:08:35 -0400
Received: from agent.admingilde.org ([213.95.21.5]:61067 "EHLO
	mail.admingilde.org") by vger.kernel.org with ESMTP
	id S1751816AbWIPVIe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Sep 2006 17:08:34 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1GOhOq-00070p-Ke
	for git@vger.kernel.org; Sat, 16 Sep 2006 23:08:32 +0200
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27133>

Now three types of path based URLs are supported:
	gitweb.cgi/project.git
	gitweb.cgi/project.git/branch
	gitweb.cgi/project.git/branch/filename

The first one (show project summary) was already supported for a long time
now.  The other two are new: they show the shortlog of a branch or
the plain file contents of some file contained in the repository.

This is especially useful to support project web pages for small
projects: just create an html branch and then use an URL like
gitweb.cgi/project.git/html/index.html.

Signed-off-by: Martin Waitz <tali@admingilde.org>
---
 gitweb/gitweb.perl |   34 +++++++++++++++++++++++++++-------
 1 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 9324d71..2789657 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -171,12 +171,7 @@ if (defined $action) {
 	}
 }
 
-our $project = ($cgi->param('p') || $ENV{'PATH_INFO'});
-if (defined $project) {
-	$project =~ s|^/||;
-	$project =~ s|/$||;
-	$project = undef unless $project;
-}
+our $project = $cgi->param('p');
 if (defined $project) {
 	if (!validate_input($project)) {
 		die_error(undef, "Invalid project parameter");
@@ -187,7 +182,6 @@ if (defined $project) {
 	if (!(-e "$projectroot/$project/HEAD")) {
 		die_error(undef, "No such project");
 	}
-	$git_dir = "$projectroot/$project";
 }
 
 our $file_name = $cgi->param('f');
@@ -247,6 +241,32 @@ if (defined $searchtext) {
 	$searchtext = quotemeta $searchtext;
 }
 
+# now read PATH_INFO and use it as alternative to parameters
+our $path_info = $ENV{"PATH_INFO"};
+$path_info =~ s|^/||;
+$path_info =~ s|/$||;
+if (validate_input($path_info) && !defined $project) {
+	$project = $path_info;
+	while ($project && !-e "$projectroot/$project/HEAD") {
+		$project =~ s,/*[^/]*$,,;
+	}
+	if (defined $project) {
+		$project = undef unless $project;
+	}
+	if ($path_info =~ m,^$project/([^/]+)/(.+)$,) {
+		# we got "project.git/branch/filename"
+		$action    ||= "blob_plain";
+		$hash_base ||= $1;
+		$file_name ||= $2;
+	} elsif ($path_info =~ m,^$project/([^/]+)$,) {
+		# we got "project.git/branch"
+		$action ||= "shortlog";
+		$hash   ||= $1;
+	}
+}
+
+$git_dir = "$projectroot/$project";
+
 # dispatch
 my %actions = (
 	"blame" => \&git_blame2,
-- 
1.4.2.gb8b6b

-- 
Martin Waitz
