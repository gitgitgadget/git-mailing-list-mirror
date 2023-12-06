Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5FEF7
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 14:21:46 -0800 (PST)
Received: (qmail 6006 invoked by uid 109); 6 Dec 2023 22:21:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 06 Dec 2023 22:21:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29131 invoked by uid 111); 6 Dec 2023 22:21:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 06 Dec 2023 17:21:47 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 6 Dec 2023 17:21:45 -0500
From: Jeff King <peff@peff.net>
To: Sven Strickroth <sven@cs-ware.de>
Cc: git <git@vger.kernel.org>
Subject: [PATCH] parse-options: decouple "--end-of-options" and "--"
Message-ID: <20231206222145.GA136253@coredump.intra.peff.net>
References: <4d944fe3-d31d-4859-8ed2-6c1da64410fe@cs-ware.de>
 <20231127212254.GA87495@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231127212254.GA87495@coredump.intra.peff.net>

On Mon, Nov 27, 2023 at 04:22:54PM -0500, Jeff King wrote:

> So something like this works:
> 
> diff --git a/builtin/reset.c b/builtin/reset.c
> index 4b018d20e3..a0d801179a 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -259,6 +259,9 @@ static void parse_args(struct pathspec *pathspec,
>  	 * At this point, argv points immediately after [-opts].
>  	 */
>  
> +	if (argv[0] && !strcmp(argv[0], "--end-of-options"))
> +		argv++;
> +
>  	if (argv[0]) {
>  		if (!strcmp(argv[0], "--")) {
>  			argv++; /* reset to HEAD, possibly with paths */
> 
> but it feels like a maintenance problem that we'd have to audit every
> caller that uses KEEP_DASHDASH.

So here's my attempt at a central fix. There is a downside (see the
discussion below), but I think in practice it should be a strict
improvement for most commands. I won't be too surprised if we find a
counter-example, but even if we do, my gut feeling is that we should fix
that command on top of this, rather than give up and require every
command to be aware of --end-of-options.

-- >8 --
Subject: [PATCH] parse-options: decouple "--end-of-options" and "--"

When we added generic end-of-options support in 51b4594b40
(parse-options: allow --end-of-options as a synonym for "--",
2019-08-06), we made them true synonyms. They both stop option parsing,
and they are both returned in the resulting argv if the KEEP_DASHDASH
flag is used.

The hope was that this would work for all callers:

  - most generic callers would not pass KEEP_DASHDASH, and so would just
    do the right thing (stop parsing there) without needing to know
    anything more.

  - callers with KEEP_DASHDASH were generally going to rely on
    setup_revisions(), which knew to handle --end-of-options specially

But that turned out miss quite a few cases that pass KEEP_DASHDASH but
do their own manual parsing. For example, "git reset", "git checkout",
and so on want pass KEEP_DASHDASH so they can support:

  git reset $revs -- $paths

but of course aren't going to actually do a traversal, so they don't
call setup_revisions(). And those cases currently get confused by
--end-of-options being left in place, like:

   $ git reset --end-of-options HEAD
   fatal: option '--end-of-options' must come before non-option arguments

We could teach each of these callers to handle the leftover option
explicitly. But let's try to be a bit more clever and see if we can
solve it centrally in parse-options.c.

The bogus assumption here is that KEEP_DASHDASH tells us the caller
wants to see --end-of-options in the result. But really, the callers
which need to know that --end-of-options was reached are those that may
potentially parse more options from argv. In other words, those that
pass the KEEP_UNKNOWN_OPT flag.

If such a caller is aware of --end-of-options (e.g., because they call
setup_revisions() with the result), then this will continue to do the
right thing, treating anything after --end-of-options as a non-option.

And if the caller is not aware of --end-of-options, they are better off
keeping it intact, because either:

  1. They are just passing the options along to somebody else anyway, in
     which case that somebody would need to know about the
     --end-of-options marker.

  2. They are going to parse the remainder themselves, at which point
     choking on --end-of-options is much better than having it silently
     removed. The point is to avoid option injection from untrusted
     command line arguments, and bailing is better than quietly treating
     the untrusted argument as an option.

This fixes bugs with --end-of-options across several commands, but I've
focused on two in particular here:

  - t7102 confirms that "git reset --end-of-options --foo" now works.
    This checks two things. One, that we no longer barf on
    "--end-of-options" itself (which previously we did, even if the rev
    was something vanilla like "HEAD" instead of "--foo"). And two, that
    we correctly treat "--foo" as a revision rather than an option.

    This fix applies to any other cases which pass KEEP_DASHDASH but not
    KEEP_UNKNOWN_OPT, like "git checkout", "git check-attr", "git grep",
    etc, which would previously choke on "--end-of-options".

  - t9350 shows the opposite case: fast-export passed KEEP_UNKNOWN_OPT
    but not KEEP_DASHDASH, but then passed the result on to
    setup_revisions(). So it never saw --end-of-options, and would
    erroneously parse "fast-export --end-of-options --foo" as having a
    "--foo" option. This is now fixed.

Note that this does shut the door for callers which want to know if we
hit end-of-options, but don't otherwise need to keep unknown opts. The
obvious thing here is feeding it to the DWIM verify_filename()
machinery. And indeed, this is a problem even for commands which do
understand --end-of-options already. For example, without this patch,
you get:

  $ git log --end-of-options --foo
  fatal: option '--foo' must come before non-option arguments

because we refuse to accept "--foo" as a filename (because it starts
with a dash) even though we could know that we saw end-of-options. The
verify_filename() function simply doesn't accept this extra information.

So that is the status quo, and this patch doubles down further on that.
Commands like "git reset" have the same problem, but they won't even
know that parse-options saw --end-of-options! So even if we fixed
verify_filename(), they wouldn't have anything to pass to it.

But in practice I don't think this is a big deal. If you are being
careful enough to use --end-of-options, then you should also be using
"--" to disambiguate and avoid the DWIM behavior in the first place. In
other words, doing:

  git log --end-of-options --this-is-a-rev -- --this-is-a-path

works correctly, and will continue to do so. And likewise, with this
patch now:

  git reset --end-of-options --this-is-a-rev -- --this-is-a-path

will work, as well.

Signed-off-by: Jeff King <peff@peff.net>
---
 parse-options.c        |  9 +++++++--
 t/t7102-reset.sh       |  8 ++++++++
 t/t9350-fast-export.sh | 10 ++++++++++
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index e0c94b0546..d50962062e 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -929,13 +929,18 @@ enum parse_opt_result parse_options_step(struct parse_opt_ctx_t *ctx,
 			continue;
 		}
 
-		if (!arg[2] /* "--" */ ||
-		    !strcmp(arg + 2, "end-of-options")) {
+		if (!arg[2] /* "--" */) {
 			if (!(ctx->flags & PARSE_OPT_KEEP_DASHDASH)) {
 				ctx->argc--;
 				ctx->argv++;
 			}
 			break;
+		} else if (!strcmp(arg + 2, "end-of-options")) {
+			if (!(ctx->flags & PARSE_OPT_KEEP_UNKNOWN_OPT)) {
+				ctx->argc--;
+				ctx->argv++;
+			}
+			break;
 		}
 
 		if (internal_help && !strcmp(arg + 2, "help-all"))
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index 4287863ae6..62d9f846ce 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -616,4 +616,12 @@ test_expect_success 'reset --mixed sets up work tree' '
 	test_must_be_empty actual
 '
 
+test_expect_success 'reset handles --end-of-options' '
+	git update-ref refs/heads/--foo HEAD^ &&
+	git log -1 --format=%s refs/heads/--foo >expect &&
+	git reset --hard --end-of-options --foo &&
+	git log -1 --format=%s HEAD >actual &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 26c25c0eb2..e9a12c18bb 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -791,4 +791,14 @@ test_expect_success 'fast-export --first-parent outputs all revisions output by
 	)
 '
 
+test_expect_success 'fast-export handles --end-of-options' '
+	git update-ref refs/heads/nodash HEAD &&
+	git update-ref refs/heads/--dashes HEAD &&
+	git fast-export --end-of-options nodash >expect &&
+	git fast-export --end-of-options --dashes >actual.raw &&
+	# fix up lines which mention the ref for comparison
+	sed s/--dashes/nodash/ <actual.raw >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.43.0.664.ga12c899002

