From: Jeff King <peff@peff.net>
Subject: [PATCH 04/14] http: add a public function for arbitrary-callback
 request
Date: Thu, 10 Nov 2011 02:49:20 -0500
Message-ID: <20111110074920.GD27950@sigill.intra.peff.net>
References: <20111110074330.GA27925@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 08:49:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROPO3-0002v8-SJ
	for gcvg-git-2@lo.gmane.org; Thu, 10 Nov 2011 08:49:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933587Ab1KJHtX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Nov 2011 02:49:23 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38915
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752684Ab1KJHtX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2011 02:49:23 -0500
Received: (qmail 22314 invoked by uid 107); 10 Nov 2011 07:49:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 10 Nov 2011 02:49:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Nov 2011 02:49:20 -0500
Content-Disposition: inline
In-Reply-To: <20111110074330.GA27925@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185202>

The http_request function recently learned to take arbitrary
callbacks; let's expose this functionality to callers.

Signed-off-by: Jeff King <peff@peff.net>
---
 http.c |    6 ++++++
 http.h |    3 +++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/http.c b/http.c
index 9ffd894..91451e9 100644
--- a/http.c
+++ b/http.c
@@ -886,6 +886,12 @@ int http_get_strbuf(const char *url, struct strbuf *result, int options)
 	return http_request_reauth(url, fwrite_buffer, result, 0, options);
 }
 
+int http_get_callback(const char *url, curl_write_callback cb,
+		      void *data, long offset, int options)
+{
+	return http_request_reauth(url, cb, data, offset, options);
+}
+
 /*
  * Downloads an url and stores the result in the given file.
  *
diff --git a/http.h b/http.h
index ee16069..4977bde 100644
--- a/http.h
+++ b/http.h
@@ -132,6 +132,9 @@ extern void append_remote_object_url(struct strbuf *buf, const char *url,
  */
 int http_get_strbuf(const char *url, struct strbuf *result, int options);
 
+int http_get_callback(const char *url, curl_write_callback cb, void *data,
+		      long offset, int options);
+
 /*
  * Prints an error message using error() containing url and curl_errorstr,
  * and returns ret.
-- 
1.7.7.2.7.g9f96f
