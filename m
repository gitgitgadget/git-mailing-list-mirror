From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] gitweb: Support hiding of chosen repositories from project list
Date: Fri, 06 Oct 2006 20:28:22 +0200
Message-ID: <20061006182822.9194.78330.stgit@rover>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 06 20:28:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVuQu-0003QE-Ci
	for gcvg-git@gmane.org; Fri, 06 Oct 2006 20:28:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422824AbWJFS2Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Oct 2006 14:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422823AbWJFS2Z
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Oct 2006 14:28:25 -0400
Received: from rover.dkm.cz ([62.24.64.27]:38605 "EHLO rover.dkm.cz")
	by vger.kernel.org with ESMTP id S1422824AbWJFS2Y (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Oct 2006 14:28:24 -0400
Received: from [127.0.0.1] (rover [127.0.0.1])
	by rover.dkm.cz (Postfix) with ESMTP id B3C1C8B4A2;
	Fri,  6 Oct 2006 20:28:22 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
User-Agent: StGIT/0.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28428>

This makes it possible to hide certain repository from project list
(while still keeping it accessible, so it's not just an inverse of
 export-ok). By default the file that needs to be created in the
repository is '.hide'.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Makefile           |    2 ++
 gitweb/gitweb.perl |   11 +++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index a151029..afb29e9 100644
--- a/Makefile
+++ b/Makefile
@@ -125,6 +125,7 @@ GITWEB_HOME_LINK_STR = projects
 GITWEB_SITENAME =
 GITWEB_PROJECTROOT = /srv/git
 GITWEB_EXPORT_OK =
+GITWEB_HIDE_REPO = .hide
 GITWEB_STRICT_EXPORT =
 GITWEB_BASE_URL =
 GITWEB_LIST =
@@ -673,6 +674,7 @@ gitweb/gitweb.cgi: gitweb/gitweb.perl
 	    -e 's|++GITWEB_SITENAME++|$(GITWEB_SITENAME)|g' \
 	    -e 's|++GITWEB_PROJECTROOT++|$(GITWEB_PROJECTROOT)|g' \
 	    -e 's|++GITWEB_EXPORT_OK++|$(GITWEB_EXPORT_OK)|g' \
+	    -e 's|++GITWEB_HIDE_REPO++|$(GITWEB_HIDE_REPO)|g' \
 	    -e 's|++GITWEB_STRICT_EXPORT++|$(GITWEB_STRICT_EXPORT)|g' \
 	    -e 's|++GITWEB_BASE_URL++|$(GITWEB_BASE_URL)|g' \
 	    -e 's|++GITWEB_LIST++|$(GITWEB_LIST)|g' \
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 3a10124..b06e96a 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -66,6 +66,11 @@ # show repository only if this file exis
 # (only effective if this variable evaluates to true)
 our $export_ok = "++GITWEB_EXPORT_OK++";
 
+# hide repository from the list if this file exists
+# (the repository is still accessible, just not shown in the project list)
+# (only effective if this variable evaulates to true)
+our $hide_repo = "++GITWEB_HIDE_REPO++";
+
 # only allow viewing of repositories also shown on the overview page
 our $strict_export = "++GITWEB_STRICT_EXPORT++";
 
@@ -864,7 +869,8 @@ sub git_get_projects_list {
 
 				my $subdir = substr($File::Find::name, $pfxlen + 1);
 				# we check related file in $projectroot
-				if (check_export_ok("$projectroot/$subdir")) {
+				if ((!$hide_repo or ! -e "$projectroot/$subdir/$hide_repo")
+				    and check_export_ok("$projectroot/$subdir")) {
 					push @list, { path => $subdir };
 					$File::Find::prune = 1;
 				}
@@ -885,7 +891,8 @@ sub git_get_projects_list {
 			if (!defined $path) {
 				next;
 			}
-			if (check_export_ok("$projectroot/$path")) {
+			if ((!$hide_repo or ! -e "$projectroot/$path/$hide_repo")
+			    and check_export_ok("$projectroot/$path")) {
 				my $pr = {
 					path => $path,
 					owner => decode("utf8", $owner, Encode::FB_DEFAULT),
