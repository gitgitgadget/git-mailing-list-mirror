From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 3/3] gitweb.js: use setTimeout rather than setInterval in blame_incremental.js
Date: Fri, 27 May 2011 15:50:01 +0200
Message-ID: <1306504201-18014-4-git-send-email-jnareb@gmail.com>
References: <1306504201-18014-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>,
	Fredrik Kuivinen <frekui@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Luben Tuikov <ltuikov@yahoo.com>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 27 15:50:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPxQx-0005MN-6G
	for gcvg-git-2@lo.gmane.org; Fri, 27 May 2011 15:50:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755964Ab1E0Nuc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2011 09:50:32 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60815 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755900Ab1E0Nu3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2011 09:50:29 -0400
Received: by mail-fx0-f46.google.com with SMTP id 17so1341410fxm.19
        for <git@vger.kernel.org>; Fri, 27 May 2011 06:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=IV6DwuWd3Bgn6kIOvDSnEbd2fB4+uVIOOmS/x9OOHzo=;
        b=eqL3x3YoSdHvXdaxOfcVfNtoegbbxSwCfVCoqGksLOASmgRk4s30/FX2vgXQIwDSsf
         XEWk965hL4ikASVF1peo81Xk4nZiFUBr3ztL3BPyK0BKnWqZmGTufaqhOir+ubeqlOol
         R2mGDq90ixw9AU1SyHzVX3pPf76rO93ywF4fk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=TnNL9Xc4ytfU+D2Tcy206TaodyuS9J0h5NmC74OfivHm6X6xupUUUC8HM98aG1N9f4
         lb9KFzsSFE9BkoxOMbGBe41HLDPPGIjGYCgU1RawneIo6eInZld6fRfpPUP8BwaFnJ1o
         ev8Hsoimh1bDXK6MkEjqL/549s+Tks528dZhw=
Received: by 10.223.6.71 with SMTP id 7mr2354631fay.14.1306504229251;
        Fri, 27 May 2011 06:50:29 -0700 (PDT)
Received: from localhost.localdomain (abvw13.neoplus.adsl.tpnet.pl [83.8.220.13])
        by mx.google.com with ESMTPS id l26sm687778fah.38.2011.05.27.06.50.27
        (version=SSLv3 cipher=OTHER);
        Fri, 27 May 2011 06:50:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.5
In-Reply-To: <1306504201-18014-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174615>

If there is a possibility that your logic could take longer to execute
than the interval time, it is recommended that you recursively call a
named function using window.setTimeout rather than window.setInterval.

Therefore instead of using setInterval as an alternate way of invoking
handleResponse (because some web browsers call onreadystatechange only
once per each distinct state, and not for each server flush), use
setTimeout and reset it from handleResponse.  As a bonus this allows
us to get rid of timer if it turns out that web browser calls
onreadystatechange on each server flush.

While at it get rid of `xhr' global variable, creating it instead as
local variable in startBlame and passing it as parameter, and of
`pollTimer' global variable, passing it as member of xhr object
(xhr.pollTimer).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch introduces three separate features, and probably should be
split into separate patches.

 gitweb/static/js/blame_incremental.js |   55 ++++++++++++++++++++++++---------
 1 files changed, 40 insertions(+), 15 deletions(-)

diff --git a/gitweb/static/js/blame_incremental.js b/gitweb/static/js/blame_incremental.js
index 27955ec..91354a0 100644
--- a/gitweb/static/js/blame_incremental.js
+++ b/gitweb/static/js/blame_incremental.js
@@ -29,7 +29,6 @@
 /* ............................................................ */
 /* utility/helper functions (and variables) */
 
-var xhr;        // XMLHttpRequest object
 var projectUrl; // partial query + separator ('?' or ';')
 
 // 'commits' is an associative map. It maps SHA1s to Commit objects.
@@ -431,8 +430,6 @@ var endRe  = /^END ?([^ ]*) ?(.*)/;
 var curCommit = new Commit();
 var curGroup  = {};
 
