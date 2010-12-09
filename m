From: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
Subject: [PATCH 07/18] gitweb: Revert back to $cache_enable vs. $caching_enabled
Date: Thu,  9 Dec 2010 13:57:13 -0800
Message-ID: <1291931844-28454-8-git-send-email-warthog9@eaglescrag.net>
References: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 09 22:56:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQoT0-0006x0-FP
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 22:55:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757453Ab0LIVzy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 16:55:54 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:51851 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757439Ab0LIVzx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 16:55:53 -0500
Received: from voot-cruiser.middle.earth (c-71-202-185-40.hsd1.ca.comcast.net [71.202.185.40])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.3) with ESMTP id oB9LtePr027765
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Thu, 9 Dec 2010 13:55:51 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Thu, 09 Dec 2010 13:55:51 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163336>

Simple enough, $cache_enable (along with all caching variables) are
already in production in multiple places and doing a small semantic
change without backwards compatibility is pointless breakage.

This reverts back to the previous variable to enable / disable caching

Signed-off-by: John 'Warthog9' Hawley <warthog9@eaglescrag.net>
---
 gitweb/gitweb.perl |   12 ++++++------
 t/gitweb-lib.sh    |    2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 05e7ba6..5eb0309 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -258,7 +258,7 @@ our $maxload = 300;
 # that the cache directory be periodically completely deleted, and this is safe to perform.
 # Suggested mechanism
 # mv $cacheidr $cachedir.flush;mkdir $cachedir;rm -rf $cachedir.flush
-our $caching_enabled = 0;
+our $cache_enable = 0;
 
 # Used to set the minimum cache timeout for the dynamic caching algorithm.  Basically
 # if we calculate the cache to be under this number of seconds we set the cache timeout
@@ -1138,7 +1138,7 @@ sub dispatch {
 	    !$project) {
 		die_error(400, "Project needed");
 	}
-	if ($caching_enabled && is_cacheable($action)) {
+	if ($cache_enable && is_cacheable($action)) {
 		cache_fetch($action);
 	} else {
 		$actions{$action}->();
@@ -3516,7 +3516,7 @@ sub git_header_html {
 	if (defined $cgi->http('HTTP_ACCEPT') &&
 	    $cgi->http('HTTP_ACCEPT') =~ m/(,|;|\s|^)application\/xhtml\+xml(,|;|\s|$)/ &&
 	    $cgi->Accept('application/xhtml+xml') != 0 &&
-	    !$caching_enabled) {
+	    !$cache_enable) {
 		$content_type = 'application/xhtml+xml';
 	} else {
 		$content_type = 'text/html';
@@ -3757,7 +3757,7 @@ sub die_error {
 	#
 	# Reset the output so that we are actually going to STDOUT as opposed
 	# to buffering the output.
-	reset_output() if ($caching_enabled);
+	reset_output() if ($cache_enable && ! $cacheErrorCache);
 
 	git_header_html($http_responses{$status}, undef, %opts);
 	print <<EOF;
@@ -5667,7 +5667,7 @@ sub git_blob_plain {
 			($sandbox ? 'attachment' : 'inline')
 			. '; filename="' . $save_as . '"');
 	local $/ = undef;
-	if ($caching_enabled) {
+	if ($cache_enable) {
 		open BINOUT, '>', $fullhashbinpath or die_error(500, "Could not open bin dump file");
 	}else{
 		open BINOUT, '>&', \$fullhashbinpath or die_error(500, "Could not open bin dump file");
@@ -5960,7 +5960,7 @@ sub git_snapshot {
 
 	open my $fd, "-|", $cmd
 		or die_error(500, "Execute git-archive failed");
-	if ($caching_enabled) {
+	if ($cache_enable) {
 		open BINOUT, '>', $fullhashbinpath or die_error(500, "Could not open bin dump file");
 	}else{
 		open BINOUT, '>&', \$fullhashbinpath or die_error(500, "Could not open bin dump file");
diff --git a/t/gitweb-lib.sh b/t/gitweb-lib.sh
index 10c4a3d..a0f7696 100755
--- a/t/gitweb-lib.sh
+++ b/t/gitweb-lib.sh
@@ -56,7 +56,7 @@ EOF
 gitweb_enable_caching () {
 	test_expect_success 'enable caching' '
 		cat >>gitweb_config.perl <<-\EOF &&
-		our $caching_enabled = 1;
+		our $cache_enable = 1;
 		our $minCacheTime = 60*60*24*7*30;     # very long expiration time for tests (a month)
 		our $maxCacheTime = 60*60*24*7*30*365; # upper bound for dynamic (adaptive) caching
 		our $cachedir = "cache";               # for testsuite to clear the right thing
-- 
1.7.2.3
