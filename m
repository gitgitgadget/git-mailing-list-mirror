From: Jeff King <peff@peff.net>
Subject: [PATCH 12/14] remote-curl: show progress for bundle downloads
Date: Thu, 10 Nov 2011 02:53:12 -0500
Message-ID: <20111110075312.GL27950@sigill.intra.peff.net>
References: <20111110074330.GA27925@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 08:53:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROPRn-0004hW-VU
	for gcvg-git-2@lo.gmane.org; Thu, 10 Nov 2011 08:53:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757360Ab1KJHxQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Nov 2011 02:53:16 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38931
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752570Ab1KJHxP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2011 02:53:15 -0500
Received: (qmail 22578 invoked by uid 107); 10 Nov 2011 07:53:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 10 Nov 2011 02:53:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Nov 2011 02:53:12 -0500
Content-Disposition: inline
In-Reply-To: <20111110074330.GA27925@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185210>

Generally, the point of fetching from a bundle is that it's
big. Without a progress meter, git will appear to hang
during the long download.

This patch adds a throughput meter (i.e., just the bytes
transferred and the rate). In the long run, we should look
for a content-length header from the server so we can show a
total size and completion percentage. However, displaying
that properly will require some surgery to the progress
code, so let's leave it as a future enhancement.

Signed-off-by: Jeff King <peff@peff.net>
---
 remote-curl.c |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 7734495..6b0820e 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -8,6 +8,7 @@
 #include "pkt-line.h"
 #include "sideband.h"
 #include "bundle.h"
+#include "progress.h"
 
 static struct remote *remote;
 static const char *url; /* always ends with a trailing slash */
@@ -107,6 +108,9 @@ struct get_refs_cb_data {
 	int is_bundle;
 	const char *tmpname;
 	FILE *fh;
+
+	struct progress *progress;
+	off_t total;
 };
 
 static size_t get_refs_callback(char *buf, size_t sz, size_t n, void *vdata)
@@ -114,8 +118,11 @@ static size_t get_refs_callback(char *buf, size_t sz, size_t n, void *vdata)
 	struct get_refs_cb_data *data = vdata;
 	struct strbuf *out = data->out;
 
-	if (data->is_bundle > 0)
+	if (data->is_bundle > 0) {
+		data->total += sz * n;
+		display_throughput(data->progress, data->total);
 		return fwrite(buf, sz, n, data->fh);
+	}
 
 	strbuf_add(out, buf, sz * n);
 
@@ -129,6 +136,12 @@ static size_t get_refs_callback(char *buf, size_t sz, size_t n, void *vdata)
 			die_errno("unable to open %s", data->tmpname);
 		if (fwrite(out->buf, 1, out->len, data->fh) < out->len)
 			die_errno("unable to write to %s", data->tmpname);
+		if (options.progress) {
+			data->total = out->len;
+			data->progress = start_progress("Downloading bundle", 0);
+			display_progress(data->progress, 0);
+			display_throughput(data->progress, data->total);
+		}
 	}
 	return sz * n;
 }
@@ -143,6 +156,8 @@ static int get_refs_from_url(const char *url, struct strbuf *out, int options,
 	data.is_bundle = -1;
 	data.tmpname = tmpname;
 	data.fh = NULL;
+	data.progress = NULL;
+	data.total = 0;
 
 	ret = http_get_callback(url, get_refs_callback, &data, 0, options);
 
@@ -150,6 +165,7 @@ static int get_refs_from_url(const char *url, struct strbuf *out, int options,
 		if (fclose(data.fh))
 			die_errno("unable to write to %s", data.tmpname);
 	}
+	stop_progress(&data.progress);
 
 	*is_bundle = data.is_bundle > 0;
 	return ret;
-- 
1.7.7.2.7.g9f96f
