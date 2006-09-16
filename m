From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] gitweb: export-ok option
Date: Sat, 16 Sep 2006 21:27:50 +0200
Message-ID: <20060916192750.GA27008@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Sep 16 21:28:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOfpX-00079U-2e
	for gcvg-git@gmane.org; Sat, 16 Sep 2006 21:27:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751015AbWIPT1y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Sep 2006 15:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbWIPT1y
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Sep 2006 15:27:54 -0400
Received: from moooo.ath.cx ([85.116.203.178]:16863 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1751015AbWIPT1x (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Sep 2006 15:27:53 -0400
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27127>

Similar to git-daemon checking for git-daemon-export-ok this
introduces an optional check before showing a repository in gitweb.

I also changed the 'No such directory' error message to 'No such
project' because the user visiting my gitweb should not know what
directories I have in the project root directory.

undef $project; is used to prevent displaying the description.
---
Perhaps there should be another option which allows only those
repositories to be shown which are in $projects_list.
---
 Makefile           |    2 ++
 gitweb/gitweb.perl |   18 ++++++++++++------
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 7b3114f..63df24c 100644
--- a/Makefile
+++ b/Makefile
@@ -132,6 +132,7 @@ GITWEB_HOMETEXT = indextext.html
 GITWEB_CSS = gitweb.css
 GITWEB_LOGO = git-logo.png
 GITWEB_FAVICON = git-favicon.png
+GITWEB_EXPORT_OK =
 
 export prefix bindir gitexecdir template_dir GIT_PYTHON_DIR
 
@@ -637,6 +638,7 @@ gitweb/gitweb.cgi: gitweb/gitweb.perl
 	    -e 's|++GITWEB_CSS++|$(GITWEB_CSS)|g' \
 	    -e 's|++GITWEB_LOGO++|$(GITWEB_LOGO)|g' \
 	    -e 's|++GITWEB_FAVICON++|$(GITWEB_FAVICON)|g' \
+	    -e 's|++GITWEB_EXPORT_OK++|$(GITWEB_EXPORT_OK)|g' \
 	    $< >$@+
 	chmod +x $@+
 	mv $@+ $@
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index d89f709..3944d13 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -54,6 +54,9 @@ our $favicon = "++GITWEB_FAVICON++";
 # source of projects list
 our $projects_list = "++GITWEB_LIST++";
 
+# show repository only if this file exists
+our $export_ok = "++GITWEB_EXPORT_OK++";
+
 # list of git base URLs used for URL to where fetch project from,
 # i.e. full URL is "$git_base_url/$project"
 our @git_base_url_list = ("++GITWEB_BASE_URL++");
@@ -181,12 +184,13 @@ if (defined $project) {
 }
 if (defined $project) {
 	if (!validate_input($project)) {
+		undef $project;
 		die_error(undef, "Invalid project parameter");
 	}
-	if (!(-d "$projectroot/$project")) {
-		die_error(undef, "No such directory");
-	}
-	if (!(-e "$projectroot/$project/HEAD")) {
+	if (!(-d "$projectroot/$project") ||
+	    !(-e "$projectroot/$project/HEAD") ||
+	    ($export_ok && !(-e "$projectroot/$project/$export_ok"))) {
+		undef $project;
 		die_error(undef, "No such project");
 	}
 	$git_dir = "$projectroot/$project";
@@ -694,7 +698,8 @@ sub git_get_projects_list {
 		my $dir = $projects_list;
 		opendir my ($dh), $dir or return undef;
 		while (my $dir = readdir($dh)) {
-			if (-e "$projectroot/$dir/HEAD") {
+			if (-e "$projectroot/$dir/HEAD" && (!$export_ok ||
+			    -e "$projectroot/$dir/$export_ok")) {
 				my $pr = {
 					path => $dir,
 				};
@@ -716,7 +721,8 @@ sub git_get_projects_list {
 			if (!defined $path) {
 				next;
 			}
-			if (-e "$projectroot/$path/HEAD") {
+			if (-e "$projectroot/$path/HEAD" && (!$export_ok ||
+			    -e "$projectroot/$path/$export_ok")) {
 				my $pr = {
 					path => $path,
 					owner => decode("utf8", $owner, Encode::FB_DEFAULT),
-- 
1.4.2.g0ea2
