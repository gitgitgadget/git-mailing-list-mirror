Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F22EB64DD
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 23:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjGUXgR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jul 2023 19:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjGUXgP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 19:36:15 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2AC1FE1
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 16:36:14 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EB4EE19C14E;
        Fri, 21 Jul 2023 19:36:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=5
        zjhNEfkar/ULUs03Menut8VNlM9UVpTWzW5lxgCXI4=; b=hrJzlIc2fH+4wgHo0
        dHsDB0ROaW+VuBZyGN5K+r6Jieg4zIWKlHXSo0s8ZAZ7+PzLYVfDB9TSbqNtvsyr
        mDGF7EX3RQLfpLjG4Ob0uonRHlGtyDrYPnkQiOUqzR9HSgs44Ng658ZW58RPTEN2
        AIuXY3RevjhsDbefh6hhu7oOcQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E385D19C14D;
        Fri, 21 Jul 2023 19:36:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5B17F19C14B;
        Fri, 21 Jul 2023 19:36:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <bk2204@github.com>
Subject: [PATCH] rerere: match the hash algorithm with its length
Date:   Fri, 21 Jul 2023 16:36:12 -0700
Message-ID: <xmqqa5vou9ar.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 612306D4-281F-11EE-ADB0-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "conflict ID" used by "git rerere" to identify past conflicts we
saw has been a SHA-1 hash of the normalized text taken from the
conflicted region.  0d7c419a (rerere: convert to use the_hash_algo,
2018-10-15) updated the rerere machinery to use more general "hash"
instead of hardcoded SHA-1 by using the_hash_algo, GIT_MAX_RAWSZ and
their friends, but the code that read from the MERGE_RR records were
left unconverted to still use get_sha1_hex(), possibly breaking the
operation in SHA-256 repositories.

We enumerate the subdirectories of $GIT_DIR/rr-cache/ and use the
ones whose name passes parse_oid_hex() in full as conflict IDs,
so they are always of correct length relative to the choice of the
hash the repository makes, and they are written to the MERGE_RR
file.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * The "conflict ID" uses SHA-1 not because we needed a secure hash.
   We only needed something that is reasonably long with fewer
   collisions (the "rerere" machinery tolerates collisions).  We
   just had SHA-1 readily available to us and that was the only
   reason we used it.  As these "conflict ID" are not security
   sensitive, we could leave them as SHA-1 even in SHA-256
   repositories and reverting 0d7c419a might be a good first step if
   we want to go in that direction, but let's be consistent.

 rerere.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/rerere.c b/rerere.c
index 7070f75014..f06172253b 100644
--- a/rerere.c
+++ b/rerere.c
@@ -203,8 +203,13 @@ static void read_rr(struct repository *r, struct string_list *rr)
 		int variant;
 		const unsigned hexsz = the_hash_algo->hexsz;
 
-		/* There has to be the hash, tab, path and then NUL */
-		if (buf.len < hexsz + 2 || get_sha1_hex(buf.buf, hash))
+		/*
+		 * There has to be the "conflict ID", tab, path and then NUL.
+		 * "conflict ID" would be a hash, possibly suffixed by "." and
+		 * a small integer (variant number).
+		 */
+		if (buf.len < hexsz + 2 ||
+		    get_hash_hex_algop(buf.buf, hash, the_hash_algo))
 			die(_("corrupt MERGE_RR"));
 
 		if (buf.buf[hexsz] != '.') {
-- 
2.41.0-394-ge43f4fd0bd

