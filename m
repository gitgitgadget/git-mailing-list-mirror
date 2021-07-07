Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D94DC07E95
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 23:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E553C61C69
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 23:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbhGGXN2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jul 2021 19:13:28 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:54218 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230456AbhGGXNM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jul 2021 19:13:12 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 815E81F8C8;
        Wed,  7 Jul 2021 23:10:20 +0000 (UTC)
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 2/5] avoid strlen via strbuf_addstr in link_alt_odb_entry
Date:   Wed,  7 Jul 2021 23:10:16 +0000
Message-Id: <20210707231019.14738-3-e@80x24.org>
In-Reply-To: <20210629205305.7100-1-e@80x24.org>
References: <20210629205305.7100-1-e@80x24.org>
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
index a13f49b192..2dd70ddf3a 100644
--- a/object-file.c
+++ b/object-file.c
@@ -567,18 +567,18 @@ static int alt_odb_usable(struct raw_object_store *o,
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
@@ -669,7 +669,7 @@ static void link_alt_odb_entries(struct repository *r, const char *alt,
 		alt = parse_alt_odb_entry(alt, sep, &entry);
 		if (!entry.len)
 			continue;
-		link_alt_odb_entry(r, entry.buf,
+		link_alt_odb_entry(r, &entry,
 				   relative_base, depth, objdirbuf.buf);
 	}
 	strbuf_release(&entry);
