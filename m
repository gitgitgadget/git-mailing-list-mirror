Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA8CC11F64
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 23:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4443061CFC
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 23:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236585AbhF1XMV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 19:12:21 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:41144 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233868AbhF1XMT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 19:12:19 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 7ECD51F8C6;
        Mon, 28 Jun 2021 23:09:53 +0000 (UTC)
Date:   Mon, 28 Jun 2021 23:09:53 +0000
From:   Eric Wong <e@80x24.org>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/5] make object_directory.loose_objects_subdir_seen a
 bitmap
Message-ID: <20210628230953.GA9830@dcvr>
References: <20210627024718.25383-1-e@80x24.org>
 <20210627024718.25383-4-e@80x24.org>
 <496545dc-e372-401c-13f4-daa7ee765d39@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <496545dc-e372-401c-13f4-daa7ee765d39@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> wrote:
> Am 27.06.21 um 04:47 schrieb Eric Wong:
> Anyway, it would look something like this:
> 
> 	size_t word_bits = bitsizeof(odb->loose_objects_subdir_seen[0]);
> 	size_t word_index = subdir_nr / word_bits;
> 	size_t mask = 1 << (subdir_nr % word_bits);

<snip> yeah, I missed bitsizeof :x

> > --- a/object-store.h
> > +++ b/object-store.h
> > @@ -22,7 +22,7 @@ struct object_directory {
> >  	 *
> >  	 * Be sure to call odb_load_loose_cache() before using.
> >  	 */
> > -	char loose_objects_subdir_seen[256];
> > +	uint32_t loose_objects_subdir_seen[8]; /* 256 bits */
> 
> Perhaps	DIV_ROUND_UP(256, bitsizeof(uint32_t))?  The comment explains
> it nicely already, though.

I think I'll keep my original there...  IMHO the macros
obfuscate the meaning for those less familiar with our codebase
(myself included :x)

> >  	struct oid_array loose_objects_cache[256];
> >
> >  	/*
> >
> 
> Summary: Good idea, the implementation looks correct, I stumbled
> over some of the names, bitsizeof() could be used.

Thanks for the review.

I'll squash up the following for v2 while awaiting feedback
for the rest of the series:

diff --git a/object-file.c b/object-file.c
index d33b84c4a4..6c397fb4f1 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2463,16 +2463,17 @@ struct oidtree *odb_loose_cache(struct object_directory *odb,
 {
 	int subdir_nr = oid->hash[0];
 	struct strbuf buf = STRBUF_INIT;
-	size_t BM_SIZE = sizeof(odb->loose_objects_subdir_seen[0]) * CHAR_BIT;
+	size_t word_bits = bitsizeof(odb->loose_objects_subdir_seen[0]);
+	size_t word_index = subdir_nr / word_bits;
+	size_t mask = 1 << (subdir_nr % word_bits);
 	uint32_t *bitmap;
-	uint32_t bit = 1 << (subdir_nr % BM_SIZE);
 
 	if (subdir_nr < 0 ||
-	    subdir_nr >= ARRAY_SIZE(odb->loose_objects_subdir_seen) * BM_SIZE)
+	    subdir_nr >= bitsizeof(odb->loose_objects_subdir_seen))
 		BUG("subdir_nr out of range");
 
-	bitmap = &odb->loose_objects_subdir_seen[subdir_nr / BM_SIZE];
-	if (*bitmap & bit)
+	bitmap = &odb->loose_objects_subdir_seen[word_index];
+	if (*bitmap & mask)
 		return &odb->loose_objects_cache;
 
 	strbuf_addstr(&buf, odb->path);
@@ -2480,7 +2481,7 @@ struct oidtree *odb_loose_cache(struct object_directory *odb,
 				    append_loose_object,
 				    NULL, NULL,
 				    &odb->loose_objects_cache);
-	*bitmap |= bit;
+	*bitmap |= mask;
 	strbuf_release(&buf);
 	return &odb->loose_objects_cache;
 }
