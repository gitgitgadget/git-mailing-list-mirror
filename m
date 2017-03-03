Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3ACD20279
	for <e@80x24.org>; Fri,  3 Mar 2017 17:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752064AbdCCRcc (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 12:32:32 -0500
Received: from mout.gmx.net ([212.227.15.15]:57022 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751637AbdCCRcL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 12:32:11 -0500
Received: from virtualbox ([89.204.154.17]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lt2BW-1cHhGW0Zgo-012WoB; Fri, 03
 Mar 2017 18:31:58 +0100
Date:   Fri, 3 Mar 2017 18:31:55 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH v3 0/9] Fix the early config
In-Reply-To: <cover.1488506615.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1488562287.git.johannes.schindelin@gmx.de>
References: <cover.1488506615.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:VC//50taxOBqsvCBNr56OjqUPxJcy5akuN4xdwMJevtOF/VMeXi
 CuLd5nZ3w6wZRYIyVXst6eB++ho2H+swkmUZHbQo9Ojjozy/vjJbvryMlEJLKbvskg2k0QF
 f2XDCg2asCsnrHAA/Tuw7aERIR55oID0/A4OmagF61NE6eP5rY80O5vKyjm/wNP+DjxWXD7
 9jqXlbJQ+EXOc92GCgUyA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TwuODfCyazc=:0Wd6miP/M/Z96gii0dNwC3
 WZAIPeP9hFu6tSu9aETG5RGvTUXII8fn/HZxiacN0dgukeeLQ2SrTDIxHfvcxHtSFwBvDNptc
 feB7GGVPjYiByB7jx8v4O3d7HfooSWQomB0Nd90f9odTBFOjlpFS64e/2dP3RU5eYp7HGiabg
 EMLtuRR8sOBeWw9AdFtc71aOjKFlyuto4XT8RMXgVxoEaNYqhQuIGgPRIFil5IxW/atbosUm2
 R9lqVRA63HUEE9Z9SHBjvT0pEI61FMtYKdT956lQRzEpPV6mtd9Cd5p6WZVYqUlmCKi8utB4j
 wE1OyBD9lot8QTF6BSApm21Ismjz7mKtwO+WUJ3cWRjrf1NfiVygs9owMhcmF4igp1s7qJ9du
 18GHqOB2QdahJmGuCYCjX9QaPQN6kc7OlTTShuFI+MuUabXEqn+kVF6tjjeLw5v2l4DOVdzQ5
 xaGJOhnl5XXpaHG9rIf5fOjWS5pi66JGYJWQxWm2MnwFD48jQ0W+SoNiQxE/7U6BozzmbyagY
 O/LFkogPSQW10A/p5ECmGDGRmDV2shkXNhRVkcN4FZMJInidSbFvCRRwD/RV25DRGGyaEHD7J
 kB+UV7S0j+IGZx2axngWxos/1skPTvUDv33BSaXt82QPUARoNN11RIpKN7njX28SVVxtQc5/d
 tb3gjlWqgQ1ldZjcE+zYdmM2d1bs1ZG4RebPEGzSARt+h0W6s73MiWRirxNSOGPj52xYADIGi
 0SEm2wnyLGJ9rFHcvnRftmU7nZwnqgQpO2JjS42Vep9Li5lP5qpjGIn31PuKZPSAJTc0amkN2
 8YJSoEA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patches are an attempt to make Git's startup sequence a bit less
surprising.

The idea here is to discover the .git/ directory gently (i.e. without
changing the current working directory, or global variables), and to use
it to read the .git/config file early, before we actually called
setup_git_directory() (if we ever do that).

This also allows us to fix the early config e.g. to determine the pager
or to resolve aliases in a non-surprising manner.

My dirty little secret is that I need to discover the Git directory
early, without changing global state, for usage statistics gathering in
the GVFS Git project, so I actually do not care all that much about the
early config, although it is a welcome fallout (and a good reason for
accepting these patches and thereby releasing me of more maintenance
burden :-)).

Notable notes:

- In contrast to earlier versions, I no longer special-case init and
  clone. Peff pointed out that this adds technical debt, and that we can
  actually argue (for consistency's sake) that early config reads the
  current repository config (if any) even for init and clone.

- The read_early_config() function does not cache Git directory
  discovery nor read values. If needed, this can be implemented later,
  in a separate patch series.

- The alias handling in git.c could possibly benefit from this work, but
  again, this is a separate topic from the current patch series.

Changes since v2:

- replaced `test -e` by `test_path_is_file`

- fixed premature "cwd -> dir" in 2/9

- the setup_git_directory_gently_1() function is no longer renamed
  because it is not exported directly, anyway

- fixed the way setup_discovered_git_dir() expected the offset parameter
  to exclude the trailing slash (which is not true for root
  directories); also verified that setup_bare_git_dir() does not require
  a corresponding patch

- switched to using size_t instead of int to save the length of the
  strbuf in discover_git_directory()

- ensured that discover_git_directory() turns a relative gitdir into an
  absolute one even if there is already some text in the strbuf

- clarified under which circumstances we turn a relative gitdir into an
  absolute one

- avoided absolute gitdir with trailing "/." to be returned

- the commit that fixes the "really dirty hack" now rewords that comment
  to reflect that it is no longer a really dirty hack

- dropped the special-casing of init and clone

- the discover_git_directory() function now correctly checks the
  repository version, warning (and returning NULL) in case of a problem


Johannes Schindelin (9):
  t7006: replace dubious test
  setup_git_directory(): use is_dir_sep() helper
  Prepare setup_discovered_git_directory() the root directory
  setup_git_directory_1(): avoid changing global state
  Export the discover_git_directory() function
  Make read_early_config() reusable
  read_early_config(): avoid .git/config hack when unneeded
  read_early_config(): really discover .git/
  Test read_early_config()

 cache.h                 |   3 +
 config.c                |  27 ++++++
 pager.c                 |  31 -------
 setup.c                 | 237 ++++++++++++++++++++++++++++++++----------------
 t/helper/test-config.c  |  15 +++
 t/t1309-early-config.sh |  50 ++++++++++
 t/t7006-pager.sh        |  18 +++-
 7 files changed, 269 insertions(+), 112 deletions(-)
 create mode 100755 t/t1309-early-config.sh


base-commit: 3bc53220cb2dcf709f7a027a3f526befd021d858
Published-As: https://github.com/dscho/git/releases/tag/early-config-v3
Fetch-It-Via: git fetch https://github.com/dscho/git early-config-v3

Interdiff vs v2:

 diff --git a/cache.h b/cache.h
 index 0af7141242f..8a4580f921d 100644
 --- a/cache.h
 +++ b/cache.h
 @@ -518,6 +518,7 @@ extern void set_git_work_tree(const char *tree);
  #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
  
  extern void setup_work_tree(void);
 +/* Find GIT_DIR without changing the working directory or other global state */
  extern const char *discover_git_directory(struct strbuf *gitdir);
  extern const char *setup_git_directory_gently(int *);
  extern const char *setup_git_directory(void);
 @@ -2070,7 +2071,7 @@ const char *split_cmdline_strerror(int cmdline_errno);
  
  /* setup.c */
  struct startup_info {
 -	int have_repository, creating_repository;
 +	int have_repository;
  	const char *prefix;
  };
  extern struct startup_info *startup_info;
 diff --git a/config.c b/config.c
 index bcda397d42e..749623a9649 100644
 --- a/config.c
 +++ b/config.c
 @@ -1419,25 +1419,16 @@ void read_early_config(config_fn_t cb, void *data)
  	git_config_with_options(cb, data, NULL, 1);
  
  	/*
 -	 * Note that this is a really dirty hack that does the wrong thing in
 -	 * many cases. The crux of the problem is that we cannot run
 -	 * setup_git_directory() early on in git's setup, so we have no idea if
 -	 * we are in a repository or not, and therefore are not sure whether
 -	 * and how to read repository-local config.
 -	 *
 -	 * So if we _aren't_ in a repository (or we are but we would reject its
 -	 * core.repositoryformatversion), we'll read whatever is in .git/config
 -	 * blindly. Similarly, if we _are_ in a repository, but not at the
 -	 * root, we'll fail to find .git/config (because it's really
 -	 * ../.git/config, etc). See t7006 for a complete set of failures.
 -	 *
 -	 * However, we have historically provided this hack because it does
 -	 * work some of the time (namely when you are at the top-level of a
 -	 * valid repository), and would rarely make things worse (i.e., you do
 -	 * not generally have a .git/config file sitting around).
 +	 * When we are not about to create a repository ourselves (init or
 +	 * clone) and when no .git/ directory was set up yet (in which case
 +	 * git_config_with_options() would already have picked up the
 +	 * repository config), we ask discover_git_directory() to figure out
 +	 * whether there is any repository config we should use (but unlike
 +	 * setup_git_directory_gently(), no global state is changed, most
 +	 * notably, the current working directory is still the same after
 +	 * the call).
  	 */
 -	if (!startup_info->creating_repository && !have_git_dir() &&
 -	    discover_git_directory(&buf)) {
 +	if (!have_git_dir() && discover_git_directory(&buf)) {
  		struct git_config_source repo_config;
  
  		memset(&repo_config, 0, sizeof(repo_config));
 diff --git a/git.c b/git.c
 index 9fb9bb90a21..33f52acbcc8 100644
 --- a/git.c
 +++ b/git.c
 @@ -337,9 +337,6 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
  	struct stat st;
  	const char *prefix;
  
 -	if (p->fn == cmd_init_db || p->fn == cmd_clone)
 -		startup_info->creating_repository = 1;
 -
  	prefix = NULL;
  	help = argc == 2 && !strcmp(argv[1], "-h");
  	if (!help) {
 diff --git a/setup.c b/setup.c
 index 7ceca6cc6ef..5320ae37314 100644
 --- a/setup.c
 +++ b/setup.c
 @@ -721,8 +721,10 @@ static const char *setup_discovered_git_dir(const char *gitdir,
  	if (offset == cwd->len)
  		return NULL;
  
 -	/* Make "offset" point to past the '/', and add a '/' at the end */
 -	offset++;
 +	/* Make "offset" point past the '/' (already the case for root dirs) */
 +	if (offset != offset_1st_component(cwd->buf))
 +		offset++;
 +	/* Add a '/' at the end */
  	strbuf_addch(cwd, '/');
  	return cwd->buf + offset;
  }
 @@ -839,8 +841,8 @@ enum discovery_result {
   * the discovered .git/ directory, if any. This path may be relative against
   * `dir` (i.e. *not* necessarily the cwd).
   */
 -static enum discovery_result discover_git_directory_1(struct strbuf *dir,
 -						      struct strbuf *gitdir)
 +static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
 +							  struct strbuf *gitdir)
  {
  	const char *env_ceiling_dirs = getenv(CEILING_DIRECTORIES_ENVIRONMENT);
  	struct string_list ceiling_dirs = STRING_LIST_INIT_DUP;
 @@ -923,24 +925,44 @@ static enum discovery_result discover_git_directory_1(struct strbuf *dir,
  
  const char *discover_git_directory(struct strbuf *gitdir)
  {
 -	struct strbuf dir = STRBUF_INIT;
 -	int len;
 +	struct strbuf dir = STRBUF_INIT, err = STRBUF_INIT;
 +	size_t gitdir_offset = gitdir->len, cwd_len;
 +	struct repository_format candidate;
  
  	if (strbuf_getcwd(&dir))
  		return NULL;
  
 -	len = dir.len;
 -	if (discover_git_directory_1(&dir, gitdir) < 0) {
 +	cwd_len = dir.len;
 +	if (setup_git_directory_gently_1(&dir, gitdir) < 0) {
  		strbuf_release(&dir);
  		return NULL;
  	}
  
 -	if (dir.len < len && !is_absolute_path(gitdir->buf)) {
 -		strbuf_addch(&dir, '/');
 -		strbuf_insert(gitdir, 0, dir.buf, dir.len);
 +	/*
 +	 * The returned gitdir is relative to dir, and if dir does not reflect
 +	 * the current working directory, we simply make the gitdir absolute.
 +	 */
 +	if (dir.len < cwd_len && !is_absolute_path(gitdir->buf + gitdir_offset)) {
 +		/* Avoid a trailing "/." */
 +		if (!strcmp(".", gitdir->buf + gitdir_offset))
 +			strbuf_setlen(gitdir, gitdir_offset);
 +		else
 +			strbuf_addch(&dir, '/');
 +		strbuf_insert(gitdir, gitdir_offset, dir.buf, dir.len);
  	}
 +
 +	strbuf_reset(&dir);
 +	strbuf_addf(&dir, "%s/config", gitdir->buf + gitdir_offset);
 +	read_repository_format(&candidate, dir.buf);
  	strbuf_release(&dir);
  
 +	if (verify_repository_format(&candidate, &err) < 0) {
 +		warning("ignoring git dir '%s': %s",
 +			gitdir->buf + gitdir_offset, err.buf);
 +		strbuf_release(&err);
 +		return NULL;
 +	}
 +
  	return gitdir->buf;
  }
  
 @@ -970,7 +992,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
  		die_errno(_("Unable to read current working directory"));
  	strbuf_addbuf(&dir, &cwd);
  
 -	switch (discover_git_directory_1(&dir, &gitdir)) {
 +	switch (setup_git_directory_gently_1(&dir, &gitdir)) {
  	case GIT_DIR_NONE:
  		prefix = NULL;
  		break;
 @@ -1000,7 +1022,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
  		      "Stopping at filesystem boundary (GIT_DISCOVERY_ACROSS_FILESYSTEM not set)."),
  		    dir.buf);
  	default:
 -		die("BUG: unhandled discover_git_directory() result");
 +		die("BUG: unhandled setup_git_directory_1() result");
  	}
  
  	if (prefix)
 diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
 index bf89340988b..4f3794d415e 100755
 --- a/t/t7006-pager.sh
 +++ b/t/t7006-pager.sh
 @@ -387,7 +387,7 @@ test_expect_success TTY 'core.pager in repo config works and retains cwd' '
  		cd sub &&
  		rm -f cwd-retained &&
  		test_terminal git -p rev-parse HEAD &&
 -		test -e cwd-retained
 +		test_path_is_file cwd-retained
  	)
  '
  

-- 
2.12.0.windows.1.7.g94dafc3b124

