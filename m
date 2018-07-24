Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B17541F597
	for <e@80x24.org>; Tue, 24 Jul 2018 10:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388448AbeGXL5c (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 07:57:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:57320 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2388426AbeGXL5c (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 07:57:32 -0400
Received: (qmail 10967 invoked by uid 109); 24 Jul 2018 10:51:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 24 Jul 2018 10:51:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26462 invoked by uid 111); 24 Jul 2018 10:51:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 24 Jul 2018 06:51:41 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Jul 2018 06:51:39 -0400
Date:   Tue, 24 Jul 2018 06:51:39 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 5/6] pass st.st_size as hint for strbuf_readlink()
Message-ID: <20180724105139.GE17165@sigill.intra.peff.net>
References: <20180724104852.GA14638@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180724104852.GA14638@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we initially added the strbuf_readlink() function in
b11b7e13f4 (Add generic 'strbuf_readlink()' helper function,
2008-12-17), the point was that we generally have a _guess_
as to the correct size based on the stat information, but we
can't necessarily trust it.

Over the years, a few callers have grown up that simply pass
in 0, even though they have the stat information. Let's have
them pass in their hint for consistency (and in theory
efficiency, since it may avoid an extra resize/syscall loop,
but neither location is probably performance critical).

Note that st.st_size is actually an off_t, so in theory we
need xsize_t() here. But none of the other callsites use it,
and since this is just a hint, it doesn't matter either way
(if we wrap we'll simply start with a too-small hint and
then eventually complain when we cannot allocate the
memory).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/init-db.c    | 3 ++-
 refs/files-backend.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 4ecf909368..12ddda7e7b 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -73,7 +73,8 @@ static void copy_templates_1(struct strbuf *path, struct strbuf *template_path,
 			continue;
 		else if (S_ISLNK(st_template.st_mode)) {
 			struct strbuf lnk = STRBUF_INIT;
-			if (strbuf_readlink(&lnk, template_path->buf, 0) < 0)
+			if (strbuf_readlink(&lnk, template_path->buf,
+					    st_template.st_size) < 0)
 				die_errno(_("cannot readlink '%s'"), template_path->buf);
 			if (symlink(lnk.buf, path->buf))
 				die_errno(_("cannot symlink '%s' '%s'"),
diff --git a/refs/files-backend.c b/refs/files-backend.c
index a9a066dcfb..c110c2520c 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -363,7 +363,7 @@ static int files_read_raw_ref(struct ref_store *ref_store,
 	/* Follow "normalized" - ie "refs/.." symlinks by hand */
 	if (S_ISLNK(st.st_mode)) {
 		strbuf_reset(&sb_contents);
-		if (strbuf_readlink(&sb_contents, path, 0) < 0) {
+		if (strbuf_readlink(&sb_contents, path, st.st_size) < 0) {
 			if (errno == ENOENT || errno == EINVAL)
 				/* inconsistent with lstat; retry */
 				goto stat_ref;
-- 
2.18.0.542.g2bf2fc4f7e

