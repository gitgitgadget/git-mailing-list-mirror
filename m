From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/3] gitweb.js: No need for loop in blame_incremental's handleResponse()
Date: Fri, 27 May 2011 15:50:00 +0200
Message-ID: <1306504201-18014-3-git-send-email-jnareb@gmail.com>
References: <1306504201-18014-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>,
	Fredrik Kuivinen <frekui@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Luben Tuikov <ltuikov@yahoo.com>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 27 15:50:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPxRC-0005Wq-20
	for gcvg-git-2@lo.gmane.org; Fri, 27 May 2011 15:50:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755878Ab1E0Nua (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2011 09:50:30 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60815 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755781Ab1E0Nu1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2011 09:50:27 -0400
Received: by mail-fx0-f46.google.com with SMTP id 17so1341410fxm.19
        for <git@vger.kernel.org>; Fri, 27 May 2011 06:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=x2mYrllznlb1Hbj9qQLSYSmqXfQqs86KVdWAFxp/Flc=;
        b=XGzqwdkGvZiRRz6kNFaubgaIorL+nv9pr8i0jazvF7LUIhrbRnU80HOvdfUECr3v8P
         fm/tyr1VA4o3E/75QezIzJGVWbj8nsEbKTUmUrJsvokZY2fo7MVSHeQ5q1u1CH8JDToU
         q/rPMxokThZmeXi2ErTnj+1NXoQDrzgkUeLyE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=mLQ4uELj9CNbWQZdqGs8g5CSm2Uwf1c1MilHSknuX+LkUyb4s9fPjSBFzlZHBu7TSq
         VHPEO+0dmu0crws6Vb9BBuZZOrIQUjPYqaS0zB23F+SfWTsK33pPtsRk/nepwtq8h7wy
         lbWmwP01ltUKS/6tcu43J8PAO8Ifi/S5g1bM0=
Received: by 10.223.98.82 with SMTP id p18mr2367349fan.64.1306504227044;
        Fri, 27 May 2011 06:50:27 -0700 (PDT)
Received: from localhost.localdomain (abvw13.neoplus.adsl.tpnet.pl [83.8.220.13])
        by mx.google.com with ESMTPS id l26sm687778fah.38.2011.05.27.06.50.25
        (version=SSLv3 cipher=OTHER);
        Fri, 27 May 2011 06:50:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.5
In-Reply-To: <1306504201-18014-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174618>

JavaScript is single-threaded, so there is no need for protecting
against changes to XMLHttpRequest object behind event handler back.

Therefore there is no need for loop that was here in case `xhr' got
new changes while processing current changes.  This should make code a
bit more clear.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Remove and simplify code.

 gitweb/static/js/blame_incremental.js |   13 ++++---------
 1 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/gitweb/static/js/blame_incremental.js b/gitweb/static/js/blame_incremental.js
index 4841805..27955ec 100644
--- a/gitweb/static/js/blame_incremental.js
+++ b/gitweb/static/js/blame_incremental.js
@@ -603,21 +603,16 @@ function handleResponse() {
 		return;
 	}
 
-	// extract new whole (complete) lines, and process them
-	while (xhr.prevDataLength !== xhr.responseText.length) {
-		if (xhr.readyState === 4 &&
-		    xhr.prevDataLength === xhr.responseText.length) {
-			break;
-		}
 
+	// extract new whole (complete) lines, and process them
+	if (xhr.prevDataLength !== xhr.responseText.length) {
 		xhr.prevDataLength = xhr.responseText.length;
 		var unprocessed = xhr.responseText.substring(xhr.nextReadPos);
 		xhr.nextReadPos = processData(unprocessed, xhr.nextReadPos);
-	} // end while
+	}
 
 	// did we finish work?
-	if (xhr.readyState === 4 &&
-	    xhr.prevDataLength === xhr.responseText.length) {
+	if (xhr.readyState === 4) {
 		responseLoaded(xhr);
 	}
 }
-- 
1.7.5
