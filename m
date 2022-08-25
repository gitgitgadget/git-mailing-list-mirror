Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301A5C04AA5
	for <git@archiver.kernel.org>; Thu, 25 Aug 2022 10:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240597AbiHYKFA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Aug 2022 06:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240526AbiHYKE6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2022 06:04:58 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D27B2603
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 03:04:54 -0700 (PDT)
Received: (qmail 14050 invoked by uid 109); 25 Aug 2022 10:04:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 25 Aug 2022 10:04:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27685 invoked by uid 111); 25 Aug 2022 10:04:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 25 Aug 2022 06:04:56 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 25 Aug 2022 06:04:53 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2022, #08; Wed, 24)
Message-ID: <YwdJRRuST2SP8ZT7@coredump.intra.peff.net>
References: <xmqqa67s5275.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa67s5275.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 24, 2022 at 10:20:30PM -0700, Junio C Hamano wrote:

> * sy/mv-out-of-cone (2022-08-10) 9 commits
>   (merged to 'next' on 2022-08-17 at 2316d9ce4d)
>  + mv: check overwrite for in-to-out move
>  + advice.h: add advise_on_moving_dirty_path()
>  + mv: cleanup empty WORKING_DIRECTORY
>  + mv: from in-cone to out-of-cone
>  + mv: remove BOTH from enum update_mode
>  + mv: check if <destination> is a SKIP_WORKTREE_DIR
>  + mv: free the with_slash in check_dir_in_index()
>  + mv: rename check_dir_in_index() to empty_dir_has_sparse_contents()
>  + t7002: add tests for moving from in-cone to out-of-cone
> 
>  "git mv A B" in a sparsely populated working tree can be asked to
>  move a path from a directory that is "in cone" to another directory
>  that is "out of cone".  Handling of such a case has been improved.
> 
>  Will merge to 'master'.
>  source: <20220809120910.2021413-1-shaoxuan.yuan02@gmail.com>

This topic (and now 'next') segfaults with SANITIZE=address in t7001.
The problem is running:

  git mv path1/path2/ .

The "." in the destination is normalized to the empty string by
internal_prefix_pathspec(). But commit c08830de41 (mv: check if
<destination> is a SKIP_WORKTREE_DIR, 2022-08-09) then calls add_slash()
on the result, and it isn't prepared to see an empty string.

This makes the problem go away:

diff --git a/builtin/mv.c b/builtin/mv.c
index 11aea7b4db..6c6385dbb5 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -72,7 +72,7 @@ static const char **internal_prefix_pathspec(const char *prefix,
 static const char *add_slash(const char *path)
 {
 	size_t len = strlen(path);
-	if (path[len - 1] != '/') {
+	if (len && path[len - 1] != '/') {
 		char *with_slash = xmalloc(st_add(len, 2));
 		memcpy(with_slash, path, len);
 		with_slash[len++] = '/';

but I didn't follow the topic well enough to know if there's anything
subtle (i.e., I'm not sure why we need the slash in the first place, and
whether "./" would be more appropriate, etc). So punting to folks who
were involved. :)

-Peff
