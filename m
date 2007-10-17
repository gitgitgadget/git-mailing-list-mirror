From: Luke Lu <git@vicaya.com>
Subject: [PATCH] gitweb: speed up project listing by limiting find depth
Date: Tue, 16 Oct 2007 17:24:51 -0700
Message-ID: <1192580691-14308-1-git-send-email-git@vicaya.com>
Cc: gitster@pobox.com, Luke Lu <git@vicaya.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 17 02:30:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihwnz-0007ij-72
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 02:30:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761766AbXJQAaZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 20:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761282AbXJQAaZ
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 20:30:25 -0400
Received: from sccrmhc13.comcast.net ([204.127.200.83]:45836 "EHLO
	sccrmhc13.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755956AbXJQAaY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 20:30:24 -0400
Received: from localhost.localdomain (c-98-207-63-2.hsd1.ca.comcast.net[98.207.63.2])
          by comcast.net (sccrmhc13) with SMTP
          id <2007101700252101300pijgve>; Wed, 17 Oct 2007 00:25:21 +0000
X-Mailer: git-send-email 1.5.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61288>

Resubmit patch to make project max depth configurable.

Signed-off-by: Luke Lu <git@vicaya.com>
---
 Makefile           |    2 ++
 gitweb/gitweb.perl |    8 ++++++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 8db4dbe..b70ba8c 100644
--- a/Makefile
+++ b/Makefile
@@ -165,6 +165,7 @@ GITWEB_CONFIG = gitweb_config.perl
 GITWEB_HOME_LINK_STR = projects
 GITWEB_SITENAME =
 GITWEB_PROJECTROOT = /pub/git
+GITWEB_PROJECT_MAXDEPTH = 2
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
index 3064298..1453101 100755
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
 
@@ -1509,16 +1513,20 @@ sub git_get_projects_list {
 		# remove the trailing "/"
 		$dir =~ s!/+$!!;
 		my $pfxlen = length("$dir");
+		my $pfxdepth = ($dir =~ tr!/!!);
 
 		File::Find::find({
 			follow_fast => 1, # follow symbolic links
 			follow_skip => 2, # ignore duplicates
+			no_chdir => 1, # don't chdir into every directory
 			dangling_symlinks => 0, # ignore dangling symlinks, silently
 			wanted => sub {
 				# skip project-list toplevel, if we get it.
 				return if (m!^[/.]$!);
 				# only directories can be git repositories
 				return unless (-d $_);
+				# don't traverse too deep (Find is super slow on os x)
+				return if tr!/!! - $pfxdepth > $project_maxdepth && ($File::Find::prune = 1);
 
 				my $subdir = substr($File::Find::name, $pfxlen + 1);
 				# we check related file in $projectroot
-- 
1.5.3.4
