From: Dmitry Vilkov <dmitry.a.vilkov@gmail.com>
Subject: [PATCH] remote-curl: don't fall back to Basic auth if we haven't tried Negotiate
Date: Tue,  2 Feb 2016 12:11:24 +0300
Message-ID: <1454404284-2197-1-git-send-email-dmitry.a.vilkov@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 02 10:18:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQX6B-0004mb-0d
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 10:18:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754087AbcBBJRj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 04:17:39 -0500
Received: from broadband-46-188-47-77.2com.net ([46.188.47.77]:33026 "EHLO
	dav-pc.localdomain" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753887AbcBBJRh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2016 04:17:37 -0500
X-Greylist: delayed 371 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Feb 2016 04:17:37 EST
Received: from dav-pc.Dlink (dav-pc.home [127.0.0.1])
	by dav-pc.localdomain (Postfix) with ESMTP id 936A63EB5A5
	for <git@vger.kernel.org>; Tue,  2 Feb 2016 12:11:24 +0300 (MSK)
X-Mailer: git-send-email 2.4.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285245>

This is fix of bug introduced by 4dbe66464 commit.
The problem is that when username/password combination was not set,
the first HTTP(S) request will fail and user will be asked for
credentials. As a side effect of first HTTP(S) request, libcurl auth
method GSS-Negotiate will be disabled unconditionally. Although, we
haven't tried yet provided credentials for this auth method.

Signed-off-by: Dmitry Vilkov <dmitry.a.vilkov@gmail.com>
---
 http.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/http.c b/http.c
index 0da9e66..707ea84 100644
--- a/http.c
+++ b/http.c
@@ -951,12 +951,15 @@ static int handle_curl_result(struct slot_results *results)
 		return HTTP_MISSING_TARGET;
 	else if (results->http_code == 401) {
 		if (http_auth.username && http_auth.password) {
+#ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
+			if (http_auth_methods & CURLAUTH_GSSNEGOTIATE) {
+				http_auth_methods &= ~CURLAUTH_GSSNEGOTIATE;
+				return HTTP_REAUTH;
+			}
+#endif
 			credential_reject(&http_auth);
 			return HTTP_NOAUTH;
 		} else {
-#ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
-			http_auth_methods &= ~CURLAUTH_GSSNEGOTIATE;
-#endif
 			return HTTP_REAUTH;
 		}
 	} else {
-- 
2.4.10
