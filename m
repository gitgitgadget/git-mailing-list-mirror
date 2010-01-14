From: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
Subject: [PATCH 3/9] gitweb: Add option to force version match
Date: Wed, 13 Jan 2010 17:22:59 -0800
Message-ID: <1263432185-21334-4-git-send-email-warthog9@eaglescrag.net>
References: <1263432185-21334-1-git-send-email-warthog9@eaglescrag.net>
 <1263432185-21334-2-git-send-email-warthog9@eaglescrag.net>
 <1263432185-21334-3-git-send-email-warthog9@eaglescrag.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 14 02:23:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVERH-0002pa-Di
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 02:23:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753669Ab0ANBXO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 20:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751068Ab0ANBXN
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 20:23:13 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:56017 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751500Ab0ANBXL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 20:23:11 -0500
Received: from localhost.localdomain (c-71-202-189-206.hsd1.ca.comcast.net [71.202.189.206])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.3/8.14.3) with ESMTP id o0E1N5Lp009231
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 13 Jan 2010 17:23:11 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
X-Mailer: git-send-email 1.6.5.2
In-Reply-To: <1263432185-21334-3-git-send-email-warthog9@eaglescrag.net>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Wed, 13 Jan 2010 17:23:11 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136910>

This adds $git_versions_must_match variable, which is set to true,
checks that we are running on the same version of git that we
shipped with, and if not throw '500 Internal Server Error' error.
What is checked is the version of gitweb (embedded in building
gitweb.cgi), against version of runtime git binary used.

Gitweb can usually run with a mismatched git install.  This is more
here to give an obvious warning as to whats going on vs. silently
failing.

By default this feature is turned on.

Signed-off-by: John 'Warthog9' Hawley <warthog9@kernel.org>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/README      |    3 +++
 gitweb/gitweb.perl |   23 +++++++++++++++++++++++
 2 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/gitweb/README b/gitweb/README
index 6c2c8e1..03151d2 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -233,6 +233,9 @@ not include variables usually directly set during build):
    If server load exceed this value then return "503 Service Unavaliable" error.
    Server load is taken to be 0 if gitweb cannot determine its value.  Set it to
    undefined value to turn it off.  The default is 300.
+ * $git_versions_must_match
+   If set, gitweb fails with 500 Internal Server Error if the version of gitweb
+   doesn't match version of git binary.  The default is true.
 
 
 Projects list file format
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 8298de5..b41bc33 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -221,6 +221,9 @@ our %avatar_size = (
 	'double'  => 32
 );
 
+# If it is true, exit if gitweb version and git binary version don't match
+our $git_versions_must_match = 1;
+
 # Used to set the maximum load that we will still respond to gitweb queries.
 # If server load exceed this value then return "503 server busy" error.
 # If gitweb cannot determined server load, it is taken to be 0.
@@ -587,6 +590,26 @@ if (defined $maxload && get_loadavg() > $maxload) {
 our $git_version = qx("$GIT" --version) =~ m/git version (.*)$/ ? $1 : "unknown";
 $number_of_git_cmds++;
 
+# Throw an error if git versions does not match, if $git_versions_must_match is true.
+if ($git_versions_must_match &&
+    $git_version ne $version) {
+	my $admin_contact =
+		defined $ENV{'SERVER_ADMIN'} ? ", $ENV{'SERVER_ADMIN'}," : '';
+	my $err_msg = <<EOT;
+<h1 align="center">*** Warning ***</h1>
+<p>
+This version of gitweb was compiled for <b>@{[esc_html($version)]}</b>,
+however git version <b>@{[esc_html($git_version)]}</b> was found on server,
+and administrator requested strict version checking.
+</p>
+<p>
+Please contact the server administrator${admin_contact} to either configure
+gitweb to allow mismatched versions, or update git or gitweb installation.
+</p>
+EOT
+	die_error(500, 'Internal server error', $err_msg);
+}
+
 $projects_list ||= $projectroot;
 
 # ======================================================================
-- 
1.6.5.2
