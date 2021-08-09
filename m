Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FC4C4338F
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 22:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60A0760FE3
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 22:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236292AbhHIWtC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Aug 2021 18:49:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:42862 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229944AbhHIWtB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Aug 2021 18:49:01 -0400
Received: (qmail 3829 invoked by uid 109); 9 Aug 2021 22:48:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 09 Aug 2021 22:48:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2974 invoked by uid 111); 9 Aug 2021 22:48:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Aug 2021 18:48:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 9 Aug 2021 18:48:39 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 2/3] range-diff: handle unterminated lines in read_patches()
Message-ID: <YRGwx5gkIXYyzMsm@coredump.intra.peff.net>
References: <YRGwGDvOte/o9vkd@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YRGwGDvOte/o9vkd@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When parsing our buffer of output from git-log, we have a
find_end_of_line() helper that finds the next newline, and gives us the
number of bytes to move past it, or the size of the whole remaining
buffer if there is no newline.

But trying to handle both those cases leads to some oddities:

  - we try to overwrite the newline with NUL in the caller, by writing
    over line[len-1]. This is at best redundant, since the helper will
    already have done so if it saw a newline. But if it didn't see a
    newline, it's actively wrong; we'll overwrite the byte at the end of
    the (unterminated) line.

    We could solve this just dropping the extra NUL assignment in the
    caller and just letting the helper do the right thing. But...

  - if we see a "diff --git" line, we'll restore the newline on top of
    the NUL byte, so we can pass the string to parse_git_diff_header().
    But if there was no newline in the first place, we can't do this.
    There's no place to put it (the current code writes a newline
    over whatever byte we obliterated earlier). The best we can do is
    feed the complete remainder of the buffer to the function (which is,
    in fact, a string, by virtue of being a strbuf).

To solve this, the caller needs to know whether we actually found a
newline or not. We could modify find_end_of_line() to return that
information, but we can further observe that it has only one caller.
So let's just inline it in that caller.

Nobody seems to have noticed this case, probably because git-log would
never produce input that doesn't end with a newline. Arguably we could
just return an error as soon as we see that the output does not end in a
newline. But the code to do so actually ends up _longer_, mostly because
of the cleanup we have to do in handling the error.

Signed-off-by: Jeff King <peff@peff.net>
---
I had initially hoped to just delete the redundant line, but the details
and the explanation got surprisingly tricky (especially for something
that we don't expect to see in practice anyway). Sorry. :)

 range-diff.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/range-diff.c b/range-diff.c
index 551600c774..088db1b1ce 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -26,17 +26,6 @@ struct patch_util {
 	struct object_id oid;
 };
 
-static size_t find_end_of_line(char *buffer, unsigned long size)
-{
-	char *eol = memchr(buffer, '\n', size);
-
-	if (!eol)
-		return size;
-
-	*eol = '\0';
-	return eol + 1 - buffer;
-}
-
 /*
  * Reads the patches into a string list, with the `util` field being populated
  * as struct object_id (will need to be free()d).
@@ -88,9 +77,16 @@ static int read_patches(const char *range, struct string_list *list,
 	size = contents.len;
 	for (; size > 0; size -= len, line += len) {
 		const char *p;
+		char *eol;
+
+		eol = memchr(line, '\n', size);
+		if (eol) {
+			*eol = '\0';
+			len = eol + 1 - line;
+		} else {
+			len = size;
+		}
 
-		len = find_end_of_line(line, size);
-		line[len - 1] = '\0';
 		if (skip_prefix(line, "commit ", &p)) {
 			if (util) {
 				string_list_append(list, buf.buf)->util = util;
@@ -132,7 +128,8 @@ static int read_patches(const char *range, struct string_list *list,
 			strbuf_addch(&buf, '\n');
 			if (!util->diff_offset)
 				util->diff_offset = buf.len;
-			line[len - 1] = '\n';
+			if (eol)
+				*eol = '\n';
 			orig_len = len;
 			len = parse_git_diff_header(&root, &linenr, 0, line,
 						    len, size, &patch);
-- 
2.33.0.rc1.475.g023efe0ae4

