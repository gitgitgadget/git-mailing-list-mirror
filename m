Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C28C433DF
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 21:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36FFA208E4
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 21:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbgGaVnM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 17:43:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:44490 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726571AbgGaVnM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 17:43:12 -0400
Received: (qmail 26873 invoked by uid 109); 31 Jul 2020 21:43:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 31 Jul 2020 21:43:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1561 invoked by uid 111); 31 Jul 2020 21:43:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 31 Jul 2020 17:43:11 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 31 Jul 2020 17:43:11 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, chriscool@tuxfamily.org, gitster@pobox.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH v3 4/4] upload-pack.c: introduce
 'uploadpackfilter.tree.maxDepth'
Message-ID: <20200731214311.GB1457058@coredump.intra.peff.net>
References: <cover.1595468657.git.me@ttaylorr.com>
 <cover.1596227003.git.me@ttaylorr.com>
 <c9d71809f49dc1b600b75769e0b6aae17382bf4e.1596227003.git.me@ttaylorr.com>
 <20200731210114.GC1440890@coredump.intra.peff.net>
 <20200731212905.GE3409@syl.lan>
 <20200731213604.GA1457058@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200731213604.GA1457058@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 31, 2020 at 05:36:04PM -0400, Jeff King wrote:

> My suggested patch does introduce more side effects. I think that's OK
> because there really is only a single caller here. But if you wanted it
> cleaner, then I think having allows_filter_choice() fill out an error
> strbuf would eliminate my concern without drastically altering the flow
> of your code.

That could be something like the patch below. banned_filter() could
switch to returning a simple boolean, but I didn't do that here.

I did (as with my other patch) reorder the logic in allows_filter_choice(),
as I think it's much easier to follow by resolving "allowed" to the
fallback earlier. That lets you handle "not allowed at all" first and
early-return (or die) before dealing with type-specific checks.

diff --git a/upload-pack.c b/upload-pack.c
index 131445b212..86786f0e13 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -993,59 +993,60 @@ static int process_deepen_not(const char *line, struct string_list *deepen_not,
 }
 
 static int allows_filter_choice(struct upload_pack_data *data,
-				struct list_objects_filter_options *opts)
+				struct list_objects_filter_options *opts,
+				struct strbuf *err)
 {
 	const char *key = list_object_filter_config_name(opts->choice);
 	struct string_list_item *item = string_list_lookup(&data->allowed_filters,
 							   key);
-	int allowed = -1;
+	int allowed;
 	if (item)
 		allowed = (intptr_t) item->util;
+	else
+		allowed = data->allow_filter_fallback;
 
-	if (allowed != 0 &&
-	    opts->choice == LOFC_TREE_DEPTH &&
-	    opts->tree_exclude_depth > data->tree_filter_max_depth)
+	if (!allowed) {
+		strbuf_addf(err, "filter '%s' not supported", key);
 		return 0;
+	}
+
+	if (opts->choice == LOFC_TREE_DEPTH &&
+	    opts->tree_exclude_depth > data->tree_filter_max_depth) {
+		strbuf_addf(err, "tree filter maximum depth is %lu, but got %lu",
+			    data->tree_filter_max_depth, opts->tree_exclude_depth);
+		return 0;
+	}
 
-	if (allowed > -1)
-		return allowed;
-	return data->allow_filter_fallback;
+	return 1;
 }
 
 static struct list_objects_filter_options *banned_filter(
 	struct upload_pack_data *data,
-	struct list_objects_filter_options *opts)
+	struct list_objects_filter_options *opts,
+	struct strbuf *err)
 {
 	size_t i;
 
-	if (!allows_filter_choice(data, opts))
+	if (!allows_filter_choice(data, opts, err))
 		return opts;
 
 	if (opts->choice == LOFC_COMBINE)
 		for (i = 0; i < opts->sub_nr; i++) {
 			struct list_objects_filter_options *sub = &opts->sub[i];
-			if (banned_filter(data, sub))
+			if (banned_filter(data, sub, err))
 				return sub;
 		}
 	return NULL;
 }
 
 static void die_if_using_banned_filter(struct upload_pack_data *data)
 {
-	struct list_objects_filter_options *banned = banned_filter(data,
-								   &data->filter_options);
 	struct strbuf buf = STRBUF_INIT;
+	struct list_objects_filter_options *banned =
+		banned_filter(data, &data->filter_options, &buf);
 	if (!banned)
 		return;
 
-	strbuf_addf(&buf, "git upload-pack: filter '%s' not supported",
-		    list_object_filter_config_name(banned->choice));
-	if (banned->choice == LOFC_TREE_DEPTH &&
-	    data->tree_filter_max_depth != ULONG_MAX)
-		strbuf_addf(&buf, _(" (maximum depth: %lu, but got: %lu)"),
-			    data->tree_filter_max_depth,
-			    banned->tree_exclude_depth);
-
 	packet_writer_error(&data->writer, "%s\n", buf.buf);
 	die("%s", buf.buf);
 }
