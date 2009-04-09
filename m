From: Erik Broes <erikbroes@ripe.net>
Subject: [PATCH] gitweb: Don't append '/' to project base URL if it ends with
 '/' or ':'
Date: Thu, 09 Apr 2009 21:59:21 +0200
Message-ID: <49DE5399.60402@ripe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 10 01:01:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ls3FT-0002OL-My
	for gcvg-git-2@gmane.org; Fri, 10 Apr 2009 01:01:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936754AbZDIW7w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 18:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936637AbZDIW7v
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 18:59:51 -0400
Received: from postgirl.ripe.net ([193.0.19.66]:49621 "EHLO postgirl.ripe.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765663AbZDIW7u (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2009 18:59:50 -0400
Received: from herring.ripe.net ([193.0.1.203])
	by postgirl.ripe.net with esmtp (Exim 4.63)
	(envelope-from <erikbroes@ripe.net>)
	id 1Ls0PB-0007f6-Pc
	for git@vger.kernel.org; Thu, 09 Apr 2009 21:59:22 +0200
Received: from Grumm.local (gw.office.nsrp.ripe.net [193.0.1.126])
	by herring.ripe.net (Postfix) with ESMTP id AD7B62F583
	for <git@vger.kernel.org>; Thu,  9 Apr 2009 21:59:21 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Macintosh/20090302)
X-RIPE-Spam-Level: ----
X-RIPE-Signature: a3d33ccd309479c043417935190f954dc4ae5decaba49b1040d77db6d009ee28
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116220>

The base URL 'user@host' would always be appended with a '/', making it
impossible to create clone URLs like: user@host:repo. Setting your base
URL to 'user@host:' will now have the desired effect.

Signed-off-by: Erik Broes <erikbroes@ripe.net>
---
 gitweb/README      |   13 +++++++------
 gitweb/gitweb.perl |    5 ++++-
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/gitweb/README b/gitweb/README
index 8433dd1..efb0f1b 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -69,12 +69,13 @@ You can specify the following configuration variables when building GIT:
    SERVER_NAME CGI environment variable is not set (e.g. if running
    gitweb as standalone script).  [No default]
  * GITWEB_BASE_URL
-   Git base URLs used for URL to where fetch project from, i.e. full
-   URL is "$git_base_url/$project".  Shown on projects summary page.
-   Repository URL for project can be also configured per repository; this
-   takes precedence over URLs composed from base URL and a project name.
-   Note that you can setup multiple base URLs (for example one for
-   git:// protocol access, another for http:// access) from the gitweb
+   Git base URLs used for URL to where fetch project from, i.e. full URL is
+   "$git_base_url/$project".  No '/' will be added between the base URL and and
+   the project if the base URL ends with either a ':' or '/'.  Shown on
+   projects summary page.  Repository URL for project can be also configured
+   per repository; this takes precedence over URLs composed from base URL and a
+   project name.  Note that you can setup multiple base URLs (for example one
+   for git:// protocol access, another for http:// access) from the gitweb
    config file.  [No default]
  * GITWEB_CSS
    Points to the location where you put gitweb.css on your web server
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 33ef190..179c48d 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4503,7 +4503,10 @@ sub git_summary {
 	# or make project git URL from git base URL and project name
 	my $url_tag = "URL";
 	my @url_list = git_get_project_url_list($project);
-	@url_list = map { "$_/$project" } @git_base_url_list unless @url_list;
+
+	# Only join with a '/' if there is no trailing '/' or ':'
+	@url_list = map { $_ .= '/' unless m{[:/]$}; $_.$project } @git_base_url_list unless @url_list;
+
 	foreach my $git_url (@url_list) {
 		next unless $git_url;
 		print "<tr class=\"metadata_url\"><td>$url_tag</td><td>$git_url</td></tr>\n";
-- 
1.6.2.1.519.gcf01bc
