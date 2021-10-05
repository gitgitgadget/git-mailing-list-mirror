Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BA2C433F5
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 20:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E37861423
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 20:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbhJEUj6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Oct 2021 16:39:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:33356 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235134AbhJEUj4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Oct 2021 16:39:56 -0400
Received: (qmail 17644 invoked by uid 109); 5 Oct 2021 20:38:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 05 Oct 2021 20:38:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6560 invoked by uid 111); 5 Oct 2021 20:38:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 05 Oct 2021 16:38:04 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 5 Oct 2021 16:38:04 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 5/5] cat-file: use packed_object_info() for
 --batch-all-objects
Message-ID: <YVy3rPuUal0+9iJs@coredump.intra.peff.net>
References: <YVy1sx8Xb1xMLFQT@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YVy1sx8Xb1xMLFQT@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When "cat-file --batch-all-objects" iterates over each object, it knows
where to find each one. But when we look up details of the object, we
don't use that information at all.

This patch teaches it to use the pack/offset pair when we're iterating
over objects in a pack. This yields a measurable speed improvement
(timings on a fully packed clone of linux.git):

  Benchmark #1: ./git.old cat-file --batch-all-objects --unordered --batch-check="%(objecttype) %(objectname)"
    Time (mean ± σ):      8.128 s ±  0.118 s    [User: 7.968 s, System: 0.156 s]
    Range (min … max):    8.007 s …  8.301 s    10 runs

  Benchmark #2: ./git.new cat-file --batch-all-objects --unordered --batch-check="%(objecttype) %(objectname)"
    Time (mean ± σ):      4.294 s ±  0.064 s    [User: 4.167 s, System: 0.125 s]
    Range (min … max):    4.227 s …  4.457 s    10 runs

  Summary
    './git.new cat-file --batch-all-objects --unordered --batch-check="%(objecttype) %(objectname)"' ran
      1.89 ± 0.04 times faster than './git.old cat-file --batch-all-objects --unordered --batch-check="%(objecttype) %(objectname)"

The implementation is pretty simple: we just call packed_object_info()
instead of oid_object_info_extended() when we can. Most of the changes
are just plumbing the pack/offset pair through the callstack. There is
one subtlety: replace lookups are not handled by packed_object_info().
But since those are disabled for --batch-all-objects, and since we'll
only have pack info when that option is in effect, we don't have to
worry about that.

There are a few limitations to this optimization which we could address
with further work:

 - I didn't bother recording when we found an object loose. Technically
   this could save us doing a fruitless lookup in the pack index. But
   opening and mmap-ing a loose object is so expensive in the first
   place that this doesn't matter much. And if your repository is large
   enough to care about per-object performance, most objects are going
   to be packed anyway.

 - This works only in --unordered mode. For the sorted mode, we'd have
   to record the pack/offset pair as part of our oid-collection. That's
   more code, plus at least 16 extra bytes of heap per object. It would
   probably still be a net win in runtime, but we'd need to measure.

 - For --batch, this still helps us with getting the object metadata,
   but we still do a from-scratch lookup for the object contents. This
   probably doesn't matter that much, because the lookup cost will be
   much smaller relative to the cost of actually unpacking and printing
   the objects.

   For small objects, we could probably swap out read_object_file() for
   using packed_object_info() with a "object_info.contentp" to get the
   contents. But we'd still need to deal with streaming for larger
   objects. A better path forward here is to teach the initial
   oid_object_info_extended() / packed_object_info() calls to retrieve
   the contents of smaller objects while they are already being
   accessed. That would save the extra lookup entirely. But it's a
   non-trivial feature to add to the object_info code, so I left it for
   now.

Signed-off-by: Jeff King <peff@peff.net>
---
I have some patches for the "give me the content in a single call if
it's small" idea, but they need some polishing. It also doesn't produce
as spectacular a speedup as I'd hoped, which is why I threw it on the
back burner. I think it's just because actually dealing with the object
content is so much more expensive than an extra lookup.

 builtin/cat-file.c | 45 +++++++++++++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 14 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index b533935d5c..219ff5628d 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -358,15 +358,26 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
 static void batch_object_write(const char *obj_name,
 			       struct strbuf *scratch,
 			       struct batch_options *opt,
-			       struct expand_data *data)
+			       struct expand_data *data,
+			       struct packed_git *pack,
+			       off_t offset)
 {
-	if (!data->skip_object_info &&
-	    oid_object_info_extended(the_repository, &data->oid, &data->info,
-				     OBJECT_INFO_LOOKUP_REPLACE) < 0) {
-		printf("%s missing\n",
-		       obj_name ? obj_name : oid_to_hex(&data->oid));
-		fflush(stdout);
-		return;
+	if (!data->skip_object_info) {
+		int ret;
+
+		if (pack)
+			ret = packed_object_info(the_repository, pack, offset,
+						 &data->info);
+		else
+			ret = oid_object_info_extended(the_repository,
+						       &data->oid, &data->info,
+						       OBJECT_INFO_LOOKUP_REPLACE);
+		if (ret < 0) {
+			printf("%s missing\n",
+			       obj_name ? obj_name : oid_to_hex(&data->oid));
+			fflush(stdout);
+			return;
+		}
 	}
 
 	strbuf_reset(scratch);
@@ -428,7 +439,7 @@ static void batch_one_object(const char *obj_name,
 		return;
 	}
 
-	batch_object_write(obj_name, scratch, opt, data);
+	batch_object_write(obj_name, scratch, opt, data, NULL, 0);
 }
 
 struct object_cb_data {
@@ -442,7 +453,8 @@ static int batch_object_cb(const struct object_id *oid, void *vdata)
 {
 	struct object_cb_data *data = vdata;
 	oidcpy(&data->expand->oid, oid);
-	batch_object_write(NULL, data->scratch, data->opt, data->expand);
+	batch_object_write(NULL, data->scratch, data->opt, data->expand,
+			   NULL, 0);
 	return 0;
 }
 
@@ -463,31 +475,36 @@ static int collect_packed_object(const struct object_id *oid,
 	return 0;
 }
 
-static int batch_unordered_object(const struct object_id *oid, void *vdata)
+static int batch_unordered_object(const struct object_id *oid,
+				  struct packed_git *pack, off_t offset,
+				  void *vdata)
 {
 	struct object_cb_data *data = vdata;
 
 	if (oidset_insert(data->seen, oid))
 		return 0;
 
 	oidcpy(&data->expand->oid, oid);
-	batch_object_write(NULL, data->scratch, data->opt, data->expand);
+	batch_object_write(NULL, data->scratch, data->opt, data->expand,
+			   pack, offset);
 	return 0;
 }
 
 static int batch_unordered_loose(const struct object_id *oid,
 				 const char *path,
 				 void *data)
 {
-	return batch_unordered_object(oid, data);
+	return batch_unordered_object(oid, NULL, 0, data);
 }
 
 static int batch_unordered_packed(const struct object_id *oid,
 				  struct packed_git *pack,
 				  uint32_t pos,
 				  void *data)
 {
-	return batch_unordered_object(oid, data);
+	return batch_unordered_object(oid, pack,
+				      nth_packed_object_offset(pack, pos),
+				      data);
 }
 
 static int batch_objects(struct batch_options *opt)
-- 
2.33.0.1231.g45ae28b974
