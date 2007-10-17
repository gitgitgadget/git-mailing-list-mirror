From: Luke Lu <git@vicaya.com>
Subject: [PATCH] gitweb: speed up project listing by limiting find depth
Date: Tue, 16 Oct 2007 18:13:26 -0700
Message-ID: <1192583606-14893-1-git-send-email-git@vicaya.com>
Cc: pasky@suse.cz, Luke Lu <git@vicaya.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 17 03:14:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhxU8-00063D-V8
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 03:14:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754018AbXJQBN6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 21:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755243AbXJQBN6
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 21:13:58 -0400
Received: from alnrmhc14.comcast.net ([206.18.177.54]:54009 "EHLO
	alnrmhc14.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753561AbXJQBN6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 21:13:58 -0400
X-Greylist: delayed 9354 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Oct 2007 21:13:58 EDT
Received: from localhost.localdomain (c-98-207-63-2.hsd1.ca.comcast.net[98.207.63.2])
          by comcast.net (alnrmhc14) with SMTP
          id <20071017011356b1400cvl1fe>; Wed, 17 Oct 2007 01:13:56 +0000
X-Mailer: git-send-email 1.5.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61300>

Resubmit patch due to tab/space issue :)

Signed-off-by: Luke Lu <git@vicaya.com>
---
 Makefile           |    2 ++
 gitweb/gitweb.perl |   11 +++++++++++
 2 files changed, 13 insertions(+), 0 deletions(-)

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
index 3064298..d62357f 100755
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
 
@@ -1509,16 +1513,23 @@ sub git_get_projects_list {
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
+				if (tr!/!! - $pfxdepth > $project_maxdepth) {
+					$File::Find::prune = 1;
+					return;
+				}
 
 				my $subdir = substr($File::Find::name, $pfxlen + 1);
 				# we check related file in $projectroot
-- 
1.5.3.4
