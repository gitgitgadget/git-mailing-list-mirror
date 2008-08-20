From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] decorate: allow const objects to be decorated
Date: Wed, 20 Aug 2008 13:55:33 -0400
Message-ID: <20080820175532.GA32005@sigill.intra.peff.net>
References: <20080820175325.GD27773@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "MichaelTiloDressel@t-online.de" <MichaelTiloDressel@t-online.de>
X-From: git-owner@vger.kernel.org Wed Aug 20 19:56:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVrvD-0003Ak-Ta
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 19:56:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752222AbYHTRzg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 13:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751884AbYHTRzg
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 13:55:36 -0400
Received: from peff.net ([208.65.91.99]:1914 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751477AbYHTRzf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 13:55:35 -0400
Received: (qmail 25489 invoked by uid 111); 20 Aug 2008 17:55:34 -0000
Received: from lawn-128-61-25-158.lawn.gatech.edu (HELO sigill.intra.peff.net) (128.61.25.158)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 20 Aug 2008 13:55:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Aug 2008 13:55:33 -0400
Content-Disposition: inline
In-Reply-To: <20080820175325.GD27773@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93003>

We don't actually modify the struct object, so there is no
reason not to accept const versions (and this allows other
callsites, like the next patch, to use the decoration
machinery).

Signed-off-by: Jeff King <peff@peff.net>
---
This one is hopefully a no-brainer, and is required for the next patch.

 decorate.c |   11 ++++++-----
 decorate.h |    6 +++---
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/decorate.c b/decorate.c
index d9668d2..82d9e22 100644
--- a/decorate.c
+++ b/decorate.c
@@ -6,13 +6,13 @@
 #include "object.h"
 #include "decorate.h"
 
-static unsigned int hash_obj(struct object *obj, unsigned int n)
+static unsigned int hash_obj(const struct object *obj, unsigned int n)
 {
 	unsigned int hash = *(unsigned int *)obj->sha1;
 	return hash % n;
 }
 
-static void *insert_decoration(struct decoration *n, struct object *base, void *decoration)
+static void *insert_decoration(struct decoration *n, const struct object *base, void *decoration)
 {
 	int size = n->size;
 	struct object_decoration *hash = n->hash;
@@ -44,7 +44,7 @@ static void grow_decoration(struct decoration *n)
 	n->nr = 0;
 
 	for (i = 0; i < old_size; i++) {
-		struct object *base = old_hash[i].base;
+		const struct object *base = old_hash[i].base;
 		void *decoration = old_hash[i].decoration;
 
 		if (!base)
@@ -55,7 +55,8 @@ static void grow_decoration(struct decoration *n)
 }
 
 /* Add a decoration pointer, return any old one */
-void *add_decoration(struct decoration *n, struct object *obj, void *decoration)
+void *add_decoration(struct decoration *n, const struct object *obj,
+		void *decoration)
 {
 	int nr = n->nr + 1;
 
@@ -65,7 +66,7 @@ void *add_decoration(struct decoration *n, struct object *obj, void *decoration)
 }
 
 /* Lookup a decoration pointer */
-void *lookup_decoration(struct decoration *n, struct object *obj)
+void *lookup_decoration(struct decoration *n, const struct object *obj)
 {
 	int j;
 
diff --git a/decorate.h b/decorate.h
index 1fa4ad9..e732804 100644
--- a/decorate.h
+++ b/decorate.h
@@ -2,7 +2,7 @@
 #define DECORATE_H
 
 struct object_decoration {
-	struct object *base;
+	const struct object *base;
 	void *decoration;
 };
 
@@ -12,7 +12,7 @@ struct decoration {
 	struct object_decoration *hash;
 };
 
-extern void *add_decoration(struct decoration *n, struct object *obj, void *decoration);
-extern void *lookup_decoration(struct decoration *n, struct object *obj);
+extern void *add_decoration(struct decoration *n, const struct object *obj, void *decoration);
+extern void *lookup_decoration(struct decoration *n, const struct object *obj);
 
 #endif
-- 
1.6.0.90.g00a5c.dirty
