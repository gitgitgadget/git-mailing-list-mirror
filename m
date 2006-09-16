From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] gitweb: export options
Date: Sun, 17 Sep 2006 00:31:01 +0200
Message-ID: <20060916223101.GB32679@moooo.ath.cx>
References: <20060916192750.GA27008@moooo.ath.cx> <20060916223027.GA32679@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Sep 17 00:31:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOih4-0001QC-5U
	for gcvg-git@gmane.org; Sun, 17 Sep 2006 00:31:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbWIPWbG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Sep 2006 18:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964803AbWIPWbG
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Sep 2006 18:31:06 -0400
Received: from moooo.ath.cx ([85.116.203.178]:5811 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S964796AbWIPWbD (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Sep 2006 18:31:03 -0400
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060916223027.GA32679@moooo.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27140>

$export_ok: If this variable evaluates to true it is checked
if a file with this name exists in the repository.  If it
does not exist the repository cannot be viewed from gitweb.
(Similar to git-daemon-export-ok for git-daemon).

$strict_export: If this variable evaluates to true only
repositories listed on the project-list-page of gitweb can
be accessed.
---
 Makefile           |    4 ++++
 gitweb/gitweb.perl |   23 ++++++++++++++++++++---
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 7b3114f..b9938ac 100644
--- a/Makefile
+++ b/Makefile
@@ -126,6 +126,8 @@ GITWEB_CONFIG = gitweb_config.perl
 GITWEB_HOME_LINK_STR = projects
 GITWEB_SITENAME =
 GITWEB_PROJECTROOT = /pub/git
+GITWEB_EXPORT_OK =
+GITWEB_STRICT_EXPORT =
 GITWEB_BASE_URL =
 GITWEB_LIST =
 GITWEB_HOMETEXT = indextext.html
@@ -631,6 +633,8 @@ gitweb/gitweb.cgi: gitweb/gitweb.perl
 	    -e 's|++GITWEB_HOME_LINK_STR++|$(GITWEB_HOME_LINK_STR)|g' \
 	    -e 's|++GITWEB_SITENAME++|$(GITWEB_SITENAME)|g' \
 	    -e 's|++GITWEB_PROJECTROOT++|$(GITWEB_PROJECTROOT)|g' \
+	    -e 's|++GITWEB_EXPORT_OK++|$(GITWEB_EXPORT_OK)|g' \
+	    -e 's|++GITWEB_STRICT_EXPORT++|$(GITWEB_STRICT_EXPORT)|g' \
 	    -e 's|++GITWEB_BASE_URL++|$(GITWEB_BASE_URL)|g' \
 	    -e 's|++GITWEB_LIST++|$(GITWEB_LIST)|g' \
 	    -e 's|++GITWEB_HOMETEXT++|$(GITWEB_HOMETEXT)|g' \
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 07ea1ea..2a63c17 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -54,6 +54,13 @@ our $favicon = "++GITWEB_FAVICON++";
 # source of projects list
 our $projects_list = "++GITWEB_LIST++";
 
+# show repository only if this file exists
+# (only effective if this variable evaluates to true)
+our $export_ok = "++GITWEB_EXPORT_OK++";
+
+# only allow viewing of repositories also shown on the overview page
+our $strict_export = "++GITWEB_STRICT_EXPORT++";
+
 # list of git base URLs used for URL to where fetch project from,
 # i.e. full URL is "$git_base_url/$project"
 our @git_base_url_list = ("++GITWEB_BASE_URL++");
@@ -205,7 +212,9 @@ if (defined $project) {
 if (defined $project) {
 	if (!validate_input($project) ||
 	    !(-d "$projectroot/$project") ||
-	    !(-e "$projectroot/$project/HEAD")) {
+	    !(-e "$projectroot/$project/HEAD") ||
+	    ($export_ok && !(-e "$projectroot/$project/$export_ok")) ||
+	    ($strict_export && !project_in_list($project))) {
 		undef $project;
 		die_error(undef, "No such project");
 	}
@@ -402,6 +411,12 @@ sub untabify {
 	return $line;
 }
 
+sub project_in_list {
+	my $project = shift;
+	my @list = git_get_projects_list();
+	return @list && scalar(grep { $_->{'path'} eq $project } @list);
+}
+
 ## ----------------------------------------------------------------------
 ## HTML aware string manipulation
 
@@ -714,7 +729,8 @@ sub git_get_projects_list {
 
 				my $subdir = substr($File::Find::name, $pfxlen + 1);
 				# we check related file in $projectroot
-				if (-e "$projectroot/$subdir/HEAD") {
+				if (-e "$projectroot/$subdir/HEAD" && (!$export_ok ||
+				    -e "$projectroot/$subdir/$export_ok")) {
 					push @list, { path => $subdir };
 					$File::Find::prune = 1;
 				}
@@ -735,7 +751,8 @@ sub git_get_projects_list {
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
