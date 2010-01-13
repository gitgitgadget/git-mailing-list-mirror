From: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
Subject: [PATCH 2/7] gitweb: Add option to force version match
Date: Wed, 13 Jan 2010 01:34:37 -0800
Message-ID: <1263375282-15508-3-git-send-email-warthog9@eaglescrag.net>
References: <1263375282-15508-1-git-send-email-warthog9@eaglescrag.net>
 <1263375282-15508-2-git-send-email-warthog9@eaglescrag.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 13 10:35:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUzdP-0004Yv-1p
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 10:35:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755290Ab0AMJev (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 04:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755268Ab0AMJes
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 04:34:48 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:57266 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755178Ab0AMJeq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 04:34:46 -0500
Received: from localhost.localdomain (c-71-202-189-206.hsd1.ca.comcast.net [71.202.189.206])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.3/8.14.3) with ESMTP id o0D9Yg1T018510
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 13 Jan 2010 01:34:45 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
X-Mailer: git-send-email 1.6.5.2
In-Reply-To: <1263375282-15508-2-git-send-email-warthog9@eaglescrag.net>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Wed, 13 Jan 2010 01:34:45 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136799>

From: John 'Warthog9' Hawley <warthog9@kernel.org>

This adds $git_versions_must_match variable, which is set to true
value checks that we are running on the same version of git that we
shipped with, and if not throw '500 Internal Server Error' error.
What is checked is the version of gitweb (embedded in building
gitweb.cgi), against version of runtime git binary used.

Gitweb can usually run with a mismatched git install.  This is more
here to give an obvious warning as to whats going on vs. silently
failing.

By default this feature is turned off.

v3 - warthog9: adjust to use die_error instead of recreating it
v2 - Jakub: Changes to make non-default, and change naming
v1 - warthog9: Initial

Signed-off-by: John 'Warthog9' Hawley <warthog9@kernel.org>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/README      |    3 +++
 gitweb/gitweb.perl |   28 ++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/gitweb/README b/gitweb/README
index 6c2c8e1..608b0f8 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -233,6 +233,9 @@ not include variables usually directly set during build):
    If server load exceed this value then return "503 Service Unavaliable" error.
    Server load is taken to be 0 if gitweb cannot determine its value.  Set it to
    undefined value to turn it off.  The default is 300.
+ * $git_versions_must_match
+   If set, gitweb fails with 500 Internal Server Error if the version of gitweb
+   doesn't match version of git binary.  The default is false.
 
 
 Projects list file format
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 0a07d3a..f17593f 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -221,6 +221,9 @@ our %avatar_size = (
 	'double'  => 32
 );
 
+# If it is true, exit if gitweb version and git binary version don't match
+our $git_versions_must_match = 0;
+
 # Used to set the maximum load that we will still respond to gitweb queries.
 # If server load exceed this value then return "503 server busy" error.
 # If gitweb cannot determined server load, it is taken to be 0.
@@ -587,6 +590,31 @@ if (defined $maxload && get_loadavg() > $maxload) {
 our $git_version = qx("$GIT" --version) =~ m/git version (.*)$/ ? $1 : "unknown";
 $number_of_git_cmds++;
 
+# Throw an error if git versions does not match, if $git_versions_must_match is true.
+if ($git_versions_must_match &&
+    $git_version ne $version) {
+	my $admin_contact =
+		defined $ENV{'SERVER_ADMIN'} ? ", $ENV{'SERVER_ADMIN'}," : '';
+	my $err_msg = <<EOT;
+Internal Server Error
+<br />
+</div>
+<hr />
+<div class="readme">
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
+	die_error(500, $err_msg);
+}
+
 $projects_list ||= $projectroot;
 
 # ======================================================================
-- 
1.6.5.2
