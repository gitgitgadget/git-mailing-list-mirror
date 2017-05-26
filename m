Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 828EE1FA14
	for <e@80x24.org>; Fri, 26 May 2017 19:11:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S944602AbdEZTLW (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 May 2017 15:11:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:58616 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754458AbdEZTKd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2017 15:10:33 -0400
Received: (qmail 21870 invoked by uid 109); 26 May 2017 19:10:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 May 2017 19:10:33 +0000
Received: (qmail 32204 invoked by uid 111); 26 May 2017 19:11:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 May 2017 15:11:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 May 2017 15:10:31 -0400
Date:   Fri, 26 May 2017 15:10:31 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH 5/6] verify_filename(): treat ":(magic)" as a pathspec
Message-ID: <20170526191031.vqvkdkdp6kv6krgo@sigill.intra.peff.net>
References: <20170526190607.jr44oygs6mzm3q6e@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170526190607.jr44oygs6mzm3q6e@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For commands that take revisions and pathspecs, magic
pathspecs like ":(exclude)foo" require the user to specify
a disambiguating "--", since they do not match a file in the
filesystem, like:

  git grep foo -- :(exclude)bar

This makes them more annoying to use than they need to be.
We loosened the rules for wildcards in 28fcc0b71 (pathspec:
avoid the need of "--" when wildcard is used, 2015-05-02).
Let's do the same for pathspecs with long-form magic.

We already handle the short-forms ":/" and ":^" specially in
check_filename(), so we don't need to handle them here. And
in fact, we could do the same with long-form magic, parsing
out the actual filename and making sure it exists. But there
are a few reasons not to do it that way:

  - the parsing gets much more complicated, and we'd want to
    hand it off to the pathspec code. But that code isn't
    ready to do this kind of speculative parsing (it's happy
    to die() when it sees a syntactically invalid pathspec).

  - not all pathspec magic maps to a filesystem path. E.g.,
    :(attr) should be treated as a pathspec regardless of
    what is in the filesystem

  - we can be a bit looser with ":(" than with the
    short-form ":/", because it is much less likely to have
    a false positive. Whereas ":/" also means "search for a
    commit with this regex".

Note that because the change is in verify_filename() and not
in its helper check_filename(), this doesn't affect the
verify_non_filename() case. I.e., if an item that matches
our new rule doesn't resolve as an object, we may fallback
to treating it as a pathspec (rather than complaining it
doesn't exist). But if it does resolve (e.g., as a file in
the index that starts with an open-paren), we won't then
complain that it's also a valid pathspec. This matches the
wildcard-exception behavior.

And of course in either case, one can always insert the "--"
to get more precise results.

Signed-off-by: Jeff King <peff@peff.net>
---
 setup.c                       | 20 +++++++++++++++++++-
 t/t4208-log-magic-pathspec.sh | 13 +++++++++++++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/setup.c b/setup.c
index 86bb7c9a9..89fcc12ab 100644
--- a/setup.c
+++ b/setup.c
@@ -185,6 +185,24 @@ static void NORETURN die_verify_filename(const char *prefix,
 
 }
 
+/*
+ * Check for arguments that don't resolve as actual files,
+ * but which look sufficiently like pathspecs that we'll consider
+ * them such for the purposes of rev/pathspec DWIM parsing.
+ */
+static int looks_like_pathspec(const char *arg)
+{
+	/* anything with a wildcard character */
+	if (!no_wildcard(arg))
+		return 1;
+
+	/* long-form pathspec magic */
+	if (starts_with(arg, ":("))
+		return 1;
+
+	return 0;
+}
+
 /*
  * Verify a filename that we got as an argument for a pathspec
  * entry. Note that a filename that begins with "-" never verifies
@@ -211,7 +229,7 @@ void verify_filename(const char *prefix,
 {
 	if (*arg == '-')
 		die("bad flag '%s' used after filename", arg);
-	if (check_filename(prefix, arg) || !no_wildcard(arg))
+	if (check_filename(prefix, arg) || looks_like_pathspec(arg))
 		return;
 	die_verify_filename(prefix, arg, diagnose_misspelt_rev);
 }
diff --git a/t/t4208-log-magic-pathspec.sh b/t/t4208-log-magic-pathspec.sh
index 67250ebdc..25129dfa0 100755
--- a/t/t4208-log-magic-pathspec.sh
+++ b/t/t4208-log-magic-pathspec.sh
@@ -65,6 +65,19 @@ test_expect_success  '"git log :!sub" behaves the same as :^' '
 	test_must_fail git log :!does-not-exist
 '
 
+test_expect_success '"git log :(exclude)sub" is not ambiguous' '
+	git log ":(exclude)sub"
+'
+
+test_expect_success '"git log :(exclude)sub --" must resolve as an object' '
+	test_must_fail git log ":(exclude)sub" --
+'
+
+test_expect_success '"git log :(unknown-magic) complains of bogus magic' '
+	test_must_fail git log ":(unknown-magic)" 2>error &&
+	test_i18ngrep pathspec.magic error
+'
+
 test_expect_success 'command line pathspec parsing for "git log"' '
 	git reset --hard &&
 	>a &&
-- 
2.13.0.496.ge44ba89db

