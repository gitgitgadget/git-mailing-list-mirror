Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E6E1B8
	for <git@vger.kernel.org>; Mon, 27 Nov 2023 13:22:56 -0800 (PST)
Received: (qmail 25740 invoked by uid 109); 27 Nov 2023 21:22:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 27 Nov 2023 21:22:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3862 invoked by uid 111); 27 Nov 2023 21:22:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 27 Nov 2023 16:22:57 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 27 Nov 2023 16:22:54 -0500
From: Jeff King <peff@peff.net>
To: Sven Strickroth <sven@cs-ware.de>
Cc: git <git@vger.kernel.org>
Subject: Re: --end-of-options inconsistently available?!
Message-ID: <20231127212254.GA87495@coredump.intra.peff.net>
References: <4d944fe3-d31d-4859-8ed2-6c1da64410fe@cs-ware.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4d944fe3-d31d-4859-8ed2-6c1da64410fe@cs-ware.de>

On Mon, Nov 27, 2023 at 12:22:44PM +0100, Sven Strickroth wrote:

> Hi,
> 
> gitcli(7) states:
> > Because -- disambiguates revisions and paths in some commands, it cannot be used for those commands to separate options and revisions. You can use --end-of-options for this (it also works for commands that do not distinguish between revisions in paths, in which case it is simply an alias for --).
> 
> However, when I use this for certain commands it fails:
> 
> $ git reset --end-of-options HEAD --
> fatal: option '--end-of-options' must come before non-option arguments

This one seems like a bug. Handling of --end-of-options usually happens
via the parse_options() API. But in this case, cmd_reset() calls it with
PARSE_OPT_KEEP_DASHDASH, which retains the --end-of-options marker. But
then the caller is not ready to deal with that string being left in
argv[0] (it is OK with "--", but not anything else).

So at first glance, it feels like parse-options should avoid leaving it
in place, like:

diff --git a/parse-options.c b/parse-options.c
index e0c94b0546..5c07ad47ec 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -931,7 +931,7 @@ enum parse_opt_result parse_options_step(struct parse_opt_ctx_t *ctx,
 
 		if (!arg[2] /* "--" */ ||
 		    !strcmp(arg + 2, "end-of-options")) {
-			if (!(ctx->flags & PARSE_OPT_KEEP_DASHDASH)) {
+			if (arg[2] || !(ctx->flags & PARSE_OPT_KEEP_DASHDASH)) {
 				ctx->argc--;
 				ctx->argv++;
 			}

But I think that confuses other callers. For example, t4202 fails
because we try (with a ref called refs/heads/--source) to run:

  git log --end-of-options --source

expecting it it to be resolved as a ref. With the patch above, it gets
confused. So I think we may need to teach KEEP_DASHDASH callers to
handle end-of-options themselves. In the case of git-log, it is done by
the revision machinery, but reset doesn't use that.

So something like this works:

diff --git a/builtin/reset.c b/builtin/reset.c
index 4b018d20e3..a0d801179a 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -259,6 +259,9 @@ static void parse_args(struct pathspec *pathspec,
 	 * At this point, argv points immediately after [-opts].
 	 */
 
+	if (argv[0] && !strcmp(argv[0], "--end-of-options"))
+		argv++;
+
 	if (argv[0]) {
 		if (!strcmp(argv[0], "--")) {
 			argv++; /* reset to HEAD, possibly with paths */

but it feels like a maintenance problem that we'd have to audit every
caller that uses KEEP_DASHDASH.

On the other hand, I do think the callers need to be a bit aware of the
issue to make things work seamlessly. In particular, this now does what
you'd expect:

  git reset --end-of-options foo -- bar

But if we do this:

  git reset --end-of-options --foo

it works if "--foo" can be resolved, but otherwise complains "option
'--foo' must come before non-option arguments", even if it exists as a
file! IOW, the do-what-I-mean handling of "--" is too picky; in
verify_filename() it complains about things that look like options, not
realizing we already made sure to avoid those.

OTOH that is also true of "git log --end-of-options --foo". And maybe
not that big a deal in practice. If you are truly being careful you'd
always do:

  git log --end-of-options --foo -- --bar

anyway, which is unambiguous.

So I dunno. I'm not sure there's a central fix, and we may have to just
fix this spot and look for others.

> $ git rev-parse --symbolic-full-name --end-of-options master
> --end-of-options
> refs/heads/master
> 
> Here, the output also contains "--end-of-options" as if it is a reference
> (same for "--")

This one is intentional. rev-parse in its default mode is not just
spitting out revisions, but also options that are meant to be passed
along to the revision machinery via other commands (like rev-list). So
for example:

  $ git rev-parse --foo HEAD
  --foo
  564d0252ca632e0264ed670534a51d18a689ef5d

And it does understand end-of-options explicitly, so:

  $ git rev-parse --end-of-options --foo --
  --end-of-options
  fatal: bad revision '--foo'

If you just want to parse a name robustly, use --verify.

> $ git checkout -f --end-of-options HEAD~1 -- afile.txt
> fatal: only one reference expected, 2 given.

I think this is the same KEEP_DASHDASH problem as with git-reset.

-Peff
