Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D277D20314
	for <e@80x24.org>; Tue,  7 Mar 2017 14:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755638AbdCGOdN (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 09:33:13 -0500
Received: from mout.gmx.net ([212.227.15.18]:52428 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755609AbdCGOdE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 09:33:04 -0500
Received: from virtualbox ([37.201.194.72]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MhAVV-1cygPE465Z-00MNpq; Tue, 07
 Mar 2017 15:32:22 +0100
Date:   Tue, 7 Mar 2017 15:32:19 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH v4 00/10] Fix the early config
In-Reply-To: <cover.1488562287.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1488897111.git.johannes.schindelin@gmx.de>
References: <cover.1488562287.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ldtCks/yXxjd7B8GMXbjY5IrTqGJrrcRhv0jPLIpTUcdwVcHdGq
 5LsT/blLQ/w0YZ9lxE12rEtwihluwrxFyBNwiqDNmWPFubsGEENifNqjsmFUxfLKLGg78a6
 mbiNOjyGzuvAuaA4zXe9nFTzR9l6Czn+CxA7TbFJWbdqeMc7qu2yX1U4cQdattbqplMBvoZ
 cGG+MAYFwxT+jcJf1Agfg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OH7yZ7G/Qmo=:sNssAcdcn5APNfKOYl/pYE
 3cE6txI4RptKpiCCNHWG9WZLC+CT+VhWMq8Znx9HILF+Z93BZfh9uplej0Exva5TxNWwXiFy/
 7ACYnVBx3pun4nMg+aCsxQwHtM9ncuVL7txqBrO6yyjr4VY/IwVXaNFhe+XZwJk3wXMCcXmKP
 VVmZBSlFpIkhFd1l19tfX1l4GcWJlHsutyqs3IYGVZ8to2+mVZvAP6Fpec5Bc8kOnIxgEdujY
 Uv2L1LUhw08Ix0yTSXjPfRUcNXfIFT9/vwE6nVb0QyQzgPlQvQxDusaJcm31044OfPqxwtBw4
 CXqMqJciTkCnf1PVCzwvulrFPQSovF0TwcX9MjOhKH/76JOKeI/sYEM/O4zI3WoXdLRPQu/gI
 iosojKd5hL6tUN9DBX4I0u01PZ0IWrp2VA/1cRol5evImzzpTpI/8LHUG0vDkdTBy+GPqtEkV
 gwv1XylnBY5yZvkEC4OB7ggshu2rawTcwKCYVazGtHzv2vXJkVM/u0kUlCubP7eeKApY/OF6i
 ZMWjQZOmaw8Aiwj3D6nkIgHV/DQoX376/ijYcf2XWWvfl5AceEWoVLPHYCXXL2OoEm7HybEOm
 igiB+g1xnbUuVLJX8Md/ZKkYQQLKdylyIEdJ7C2u10BLggtKFrsH2qDlW6XxAgaQ6OGB8ydP1
 9wQKNQRKalWquCucjJ4c+FwiZeQlupbhxXBbbXK7hylFX1slFa/XAIZA1oBcW24SQTsfzxfFa
 fZ8yn35g31F6tBNEOjsmBIULeOjVAZQ4+L8RXIGY4OLlwF/eJpbcZSjCmzVntogj7XmWOuaQ0
 iiNmbg0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patches are an attempt to make Git's startup sequence a bit less
surprising.

The idea here is to discover the .git/ directory gently (i.e. without
changing the current working directory, nor any global variables), and
to use it to read the .git/config file early, before we actually called
setup_git_directory() (if we ever do that).

This also allows us to fix the early config e.g. to determine the pager
or to resolve aliases in a non-surprising manner.

My own use case: in the GVFS Git fork, we need to execute pre-command
and post-command hooks before and after *every* Git command. A previous
version of the pre-command/post-command hook support was broken, as it
used run_hook() which implicitly called setup_git_directory() too early.
The discover_git_directory() function (and due to core.hooksPath also
the read_early_config() function) helped me fix this.

Notable notes:

- Even if it can cause surprising problems, `init` and `clone` are not
  special-cased. Rationale: it would introduce technical debt and
  violate the Principle Of Least Astonishment.

- The read_early_config() function does not cache Git directory
  discovery nor read values. This is left for another patch series, if
  it ever becomes necessary.

- The alias handling in git.c could possibly benefit from this work, but
  again, this is a separate topic from the current patch series.

Changes since v3:

- instead of just fixing the `== '/'` comparison, 2/9 now *also* changes
  the style of the original to something Linux' checkpatch.pl prefers.

- fixed the comment added in 8/9 which was stale from an earlier
  iteration of this patch series.

- adjusted the commit above discover_git_directory()'s declaration, to
  make it more understandable.

- touched up the commit message of 5/9 to make the flow more natural.

- moved a fault fixup: by mistake, the repository_format check was added
  to 8/9 when it really needed to go to 5/9, where the
  discover_git_directory() function was introduced (I noticed this while
  rebasing).

- fixed discover_git_directory() when setup_git_directory_gently_1()
  returned GIT_DIR_NONE (the previous iteration would *not* return NULL
  in that case).


Johannes Schindelin (10):
  t7006: replace dubious test
  setup_git_directory(): use is_dir_sep() helper
  Prepare setup_discovered_git_directory() the root directory
  setup_git_directory_1(): avoid changing global state
  Introduce the discover_git_directory() function
  Make read_early_config() reusable
  read_early_config(): avoid .git/config hack when unneeded
  read_early_config(): really discover .git/
  Test read_early_config()
  setup_git_directory_gently_1(): avoid die()ing

 cache.h                 |   8 ++
 config.c                |  25 +++++
 pager.c                 |  31 ------
 setup.c                 | 246 +++++++++++++++++++++++++++++++++---------------
 t/helper/test-config.c  |  15 +++
 t/t1309-early-config.sh |  50 ++++++++++
 t/t7006-pager.sh        |  18 +++-
 7 files changed, 282 insertions(+), 111 deletions(-)
 create mode 100755 t/t1309-early-config.sh


base-commit: 3bc53220cb2dcf709f7a027a3f526befd021d858
Published-As: https://github.com/dscho/git/releases/tag/early-config-v4
Fetch-It-Via: git fetch https://github.com/dscho/git early-config-v4

Interdiff vs v3:

 diff --git a/cache.h b/cache.h
 index 8a4580f921d..e7b57457e73 100644
 --- a/cache.h
 +++ b/cache.h
 @@ -518,7 +518,12 @@ extern void set_git_work_tree(const char *tree);
  #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
  
  extern void setup_work_tree(void);
 -/* Find GIT_DIR without changing the working directory or other global state */
 +/*
 + * Find GIT_DIR of the repository that contains the current working directory,
 + * without changing the working directory or other global state. The result is
 + * appended to gitdir. The return value is either NULL if no repository was
 + * found, or pointing to the path inside gitdir's buffer.
 + */
  extern const char *discover_git_directory(struct strbuf *gitdir);
  extern const char *setup_git_directory_gently(int *);
  extern const char *setup_git_directory(void);
 diff --git a/config.c b/config.c
 index 749623a9649..a88df53fdbc 100644
 --- a/config.c
 +++ b/config.c
 @@ -1419,14 +1419,12 @@ void read_early_config(config_fn_t cb, void *data)
  	git_config_with_options(cb, data, NULL, 1);
  
  	/*
 -	 * When we are not about to create a repository ourselves (init or
 -	 * clone) and when no .git/ directory was set up yet (in which case
 -	 * git_config_with_options() would already have picked up the
 -	 * repository config), we ask discover_git_directory() to figure out
 -	 * whether there is any repository config we should use (but unlike
 +	 * When setup_git_directory() was not yet asked to discover the
 +	 * GIT_DIR, we ask discover_git_directory() to figure out whether there
 +	 * is any repository config we should use (but unlike
  	 * setup_git_directory_gently(), no global state is changed, most
 -	 * notably, the current working directory is still the same after
 -	 * the call).
 +	 * notably, the current working directory is still the same after the
 +	 * call).
  	 */
  	if (!have_git_dir() && discover_git_directory(&buf)) {
  		struct git_config_source repo_config;
 diff --git a/setup.c b/setup.c
 index 5320ae37314..9118b48590a 100644
 --- a/setup.c
 +++ b/setup.c
 @@ -825,7 +825,8 @@ enum discovery_result {
  	GIT_DIR_BARE,
  	/* these are errors */
  	GIT_DIR_HIT_CEILING = -1,
 -	GIT_DIR_HIT_MOUNT_POINT = -2
 +	GIT_DIR_HIT_MOUNT_POINT = -2,
 +	GIT_DIR_INVALID_GITFILE = -3
  };
  
  /*
 @@ -842,7 +843,8 @@ enum discovery_result {
   * `dir` (i.e. *not* necessarily the cwd).
   */
  static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
 -							  struct strbuf *gitdir)
 +							  struct strbuf *gitdir,
 +							  int die_on_error)
  {
  	const char *env_ceiling_dirs = getenv(CEILING_DIRECTORIES_ENVIRONMENT);
  	struct string_list ceiling_dirs = STRING_LIST_INIT_DUP;
 @@ -890,14 +892,22 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
  	if (one_filesystem)
  		current_device = get_device_or_die(dir->buf, NULL, 0);
  	for (;;) {
 -		int offset = dir->len;
 +		int offset = dir->len, error_code = 0;
  
  		if (offset > min_offset)
  			strbuf_addch(dir, '/');
  		strbuf_addstr(dir, DEFAULT_GIT_DIR_ENVIRONMENT);
 -		gitdirenv = read_gitfile(dir->buf);
 -		if (!gitdirenv && is_git_directory(dir->buf))
 -			gitdirenv = DEFAULT_GIT_DIR_ENVIRONMENT;
 +		gitdirenv = read_gitfile_gently(dir->buf, die_on_error ?
 +						NULL : &error_code);
 +		if (!gitdirenv) {
 +			if (die_on_error ||
 +			    error_code == READ_GITFILE_ERR_NOT_A_FILE) {
 +				if (is_git_directory(dir->buf))
 +				    gitdirenv = DEFAULT_GIT_DIR_ENVIRONMENT;
 +			} else if (error_code &&
 +				   error_code != READ_GITFILE_ERR_STAT_FAILED)
 +				return GIT_DIR_INVALID_GITFILE;
 +		}
  		strbuf_setlen(dir, offset);
  		if (gitdirenv) {
  			strbuf_addstr(gitdir, gitdirenv);
 @@ -912,7 +922,8 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
  		if (offset <= min_offset)
  			return GIT_DIR_HIT_CEILING;
  
 -		while (--offset > ceil_offset && !is_dir_sep(dir->buf[offset]));
 +		while (--offset > ceil_offset && !is_dir_sep(dir->buf[offset]))
 +			; /* continue */
  		if (offset <= ceil_offset)
  			return GIT_DIR_HIT_CEILING;
  
 @@ -933,7 +944,7 @@ const char *discover_git_directory(struct strbuf *gitdir)
  		return NULL;
  
  	cwd_len = dir.len;
 -	if (setup_git_directory_gently_1(&dir, gitdir) < 0) {
 +	if (setup_git_directory_gently_1(&dir, gitdir, 0) <= 0) {
  		strbuf_release(&dir);
  		return NULL;
  	}
 @@ -963,7 +974,7 @@ const char *discover_git_directory(struct strbuf *gitdir)
  		return NULL;
  	}
  
 -	return gitdir->buf;
 +	return gitdir->buf + gitdir_offset;
  }
  
  const char *setup_git_directory_gently(int *nongit_ok)
 @@ -992,7 +1003,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
  		die_errno(_("Unable to read current working directory"));
  	strbuf_addbuf(&dir, &cwd);
  
 -	switch (setup_git_directory_gently_1(&dir, &gitdir)) {
 +	switch (setup_git_directory_gently_1(&dir, &gitdir, 1)) {
  	case GIT_DIR_NONE:
  		prefix = NULL;
  		break;

-- 
2.12.0.windows.1.7.g94dafc3b124

