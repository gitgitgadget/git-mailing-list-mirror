Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D8DEB64DC
	for <git@archiver.kernel.org>; Mon,  3 Jul 2023 05:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjGCF1a (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jul 2023 01:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjGCF11 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2023 01:27:27 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777BE1B1
        for <git@vger.kernel.org>; Sun,  2 Jul 2023 22:27:26 -0700 (PDT)
Received: (qmail 6028 invoked by uid 109); 3 Jul 2023 05:27:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 03 Jul 2023 05:27:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2127 invoked by uid 111); 3 Jul 2023 05:27:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Jul 2023 01:27:28 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 Jul 2023 01:27:24 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 05/16] ref-filter.c: parameterize match functions over
 patterns
Message-ID: <20230703052724.GE3502534@coredump.intra.peff.net>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1687270849.git.me@ttaylorr.com>
 <39e9b0f50d07cc75219325e7c7e72a801ca0cf16.1687270849.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <39e9b0f50d07cc75219325e7c7e72a801ca0cf16.1687270849.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 20, 2023 at 10:21:21AM -0400, Taylor Blau wrote:

> Once we start passing either in, `match_pattern()` will have little to
> do with a particular `struct ref_filter *` instance. To clarify this,
> drop it from the argument list, and replace it with the only bit of the
> `ref_filter` that we care about (`filter->ignore_case`).

Makes sense, but...

> @@ -2134,9 +2134,10 @@ static int match_pattern(const struct ref_filter *filter, const char *refname)
>   * matches a pattern "refs/heads/" but not "refs/heads/m") or a
>   * wildcard (e.g. the same ref matches "refs/heads/m*", too).
>   */
> -static int match_name_as_path(const struct ref_filter *filter, const char *refname)
> +static int match_name_as_path(const struct ref_filter *filter,
> +			      const char **pattern,
> +			      const char *refname)

...wouldn't we then want to do the same for match_name_as_path()?

I.e., this:

diff --git a/ref-filter.c b/ref-filter.c
index 6aacb99be7..cf10c753e2 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2134,14 +2134,13 @@ static int match_pattern(const char **patterns, const char *refname,
  * matches a pattern "refs/heads/" but not "refs/heads/m") or a
  * wildcard (e.g. the same ref matches "refs/heads/m*", too).
  */
-static int match_name_as_path(const struct ref_filter *filter,
-			      const char **pattern,
-			      const char *refname)
+static int match_name_as_path(const char **pattern, const char *refname,
+			      int ignore_case)
 {
 	int namelen = strlen(refname);
 	unsigned flags = WM_PATHNAME;
 
-	if (filter->ignore_case)
+	if (ignore_case)
 		flags |= WM_CASEFOLD;
 
 	for (; *pattern; pattern++) {
@@ -2166,7 +2165,8 @@ static int filter_pattern_match(struct ref_filter *filter, const char *refname)
 	if (!*filter->name_patterns)
 		return 1; /* No pattern always matches */
 	if (filter->match_as_path)
-		return match_name_as_path(filter, filter->name_patterns, refname);
+		return match_name_as_path(filter->name_patterns, refname,
+					  filter->ignore_case);
 	return match_pattern(filter->name_patterns, refname,
 			     filter->ignore_case);
 }

Also, I noticed that you declared it as "const int ignore_case" in
match_pattern(). That's not wrong, but we usually do not bother (it is
passed by value, so const-ness is irrelevant to the caller, and the
compiler can see inside the function that the value is not changed and
optimize appropriately).

-Peff
