From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2] http-backend: provide Allow header for 405
Date: Thu, 12 Sep 2013 00:30:01 +0000
Message-ID: <1378945801-122021-1-git-send-email-sandals@crustytoothpaste.net>
Cc: mhagger@alum.mit.edu, jkoleszar@google.com, gitster@pobox.com,
	jrnieder@gmail.com, peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 12 02:30:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJunc-00009i-3a
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 02:30:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371Ab3ILAaN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 20:30:13 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:60231 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751103Ab3ILAaM (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Sep 2013 20:30:12 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id E944060001;
	Thu, 12 Sep 2013 00:30:09 +0000 (UTC)
X-Mailer: git-send-email 1.8.4.236.g382490f.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234615>

The HTTP 1.1 standard requires an Allow header for 405 Method Not Allowed:

  The response MUST include an Allow header containing a list of valid methods
  for the requested resource.

So provide such a header when we return a 405 to the user agent.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 http-backend.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/http-backend.c b/http-backend.c
index 0324417..8c464bd 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -594,9 +594,11 @@ int main(int argc, char **argv)
 
 			if (strcmp(method, c->method)) {
 				const char *proto = getenv("SERVER_PROTOCOL");
-				if (proto && !strcmp(proto, "HTTP/1.1"))
+				if (proto && !strcmp(proto, "HTTP/1.1")) {
 					http_status(405, "Method Not Allowed");
-				else
+					hdr_str("Allow", !strcmp(c->method, "GET") ?
+						"GET, HEAD" : c->method);
+				} else
 					http_status(400, "Bad Request");
 				hdr_nocache();
 				end_headers();
-- 
1.8.4.rc3
