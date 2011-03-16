From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 1/2] gitweb: fix #patchNN anchors when path_info is enabled
Date: Tue, 15 Mar 2011 19:15:54 -0700
Message-ID: <3ef1af6874437043a4451bfbcae59b2b@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 16 03:31:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzgVx-0001YX-Ca
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 03:31:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482Ab1CPCbD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2011 22:31:03 -0400
Received: from [69.28.251.93] ([69.28.251.93]:56913 "EHLO b32.net"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751188Ab1CPCbB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2011 22:31:01 -0400
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Mar 2011 22:31:01 EDT
Received: (qmail 31783 invoked from network); 16 Mar 2011 02:24:19 -0000
Received: from localhost (HELO vps-1001064-677.cp.jvds.com) (127.0.0.1)
  by localhost with (DHE-RSA-AES128-SHA encrypted) SMTP; 16 Mar 2011 02:24:19 -0000
Received: by vps-1001064-677.cp.jvds.com (sSMTP sendmail emulation); Tue, 15 Mar 2011 19:24:17 -0700
User-Agent: vim 7.2
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169096>

My configuration is as follows:

$feature{'pathinfo'}{'default'} = [1];

<Location /gitweb>
        Options ExecCGI
        SetHandler cgi-script
</Location>

GITWEB_{JS,CSS,LOGO,...} all start with gitweb-static/

gitweb.cgi renamed to /var/www/html/gitweb

This gives me simple, easy-to-read URLs that look like:

http://HOST/gitweb/myproject.git/commitdiff/0faa4a6ef921d8a233f30d66f9a3e1b24e8ec906

The problem is that in this configuration, PATH_INFO is used to set the
base URL:

<base href="http://HOST/gitweb">

This breaks the "patch" anchor links seen on the commitdiff pages,
because they are computed relative to the base URL:

http://HOST/gitweb#patch1

My solution is to add an "anchor" parameter to href(), so that the full
path is included in the patchNN links.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 gitweb/gitweb.perl |   31 +++++++++++++++++++++++++------
 1 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1b9369d..3b6a90d 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1199,6 +1199,7 @@ if (defined caller) {
 # -full => 0|1      - use absolute/full URL ($my_uri/$my_url as base)
 # -replay => 1      - start from a current view (replay with modifications)
 # -path_info => 0|1 - don't use/use path_info URL (if possible)
+# -anchor           - add #ANCHOR to end of URL
 sub href {
 	my %params = @_;
 	# default is to use -absolute url() i.e. $my_uri
@@ -1314,6 +1315,10 @@ sub href {
 	# final transformation: trailing spaces must be escaped (URI-encoded)
 	$href =~ s/(\s+)$/CGI::escape($1)/e;
 
+	if (defined($params{'anchor'})) {
+		$href .= "#".esc_param($params{'anchor'});
+	}
+
 	return $href;
 }
 
@@ -4334,8 +4339,10 @@ sub git_difftree_body {
 			if ($action eq 'commitdiff') {
 				# link to patch
 				$patchno++;
-				print "<td class=\"link\">" .
-				      $cgi->a({-href => "#patch$patchno"}, "patch") .
+				print $cgi->a({-href =>
+				      href(action=>"commitdiff",
+				      hash=>$hash, anchor=>"patch$patchno")},
+				      "patch") .
 				      " | " .
 				      "</td>\n";
 			}
@@ -4432,7 +4439,10 @@ sub git_difftree_body {
 			if ($action eq 'commitdiff') {
 				# link to patch
 				$patchno++;
-				print $cgi->a({-href => "#patch$patchno"}, "patch");
+				print $cgi->a({-href =>
+				      href(action=>"commitdiff",
+				      hash=>$hash, anchor=>"patch$patchno")},
+				      "patch");
 				print " | ";
 			}
 			print $cgi->a({-href => href(action=>"blob", hash=>$diff->{'to_id'},
@@ -4452,7 +4462,10 @@ sub git_difftree_body {
 			if ($action eq 'commitdiff') {
 				# link to patch
 				$patchno++;
-				print $cgi->a({-href => "#patch$patchno"}, "patch");
+				print $cgi->a({-href =>
+				      href(action=>"commitdiff",
+				      hash=>$hash, anchor=>"patch$patchno")},
+				      "patch");
 				print " | ";
 			}
 			print $cgi->a({-href => href(action=>"blob", hash=>$diff->{'from_id'},
@@ -4494,7 +4507,10 @@ sub git_difftree_body {
 			if ($action eq 'commitdiff') {
 				# link to patch
 				$patchno++;
-				print $cgi->a({-href => "#patch$patchno"}, "patch") .
+				print $cgi->a({-href =>
+				      href(action=>"commitdiff",
+				      hash=>$hash, anchor=>"patch$patchno")},
+				      "patch") .
 				      " | ";
 			} elsif ($diff->{'to_id'} ne $diff->{'from_id'}) {
 				# "commit" view and modified file (not onlu mode changed)
@@ -4539,7 +4555,10 @@ sub git_difftree_body {
 			if ($action eq 'commitdiff') {
 				# link to patch
 				$patchno++;
-				print $cgi->a({-href => "#patch$patchno"}, "patch") .
+				print $cgi->a({-href =>
+				      href(action=>"commitdiff",
+				      hash=>$hash, anchor=>"patch$patchno")},
+				      "patch") .
 				      " | ";
 			} elsif ($diff->{'to_id'} ne $diff->{'from_id'}) {
 				# "commit" view and modified file (not only pure rename or copy)
-- 
1.7.4.1
