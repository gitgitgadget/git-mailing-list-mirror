Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BE851F453
	for <e@80x24.org>; Fri, 18 Jan 2019 21:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729677AbfARVq3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 16:46:29 -0500
Received: from cloud.peff.net ([104.130.231.41]:41590 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729621AbfARVq3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 16:46:29 -0500
Received: (qmail 26465 invoked by uid 109); 18 Jan 2019 21:46:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 18 Jan 2019 21:46:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15356 invoked by uid 111); 18 Jan 2019 21:46:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 18 Jan 2019 16:46:31 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 Jan 2019 16:46:27 -0500
Date:   Fri, 18 Jan 2019 16:46:27 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?Q?S=C3=A9rgio?= Peixoto <sergio.peixoto@gmail.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] attr: do not mark queried macros as unset
Message-ID: <20190118214626.GC28808@sigill.intra.peff.net>
References: <CAK3b1G+88a=xfO=6wfRi1SMy3xtca2NcFyxuBLKwSifb_L9xwA@mail.gmail.com>
 <20190117160752.GA29375@sigill.intra.peff.net>
 <CAK3b1GJPZ5X3uEP1a-NF9PZkE0tTKVLda5hM32jExVz_OD2E=g@mail.gmail.com>
 <20190118165800.GA9956@sigill.intra.peff.net>
 <20190118213458.GB28808@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190118213458.GB28808@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 18, 2019 at 04:34:58PM -0500, Jeff King wrote:

> When 06a604e670 later refactored the macro code, it dropped maybe_real
> entirely. This missed the fact that "maybe_real" could be unset for two
> reasons: because of a macro, or because it was never found during
> parsing. This had two results:
> 
>   - the optimization in collect_some_attrs() ceased doing anything
>     meaningful, since it no longer kept track of "was it found during
>     parsing"
> 
>   - worse, it actually kicked in when the caller _did_ ask about a macro
>     by name, causing us to mark it as unspecified
> 
> It should be possible to salvage this optimization, but let's start with
> just removing the remnants. It hasn't been doing anything (except
> creating bugs) since 60a12722ac, and nobody seems to have noticed the
> performance regression. It's more important to fix the correctness
> problem clearly first.

And here's a resurrection of the optimization that _seems_ to work, but
I'm not 100% confident in.

In particular, it does not care about macros at all. It simply asks: is
this queried attribute a thing which was ever mentioned in the
attributes files (either as a path match or as a possible macro
expansion). If not, then we know we do not need to look further for it.

But that leaves me unsure why the original optimization needed to care
about macros at all. Has something changed since then with respect to
the way we expand macros since then? Or am I totally missing some case
that will cause problems?

I guess maybe what I'm missing is that asking for "diff" means that we
need to care about:

  - whether "diff" was mentioned in the stack

  - whether "binary" was mentioned in the stack

But just "binary" mentioning "diff" is not interesting without somebody
actually mentioning "binary". I.e., I don't think the patch here will
produce wrong results, but it will not kick in as often as we might
like.

I'm not sure how to do it robustly without being able to reverse-map all
of the macros after we've resolved them (i.e., to know that "diff" gets
mentioned by "binary", and then check if "binary" is actually
mentioned). I think that would be possible now, as we should know that
after determine_macros(). But I also wonder if we are hitting
diminishing returns (after all, determine_macros() is already walking
the attr stack).

I dunno. This is why I submitted the initial patch as the simplest fix. ;)

---
diff --git a/attr.c b/attr.c
index 57ced792f8..c3cbfa6501 100644
--- a/attr.c
+++ b/attr.c
@@ -31,6 +31,7 @@ static const char git_attr__unknown[] = "(builtin)unknown";
 
 struct git_attr {
 	int attr_nr; /* unique attribute number */
+	int in_stack; /* actually found in some attribute stack */
 	char name[FLEX_ARRAY]; /* attribute name */
 };
 
@@ -220,7 +221,8 @@ static void report_invalid_attr(const char *name, size_t len,
  * dictionary.  If no entry is found, create a new attribute and store it in
  * the dictionary.
  */
-static const struct git_attr *git_attr_internal(const char *name, int namelen)
+static const struct git_attr *git_attr_internal(const char *name, int namelen,
+						int in_stack)
 {
 	struct git_attr *a;
 
@@ -240,6 +242,8 @@ static const struct git_attr *git_attr_internal(const char *name, int namelen)
 		       (hashmap_get_size(&g_attr_hashmap.map) - 1));
 	}
 
+	a->in_stack |= in_stack;
+
 	hashmap_unlock(&g_attr_hashmap);
 
 	return a;
@@ -247,7 +251,7 @@ static const struct git_attr *git_attr_internal(const char *name, int namelen)
 
 const struct git_attr *git_attr(const char *name)
 {
-	return git_attr_internal(name, strlen(name));
+	return git_attr_internal(name, strlen(name), 0);
 }
 
 /* What does a matched pattern decide? */
@@ -335,7 +339,7 @@ static const char *parse_attr(const char *src, int lineno, const char *cp,
 		else {
 			e->setto = xmemdupz(equals + 1, ep - equals - 1);
 		}
-		e->attr = git_attr_internal(cp, len);
+		e->attr = git_attr_internal(cp, len, 1);
 	}
 	return ep + strspn(ep, blank);
 }
@@ -396,7 +400,7 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
 		      sizeof(struct attr_state) * num_attr +
 		      (is_macro ? 0 : namelen + 1));
 	if (is_macro) {
-		res->u.attr = git_attr_internal(name, namelen);
+		res->u.attr = git_attr_internal(name, namelen, 1);
 	} else {
 		char *p = (char *)&(res->state[num_attr]);
 		memcpy(p, name, namelen);
@@ -1093,6 +1097,7 @@ static void collect_some_attrs(const struct index_state *istate,
 			       struct attr_check *check)
 {
 	int pathlen, rem, dirlen;
+	int i;
 	const char *cp, *last_slash = NULL;
 	int basename_offset;
 
@@ -1111,6 +1116,21 @@ static void collect_some_attrs(const struct index_state *istate,
 
 	prepare_attr_stack(istate, path, dirlen, &check->stack);
 	all_attrs_init(&g_attr_hashmap, check);
+
+	if (check->nr) {
+		rem = 0;
+		for (i = 0; i < check->nr; i++) {
+			int n = check->items[i].attr->attr_nr;
+			struct all_attrs_item *item = &check->all_attrs[n];
+			if (!item->attr->in_stack) {
+				item->value = ATTR__UNSET;
+				rem++;
+			}
+		}
+		if (rem == check->nr)
+			return;
+	}
+
 	determine_macros(check->all_attrs, check->stack);
 
 	rem = check->all_attrs_nr;
