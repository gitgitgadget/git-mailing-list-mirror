Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D8BCC2BA83
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 15:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE28B650DC
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 15:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbhCPPRr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 11:17:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:37794 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235396AbhCPPP7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 11:15:59 -0400
Received: (qmail 19409 invoked by uid 109); 16 Mar 2021 15:15:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Mar 2021 15:15:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28793 invoked by uid 111); 16 Mar 2021 15:15:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Mar 2021 11:15:56 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 16 Mar 2021 11:15:55 -0400
From:   Jeff King <peff@peff.net>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Miriam Rubio <mirucam@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Pranit Bauva <pranit.bauva@gmail.com>, git@vger.kernel.org
Subject: [PATCH] bisect: peel annotated tags to commits
Message-ID: <YFDLq9mLbJtLqKea@coredump.intra.peff.net>
References: <878s6nz1sg.fsf@igel.home>
 <YFDGX4EsrvHqZgPF@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YFDGX4EsrvHqZgPF@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 16, 2021 at 10:53:19AM -0400, Jeff King wrote:

> On Tue, Mar 16, 2021 at 02:05:51PM +0100, Andreas Schwab wrote:
> 
> > $ git --version
> > git version 2.31.0
> > $ git bisect start
> > $ git bisect good v2.30.0
> > $ git bisect bad v2.31.0
> > 3e90d4b58f3819cfd58ac61cb8668e83d3ea0563 was both good and bad
> 
> Looks like it bisects to 27257bc466 (bisect--helper: reimplement
> `bisect_state` & `bisect_head` shell functions in C, 2020-10-15), which
> isn't too surprising. So it broke in v2.30, but nobody seems to have
> noticed during the last cycle.
> 
> I'd guess it's just missing a call to peel the input oid.

Yep. Here's a fix. Again, not new in v2.31, so we don't have to worry
about a brown-bag fix for yesterday's release. But I do think it's worth
trying to get onto a maint release. I prepared this patch on top of
mr/bisect-in-c-3.

-- >8 --
Subject: [PATCH] bisect: peel annotated tags to commits

This patch fixes a bug where git-bisect doesn't handle receiving
annotated tags as "git bisect good <tag>", etc. It's a regression in
27257bc466 (bisect--helper: reimplement `bisect_state` & `bisect_head`
shell functions in C, 2020-10-15).

The original shell code called:

  sha=$(git rev-parse --verify "$rev^{commit}") ||
          die "$(eval_gettext "Bad rev input: \$rev")"

which will peel the input to a commit (or complain if that's not
possible). But the C code just calls get_oid(), which will yield the oid
of the tag.

The fix is to peel to a commit. The error message here is a little
non-idiomatic for Git (since it starts with a capital). I've mostly left
it, as it matches the other converted messages (like the "Bad rev input"
we print when get_oid() fails), though I did add an indication that it
was the peeling that was the problem. It might be worth taking a pass
through this converted code to modernize some of the error messages.

Note also that the test does a bare "grep" (not i18ngrep) on the
expected "X is the first bad commit" output message. This matches the
rest of the test script.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/bisect--helper.c    |  9 ++++++++-
 t/t6030-bisect-porcelain.sh | 12 ++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index fc6ca257a4..f0eeb4a2f0 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -876,12 +876,19 @@ static enum bisect_error bisect_state(struct bisect_terms *terms, const char **a
 	 */
 
 	for (; argc; argc--, argv++) {
+		struct commit *commit;
+
 		if (get_oid(*argv, &oid)){
 			error(_("Bad rev input: %s"), *argv);
 			oid_array_clear(&revs);
 			return BISECT_FAILED;
 		}
-		oid_array_append(&revs, &oid);
+
+		commit = lookup_commit_reference(the_repository, &oid);
+		if (!commit)
+			die(_("Bad rev input (not a commit): %s"), *argv);
+
+		oid_array_append(&revs, &commit->object.oid);
 	}
 
 	if (strbuf_read_file(&buf, git_path_bisect_expected_rev(), 0) < the_hash_algo->hexsz ||
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index b886529e59..9c389553a7 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -929,4 +929,16 @@ test_expect_success 'git bisect reset cleans bisection state properly' '
 	test_path_is_missing "$GIT_DIR/BISECT_START"
 '
 
+test_expect_success 'bisect handles annotated tags' '
+	test_commit commit-one &&
+	git tag -m foo tag-one &&
+	test_commit commit-two &&
+	git tag -m foo tag-two &&
+	git bisect start &&
+	git bisect good tag-one &&
+	git bisect bad tag-two >output &&
+	bad=$(git rev-parse --verify tag-two^{commit}) &&
+	grep "$bad is the first bad commit" output
+'
+
 test_done
-- 
2.31.0.559.g509d4a088b

