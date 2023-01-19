Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF354C678D6
	for <git@archiver.kernel.org>; Thu, 19 Jan 2023 01:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjASB6I (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 20:58:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjASB6B (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 20:58:01 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFC13EC5E
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 17:57:57 -0800 (PST)
Received: (qmail 5611 invoked by uid 109); 19 Jan 2023 01:57:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 19 Jan 2023 01:57:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27951 invoked by uid 111); 19 Jan 2023 01:57:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 18 Jan 2023 20:57:59 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 18 Jan 2023 20:57:56 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH] hash-object: fix descriptor leak with --literally
Message-ID: <Y8ijpJqtkDTi792i@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In hash_object(), we open a descriptor for each file to hash (whether we
got the filename from the command line or --stdin-paths), but never
close it. For the traditional code path which feeds the result to
index_fd(), this is OK; it closes the descriptor for us.

But 5ba9a93b39 (hash-object: add --literally option, 2014-09-11) a
second code path which does not close the descriptor. There we need to
do so ourselves.

You can see the problem in a clone of git.git like this:

  $ git ls-files -s | grep ^100644 | cut -f2 |
    git hash-object --stdin-paths --literally >/dev/null
  fatal: could not open 'builtin/var.c' for reading: Too many open files

After this patch, it completes successfully. I didn't bother with a
test, as it's a pain to deal with descriptor limits portably, and the
fix is so trivial.

Signed-off-by: Jeff King <peff@peff.net>
---
Something I ran into while testing my hash-object fsck series, but I
broke it off here because it's really an independent bug-fix.

I do think the world would be less confusing if index_fd() didn't close
the descriptor we pass it, and then hash_file() could just do:

  fd = open();
  hash_fd(fd);
  close(fd);

which is much more readable. But it has many other callers. So even if
we wanted to untangle all that, I think it makes sense to do this
obvious fix in the meantime.

 builtin/hash-object.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index b506381502..44db83f07f 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -27,6 +27,7 @@ static int hash_literally(struct object_id *oid, int fd, const char *type, unsig
 	else
 		ret = write_object_file_literally(buf.buf, buf.len, type, oid,
 						 flags);
+	close(fd);
 	strbuf_release(&buf);
 	return ret;
 }
-- 
2.39.1.616.gd06fca9e99
