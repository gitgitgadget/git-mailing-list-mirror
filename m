Return-Path: <SRS0=ybwr=BB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CD9C433E4
	for <git@archiver.kernel.org>; Wed, 22 Jul 2020 21:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B45720674
	for <git@archiver.kernel.org>; Wed, 22 Jul 2020 21:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgGVVkl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jul 2020 17:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgGVVkk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jul 2020 17:40:40 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2FE9C0619DC
        for <git@vger.kernel.org>; Wed, 22 Jul 2020 14:40:40 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jyMTf-009HZR-4K; Wed, 22 Jul 2020 23:40:39 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     git@vger.kernel.org
Cc:     bup-list@googlegroups.com,
        Jamie Wyrick <terrifiedquack80@gmail.com>
Subject: [PATCH v3] pack-write/docs: update regarding pack naming
Date:   Wed, 22 Jul 2020 23:40:31 +0200
Message-Id: <20200722214031.116161-1-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The index-pack documentation explicitly states that the pack
name is derived from the sorted list of object names, but
since commit 1190a1acf800 ("pack-objects: name pack files
after trailer hash") that isn't true anymore.

Be less explicit in the docs as to what the exact output is,
and just say that it's whatever goes into the pack name.

Also update a comment on write_idx_file() since it no longer
modifies the sha1 variable (it's const now anyway), as noted
by Junio.

Fixes: 1190a1acf800 ("pack-objects: name pack files after trailer hash")
Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
It was reported that bup writes pack files that have a name
different from what git does, and I think it's quite possibly
because of this documentation ... it doesn't actually really
*matter* though, as long as the file is internally consistent
nothing checks that the name also matches the footer.

You can also take this as a bug report and fix the language in
some other, perhaps more precise way, if you prefer :-)

v2: correct bup list address, oops
v3: don't re-indent, update the comment as well
---
 Documentation/git-index-pack.txt | 4 ++--
 pack-write.c                     | 5 ++---
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index-pack.txt
index 9316d9a80b0d..ac74d058e01d 100644
--- a/Documentation/git-index-pack.txt
+++ b/Documentation/git-index-pack.txt
@@ -104,8 +104,8 @@ This option cannot be used with --stdin.
 NOTES
 -----
 
-Once the index has been created, the list of object names is sorted
-and the SHA-1 hash of that list is printed to stdout. If --stdin was
+Once the index has been created, the hash that goes into the name of
+the pack/idx file is printed to stdout. If --stdin was
 also used then this is prefixed by either "pack\t", or "keep\t" if a
 new .keep file was successfully created. This is useful to remove a
 .keep file used as a lock to prevent the race with 'git repack'
diff --git a/pack-write.c b/pack-write.c
index f0017beb9dd4..685d327d800a 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -38,9 +38,8 @@ static int need_large_offset(off_t offset, const struct pack_idx_option *opts)
 }
 
 /*
- * On entry *sha1 contains the pack content SHA1 hash, on exit it is
- * the SHA1 hash of sorted object names. The objects array passed in
- * will be sorted by SHA1 on exit.
+ * The *sha1 contains the pack content SHA1 hash.
+ * The objects array passed in will be sorted by SHA1 on exit.
  */
 const char *write_idx_file(const char *index_name, struct pack_idx_entry **objects,
 			   int nr_objects, const struct pack_idx_option *opts,
-- 
2.26.2

