Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF8FC677F1
	for <git@archiver.kernel.org>; Thu, 19 Jan 2023 01:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjASBs1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 20:48:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjASBpl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 20:45:41 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F12F23309
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 17:39:56 -0800 (PST)
Received: (qmail 5596 invoked by uid 109); 19 Jan 2023 01:39:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 19 Jan 2023 01:39:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27834 invoked by uid 111); 19 Jan 2023 01:39:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 18 Jan 2023 20:39:58 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 18 Jan 2023 20:39:55 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [RFC/PATCH 0/6] hash-object: use fsck to check objects
Message-ID: <Y8ifa7hyqxSbL92U@coredump.intra.peff.net>
References: <Y8hX+pIZUKXsyYj5@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y8hX+pIZUKXsyYj5@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 18, 2023 at 03:35:06PM -0500, Jeff King wrote:

> The other option is having the fsck code avoid looking past the size it
> was given. I think the intent is that this should work, from commits
> like 4d0d89755e (Make sure fsck_commit_buffer() does not run out of the
> buffer, 2014-09-11). We do use skip_prefix() and parse_oid_hex(), which
> won't respect the size, but I think[1] that's OK because we'll have
> parsed up to the end-of-header beforehand (and those functions would
> never match past there).
> 
> Which would mean that 9a1a3a4d4c (mktag: allow omitting the header/body
> \n separator, 2021-01-05) and acf9de4c94 (mktag: use fsck instead of
> custom verify_tag(), 2021-01-05) were buggy, and we can just fix them.
> 
> [1] But I said "I think" above because it can get pretty subtle. There's
>     some more discussion in this thread:
> 
>       https://lore.kernel.org/git/20150625155128.C3E9738005C@gemini.denx.de/
> 
>     but I haven't yet convinced myself it's safe. This is exactly the
>     kind of analysis I wish I had the power to nerd-snipe René into.

I poked at this a bit more, and it definitely isn't safe. I think the
use of skip_prefix(), etc, is OK, because they'd always stop at an
unexpected newline. But verify_headers() is only confirming that we have
a series of complete lines, and we might end with no "\n\n" (and hence
no commit/tag message). And so the obvious case that fools us is one
where the data simply ends at a newline, but we are missing one or more
headers. So a truncated commit like:

  tree 1234567890123456789012345678901234567890

(with the newline at the end of the "tree" line, but nothing else) will
cause fsck_commit() to look past the "size" we pass it. With all of the
current callers, that means it sees a NUL and bails. So it's not
currently a bug, but it becomes one if we can feed it arbitrary buffers.

Fixing it isn't _too_ bad, and could look something like this:

diff --git a/fsck.c b/fsck.c
index c2c8facd2d..3f0bb3e350 100644
--- a/fsck.c
+++ b/fsck.c
@@ -834,6 +834,7 @@ static int fsck_commit(const struct object_id *oid,
 	unsigned author_count;
 	int err;
 	const char *buffer_begin = buffer;
+	const char *buffer_end = buffer + size;
 	const char *p;
 
 	if (verify_headers(buffer, size, oid, OBJ_COMMIT, options))
@@ -847,7 +848,7 @@ static int fsck_commit(const struct object_id *oid,
 			return err;
 	}
 	buffer = p + 1;
-	while (skip_prefix(buffer, "parent ", &buffer)) {
+	while (buffer < buffer_end && skip_prefix(buffer, "parent ", &buffer)) {
 		if (parse_oid_hex(buffer, &parent_oid, &p) || *p != '\n') {
 			err = report(options, oid, OBJ_COMMIT, FSCK_MSG_BAD_PARENT_SHA1, "invalid 'parent' line format - bad sha1");
 			if (err)
@@ -856,7 +857,7 @@ static int fsck_commit(const struct object_id *oid,
 		buffer = p + 1;
 	}
 	author_count = 0;
-	while (skip_prefix(buffer, "author ", &buffer)) {
+	while (buffer < buffer_end && skip_prefix(buffer, "author ", &buffer)) {
 		author_count++;
 		err = fsck_ident(&buffer, oid, OBJ_COMMIT, options);
 		if (err)
@@ -868,7 +869,7 @@ static int fsck_commit(const struct object_id *oid,
 		err = report(options, oid, OBJ_COMMIT, FSCK_MSG_MULTIPLE_AUTHORS, "invalid format - multiple 'author' lines");
 	if (err)
 		return err;
-	if (!skip_prefix(buffer, "committer ", &buffer))
+	if (buffer >= buffer_end || !skip_prefix(buffer, "committer ", &buffer))
 		return report(options, oid, OBJ_COMMIT, FSCK_MSG_MISSING_COMMITTER, "invalid format - expected 'committer' line");
 	err = fsck_ident(&buffer, oid, OBJ_COMMIT, options);
 	if (err)

And then the tag side would need something similar. I'd probably also
sprinkle some comments in verify_headers() and its callers documenting
our assumptions and what's OK to do (string-like parsing functions work
as long as they stop when they hit a newline). That, plus a few tests
covering the problematic cases to avoid regressions, would probably be
OK.

I think fsck_tree() is mostly fine, as the tree-iterating code detects
truncation. Though I do find the use of strlen() in decode_tree_entry()
a little suspicious (and that would be true of the current code, as
well, since it powers hash-object's existing parsing check).

-Peff
