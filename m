Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88C5B20986
	for <e@80x24.org>; Wed, 19 Oct 2016 20:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756913AbcJSUjr (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Oct 2016 16:39:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:59649 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752113AbcJSUjq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2016 16:39:46 -0400
Received: (qmail 16897 invoked by uid 109); 19 Oct 2016 20:39:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 19 Oct 2016 20:39:46 +0000
Received: (qmail 17404 invoked by uid 111); 19 Oct 2016 20:40:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 19 Oct 2016 16:40:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Oct 2016 16:39:44 -0400
Date:   Wed, 19 Oct 2016 16:39:44 -0400
From:   Jeff King <peff@peff.net>
To:     Santiago Torres <santiago@nyu.edu>
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        walters@verbum.org, Lukas Puehringer <luk.puehringer@gmail.com>
Subject: [PATCH 2/2] tag: send fully qualified refnames to
 verify_tag_and_format
Message-ID: <20161019203943.epjxnfci7vcqg4xv@sigill.intra.peff.net>
References: <20161019203520.zevkb75at2nrogdm@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161019203520.zevkb75at2nrogdm@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The ref-filter code generally expects to see fully qualified
refs, so that things like "%(refname)" and "%(refname:short)"
work as expected. We can do so easily from git-tag, which
always works with refnames in the refs/tags namespace. As a
bonus, we can drop the "kind" parameter from
pretty_print_ref() and just deduce it automatically.

Unfortunately, things are not so simple for verify-tag,
which takes an arbitrary sha1 expression. It has no clue if
a refname as used or not, and whether it was in the
refs/tags namespace.

In an ideal world, get_sha1_with_context() would optionally
tell us about any refs we resolved while it was working, and
we could just feed that refname (and then in cases where we
didn't use a ref at all, like a bare sha1, we could fallback
to just showing the sha1 name the user gave us).

Signed-off-by: Jeff King <peff@peff.net>
---
I think you'd really just squash the various bits of this into your
series at the right spots, though I don't mind it on top, either.

The big question is to what degree we should care about the verify-tag
case. I don't think it's any worse off with this change than it is with
your series (its "kind" becomes "OTHER", but I don't think that is
actually used for display at all; the name remains the same). I'd be OK
with leaving it like this, as a known bug, until get_sha1_with_context()
learns to tell us about the ref. It's an unhandled corner case in a
brand-new feature, not a regression in an existing one.

 builtin/tag.c | 2 +-
 ref-filter.c  | 4 ++--
 ref-filter.h  | 6 +++++-
 tag.c         | 2 +-
 4 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 49aeb50..18eab7e 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -114,7 +114,7 @@ static int verify_tag(const char *name, const char *ref,
 	if (fmt_pretty)
 		flags = GPG_VERIFY_QUIET;
 
-	return verify_and_format_tag(sha1, name, fmt_pretty, flags);
+	return verify_and_format_tag(sha1, ref, fmt_pretty, flags);
 }
 
 static int do_sign(struct strbuf *buffer)
diff --git a/ref-filter.c b/ref-filter.c
index 77ec9de..74da17a 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1643,11 +1643,11 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
 }
 
 void pretty_print_ref(const char *name, const unsigned char *sha1,
-		const char *format, unsigned kind)
+		      const char *format)
 {
 	struct ref_array_item *ref_item;
 	ref_item = new_ref_array_item(name, sha1, 0);
-	ref_item->kind = kind;
+	ref_item->kind = ref_kind_from_refname(name);
 	show_ref_array_item(ref_item, format, 0);
 	free_array_item(ref_item);
 }
diff --git a/ref-filter.h b/ref-filter.h
index 3d23090..fed2f5e 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -107,7 +107,11 @@ struct ref_sorting *ref_default_sorting(void);
 /*  Function to parse --merged and --no-merged options */
 int parse_opt_merge_filter(const struct option *opt, const char *arg, int unset);
 
+/*
+ * Print a single ref, outside of any ref-filter. Note that the
+ * name must be a fully qualified refname.
+ */
 void pretty_print_ref(const char *name, const unsigned char *sha1,
-		const char *format, unsigned kind);
+		      const char *format);
 
 #endif /*  REF_FILTER_H  */
diff --git a/tag.c b/tag.c
index d3512c0..d5a7cfb 100644
--- a/tag.c
+++ b/tag.c
@@ -62,7 +62,7 @@ int verify_and_format_tag(const unsigned char *sha1, const char *name,
 	free(buf);
 
 	if (fmt_pretty)
-		pretty_print_ref(name, sha1, fmt_pretty, FILTER_REFS_TAGS);
+		pretty_print_ref(name, sha1, fmt_pretty);
 
 	return ret;
 }
-- 
2.10.1.619.g16351a7
