From: Jeff King <peff@peff.net>
Subject: [PATCH 10/14] remote-curl: try base $URL after $URL/info/refs
Date: Thu, 10 Nov 2011 02:51:18 -0500
Message-ID: <20111110075118.GJ27950@sigill.intra.peff.net>
References: <20111110074330.GA27925@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 08:51:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROPPy-0003t3-1i
	for gcvg-git-2@lo.gmane.org; Thu, 10 Nov 2011 08:51:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933611Ab1KJHvV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Nov 2011 02:51:21 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38927
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933608Ab1KJHvV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2011 02:51:21 -0500
Received: (qmail 22522 invoked by uid 107); 10 Nov 2011 07:51:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 10 Nov 2011 02:51:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Nov 2011 02:51:18 -0500
Content-Disposition: inline
In-Reply-To: <20111110074330.GA27925@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185208>

When fetching via http, we will try "$URL/info/refs" to get
the list of refs. We may get an unexpected bundle from that
transfer, and we already handle that case. But we should
also check just "$URL" to see if it's a bundle.

Signed-off-by: Jeff King <peff@peff.net>
---
And now we can actually test with apache.

 remote-curl.c          |   19 +++++++++++++++++++
 t/t5552-http-bundle.sh |   36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 0 deletions(-)
 create mode 100755 t/t5552-http-bundle.sh

diff --git a/remote-curl.c b/remote-curl.c
index 84586e0..7734495 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -222,6 +222,25 @@ static int get_refs_from_url(const char *url, struct strbuf *out, int options,
 					     filename, &is_bundle);
 	}
 
+	/* try the straight URL for a bundle, but don't impact the
+	 * error reporting that happens below. */
+	if (http_ret != HTTP_OK && http_ret != HTTP_NOAUTH) {
+		struct strbuf trimmed = STRBUF_INIT;
+		int r;
+
+		strbuf_reset(&buffer);
+
+		strbuf_addstr(&trimmed, url);
+		while (trimmed.len > 0 && trimmed.buf[trimmed.len-1] == '/')
+			strbuf_setlen(&trimmed, trimmed.len - 1);
+
+		r = get_refs_from_url(trimmed.buf, &buffer, 0, filename,
+				      &is_bundle);
+		if (r == HTTP_OK && is_bundle)
+			http_ret = r;
+		strbuf_release(&trimmed);
+	}
+
 	switch (http_ret) {
 	case HTTP_OK:
 		break;
diff --git a/t/t5552-http-bundle.sh b/t/t5552-http-bundle.sh
new file mode 100755
index 0000000..8527403
--- /dev/null
+++ b/t/t5552-http-bundle.sh
@@ -0,0 +1,36 @@
+#!/bin/sh
+
+test_description='test fetching from http-accessible bundles'
+. ./test-lib.sh
+
+LIB_HTTPD_PORT=${LIB_HTTPD_PORT-'5552'}
+. "$TEST_DIRECTORY"/lib-httpd.sh
+start_httpd
+
+test_expect_success 'create bundles' '
+	test_commit one &&
+	git bundle create "$HTTPD_DOCUMENT_ROOT_PATH/one.bundle" --all &&
+	test_commit two &&
+	git bundle create "$HTTPD_DOCUMENT_ROOT_PATH/two.bundle" --all ^one
+'
+
+test_expect_success 'clone from bundle' '
+	git clone --bare $HTTPD_URL/one.bundle clone &&
+	echo one >expect &&
+	git --git-dir=clone log -1 --format=%s >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'fetch from bundle' '
+	git --git-dir=clone fetch $HTTPD_URL/two.bundle refs/*:refs/* &&
+	echo two >expect &&
+	git --git-dir=clone log -1 --format=%s >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'cannot clone from partial bundle' '
+	test_must_fail git clone $HTTPD_URL/two.bundle
+'
+
+stop_httpd
+test_done
-- 
1.7.7.2.7.g9f96f
