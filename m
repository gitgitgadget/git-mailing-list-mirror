From: Jeff King <peff@peff.net>
Subject: [PATCH 5/9] http: provide effective url to callers
Date: Sat, 28 Sep 2013 04:32:02 -0400
Message-ID: <20130928083202.GE2131@sigill.intra.peff.net>
References: <20130928082956.GA22610@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Kyle J. McKay" <mackyle@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 28 10:32:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPpwg-0002fB-Tj
	for gcvg-git-2@plane.gmane.org; Sat, 28 Sep 2013 10:32:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754920Ab3I1IcG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 04:32:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:35146 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754916Ab3I1IcF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 04:32:05 -0400
Received: (qmail 8682 invoked by uid 102); 28 Sep 2013 08:32:04 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 28 Sep 2013 03:32:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 28 Sep 2013 04:32:02 -0400
Content-Disposition: inline
In-Reply-To: <20130928082956.GA22610@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235494>

When we ask curl to access a URL, it may follow one or more
redirects to reach the final location. We have no idea
this has happened, as curl takes care of the details and
simply returns the final content to us.

The final URL that we ended up with can be accessed via
CURLINFO_EFFECTIVE_URL. Let's make that optionally available
to callers of http_get_*, so that they can make further
decisions based on the redirection.

Signed-off-by: Jeff King <peff@peff.net>
---
 http.c | 4 ++++
 http.h | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/http.c b/http.c
index 5504b2c..65a0048 100644
--- a/http.c
+++ b/http.c
@@ -911,6 +911,10 @@ static int http_request(const char *url,
 		curlinfo_strbuf(slot->curl, CURLINFO_CONTENT_TYPE,
 				options->content_type);
 
+	if (options && options->effective_url)
+		curlinfo_strbuf(slot->curl, CURLINFO_EFFECTIVE_URL,
+				options->effective_url);
+
 	curl_slist_free_all(headers);
 	strbuf_release(&buf);
 
diff --git a/http.h b/http.h
index 17116ab..974ede7 100644
--- a/http.h
+++ b/http.h
@@ -133,6 +133,12 @@ struct http_get_options {
 
 	/* If non-NULL, returns the content-type of the response. */
 	struct strbuf *content_type;
+
+	/*
+	 * If non-NULL, returns the URL we ended up at, including any
+	 * redirects we followed.
+	 */
+	struct strbuf *effective_url;
 };
 
 /* Return values for http_get_*() */
-- 
1.8.4.rc3.19.g9da5bf6
