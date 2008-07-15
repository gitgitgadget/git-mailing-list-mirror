From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v2] index-pack: Honor core.deltaBaseCacheLimit when
	resolving deltas
Date: Tue, 15 Jul 2008 04:45:34 +0000
Message-ID: <20080715044534.GA2794@spearce.org>
References: <20080715031800.GD1700@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>,
	Stephan Hennig <mailing_list@arcor.de>,
	Andreas Ericsson <ae@op5.se>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 06:47:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIcRp-0000rM-Vn
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 06:47:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751631AbYGOEpg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 00:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbYGOEpf
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 00:45:35 -0400
Received: from george.spearce.org ([209.20.77.23]:60217 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751446AbYGOEpf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 00:45:35 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id BE30D383A4; Tue, 15 Jul 2008 04:45:34 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080715031800.GD1700@spearce.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88520>

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

The astute reader will probably realize that we can still exceed
the delta base cache limit, but this happens only if the most
recent base plus the delta plus the inflated dependent sum up to
more than the base cache limit.  Due to the way patch_delta is
currently implemented we cannot operate in less memory anyway.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 Version 2 plugs the case Nico noticed, where the patch was causing
 the exact behavior it was trying to prevent while recovering from
 what it did to avoid the excessive memory usage in the first place.

 The change was in get_base_data() where we now unpack the delta
 after we have unpacked the base.  Nico and I both missed that we
 must also bump base_cache_used when we restore the base, and we
 must also prune the bases in case this base has caused us to go
 over the limit.

 :-)

 index-pack.c |   48 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/index-pack.c b/index-pack.c
index 7239e89..b4ec736 100644
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
 
+static void prune_base_data(struct base_data *retain)
+{
+	struct base_data *b = base_cache;
+	for (b = base_cache;
+	     base_cache_used > delta_base_cache_limit && b;
+	     b = b->child) {
+		if (b->data && b != retain) {
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
+	prune_base_data(c);
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
@@ -456,6 +476,30 @@ static void sha1_object(const void *data, unsigned long size,
 	}
 }
 
+static void *get_base_data(struct base_data *c)
+{
+	if (!c->data) {
+		struct object_entry *obj = c->obj;
+
+		if (obj->type == OBJ_REF_DELTA || obj->type == OBJ_OFS_DELTA) {
+			void *base = get_base_data(c->base);
+			void *raw = get_data_from_pack(obj);
+			c->data = patch_delta(
+				base, c->base->size,
+				raw, obj->size,
+				&c->size);
+			free(raw);
+			if (!c->data)
+				bad_object(obj->idx.offset, "failed to apply delta");
+		} else
+			c->data = get_data_from_pack(obj);
+
+		base_cache_used += c->size;
+		prune_base_data(c);
+	}
+	return c->data;
+}
+
 static void resolve_delta(struct object_entry *delta_obj,
 			  struct base_data *base_obj, enum object_type type)
 {
@@ -468,7 +512,7 @@ static void resolve_delta(struct object_entry *delta_obj,
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
