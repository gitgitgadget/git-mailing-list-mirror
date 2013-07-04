From: Tony Finch <dot@dotat.at>
Subject: [PATCH v3] gitweb: allow extra breadcrumbs to prefix the trail
Date: Thu, 4 Jul 2013 18:02:12 +0100
Message-ID: <E1UunDD-0004Xd-Vv@hermes-2.csi.cam.ac.uk>
References: <E1Uu3IT-0008U1-3c@hermes-2.csi.cam.ac.uk>
Cc: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 04 19:21:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UunDJ-0002ly-90
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 19:21:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756834Ab3GDRU5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jul 2013 13:20:57 -0400
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:39838 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756662Ab3GDRU4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jul 2013 13:20:56 -0400
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-2.csi.cam.ac.uk ([131.111.8.54]:34076)
	by ppsw-52.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.158]:25)
	with esmtpa (EXTERNAL:fanf2) id 1UunDE-00074T-D6 (Exim 4.80_167-5a66dd3)
	(return-path <fanf2@hermes.cam.ac.uk>); Thu, 04 Jul 2013 18:20:56 +0100
Received: from fanf2 by hermes-2.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local id 1UunDD-0004Xd-Vv (Exim 4.72)
	(return-path <fanf2@hermes.cam.ac.uk>); Thu, 04 Jul 2013 18:20:56 +0100
In-Reply-To: <E1Uu3IT-0008U1-3c@hermes-2.csi.cam.ac.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229598>

There are often parent pages logically above the gitweb projects
list, e.g. home pages of the organization and department that host
the gitweb server. This change allows you to include links to those
pages in gitweb's breadcrumb trail.

Signed-off-by: Tony Finch <dot@dotat.at>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/gitweb.conf.txt | 22 ++++++++++++++++++++--
 gitweb/gitweb.perl            |  7 ++++++-
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.txt
index ea0526e..305db63 100644
--- a/Documentation/gitweb.conf.txt
+++ b/Documentation/gitweb.conf.txt
@@ -336,8 +336,26 @@ $home_link_str::
 	used as the first component of gitweb's "breadcrumb trail":
 	`<home link> / <project> / <action>`.  Can be set at build time using
 	the `GITWEB_HOME_LINK_STR` variable.  By default it is set to "projects",
-	as this link leads to the list of projects.  Other popular choice it to
-	set it to the name of site.
+	as this link leads to the list of projects.  Another popular choice is to
+	set it to the name of site.  Note that it is treated as raw HTML so it
+	should not be set from untrusted sources.
+
+@extra_breadcrumbs::
+	Additional links to be added to the start of the breadcrumb trail before
+	the home link, to pages that are logically "above" the gitweb projects
+	list, such as the organization and department which host the gitweb
+	server. Each element of the list is a reference to an array, in which
+	element 0 is the link text (equivalent to `$home_link_str`) and element
+	1 is the target URL (equivalent to `$home_link`).
++
+For example, the following setting produces a breadcrumb trail like
+"home / dev / projects / ..." where "projects" is the home link.
+----------------------------------------------------------------------------
+    our @extra_breadcrumbs = (
+      [ 'home' => 'https://www.example.org/' ],
+      [ 'dev'  => 'https://dev.example.org/' ],
+    );
+----------------------------------------------------------------------------
 
 $logo_url::
 $logo_label::
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 8d69ada..f429f75 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -85,6 +85,9 @@ our $project_maxdepth = "++GITWEB_PROJECT_MAXDEPTH++";
 # string of the home link on top of all pages
 our $home_link_str = "++GITWEB_HOME_LINK_STR++";
 
+# extra breadcrumbs preceding the home link
+our @extra_breadcrumbs = ();
+
 # name of your site or organization to appear in page titles
 # replace this with something more descriptive for clearer bookmarks
 our $site_name = "++GITWEB_SITENAME++"
@@ -3982,7 +3985,9 @@ sub print_nav_breadcrumbs_path {
 sub print_nav_breadcrumbs {
 	my %opts = @_;
 
-	print $cgi->a({-href => esc_url($home_link)}, $home_link_str) . " / ";
+	for my $crumb (@extra_breadcrumbs, [ $home_link_str => $home_link ]) {
+		print $cgi->a({-href => esc_url($crumb->[1])}, $crumb->[0]) . " / ";
+	}
 	if (defined $project) {
 		my @dirname = split '/', $project;
 		my $projectbasename = pop @dirname;
-- 
1.8.3.1.605.g85318f5
