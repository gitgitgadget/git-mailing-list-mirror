From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 4/6] http: retry authentication failures for all http requests
Date: Fri, 14 Oct 2011 09:40:38 +0200
Message-ID: <8d677edc4fa3fd1fe12b49bf279aaad5be89b81c.1318577792.git.git@drmicha.warpmail.net>
References: <4E9692BF.8040705@drmicha.warpmail.net>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 14 09:41:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REcO9-0006DO-Tz
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 09:41:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932653Ab1JNHkx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 03:40:53 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:56307 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932327Ab1JNHku (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Oct 2011 03:40:50 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 7BCBD20BB7;
	Fri, 14 Oct 2011 03:40:50 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute3.internal (MEProxy); Fri, 14 Oct 2011 03:40:50 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=jw
	ey6RHTIuSo6HS5DBtz1nE34TE=; b=ta6gtRiYBbIjL06hhljcA2AVzns55EKy4N
	jALwTy3O90/KySQBaUa7IUtI34IYT/3n+3lRisiBPM+p8mqFeYEYjeqPKHboQcuL
	Ld9Nk5vQajfNHjNykW5Yz8UaZwT+EmeuH2PPr+C6d9U16yIEizKcw1Tbc3Wc27N/
	aNrr2qXk0=
X-Sasl-enc: mpUtZgPqVJTadibG3g/bGWzL5M+pXOFmc0pLsEpNPjws 1318578049
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id F0E6D4833FD;
	Fri, 14 Oct 2011 03:40:49 -0400 (EDT)
X-Mailer: git-send-email 1.7.7.338.g0156b
In-Reply-To: <4E9692BF.8040705@drmicha.warpmail.net>
In-Reply-To: <cover.1318577792.git.git@drmicha.warpmail.net>
References: <cover.1318577792.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183551>

From: Jeff King <peff@peff.net>

Commit 42653c0 (Prompt for a username when an HTTP request
401s, 2010-04-01) changed http_get_strbuf to prompt for
credentials when we receive a 401, but didn't touch
http_get_file. The latter is called only for dumb http;
while it's usually the case that people don't use
authentication on top of dumb http, there is no reason not
to allow both types of requests to use this feature.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 http.c |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/http.c b/http.c
index c93716c..89e3cf4 100644
--- a/http.c
+++ b/http.c
@@ -846,13 +846,18 @@ static int http_request(const char *url, void *result, int target, int options)
 	return ret;
 }
 
+static int http_request_reauth(const char *url, void *result, int target,
+			       int options)
+{
+	int ret = http_request(url, result, target, options);
+	if (ret != HTTP_REAUTH)
+		return ret;
+	return http_request(url, result, target, options);
+}
+
 int http_get_strbuf(const char *url, struct strbuf *result, int options)
 {
-	int http_ret = http_request(url, result, HTTP_REQUEST_STRBUF, options);
-	if (http_ret == HTTP_REAUTH) {
-		http_ret = http_request(url, result, HTTP_REQUEST_STRBUF, options);
-	}
-	return http_ret;
+	return http_request_reauth(url, result, HTTP_REQUEST_STRBUF, options);
 }
 
 /*
@@ -875,7 +880,7 @@ static int http_get_file(const char *url, const char *filename, int options)
 		goto cleanup;
 	}
 
-	ret = http_request(url, result, HTTP_REQUEST_FILE, options);
+	ret = http_request_reauth(url, result, HTTP_REQUEST_FILE, options);
 	fclose(result);
 
 	if ((ret == HTTP_OK) && move_temp_to_file(tmpfile.buf, filename))
-- 
1.7.7.338.g0156b
