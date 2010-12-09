From: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
Subject: [PATCH 12/18] gitweb: Change file handles (in caching) to lexical variables as opposed to globs
Date: Thu,  9 Dec 2010 13:57:18 -0800
Message-ID: <1291931844-28454-13-git-send-email-warthog9@eaglescrag.net>
References: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 09 22:56:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQoTf-0007Gf-8V
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 22:56:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757472Ab0LIV4E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 16:56:04 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:51862 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757196Ab0LIV4C (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 16:56:02 -0500
Received: from voot-cruiser.middle.earth (c-71-202-185-40.hsd1.ca.comcast.net [71.202.185.40])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.3) with ESMTP id oB9LtePw027765
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Thu, 9 Dec 2010 13:55:57 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Thu, 09 Dec 2010 13:55:59 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163341>

This isn't a huge change, it just adds global variables for the file handles,
an additional cleanup to localize the variable a bit more which should alleviate
the issues that Jakub had with my original approach.

Signed-off-by: John 'Warthog9' Hawley <warthog9@eaglescrag.net>
---
 gitweb/lib/cache.pl |  114 +++++++++++++++++++++++++++++++-------------------
 1 files changed, 71 insertions(+), 43 deletions(-)

diff --git a/gitweb/lib/cache.pl b/gitweb/lib/cache.pl
index 5182a94..fafc028 100644
--- a/gitweb/lib/cache.pl
+++ b/gitweb/lib/cache.pl
@@ -14,6 +14,12 @@ use Digest::MD5 qw(md5 md5_hex md5_base64);
 use Fcntl ':flock';
 use File::Copy;
 
