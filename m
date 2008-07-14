Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=0.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: (qmail 4652 invoked by uid 111); 14 Jul 2008 02:08:15 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 13 Jul 2008 22:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753742AbYGNCHy (ORCPT <rfc822;peff@peff.net>);
	Sun, 13 Jul 2008 22:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753620AbYGNCHy
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 22:07:54 -0400
Received: from george.spearce.org ([209.20.77.23]:36310 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753557AbYGNCHv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 22:07:51 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 1F2CB38419; Mon, 14 Jul 2008 02:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 663AD383A4;
	Mon, 14 Jul 2008 02:07:48 +0000 (UTC)
From:	"Shawn O. Pearce" <spearce@spearce.org>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org, Stephan Hennig <mailing_list@arcor.de>,
	Nicolas Pitre <nico@cam.org>, Andreas Ericsson <ae@op5.se>
Subject: [PATCH 2/4] index-pack: Chain the struct base_data on the stack for traversal
Date:	Sun, 13 Jul 2008 22:07:45 -0400
Message-Id: <1216001267-33235-3-git-send-email-spearce@spearce.org>
X-Mailer: git-send-email 1.5.6.2.393.g45096
In-Reply-To: <1216001267-33235-2-git-send-email-spearce@spearce.org>
References: <1216001267-33235-1-git-send-email-spearce@spearce.org>
 <1216001267-33235-2-git-send-email-spearce@spearce.org>
In-Reply-To: <20080713011512.GB31050@spearce.org>
References: <20080713011512.GB31050@spearce.org>
To:	Junio C Hamano <gitster@pobox.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org
X-Old-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4

We need to release earlier inflated base objects when memory gets
low, which means we need to be able to walk up or down the stack
to locate the objects we want to release, and free their data.

The new link/unlink routines allow inserting and removing the struct
base_data during recursion inside resolve_delta, and the global
base_cache gives us the head of the chain (bottom of the stack)
so we can traverse it.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 index-pack.c |   34 +++++++++++++++++++++++++++++++---
 1 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/index-pack.c b/index-pack.c
index db03478..6c59fd3 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -27,6 +27,8 @@ union delta_base {
 };
 
 struct base_data {
+	struct base_data *base;
+	struct base_data *child;
 	void *data;
 	unsigned long size;
 };
@@ -48,6 +50,7 @@ struct delta_entry
 
 static struct object_entry *objects;
 static struct delta_entry *deltas;
+static struct base_data *base_cache;
 static int nr_objects;
 static int nr_deltas;
 static int nr_resolved_deltas;
@@ -216,6 +219,27 @@ static void bad_object(unsigned long offset, const char *format, ...)
 	die("pack has bad object at offset %lu: %s", offset, buf);
 }
 
+static void link_base_data(struct base_data *base, struct base_data *c)
+{
+	if (base)
+		base->child = c;
+	else
+		base_cache = c;
+
+	c->base = base;
+	c->child = NULL;
+}
+
+static void unlink_base_data(struct base_data *c)
+{
+	struct base_data *base = c->base;
+	if (base)
+		base->child = NULL;
+	else
+		base_cache = NULL;
+	free(c->data);
+}
+
 static void *unpack_entry_data(unsigned long offset, unsigned long size)
 {
 	z_stream stream;
@@ -452,6 +476,8 @@ static void resolve_delta(struct object_entry *delta_obj,
 	sha1_object(result.data, result.size, type, delta_obj->idx.sha1);
 	nr_resolved_deltas++;
 
+	link_base_data(base_obj, &result);
+
 	hashcpy(delta_base.sha1, delta_obj->idx.sha1);
 	if (!find_delta_children(&delta_base, &first, &last)) {
 		for (j = first; j <= last; j++) {
@@ -471,7 +497,7 @@ static void resolve_delta(struct object_entry *delta_obj,
 		}
 	}
 
-	free(result.data);
+	unlink_base_data(&result);
 }
 
 static int compare_delta_entry(const void *a, const void *b)
@@ -562,6 +588,7 @@ static void parse_pack_objects(unsigned char *sha1)
 			continue;
 		base_obj.data = get_data_from_pack(obj);
 		base_obj.size = obj->size;
+		link_base_data(NULL, &base_obj);
 
 		if (ref)
 			for (j = ref_first; j <= ref_last; j++) {
@@ -575,7 +602,7 @@ static void parse_pack_objects(unsigned char *sha1)
 				if (child->real_type == OBJ_OFS_DELTA)
 					resolve_delta(child, &base_obj, obj->type);
 			}
-		free(base_obj.data);
+		unlink_base_data(&base_obj);
 		display_progress(progress, nr_resolved_deltas);
 	}
 }
@@ -670,6 +697,7 @@ static void fix_unresolved_deltas(int nr_unresolved)
 		base_obj.data = read_sha1_file(d->base.sha1, &type, &base_obj.size);
 		if (!base_obj.data)
 			continue;
+		link_base_data(NULL, &base_obj);
 
 		find_delta_children(&d->base, &first, &last);
 		for (j = first; j <= last; j++) {
@@ -683,7 +711,7 @@ static void fix_unresolved_deltas(int nr_unresolved)
 			die("local object %s is corrupt", sha1_to_hex(d->base.sha1));
 		append_obj_to_pack(d->base.sha1, base_obj.data,
 			base_obj.size, type);
-		free(base_obj.data);
+		unlink_base_data(&base_obj);
 		display_progress(progress, nr_resolved_deltas);
 	}
 	free(sorted_by_pos);
-- 
1.5.6.2.393.g45096

