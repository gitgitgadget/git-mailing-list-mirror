From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] refactor refs_from_alternate_cb to allow passing extra
 data
Date: Thu, 19 May 2011 17:33:17 -0400
Message-ID: <20110519213317.GA29793@sigill.intra.peff.net>
References: <20110519213231.GA29702@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 23:33:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNAqS-0005qZ-HN
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 23:33:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934800Ab1ESVdU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 17:33:20 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39443
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932455Ab1ESVdT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2011 17:33:19 -0400
Received: (qmail 21003 invoked by uid 107); 19 May 2011 21:35:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 19 May 2011 17:35:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 May 2011 17:33:17 -0400
Content-Disposition: inline
In-Reply-To: <20110519213231.GA29702@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174011>

The foreach_alt_odb function triggers a callback for each
alternate object db we have, with room for a single void
pointer as data. Currently, we always call refs_from_alternate_cb
as the callback function, and then pass another callback (to
receive each ref individually) as the void pointer.

This has two problems:

  1. C technically forbids stuffing a function pointer into
     a "void *". In practice, this probably doesn't matter
     on any architectures git runs on, but it never hurts to
     follow the letter of the law.

  2. There is no room for an extra data pointer. Indeed, the
     alternate_ref_fn that refs_from_alternate_cb calls
     takes a void* for data, but we always pass it NULL.

Instead, let's properly stuff our function pointer into a
data struct, which also leaves room for an extra
caller-supplied data pointer. And to keep things simple for
existing callers, let's make a for_each_alternate_ref
function that takes care of creating the extra struct.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fetch-pack.c   |    2 +-
 builtin/receive-pack.c |    2 +-
 transport.c            |   20 +++++++++++++++++---
 transport.h            |    2 +-
 4 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 85aff02..60a17c7 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -226,7 +226,7 @@ static void insert_one_alternate_ref(const struct ref *ref, void *unused)
 
 static void insert_alternate_refs(void)
 {
-	foreach_alt_odb(refs_from_alternate_cb, insert_one_alternate_ref);
+	for_each_alternate_ref(insert_one_alternate_ref, NULL);
 }
 
 #define INITIAL_FLUSH 16
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index e1ba4dc..6bb1281 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -738,7 +738,7 @@ static void add_one_alternate_ref(const struct ref *ref, void *unused)
 
 static void add_alternate_refs(void)
 {
-	foreach_alt_odb(refs_from_alternate_cb, add_one_alternate_ref);
+	for_each_alternate_ref(add_one_alternate_ref, NULL);
 }
 
 int cmd_receive_pack(int argc, const char **argv, const char *prefix)
diff --git a/transport.c b/transport.c
index a02f79a..1a3998e 100644
--- a/transport.c
+++ b/transport.c
@@ -1190,14 +1190,20 @@ literal_copy:
 	return xstrdup(url);
 }
 
-int refs_from_alternate_cb(struct alternate_object_database *e, void *cb)
+struct alternate_refs_data {
+	alternate_ref_fn *fn;
+	void *data;
+};
+
+static int refs_from_alternate_cb(struct alternate_object_database *e,
+				  void *data)
 {
 	char *other;
 	size_t len;
 	struct remote *remote;
 	struct transport *transport;
 	const struct ref *extra;
-	alternate_ref_fn *ref_fn = cb;
+	struct alternate_refs_data *cb = data;
 
 	e->name[-1] = '\0';
 	other = xstrdup(real_path(e->base));
@@ -1218,8 +1224,16 @@ int refs_from_alternate_cb(struct alternate_object_database *e, void *cb)
 	for (extra = transport_get_remote_refs(transport);
 	     extra;
 	     extra = extra->next)
-		ref_fn(extra, NULL);
+		cb->fn(extra, cb->data);
 	transport_disconnect(transport);
 	free(other);
 	return 0;
 }
+
+void for_each_alternate_ref(alternate_ref_fn fn, void *data)
+{
+	struct alternate_refs_data cb;
+	cb.fn = fn;
+	cb.data = data;
+	foreach_alt_odb(refs_from_alternate_cb, &cb);
+}
diff --git a/transport.h b/transport.h
index efb1968..161d724 100644
--- a/transport.h
+++ b/transport.h
@@ -167,6 +167,6 @@ void transport_print_push_status(const char *dest, struct ref *refs,
 		  int verbose, int porcelain, int *nonfastforward);
 
 typedef void alternate_ref_fn(const struct ref *, void *);
-extern int refs_from_alternate_cb(struct alternate_object_database *e, void *cb);
+extern void for_each_alternate_ref(alternate_ref_fn, void *);
 
 #endif
-- 
1.7.5.8.ga95ab
