From: Jeff King <peff@peff.net>
Subject: [PATCH 06/14] transport: factor out bundle to ref list conversion
Date: Thu, 10 Nov 2011 02:49:52 -0500
Message-ID: <20111110074952.GF27950@sigill.intra.peff.net>
References: <20111110074330.GA27925@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 08:50:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROPOc-0003Bw-TE
	for gcvg-git-2@lo.gmane.org; Thu, 10 Nov 2011 08:50:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933638Ab1KJHt4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Nov 2011 02:49:56 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38919
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933613Ab1KJHtz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2011 02:49:55 -0500
Received: (qmail 22370 invoked by uid 107); 10 Nov 2011 07:49:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 10 Nov 2011 02:49:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Nov 2011 02:49:52 -0500
Content-Disposition: inline
In-Reply-To: <20111110074330.GA27925@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185204>

There is a data structure mismatch between what the
transport code wants (a linked list of "struct ref") and
what the bundle header provides (an array of ref names and
sha1s), so the transport code has to convert.

Let's factor out this conversion to make it useful to other
transport-ish callers (like remote-curl).

Signed-off-by: Jeff King <peff@peff.net>
---
 bundle.c    |   16 ++++++++++++++++
 bundle.h    |    2 ++
 transport.c |   11 +----------
 3 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/bundle.c b/bundle.c
index 08020bc..e48fe2f 100644
--- a/bundle.c
+++ b/bundle.c
@@ -7,6 +7,7 @@
 #include "list-objects.h"
 #include "run-command.h"
 #include "refs.h"
+#include "remote.h"
 
 static const char bundle_signature[] = "# v2 git bundle\n";
 
@@ -449,3 +450,18 @@ int unbundle(struct bundle_header *header, int bundle_fd, int flags)
 		return error("index-pack died");
 	return 0;
 }
+
+struct ref *bundle_header_to_refs(const struct bundle_header *header)
+{
+	struct ref *result = NULL;
+	int i;
+
+	for (i = 0; i < header->references.nr; i++) {
+		struct ref_list_entry *e = header->references.list + i;
+		struct ref *ref = alloc_ref(e->name);
+		hashcpy(ref->old_sha1, e->sha1);
+		ref->next = result;
+		result = ref;
+	}
+	return result;
+}
diff --git a/bundle.h b/bundle.h
index 1584e4d..675cc97 100644
--- a/bundle.h
+++ b/bundle.h
@@ -24,4 +24,6 @@ int create_bundle(struct bundle_header *header, const char *path,
 int list_bundle_refs(struct bundle_header *header,
 		int argc, const char **argv);
 
+struct ref *bundle_header_to_refs(const struct bundle_header *header);
+
 #endif
diff --git a/transport.c b/transport.c
index 51814b5..5020bbb 100644
--- a/transport.c
+++ b/transport.c
@@ -407,8 +407,6 @@ struct bundle_transport_data {
 static struct ref *get_refs_from_bundle(struct transport *transport, int for_push)
 {
 	struct bundle_transport_data *data = transport->data;
-	struct ref *result = NULL;
-	int i;
 
 	if (for_push)
 		return NULL;
@@ -418,14 +416,7 @@ struct bundle_transport_data {
 	data->fd = read_bundle_header(transport->url, &data->header);
 	if (data->fd < 0)
 		die ("Could not read bundle '%s'.", transport->url);
-	for (i = 0; i < data->header.references.nr; i++) {
-		struct ref_list_entry *e = data->header.references.list + i;
-		struct ref *ref = alloc_ref(e->name);
-		hashcpy(ref->old_sha1, e->sha1);
-		ref->next = result;
-		result = ref;
-	}
-	return result;
+	return bundle_header_to_refs(&data->header);
 }
 
 static int fetch_refs_from_bundle(struct transport *transport,
-- 
1.7.7.2.7.g9f96f
