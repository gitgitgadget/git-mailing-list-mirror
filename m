Return-Path: <SRS0=bfGv=CG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC586C433E2
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 18:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5B0B20838
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 18:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgH1Szc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Aug 2020 14:55:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:43978 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728015AbgH1Szc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Aug 2020 14:55:32 -0400
Received: (qmail 28446 invoked by uid 109); 28 Aug 2020 18:55:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 28 Aug 2020 18:55:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11207 invoked by uid 111); 28 Aug 2020 18:55:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 28 Aug 2020 14:55:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 28 Aug 2020 14:55:31 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com
Subject: Re: [PATCH] midx: traverse the local MIDX first
Message-ID: <20200828185531.GB2171353@coredump.intra.peff.net>
References: <20200828180621.GA9036@nand.nand.local>
 <20200828185039.GA2171353@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200828185039.GA2171353@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 28, 2020 at 02:50:39PM -0400, Jeff King wrote:

> So I'd be tempted to say that the latter callers should be using a
> separate function that gives them what they want. That lets them avoid
> being too intimate with the details of how we order things.
> 
> The patch below illustrates that.  It also changes the existing function
> name to avoid confusion and to help audit the existing callers, but
> that's optional and maybe not worth it.

And here's the same concept as a more minimal change, suitable for
squashing into yours. The advantage is that it keeps the "the local one
goes first" logic in one abstracted spot.

diff --git a/builtin/repack.c b/builtin/repack.c
index 28b0c1bf1b..60cb196956 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -133,9 +133,9 @@ static void get_non_kept_pack_filenames(struct string_list *fname_list,
 static void remove_redundant_pack(const char *dir_name, const char *base_name)
 {
 	struct strbuf buf = STRBUF_INIT;
-	struct multi_pack_index *m = get_multi_pack_index(the_repository);
+	struct multi_pack_index *m = get_local_multi_pack_index(the_repository);
 	strbuf_addf(&buf, "%s.pack", base_name);
-	if (m && m->local && midx_contains_pack(m, buf.buf))
+	if (m && midx_contains_pack(m, buf.buf))
 		clear_midx_file(the_repository);
 	strbuf_insertf(&buf, 0, "%s/", dir_name);
 	unlink_pack_path(buf.buf, 1);
diff --git a/packfile.c b/packfile.c
index 6ab5233613..9ef27508f2 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1027,6 +1027,17 @@ struct multi_pack_index *get_multi_pack_index(struct repository *r)
 	return r->objects->multi_pack_index;
 }
 
+struct multi_pack_index *get_local_multi_pack_index(struct repository *r)
+{
+	struct multi_pack_index *m = get_multi_pack_index(r);
+
+	/* no need to iterate; we always put the local one first (if any) */
+	if (m && m->local)
+		return m;
+
+	return NULL;
+}
+
 struct packed_git *get_all_packs(struct repository *r)
 {
 	struct multi_pack_index *m;
diff --git a/packfile.h b/packfile.h
index 240aa73b95..a58fc738e0 100644
--- a/packfile.h
+++ b/packfile.h
@@ -57,6 +57,7 @@ void install_packed_git(struct repository *r, struct packed_git *pack);
 struct packed_git *get_packed_git(struct repository *r);
 struct list_head *get_packed_git_mru(struct repository *r);
 struct multi_pack_index *get_multi_pack_index(struct repository *r);
+struct multi_pack_index *get_local_multi_pack_index(struct repository *r);
 struct packed_git *get_all_packs(struct repository *r);
 
 /*
