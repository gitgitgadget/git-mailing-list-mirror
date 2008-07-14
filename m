Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=0.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: (qmail 4670 invoked by uid 111); 14 Jul 2008 02:08:24 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 13 Jul 2008 22:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753646AbYGNCH4 (ORCPT <rfc822;peff@peff.net>);
	Sun, 13 Jul 2008 22:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753739AbYGNCHz
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 22:07:55 -0400
Received: from george.spearce.org ([209.20.77.23]:36315 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753646AbYGNCHw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 22:07:52 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 791573841A; Mon, 14 Jul 2008 02:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id D809A3836B;
	Mon, 14 Jul 2008 02:07:48 +0000 (UTC)
From:	"Shawn O. Pearce" <spearce@spearce.org>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org, Stephan Hennig <mailing_list@arcor.de>,
	Nicolas Pitre <nico@cam.org>, Andreas Ericsson <ae@op5.se>
Subject: [PATCH 3/4] index-pack: Track the object_entry that creates each base_data
Date:	Sun, 13 Jul 2008 22:07:46 -0400
Message-Id: <1216001267-33235-4-git-send-email-spearce@spearce.org>
X-Mailer: git-send-email 1.5.6.2.393.g45096
In-Reply-To: <1216001267-33235-3-git-send-email-spearce@spearce.org>
References: <1216001267-33235-1-git-send-email-spearce@spearce.org>
 <1216001267-33235-2-git-send-email-spearce@spearce.org>
 <1216001267-33235-3-git-send-email-spearce@spearce.org>
In-Reply-To: <20080713011512.GB31050@spearce.org>
References: <20080713011512.GB31050@spearce.org>
To:	Junio C Hamano <gitster@pobox.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org
X-Old-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4

If we free the data stored within a base_data we need the struct
object_entry to get the data back again for use with another
dependent delta.  Storing the object_entry* makes it simple to call
get_data_from_pack() to recover the compressed information.

This however means we must add the missing baes object to the end
of our packfile prior to calling resolve_delta() on each of the
dependent deltas.  Adding the base first ensures we can read the
base back from the pack we indexing, as if it had been included by
the remote side.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 index-pack.c |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/index-pack.c b/index-pack.c
index 6c59fd3..7239e89 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -29,6 +29,7 @@ union delta_base {
 struct base_data {
 	struct base_data *base;
 	struct base_data *child;
+	struct object_entry *obj;
 	void *data;
 	unsigned long size;
 };
@@ -476,6 +477,7 @@ static void resolve_delta(struct object_entry *delta_obj,
 	sha1_object(result.data, result.size, type, delta_obj->idx.sha1);
 	nr_resolved_deltas++;
 
+	result.obj = delta_obj;
 	link_base_data(base_obj, &result);
 
 	hashcpy(delta_base.sha1, delta_obj->idx.sha1);
@@ -588,6 +590,7 @@ static void parse_pack_objects(unsigned char *sha1)
 			continue;
 		base_obj.data = get_data_from_pack(obj);
 		base_obj.size = obj->size;
+		base_obj.obj = obj;
 		link_base_data(NULL, &base_obj);
 
 		if (ref)
@@ -633,7 +636,8 @@ static int write_compressed(int fd, void *in, unsigned int size, uint32_t *obj_c
 	return size;
 }
 
-static void append_obj_to_pack(const unsigned char *sha1, void *buf,
+static struct object_entry *append_obj_to_pack(
+			       const unsigned char *sha1, void *buf,
 			       unsigned long size, enum object_type type)
 {
 	struct object_entry *obj = &objects[nr_objects++];
@@ -654,6 +658,7 @@ static void append_obj_to_pack(const unsigned char *sha1, void *buf,
 	obj[1].idx.offset = obj[0].idx.offset + n;
 	obj[1].idx.offset += write_compressed(output_fd, buf, size, &obj[0].idx.crc32);
 	hashcpy(obj->idx.sha1, sha1);
+	return obj;
 }
 
 static int delta_pos_compare(const void *_a, const void *_b)
@@ -697,6 +702,12 @@ static void fix_unresolved_deltas(int nr_unresolved)
 		base_obj.data = read_sha1_file(d->base.sha1, &type, &base_obj.size);
 		if (!base_obj.data)
 			continue;
+
+		if (check_sha1_signature(d->base.sha1, base_obj.data,
+				base_obj.size, typename(type)))
+			die("local object %s is corrupt", sha1_to_hex(d->base.sha1));
+		base_obj.obj = append_obj_to_pack(d->base.sha1, base_obj.data,
+			base_obj.size, type);
 		link_base_data(NULL, &base_obj);
 
 		find_delta_children(&d->base, &first, &last);
@@ -706,11 +717,6 @@ static void fix_unresolved_deltas(int nr_unresolved)
 				resolve_delta(child, &base_obj, type);
 		}
 
-		if (check_sha1_signature(d->base.sha1, base_obj.data,
-				base_obj.size, typename(type)))
-			die("local object %s is corrupt", sha1_to_hex(d->base.sha1));
-		append_obj_to_pack(d->base.sha1, base_obj.data,
-			base_obj.size, type);
 		unlink_base_data(&base_obj);
 		display_progress(progress, nr_resolved_deltas);
 	}
-- 
1.5.6.2.393.g45096

