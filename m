Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F09B91FAF4
	for <e@80x24.org>; Tue, 14 Feb 2017 21:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753834AbdBNVyk (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 16:54:40 -0500
Received: from cloud.peff.net ([104.130.231.41]:55351 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751358AbdBNVyj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 16:54:39 -0500
Received: (qmail 24026 invoked by uid 109); 14 Feb 2017 21:54:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Feb 2017 21:54:39 +0000
Received: (qmail 7161 invoked by uid 111); 14 Feb 2017 21:54:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Feb 2017 16:54:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Feb 2017 16:54:36 -0500
Date:   Tue, 14 Feb 2017 16:54:36 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: [PATCH 8/7] grep: treat revs the same for --untracked as for
 --no-index
Message-ID: <20170214215436.kqca4c7gv2kwevw7@sigill.intra.peff.net>
References: <20170214060021.einv7372exbxa23z@sigill.intra.peff.net>
 <20170214060729.v4r24y5tuaov3jrh@sigill.intra.peff.net>
 <eef97cc4-d616-b298-bc99-b2772b757190@google.com>
 <20170214180453.tpze2hdv3eytxfju@sigill.intra.peff.net>
 <82212eaa-76d2-3357-8e06-5e4d56028c2e@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <82212eaa-76d2-3357-8e06-5e4d56028c2e@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 14, 2017 at 10:19:56AM -0800, Jonathan Tan wrote:

> > I wasn't sure if we wanted to treat "untracked" in the same way.
> > Certainly we can catch the error here for the seen_dashdash case, but is
> > it also the case that:
> > 
> >   echo content >master
> >   git grep --untracked pattern master
> > 
> > should treat "master" as a path?
> 
> It is already the case that it cannot be treated as a rev:
> 
>   $ git grep --untracked pattern master
>   fatal: --no-index or --untracked cannot be used with revs.
> 
> So I think it would be better if it was treated as a path, for consistency
> with --no-index. I'm OK either way, though.

Right, it's always been disallowed. But the early detection changes a
few user-visible behaviors like the exact error message, and how
disambiguation works (see below). I think the arguments for making that
change for --no-index are stronger than for --untracked. But it probably
makes sense for --untracked, too.

Here's a patch on top of my series that lumps the two together again. It
_could_ be squashed into the earlier patch, but I think I prefer keeping
it separate.

-- >8 --
Subject: [PATCH] grep: treat revs the same for --untracked as for --no-index

git-grep has always disallowed grepping in a tree (as
opposed to the working directory) with both --untracked
and --no-index. But we traditionally did so by first
collecting the revs, and then complaining when any were
provided.

The --no-index option recently learned to detect revs
much earlier. This has two user-visible effects:

  - we don't bother to resolve revision names at all. So
    when there's a rev/path ambiguity, we always choose to
    treat it as a path.

  - likewise, when you do specify a revision without "--",
    the error you get is "no such path" and not "--untracked
    cannot be used with revs".

The rationale for doing this with --no-index is that it is
meant to be used outside a repository, and so parsing revs
at all does not make sense.

This patch gives --untracked the same treatment. While it
_is_ meant to be used in a repository, it is explicitly
about grepping the non-repository contents. Telling the user
"we found a rev, but you are not allowed to use revs" is
not really helpful compared to "we treated your argument as
a path, and could not find it".

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/grep.c  | 10 +++++-----
 t/t7810-grep.sh |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 1454bef49..9304c33e7 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -967,6 +967,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	int dummy;
 	int use_index = 1;
 	int pattern_type_arg = GREP_PATTERN_TYPE_UNSPECIFIED;
+	int allow_revs;
 
 	struct option options[] = {
 		OPT_BOOL(0, "cached", &cached,
@@ -1165,6 +1166,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	 * to it must resolve as a rev. If not, then we stop at the first
 	 * non-rev and assume everything else is a path.
 	 */
+	allow_revs = use_index && !untracked;
 	for (i = 0; i < argc; i++) {
 		const char *arg = argv[i];
 		unsigned char sha1[20];
@@ -1176,9 +1178,9 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			break;
 		}
 
-		if (!use_index) {
+		if (!allow_revs) {
 			if (seen_dashdash)
-				die(_("--no-index cannot be used with revs"));
+				die(_("--no-index or --untracked cannot be used with revs"));
 			break;
 		}
 
@@ -1201,7 +1203,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	if (!seen_dashdash) {
 		int j;
 		for (j = i; j < argc; j++)
-			verify_filename(prefix, argv[j], j == i && use_index);
+			verify_filename(prefix, argv[j], j == i && allow_revs);
 	}
 
 	parse_pathspec(&pathspec, 0,
@@ -1273,8 +1275,6 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 
 	if (!use_index || untracked) {
 		int use_exclude = (opt_exclude < 0) ? use_index : !!opt_exclude;
-		if (list.nr)
-			die(_("--no-index or --untracked cannot be used with revs."));
 		hit = grep_directory(&opt, &pathspec, use_exclude, use_index);
 	} else if (0 <= opt_exclude) {
 		die(_("--[no-]exclude-standard cannot be used for tracked contents."));
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 0ff9f6cae..cee42097b 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -1032,7 +1032,7 @@ test_expect_success 'grep --no-index pattern -- path' '
 
 test_expect_success 'grep --no-index complains of revs' '
 	test_must_fail git grep --no-index o master -- 2>err &&
-	test_i18ngrep "no-index cannot be used with revs" err
+	test_i18ngrep "cannot be used with revs" err
 '
 
 test_expect_success 'grep --no-index prefers paths to revs' '
-- 
2.12.0.rc1.479.g59880b11e

