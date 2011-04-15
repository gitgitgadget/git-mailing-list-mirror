From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 06/11] gitweb.js: Provide getElementsByClassName method (if it not exists)
Date: Fri, 15 Apr 2011 16:44:00 +0200
Message-ID: <1302878645-458-7-git-send-email-jnareb@gmail.com>
References: <1302878645-458-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Kevin Cernekee <cernekee@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 16:45:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAkGz-0002aV-T4
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 16:45:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756204Ab1DOOpQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2011 10:45:16 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:43845 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755017Ab1DOOom (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2011 10:44:42 -0400
Received: by mail-wy0-f174.google.com with SMTP id 21so2304119wya.19
        for <git@vger.kernel.org>; Fri, 15 Apr 2011 07:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=1i8v4K3Gbf8PxxpLXfUlQrKpfZgjN4NT61VV8yo9WZ0=;
        b=ZRnoNO5sQlRlMzcETMD/a+HD8Sh6e0+e00HB1dckjlP1Xke6XpfljjaiBlU8MY2sj0
         /mm9vLYH1F7FPrFKATcecLWynl/QKB8X7h39yAAD03oHifa3pmGNH+hWIN9JH7qZi/iD
         iGW9LcvZBSG7dniOnICrIZ24Lq+B6nlkeKl1s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=XwFFOxHfcDg+oOnSKiJuZ30kAjBW1tngBSl1Bsf1XqHKWMSGLZnmV/CSrK3McukfR6
         1ECLKMaO4RxSdYpNo3WT9BTcZlVKLflHX5S6f6zPoIrhgjB5BI8z8B/2ORGaJ1X8JiO9
         FgCDu9C/1ZyzMG8wSF1NL8ueX4R3VvqGs1iJg=
Received: by 10.216.140.219 with SMTP id e69mr2547714wej.45.1302878681776;
        Fri, 15 Apr 2011 07:44:41 -0700 (PDT)
Received: from roke.localdomain (abwn60.neoplus.adsl.tpnet.pl [83.8.237.60])
        by mx.google.com with ESMTPS id u9sm1663346wbg.34.2011.04.15.07.44.39
        (version=SSLv3 cipher=OTHER);
        Fri, 15 Apr 2011 07:44:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1302878645-458-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171610>

The code is simplified and does not support full specification of
native getElementsByClassName method, but implements just subset that
would be enough for gitweb, supporting only single class name.

This patch makes subsequent timezone manipulation work on Mozilla
1.17.2 which doesn't have document.getElementsByClassName (while
native implementation is used e.g. for Firefox 4.0).

Signed-off-by: John 'Warthog9' Hawley <warthog9@eaglescrag.net>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch is unchanged from v1 version, except added commentary in
the commit message.

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
