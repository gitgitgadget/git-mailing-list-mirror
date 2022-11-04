Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15001C4332F
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 09:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiKDJp5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 05:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiKDJp4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 05:45:56 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B569E0C
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 02:45:54 -0700 (PDT)
Received: (qmail 18439 invoked by uid 109); 4 Nov 2022 09:45:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 04 Nov 2022 09:45:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27775 invoked by uid 111); 4 Nov 2022 09:45:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 04 Nov 2022 05:45:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 4 Nov 2022 05:45:52 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>
Cc:     Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
Subject: Re: "git bisect run" strips "--log" from the list of arguments
Message-ID: <Y2TfUFkLUa2tHdS7@coredump.intra.peff.net>
References: <1cb1c033-0525-7e62-8c09-81019bf26060@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1cb1c033-0525-7e62-8c09-81019bf26060@redhat.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 04, 2022 at 07:31:26AM +0100, Lukáš Doktor wrote:

> Steps to Reproduce:
> 
> 1. git bisect start BAD GOOD
> 2. git bisect run ./myscript arg1 --log arg2 --log -- arg3 --log arg4
> 
> Results with 2.34.1:
> 
>     running  './myscript' 'arg1' 'arg2' '--' 'arg3' '--log' 'arg4'
> 
> Results with 2.33.0:
> 
>     running ./myscript arg1 --log arg2 --log -- arg3 --log arg4

Thanks for an easy reproduction recipe. I used this as an easy-to-see
test case, which works in any repo:

  git bisect start HEAD HEAD~2 >/dev/null 2>&1
  git bisect bisect run echo --log 2>&1 | grep running

> Is this expected? In https://bugzilla.redhat.com/show_bug.cgi?id=2139883 Todd suggested it might be related to
> 
>     d1bbbe45df (bisect--helper: reimplement `bisect_run` shell function in C, 2021-09-13) 
> 
> but I haven't tried it myself.

Yes, it bisects to that commit. +cc Christian, who mentored this gsoc
project.

I think the problem is that we are now feeding the arguments to
parse_options() in git bisect--helper, and it doesn't realize that it
needs to stop after seeing that we are in "run" mode.  And because
"--log" is an option to git-bisect--helper (it is the opposite of
"--no-log"), it is consumed there.

As you noticed, the "--" stops parsing, so the one between "arg3" and
"arg4" is preserved.

It feels like the invocation of bisect--helper ought to be passing "--"
itself to indicate the end of options, like:

diff --git a/git-bisect.sh b/git-bisect.sh
index 405cf76f2a..bd69e8d389 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -75,7 +75,7 @@ case "$#" in
 	log)
 		git bisect--helper --bisect-log || exit ;;
 	run)
-		git bisect--helper --bisect-run "$@" || exit;;
+		git bisect--helper --bisect-run -- "$@" || exit;;
 	terms)
 		git bisect--helper --bisect-terms "$@" || exit;;
 	*)

but there are two oddities:

  1. We use PARSE_OPT_KEEP_DASHDASH, so it ends up in the final command.
     We might be able to drop that; it goes back to 06f5608c14
     (bisect--helper: `bisect_start` shell function partially in C,
     2019-01-02), but I'm not sure which other modes might be relying on
     it.

  2. We are forwarding "$@" from the user. I'm not sure if they would
     ever use "--" themselves to signal end of options. We might be OK
     because "bisect run" does not take any other options (as far as I
     know), so nobody would ever need to do that. I.e., I don't think
     anybody would do:

       git bisect run -- mycommand

     because it will treat the "--" literally as a command name.

So we could possibly just add it in the script as above, and then
unconditionally eat it in the C program. I.e., add this hunk:

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 28ef7ec2a4..2d6c77df2e 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1377,6 +1377,11 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		res = bisect_visualize(&terms, argv, argc);
 		break;
 	case BISECT_RUN:
+		/* consume "--" added by git-bisect.sh, but left by parse-options */
+		if (argc) {
+			argc--;
+			argv++;
+		}
 		if (!argc)
 			return error(_("bisect run failed: no command provided."));
 		get_terms(&terms);

It feels a bit hacky, but I think it would work, and there's no
possibility of disrupting the other modes.

The other option is probably an elaborate parse-options callback, like
the diff below. But it's pretty horrible, too.

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 28ef7ec2a4..16f71fd59c 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1277,22 +1277,49 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
 	return res;
 }
 
+enum bisect_cmdmode {
+	BISECT_RESET = 1,
+	BISECT_NEXT_CHECK,
+	BISECT_TERMS,
+	BISECT_START,
+	BISECT_AUTOSTART,
+	BISECT_NEXT,
+	BISECT_STATE,
+	BISECT_LOG,
+	BISECT_REPLAY,
+	BISECT_SKIP,
+	BISECT_VISUALIZE,
+	BISECT_RUN,
+};
+
+static int run_argc;
+static const char **run_argv;
+
+static int parse_opt_bisect_run(struct parse_opt_ctx_t *ctx,
+				const struct option *opt,
+				const char *arg, int unset)
+{
+	enum bisect_cmdmode *cmdmode = opt->value;
+
+	BUG_ON_OPT_ARG(arg);
+	BUG_ON_OPT_NEG(unset);
+
+	*cmdmode = BISECT_RUN;
+	/*
+	 * Yuck, parse-options has no way to say "done, and stop parsing";
+	 * it will keep going if we still have any argc left. So we have to
+	 * stash the rest of the options ourselves.
+	 */
+	run_argc = ctx->argc - 1;
+	run_argv = ctx->argv + 1;
+	ctx->argc = 1;
+
+	return 0;
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
-	enum {
-		BISECT_RESET = 1,
-		BISECT_NEXT_CHECK,
-		BISECT_TERMS,
-		BISECT_START,
-		BISECT_AUTOSTART,
-		BISECT_NEXT,
-		BISECT_STATE,
-		BISECT_LOG,
-		BISECT_REPLAY,
-		BISECT_SKIP,
-		BISECT_VISUALIZE,
-		BISECT_RUN,
-	} cmdmode = 0;
+	enum bisect_cmdmode cmdmode = 0;
 	int res = 0, nolog = 0;
 	struct option options[] = {
 		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
@@ -1315,8 +1342,10 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("skip some commits for checkout"), BISECT_SKIP),
 		OPT_CMDMODE(0, "bisect-visualize", &cmdmode,
 			 N_("visualize the bisection"), BISECT_VISUALIZE),
-		OPT_CMDMODE(0, "bisect-run", &cmdmode,
-			 N_("use <cmd>... to automatically bisect"), BISECT_RUN),
+		{OPTION_LOWLEVEL_CALLBACK, 0, "bisect-run", &cmdmode, NULL,
+			 N_("use <cmd>... to automatically bisect"),
+			 PARSE_OPT_NOARG|PARSE_OPT_NONEG,
+			 NULL, 0, parse_opt_bisect_run},
 		OPT_BOOL(0, "no-log", &nolog,
 			 N_("no log for BISECT_WRITE")),
 		OPT_END()
@@ -1377,10 +1406,10 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		res = bisect_visualize(&terms, argv, argc);
 		break;
 	case BISECT_RUN:
-		if (!argc)
+		if (!run_argc)
 			return error(_("bisect run failed: no command provided."));
 		get_terms(&terms);
-		res = bisect_run(&terms, argv, argc);
+		res = bisect_run(&terms, run_argv, run_argc);
 		break;
 	default:
 		BUG("unknown subcommand %d", cmdmode);

-Peff
