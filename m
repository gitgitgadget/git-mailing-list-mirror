From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] submodule: stop sanitizing config options
Date: Wed, 4 May 2016 21:22:19 -0400
Message-ID: <20160505012219.GA15090@sigill.intra.peff.net>
References: <cover.1461837783.git.johannes.schindelin@gmx.de>
 <cover.1462342213.git.johannes.schindelin@gmx.de>
 <20160504062618.GA9849@sigill.intra.peff.net>
 <20160504074559.GA3077@sigill.intra.peff.net>
 <20160504080047.GA2436@sigill.intra.peff.net>
 <CAGZ79kaUiVLuXvpLPKuZZ55zbQXA3Wt7WP3a_65gBW2Cj-gMoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu May 05 03:22:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay7zp-00030s-71
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 03:22:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755123AbcEEBWY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 21:22:24 -0400
Received: from cloud.peff.net ([50.56.180.127]:34427 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754726AbcEEBWW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 21:22:22 -0400
Received: (qmail 17891 invoked by uid 102); 5 May 2016 01:22:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 May 2016 21:22:22 -0400
Received: (qmail 16142 invoked by uid 107); 5 May 2016 01:22:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 May 2016 21:22:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 May 2016 21:22:19 -0400
Content-Disposition: inline
In-Reply-To: <CAGZ79kaUiVLuXvpLPKuZZ55zbQXA3Wt7WP3a_65gBW2Cj-gMoQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293630>

On Wed, May 04, 2016 at 03:53:26PM -0700, Stefan Beller wrote:

> > I think we'd actually do it all in one, and that patch looks something
> > like the one below (on top of jk/submodule-config-sanitize-fix).
> 
>     $ git checkout origin/jk/submodule-config-sanitize-fix
>     $ git am p
> Applying: submodule: stop sanitizing config options
> error: patch failed: builtin/submodule--helper.c:246
> error: builtin/submodule--helper.c: patch does not apply
> error: patch failed: submodule.c:1131
> error: submodule.c: patch does not apply
> Patch failed at 0001 submodule: stop sanitizing config options
> 
> So if you want some documentation on top of that, where would I base it on?

I build the patches for jk/submodule-config-sanitize-fix on top of
master as of the other day, and then built this most recent patch on top
of that.

Looks like Junio applied them directly on the tip of
jk/submodule-c-credential, and had to wiggle the code in submodule.c,
which conflicted with the parallel-process stuff that was merged in
between. Since the new patch updates that code, it will likewise run
into conflicts.

I don't think there's a strict right answer here; if the original buggy
submodule-c-credential code had been released, we would definitely want
to build off of it for "maint" releases. But it wasn't, so master is
"just as good" in a sense. But I think Junio makes it a habit to apply
fixes as far back as the introduced bug, even when it's not going to
maint.

So since that's what published, it makes sense to build on that. Here's
a version of my patch that should apply for you (no semantic changes,
just differences in the surrounding context):

-- >8 --
Subject: [PATCH] submodule: stop sanitizing config options

The point of having a whitelist of command-line config
options to pass to submodules was two-fold:

  1. It prevented obvious nonsense like using core.worktree
     for multiple repos.

  2. It could prevent surprise when the user did not mean
     for the options to leak to the submodules (e.g.,
     http.sslverify=false).

For case 1, the answer is mostly "if it hurts, don't do
that". For case 2, we can note that any such example has a
matching inverted surprise (e.g., a user who meant
http.sslverify=true to apply everywhere, but it didn't).

So this whitelist is probably not giving us any benefit, and
is already creating a hassle as people propose things to put
on it. Let's just drop it entirely.

Note that we still need to keep a special code path for
"prepare the submodule environment", because we still have
to take care to pass through $GIT_CONFIG_PARAMETERS (and
block the rest of the repo-specific environment variables).

We can do this easily from within the submodule shell
script, which lets us drop the submodule--helper option
entirely (and it's OK to do so because as a "--" program, it
is entirely a private implementation detail).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/submodule--helper.c  | 17 -----------------
 git-submodule.sh             |  4 ++--
 submodule.c                  | 39 +--------------------------------------
 t/t7412-submodule--helper.sh | 26 --------------------------
 4 files changed, 3 insertions(+), 83 deletions(-)
 delete mode 100755 t/t7412-submodule--helper.sh

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 16d6432..89250f0 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -260,22 +260,6 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
-static int module_sanitize_config(int argc, const char **argv, const char *prefix)
-{
-	struct strbuf sanitized_config = STRBUF_INIT;
-
-	if (argc > 1)
-		usage(_("git submodule--helper sanitize-config"));
-
-	git_config_from_parameters(sanitize_submodule_config, &sanitized_config);
-	if (sanitized_config.len)
-		printf("%s\n", sanitized_config.buf);
-
-	strbuf_release(&sanitized_config);
-
-	return 0;
-}
-
 struct cmd_struct {
 	const char *cmd;
 	int (*fn)(int, const char **, const char *);
@@ -285,7 +269,6 @@ static struct cmd_struct commands[] = {
 	{"list", module_list},
 	{"name", module_name},
 	{"clone", module_clone},
-	{"sanitize-config", module_sanitize_config},
 };
 
 int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
diff --git a/git-submodule.sh b/git-submodule.sh
index 91f5856..b1c056c 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -197,9 +197,9 @@ isnumber()
 # of the settings from GIT_CONFIG_PARAMETERS.
 sanitize_submodule_env()
 {
-	sanitized_config=$(git submodule--helper sanitize-config)
+	save_config=$GIT_CONFIG_PARAMETERS
 	clear_local_git_env
-	GIT_CONFIG_PARAMETERS=$sanitized_config
+	GIT_CONFIG_PARAMETERS=$save_config
 	export GIT_CONFIG_PARAMETERS
 }
 
diff --git a/submodule.c b/submodule.c
index c18ab9b..d598881 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1098,50 +1098,13 @@ void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir)
 	strbuf_release(&rel_path);
 	free((void *)real_work_tree);
 }
-/*
- * Rules to sanitize configuration variables that are Ok to be passed into
- * submodule operations from the parent project using "-c". Should only
- * include keys which are both (a) safe and (b) necessary for proper
- * operation.
- */
-static int submodule_config_ok(const char *var)
-{
-	if (starts_with(var, "credential."))
-		return 1;
-	return 0;
-}
-
-int sanitize_submodule_config(const char *var, const char *value, void *data)
-{
-	struct strbuf *out = data;
-
-	if (submodule_config_ok(var)) {
-		if (out->len)
-			strbuf_addch(out, ' ');
-
-		if (value)
-			sq_quotef(out, "%s=%s", var, value);
-		else
-			sq_quote_buf(out, var);
-	}
-
-	return 0;
-}
 
 void prepare_submodule_repo_env(struct argv_array *out)
 {
 	const char * const *var;
 
 	for (var = local_repo_env; *var; var++) {
-		if (!strcmp(*var, CONFIG_DATA_ENVIRONMENT)) {
-			struct strbuf sanitized_config = STRBUF_INIT;
-			git_config_from_parameters(sanitize_submodule_config,
-						   &sanitized_config);
-			argv_array_pushf(out, "%s=%s", *var, sanitized_config.buf);
-			strbuf_release(&sanitized_config);
-		} else {
+		if (strcmp(*var, CONFIG_DATA_ENVIRONMENT))
 			argv_array_push(out, *var);
-		}
 	}
-
 }
diff --git a/t/t7412-submodule--helper.sh b/t/t7412-submodule--helper.sh
deleted file mode 100755
index 149d428..0000000
--- a/t/t7412-submodule--helper.sh
+++ /dev/null
@@ -1,26 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) 2016 Jacob Keller
-#
-
-test_description='Basic plumbing support of submodule--helper
-
-This test verifies the submodule--helper plumbing command used to implement
-git-submodule.
-'
-
-. ./test-lib.sh
-
-test_expect_success 'sanitize-config clears configuration' '
-	git -c user.name="Some User" submodule--helper sanitize-config >actual &&
-	test_must_be_empty actual
-'
-
-sq="'"
-test_expect_success 'sanitize-config keeps credential.helper' '
-	git -c credential.helper=helper submodule--helper sanitize-config >actual &&
-	echo "${sq}credential.helper=helper${sq}" >expect &&
-	test_cmp expect actual
-'
-
-test_done
-- 
2.8.2.600.g439cdc9
