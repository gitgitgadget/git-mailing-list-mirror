Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CD991F404
	for <e@80x24.org>; Tue, 14 Aug 2018 18:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbeHNVIq (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 17:08:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:54968 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727948AbeHNVIq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 17:08:46 -0400
Received: (qmail 32031 invoked by uid 109); 14 Aug 2018 18:20:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 14 Aug 2018 18:20:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24499 invoked by uid 111); 14 Aug 2018 18:20:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 14 Aug 2018 14:20:27 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Aug 2018 14:20:22 -0400
Date:   Tue, 14 Aug 2018 14:20:22 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, git@vger.kernel.org
Subject: [PATCH 3/4] cat-file: use a single strbuf for all output
Message-ID: <20180814182022.GC26919@sigill.intra.peff.net>
References: <20180814181358.GA26391@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180814181358.GA26391@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we're in batch mode, we end up in batch_object_write()
for each object, which allocates its own strbuf for each
call. Instead, we can provide a single "scratch" buffer that
gets reused for each output. When running:

  git cat-file --batch-all-objects --batch-check='%(objectname)'

on git.git, my best-of-five time drops from:

  real	0m0.171s
  user	0m0.159s
  sys	0m0.012s

to:

  real	0m0.133s
  user	0m0.121s
  sys	0m0.012s

Note that we could do this just by putting the "scratch"
pointer into "struct expand_data", but I chose instead to
add an extra parameter to the callstack. That's more
verbose, but it makes it a bit more obvious what is going
on, which in turn makes it easy to see where we need to be
releasing the string in the caller (right after the loop
which uses it in each case).

Based-on-a-patch-by: René Scharfe <l.s.r@web.de>
Signed-off-by: Jeff King <peff@peff.net>
---
It also made it easy to see that without the prior patch,
we'd have been using "buf" for two parameters. :)

 builtin/cat-file.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 3ed1d0be80..08dced2614 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -338,11 +338,11 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
 	}
 }
 
-static void batch_object_write(const char *obj_name, struct batch_options *opt,
+static void batch_object_write(const char *obj_name,
+			       struct strbuf *scratch,
+			       struct batch_options *opt,
 			       struct expand_data *data)
 {
-	struct strbuf buf = STRBUF_INIT;
-
 	if (!data->skip_object_info &&
 	    oid_object_info_extended(the_repository, &data->oid, &data->info,
 				     OBJECT_INFO_LOOKUP_REPLACE) < 0) {
@@ -352,10 +352,10 @@ static void batch_object_write(const char *obj_name, struct batch_options *opt,
 		return;
 	}
 
-	strbuf_expand(&buf, opt->format, expand_format, data);
-	strbuf_addch(&buf, '\n');
-	batch_write(opt, buf.buf, buf.len);
-	strbuf_release(&buf);
+	strbuf_reset(scratch);
+	strbuf_expand(scratch, opt->format, expand_format, data);
+	strbuf_addch(scratch, '\n');
+	batch_write(opt, scratch->buf, scratch->len);
 
 	if (opt->print_contents) {
 		print_object_or_die(opt, data);
@@ -363,7 +363,9 @@ static void batch_object_write(const char *obj_name, struct batch_options *opt,
 	}
 }
 
-static void batch_one_object(const char *obj_name, struct batch_options *opt,
+static void batch_one_object(const char *obj_name,
+			     struct strbuf *scratch,
+			     struct batch_options *opt,
 			     struct expand_data *data)
 {
 	struct object_context ctx;
@@ -405,20 +407,21 @@ static void batch_one_object(const char *obj_name, struct batch_options *opt,
 		return;
 	}
 
-	batch_object_write(obj_name, opt, data);
+	batch_object_write(obj_name, scratch, opt, data);
 }
 
 struct object_cb_data {
 	struct batch_options *opt;
 	struct expand_data *expand;
 	struct oidset *seen;
+	struct strbuf *scratch;
 };
 
 static int batch_object_cb(const struct object_id *oid, void *vdata)
 {
 	struct object_cb_data *data = vdata;
 	oidcpy(&data->expand->oid, oid);
-	batch_object_write(NULL, data->opt, data->expand);
+	batch_object_write(NULL, data->scratch, data->opt, data->expand);
 	return 0;
 }
 
@@ -509,6 +512,7 @@ static int batch_objects(struct batch_options *opt)
 
 		cb.opt = opt;
 		cb.expand = &data;
+		cb.scratch = &output;
 
 		if (opt->unordered) {
 			struct oidset seen = OIDSET_INIT;
@@ -531,6 +535,7 @@ static int batch_objects(struct batch_options *opt)
 			oid_array_clear(&sa);
 		}
 
+		strbuf_release(&output);
 		return 0;
 	}
 
@@ -559,10 +564,11 @@ static int batch_objects(struct batch_options *opt)
 			data.rest = p;
 		}
 
-		batch_one_object(input.buf, opt, &data);
+		batch_one_object(input.buf, &output, opt, &data);
 	}
 
 	strbuf_release(&input);
+	strbuf_release(&output);
 	warn_on_object_refname_ambiguity = save_warning;
 	return retval;
 }
-- 
2.18.0.1066.g0d97f3a098

