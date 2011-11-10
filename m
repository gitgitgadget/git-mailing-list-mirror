From: Jeff King <peff@peff.net>
Subject: [PATCH 05/14] remote-curl: use http callback for requesting refs
Date: Thu, 10 Nov 2011 02:49:44 -0500
Message-ID: <20111110074944.GE27950@sigill.intra.peff.net>
References: <20111110074330.GA27925@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 08:49:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROPOQ-00035a-Jf
	for gcvg-git-2@lo.gmane.org; Thu, 10 Nov 2011 08:49:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933632Ab1KJHtr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Nov 2011 02:49:47 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38917
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933628Ab1KJHtq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2011 02:49:46 -0500
Received: (qmail 22342 invoked by uid 107); 10 Nov 2011 07:49:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 10 Nov 2011 02:49:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Nov 2011 02:49:44 -0500
Content-Disposition: inline
In-Reply-To: <20111110074330.GA27925@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185203>

This should behave identically to the current strbuf code,
but opens up room for us to do more clever things with
bundles in a future patch.

Signed-off-by: Jeff King <peff@peff.net>
---
Obviously it's way more code for the same thing, but future patches will
make the design more clear.

 remote-curl.c |   22 ++++++++++++++++++++--
 1 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 0e720ee..fb4d853 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -90,6 +90,24 @@ static void free_discovery(struct discovery *d)
 	}
 }
 
+struct get_refs_cb_data {
+	struct strbuf *out;
+};
+
+static size_t get_refs_callback(char *buf, size_t sz, size_t n, void *vdata)
+{
+	struct get_refs_cb_data *data = vdata;
+	strbuf_add(data->out, buf, sz * n);
+	return sz * n;
+}
+
+static int get_refs_from_url(const char *url, struct strbuf *out, int options)
+{
+	struct get_refs_cb_data data;
+	data.out = out;
+	return http_get_callback(url, get_refs_callback, &data, 0, options);
+}
+
 static struct discovery* discover_refs(const char *service)
 {
 	struct strbuf buffer = STRBUF_INIT;
@@ -112,7 +130,7 @@ static void free_discovery(struct discovery *d)
 	}
 	refs_url = strbuf_detach(&buffer, NULL);
 
-	http_ret = http_get_strbuf(refs_url, &buffer, HTTP_NO_CACHE);
+	http_ret = get_refs_from_url(refs_url, &buffer, HTTP_NO_CACHE);
 
 	/* try again with "plain" url (no ? or & appended) */
 	if (http_ret != HTTP_OK && http_ret != HTTP_NOAUTH) {
@@ -123,7 +141,7 @@ static void free_discovery(struct discovery *d)
 		strbuf_addf(&buffer, "%sinfo/refs", url);
 		refs_url = strbuf_detach(&buffer, NULL);
 
-		http_ret = http_get_strbuf(refs_url, &buffer, HTTP_NO_CACHE);
+		http_ret = get_refs_from_url(refs_url, &buffer, HTTP_NO_CACHE);
 	}
 
 	switch (http_ret) {
-- 
1.7.7.2.7.g9f96f
