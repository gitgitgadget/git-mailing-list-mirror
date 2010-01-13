From: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
Subject: [PATCH 4/7] gitweb: Optionally add "git" links in project list page
Date: Wed, 13 Jan 2010 01:34:39 -0800
Message-ID: <1263375282-15508-5-git-send-email-warthog9@eaglescrag.net>
References: <1263375282-15508-1-git-send-email-warthog9@eaglescrag.net>
 <1263375282-15508-2-git-send-email-warthog9@eaglescrag.net>
 <1263375282-15508-3-git-send-email-warthog9@eaglescrag.net>
 <1263375282-15508-4-git-send-email-warthog9@eaglescrag.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 13 10:35:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUzdP-0004Yv-Jg
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 10:35:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755292Ab0AMJe5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 04:34:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755269Ab0AMJet
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 04:34:49 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:57268 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755150Ab0AMJer (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 04:34:47 -0500
Received: from localhost.localdomain (c-71-202-189-206.hsd1.ca.comcast.net [71.202.189.206])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.3/8.14.3) with ESMTP id o0D9Yg1V018510
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 13 Jan 2010 01:34:46 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
X-Mailer: git-send-email 1.6.5.2
In-Reply-To: <1263375282-15508-4-git-send-email-warthog9@eaglescrag.net>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Wed, 13 Jan 2010 01:34:46 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136801>

From: John 'Warthog9' Hawley <warthog9@kernel.org>

This adds a "git" link for each project in the project list page,
should a common $gitlinkurl_project be defined and not empty.  The full
URL of each link is composed of $git_base_url_list[0] and project name.
It is intended for git:// links or that something can reference the git
repository using a smart protocol directly.

This does make the assumption that the git repositories share a common
path, which is no different than the assumption @git_base_url_list makes.
Nothing to date is known to actually make use of introduced link.

Created "git" link follows rel=vcs-* microformat specification:
  http://kitenet.net/~joey/rfc/rel-vcs/

Signed-off-by: John 'Warthog9' Hawley <warthog9@kernel.org>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/README      |    4 ++++
 gitweb/gitweb.perl |    9 +++++++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/gitweb/README b/gitweb/README
index 608b0f8..2ec66e7 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -71,6 +71,7 @@ You can specify the following configuration variables when building GIT:
  * GITWEB_BASE_URL
    Git base URLs used for URL to where fetch project from, i.e. full
    URL is "$git_base_url/$project".  Shown on projects summary page.
+   If it begins with "git://" it is also used for $gitlinkurl_base, see below.
    Repository URL for project can be also configured per repository; this
    takes precedence over URLs composed from base URL and a project name.
    Note that you can setup multiple base URLs (for example one for
@@ -204,6 +205,9 @@ not include variables usually directly set during build):
    access, and one for http:// "dumb" protocol access).  Note that per
    repository configuration in 'cloneurl' file, or as values of gitweb.url
    project config.
+ * $gitlinkurl_project
+   Boolean (if it is defined and not empty) to add "git" link in
+   projects list, for each project.  Full URL is "$git_base_url_list[0]/$project".
  * $default_blob_plain_mimetype
    Default mimetype for blob_plain (raw) view, if mimetype checking
    doesn't result in some other type; by default 'text/plain'.
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index f17593f..b8f2a67 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -224,6 +224,11 @@ our %avatar_size = (
 # If it is true, exit if gitweb version and git binary version don't match
 our $git_versions_must_match = 0;
 
+# This is a boolean on/off switch to add a "git" link for each project in
+#  project list.  It uses the first element of @git_base_url_list as the
+#  base of the URL.  Full URL is "$git_base_url_list[0]/$project".
+our $gitlinkurl_project = '';
+
 # Used to set the maximum load that we will still respond to gitweb queries.
 # If server load exceed this value then return "503 server busy" error.
 # If gitweb cannot determined server load, it is taken to be 0.
@@ -4473,6 +4478,10 @@ sub git_project_list_body {
 		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"log")}, "log") . " | " .
 		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"tree")}, "tree") .
 		      ($pr->{'forks'} ? " | " . $cgi->a({-href => href(project=>$pr->{'path'}, action=>"forks")}, "forks") : '') .
+		      ($gitlinkurl_project && $git_base_url_list[0] ?
+		       " | " . $cgi->a({-href=> $git_base_url_list[0] ."/$pr->{'path'}",
+		                        -rel=>"vcs-git"}, "git")
+		      : '') .
 		      "</td>\n" .
 		      "</tr>\n";
 	}
-- 
1.6.5.2
