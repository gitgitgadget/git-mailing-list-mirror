Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37D3C433EF
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 22:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9125C61051
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 22:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236357AbhILWkm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Sep 2021 18:40:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:45710 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231251AbhILWkm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Sep 2021 18:40:42 -0400
Received: (qmail 17068 invoked by uid 109); 12 Sep 2021 22:39:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 12 Sep 2021 22:39:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2954 invoked by uid 111); 12 Sep 2021 22:39:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 12 Sep 2021 18:39:26 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 12 Sep 2021 18:39:26 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] difftool: use "struct strvec" API in
 run_{dir,file}_diff()
Message-ID: <YT6BnnXeAWn8BycF@coredump.intra.peff.net>
References: <cover-0.2-00000000000-20210911T182009Z-avarab@gmail.com>
 <patch-1.2-e7481eb0c0c-20210911T182009Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.2-e7481eb0c0c-20210911T182009Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 11, 2021 at 08:21:11PM +0200, Ævar Arnfjörð Bjarmason wrote:

> The underlying run_command() API can take either the "struct strvec
> args", or a "const char **argv". Let's move to the former to use the
> more "native" version of run_command() in both of these functions.

It sounds like we're moving to use child.args (the strvec interface)
instead of child.argv (the const char one). Which I support; I'd like to
eventually get rid of the argv interface entirely because it has
memory-ownership semantics that are easy to get wrong.

But this...

> @@ -393,10 +393,8 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
>  	child.clean_on_exit = 1;
>  	child.dir = prefix;
>  	child.out = -1;
> -	strvec_pushl(&child.args, "diff", "--raw", "--no-abbrev", "-z",
> -		     NULL);
> -	for (i = 0; i < argc; i++)
> -		strvec_push(&child.args, argv[i]);
> +	child.argv = args->v;
> +

...is going in the opposite direction.

I'd much rather see us continue to use child.args here, like:

  strvec_pushv(&child.args, args->v);

Though really I do think passing the strvec into run_dir_diff() is
questionable in the first place. The caller depends on us to free the
memory in the strvec for them, which is...subtle.

It does let you immediately return here:

>  	if (dir_diff)
> -		return run_dir_diff(extcmd, symlinks, prefix, argc, argv);
> -	return run_file_diff(prompt, prefix, argc, argv);
> +		return run_dir_diff(extcmd, symlinks, prefix, &args);
> +	return run_file_diff(prompt, prefix, &args);

without doing any cleanup. But I think just:

  if (dir_diff)
	ret = run_dir_diff(...);
  else
	ret = run_file_diff(...);

  strvec_clear(&args);
  return ret;

would be a lot more obvious.

I almost suggested that this could be done even simpler by having the
caller pass in one of two pre-made argv lists (in addition to what's in
the original argv). But the _actual_ benefit you want here is making it
easy to construct those lists in the shared code of the caller. Your
commit message didn't at all make that clear (so to me it looked like
your "cleanup" was actively making things worse).

It only becomes apparent with the second patch. I would have found it
much easier to understand with something like the patch below. And then
a further patch to use strvec_pushv instead of manually looping (even
getting rid of the argc parameters entirely!), and one to convert
run_file_diff() to use a struct child_process (which fixes its memory
leak).


-- >8 --
difftool: prepare "diff" cmdline in cmd_difftool()

We call into either run_dir_diff() or run_file_diff(), each of which
sets up a child argv starting with "diff" and some hard-coded options
(depending on which mode we're using). Let's extract that logic into the
caller, which will make it easier to modify the options for cases which
affect both functions.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/difftool.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index 6a9242a803..91a8e51b0c 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -393,8 +393,6 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 	child.clean_on_exit = 1;
 	child.dir = prefix;
 	child.out = -1;
-	strvec_pushl(&child.args, "diff", "--raw", "--no-abbrev", "-z",
-		     NULL);
 	for (i = 0; i < argc; i++)
 		strvec_push(&child.args, argv[i]);
 	if (start_command(&child))
@@ -683,7 +681,6 @@ static int run_file_diff(int prompt, const char *prefix,
 		env[2] = "GIT_DIFFTOOL_NO_PROMPT=true";
 
 
-	strvec_push(&args, "diff");
 	for (i = 0; i < argc; i++)
 		strvec_push(&args, argv[i]);
 	return run_command_v_opt_cd_env(args.v, RUN_GIT_CMD, prefix, env);
@@ -719,6 +716,7 @@ int cmd_difftool(int argc, const char **argv, const char *prefix)
 		OPT_ARGUMENT("no-index", &no_index, N_("passed to `diff`")),
 		OPT_END()
 	};
+	struct strvec args = STRVEC_INIT;
 
 	git_config(difftool_config, NULL);
 	symlinks = has_symlinks;
@@ -768,7 +766,12 @@ int cmd_difftool(int argc, const char **argv, const char *prefix)
 	 * will invoke a separate instance of 'git-difftool--helper' for
 	 * each file that changed.
 	 */
+	strvec_push(&args, "diff");
+	if (dir_diff)
+		strvec_pushl(&args, "--raw", "--no-abbrev", "-z", NULL);
+	strvec_pushv(&args, argv);
+
 	if (dir_diff)
-		return run_dir_diff(extcmd, symlinks, prefix, argc, argv);
-	return run_file_diff(prompt, prefix, argc, argv);
+		return run_dir_diff(extcmd, symlinks, prefix, args.nr, args.v);
+	return run_file_diff(prompt, prefix, args.nr, args.v);
 }
-- 
2.33.0.811.g40f7f3a89c
