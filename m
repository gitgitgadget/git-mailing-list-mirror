Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0EDC433F5
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 18:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 916AC61050
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 18:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbhIXStk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 14:49:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:54684 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229954AbhIXStk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 14:49:40 -0400
Received: (qmail 19160 invoked by uid 109); 24 Sep 2021 18:48:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Sep 2021 18:48:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11214 invoked by uid 111); 24 Sep 2021 18:48:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Sep 2021 14:48:06 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Sep 2021 14:48:05 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 14/16] ref-filter: stop setting FILTER_REFS_INCLUDE_BROKEN
Message-ID: <YU4dZZ7P34/kSduu@coredump.intra.peff.net>
References: <YU4ZOF9+ubmoItmK@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YU4ZOF9+ubmoItmK@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Of the ref-filter callers, for-each-ref and git-branch both set the
INCLUDE_BROKEN flag (but git-tag does not, which is a weird
inconsistency).  But now that GIT_REF_PARANOIA is on by default, that
produces almost the same outcome for all three.

The one exception is that GIT_REF_PARANOIA will omit dangling symrefs.
That's a better behavior for these tools, as they would never include
such a symref in the main output anyway (they can't, as it doesn't point
to an object). Instead they issue a warning to stderr. But that warning
is somewhat useless; a dangling symref is a perfectly reasonable thing
to have in your repository, and is not a sign of corruption. It's much
friendlier to just quietly ignore it.

And in terms of robustness, the warning gains us little. It does not
impact the exit code of either tool. So while the warning _might_ clue
in a user that they have an unexpected broken symref, it would not help
any kind of scripted use.

This patch converts for-each-ref and git-branch to stop using the
INCLUDE_BROKEN flag. That gives them more reasonable behavior, and
harmonizes them with git-tag.

We have to change one test to adapt to the situation. t1430 tries to
trigger all of the REF_ISBROKEN behaviors from the underlying ref code.
It uses for-each-ref to do so (because there isn't any other mechanism).
That will no longer issue a warning about the symref which points to an
invalid name, as it's considered dangling (and we can instead be sure
that it's _not_ mentioned on stderr). Note that we do still complain
about the illegally named "broken..symref"; its problem is not that it's
dangling, but the name of the symref itself is illegal.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/branch.c        | 2 +-
 builtin/for-each-ref.c  | 2 +-
 t/t1430-bad-ref-name.sh | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 03c7b7253a..0b7ed82654 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -427,7 +427,7 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
 
 	memset(&array, 0, sizeof(array));
 
-	filter_refs(&array, filter, filter->kind | FILTER_REFS_INCLUDE_BROKEN);
+	filter_refs(&array, filter, filter->kind);
 
 	if (filter->verbose)
 		maxwidth = calc_maxwidth(&array, strlen(remote_prefix));
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 89cb6307d4..642b4b888f 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -77,7 +77,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 
 	filter.name_patterns = argv;
 	filter.match_as_path = 1;
-	filter_refs(&array, &filter, FILTER_REFS_ALL | FILTER_REFS_INCLUDE_BROKEN);
+	filter_refs(&array, &filter, FILTER_REFS_ALL);
 	ref_array_sort(sorting, &array);
 
 	if (!maxcount || array.nr < maxcount)
diff --git a/t/t1430-bad-ref-name.sh b/t/t1430-bad-ref-name.sh
index b1839e0877..fa3aeb80f2 100755
--- a/t/t1430-bad-ref-name.sh
+++ b/t/t1430-bad-ref-name.sh
@@ -170,7 +170,7 @@ test_expect_success 'for-each-ref emits warnings for broken names' '
 	! grep -e "badname" output &&
 	! grep -e "broken\.\.\.symref" output &&
 	test_i18ngrep "ignoring ref with broken name refs/heads/broken\.\.\.ref" error &&
-	test_i18ngrep "ignoring broken ref refs/heads/badname" error &&
+	test_i18ngrep ! "ignoring broken ref refs/heads/badname" error &&
 	test_i18ngrep "ignoring ref with broken name refs/heads/broken\.\.\.symref" error
 '
 
-- 
2.33.0.1071.gb37e412355

