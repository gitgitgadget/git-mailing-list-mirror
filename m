From: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
Subject: [PATCH 17/18] gitweb: Prepare for cached error pages & better error page handling
Date: Thu,  9 Dec 2010 13:57:23 -0800
Message-ID: <1291931844-28454-18-git-send-email-warthog9@eaglescrag.net>
References: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 09 22:56:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQoTg-0007Gf-Av
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 22:56:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757483Ab0LIV4H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 16:56:07 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:51870 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757480Ab0LIV4F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 16:56:05 -0500
Received: from voot-cruiser.middle.earth (c-71-202-185-40.hsd1.ca.comcast.net [71.202.185.40])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.3) with ESMTP id oB9LteQ3027765
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Thu, 9 Dec 2010 13:56:04 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Thu, 09 Dec 2010 13:56:05 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163346>

To quote myself from an e-mail of mine:

	I've got a hammer, it clearly solves all problems!

This is the prepatory work to set up a mechanism inside the
caching engine to cache the error pages instead of throwing
them straight out to the client.

This adds two functions:

die_error_cache() - this gets back called from die_error() so
that the error message generated can be cached.

cacheDisplayErr() - this is a simplified version of cacheDisplay()
that does an initial check, if the error page exists - display it
and exit.  If not, return.

Signed-off-by: John 'Warthog9' Hawley <warthog9@eaglescrag.net>
---
 gitweb/lib/cache.pl |   52 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 52 insertions(+), 0 deletions(-)

diff --git a/gitweb/lib/cache.pl b/gitweb/lib/cache.pl
index a8c902d..6cb82c8 100644
--- a/gitweb/lib/cache.pl
+++ b/gitweb/lib/cache.pl
@@ -302,6 +302,36 @@ sub cacheUpdate {
 	}
 }
 
+sub die_error_cache {
+	my ($output) = @_;
+
+	open(my $cacheFileErr, '>:utf8', "$fullhashpath.err");
+	my $lockStatus = flock($cacheFileErr,LOCK_EX|LOCK_NB);
+
+	if (! $lockStatus ){
+		if ( $areForked ){
+			exit(0);
+		}else{
+			return;
+		}
+	}
+
+	# Actually dump the output to the proper file handler
+	local $/ = undef;
+	$|++;
+	print $cacheFileErr "$output";
+	$|--;
+
+	flock($cacheFileErr,LOCK_UN);
+	close($cacheFileErr);
+
+	if ( $areForked ){
+		exit(0);
+	}else{
+		return;
+	}
+}
+
 
 sub cacheWaitForUpdate {
 	my ($action) = @_;
@@ -380,6 +410,28 @@ EOF
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
-- 
1.7.2.3
