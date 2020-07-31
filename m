Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71B2C433DF
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 21:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA94B21744
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 21:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgGaVWo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 17:22:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:44406 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726571AbgGaVWo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 17:22:44 -0400
Received: (qmail 24912 invoked by uid 109); 31 Jul 2020 21:22:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 31 Jul 2020 21:22:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31869 invoked by uid 111); 31 Jul 2020 21:22:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 31 Jul 2020 17:22:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 31 Jul 2020 17:22:43 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, chriscool@tuxfamily.org, gitster@pobox.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH v3 4/4] upload-pack.c: introduce
 'uploadpackfilter.tree.maxDepth'
Message-ID: <20200731212243.GA1443086@coredump.intra.peff.net>
References: <cover.1595468657.git.me@ttaylorr.com>
 <cover.1596227003.git.me@ttaylorr.com>
 <c9d71809f49dc1b600b75769e0b6aae17382bf4e.1596227003.git.me@ttaylorr.com>
 <20200731210114.GC1440890@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200731210114.GC1440890@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 31, 2020 at 05:01:14PM -0400, Jeff King wrote:

> Hmm. So I see now why you wanted to go with the strbuf in the earlier
> patch. This does still feel awkward, though. You check "is it allowed"
> in an earlier function, we get "nope, it's not allowed", and now we have
> to reimplement the check here. That seems like a maintenance burden.
> 
> I think a more natural flow would be either:
> 
>   - the "is it allowed" functions calls immediately into the function
>     that sends the error and dies (this might need a conditional if
>     there's a caller who doesn't want to die; I didn't check)
> 
> or
> 
>   - on failure it populates an error buffer itself, which the caller can
>     then pass along as it sees fit

The first one is easy to do, because there's no other caller. Worth it?

-- >8 --
diff --git a/upload-pack.c b/upload-pack.c
index 131445b212..574a447d5c 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -992,62 +992,63 @@ static int process_deepen_not(const char *line, struct string_list *deepen_not,
 	return 0;
 }
 
-static int allows_filter_choice(struct upload_pack_data *data,
-				struct list_objects_filter_options *opts)
+/* probably this helper could be used in lots more places */
+NORETURN __attribute__((format(printf,2,3)))
+static void send_err_and_die(struct upload_pack_data *data,
+			     const char *fmt, ...)
+{
+	struct strbuf buf = STRBUF_INIT;
+	va_list ap;
+
+	/* yuck, buf not necessary if we had va_list versions of our helpers */
+	va_start(ap, fmt);
+	strbuf_vaddf(&buf, fmt, ap);
+	va_end(ap);
+
+	packet_writer_error(&data->writer, "%s", buf.buf);
+	die("%s", buf.buf);
+}
+
+static void check_one_filter(struct upload_pack_data *data,
+			     struct list_objects_filter_options *opts)
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
-		return 0;
+	if (!allowed)
+		send_err_and_die(data, "filter '%s' not supported",
+				 list_object_filter_config_name(opts->choice));
 
-	if (allowed > -1)
-		return allowed;
-	return data->allow_filter_fallback;
+	if (opts->choice == LOFC_TREE_DEPTH &&
+	    opts->tree_exclude_depth > data->tree_filter_max_depth)
+		send_err_and_die(data,
+				 "tree filter allows max depth %lu, but got %lu",
+				 data->tree_filter_max_depth,
+				 opts->tree_exclude_depth);
 }
 
-static struct list_objects_filter_options *banned_filter(
-	struct upload_pack_data *data,
-	struct list_objects_filter_options *opts)
+static void check_filter_recurse(struct upload_pack_data *data,
+				 struct list_objects_filter_options *opts)
 {
 	size_t i;
 
-	if (!allows_filter_choice(data, opts))
-		return opts;
+	check_one_filter(data, opts);
 
 	if (opts->choice == LOFC_COMBINE)
 		for (i = 0; i < opts->sub_nr; i++) {
-			struct list_objects_filter_options *sub = &opts->sub[i];
-			if (banned_filter(data, sub))
-				return sub;
+			check_filter_recurse(data, &opts->sub[i]);
 		}
-	return NULL;
 }
 
 static void die_if_using_banned_filter(struct upload_pack_data *data)
 {
-	struct list_objects_filter_options *banned = banned_filter(data,
-								   &data->filter_options);
-	struct strbuf buf = STRBUF_INIT;
-	if (!banned)
-		return;
-
-	strbuf_addf(&buf, "git upload-pack: filter '%s' not supported",
-		    list_object_filter_config_name(banned->choice));
-	if (banned->choice == LOFC_TREE_DEPTH &&
-	    data->tree_filter_max_depth != ULONG_MAX)
-		strbuf_addf(&buf, _(" (maximum depth: %lu, but got: %lu)"),
-			    data->tree_filter_max_depth,
-			    banned->tree_exclude_depth);
-
-	packet_writer_error(&data->writer, "%s\n", buf.buf);
-	die("%s", buf.buf);
+	check_filter_recurse(data, &data->filter_options);
 }
 
 static void receive_needs(struct upload_pack_data *data,