-var pollTimer = null;
-
 /**
  * Parse output from 'git blame --incremental [...]', received via
  * XMLHttpRequest from server (blamedataUrl), and call handleLine
@@ -533,26 +530,34 @@ function processData(unprocessed, nextReadPos) {
  * Handle XMLHttpRequest errors
  *
  * @param {XMLHttpRequest} xhr: XMLHttpRequest object
+ * @param {Number} [xhr.pollTimer] ID of the timeout to clear
  *
- * @globals pollTimer, commits
+ * @globals commits
  */
 function handleError(xhr) {
 	errorInfo('Server error: ' +
 		xhr.status + ' - ' + (xhr.statusText || 'Error contacting server'));
 
-	clearInterval(pollTimer);
+	if (typeof xhr.pollTimer === "number") {
+		clearTimeout(xhr.pollTimer);
+		delete xhr.pollTimer;
+	}
 	commits = {}; // free memory
 }
 
 /**
  * Called after XMLHttpRequest finishes (loads)
  *
- * @param {XMLHttpRequest} xhr: XMLHttpRequest object (unused)
+ * @param {XMLHttpRequest} xhr: XMLHttpRequest object
+ * @param {Number} [xhr.pollTimer] ID of the timeout to clear
  *
- * @globals pollTimer, commits
+ * @globals commits
  */
 function responseLoaded(xhr) {
-	clearInterval(pollTimer);
+	if (typeof xhr.pollTimer === "number") {
+		clearTimeout(xhr.pollTimer);
+		delete xhr.pollTimer;
+	}
 
 	fixColorsAndGroups();
 	writeTimeInterval();
@@ -563,9 +568,13 @@ function responseLoaded(xhr) {
  * handler for XMLHttpRequest onreadystatechange event
  * @see startBlame
  *
- * @globals xhr
+ * @param {XMLHttpRequest} xhr: XMLHttpRequest object
+ * @param {Number} xhr.prevDataLength: previous value of xhr.responseText.length
+ * @param {Number} xhr.nextReadPos: start of unread part of xhr.responseText
+ * @param {Number} [xhr.pollTimer] ID of the timeout (to reset or cancel)
+ * @param {Boolean} fromTimer: if handler was called from timer
  */
-function handleResponse() {
+function handleResponse(xhr, fromTimer) {
 
 	/*
 	 * xhr.readyState
@@ -614,6 +623,19 @@ function handleResponse() {
 	// did we finish work?
 	if (xhr.readyState === 4) {
 		responseLoaded(xhr);
+		return;
+	}
+
+	// if we get from timer, we have to restart it
+	// otherwise onreadystatechange gives us partial response, timer not needed
+	if (fromTimer) {
+		setTimeout(function () {
+			handleResponse(xhr, true);
+		}, 1000);
+
+	} else if (typeof xhr.pollTimer === "number") {
+		clearTimeout(xhr.pollTimer);
+		delete xhr.pollTimer;
 	}
 }
 
@@ -629,11 +651,11 @@ function handleResponse() {
  * Called from 'blame_incremental' view after loading table with
  * file contents, a base for blame view.
  *
- * @globals xhr, t0, projectUrl, div_progress_bar, totalLines, pollTimer
+ * @globals t0, projectUrl, div_progress_bar, totalLines
 */
 function startBlame(blamedataUrl, bUrl) {
 
-	xhr = createRequestObject();
+	var xhr = createRequestObject();
 	if (!xhr) {
 		errorInfo('ERROR: XMLHttpRequest not supported');
 		return;
@@ -652,8 +674,9 @@ function startBlame(blamedataUrl, bUrl) {
 	xhr.prevDataLength = -1;  // used to detect if we have new data
 	xhr.nextReadPos = 0;      // where unread part of response starts
 
-	xhr.onreadystatechange = handleResponse;
-	//xhr.onreadystatechange = function () { handleResponse(xhr); };
+	xhr.onreadystatechange = function () {
+		handleResponse(xhr, false); 
+	};
 
 	xhr.open('GET', blamedataUrl);
 	xhr.setRequestHeader('Accept', 'text/plain');
@@ -661,7 +684,9 @@ function startBlame(blamedataUrl, bUrl) {
 
 	// not all browsers call onreadystatechange event on each server flush
 	// poll response using timer every second to handle this issue
-	pollTimer = setInterval(xhr.onreadystatechange, 1000);
+	xhr.pollTimer = setTimeout(function () {
+		handleResponse(xhr, true);
+	}, 1000);
 }
 
 /* end of blame_incremental.js */
-- 
1.7.5
