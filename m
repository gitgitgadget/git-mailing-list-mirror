From: Jeff King <peff@peff.net>
Subject: [PATCH 13/14] remote-curl: resume interrupted bundle transfers
Date: Thu, 10 Nov 2011 02:53:53 -0500
Message-ID: <20111110075353.GM27950@sigill.intra.peff.net>
References: <20111110074330.GA27925@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 08:54:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROPST-00050k-3v
	for gcvg-git-2@lo.gmane.org; Thu, 10 Nov 2011 08:54:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755136Ab1KJHx5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Nov 2011 02:53:57 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38933
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751335Ab1KJHx4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2011 02:53:56 -0500
Received: (qmail 22606 invoked by uid 107); 10 Nov 2011 07:53:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 10 Nov 2011 02:53:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Nov 2011 02:53:53 -0500
Content-Disposition: inline
In-Reply-To: <20111110074330.GA27925@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185211>

If we have a bundle file from a previous fetch that matches
this URL, then we should resume the transfer where we left
off.

Signed-off-by: Jeff King <peff@peff.net>
---
The second half of the diff is hard to read because I re-indent a big
chunk. It's much easier to see what's going on with "diff -b".

 remote-curl.c |   64 +++++++++++++++++++++++++++++++++++++++++++++++---------
 1 files changed, 53 insertions(+), 11 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 6b0820e..43ad1b6 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -9,6 +9,7 @@
 #include "sideband.h"
 #include "bundle.h"
 #include "progress.h"
+#include "dir.h"
 
 static struct remote *remote;
 static const char *url; /* always ends with a trailing slash */
@@ -171,6 +172,32 @@ static int get_refs_from_url(const char *url, struct strbuf *out, int options,
 	return ret;
 }
 
+static int resume_bundle(const char *url, const char *tmpname)
+{
+	struct get_refs_cb_data data;
+	int ret;
+
+	data.fh = fopen(tmpname, "ab");
+	if (!data.fh)
+		die_errno("unable to open %s", tmpname);
+
+	data.is_bundle = 1;
+	data.total = ftell(data.fh);
+	if (options.progress) {
+		data.progress = start_progress("Resuming bundle", 0);
+		display_progress(data.progress, 0);
+		display_throughput(data.progress, data.total);
+	}
+
+	ret = http_get_callback(url, get_refs_callback, &data, data.total, 0);
+
+	if (fclose(data.fh))
+		die_errno("unable to write to %s", tmpname);
+	stop_progress(&data.progress);
+
+	return ret;
+}
+
 static const char *url_to_bundle_tmpfile(const char *url)
 {
 	struct strbuf buf = STRBUF_INIT;
@@ -210,20 +237,35 @@ static int get_refs_from_url(const char *url, struct strbuf *out, int options,
 	free_discovery(last);
 
 	filename = url_to_bundle_tmpfile(url);
+	if (file_exists(filename)) {
+		struct strbuf trimmed = STRBUF_INIT;
 
-	strbuf_addf(&buffer, "%sinfo/refs", url);
-	if (!prefixcmp(url, "http://") || !prefixcmp(url, "https://")) {
-		is_http = 1;
-		if (!strchr(url, '?'))
-			strbuf_addch(&buffer, '?');
-		else
-			strbuf_addch(&buffer, '&');
-		strbuf_addf(&buffer, "service=%s", service);
+		strbuf_addstr(&trimmed, url);
+		while (trimmed.len > 0 && trimmed.buf[trimmed.len-1] == '/')
+			strbuf_setlen(&trimmed, trimmed.len - 1);
+		refs_url = strbuf_detach(&trimmed, NULL);
+
+		http_ret = resume_bundle(refs_url, filename);
+		is_bundle = 1;
 	}
-	refs_url = strbuf_detach(&buffer, NULL);
+	else
+		http_ret = HTTP_MISSING_TARGET;
+
+	if (http_ret != HTTP_OK && http_ret != HTTP_NOAUTH) {
+		strbuf_addf(&buffer, "%sinfo/refs", url);
+		if (!prefixcmp(url, "http://") || !prefixcmp(url, "https://")) {
+			is_http = 1;
+			if (!strchr(url, '?'))
+				strbuf_addch(&buffer, '?');
+			else
+				strbuf_addch(&buffer, '&');
+			strbuf_addf(&buffer, "service=%s", service);
+		}
+		refs_url = strbuf_detach(&buffer, NULL);
 
-	http_ret = get_refs_from_url(refs_url, &buffer, HTTP_NO_CACHE,
-				     filename, &is_bundle);
+		http_ret = get_refs_from_url(refs_url, &buffer, HTTP_NO_CACHE,
+					     filename, &is_bundle);
+	}
 
 	/* try again with "plain" url (no ? or & appended) */
 	if (http_ret != HTTP_OK && http_ret != HTTP_NOAUTH) {
-- 
1.7.7.2.7.g9f96f
