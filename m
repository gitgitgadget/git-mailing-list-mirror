From: Jon Loeliger <jdl@jdl.com>
Subject: [PATCH] Move config options into separate package.
Date: Wed, 22 Mar 2006 20:49:51 -0600
Message-ID: <E1FMFtX-0000W4-Tx@jdl.com>
X-From: git-owner@vger.kernel.org Thu Mar 23 03:50:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMFuB-00010J-GF
	for gcvg-git@gmane.org; Thu, 23 Mar 2006 03:50:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964911AbWCWCuW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Mar 2006 21:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964910AbWCWCuW
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Mar 2006 21:50:22 -0500
Received: from www.jdl.com ([66.118.10.122]:61605 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S964911AbWCWCuV (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Mar 2006 21:50:21 -0500
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1FMFtX-0000W4-Tx
	for git@vger.kernel.org; Wed, 22 Mar 2006 20:49:53 -0600
To: git@vger.kernel.org
X-Spam-Score: -5.9 (-----)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17848>


Allow new gitweb.cgi to be installed without having to
continually tinker with the site-specific configuration
options need for an install.

Signed-off-by: Jon Loeliger <jdl@jdl.com>

---

This patch can be pulled directly from the "jdl" branch here:

    http://www.jdl.com/pub/software/gitweb.git


 gitweb.cgi       |   29 ++++++++++++-----------------
 gitweb_config.pm |   42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 17 deletions(-)
 create mode 100644 gitweb_config.pm

a55eba90ac75a5f722b865e631a728d4a6446d07
diff --git a/gitweb.cgi b/gitweb.cgi
index c1bb624..4d3bcd6 100755
--- a/gitweb.cgi
+++ b/gitweb.cgi
@@ -16,31 +16,26 @@ use Encode;
 use Fcntl ':mode';
 binmode STDOUT, ':utf8';
 
+require gitweb_config;
+
 my $cgi = new CGI;
 my $version =		"264";
 my $my_url =		$cgi->url();
 my $my_uri =		$cgi->url(-absolute => 1);
 my $rss_link =		"";
 
-# absolute fs-path which will be prepended to the project path
-#my $projectroot =	"/pub/scm";
-my $projectroot =	"/home/kay/public_html/pub/scm";
-
-# location of the git-core binaries
-my $gitbin =		"/usr/bin";
-
-# location for temporary files needed for diffs
-my $git_temp =		"/tmp/gitweb";
-
 # target of the home link on top of all pages
-my $home_link =		$my_uri;
+my $home_link =	$my_uri;
 
-# html text to include at home page
-my $home_text =		"indextext.html";
+# Get config values or use defaults.
+my $config_opts = gitweb_config::get_config_opts();
+my $gitbin = $config_opts->{gitbin} || "/usr/bin";
+my $git_temp = $config_opts->{git_temp} || "/tmp/gitweb";
+my $projectroot = $config_opts->{projectroot} || "/pub/scm";
+my $home_text =	$config_opts->{home_text} || "indextext.html";
+my $projects_list = $config_opts->{projects_list} || "index/index.aux";
+my $description_len = $config_opts->{description_len} || 25;
 
-# source of projects list
-#my $projects_list =	$projectroot;
-my $projects_list =	"index/index.aux";
 
 # input validation and dispatch
 my $action = $cgi->param('a');
@@ -853,7 +848,7 @@ sub git_project_list {
 		$pr->{'commit'} = \%co;
 		if (!defined $pr->{'descr'}) {
 			my $descr = git_read_description($pr->{'path'}) || "";
-			$pr->{'descr'} = chop_str($descr, 25, 5);
+			$pr->{'descr'} = chop_str($descr, $description_len, 5);
 		}
 		if (!defined $pr->{'owner'}) {
 			$pr->{'owner'} = get_file_owner("$projectroot/$pr->{'path'}") || "";
diff --git a/gitweb_config.pm b/gitweb_config.pm
new file mode 100644
index 0000000..d67fb34
--- /dev/null
+++ b/gitweb_config.pm
@@ -0,0 +1,42 @@
+#
+# This program is licensed under the GPLv2
+#
+
+#
+# Configuration Options for gitweb
+#
+# gitbin: Location of the git-core binaries
+#	"/usr/bin"
+#
+# git_temp: Location for temporary files needed for diffs
+#	"/tmp/gtiweb"
+#
+# projectroot: Absolute fs-path which will be prepended to the project path
+#	"/pub/scm"
+#	"/home/kay/public_html/pub/scm"
+#
+# projects_list: Source of projects list
+#	"/pub/scm"
+#	"index/index.aux"
+#
+# home_text: Html text to include at home page
+#	"indextext.html"
+#
+# description_len: Length of description field
+#	25
+#	35
+
+package gitweb_config;
+
+my $opts = {
+    gitbin => "/usr/bin",
+    git_temp => "/tmp/gitweb",
+    projectroot => "/pub/software",
+    projects_list => "/pub/software",
+    home_text => "indextext.html",
+    description_len => 35,
+};
+
+sub get_config_opts { return $opts; }
+
+1;
-- 
1.2.4.gc98264
