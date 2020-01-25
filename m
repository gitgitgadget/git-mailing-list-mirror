Return-Path: <SRS0=JG/V=3O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03873C2D0CE
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 00:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA8082072C
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 00:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387485AbgAYAAx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 19:00:53 -0500
Received: from cloud.peff.net ([104.130.231.41]:44222 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2387458AbgAYAAw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 19:00:52 -0500
Received: (qmail 9132 invoked by uid 109); 25 Jan 2020 00:00:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 25 Jan 2020 00:00:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12258 invoked by uid 111); 25 Jan 2020 00:08:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Jan 2020 19:08:03 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Jan 2020 19:00:51 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David =?utf-8?B?QnVyc3Ryw7Zt?= <davidburstrom@spotify.com>,
        git@vger.kernel.org
Subject: Re: Bug or unexpected behaviour in git show <rev>:a\b
Message-ID: <20200125000051.GA566074@coredump.intra.peff.net>
References: <CAA-mk2_jB2X1J-NCXQ92spa-fmEct9G9f1iQo7t8=rvD5coFDA@mail.gmail.com>
 <20200124190119.GB1672342@coredump.intra.peff.net>
 <xmqqk15gzmc8.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqk15gzmc8.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 24, 2020 at 11:27:35AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > So everything is working as designed, or at least explainable. But I
> > think there is some room for improvement. A backslash that isn't
> > followed by a glob meta-character _is_ still a meta character (your
> > "a\b" would be globbing for "ab"). But it's useless enough that I think
> > it shouldn't be enough to trigger the "oh, you probably meant this as a
> > pathspec" DWIM rule.
> 
> This sounds sensible.

OK, the patch I came up with is below.

> > We _could_ also say "even though this could technically be a pathspec
> > because of its metacharacter, it looks vaguely enough like a
> > path-in-tree revision that we shouldn't guess". That I'm less
> > comfortable with, just because it makes the heuristics even more
> > magical.
> 
> Not just it becomes more magical, I am afraid that the code to
> implement such a heuristics would be fragile and become a source of
> unnecessary bugs.  Let's not go there.

OK. It does mean that:

  git show HEAD:a*

will still quietly produce no output instead of saying "hey, there is no
a* in HEAD". But I think given the lack of bug reports over the years
that this case (and the backslash one I'm fixing) are probably
relatively rare.  The backslash one seems a lot more likely, just
because Windows folks may treat it like a path separator (I'm not sure
if that even works, considering its meaning in a glob, but certainly I
can imagine somebody doing so as an experiment and getting confused by
the result).

> I should learn to use "working as designed or at least explainable"
> more often in my responses, by the way.  That's quite a useful and
> good phrase ;-)

Perhaps that can be Git's motto. ;)

Anyway, here's the patch. Even though this is rare, I think it's worth
doing. The code is simple and I don't anticipate anybody complaining
about the tightening.

-- >8 --
Subject: verify_filename(): handle backslashes in "wildcards are pathspecs" rule

Commit 28fcc0b71a (pathspec: avoid the need of "--" when wildcard is
used, 2015-05-02) allowed:

  git rev-parse '*.c'

without the double-dash. But the rule it uses to check for wildcards
actually looks for any glob special. This is overly liberal, as it means
that a pattern that doesn't actually do any wildcard matching, like
"a\b", will be considered a pathspec.

If you do have such a file on disk, that's presumably what you wanted.
But if you don't, the results are confusing: rather than say "there's no
such path a\b", we'll quietly accept it as a pathspec which very likely
matches nothing (or at least not what you intended). Likewise, looking
for path "a\*b" doesn't expand the search at all; it would only find a
single entry, "a*b".

This commit switches the rule to trigger only when glob metacharacters
would expand the search, meaning both of those cases will now report an
error (you can still disambiguate using "--", of course; we're just
tightening the DWIM heuristic).

Note that we didn't test the original feature in 28fcc0b71a at all. So
this patch not only tests for these corner cases, but also adds a
regression test for the existing behavior.

Reported-by: David Burström <davidburstrom@spotify.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 setup.c                        | 23 ++++++++++++++++++++---
 t/t1506-rev-parse-diagnosis.sh | 14 ++++++++++++++
 2 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/setup.c b/setup.c
index e2a479a64f..12228c0d9c 100644
--- a/setup.c
+++ b/setup.c
@@ -197,9 +197,26 @@ static void NORETURN die_verify_filename(struct repository *r,
  */
 static int looks_like_pathspec(const char *arg)
 {
-	/* anything with a wildcard character */
-	if (!no_wildcard(arg))
-		return 1;
+	const char *p;
+	int escaped = 0;
+
+	/*
+	 * Wildcard characters imply the user is looking to match pathspecs
+	 * that aren't in the filesystem. Note that this doesn't include
+	 * backslash even though it's a glob special; by itself it doesn't
+	 * cause any increase in the match. Likewise ignore backslash-escaped
+	 * wildcard characters.
+	 */
+	for (p = arg; *p; p++) {
+		if (escaped) {
+			escaped = 0;
+		} else if (is_glob_special(*p)) {
+			if (*p == '\\')
+				escaped = 1;
+			else
+				return 1;
+		}
+	}
 
 	/* long-form pathspec magic */
 	if (starts_with(arg, ":("))
diff --git a/t/t1506-rev-parse-diagnosis.sh b/t/t1506-rev-parse-diagnosis.sh
index 6d951ca015..8a75f37a11 100755
--- a/t/t1506-rev-parse-diagnosis.sh
+++ b/t/t1506-rev-parse-diagnosis.sh
@@ -222,4 +222,18 @@ test_expect_success 'reject Nth ancestor if N is too high' '
 	test_must_fail git rev-parse HEAD~100000000000000000000000000000000
 '
 
+test_expect_success 'pathspecs with wildcards are not ambiguous' '
+	echo "*.c" >expect &&
+	git rev-parse "*.c" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'backslash does not trigger wildcard rule' '
+	test_must_fail git rev-parse "foo\\bar"
+'
+
+test_expect_success 'escaped char does not trigger wildcard rule' '
+	test_must_fail git rev-parse "foo\\*bar"
+'
+
 test_done
-- 
2.25.0.421.gb74d19af79

