From: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
Subject: [PATCH 18/18] gitweb: Add better error handling for gitweb caching
Date: Thu,  9 Dec 2010 13:57:24 -0800
Message-ID: <1291931844-28454-19-git-send-email-warthog9@eaglescrag.net>
References: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 09 22:56:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQoTg-0007Gf-SP
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 22:56:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757485Ab0LIV4M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 16:56:12 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:51871 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757462Ab0LIV4G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 16:56:06 -0500
Received: from voot-cruiser.middle.earth (c-71-202-185-40.hsd1.ca.comcast.net [71.202.185.40])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.3) with ESMTP id oB9LteQ4027765
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Thu, 9 Dec 2010 13:56:05 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Thu, 09 Dec 2010 13:56:05 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163345>

This basically finishes the plumbing for caching the error pages
as the are generated.

If an error is hit, create a <hash>.err file with the error.  This
will interrupt all currently waiting processes and they will display
the error, without any additional refreshing.

On a new request a generation will be attempted, should it succed the
<hash.err> file is removed (if it exists).

Signed-off-by: John 'Warthog9' Hawley <warthog9@eaglescrag.net>
---
 gitweb/gitweb.perl  |    8 ++++++++
 gitweb/lib/cache.pl |   14 ++++++++++++++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index d39982a..5a9660a 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -41,6 +41,7 @@ our $version = "++GIT_VERSION++";
 
 # Output buffer variable
 our $output = "";
+our $output_err = "";
 
 our ($my_url, $my_uri, $base_url, $path_info, $home_link);
 sub evaluate_uri {
@@ -303,6 +304,9 @@ our $fullhashpath = *STDOUT;
 our $fullhashbinpath = *STDOUT;
 our $fullhashbinpathfinal = *STDOUT;
 
+our $cacheErrorCache = 0; # false
+our $cacheErrorCount = 0;
+
 our $full_url;
 our $urlhash;
 
@@ -3786,6 +3790,7 @@ sub die_error {
 	# Reset the output so that we are actually going to STDOUT as opposed
 	# to buffering the output.
 	reset_output() if ($cache_enable && ! $cacheErrorCache);
+	$cacheErrorCount++ if( $cacheErrorCache );
 
 	git_header_html($http_responses{$status}, undef, %opts);
 	print <<EOF;
@@ -3801,6 +3806,9 @@ EOF
 	print "</div>\n";
 
 	git_footer_html();
+
+	die_error_cache($output) if ( $cacheErrorCache );
+
 	goto DONE_GITWEB
 		unless ($opts{'-error_handler'});
 }
diff --git a/gitweb/lib/cache.pl b/gitweb/lib/cache.pl
index 6cb82c8..2e7ca69 100644
--- a/gitweb/lib/cache.pl
+++ b/gitweb/lib/cache.pl
@@ -240,8 +240,14 @@ sub cacheUpdate {
 	# Trap all output from the action
 	change_output();
 
+	# Set the error handler so we cache
+	$cacheErrorCache = 1; # true
+
 	$actions{$action}->();
 
+	# Reset Error Handler to not cache
+	$cacheErrorCache = 0; # false
+
 	# Reset the outputs as we should be fine now
 	reset_output();
 
@@ -295,6 +301,8 @@ sub cacheUpdate {
 		close($cacheFileBG);
 	}
 
+	unlink("$fullhashpath.err") if (-e "$fullhashpath.err");
+
 	if ( $areForked ){
 		exit(0);
 	} else {
@@ -339,6 +347,9 @@ sub cacheWaitForUpdate {
 	my $max = 10;
 	my $lockStat = 0;
 
+	# Call cacheDisplayErr - if an error exists it will display and die.  If not it will just return
+	cacheDisplayErr($action);
+
 	if( $backgroundCache ){
 		if( -e "$fullhashpath" ){
 			open($cacheFile, '<:utf8', "$fullhashpath");
@@ -402,6 +413,9 @@ EOF
 		close($cacheFile);
 		$x++;
 		$combinedLockStat = $lockStat;
+
+		# Call cacheDisplayErr - if an error exists it will display and die.  If not it will just return
+		cacheDisplayErr($action);
 	} while ((! $combinedLockStat) && ($x < $max));
 	print <<EOF;
 </body>
-- 
1.7.2.3
