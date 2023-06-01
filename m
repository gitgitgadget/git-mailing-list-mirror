Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A59C7EE23
	for <git@archiver.kernel.org>; Thu,  1 Jun 2023 17:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbjFARn6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jun 2023 13:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233066AbjFARnz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 13:43:55 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33523197
        for <git@vger.kernel.org>; Thu,  1 Jun 2023 10:43:53 -0700 (PDT)
Received: (qmail 5954 invoked by uid 109); 1 Jun 2023 17:43:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 01 Jun 2023 17:43:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25318 invoked by uid 111); 1 Jun 2023 17:43:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Jun 2023 13:43:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 1 Jun 2023 13:43:51 -0400
From:   Jeff King <peff@peff.net>
To:     Jim Pryor <dubiousjim@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: [PATCH 3/3] diff: detect pathspec magic not supported by --follow
Message-ID: <20230601174351.GC4165297@coredump.intra.peff.net>
References: <20230601173724.GA4158369@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230601173724.GA4158369@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The --follow code doesn't handle most forms of pathspec magic. We check
that no unexpected ones have made it to try_to_follow_renames() with a
runtime GUARD_PATHSPEC() check, which gives behavior like this:

  $ git log --follow ':(icase)makefile' >/dev/null
  BUG: tree-diff.c:596: unsupported magic 10
  Aborted

The same is true of ":(glob)", ":(attr)", and so on. It's good that we
notice the problem rather than continuing and producing a wrong answer.
But there are two non-ideal things:

  1. The idea of GUARD_PATHSPEC() is to catch programming errors where
     low-level code gets unexpected pathspecs. We'd usually try to catch
     unsupported pathspecs by passing a magic_mask to parse_pathspec(),
     which would give the user a much better message like:

       pathspec magic not supported by this command: 'icase'

     That doesn't happen here because git-log usually _does_ support
     all types of pathspec magic, and so it passes "0" for the mask
     (this call actually happens in setup_revisions()). It needs to
     distinguish the normal case from the "--follow" one but currently
     doesn't.

  2. In addition to --follow, we have the log.follow config option. When
     that is set, we try to turn on --follow mode only when there is a
     single pathspec (since --follow doesn't handle anything else). But
     really, that ought to be expanded to "use --follow when the
     pathspec supports it". Otherwise, we'd complain any time you use an
     exotic pathspec:

       $ git config log.follow true
       $ git log ':(icase)makefile' >/dev/null
       BUG: tree-diff.c:596: unsupported magic 10
       Aborted

     We should instead just avoid enabling follow mode if it's not
     supported by this particular invocation.

This patch expands our diff_check_follow_pathspec() function to cover
pathspec magic, solving both problems.

A few final notes:

  - we could also solve (1) by passing the appropriate mask to
    parse_pathspec(). But that's not great for two reasons. One is that
    the error message is less precise. It says "magic not supported by
    this command", but really it is not the command, but rather the
    --follow option which is the problem. The second is that it always
    calls die(). But for our log.follow code, we want to speculatively
    ask "is this pathspec OK?" and just get a boolean result.

  - This is obviously the right thing to do for ':(icase)' and most
    other magic options. But ':(glob)' is a bit odd here. The --follow
    code doesn't support wildcards, but we allow them anyway. From
    try_to_follow_renames():

	#if 0
	        /*
	         * We should reject wildcards as well. Unfortunately we
	         * haven't got a reliable way to detect that 'foo\*bar' in
	         * fact has no wildcards. nowildcard_len is merely a hint for
	         * optimization. Let it slip for now until wildmatch is taught
	         * about dry-run mode and returns wildcard info.
	         */
	        if (opt->pathspec.has_wildcard)
	                BUG("wildcards are not supported");
	#endif

    So something like "git log --follow 'Make*'" is already doing the
    wrong thing, since ":(glob)" behavior is already the default (it is
    used only to countermand an earlier --noglob-pathspecs).

    So we _could_ loosen the guard to allow :(glob), since it just
    behaves the same as pathspecs do by default. But it seems like a
    backwards step to do so. It already doesn't work (it hits the BUG()
    case currently), and given that the user took an explicit step to
    say "this pathspec should glob", it is reasonable for us to say "no,
    --follow does not support globbing" (or in the case of log.follow,
    avoid turning on follow mode). Which is what happens after this
    patch.

  - The set of allowed pathspec magic is obviously the same as in
    GUARD_PATHSPEC(). We could perhaps factor these out to avoid
    repetition. The point of having separate masks and GUARD calls is
    that we don't necessarily know which parsed pathspecs will be used
    where. But in this case, the two are heavily correlated. Still,
    there may be some value in keeping them separate; it would make
    anyone think twice about adding new magic to the list in
    diff_check_follow_pathspec(). They'd need to touch
    try_to_follow_renames() as well, which is the code that would
    actually need to be updated to handle more exotic pathspecs.

  - The documentation for log.follow says that it enables --follow
    "...when a single <path> is given". We could possibly expand that to
    say "with no unsupported pathspec magic", but that raises the
    question of documenting which magic is supported. I think the
    existing wording of "single <path>" sufficiently encompasses the
    idea (the forbidden magic is stuff that might match multiple
    entries), and the spirit remains the same.

Reported-by: Jim Pryor <dubiousjim@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 diff.c         | 15 +++++++++++++++
 t/t4202-log.sh | 15 +++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/diff.c b/diff.c
index 9f548f3471..8ca16fefe7 100644
--- a/diff.c
+++ b/diff.c
@@ -4753,11 +4753,26 @@ unsigned diff_filter_bit(char status)
 
 int diff_check_follow_pathspec(struct pathspec *ps, int die_on_error)
 {
+	unsigned forbidden_magic;
+
 	if (ps->nr != 1) {
 		if (die_on_error)
 			die(_("--follow requires exactly one pathspec"));
 		return 0;
 	}
+
+	forbidden_magic = ps->items[0].magic & ~(PATHSPEC_FROMTOP |
+						 PATHSPEC_LITERAL);
+	if (forbidden_magic) {
+		if (die_on_error) {
+			struct strbuf sb = STRBUF_INIT;
+			pathspec_magic_names(forbidden_magic, &sb);
+			die(_("pathspec magic not supported by --follow: %s"),
+			    sb.buf);
+		}
+		return 0;
+	}
+
 	return 1;
 }
 
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index ae73aef922..5b54d7928e 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -187,6 +187,21 @@ test_expect_success 'git config log.follow does not die with no paths' '
 	git log --
 '
 
+test_expect_success 'git log --follow rejects unsupported pathspec magic' '
+	test_must_fail git log --follow ":(top,glob,icase)ichi" 2>stderr &&
+	# check full error message; we want to be sure we mention both
+	# of the rejected types (glob,icase), but not the allowed one (top)
+	echo "fatal: pathspec magic not supported by --follow: ${SQ}glob${SQ}, ${SQ}icase${SQ}" >expect &&
+	test_cmp expect stderr
+'
+
+test_expect_success 'log.follow disabled with unsupported pathspec magic' '
+	test_config log.follow true &&
+	git log --format=%s ":(glob,icase)ichi" >actual &&
+	echo third >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'git config log.follow is overridden by --no-follow' '
 	test_config log.follow true &&
 	git log --no-follow --pretty="format:%s" ichi >actual &&
-- 
2.41.0.346.g8d12207a4f
