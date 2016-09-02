Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C0571F859
	for <e@80x24.org>; Fri,  2 Sep 2016 08:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751218AbcIBIEW (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 04:04:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:36991 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750979AbcIBIEU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 04:04:20 -0400
Received: (qmail 7150 invoked by uid 109); 2 Sep 2016 08:04:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 02 Sep 2016 08:04:18 +0000
Received: (qmail 23578 invoked by uid 111); 2 Sep 2016 08:04:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 02 Sep 2016 04:04:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Sep 2016 04:04:17 -0400
Date:   Fri, 2 Sep 2016 04:04:17 -0400
From:   Jeff King <peff@peff.net>
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
Cc:     doak <doak@gmx.de>, "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: bug: 'core.logallrefupdates' is not set by default in non-bare
 repository
Message-ID: <20160902080416.jmrctu3onfmylmeq@sigill.intra.peff.net>
References: <c46d36ef-3c2e-374f-0f2e-ffe31104e023@gmx.de>
 <1472634746.4265.47.camel@kaarsemaker.net>
 <20160831104825.quyqb54bo5k7fdxs@sigill.intra.peff.net>
 <1472657553.4265.63.camel@kaarsemaker.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1472657553.4265.63.camel@kaarsemaker.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 31, 2016 at 05:32:33PM +0200, Dennis Kaarsemaker wrote:

> > We may need to do something like turn off the
> > need_shared_repository_from_config in init-db, since I think it would
> > not want to ever read from the default config sources in most of its
> > code-paths (OTOH, it should in theory respect core.sharedRepository
> > in ~/.gitconfig, so maybe there is another more elegant way of
> > handling this).
> 
> I would go even further and say that git init should completely ignore
> the config of a repository you happen to be in when creating a new
> repository.

Hmm. I'd think we would already be avoiding that, because we shouldn't
be calling setup_git_directory(). But some of the lazy-loaded setup is a
bit overzealous, and we blindly look at ".git/config". If we try the
same operation from a subdir of an existing repo, we _don't_ end up
confused. Eek.

So I actually wonder if that is the root of the bug. In your patch, you
disable config reading when we chdir to the new repo:

> diff --git a/builtin/init-db.c b/builtin/init-db.c
> index 3a45f0b..d0fd3dc 100644
> --- a/builtin/init-db.c
> +++ b/builtin/init-db.c
> @@ -493,6 +493,12 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
>  		int mkdir_tried = 0;
>  	retry:
>  		if (chdir(argv[0]) < 0) {
> +			/*
> +			 * We're creating a new repository. If we're already in another
> +			 * repository, ignore its config
> +			 */
> +			ignore_repo_config = 1;
> +			git_config_clear();

But I think we should go further and avoid ever looking at the original
repository in the first place. I.e., I would say that "git init" should
never ever behave differently if run in an existing repo versus outside
of one.

So really we ought to be setting ignore_repo_config from the very start
of cmd_init(), and then re-enabling it once we are "inside" the new
repo.  The git_config_clear() should in theory come once we are
"inside", as well; we may have cached system/global config, and
need to flush so we read them anew along with the new local config.

OTOH, since there shouldn't be anything interesting in the new
repo-level config, I'm not sure that's really necessary. The rest of
"init" can probably proceed without caring.

I also wonder if there are other things besides config which might
accidentally read from .git (because they call git_pathdup(), and it
just blindly looks in ".git" if nobody called setup_git_directory()). So
it would be nice to have some flag for "do not ever lazy-call
setup_git_env; we do not care about any repository".  But I think that's
ahrd; functions like git_pathdup() are always expected to return _some_
value, so what would they say? The best we could do is return
"/does-not-exist/" or something, but that is awfully hacky.

> @@ -500,7 +506,6 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
>  				 * and we know shared_repository should always be 0;
>  				 * but just in case we play safe.
>  				 */
> -				saved = get_shared_repository();
>  				set_shared_repository(0);
>  				switch (safe_create_leading_directories_const(argv[0])) {
>  				case SCLD_OK:

I don't know if anybody cares about being able to set core.sharedRepository
from ~/.gitconfig. It didn't work until v2.9.0 anyway (when I moved it
out of the repository-format check), but it seems like you _should_ be
able to set it and have it Just Work.

And in that case, this "we know shared_repository should always be 0" is
not true, and we would want to keep doing the save/set-to-0/restore
dance here.

> @@ -524,6 +528,11 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
>  	} else if (0 < argc) {
>  		usage(init_db_usage[0]);
>  	}
> +
> +	need_shared_repository_from_config = 1;
> +	ignore_repo_config = 0;
> +	git_config_clear();

This is the part I think we could actually skip. The only thing we might
not have loaded is the "config" we just wrote to the new repository. But
I don't think we have to care about what is in it.

> diff --git a/config.c b/config.c
> index 0dfed68..2df0189 100644
> --- a/config.c
> +++ b/config.c
> @@ -1304,7 +1304,7 @@ static int do_git_config_sequence(config_fn_t fn, void *data)
>  		ret += git_config_from_file(fn, user_config, data);
>  
>  	current_parsing_scope = CONFIG_SCOPE_REPO;
> -	if (repo_config && !access_or_die(repo_config, R_OK, 0))
> +	if (repo_config && !ignore_repo_config && !access_or_die(repo_config, R_OK, 0))
>  		ret += git_config_from_file(fn, repo_config, data);

We probably want to intercept the call to git_pathdup() earlier than
this, if the point is not to touch any of the lazy-load setup_git_dir()
stuff at all. The effect is the same for config, but I think it makes
sense to have as little effect as possible.

So here's the minimal fix that seems to work for me:

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 3a45f0b..56e7b9a 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -484,6 +484,8 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
+	ignore_repo_config = 1;
+
 	argc = parse_options(argc, argv, prefix, init_db_options, init_db_usage, 0);
 
 	if (real_git_dir && !is_absolute_path(real_git_dir))
diff --git a/cache.h b/cache.h
index b780a91..13b78e4 100644
--- a/cache.h
+++ b/cache.h
@@ -1582,6 +1582,13 @@ enum config_origin_type {
 	CONFIG_ORIGIN_CMDLINE
 };
 
+/*
+ * If non-zero, git_config() will avoid any attempt to find the repo config;
+ * this is useful for programs like git-init that might look at config before
+ * actually setting up the new repository.
+ */
+extern int ignore_repo_config;
+
 typedef int (*config_fn_t)(const char *, const char *, void *);
 extern int git_default_config(const char *, const char *, void *);
 extern int git_config_from_file(config_fn_t fn, const char *, void *);
diff --git a/config.c b/config.c
index 0dfed68..c9fc62e 100644
--- a/config.c
+++ b/config.c
@@ -14,6 +14,8 @@
 #include "string-list.h"
 #include "utf8.h"
 
+int ignore_repo_config;
+
 struct config_source {
 	struct config_source *prev;
 	union {
@@ -1289,7 +1291,7 @@ static int do_git_config_sequence(config_fn_t fn, void *data)
 	int ret = 0;
 	char *xdg_config = xdg_config_home("config");
 	char *user_config = expand_user_path("~/.gitconfig");
-	char *repo_config = git_pathdup("config");
+	char *repo_config = ignore_repo_config ? NULL : git_pathdup("config");;
 
 	current_parsing_scope = CONFIG_SCOPE_SYSTEM;
 	if (git_config_system() && !access_or_die(git_etc_gitconfig(), R_OK, 0))
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index a6fdd5e..8efddaa 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -384,4 +384,13 @@ test_expect_success MINGW 'bare git dir not hidden' '
 	! is_hidden newdir
 '
 
+test_expect_success 'init from existing directory does not confuse config' '
+	rm -rf newdir &&
+	test_config core.logallrefupdates true &&
+	git init newdir &&
+	echo true >expect &&
+	git -C newdir config --bool core.logallrefupdates >actual &&
+	test_cmp expect actual
+'
+
 test_done


