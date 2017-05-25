Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF4D9209FD
	for <e@80x24.org>; Thu, 25 May 2017 15:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424303AbdEYP1s (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 11:27:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:57949 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1424300AbdEYP1q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 11:27:46 -0400
Received: (qmail 9372 invoked by uid 109); 25 May 2017 15:27:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 25 May 2017 15:27:42 +0000
Received: (qmail 21123 invoked by uid 111); 25 May 2017 15:28:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 25 May 2017 11:28:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 May 2017 11:27:40 -0400
Date:   Thu, 25 May 2017 11:27:40 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [RFC/PATCH] recognize pathspec magic without "--" disambiguation
Message-ID: <20170525152739.t63dbsq2dojy2y2h@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For commands that take revisions and pathspecs, magic
pathspecs like ":^Documentation" or ":/Documentation" have
to appear on the right-hand side of the disambiguating "--",
like:

  git log -- :^Documentation

This makes them more annoying to use than they need to be.
We loosened the rules for wildcards in 28fcc0b71 (pathspec:
avoid the need of "--" when wildcard is used, 2015-05-02).
Let's do the same for arguments that look like pathspec
magic (colon followed by any punctuation).

The obvious and desired impact is that you can now do:

  git log :^Documentation

But let's consider related invocations and whether we're
making them better or worse:

   - git log :/foo
      (when "foo" matches a commit message)

      This one should remain the same. Like the existing
      wildcard rule, we're touching only verify_filename(),
      not verify_non_filename(). So cases that _do_ resolve
      as a rev will continue to do so.

   - git log :^foo
      (when "^foo" exists in your index)

      The same logic applies; it would continue to work. And
      ditto for any other weird filenames in your index like
      "(attr)foo".

   - git log :/foo
      (when "foo" does _not_ match a commit message)

      We won't treat this as a revision, because it doesn't
      match anything. So prior to this patch, we'd either
      treat it as a path (if "foo" does exist at the root of
      the project) or complain "this isn't a rev, and nor is
      it a path".  Whereas after this patch, we'd always
      treat it like a path, whether it exists or not (so in
      the second case instead of an error, you're likely to
      get an empty "log", unless "foo" really did exist
      somewhere in your history). So this is a potential
      downside; if the user intended a search of the commit
      messages, they may prefer the error message to the
      attempted pathspec match.

      This same downside actually exists currently when you
      have an asterisk in your regex. E.g.,

        git log :/foo.*bar

      will be treated as a pathspec (if it doesn't match a
      commit message) due to the wildcard matching in
      28fcc0b71.

   - git log :^foo
       (when "^foo" isn't in your index)

      The same outcomes apply here as above, but this
      "downside" is very unlikely to occur, as "^foo" is
      such a funny name (and again, things like "(attr)foo"
      as a filename are sufficiently uncommon not to worry
      about).

   - git log :%foo
      (or any other pathspec magic char that doesn't exist)

      The new check doesn't actually parse the pathspec
      magic, but allows any punctuation (which includes the
      long-form ":(magic)"). At first glance this seems
      overly permissive, but it actually yields a better
      error message here: instead of complaining that
      ":%foo" is neither a rev nor a path, we treat it as a
      pathspec and complain that "%" is not a known magic
      (the same as we would if the "--" were given).

      Of course, the flip side here is when you really
      meant a file named "%foo" in your index, but it didn't
      exist. That seems reasonably unlikely (and the error
      message is clear enough to point the user in the right
      direction).

So the collateral damage doesn't seem too bad (it's really
just the case where :/foo doesn't match anything). There are
two possibilities for reducing that:

  1. Instead of accepting all pathspec magic, just allow
     certain ones like ":^" which are unlikely to be used to
     specify a revision (or alternatively, just disallow
     potentially confusing ones like ":/").

     That works, but it makes the rules inconsistent and
     confusing for the user (i.e., "--" is sometimes needed
     for magic and sometimes not).

  2. Instead of recognizing pathspec magic, teach
     check_filename() to parse off the filename bit and see
     if that exists (e.g., for "^foo" see if "foo" exists).
     We already do this for ":/", but it's done in a very
     ad-hoc way. We parse it ourselves, rather than relying
     on the pathspec code, and handle only "/" magic, and
     not even its ":(top)" long form.

     That could be fixed by asking the pathspec code to
     parse it for us (including all magic), and then trying
     to match the resulting name against the working tree.
     But not all pathspec magic actually results in a
     pathname. For instance, when should ":(attr)foo" be
     valid? We can't just look for "foo" in the filesystem
     (it's an attribute, not a pathname).

     By comparison, recognizing things that look like
     pathspec magic is a simple and easy to understand rule.

Signed-off-by: Jeff King <peff@peff.net>
---
I wrote all the above to try to convince myself that this
doesn't have any serious regression cases. And I think I
did.

But I actually we could make the rules in alternative (2)
above work. check_filename() would ask the pathspec code to
parse each argument and get one of three results:

  1. it's not pathspec magic; treat it like a filename
     (e.g., just "foo", or even bogus stuff like ":%foo")

  2. it is pathspec magic, and here is the matching filename
     that ought to exist (e.g., "foo" from ":^foo" or
     ":(exclude)foo")

  3. it is pathspec magic, but there's no matching filename.
     Assume it's a pathspec (e.g., "(attr)foo").

I'm on the fence on whether it's worth the trouble versus
the simple rule implemented by this patch.

 setup.c                       | 19 ++++++++++++++++++-
 t/t4208-log-magic-pathspec.sh | 20 ++++++++++++++++++++
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/setup.c b/setup.c
index 0309c2782..1ca286e82 100644
--- a/setup.c
+++ b/setup.c
@@ -181,6 +181,23 @@ static void NORETURN die_verify_filename(const char *prefix,
 
 }
 
+/*
+ * Check for arguments that don't resolve as actual files,
+ * but which look sufficiently like pathspecs that we'll consider
+ * them such for the purposes of rev/pathspec DWIM parsing.
+ */
+static int looks_like_pathspec(const char *arg)
+{
+	if (!no_wildcard(arg))
+		return 1;
+
+	/* pathspec magic like ":^subdir" */
+	if (arg[0] == ':' && ispunct(arg[1]))
+		return 1;
+
+	return 0;
+}
+
 /*
  * Verify a filename that we got as an argument for a pathspec
  * entry. Note that a filename that begins with "-" never verifies
@@ -207,7 +224,7 @@ void verify_filename(const char *prefix,
 {
 	if (*arg == '-')
 		die("bad flag '%s' used after filename", arg);
-	if (check_filename(prefix, arg) || !no_wildcard(arg))
+	if (check_filename(prefix, arg) || looks_like_pathspec(arg))
 		return;
 	die_verify_filename(prefix, arg, diagnose_misspelt_rev);
 }
diff --git a/t/t4208-log-magic-pathspec.sh b/t/t4208-log-magic-pathspec.sh
index 001343e2f..c87dda53c 100755
--- a/t/t4208-log-magic-pathspec.sh
+++ b/t/t4208-log-magic-pathspec.sh
@@ -61,4 +61,24 @@ test_expect_success 'command line pathspec parsing for "git log"' '
 	git log --merge -- a
 '
 
+# This differs from the ":/a" check above in that :/in only _looks_
+# like a pathspec, but doesn't match an actual file. So we prefer
+# it as a rev.
+test_expect_success '"git log :/in" should not be ambiguous' '
+	git log :/in
+'
+
+test_expect_success '"git log :^sub" should not be ambiguous' '
+	git log :^sub
+'
+
+test_expect_success '"git log :(exclude)sub" should not be ambiguous' '
+	git log ":(exclude)sub"
+'
+
+test_expect_success '"git log :%foo" should complain of bad magic' '
+	test_must_fail git log :%foo 2>error &&
+	test_i18ngrep pathspec.magic error
+'
+
 test_done
-- 
2.13.0.496.ge44ba89db
