From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 08/13] gitweb.js: Provide getElementsByClassName method (if it not exists)
Date: Thu, 28 Apr 2011 21:04:06 +0200
Message-ID: <1304017451-12283-9-git-send-email-jnareb@gmail.com>
References: <1304017451-12283-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Kevin Cernekee <cernekee@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 21:05:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFWWZ-0003Nk-FQ
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 21:05:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933424Ab1D1TE4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 15:04:56 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62309 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933419Ab1D1TEw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 15:04:52 -0400
Received: by mail-ww0-f44.google.com with SMTP id 36so3481029wwa.1
        for <git@vger.kernel.org>; Thu, 28 Apr 2011 12:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=QBhrIqkG6sDNMZiNowi4vVn9wbcqVsi2s/hwg0OXwJk=;
        b=rvf+/FmPMo2d1JMzUUYljSPHoiO/NHhrFa6W22NZ4yoaTkn+6XzyBXkPvZn4hQYyBi
         inL3tL6Q2pGe82YiSBJrCxAsyYGrjnHDMlOP5aI4eMppfMZ7gMlupU5mM8AdZ7z9LvP2
         2zL3a7NykPNQta5ErdvXf2rBqp7ZPM41AkYxM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=hnAW1dXgoeUGyqZKWrI6N1F9vuzb+9QOqltNZRAzr1pjnqe8YNbQjhde/zVdy9UyVj
         WXL5EJjsL9WnFeTFEVkSy1NThuGv/ySd1C1bZ/oFtZkEoRBxyzlMfsWfJ6fiVyVHZwao
         Y4JNFjfZmdGs6XdTizcLQ/xL1CSkqU4i8qjAo=
Received: by 10.227.10.141 with SMTP id p13mr2455889wbp.75.1304017492104;
        Thu, 28 Apr 2011 12:04:52 -0700 (PDT)
Received: from localhost.localdomain (abrz25.neoplus.adsl.tpnet.pl [83.8.119.25])
        by mx.google.com with ESMTPS id w25sm1266549wbd.56.2011.04.28.12.04.50
        (version=SSLv3 cipher=OTHER);
        Thu, 28 Apr 2011 12:04:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1304017451-12283-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172390>

The code is simplified and does not support full specification of
native getElementsByClassName method, but implements just subset that
would be enough for gitweb, supporting only single class name.

Signed-off-by: John 'Warthog9' Hawley <warthog9@eaglescrag.net>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch is unchanged from first version of this series.


Instead of providing findElementsByClassName function like in
J.H. patch, which could use getElementsByClassName if present (it
didn't cache the check for document.getElementsByClassName, but I
guess any performance gain is negligible), this version adds
getElementsByClassName method to 'document' if it doesn't exist.

Note that in this implementation we avoid 'push' method of Array
instances, as supposedly not all web browsers implement it, and it is
easy to work around.

In this implementation of document.getElementsByClassName we use
'document.all' if it exists instead of 'document.getElementsByTagName("*")';
this avoids issue with getElementsByTagName("*") that supposedly some
versions of IE have.  This workaround is not present in original patch
by J.H.

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
