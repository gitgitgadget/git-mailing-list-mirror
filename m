From: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
Subject: [PATCH 1/3] gitweb: Add option to force version match
Date: Wed, 27 Oct 2010 17:42:52 -0700
Message-ID: <1288226574-19068-2-git-send-email-warthog9@eaglescrag.net>
References: <1288226574-19068-1-git-send-email-warthog9@eaglescrag.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.2.3"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 28 03:35:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBHOo-000372-3s
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 03:35:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932437Ab0J1BfW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 21:35:22 -0400
Received: from shards.monkeyblade.net ([198.137.202.13]:48194 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758067Ab0J1BfQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 21:35:16 -0400
X-Greylist: delayed 3133 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Oct 2010 21:35:15 EDT
Received: from voot-cruiser.middle.earth (173-27-0-103.client.mchsi.com [173.27.0.103])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.3) with ESMTP id o9S0gucM008331
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 27 Oct 2010 17:43:02 -0700
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1288226574-19068-1-git-send-email-warthog9@eaglescrag.net>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Wed, 27 Oct 2010 17:43:03 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160149>

This is a multi-part message in MIME format.
--------------1.7.2.3
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


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
 gitweb/README      |    4 ++++
 gitweb/gitweb.perl |   27 +++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 0 deletions(-)


--------------1.7.2.3
Content-Type: text/x-patch; name="0001-gitweb-Add-option-to-force-version-match.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline; filename="0001-gitweb-Add-option-to-force-version-match.patch"

diff --git a/gitweb/README b/gitweb/README
index bf3664f..7ee8450 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -246,6 +246,10 @@ not include variables usually directly set during build):
    http://www.andre-simon.de due to assumptions about parameters and output).
    Useful if highlight is not installed on your webserver's PATH.
    [Default: highlight]
+ * $git_versions_must_match
+   If set, gitweb fails with 500 Internal Server Error if the version of gitweb
+   doesn't match version of git binary.  The default is true.
+
 
 Projects list file format
 ~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 8d7e4c5..215a4e9 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -232,6 +232,9 @@ our %avatar_size = (
 	'double'  => 32
 );
 
+# If it is true, exit if gitweb version and git binary version don't match
+our $git_versions_must_match = 1;
+
 # Used to set the maximum load that we will still respond to gitweb queries.
 # If server load exceed this value then return "503 server busy" error.
 # If gitweb cannot determined server load, it is taken to be 0.
@@ -649,6 +652,29 @@ sub check_loadavg {
 	}
 }
 
+sub check_versionmatch {
+	# Throw an error if git versions does not match, if $git_versions_must_match is true.
+	if ($git_versions_must_match &&
+	    $git_version ne $version) {
+		my $admin_contact =
+			defined $ENV{'SERVER_ADMIN'} ? ", $ENV{'SERVER_ADMIN'}," : '';
+		my $err_msg = <<EOT;
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
+		die_error(500, 'Internal server error', $err_msg);
+	}
+
+}
+
 # ======================================================================
 # input validation and dispatch
 
@@ -1075,6 +1101,7 @@ sub run_request {
 	evaluate_uri();
 	evaluate_gitweb_config();
 	check_loadavg();
+	check_versionmatch();
 
 	# $projectroot and $projects_list might be set in gitweb config file
 	$projects_list ||= $projectroot;

--------------1.7.2.3--
