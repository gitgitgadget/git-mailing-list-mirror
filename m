From: Luke Lu <git@vicaya.com>
Subject: [PATCH] gitweb: speed up project listing on large work trees by limiting find depth
Date: Tue, 16 Oct 2007 20:45:25 -0700
Message-ID: <1192592725-28143-1-git-send-email-git@vicaya.com>
Cc: pasky@suse.cz, spearce@spearce.org, Luke Lu <git@vicaya.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 17 05:46:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhzrD-0002Nz-MF
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 05:46:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754776AbXJQDp4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 23:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754553AbXJQDp4
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 23:45:56 -0400
Received: from rwcrmhc13.comcast.net ([216.148.227.153]:57257 "EHLO
	rwcrmhc13.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752642AbXJQDp4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 23:45:56 -0400
Received: from localhost.localdomain (c-98-207-63-2.hsd1.ca.comcast.net[98.207.63.2])
          by comcast.net (rwcrmhc13) with SMTP
          id <20071017034554m1300ohq5oe>; Wed, 17 Oct 2007 03:45:55 +0000
X-Mailer: git-send-email 1.5.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61326>

Resubmitting patch after passing gitweb regression tests.

Signed-off-by: Luke Lu <git@vicaya.com>
---
 Makefile                               |    2 ++
 gitweb/gitweb.perl                     |   10 ++++++++++
 t/t9500-gitweb-standalone-no-errors.sh |    1 +
 3 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 8db4dbe..3e9938e 100644
--- a/Makefile
+++ b/Makefile
@@ -165,6 +165,7 @@ GITWEB_CONFIG = gitweb_config.perl
 GITWEB_HOME_LINK_STR = projects
 GITWEB_SITENAME =
 GITWEB_PROJECTROOT = /pub/git
+GITWEB_PROJECT_MAXDEPTH = 2007
 GITWEB_EXPORT_OK =
 GITWEB_STRICT_EXPORT =
 GITWEB_BASE_URL =
@@ -831,6 +832,7 @@ gitweb/gitweb.cgi: gitweb/gitweb.perl
 	    -e 's|++GITWEB_HOME_LINK_STR++|$(GITWEB_HOME_LINK_STR)|g' \
 	    -e 's|++GITWEB_SITENAME++|$(GITWEB_SITENAME)|g' \
 	    -e 's|++GITWEB_PROJECTROOT++|$(GITWEB_PROJECTROOT)|g' \
+	    -e 's|"++GITWEB_PROJECT_MAXDEPTH++"|$(GITWEB_PROJECT_MAXDEPTH)|g' \
 	    -e 's|++GITWEB_EXPORT_OK++|$(GITWEB_EXPORT_OK)|g' \
 	    -e 's|++GITWEB_STRICT_EXPORT++|$(GITWEB_STRICT_EXPORT)|g' \
 	    -e 's|++GITWEB_BASE_URL++|$(GITWEB_BASE_URL)|g' \
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 3064298..48e21da 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -35,6 +35,10 @@ our $GIT = "++GIT_BINDIR++/git";
 #our $projectroot = "/pub/scm";
 our $projectroot = "++GITWEB_PROJECTROOT++";
 
+# fs traversing limit for getting project list
+# the number is relative to the projectroot
+our $project_maxdepth = "++GITWEB_PROJECT_MAXDEPTH++";
+
 # target of the home link on top of all pages
 our $home_link = $my_uri || "/";
 
@@ -1509,6 +1513,7 @@ sub git_get_projects_list {
 		# remove the trailing "/"
 		$dir =~ s!/+$!!;
 		my $pfxlen = length("$dir");
+		my $pfxdepth = ($dir =~ tr!/!!);
 
 		File::Find::find({
 			follow_fast => 1, # follow symbolic links
@@ -1519,6 +1524,11 @@ sub git_get_projects_list {
 				return if (m!^[/.]$!);
 				# only directories can be git repositories
 				return unless (-d $_);
+				# don't traverse too deep (Find is super slow on os x)
+				if (($File::Find::name =~ tr!/!!) - $pfxdepth > $project_maxdepth) {
+					$File::Find::prune = 1;
+					return;
+				}
 
 				my $subdir = substr($File::Find::name, $pfxlen + 1);
 				# we check related file in $projectroot
diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index 642b836..f7bad5b 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -18,6 +18,7 @@ gitweb_init () {
 our \$version = "current";
 our \$GIT = "git";
 our \$projectroot = "$(pwd)";
+our \$project_maxdepth = 8;
 our \$home_link_str = "projects";
 our \$site_name = "[localhost]";
 our \$site_header = "";
-- 
1.5.3.4
