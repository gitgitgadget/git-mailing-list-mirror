From: Matt McCutchen <matt@mattmccutchen.net>
Subject: [PATCH try 2] gitweb: Add option to put a trailing slash on
 pathinfo-style project URLs
Date: Sat, 13 Dec 2008 16:11:29 -0500
Message-ID: <1229202689.31181.1.camel@mattlaptop2.local>
References: <1229195421.3943.8.camel@mattlaptop2.local>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 13 22:12:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBbnF-00046Q-AP
	for gcvg-git-2@gmane.org; Sat, 13 Dec 2008 22:12:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751657AbYLMVLc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Dec 2008 16:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751655AbYLMVLc
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Dec 2008 16:11:32 -0500
Received: from sd-green-bigip-202.dreamhost.com ([208.97.132.202]:38638 "EHLO
	jankymail-a5.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751516AbYLMVLc (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Dec 2008 16:11:32 -0500
Received: from [129.2.130.102] (129-2-130-102.wireless.umd.edu [129.2.130.102])
	by jankymail-a5.g.dreamhost.com (Postfix) with ESMTP id 80DD713EC8;
	Sat, 13 Dec 2008 13:11:30 -0800 (PST)
In-Reply-To: <1229195421.3943.8.camel@mattlaptop2.local>
X-Mailer: Evolution 2.24.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103019>

My Web site uses pathinfo mode and some rewrite magic to show the gitweb
interface at the URL of the real repository directory (which users also
pull from).  In this case, it's desirable to end generated links to the
project in a trailing slash so the Web server doesn't have to redirect
the client to add the slash.  This patch adds a second element to the
"pathinfo" feature configuration to control the trailing slash.

Signed-off-by: Matt McCutchen <matt@mattmccutchen.net>
---
Resending with a sign-off.

 gitweb/gitweb.perl |   28 ++++++++++++++++++++++------
 1 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 6eb370d..86511cf 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -270,6 +270,11 @@ our %feature = (
 	# $feature{'pathinfo'}{'default'} = [1];
 	# Project specific override is not supported.
 
+	# If you want a trailing slash on the project path (because, for
+	# example, you have a real directory at that URL and are using
+	# some rewrite magic to invoke gitweb), then set:
+	# $feature{'pathinfo'}{'default'} = [1, 1];
+
 	# Note that you will need to change the default location of CSS,
 	# favicon, logo and possibly other files to an absolute URL. Also,
 	# if gitweb.cgi serves as your indexfile, you will need to force
@@ -829,8 +834,8 @@ sub href (%) {
 		}
 	}
 
-	my $use_pathinfo = gitweb_check_feature('pathinfo');
-	if ($use_pathinfo) {
+	my @use_pathinfo = gitweb_get_feature('pathinfo');
+	if ($use_pathinfo[0]) {
 		# try to put as many parameters as possible in PATH_INFO:
 		#   - project name
 		#   - action
@@ -845,7 +850,12 @@ sub href (%) {
 		$href =~ s,/$,,;
 
 		# Then add the project name, if present
-		$href .= "/".esc_url($params{'project'}) if defined $params{'project'};
+		my $proj_href = undef;
+		if (defined $params{'project'}) {
+			$href .= "/".esc_url($params{'project'});
+			# Save for trailing-slash check below.
+			$proj_href = $href;
+		}
 		delete $params{'project'};
 
 		# since we destructively absorb parameters, we keep this
@@ -903,6 +913,10 @@ sub href (%) {
 			$href .= $known_snapshot_formats{$fmt}{'suffix'};
 			delete $params{'snapshot_format'};
 		}
+
+		# If requested in the configuration, add a trailing slash to a URL that
+		# has nothing appended after the project path.
+		$href .= '/' if ($use_pathinfo[1] && defined $proj_href && $href eq $proj_href);
 	}
 
 	# now encode the parameters explicitly
@@ -2987,13 +3001,15 @@ EOF
 			$search_hash = "HEAD";
 		}
 		my $action = $my_uri;
-		my $use_pathinfo = gitweb_check_feature('pathinfo');
-		if ($use_pathinfo) {
+		my @use_pathinfo = gitweb_get_feature('pathinfo');
+		if ($use_pathinfo[0]) {
 			$action .= "/".esc_url($project);
+			# Add a trailing slash if requested in the configuration.
+			$action .= '/' if ($use_pathinfo[1]);
 		}
 		print $cgi->startform(-method => "get", -action => $action) .
 		      "<div class=\"search\">\n" .
-		      (!$use_pathinfo &&
+		      (!$use_pathinfo[0] &&
 		      $cgi->input({-name=>"p", -value=>$project, -type=>"hidden"}) . "\n") .
 		      $cgi->input({-name=>"a", -value=>"search", -type=>"hidden"}) . "\n" .
 		      $cgi->input({-name=>"h", -value=>$search_hash, -type=>"hidden"}) . "\n" .
-- 
1.6.1.rc2.27.gc7114
