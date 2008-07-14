Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=0.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: (qmail 4689 invoked by uid 111); 14 Jul 2008 02:08:31 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 13 Jul 2008 22:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753842AbYGNCH6 (ORCPT <rfc822;peff@peff.net>);
	Sun, 13 Jul 2008 22:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753709AbYGNCH5
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 22:07:57 -0400
Received: from george.spearce.org ([209.20.77.23]:36319 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753685AbYGNCHy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 22:07:54 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id F0DDC383A6; Mon, 14 Jul 2008 02:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 4CEDE383A4;
	Mon, 14 Jul 2008 02:07:49 +0000 (UTC)
From:	"Shawn O. Pearce" <spearce@spearce.org>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org, Stephan Hennig <mailing_list@arcor.de>,
	Nicolas Pitre <nico@cam.org>, Andreas Ericsson <ae@op5.se>
Subject: [PATCH 4/4] index-pack: Honor core.deltaBaseCacheLimit when resolving deltas
Date:	Sun, 13 Jul 2008 22:07:47 -0400
Message-Id: <1216001267-33235-5-git-send-email-spearce@spearce.org>
X-Mailer: git-send-email 1.5.6.2.393.g45096
In-Reply-To: <1216001267-33235-4-git-send-email-spearce@spearce.org>
References: <1216001267-33235-1-git-send-email-spearce@spearce.org>
 <1216001267-33235-2-git-send-email-spearce@spearce.org>
 <1216001267-33235-3-git-send-email-spearce@spearce.org>
 <1216001267-33235-4-git-send-email-spearce@spearce.org>
In-Reply-To: <20080713011512.GB31050@spearce.org>
References: <20080713011512.GB31050@spearce.org>
To:	Junio C Hamano <gitster@pobox.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org
X-Old-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4

If we are trying to resolve deltas for a long delta chain composed
of multi-megabyte objects we can easily run into requiring 500M+
of memory to hold each object in the chain on the call stack while
we recurse into the dependent objects and resolve them.

We now use a simple delta cache that discards objects near the
bottom of the call stack first, as they are the most least recently
used objects in this current delta chain.  If we recurse out of a
chain we may find the base object is no longer available, as it was
free'd to keep memory under the deltaBaseCacheLimit.  In such cases
we must unpack the base object again, which will require recursing
back to the root of the top of the delta chain as we released that
root first.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 index-pack.c |   43 +++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/index-pack.c b/index-pack.c
index 7239e89..84c9fc1 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -52,6 +52,7 @@ struct delta_entry
 static struct object_entry *objects;
 static struct delta_entry *deltas;
 static struct base_data *base_cache;
+static size_t base_cache_used;
 static int nr_objects;
 static int nr_deltas;
 static int nr_resolved_deltas;
@@ -220,6 +221,20 @@ static void bad_object(unsigned long offset, const char *format, ...)
 	die("pack has bad object at offset %lu: %s", offset, buf);
 }
 
+static void prune_base_data(void)
+{
+	struct base_data *b = base_cache;
+	for (b = base_cache;
+	     base_cache_used > delta_base_cache_limit && b && b->child;
+	     b = b->child) {
+		if (b->data) {
+			free(b->data);
+			b->data = NULL;
+			base_cache_used -= b->size;
+		}
+	}
+}
+
 static void link_base_data(struct base_data *base, struct base_data *c)
 {
 	if (base)
@@ -229,6 +244,8 @@ static void link_base_data(struct base_data *base, struct base_data *c)
 
 	c->base = base;
 	c->child = NULL;
+	base_cache_used += c->size;
+	prune_base_data();
 }
 
 static void unlink_base_data(struct base_data *c)
@@ -238,7 +255,10 @@ static void unlink_base_data(struct base_data *c)
 		base->child = NULL;
 	else
 		base_cache = NULL;
-	free(c->data);
+	if (c->data) {
+		free(c->data);
+		base_cache_used -= c->size;
+	}
 }
 
 static void *unpack_entry_data(unsigned long offset, unsigned long size)
@@ -456,6 +476,25 @@ static void sha1_object(const void *data, unsigned long size,
 	}
 }
 
+static void *get_base_data(struct base_data *c)
+{
+	if (!c->data) {
+		struct object_entry *obj = c->obj;
+		void *raw = get_data_from_pack(obj);
+		if (obj->type == OBJ_REF_DELTA || obj->type == OBJ_OFS_DELTA) {
+			c->data = patch_delta(
+				get_base_data(c->base), c->base->size,
+				raw, obj->size,
+				&c->size);
+			free(raw);
+			if (!c->data)
+				bad_object(obj->idx.offset, "failed to apply delta");
+		} else
+			c->data = raw;
+	}
+	return c->data;
+}
+
 static void resolve_delta(struct object_entry *delta_obj,
 			  struct base_data *base_obj, enum object_type type)
 {
@@ -468,7 +507,7 @@ static void resolve_delta(struct object_entry *delta_obj,
 	delta_obj->real_type = type;
 	delta_data = get_data_from_pack(delta_obj);
 	delta_size = delta_obj->size;
-	result.data = patch_delta(base_obj->data, base_obj->size,
+	result.data = patch_delta(get_base_data(base_obj), base_obj->size,
 			     delta_data, delta_size,
 			     &result.size);
 	free(delta_data);
-- 
1.5.6.2.393.g45096

