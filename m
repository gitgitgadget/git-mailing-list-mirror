Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5D7EDE99C
	for <git@archiver.kernel.org>; Thu, 14 Sep 2023 09:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237585AbjINJmX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Sep 2023 05:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237181AbjINJmJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2023 05:42:09 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A3C59E2
        for <git@vger.kernel.org>; Thu, 14 Sep 2023 02:39:49 -0700 (PDT)
Received: (qmail 27321 invoked by uid 109); 14 Sep 2023 09:39:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 14 Sep 2023 09:39:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21299 invoked by uid 111); 14 Sep 2023 09:39:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 14 Sep 2023 05:39:51 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 14 Sep 2023 05:39:48 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH 1/4] merge-ort: drop custom err() function
Message-ID: <20230914093948.GA2254894@coredump.intra.peff.net>
References: <20230914093409.GA2254811@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230914093409.GA2254811@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The merge-ort code has an err() function, but it's really just error()
in disguise. It differs in two ways:

  1. It takes a "struct merge_options" argument. But the function
     completely ignores it! We can simply remove it.

  2. It formats the error string into a strbuf, prepending "error: ",
     and then feeds the result into error(). But this is wrong! The
     error() function already adds the prefix, so we end up with:

        error: error: Failed to execute internal merge

So let's just drop this function entirely and call error() directly, as
the functions are otherwise identical (note that they both always return
-1).

Presumably nobody noticed the bogus messages because they are quite hard
to trigger (they are mostly internal errors reading and writing
objects). However, one easy trigger is a custom merge driver which dies
by signal; we have a test already here, but we were not checking the
contents of stderr.

Signed-off-by: Jeff King <peff@peff.net>
---
A few of these messages starts with capital letters, which is unlike our
usual error message style. I didn't clean that up here. We could do so
on top, but I actually wonder if some of these ought to be using
path_msg() and continuing instead, to give output closer to other
conflict or error cases (e.g., conflicts caused by missing submodule
objects). But I dunno. I guess these are all more clearly "woah,
something is totally wrong" that we do not expect to happen, so it
probably isn't a big deal to just abort.

 merge-ort.c           | 28 +++++-----------------------
 t/t6406-merge-attr.sh |  3 ++-
 2 files changed, 7 insertions(+), 24 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 8631c99700..027ecc7f78 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -721,23 +721,6 @@ static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
 	renames->callback_data_nr = renames->callback_data_alloc = 0;
 }
 
-__attribute__((format (printf, 2, 3)))
-static int err(struct merge_options *opt, const char *err, ...)
-{
-	va_list params;
-	struct strbuf sb = STRBUF_INIT;
-
-	strbuf_addstr(&sb, "error: ");
-	va_start(params, err);
-	strbuf_vaddf(&sb, err, params);
-	va_end(params);
-
-	error("%s", sb.buf);
-	strbuf_release(&sb);
-
-	return -1;
-}
-
 static void format_commit(struct strbuf *sb,
 			  int indent,
 			  struct repository *repo,
@@ -2122,13 +2105,12 @@ static int handle_content_merge(struct merge_options *opt,
 					  &result_buf);
 
 		if ((merge_status < 0) || !result_buf.ptr)
-			ret = err(opt, _("Failed to execute internal merge"));
+			ret = error(_("Failed to execute internal merge"));
 
 		if (!ret &&
 		    write_object_file(result_buf.ptr, result_buf.size,
 				      OBJ_BLOB, &result->oid))
-			ret = err(opt, _("Unable to add %s to database"),
-				  path);
+			ret = error(_("Unable to add %s to database"), path);
 
 		free(result_buf.ptr);
 		if (ret)
@@ -3518,10 +3500,10 @@ static int read_oid_strbuf(struct merge_options *opt,
 	unsigned long size;
 	buf = repo_read_object_file(the_repository, oid, &type, &size);
 	if (!buf)
-		return err(opt, _("cannot read object %s"), oid_to_hex(oid));
+		return error(_("cannot read object %s"), oid_to_hex(oid));
 	if (type != OBJ_BLOB) {
 		free(buf);
-		return err(opt, _("object %s is not a blob"), oid_to_hex(oid));
+		return error(_("object %s is not a blob"), oid_to_hex(oid));
 	}
 	strbuf_attach(dst, buf, size, size + 1);
 	return 0;
@@ -4973,7 +4955,7 @@ static void merge_ort_nonrecursive_internal(struct merge_options *opt,
 		 * TRANSLATORS: The %s arguments are: 1) tree hash of a merge
 		 * base, and 2-3) the trees for the two trees we're merging.
 		 */
-		err(opt, _("collecting merge info failed for trees %s, %s, %s"),
+		error(_("collecting merge info failed for trees %s, %s, %s"),
 		    oid_to_hex(&merge_base->object.oid),
 		    oid_to_hex(&side1->object.oid),
 		    oid_to_hex(&side2->object.oid));
diff --git a/t/t6406-merge-attr.sh b/t/t6406-merge-attr.sh
index 9677180a5b..05ad13b23e 100755
--- a/t/t6406-merge-attr.sh
+++ b/t/t6406-merge-attr.sh
@@ -179,7 +179,8 @@ test_expect_success !WINDOWS 'custom merge driver that is killed with a signal'
 
 	>./please-abort &&
 	echo "* merge=custom" >.gitattributes &&
-	test_must_fail git merge main &&
+	test_must_fail git merge main 2>err &&
+	grep "^error: Failed to execute internal merge" err &&
 	git ls-files -u >output &&
 	git diff --name-only HEAD >>output &&
 	test_must_be_empty output
-- 
2.42.0.628.g8a27295885

