From: Peter Stuge <peter@stuge.se>
Subject: [PATCH] gitweb: Fix links to lines in blobs when javascript-actions are enabled
Date: Tue, 27 Sep 2011 11:51:00 +0200
Message-ID: <1317117060-3955-1-git-send-email-peter@stuge.se>
References: <20110927094947.10955.qmail@stuge.se>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 27 11:51:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8UJg-000213-GB
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 11:51:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752219Ab1I0JvD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Sep 2011 05:51:03 -0400
Received: from foo.stuge.se ([212.116.89.98]:40855 "HELO foo.stuge.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751631Ab1I0JvC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2011 05:51:02 -0400
Received: (qmail 11162 invoked from network); 27 Sep 2011 09:51:00 -0000
Received: from localhost (HELO stuge.se) (127.0.0.1)
  by localhost with SMTP; 27 Sep 2011 09:51:00 -0000
X-Mailer: git-send-email 1.7.4.1.343.ga91df.dirty
In-Reply-To: <20110927094947.10955.qmail@stuge.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182230>

Some javascript code will run in the browser onLoad and signals back to
gitweb that the browser can actually do javascript.

The code adds [?;]js=1 into the URL of all links on the page. The code
always added [?;]js=1 to the end of links, which is wrong when links
contain a URI fragment, such as links directly to a line in a blob:
..?p=repo.git;a=blob;f=file#l123

In this case, [?;]js=1 must be added before the hashmark.

Signed-off-by: Peter Stuge <peter@stuge.se>
---
 gitweb/static/js/javascript-detection.js |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/gitweb/static/js/javascript-detection.js b/gitweb/static/js/javascript-detection.js
index 93dd2bd..fa2596f 100644
--- a/gitweb/static/js/javascript-detection.js
+++ b/gitweb/static/js/javascript-detection.js
@@ -16,7 +16,7 @@
  * and other reasons to not add 'js=1' param at the end of link
  * @constant
  */
-var jsExceptionsRe = /[;?]js=[01]$/;
+var jsExceptionsRe = /[;?]js=[01](#.*)?$/;
 
 /**
  * Add '?js=1' or ';js=1' to the end of every link in the document
@@ -33,9 +33,9 @@ function fixLinks() {
 	var allLinks = document.getElementsByTagName("a") || document.links;
 	for (var i = 0, len = allLinks.length; i < len; i++) {
 		var link = allLinks[i];
-		if (!jsExceptionsRe.test(link)) { // =~ /[;?]js=[01]$/;
-			link.href +=
-				(link.href.indexOf('?') === -1 ? '?' : ';') + 'js=1';
+		if (!jsExceptionsRe.test(link)) {
+			link.href = link.href.replace(/(#|$)/,
+				(link.href.indexOf('?') === -1 ? '?' : ';') + 'js=1$1');
 		}
 	}
 }
-- 
1.7.4.1.343.ga91df.dirty
