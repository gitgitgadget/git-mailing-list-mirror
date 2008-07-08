From: Petr Baudis <pasky@suse.cz>
Subject: [HACK] gitweb: Support hiding of chosen repositories from project list
Date: Tue, 08 Jul 2008 18:56:55 +0200
Message-ID: <20080708165445.10663.26304.stgit@rover.dkm.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 08 19:31:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGH2H-0008V9-EO
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 19:31:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753544AbYGHRa2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 13:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752613AbYGHRa2
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 13:30:28 -0400
Received: from rover.dkm.cz ([62.24.64.27]:52862 "EHLO rover.dkm.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751125AbYGHRa2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 13:30:28 -0400
X-Greylist: delayed 1946 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Jul 2008 13:30:27 EDT
Received: from rover.dkm.cz (localhost [127.0.0.1])
	by rover.dkm.cz (Postfix) with ESMTP id 90A1D166743
	for <git@vger.kernel.org>; Tue,  8 Jul 2008 18:56:55 +0200 (CEST)
User-Agent: StGIT/0.14.3.171.ge0e6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87775>

This makes it possible to hide certain repository from project list
(while still keeping it accessible, so it's not just an inverse of
 export-ok). By default the file that needs to be created in the
repository is '.hide'.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

  I used this for something at repo.or.cz, but it is actually lying around
unused in my patch queue now; before removing it, I'm going to archive it on
the mailing list, maybe someone will find it useful.

 Makefile           |    2 ++
 gitweb/gitweb.perl |   11 +++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)


diff --git a/Makefile b/Makefile
index 3314dd6..b7c7f42 100644
--- a/Makefile
+++ b/Makefile
@@ -195,6 +195,7 @@ GITWEB_SITENAME =
 GITWEB_PROJECTROOT = /pub/git
 GITWEB_PROJECT_MAXDEPTH = 2007
 GITWEB_EXPORT_OK =
+GITWEB_HIDE_REPO = .hide
 GITWEB_STRICT_EXPORT =
 GITWEB_BASE_URL =
 GITWEB_LIST =
@@ -1130,6 +1131,7 @@ gitweb/gitweb.cgi: gitweb/gitweb.perl
 	    -e 's|++GITWEB_PROJECTROOT++|$(GITWEB_PROJECTROOT)|g' \
 	    -e 's|"++GITWEB_PROJECT_MAXDEPTH++"|$(GITWEB_PROJECT_MAXDEPTH)|g' \
 	    -e 's|++GITWEB_EXPORT_OK++|$(GITWEB_EXPORT_OK)|g' \
+	    -e 's|++GITWEB_HIDE_REPO++|$(GITWEB_HIDE_REPO)|g' \
 	    -e 's|++GITWEB_STRICT_EXPORT++|$(GITWEB_STRICT_EXPORT)|g' \
 	    -e 's|++GITWEB_BASE_URL++|$(GITWEB_BASE_URL)|g' \
 	    -e 's|++GITWEB_LIST++|$(GITWEB_LIST)|g' \
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 3b02d87..7ad0faa 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -90,6 +90,11 @@ our $default_projects_order = "project";
 # (only effective if this variable evaluates to true)
 our $export_ok = "++GITWEB_EXPORT_OK++";
 
+# hide repository from the list if this file exists
+# (the repository is still accessible, just not shown in the project list)
+# (only effective if this variable evaulates to true)
+our $hide_repo = "++GITWEB_HIDE_REPO++";
+
 # only allow viewing of repositories also shown on the overview page
 our $strict_export = "++GITWEB_STRICT_EXPORT++";
 
@@ -1796,7 +1801,8 @@ sub git_get_projects_list {
 				# we check related file in $projectroot
 				if ($check_forks and $subdir =~ m#/.#) {
 					$File::Find::prune = 1;
-				} elsif (check_export_ok("$projectroot/$filter/$subdir")) {
+				} elsif ((!$hide_repo or ! -e "$projectroot/$filter/$subdir/$hide_repo")
+				    and check_export_ok("$projectroot/$filter/$subdir")) {
 					push @list, { path => ($filter ? "$filter/" : '') . $subdir };
 					$File::Find::prune = 1;
 				}
@@ -1846,7 +1852,8 @@ sub git_get_projects_list {
 					next PROJECT;
 				}
 			}
-			if (check_export_ok("$projectroot/$path")) {
+			if ((!$hide_repo or ! -e "$projectroot/$path/$hide_repo")
+			    and check_export_ok("$projectroot/$path")) {
 				my $pr = {
 					path => $path,
 					owner => to_utf8($owner),
