From: =?iso-8859-1?Q?Martin_Storsj=F6?= <martin@martin.st>
Subject: [PATCH] Do curl option disabling before enabling new options
Date: Tue, 14 Apr 2009 22:01:01 +0300 (EEST)
Message-ID: <Pine.LNX.4.64.0904142200130.7479@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 14 21:03:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtnuM-000615-Fr
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 21:02:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754982AbZDNTBH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2009 15:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751896AbZDNTBF
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 15:01:05 -0400
Received: from smtp2.abo.fi ([130.232.213.77]:52493 "EHLO smtp2.abo.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753222AbZDNTBE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2009 15:01:04 -0400
Received: from albin.abo.fi (albin.abo.fi [130.232.81.192])
	by smtp2.abo.fi (8.14.3/8.12.9) with ESMTP id n3EJ11Js000736
	for <git@vger.kernel.org>; Tue, 14 Apr 2009 22:01:02 +0300
X-X-Sender: mstorsjo@localhost.localdomain
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (smtp2.abo.fi [130.232.213.77]); Tue, 14 Apr 2009 22:01:02 +0300 (EEST)
X-Virus-Scanned: by roxy.abo.fi (roxy.abo.fi: Tue Apr 14 22:01:02 2009)
X-Scanned-By: MIMEDefang 2.67 on 130.232.213.77
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This works around a bug in curl versions up to 7.19.4, where
disabling the CURLOPT_NOBODY option sets the internal state
incorrectly considering that CURLOPT_PUT was enabled earlier.

The bug is discussed at http://curl.haxx.se/bug/view.cgi?id=2727981
and is corrected in the latest version of curl in CVS.

This bug usually has no impact on git, but may surface if using
multi-pass authentication methods.

Signed-off-by: Martin Storsjo <martin@martin.st>
---
 http-push.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/http-push.c b/http-push.c
index 5138224..3629492 100644
--- a/http-push.c
+++ b/http-push.c
@@ -599,9 +599,9 @@ static void start_put(struct transfer_request *request)
 #endif
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_null);
 	curl_easy_setopt(slot->curl, CURLOPT_CUSTOMREQUEST, DAV_PUT);
+	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
 	curl_easy_setopt(slot->curl, CURLOPT_UPLOAD, 1);
 	curl_easy_setopt(slot->curl, CURLOPT_PUT, 1);
-	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
 	curl_easy_setopt(slot->curl, CURLOPT_URL, request->url);
 
 	if (start_active_slot(slot)) {
-- 
1.6.0.2
