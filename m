Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6DDC54EE9
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 19:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbiI0Ti2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 15:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbiI0Ti1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 15:38:27 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F36F15311A
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 12:38:26 -0700 (PDT)
Received: (qmail 377 invoked by uid 109); 27 Sep 2022 19:38:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 27 Sep 2022 19:38:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21537 invoked by uid 111); 27 Sep 2022 19:38:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Sep 2022 15:38:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 27 Sep 2022 15:38:25 -0400
From:   Jeff King <peff@peff.net>
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2] tmp-objdir: skip clean up when handling a signal
Message-ID: <YzNRMbaM40i/6tPa@coredump.intra.peff.net>
References: <pull.1348.git.git.1664236383785.gitgitgadget@gmail.com>
 <pull.1348.v2.git.git.1664306341425.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1348.v2.git.git.1664306341425.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 27, 2022 at 07:19:01PM +0000, John Cai via GitGitGadget wrote:

> Since we can't do the cleanup in a portable and signal-safe way, skip
> the cleanup when we're handling a signal.

Thanks, this looks fine to me, though I think there are a few extra
cleanup opportunities that could be squashed in:

diff --git a/tmp-objdir.c b/tmp-objdir.c
index 5d5f15f6d7..2fb0ec8317 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -18,7 +18,7 @@ struct tmp_objdir {
 
 /*
  * Allow only one tmp_objdir at a time in a running process, which simplifies
- * our signal/atexit cleanup routines.  It's doubtful callers will ever need
+ * our atexit cleanup routine.  It's doubtful callers will ever need
  * more than one, and we can expand later if so.  You can have many such
  * tmp_objdirs simultaneously in many processes, of course.
  */
@@ -31,7 +31,7 @@ static void tmp_objdir_free(struct tmp_objdir *t)
 	free(t);
 }
 
-static int tmp_objdir_destroy_1(struct tmp_objdir *t)
+static int tmp_objdir_destroy(struct tmp_objdir *t)
 {
 	int err;
 
@@ -44,23 +44,13 @@ static int tmp_objdir_destroy_1(struct tmp_objdir *t)
 	if (t->prev_odb)
 		restore_primary_odb(t->prev_odb, t->path.buf);
 
-	/*
-	 * This may use malloc via strbuf_grow(), but we should
-	 * have pre-grown t->path sufficiently so that this
-	 * doesn't happen in practice.
-	 */
 	err = remove_dir_recursively(&t->path, 0);
 
 	tmp_objdir_free(t);
 
 	return err;
 }
 
-int tmp_objdir_destroy(struct tmp_objdir *t)
-{
-	return tmp_objdir_destroy_1(t);
-}
-
 static void remove_tmp_objdir(void)
 {
 	tmp_objdir_destroy(the_tmp_objdir);
@@ -139,14 +129,6 @@ struct tmp_objdir *tmp_objdir_create(const char *prefix)
 	 */
 	strbuf_addf(&t->path, "%s/tmp_objdir-%s-XXXXXX", get_object_directory(), prefix);
 
-	/*
-	 * Grow the strbuf beyond any filename we expect to be placed in it.
-	 * If tmp_objdir_destroy() is called by a signal handler, then
-	 * we should be able to use the strbuf to remove files without
-	 * having to call malloc.
-	 */
-	strbuf_grow(&t->path, 1024);
-
 	if (!mkdtemp(t->path.buf)) {
 		/* free, not destroy, as we never touched the filesystem */
 		tmp_objdir_free(t);
