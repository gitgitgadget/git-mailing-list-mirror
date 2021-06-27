Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AEF2C49EA6
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 02:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4338F61C55
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 02:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbhF0Ctr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Jun 2021 22:49:47 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:60558 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230104AbhF0Ctq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Jun 2021 22:49:46 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 4495B1F8C8;
        Sun, 27 Jun 2021 02:47:19 +0000 (UTC)
From:   Eric Wong <e@80x24.org>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Subject: [PATCH 2/5] avoid strlen via strbuf_addstr in link_alt_odb_entry
Date:   Sun, 27 Jun 2021 02:47:15 +0000
Message-Id: <20210627024718.25383-3-e@80x24.org>
In-Reply-To: <20210627024718.25383-1-e@80x24.org>
References: <20210627024718.25383-1-e@80x24.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We can save a few milliseconds (across 100K odbs) by using
strbuf_addbuf() instead of strbuf_addstr() by passing `entry' as
a strbuf pointer rather than a "const char *".

Signed-off-by: Eric Wong <e@80x24.org>
---
 object-file.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/object-file.c b/object-file.c
index 304af3a172..6be43c2b60 100644
--- a/object-file.c
+++ b/object-file.c
@@ -569,18 +569,18 @@ static int alt_odb_usable(struct raw_object_store *o,
 static void read_info_alternates(struct repository *r,
 				 const char *relative_base,
 				 int depth);
-static int link_alt_odb_entry(struct repository *r, const char *entry,
+static int link_alt_odb_entry(struct repository *r, const struct strbuf *entry,
 	const char *relative_base, int depth, const char *normalized_objdir)
 {
 	struct object_directory *ent;
 	struct strbuf pathbuf = STRBUF_INIT;
 	khiter_t pos;
 
-	if (!is_absolute_path(entry) && relative_base) {
+	if (!is_absolute_path(entry->buf) && relative_base) {
 		strbuf_realpath(&pathbuf, relative_base, 1);
 		strbuf_addch(&pathbuf, '/');
 	}
-	strbuf_addstr(&pathbuf, entry);
+	strbuf_addbuf(&pathbuf, entry);
 
 	if (strbuf_normalize_path(&pathbuf) < 0 && relative_base) {
 		error(_("unable to normalize alternate object path: %s"),
@@ -671,7 +671,7 @@ static void link_alt_odb_entries(struct repository *r, const char *alt,
 		alt = parse_alt_odb_entry(alt, sep, &entry);
 		if (!entry.len)
 			continue;
-		link_alt_odb_entry(r, entry.buf,
+		link_alt_odb_entry(r, &entry,
 				   relative_base, depth, objdirbuf.buf);
 	}
 	strbuf_release(&entry);
