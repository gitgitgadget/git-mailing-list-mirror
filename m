From: Jeff King <peff@peff.net>
Subject: [PATCH 07/14] bundle: add is_bundle_buf helper
Date: Thu, 10 Nov 2011 02:50:01 -0500
Message-ID: <20111110075001.GG27950@sigill.intra.peff.net>
References: <20111110074330.GA27925@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 08:50:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROPOm-0003I7-5D
	for gcvg-git-2@lo.gmane.org; Thu, 10 Nov 2011 08:50:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933640Ab1KJHuF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Nov 2011 02:50:05 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38921
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933613Ab1KJHuE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2011 02:50:04 -0500
Received: (qmail 22398 invoked by uid 107); 10 Nov 2011 07:50:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 10 Nov 2011 02:50:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Nov 2011 02:50:01 -0500
Content-Disposition: inline
In-Reply-To: <20111110074330.GA27925@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185205>

This is similar to is_bundle, but checks an in-memory buffer
rather than a file. It also works on a partial buffer,
checking only the bundle signature. This means the result is
a three-way conditional: yes, no, or "we do not have enough
data yet".

Signed-off-by: Jeff King <peff@peff.net>
---
 bundle.c |   14 ++++++++++++++
 bundle.h |    1 +
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/bundle.c b/bundle.c
index e48fe2f..6f911bc 100644
--- a/bundle.c
+++ b/bundle.c
@@ -122,6 +122,20 @@ int is_bundle(const char *path, int quiet)
 	return (fd >= 0);
 }
 
+int is_bundle_buf(const char *s, int len)
+{
+	if (len > strlen(bundle_signature))
+		len = strlen(bundle_signature);
+	/* If we don't match what we already have, then definitely not. */
+	if (memcmp(s, bundle_signature, len))
+		return 0;
+	/* If we have enough bytes, we can say yes */
+	if (len == strlen(bundle_signature))
+		return 1;
+	/* otherwise, we can only say "maybe" */
+	return -1;
+}
+
 static int list_refs(struct ref_list *r, int argc, const char **argv)
 {
 	int i;
diff --git a/bundle.h b/bundle.h
index 675cc97..8bec44d 100644
--- a/bundle.h
+++ b/bundle.h
@@ -15,6 +15,7 @@ struct bundle_header {
 };
 
 int is_bundle(const char *path, int quiet);
+int is_bundle_buf(const char *s, int len);
 int read_bundle_header(const char *path, struct bundle_header *header);
 int create_bundle(struct bundle_header *header, const char *path,
 		int argc, const char **argv);
-- 
1.7.7.2.7.g9f96f
