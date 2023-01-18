Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B40DC32793
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 20:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjARUrA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 15:47:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjARUq7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 15:46:59 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E5D4673E
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 12:46:58 -0800 (PST)
Received: (qmail 3394 invoked by uid 109); 18 Jan 2023 20:46:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 18 Jan 2023 20:46:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25049 invoked by uid 111); 18 Jan 2023 20:46:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 18 Jan 2023 15:46:59 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 18 Jan 2023 15:46:57 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [RFC/PATCH 0/6] hash-object: use fsck to check objects
Message-ID: <Y8hawZj9st0jN4dr@coredump.intra.peff.net>
References: <Y8hX+pIZUKXsyYj5@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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

That would look something like this:

diff --git a/fsck.c b/fsck.c
index c2c8facd2d..d220276bcb 100644
--- a/fsck.c
+++ b/fsck.c
@@ -898,6 +898,7 @@ int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
 {
 	int ret = 0;
 	char *eol;
+	const char *eob = buffer + size;
 	struct strbuf sb = STRBUF_INIT;
 	const char *p;
 
@@ -960,10 +961,8 @@ int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
 	}
 	else
 		ret = fsck_ident(&buffer, oid, OBJ_TAG, options);
-	if (!*buffer)
-		goto done;
 
-	if (!starts_with(buffer, "\n")) {
+	if (buffer != eob && *buffer != '\n') {
 		/*
 		 * The verify_headers() check will allow
 		 * e.g. "[...]tagger <tagger>\nsome

Changing the starts_with() is not strictly necessary, but I think it
makes it more clear that we are only going to look at the one character
we confirmed is still valid inside the buffer.

This is enough to have the whole test suite pass with ASan/UBSan after
my series. But as I said earlier, I'd want to look carefully at the rest
of the fsck code to make sure there aren't any other possible inputs
that could look past the end of the buffer.

-Peff
