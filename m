Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEEEC38A2D
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 21:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiJUVmv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 17:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiJUVmu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 17:42:50 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970462A79C9
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 14:42:49 -0700 (PDT)
Received: (qmail 14441 invoked by uid 109); 21 Oct 2022 21:42:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 21 Oct 2022 21:42:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16435 invoked by uid 111); 21 Oct 2022 21:42:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Oct 2022 17:42:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 21 Oct 2022 17:42:48 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jan =?utf-8?Q?Pokorn=C3=BD?= <poki@fnusa.cz>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 1/4] repack: convert "names" util bitfield to array
Message-ID: <Y1MSWAx+baTklfLL@coredump.intra.peff.net>
References: <Y1MR7V8kGolLd8eh@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y1MR7V8kGolLd8eh@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We keep a string_list "names" containing the hashes of packs generated
on our behalf by pack-objects. The util field of each item is treated as
a bitfield that tells us which extensions (.pack, .idx, .rev, etc) are
present for each name.

Let's switch this to allocating a real array. That will give us room in
a future patch to store more data than just a single bit per extension.
And it makes the code a little easier to read, as we avoid casting back
and forth between uintptr_t and a void pointer.

Since the only thing we're storing is an array, we could just allocate
it directly. But instead I've put it into a named struct here. That
further increases readability around the casts, and in particular helps
differentiate us from other string_lists in the same file which use
their util field differently. E.g., the existing_*_packs lists still do
bit-twiddling, but their bits have different meaning than the ones in
"names". This makes it hard to grep around the code to see how the util
fields are used; now you can look for "generated_pack_data".

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/repack.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index a5bacc7797..8e71230bf7 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -247,11 +247,15 @@ static struct {
 	{".idx"},
 };
 
-static unsigned populate_pack_exts(char *name)
+struct generated_pack_data {
+	char exts[ARRAY_SIZE(exts)];
+};
+
+static struct generated_pack_data *populate_pack_exts(const char *name)
 {
 	struct stat statbuf;
 	struct strbuf path = STRBUF_INIT;
-	unsigned ret = 0;
+	struct generated_pack_data *data = xcalloc(1, sizeof(*data));
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(exts); i++) {
@@ -261,11 +265,11 @@ static unsigned populate_pack_exts(char *name)
 		if (stat(path.buf, &statbuf))
 			continue;
 
-		ret |= (1 << i);
+		data->exts[i] = 1;
 	}
 
 	strbuf_release(&path);
-	return ret;
+	return data;
 }
 
 static void repack_promisor_objects(const struct pack_objects_args *args,
@@ -320,7 +324,7 @@ static void repack_promisor_objects(const struct pack_objects_args *args,
 					  line.buf);
 		write_promisor_file(promisor_name, NULL, 0);
 
-		item->util = (void *)(uintptr_t)populate_pack_exts(item->string);
+		item->util = populate_pack_exts(item->string);
 
 		free(promisor_name);
 	}
@@ -994,7 +998,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	string_list_sort(&names);
 
 	for_each_string_list_item(item, &names) {
-		item->util = (void *)(uintptr_t)populate_pack_exts(item->string);
+		item->util = populate_pack_exts(item->string);
 	}
 
 	close_object_store(the_repository->objects);
@@ -1003,6 +1007,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	 * Ok we have prepared all new packfiles.
 	 */
 	for_each_string_list_item(item, &names) {
+		struct generated_pack_data *data = item->util;
+
 		for (ext = 0; ext < ARRAY_SIZE(exts); ext++) {
 			char *fname, *fname_old;
 
@@ -1011,7 +1017,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 			fname_old = mkpathdup("%s-%s%s",
 					packtmp, item->string, exts[ext].name);
 
-			if (((uintptr_t)item->util) & ((uintptr_t)1 << ext)) {
+			if (data->exts[ext]) {
 				struct stat statbuffer;
 				if (!stat(fname_old, &statbuffer)) {
 					statbuffer.st_mode &= ~(S_IWUSR | S_IWGRP | S_IWOTH);
@@ -1115,7 +1121,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		write_midx_file(get_object_directory(), NULL, NULL, flags);
 	}
 
-	string_list_clear(&names, 0);
+	string_list_clear(&names, 1);
 	string_list_clear(&existing_nonkept_packs, 0);
 	string_list_clear(&existing_kept_packs, 0);
 	clear_pack_geometry(geometry);
-- 
2.38.1.496.ga614b0e9bd

