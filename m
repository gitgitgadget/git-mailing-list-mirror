Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29367C433EF
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 12:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BBD360FD7
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 12:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236406AbhIDMna (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Sep 2021 08:43:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:39320 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235794AbhIDMn3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Sep 2021 08:43:29 -0400
Received: (qmail 32480 invoked by uid 109); 4 Sep 2021 12:42:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 04 Sep 2021 12:42:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11379 invoked by uid 111); 4 Sep 2021 12:42:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 04 Sep 2021 08:42:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 4 Sep 2021 08:42:27 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     ZheNing Hu <adlternative@gmail.com>
Subject: [PATCH 2/2] ref-filter: implement "quick" formats
Message-ID: <YTNps0YBOaRNvPzk@coredump.intra.peff.net>
References: <YTNpQ7Od1U/5i0R7@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YTNpQ7Od1U/5i0R7@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some commonly-used formats can be output _much_ faster than going
through the usual atom-formatting code. E.g., "%(objectname) %(refname)"
can just be a simple printf. This commit detects a few easy cases and
uses a hard-coded output function instead.

Note two things about the implementation:

 - we could probably go further here. E.g., %(refname:lstrip) should be
   easy-ish to optimize, too. Likewise, mixed-text like "delete
   %(refname)" would be nice to have.

 - the code is repetitive and enumerates all the cases, and it feels
   like we ought to be able to generalize it more. But that's exactly
   what the current formatting tries to do!

So this whole thing is pretty horrible, and is a hack around the
slowness of the whole used_atom system. It _should_ be possible to
refactor that system to have roughly the same cost, but this will serve
in the meantime.

Here are some numbers ("stream" is Git with the streaming optimization
from the previous commit, and "quick" is this commit):

  Benchmark #1: ./git.stream for-each-ref --format='%(objectname) %(refname)'
    Time (mean ± σ):     229.2 ms ±   6.6 ms    [User: 228.3 ms, System: 0.9 ms]
    Range (min … max):   220.4 ms … 242.6 ms    13 runs

  Benchmark #2: ./git.quick for-each-ref --format='%(objectname) %(refname)'
    Time (mean ± σ):      94.8 ms ±   2.2 ms    [User: 93.5 ms, System: 1.4 ms]
    Range (min … max):    90.8 ms …  98.2 ms    32 runs

  Summary
    './git.quick for-each-ref --format='%(objectname) %(refname)'' ran
      2.42 ± 0.09 times faster than './git.stream for-each-ref --format='%(objectname) %(refname)''

Signed-off-by: Jeff King <peff@peff.net>
---
 ref-filter.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 ref-filter.h | 13 +++++++++++
 2 files changed, 76 insertions(+)

diff --git a/ref-filter.c b/ref-filter.c
index 17b78b1d30..1efa3aadc8 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1009,6 +1009,37 @@ static int reject_atom(enum atom_type atom_type)
 	return atom_type == ATOM_REST;
 }
 
+static void set_up_quick_format(struct ref_format *format)
+{
+	/* quick formats don't handle any special quoting */
+	if (format->quote_style)
+		return;
+
+	/*
+	 * no atoms at all; this should be uncommon in real life, but it may be
+	 * interesting for benchmarking
+	 */
+	if (!used_atom_cnt) {
+		format->quick = REF_FORMAT_QUICK_VERBATIM;
+		return;
+	}
+
+	/*
+	 * It's tempting to look at used_atom here, but it's wrong to do so: we
+	 * need not only to be sure of the needed atoms, but also their order
+	 * and any verbatim parts of the format. So instead, let's just
+	 * hard-code some specific formats.
+	 */
+	if (!strcmp(format->format, "%(refname)"))
+		format->quick = REF_FORMAT_QUICK_REFNAME;
+	else if (!strcmp(format->format, "%(objectname)"))
+		format->quick = REF_FORMAT_QUICK_OBJECTNAME;
+	else if (!strcmp(format->format, "%(refname) %(objectname)"))
+		format->quick = REF_FORMAT_QUICK_REFNAME_OBJECTNAME;
+	else if (!strcmp(format->format, "%(objectname) %(refname)"))
+		format->quick = REF_FORMAT_QUICK_OBJECTNAME_REFNAME;
+}
+
 /*
  * Make sure the format string is well formed, and parse out
  * the used atoms.
@@ -1047,6 +1078,9 @@ int verify_ref_format(struct ref_format *format)
 	}
 	if (format->need_color_reset_at_eol && !want_color(format->use_color))
 		format->need_color_reset_at_eol = 0;
+
+	set_up_quick_format(format);
+
 	return 0;
 }
 
@@ -2617,6 +2651,32 @@ static void append_literal(const char *cp, const char *ep, struct ref_formatting
 	}
 }
 
+static int quick_ref_format(const struct ref_format *format,
+			    const char *refname,
+			    const struct object_id *oid)
+{
+	switch(format->quick) {
+	case REF_FORMAT_QUICK_NONE:
+		return -1;
+	case REF_FORMAT_QUICK_VERBATIM:
+		printf("%s\n", format->format);
+		return 0;
+	case REF_FORMAT_QUICK_REFNAME:
+		printf("%s\n", refname);
+		return 0;
+	case REF_FORMAT_QUICK_OBJECTNAME:
+		printf("%s\n", oid_to_hex(oid));
+		return 0;
+	case REF_FORMAT_QUICK_REFNAME_OBJECTNAME:
+		printf("%s %s\n", refname, oid_to_hex(oid));
+		return 0;
+	case REF_FORMAT_QUICK_OBJECTNAME_REFNAME:
+		printf("%s %s\n", oid_to_hex(oid), refname);
+		return 0;
+	}
+	BUG("unknown ref_format_quick value: %d", format->quick);
+}
+
 int format_ref_array_item(struct ref_array_item *info,
 			  struct ref_format *format,
 			  struct strbuf *final_buf,
@@ -2670,6 +2730,9 @@ void pretty_print_ref(const char *name, const struct object_id *oid,
 	struct strbuf output = STRBUF_INIT;
 	struct strbuf err = STRBUF_INIT;
 
+	if (!quick_ref_format(format, name, oid))
+		return;
+
 	ref_item = new_ref_array_item(name, oid);
 	ref_item->kind = ref_kind_from_refname(name);
 	if (format_ref_array_item(ref_item, format, &output, &err))
diff --git a/ref-filter.h b/ref-filter.h
index ecea1837a2..fde5c3a1cb 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -87,6 +87,19 @@ struct ref_format {
 
 	/* Internal state to ref-filter */
 	int need_color_reset_at_eol;
+
+	/*
+	 * Set by verify_ref_format(); if not NONE, we can skip the usual
+	 * formatting and use an optimized routine.
+	 */
+	enum ref_format_quick {
+		REF_FORMAT_QUICK_NONE = 0,
+		REF_FORMAT_QUICK_VERBATIM,
+		REF_FORMAT_QUICK_REFNAME,
+		REF_FORMAT_QUICK_OBJECTNAME,
+		REF_FORMAT_QUICK_REFNAME_OBJECTNAME,
+		REF_FORMAT_QUICK_OBJECTNAME_REFNAME,
+	} quick;
 };
 
 #define REF_FORMAT_INIT { .use_color = -1 }
-- 
2.33.0.618.g5b11852304
