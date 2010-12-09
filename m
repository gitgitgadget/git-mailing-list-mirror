From: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
Subject: [PATCH 11/18] gitweb: add isDumbClient() check
Date: Thu,  9 Dec 2010 13:57:17 -0800
Message-ID: <1291931844-28454-12-git-send-email-warthog9@eaglescrag.net>
References: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 09 22:56:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQoTf-0007Gf-P4
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 22:56:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757479Ab0LIV4F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 16:56:05 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:51861 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757462Ab0LIVz6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 16:55:58 -0500
Received: from voot-cruiser.middle.earth (c-71-202-185-40.hsd1.ca.comcast.net [71.202.185.40])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.3) with ESMTP id oB9LtePv027765
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Thu, 9 Dec 2010 13:55:55 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Thu, 09 Dec 2010 13:55:56 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163344>

Basic check for the claimed Agent string, if it matches a known
blacklist (wget and curl currently) don't display the 'Generating...'
page.

Jakub has mentioned a couple of other possible ways to handle
this, so if a better way comes along this should be used as a
wrapper to any better way we can find to deal with this.

Signed-off-by: John 'Warthog9' Hawley <warthog9@eaglescrag.net>
---
 gitweb/lib/cache.pl |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/gitweb/lib/cache.pl b/gitweb/lib/cache.pl
index d55b572..5182a94 100644
--- a/gitweb/lib/cache.pl
+++ b/gitweb/lib/cache.pl
@@ -116,6 +116,34 @@ sub isFeedAction {
 	return 0;		# False
 }
 
+# There have been a number of requests that things like "dumb" clients, I.E. wget
+# lynx, links, etc (things that just download, but don't parse the html) actually
+# work without getting the wonkiness that is the "Generating..." page.
+#
+# There's only one good way to deal with this, and that's to read the browser User
+# Agent string and do matching based on that.  This has a whole slew of error cases
+# and mess, but there's no other way to determine if the "Generating..." page
+# will break things.
+#
+# This assumes the client is not dumb, thus the default behavior is to return
+# "false" (0) (and eventually the "Generating..." page).  If it is a dumb client
+# return "true" (1)
+sub isDumbClient {
+	my($user_agent) = $ENV{'HTTP_USER_AGENT'};
+	
+	if(
+		# wget case
+		$user_agent =~ /^Wget/i
+		||
+		# curl should be excluded I think, probably better safe than sorry
+		$user_agent =~ /^curl/i
+	  ){
+		return 1;	# True
+	}
+
+	return 0;
+}
+
 sub cacheUpdate {
 	my ($action,$areForked) = @_;
 	my $lockingStatus;
@@ -237,6 +265,8 @@ sub cacheWaitForUpdate {
 	if(
 		isFeedAction($action)
 		||
+		isDumbClient()
+		||
 		! $cacheGenStatus
 	  ){
 		do {
-- 
1.7.2.3
