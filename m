Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7802C433F5
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 17:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92FF961355
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 17:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbhJSRdb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Oct 2021 13:33:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:41702 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232526AbhJSRdb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Oct 2021 13:33:31 -0400
Received: (qmail 7003 invoked by uid 109); 19 Oct 2021 17:31:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 19 Oct 2021 17:31:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12600 invoked by uid 111); 19 Oct 2021 17:31:17 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 19 Oct 2021 13:31:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 19 Oct 2021 13:31:16 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PoC] mailmap and trailers
Message-ID: <YW8A5FznqLYs7MqH@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The notion came up at the virtual contrib summit that we mailmap
author/committer names, but not usually idents in trailers. We do for
"git shortlog --group=trailer", but not in say, "git log", which is
where most people will see them.

So here's a proof-of-concept at mapping idents in trailers for git-log.
It does enough that you can try:

  $ git log --format='%(trailers)' >orig
  $ git log --format='%(trailers:mailmap)' >mapped
  $ diff -u orig mapped

which does show the expected differences for git.git (e.g., people's
Signed-off-by trailers getting adjusted for their current emails).

One of the main things I wondered was the speed difference. The first
command runs in about 0.5s for me, and the second in about 3.5s. So
there's a pretty big cost, but perhaps acceptable in the context of
interactive use. I didn't profile much. I'd guess some of the time is
just that parsing and handling individual trailers at all is a bit slow
(so it's on par with %(trailers:unfold), etc).

What's here should work reliably, I think, but is pretty incomplete:

  - it only works for %(trailers). We'd probably want a
    "--mailmap-trailers" options to affect --pretty=medium, etc. That
    code would probably go in pretty.c:pp_remainder()

  - docs/tests conspicuously missing

  - there's some ugliness with the ownership of the mailmap data
    structure itself. I followed the existing pattern there. At the very
    least these two spots should use the _same_ static string_list, but
    probably it should be refactored to put it into pretty_print_context
    or something.

Anyway, here it is. I'm not sure if I'll push it forward more, but
certainly anybody interested is welcome to pick it up and run with it. I
mostly wanted to show how much and where such code would be, and see how
it performed.

---
diff --git a/pretty.c b/pretty.c
index 73b5ead509..0afa70058f 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1167,6 +1167,7 @@ int format_set_trailers_options(struct process_trailer_options *opts,
 	for (;;) {
 		const char *argval;
 		size_t arglen;
+		int bool_arg;
 
 		if (**arg == ')')
 			break;
@@ -1200,6 +1201,15 @@ int format_set_trailers_options(struct process_trailer_options *opts,
 			strbuf_expand(kvsepbuf, fmt, strbuf_expand_literal_cb, NULL);
 			free(fmt);
 			opts->key_value_separator = kvsepbuf;
+		} else if (match_placeholder_bool_arg(*arg, "mailmap", arg, &bool_arg)) {
+			if (bool_arg) {
+				/* yuck but this is how mailmap_name() above does it */
+				static struct string_list mailmap = STRING_LIST_INIT_DUP;
+				read_mailmap(&mailmap);
+				opts->mailmap = &mailmap;
+			} else {
+				opts->mailmap = NULL;
+			}
 		} else if (!match_placeholder_bool_arg(*arg, "only", arg, &opts->only_trailers) &&
 			   !match_placeholder_bool_arg(*arg, "unfold", arg, &opts->unfold) &&
 			   !match_placeholder_bool_arg(*arg, "keyonly", arg, &opts->key_only) &&
diff --git a/trailer.c b/trailer.c
index 7c7cb61a94..743fdd506d 100644
--- a/trailer.c
+++ b/trailer.c
@@ -6,6 +6,8 @@
 #include "tempfile.h"
 #include "trailer.h"
 #include "list.h"
+#include "mailmap.h"
+
 /*
  * Copyright (c) 2013, 2014 Christian Couder <chriscool@tuxfamily.org>
  */
@@ -1138,6 +1140,29 @@ void trailer_info_release(struct trailer_info *info)
 	free(info->trailers);
 }
 
+static int mailmap_value(struct string_list *mailmap,
+			 struct strbuf *out, const struct strbuf *in)
+{
+	const char *mailbuf, *namebuf;
+	size_t namelen, maillen;
+	struct ident_split ident;
+
+	if (split_ident_line(&ident, in->buf, in->len))
+		return -1; /* not an ident */
+
+	namebuf = ident.name_begin;
+	namelen = ident.name_end - ident.name_begin;
+	mailbuf = ident.mail_begin;
+	maillen = ident.mail_end - ident.mail_begin;
+
+	map_user(mailmap, &mailbuf, &maillen, &namebuf, &namelen);
+	strbuf_add(out, namebuf, namelen);
+	strbuf_addstr(out, " <");
+	strbuf_add(out, mailbuf, maillen);
+	strbuf_addch(out, '>');
+	return 0;
+}
+
 static void format_trailer_info(struct strbuf *out,
 				const struct trailer_info *info,
 				const struct process_trailer_options *opts)
@@ -1148,7 +1173,7 @@ static void format_trailer_info(struct strbuf *out,
 	/* If we want the whole block untouched, we can take the fast path. */
 	if (!opts->only_trailers && !opts->unfold && !opts->filter &&
 	    !opts->separator && !opts->key_only && !opts->value_only &&
-	    !opts->key_value_separator) {
+	    !opts->key_value_separator && !opts->mailmap) {
 		strbuf_add(out, info->trailer_start,
 			   info->trailer_end - info->trailer_start);
 		return;
@@ -1177,8 +1202,11 @@ static void format_trailer_info(struct strbuf *out,
 					else
 						strbuf_addstr(out, ": ");
 				}
-				if (!opts->key_only)
-					strbuf_addbuf(out, &val);
+				if (!opts->key_only) {
+					if (!opts->mailmap ||
+					    mailmap_value(opts->mailmap, out, &val) < 0)
+						strbuf_addbuf(out, &val);
+				}
 				if (!opts->separator)
 					strbuf_addch(out, '\n');
 			}
diff --git a/trailer.h b/trailer.h
index 795d2fccfd..747d2a6bc6 100644
--- a/trailer.h
+++ b/trailer.h
@@ -73,6 +73,7 @@ struct process_trailer_options {
 	int no_divider;
 	int key_only;
 	int value_only;
+	struct string_list *mailmap;
 	const struct strbuf *separator;
 	const struct strbuf *key_value_separator;
 	int (*filter)(const struct strbuf *, void *);