+# Global declarations
+our $cacheFile;
+our $cacheFileBG;
+our $cacheFileBinWT;
+our $cacheFileBin;
+
 sub cache_fetch {
 	my ($action) = @_;
 	my $cacheTime = 0;
@@ -49,9 +55,9 @@ sub cache_fetch {
 	}else{
 		#if cache is out dated, update
 		#else displayCache();
-		open(cacheFile, '<', "$fullhashpath");
-		stat(cacheFile);
-		close(cacheFile);
+		open($cacheFile, '<', "$fullhashpath");
+		stat($cacheFile);
+		close($cacheFile);
 		my $stat_time = (stat(_))[9];
 		my $stat_size = (stat(_))[7];
 
@@ -150,13 +156,13 @@ sub cacheUpdate {
 	my $fileData = "";
 
 	if($backgroundCache){
-		open(cacheFileBG, '>:utf8', "$fullhashpath.bg");
-		my $lockStatBG = flock(cacheFileBG,LOCK_EX|LOCK_NB);
+		open($cacheFileBG, '>:utf8', "$fullhashpath.bg");
+		my $lockStatBG = flock($cacheFileBG,LOCK_EX|LOCK_NB);
 
 		$lockStatus = $lockStatBG;
 	}else{
-		open(cacheFile, '>:utf8', \$fullhashpath);
-		my $lockStat = flock(cacheFile,LOCK_EX|LOCK_NB);
+		open($cacheFile, '>:utf8', \$fullhashpath);
+		my $lockStat = flock($cacheFile,LOCK_EX|LOCK_NB);
 
 		$lockStatus = $lockStat;
 	}
@@ -172,8 +178,8 @@ sub cacheUpdate {
 	}
 
 	if( isBinaryAction($action) ){
-		my $openstat = open(cacheFileBinWT, '>>:utf8', "$fullhashbinpath");
-		my $lockStatBin = flock(cacheFileBinWT,LOCK_EX|LOCK_NB);
+		my $openstat = open($cacheFileBinWT, '>>:utf8', "$fullhashbinpath");
+		my $lockStatBin = flock($cacheFileBinWT,LOCK_EX|LOCK_NB);
 	}
 
 	# Trap all output from the action
@@ -186,8 +192,8 @@ sub cacheUpdate {
 
 
 	if($backgroundCache){
-		open(cacheFile, '>:utf8', "$fullhashpath");
-		$lockStat = flock(cacheFile,LOCK_EX);
+		open($cacheFile, '>:utf8', "$fullhashpath");
+		$lockStat = flock($cacheFile,LOCK_EX);
 
 		if (! $lockStat ){
 			if ( $areForked ){
@@ -199,8 +205,8 @@ sub cacheUpdate {
 	}
 
 	if( isBinaryAction($action) ){
-		my $openstat = open(cacheFileBinFINAL, '>:utf8', "$fullhashbinpathfinal");
-		$lockStatBIN = flock(cacheFileBinFINAL,LOCK_EX);
+		my $openstat = open($cacheFileBinFINAL, '>:utf8', "$fullhashbinpathfinal");
+		$lockStatBIN = flock($cacheFileBinFINAL,LOCK_EX);
 
 		if (! $lockStatBIN ){
 			if ( $areForked ){
@@ -214,24 +220,24 @@ sub cacheUpdate {
 	# Actually dump the output to the proper file handler
 	local $/ = undef;
 	$|++;
-	print cacheFile "$output";
+	print $cacheFile "$output";
 	$|--;
 	if( isBinaryAction($action) ){
 		move("$fullhashbinpath", "$fullhashbinpathfinal") or die "Binary Cache file could not be updated: $!";
 
-		flock(cacheFileBinFINAL,LOCK_UN);
-		close(cacheFileBinFINAL);
+		flock($cacheFileBinFINAL,LOCK_UN);
+		close($cacheFileBinFINAL);
 
-		flock(cacheFileBinWT,LOCK_UN);
-		close(cacheFileBinWT);
+		flock($cacheFileBinWT,LOCK_UN);
+		close($cacheFileBinWT);
 	}
 
-	flock(cacheFile,LOCK_UN);
-	close(cacheFile);
+	flock($cacheFile,LOCK_UN);
+	close($cacheFile);
 
 	if($backgroundCache){
-		flock(cacheFileBG,LOCK_UN);
-		close(cacheFileBG);
+		flock($cacheFileBG,LOCK_UN);
+		close($cacheFileBG);
 	}
 
 	if ( $areForked ){
@@ -250,10 +256,10 @@ sub cacheWaitForUpdate {
 
 	if( $backgroundCache ){
 		if( -e "$fullhashpath" ){
-			open(cacheFile, '<:utf8', "$fullhashpath");
-			$lockStat = flock(cacheFile,LOCK_SH|LOCK_NB);
-			stat(cacheFile);
-			close(cacheFile);
+			open($cacheFile, '<:utf8', "$fullhashpath");
+			$lockStat = flock($cacheFile,LOCK_SH|LOCK_NB);
+			stat($cacheFile);
+			close($cacheFile);
 
 			if( $lockStat && ( (stat(_))[9] > (time - $maxCacheLife) ) ){
 				cacheDisplay($action);
@@ -271,9 +277,9 @@ sub cacheWaitForUpdate {
 	  ){
 		do {
 			sleep 2 if $x > 0;
-			open(cacheFile, '<:utf8', "$fullhashpath");
-			$lockStat = flock(cacheFile,LOCK_SH|LOCK_NB);
-			close(cacheFile);
+			open($cacheFile, '<:utf8', "$fullhashpath");
+			$lockStat = flock($cacheFile,LOCK_SH|LOCK_NB);
+			close($cacheFile);
 			$x++;
 			$combinedLockStat = $lockStat;
 		} while ((! $combinedLockStat) && ($x < $max));
@@ -326,9 +332,9 @@ EOF
 	do {
 		print ".";
 		sleep 2 if $x > 0;
-		open(cacheFile, '<:utf8', "$fullhashpath");
-		$lockStat = flock(cacheFile,LOCK_SH|LOCK_NB);
-		close(cacheFile);
+		open($cacheFile, '<:utf8', "$fullhashpath");
+		$lockStat = flock($cacheFile,LOCK_SH|LOCK_NB);
+		close($cacheFile);
 		$x++;
 		$combinedLockStat = $lockStat;
 	} while ((! $combinedLockStat) && ($x < $max));
@@ -339,41 +345,63 @@ EOF
 	return;
 }
 
+sub cacheDisplayErr {
+
+	return if ( ! -e "$fullhashpath.err" );
+
+	open($cacheFileErr, '<:utf8', "$fullhashpath.err");
+	$lockStatus = flock($cacheFileErr,LOCK_SH|LOCK_NB);
+
+	if (! $lockStatus ){
+		show_warning(
+				"<p>".
+				"<strong>*** Warning ***:</strong> Locking error when trying to lock error cache page, file $fullhashpath.err<br/>/\n".
+				"This is about as screwed up as it gets folks - see your systems administrator for more help with this.".
+				"<p>"
+				);
+	}
+
+	while( <$cacheFileErr> ){
+		print $_;
+	}
+	exit(0);
+}
+
 sub cacheDisplay {
 	local $/ = undef;
 	$|++;
 
 	my ($action) = @_;
-	open(cacheFile, '<:utf8', "$fullhashpath");
-	$lockStat = flock(cacheFile,LOCK_SH|LOCK_NB);
+	open($cacheFile, '<:utf8', "$fullhashpath");
+	$lockStat = flock($cacheFile,LOCK_SH|LOCK_NB);
 
 	if (! $lockStat ){
-		close(cacheFile);
+		close($cacheFile);
 		cacheWaitForUpdate($action);
 	}
 
 	if( isBinaryAction($action) ){
-		my $openstat = open(cacheFileBin, '<', "$fullhashbinpathfinal");
-		$lockStatBIN = flock(cacheFileBin,LOCK_SH|LOCK_NB);
+		my $openstat = open($cacheFileBin, '<', "$fullhashbinpathfinal");
+		$lockStatBIN = flock($cacheFileBin,LOCK_SH|LOCK_NB);
 		if (! $lockStatBIN ){
-			close(cacheFile);
-			close(cacheFileBin);
+			close($cacheFile);
+			close($cacheFileBin);
 			cacheWaitForUpdate($action);
 		}
 
 		my $binfilesize = -s "$fullhashbinpathfinal";
 		print "Content-Length: $binfilesize";
 	}
-	while( <cacheFile> ){
+	while( <$cacheFile> ){
 		print $_;
 	}
 	if( isBinaryAction($action) ){
 		binmode STDOUT, ':raw';
-		print <cacheFileBin>;
+		print <$cacheFileBin>;
 		binmode STDOUT, ':utf8'; # as set at the beginning of gitweb.cgi
-		close(cacheFileBin);
+		close($cacheFileBin);
 	}
-	close(cacheFile);
+	close($cacheFile);
 	$|--;
 }
 
-- 
1.7.2.3
