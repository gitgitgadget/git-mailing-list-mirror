From: Damien Tournoud <damien@tournoud.net>
Subject: [PATCH] More flexible URL patterns for gitweb
Date: Sun, 11 Apr 2010 02:40:29 +0200
Message-ID: <1270946429-5366-1-git-send-email-damien@tournoud.net>
Cc: Damien Tournoud <damien@tournoud.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 11 02:47:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0lKf-0001jl-Ml
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 02:47:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752298Ab0DKArH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 20:47:07 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:35755 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752259Ab0DKArF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 20:47:05 -0400
X-Greylist: delayed 387 seconds by postgrey-1.27 at vger.kernel.org; Sat, 10 Apr 2010 20:47:05 EDT
Received: by mail-bw0-f219.google.com with SMTP id 19so110224bwz.21
        for <git@vger.kernel.org>; Sat, 10 Apr 2010 17:47:03 -0700 (PDT)
Received: by 10.204.81.145 with SMTP id x17mr2348533bkk.31.1270946434791;
        Sat, 10 Apr 2010 17:40:34 -0700 (PDT)
Received: from localhost.localdomain (bdv75-6-82-230-177-196.fbx.proxad.net [82.230.177.196])
        by mx.google.com with ESMTPS id a11sm23577934bkc.3.2010.04.10.17.40.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 10 Apr 2010 17:40:34 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144616>

@git_base_url_list hardcodes URLs in the form "$git_base_url/$project",
which makes impossible to generate proper URLs for SSH access scenarios.

This patch implements a more flexible replacement scheme, using a
simple placeholder for the project path, and fixes the associated
documentation.

Signed-off-by: Damien Tournoud <damien@tournoud.net>
---
 gitweb/README      |   13 ++++++-------
 gitweb/gitweb.perl |    2 +-
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/gitweb/README b/gitweb/README
index ad6a04c..f16729c 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -197,13 +197,12 @@ not include variables usually directly set during build):
    full description is available as 'title' attribute (usually shown on
    mouseover).  By default set to 25, which might be too small if you
    use long project descriptions.
- * @git_base_url_list
-   List of git base URLs used for URL to where fetch project from, shown
-   in project summary page.  Full URL is "$git_base_url/$project".
-   You can setup multiple base URLs (for example one for  git:// protocol
-   access, and one for http:// "dumb" protocol access).  Note that per
-   repository configuration in 'cloneurl' file, or as values of gitweb.url
-   project config.
+ * @git_base_url_patterns
+   List of git base URLs patterns used to build the URLs displayed in the
+   project summary page. Examples include "git://git.example.com/%project",
+   "http://git.example.com/%project" and "git@git.example.com:%project".
+   Note that per repository configuration in a 'cloneurl' file, or configuration
+   values of gitweb.url in the project config take precedence over this.
  * $default_blob_plain_mimetype
    Default mimetype for blob_plain (raw) view, if mimetype checking
    doesn't result in some other type; by default 'text/plain'.
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c356e95..0fc5957 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4904,7 +4904,7 @@ sub git_summary {
 	# or make project git URL from git base URL and project name
 	my $url_tag = "URL";
 	my @url_list = git_get_project_url_list($project);
-	@url_list = map { "$_/$project" } @git_base_url_list unless @url_list;
+	@url_list = map { my $url = $_; $url =~ s/%project/$project/g; $url } @git_base_url_list unless @url_list;
 	foreach my $git_url (@url_list) {
 		next unless $git_url;
 		print "<tr class=\"metadata_url\"><td>$url_tag</td><td>$git_url</td></tr>\n";
-- 
1.6.5.7
