From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 06/11] gitweb.js: Provide getElementsByClassName method (if it not exists)
Date: Sun, 10 Apr 2011 00:49:21 +0200
Message-ID: <1302389366-21515-7-git-send-email-jnareb@gmail.com>
References: <1302389366-21515-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Kevin Cernekee <cernekee@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 10 00:50:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8gz8-0005HA-AQ
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 00:50:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755950Ab1DIWuD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2011 18:50:03 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40519 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755796Ab1DIWt6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2011 18:49:58 -0400
Received: by mail-fx0-f46.google.com with SMTP id 17so2942648fxm.19
        for <git@vger.kernel.org>; Sat, 09 Apr 2011 15:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=8uSZlwQcQHOsV6tMdsEoytkDHsi8zJg7orhClqKhVx4=;
        b=HtQHE9allmCL5dzOVGCoNHsMaUEgexhtCEdw7M/MAXTSzfTWywYveFc2fyIAcCU/EW
         6e7HfhVfBsLlEANr6B2NW+bz1ooMVA6zgHWoZyfJEyesBnUqZx13/qc9NBjACxqnKcEZ
         rkdW5D8R/vqGnlC8DQmJCaCOpeG6ub8B56f3A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=L2+LSaBNtNWxw5EthJOQ4A4pwApc9QG65nJyLCVS7CIvtvnOVau8FllnvO8gP8X2YU
         ssYAYFiYLUBlJfZfWZtI5GL4Xkf1wYK89wK0rdOU0gDepvGyR8tTH0c1OlPoMzN4R8WZ
         SXL8VuZfGvwRPZAXxL05B6sH1D54ewA7f3Mo0=
Received: by 10.223.6.198 with SMTP id a6mr3729922faa.126.1302389396739;
        Sat, 09 Apr 2011 15:49:56 -0700 (PDT)
Received: from localhost.localdomain (abwd67.neoplus.adsl.tpnet.pl [83.8.227.67])
        by mx.google.com with ESMTPS id j12sm1188601fax.33.2011.04.09.15.49.55
        (version=SSLv3 cipher=OTHER);
        Sat, 09 Apr 2011 15:49:56 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1302389366-21515-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171222>

The code is simplified and does not support full specification of
native getElementsByClassName method, but implements just subset that
would be enough for gitweb, supporting only single class name.

Signed-off-by: John 'Warthog9' Hawley <warthog9@eaglescrag.net>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Instead of providing findElementsByClassName function like in
J.H. patch, which could use getElementsByClassName if present (but
didn't cache check for document.getElementsByClassName), this version
adds getElementsByClassName method to 'document' if it doesn't exist.

Which solution is better / easier to understand?  I'm not sure.

 gitweb/static/js/lib/common-lib.js |   51 ++++++++++++++++++++++++++++++++++++
 1 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/gitweb/static/js/lib/common-lib.js b/gitweb/static/js/lib/common-lib.js
index d6b0c0d..b371391 100644
--- a/gitweb/static/js/lib/common-lib.js
+++ b/gitweb/static/js/lib/common-lib.js
@@ -89,6 +89,57 @@ function createRequestObject() {
 
 
 /* ............................................................ */
+/* Support for legacy browsers */
+
+/**
+ * Provides getElementsByClassName method, if there is no native
+ * implementation of this method.
+ *
+ * NOTE that there are limits and differences compared to native
+ * getElementsByClassName as defined by e.g.:
+ *   https://developer.mozilla.org/en/DOM/document.getElementsByClassName
+ *   http://www.whatwg.org/specs/web-apps/current-work/multipage/dom.html#dom-getelementsbyclassname
+ *   http://www.whatwg.org/specs/web-apps/current-work/multipage/dom.html#dom-document-getelementsbyclassname
+ *
+ * Namely, this implementation supports only single class name as
+ * argument and not set of space-separated tokens representing classes,
+ * it returns Array of nodes rather than live NodeList, and has
+ * additional optional argument where you can limit search to given tags
+ * (via getElementsByTagName).
+ *
+ * Based on
+ *   http://code.google.com/p/getelementsbyclassname/
+ *   http://www.dustindiaz.com/getelementsbyclass/
+ *   http://stackoverflow.com/questions/1818865/do-we-have-getelementsbyclassname-in-javascript
+ *
+ * See also http://ejohn.org/blog/getelementsbyclassname-speed-comparison/
+ *
+ * @param {String} class: name of _single_ class to find
+ * @param {String} [taghint] limit search to given tags
+ * @returns {Node[]} array of matching elements
+ */
+if (!('getElementsByClassName' in document)) {
+	document.getElementsByClassName = function (classname, taghint) {
+		taghint = taghint || "*";
+		var elements = (taghint === "*" && document.all) ?
+		               document.all :
+		               document.getElementsByTagName(taghint);
+		var pattern = new RegExp("(^|\\s)" + classname + "(\\s|$)");
+		var matches= [];
+		for (var i = 0, j = 0, n = elements.length; i < n; i++) {
+			var el= elements[i];
+			if (el.className && pattern.test(el.className)) {
+				// matches.push(el);
+				matches[j] = el;
+				j++;
+			}
+		}
+		return matches;
+	};
+} // end if
+
+
+/* ............................................................ */
 /* unquoting/unescaping filenames */
 
 /**#@+
-- 
1.7.3
