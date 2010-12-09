From: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
Subject: [PATCH 10/18] gitweb: Adding isBinaryAction() and isFeedAction() to determine the action type
Date: Thu,  9 Dec 2010 13:57:16 -0800
Message-ID: <1291931844-28454-11-git-send-email-warthog9@eaglescrag.net>
References: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 09 22:56:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQoTe-0007Gf-ML
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 22:56:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757461Ab0LIVz7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 16:55:59 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:51858 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757196Ab0LIVz4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 16:55:56 -0500
Received: from voot-cruiser.middle.earth (c-71-202-185-40.hsd1.ca.comcast.net [71.202.185.40])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.3) with ESMTP id oB9LtePu027765
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Thu, 9 Dec 2010 13:55:54 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Thu, 09 Dec 2010 13:55:55 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163343>

This is fairly self explanitory, these are here just to centralize the checking
for these types of actions, as special things need to be done with regards to
them inside the caching engine.

isBinaryAction() returns true if the action deals with creating binary files
(this needing :raw output)

isFeedAction() returns true if the action deals with a news feed of some sort,
basically used to bypass the 'Generating...' message should it be a news reader
as those will explode badly on that page.

Signed-off-by: John 'Warthog9' Hawley <warthog9@eaglescrag.net>
---
 gitweb/lib/cache.pl |   69 ++++++++++++++++++++++++++-------------------------
 1 files changed, 35 insertions(+), 34 deletions(-)

diff --git a/gitweb/lib/cache.pl b/gitweb/lib/cache.pl
index a8ee99e..d55b572 100644
--- a/gitweb/lib/cache.pl
+++ b/gitweb/lib/cache.pl
@@ -88,6 +88,34 @@ sub cache_fetch {
 	#$actions{$action}->();
 }
 
+sub isBinaryAction {
+	my ($action) = @_;
+
+	if(
+		$action eq "snapshot"
+		||
+		$action eq "blob_plain"
+	){
+		return 1;	# True
+	}
+
+	return 0;		# False
+}
+
+sub isFeedAction {
+	if(
+		$action eq "atom"
+		||
+		$action eq "rss"
+		||
+		$action eq "opml"
+	){
+		return 1;	# True
+	}
+
+	return 0;		# False
+}
+
 sub cacheUpdate {
 	my ($action,$areForked) = @_;
 	my $lockingStatus;
@@ -115,11 +143,7 @@ sub cacheUpdate {
 		}
 	}
 
-	if(
-		$action eq "snapshot"
-		||
-		$action eq "blob_plain"
-	){
+	if( isBinaryAction($action) ){
 		my $openstat = open(cacheFileBinWT, '>>:utf8', "$fullhashbinpath");
 		my $lockStatBin = flock(cacheFileBinWT,LOCK_EX|LOCK_NB);
 	}
@@ -146,11 +170,7 @@ sub cacheUpdate {
 		}
 	}
 
-	if(
-		$action eq "snapshot"
-		||
-		$action eq "blob_plain"
-	){
+	if( isBinaryAction($action) ){
 		my $openstat = open(cacheFileBinFINAL, '>:utf8', "$fullhashbinpathfinal");
 		$lockStatBIN = flock(cacheFileBinFINAL,LOCK_EX);
 
@@ -168,11 +188,7 @@ sub cacheUpdate {
 	$|++;
 	print cacheFile "$output";
 	$|--;
-	if(
-		$action eq "snapshot"
-		||
-		$action eq "blob_plain"
-	){
+	if( isBinaryAction($action) ){
 		move("$fullhashbinpath", "$fullhashbinpathfinal") or die "Binary Cache file could not be updated: $!";
 
 		flock(cacheFileBinFINAL,LOCK_UN);
@@ -219,14 +235,10 @@ sub cacheWaitForUpdate {
 	}
 
 	if(
-		$action eq "atom"
-		||
-		$action eq "rss"
-		||
-		$action eq "opml"
+		isFeedAction($action)
 		||
 		! $cacheGenStatus
-	){
+	  ){
 		do {
 			sleep 2 if $x > 0;
 			open(cacheFile, '<:utf8', "$fullhashpath");
@@ -310,17 +322,10 @@ sub cacheDisplay {
 		cacheWaitForUpdate($action);
 	}
 
-	if(
-		(
-			$action eq "snapshot"
-			||
-			$action eq "blob_plain"
-		)
-	){
+	if( isBinaryAction($action) ){
 		my $openstat = open(cacheFileBin, '<', "$fullhashbinpathfinal");
 		$lockStatBIN = flock(cacheFileBin,LOCK_SH|LOCK_NB);
 		if (! $lockStatBIN ){
-			system ("echo 'cacheDisplay - bailing due to binary lock failure' >> /tmp/gitweb.log");
 			close(cacheFile);
 			close(cacheFileBin);
 			cacheWaitForUpdate($action);
@@ -332,11 +337,7 @@ sub cacheDisplay {
 	while( <cacheFile> ){
 		print $_;
 	}
-	if(
-		$action eq "snapshot"
-		||
-		$action eq "blob_plain"
-	){
+	if( isBinaryAction($action) ){
 		binmode STDOUT, ':raw';
 		print <cacheFileBin>;
 		binmode STDOUT, ':utf8'; # as set at the beginning of gitweb.cgi
-- 
1.7.2.3
