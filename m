From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] http: return curl's AUTHAVAIL via slot_results
Date: Thu, 31 Oct 2013 02:35:31 -0400
Message-ID: <20131031063530.GA5812@sigill.intra.peff.net>
References: <20131031063451.GA5513@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Thu Oct 31 07:35:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vblr0-0000ov-5F
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 07:35:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752667Ab3JaGfe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 02:35:34 -0400
Received: from cloud.peff.net ([50.56.180.127]:58997 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750855Ab3JaGfe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 02:35:34 -0400
Received: (qmail 18238 invoked by uid 102); 31 Oct 2013 06:35:34 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 31 Oct 2013 01:35:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Oct 2013 02:35:31 -0400
Content-Disposition: inline
In-Reply-To: <20131031063451.GA5513@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237080>

Callers of the http code may want to know which auth types
were available for the previous request. But after finishing
with the curl slot, they are not supposed to look at the
curl handle again. We already handle returning other
information via the slot_results struct; let's add a flag to
check the available auth.

Note that older versions of curl did not support this, so we
simply return 0 (something like "-1" would be worse, as the
value is a bitflag and we might accidentally set a flag).
This is sufficient for the callers planned in this series,
who only trigger some optional behavior if particular bits
are set, and can live with a fake "no bits" answer.

Signed-off-by: Jeff King <peff@peff.net>
---
 http.c | 6 ++++++
 http.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/http.c b/http.c
index 0ddb164..5c51865 100644
--- a/http.c
+++ b/http.c
@@ -761,6 +761,12 @@ void finish_active_slot(struct active_request_slot *slot)
 	if (slot->results != NULL) {
 		slot->results->curl_result = slot->curl_result;
 		slot->results->http_code = slot->http_code;
+#if LIBCURL_VERSION_NUM >= 0x070a08
+		curl_easy_getinfo(slot->curl, CURLINFO_HTTPAUTH_AVAIL,
+				  &slot->results->auth_avail);
+#else
+		slot->results->auth_avail = 0;
+#endif
 	}
 
 	/* Run callback if appropriate */
diff --git a/http.h b/http.h
index d77c1b5..81d4843 100644
--- a/http.h
+++ b/http.h
@@ -54,6 +54,7 @@
 struct slot_results {
 	CURLcode curl_result;
 	long http_code;
+	long auth_avail;
 };
 
 struct active_request_slot {
-- 
1.8.4.1.898.g8bf8a41.dirty
