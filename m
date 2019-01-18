Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 651351F453
	for <e@80x24.org>; Fri, 18 Jan 2019 21:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729661AbfARVfB (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 16:35:01 -0500
Received: from cloud.peff.net ([104.130.231.41]:41584 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729630AbfARVfA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 16:35:00 -0500
Received: (qmail 25750 invoked by uid 109); 18 Jan 2019 21:35:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 18 Jan 2019 21:35:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15330 invoked by uid 111); 18 Jan 2019 21:35:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 18 Jan 2019 16:35:03 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 Jan 2019 16:34:58 -0500
Date:   Fri, 18 Jan 2019 16:34:58 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?Q?S=C3=A9rgio?= Peixoto <sergio.peixoto@gmail.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>, git@vger.kernel.org
Subject: [PATCH] attr: do not mark queried macros as unset
Message-ID: <20190118213458.GB28808@sigill.intra.peff.net>
References: <CAK3b1G+88a=xfO=6wfRi1SMy3xtca2NcFyxuBLKwSifb_L9xwA@mail.gmail.com>
 <20190117160752.GA29375@sigill.intra.peff.net>
 <CAK3b1GJPZ5X3uEP1a-NF9PZkE0tTKVLda5hM32jExVz_OD2E=g@mail.gmail.com>
 <20190118165800.GA9956@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190118165800.GA9956@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 18, 2019 at 11:58:01AM -0500, Jeff King wrote:

> Now, on to the actual bug. The simplest reproduction is:
> 
>   (echo "[attr]foo bar"; echo "* foo") >.gitattributes
>   git check-attr foo file

Actually, even simpler is to just "binary", which is pre-defined as a
macro. :)

> which should report "foo" as set. This bisects to 60a12722ac (attr:
> remove maybe-real, maybe-macro from git_attr, 2017-01-27), and it seems
> like an unintentional regression there. I haven't yet poked into that
> commit to see what the fix will look like.

So here's the fix I came up with. +cc Duy, as this is really tangled
with his older 06a604e670.

-- >8 --
Subject: [PATCH] attr: do not mark queried macros as unset

Since 60a12722ac (attr: remove maybe-real, maybe-macro from git_attr,
2017-01-27), we will always mark an attribute macro (e.g., "binary")
that is specifically queried for as "unspecified", even though listing
_all_ attributes would display it at set. E.g.:

  $ echo "* binary" >.gitattributes

  $ git check-attr -a file
  file: binary: set
  file: diff: unset
  file: merge: unset
  file: text: unset

  $ git check-attr binary file
  file: binary: unspecified

The problem stems from an incorrect conversion of the optimization from
06a604e670 (attr: avoid heavy work when we know the specified attr is
not defined, 2014-12-28). There we tried in collect_some_attrs() to
avoid even looking at the attr_stack when the user has asked for "foo"
and we know that "foo" did not ever appear in any .gitattributes file.

It used a flag "maybe_real" in each attribute struct, where "real" meant
that the attribute appeared in an actual file (we have to make this
distinction because we also create an attribute struct for any names
that are being queried). But as explained in that commit message, the
meaning of "real" was tangled with some special cases around macros.

When 06a604e670 later refactored the macro code, it dropped maybe_real
entirely. This missed the fact that "maybe_real" could be unset for two
reasons: because of a macro, or because it was never found during
parsing. This had two results:

  - the optimization in collect_some_attrs() ceased doing anything
    meaningful, since it no longer kept track of "was it found during
    parsing"

  - worse, it actually kicked in when the caller _did_ ask about a macro
    by name, causing us to mark it as unspecified

It should be possible to salvage this optimization, but let's start with
just removing the remnants. It hasn't been doing anything (except
creating bugs) since 60a12722ac, and nobody seems to have noticed the
performance regression. It's more important to fix the correctness
problem clearly first.

I've added two tests here. The second one actually shows off the bug.
The test of "check-attr -a" is not strictly necessary, but we currently
do not test attribute macros much, and the builtin "binary" not at all.
So this increases our general test coverage, as well as making sure we
didn't mess up this related case.

Signed-off-by: Jeff King <peff@peff.net>
---
 attr.c                | 16 +---------------
 t/t0003-attributes.sh | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/attr.c b/attr.c
index eaece6658d..57ced792f8 100644
--- a/attr.c
+++ b/attr.c
@@ -1092,7 +1092,7 @@ static void collect_some_attrs(const struct index_state *istate,
 			       const char *path,
 			       struct attr_check *check)
 {
-	int i, pathlen, rem, dirlen;
+	int pathlen, rem, dirlen;
 	const char *cp, *last_slash = NULL;
 	int basename_offset;
 
@@ -1113,20 +1113,6 @@ static void collect_some_attrs(const struct index_state *istate,
 	all_attrs_init(&g_attr_hashmap, check);
 	determine_macros(check->all_attrs, check->stack);
 
-	if (check->nr) {
-		rem = 0;
-		for (i = 0; i < check->nr; i++) {
-			int n = check->items[i].attr->attr_nr;
-			struct all_attrs_item *item = &check->all_attrs[n];
-			if (item->macro) {
-				item->value = ATTR__UNSET;
-				rem++;
-			}
-		}
-		if (rem == check->nr)
-			return;
-	}
-
 	rem = check->all_attrs_nr;
 	fill(path, pathlen, basename_offset, check->stack, check->all_attrs, rem);
 }
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 22499bce5f..71e63d8b50 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -322,4 +322,24 @@ test_expect_success 'bare repository: test info/attributes' '
 	)
 '
 
+test_expect_success 'binary macro expanded by -a' '
+	echo "file binary" >.gitattributes &&
+	cat >expect <<-\EOF &&
+	file: binary: set
+	file: diff: unset
+	file: merge: unset
+	file: text: unset
+	EOF
+	git check-attr -a file >actual &&
+	test_cmp expect actual
+'
+
+
+test_expect_success 'query binary macro directly' '
+	echo "file binary" >.gitattributes &&
+	echo file: binary: set >expect &&
+	git check-attr binary file >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.20.1.691.ge06e0a624f

