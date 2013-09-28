From: Jeff King <peff@peff.net>
Subject: [PATCH 7/9] remote-curl: make refs_url a strbuf
Date: Sat, 28 Sep 2013 04:35:10 -0400
Message-ID: <20130928083510.GB2782@sigill.intra.peff.net>
References: <20130928082956.GA22610@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Kyle J. McKay" <mackyle@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 28 10:35:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPpzh-00056E-TL
	for gcvg-git-2@plane.gmane.org; Sat, 28 Sep 2013 10:35:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754044Ab3I1IfO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 04:35:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:35172 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753953Ab3I1IfM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 04:35:12 -0400
Received: (qmail 8891 invoked by uid 102); 28 Sep 2013 08:35:12 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 28 Sep 2013 03:35:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 28 Sep 2013 04:35:10 -0400
Content-Disposition: inline
In-Reply-To: <20130928082956.GA22610@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235496>

In the discover_refs function, we use a strbuf named
"buffer" for multiple purposes. First we build the info/refs
URL in it, and then detach that to a bare pointer. Then, we
use the same strbuf to store the result of fetching the
refs.

Let's instead keep a separate refs_url strbuf. This is less
confusing, as the "buffer" strbuf is now used for only one
thing.

Signed-off-by: Jeff King <peff@peff.net>
---
This one is not technically required.  In my original draft, having it
as a strbuf was helpful, but that didn't make it to the final version.
However, I think it's a worthwhile cleanup on its own, so I left it in.

 remote-curl.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index d524462..7fb092f 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -204,8 +204,8 @@ static struct discovery* discover_refs(const char *service, int for_push)
 	struct strbuf exp = STRBUF_INIT;
 	struct strbuf type = STRBUF_INIT;
 	struct strbuf buffer = STRBUF_INIT;
+	struct strbuf refs_url = STRBUF_INIT;
 	struct discovery *last = last_discovery;
-	char *refs_url;
 	int http_ret, maybe_smart = 0;
 	struct http_get_options options;
 
@@ -213,24 +213,23 @@ static struct discovery* discover_refs(const char *service, int for_push)
 		return last;
 	free_discovery(last);
 
-	strbuf_addf(&buffer, "%sinfo/refs", url);
+	strbuf_addf(&refs_url, "%sinfo/refs", url);
 	if ((!prefixcmp(url, "http://") || !prefixcmp(url, "https://")) &&
 	     git_env_bool("GIT_SMART_HTTP", 1)) {
 		maybe_smart = 1;
 		if (!strchr(url, '?'))
-			strbuf_addch(&buffer, '?');
+			strbuf_addch(&refs_url, '?');
 		else
-			strbuf_addch(&buffer, '&');
-		strbuf_addf(&buffer, "service=%s", service);
+			strbuf_addch(&refs_url, '&');
+		strbuf_addf(&refs_url, "service=%s", service);
 	}
-	refs_url = strbuf_detach(&buffer, NULL);
 
 	memset(&options, 0, sizeof(options));
 	options.content_type = &type;
 	options.no_cache = 1;
 	options.keep_error = 1;
 
-	http_ret = http_get_strbuf(refs_url, &buffer, &options);
+	http_ret = http_get_strbuf(refs_url.buf, &buffer, &options);
 	switch (http_ret) {
 	case HTTP_OK:
 		break;
@@ -283,7 +282,7 @@ static struct discovery* discover_refs(const char *service, int for_push)
 	else
 		last->refs = parse_info_refs(last);
 
-	free(refs_url);
+	strbuf_release(&refs_url);
 	strbuf_release(&exp);
 	strbuf_release(&type);
 	strbuf_release(&buffer);
-- 
1.8.4.rc3.19.g9da5bf6
