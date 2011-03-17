From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH v2 1/3] gitweb: fix #patchNN anchors when path_info is enabled
Date: Thu, 17 Mar 2011 12:38:29 -0700
Message-ID: <c8621826e0576e3e31240b0205e7e3d0@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 20:47:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0JAV-0004Bj-Ix
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 20:47:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754971Ab1CQTrO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2011 15:47:14 -0400
Received: from [69.28.251.93] ([69.28.251.93]:42634 "EHLO b32.net"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752955Ab1CQTrN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2011 15:47:13 -0400
Received: (qmail 12241 invoked from network); 17 Mar 2011 19:47:11 -0000
Received: from localhost (HELO vps-1001064-677.cp.jvds.com) (127.0.0.1)
  by localhost with (DHE-RSA-AES128-SHA encrypted) SMTP; 17 Mar 2011 19:47:11 -0000
Received: by vps-1001064-677.cp.jvds.com (sSMTP sendmail emulation); Thu, 17 Mar 2011 12:47:11 -0700
User-Agent: vim 7.2
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169264>

When $feature{'pathinfo'} is used, gitweb sets the base URL to something
like:

<base href="http://HOST/gitweb.cgi">

This breaks the "patch" anchor links seen on the commitdiff pages,
because they are computed relative to the base URL:

http://HOST/gitweb.cgi#patch1

Instead, they should look like:

http://HOST/gitweb.cgi/myproject.git/commitdiff/35a9811ef9d68eae9afd76bede121da4f89b448c#patch1

Add an "-anchor" parameter to href(), so that the full path is included
in the patch link.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 gitweb/gitweb.perl |   25 +++++++++++++++++++------
 1 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 0779f12..57a3caf 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1199,11 +1199,13 @@ if (defined caller) {
 # -full => 0|1      - use absolute/full URL ($my_uri/$my_url as base)
 # -replay => 1      - start from a current view (replay with modifications)
 # -path_info => 0|1 - don't use/use path_info URL (if possible)
+# -anchor ANCHOR    - add #ANCHOR to end of URL, implies -replay if used alone
 sub href {
 	my %params = @_;
 	# default is to use -absolute url() i.e. $my_uri
 	my $href = $params{-full} ? $my_url : $my_uri;
 
+	$params{-replay} = 1 if ($params{-anchor} && keys %params == 1);
 	$params{'project'} = $project unless exists $params{'project'};
 
 	if ($params{-replay}) {
@@ -1314,6 +1316,10 @@ sub href {
 	# final transformation: trailing spaces must be escaped (URI-encoded)
 	$href =~ s/(\s+)$/CGI::escape($1)/e;
 
+	if ($params{-anchor}) {
+		$href .= "#".esc_param($params{-anchor});
+	}
+
 	return $href;
 }
 
@@ -4334,8 +4340,9 @@ sub git_difftree_body {
 			if ($action eq 'commitdiff') {
 				# link to patch
 				$patchno++;
-				print "<td class=\"link\">" .
-				      $cgi->a({-href => "#patch$patchno"}, "patch") .
+				print $cgi->a({-href =>
+				      href(-anchor=>"patch$patchno")},
+				      "patch") .
 				      " | " .
 				      "</td>\n";
 			}
@@ -4432,7 +4439,8 @@ sub git_difftree_body {
 			if ($action eq 'commitdiff') {
 				# link to patch
 				$patchno++;
-				print $cgi->a({-href => "#patch$patchno"}, "patch");
+				print $cgi->a({-href =>
+				      href(-anchor=>"patch$patchno")}, "patch");
 				print " | ";
 			}
 			print $cgi->a({-href => href(action=>"blob", hash=>$diff->{'to_id'},
@@ -4452,7 +4460,8 @@ sub git_difftree_body {
 			if ($action eq 'commitdiff') {
 				# link to patch
 				$patchno++;
-				print $cgi->a({-href => "#patch$patchno"}, "patch");
+				print $cgi->a({-href =>
+				      href(-anchor=>"patch$patchno")}, "patch");
 				print " | ";
 			}
 			print $cgi->a({-href => href(action=>"blob", hash=>$diff->{'from_id'},
@@ -4494,7 +4503,9 @@ sub git_difftree_body {
 			if ($action eq 'commitdiff') {
 				# link to patch
 				$patchno++;
-				print $cgi->a({-href => "#patch$patchno"}, "patch") .
+				print $cgi->a({-href =>
+				      href(-anchor=>"patch$patchno")},
+				      "patch") .
 				      " | ";
 			} elsif ($diff->{'to_id'} ne $diff->{'from_id'}) {
 				# "commit" view and modified file (not onlu mode changed)
@@ -4539,7 +4550,9 @@ sub git_difftree_body {
 			if ($action eq 'commitdiff') {
 				# link to patch
 				$patchno++;
-				print $cgi->a({-href => "#patch$patchno"}, "patch") .
+				print $cgi->a({-href =>
+				      href(-anchor=>"patch$patchno")},
+				      "patch") .
 				      " | ";
 			} elsif ($diff->{'to_id'} ne $diff->{'from_id'}) {
 				# "commit" view and modified file (not only pure rename or copy)
-- 
1.7.4.1
