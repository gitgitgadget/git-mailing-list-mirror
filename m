From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/3] gitweb.js: No need for inProgress in blame_incremental.js
Date: Fri, 27 May 2011 15:49:59 +0200
Message-ID: <1306504201-18014-2-git-send-email-jnareb@gmail.com>
References: <1306504201-18014-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>,
	Fredrik Kuivinen <frekui@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Luben Tuikov <ltuikov@yahoo.com>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 27 15:50:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPxQw-0005MN-M0
	for gcvg-git-2@lo.gmane.org; Fri, 27 May 2011 15:50:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755912Ab1E0Nu1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2011 09:50:27 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60815 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755654Ab1E0Nu0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2011 09:50:26 -0400
Received: by mail-fx0-f46.google.com with SMTP id 17so1341410fxm.19
        for <git@vger.kernel.org>; Fri, 27 May 2011 06:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=qulxWMeLMix0J5Km2sltGaNScRvhj7SXG6HBcHn1Wn0=;
        b=KZPLMuIa1pDs9LalrEiNbVNv0v7HVXupcHJhYq5ULn1H90w86FN4JNmFe54jRXOYxT
         +lMVkJ2bOgMN0iP12F1FAhtYslr3WdGPaQ8FwOK4r3hK2hveGcMyb4OJlJ+PmMywCPUl
         tE/Lfg1HCMIhY0FA6XYIy4EAAe1RDeI0cMTDA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=pi/mCLADxOLKYcy8gZeaZZHw4n0YudXsyymY7cyZuz1kSa/JJZNR2loV4d/uCdf9Qk
         zB85eZRXP9u9/fg58rCp3YH7wJvRih/VN5iNWuD5r21+Rz+t8u569w0VNkgZPbujvz9v
         6Vzu7i9U5kL765iXNduzsDAayu4sV+qOuv19Y=
Received: by 10.223.69.65 with SMTP id y1mr2381894fai.60.1306504225200;
        Fri, 27 May 2011 06:50:25 -0700 (PDT)
Received: from localhost.localdomain (abvw13.neoplus.adsl.tpnet.pl [83.8.220.13])
        by mx.google.com with ESMTPS id l26sm687778fah.38.2011.05.27.06.50.23
        (version=SSLv3 cipher=OTHER);
        Fri, 27 May 2011 06:50:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.5
In-Reply-To: <1306504201-18014-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174617>

JavaScript is single-threaded, so there is no need for protection
against re-entrancy via inProgress variable.

In particular calls to setInterval handler are stacked if handler
doesn't finish before new interrupt (before new interval).  The same
happens with events - they are (hopefully) stacked if even handler
didn't finish work.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Remove and simplify code.

 gitweb/static/js/blame_incremental.js |   21 +++------------------
 1 files changed, 3 insertions(+), 18 deletions(-)

diff --git a/gitweb/static/js/blame_incremental.js b/gitweb/static/js/blame_incremental.js
index 676da6b..4841805 100644
--- a/gitweb/static/js/blame_incremental.js
+++ b/gitweb/static/js/blame_incremental.js
@@ -420,8 +420,6 @@ function handleLine(commit, group) {
 
 // ----------------------------------------------------------------------
 
-var inProgress = false;   // are we processing response
-
 /**#@+
  * @constant
  */
@@ -536,7 +534,7 @@ function processData(unprocessed, nextReadPos) {
  *
  * @param {XMLHttpRequest} xhr: XMLHttpRequest object
  *
- * @globals pollTimer, commits, inProgress
+ * @globals pollTimer, commits
  */
 function handleError(xhr) {
 	errorInfo('Server error: ' +
@@ -544,8 +542,6 @@ function handleError(xhr) {
 
 	clearInterval(pollTimer);
 	commits = {}; // free memory
-
-	inProgress = false;
 }
 
 /**
@@ -553,7 +549,7 @@ function handleError(xhr) {
  *
  * @param {XMLHttpRequest} xhr: XMLHttpRequest object (unused)
  *
- * @globals pollTimer, commits, inProgress
+ * @globals pollTimer, commits
  */
 function responseLoaded(xhr) {
 	clearInterval(pollTimer);
@@ -561,15 +557,13 @@ function responseLoaded(xhr) {
 	fixColorsAndGroups();
 	writeTimeInterval();
 	commits = {}; // free memory
-
-	inProgress = false;
 }
 
 /**
  * handler for XMLHttpRequest onreadystatechange event
  * @see startBlame
  *
- * @globals xhr, inProgress
+ * @globals xhr
  */
 function handleResponse() {
 
@@ -609,13 +603,6 @@ function handleResponse() {
 		return;
 	}
 
-	// in case we were called before finished processing
-	if (inProgress) {
-		return;
-	} else {
-		inProgress = true;
-	}
-
 	// extract new whole (complete) lines, and process them
 	while (xhr.prevDataLength !== xhr.responseText.length) {
 		if (xhr.readyState === 4 &&
@@ -633,8 +620,6 @@ function handleResponse() {
 	    xhr.prevDataLength === xhr.responseText.length) {
 		responseLoaded(xhr);
 	}
-
-	inProgress = false;
 }
 
 // ============================================================
-- 
1.7.5
