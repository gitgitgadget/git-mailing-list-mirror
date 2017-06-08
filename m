Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29D501FAE5
	for <e@80x24.org>; Thu,  8 Jun 2017 19:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751515AbdFHTxf (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 15:53:35 -0400
Received: from mout.gmx.net ([212.227.17.21]:57086 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751469AbdFHTxe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 15:53:34 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LikyX-1dqjgb1RLJ-00czCM; Thu, 08
 Jun 2017 21:53:28 +0200
Date:   Thu, 8 Jun 2017 21:53:26 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/8] Avoid problem where git_dir is set after alias
 expansion
Message-ID: <cover.1496951503.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:V64vKj0DzZAmMwwIjjuOVx5m337PNx4FSo+b7EdViJw3XHAzecZ
 UJPsr1Bay8ZQuKDY+tHGFZack2ZkFgxNRGLRXzdcM3kSGmE3Hx4/yuKb1N0mo1vAwbUi9wo
 DRTOryy99H1j01H2Ia2C+ha4YyQkrS1pATfSHAhXbjsr6Q9skE6EGQO0Qh8igJeNRDSrH88
 tJgCitEdMM8FLDP44yojg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tnaXnw1aqYs=:VQtHZYlgXNHxTAVmf++oEN
 IX/t3d3vV1TwNgBTQ79KzDcIAfsNI2ci4p8s1nXGFn4VaJPxXCLtfDRHUKqpNxEMPR00Igz8G
 +V/VAXJ6u4T9UIWRmXUi5IoboqapVp7ocX9pzU8sUF8H5U07PRP1707v5ZL+1pBPhmwHyhH9t
 lX0x2wJ6OkqUFZ50ucf59siQZI+CuYRYASMf8kl3O/Hch4bgk/lmoWpgy2JAOyNMwuYfQvx2e
 IH+rmjoFnhjSW2nagc9HsAPHn9Vf08toMD3GetLSCHU/YJh5FBwQf/jhaK+sMVt+pF80CZJ6X
 xyDVzfZ+VE+fdvC0L8JglwBOuwvr+spqH3sy+np2JdjzYWtnnInGkfK7US3cQskk6Rl+1gadV
 0MCTYE9hh/7WL1LIafocFZ7/Xg8dNjW+92p+aGjyqCnLRz3vwLa2HqHkz/v53YnfQxTRG269u
 G6Zz6Gq8yVecGdZx4PydcQCJ+/h9OBOgtZzn8tDFt8xDoC6BBMKaDutDcixdS1lEGVX1aFZvb
 SjNeruCx41KRG54WcKHD7rzH+F/s7HNxoPSG/1cllw+oD8L94l6wDTETOC4lN156UGStS6kSL
 z2Xk3unJk8UYI3t/HcYeLXOlR8WO5HlaI3ItuQ2BEPJEyG7PoKeZG5N3VEEFnQTXVAg/lj/GR
 S7EYs7tvRm0nvR1P/fsCqd9yYMX4tA0sEJ5S/4NoXAcvR2o/mfPZTHoo09njA6XXXz4ga87dT
 sUCrXdDFX2cGu3XgxeYnn7s5nzoaAE8K4Y9PD4MtlWJLI18yLoBLH/nz/bFNrGwpF+tqa5+gJ
 DU0IZgX
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When expanding an alias in a subdirectory, we setup the git_dir
(gently), read the config, and then restore the "env" (e.g. the current
working directory) so that the command specified by the alias can run
correctly.

What we failed to reset was the git_dir, meaning that in the most common
case, it was now pointing to a .git/ directory *in the subdirectory*.

This problem was identified in the GVFS fork, where a pre-command hook
was introduced to allow pre-fetching missing blobs.

An early quick fix in the GVFS fork simply built on top of the
save_env_before_alias() hack, introducing another hack that saves the
git_dir and restores it after an alias is expanded:

	https://github.com/Microsoft/git/commit/2d859ba3b

That is very hacky, though, and it is much better (although much more
involved, too) to fix this "properly", i.e. by replacing the ugly
save/restore logic by simply using the early config code path.

However, aliases are strange beasts.

When an alias refers to a single Git command (originally the sole
intention of aliases), the current working directory is restored to what
it had been before expanding the alias.

But when an alias starts with an exclamation point, i.e. referring to a
command-line to be interpreted by the shell, the current working
directory is no longer in the subdirectory but instead in the worktree's
top-level directory.

This is even true for worktrees added by `git worktree add`.

But when we are inside the .git/ directory, the current working
directory is *restored* to the subdirectory inside the .git/ directory.

In short, the logic is a bit complicated what is the expected current
working directory after expanding an alias and before actually running
it.

That is why this patch series had to expand the signature of the early
config machinery to return the additional information for aliases'
benefit.

Changes since v1:

- 1/8's commit message clarifies why the other early return in
  discover_git_directory() does not need an equivalent resetting of
  git_dir.

- 3/8's commit message fixes awkward language (thanks, Brandon!).

- the `worktree_dir` variables/parameters have been renamed to
  `cdup_dir` to clarify that they only get populated if the search for
  the .git/ directory determined that the current working directory
  is a subdirectory of the directory containing .git/.


Johannes Schindelin (8):
  discover_git_directory(): avoid setting invalid git_dir
  config: report correct line number upon error
  help: use early config when autocorrecting aliases
  read_early_config(): optionally return the worktree's top-level
    directory
  t1308: relax the test verifying that empty alias values are disallowed
  t7006: demonstrate a problem with aliases in subdirectories
  alias_lookup(): optionally return top-level directory
  Use the early config machinery to expand aliases

 alias.c                | 33 +++++++++++++++++++++-------
 builtin/help.c         |  2 +-
 cache.h                |  7 +++---
 config.c               |  7 +++---
 git.c                  | 59 ++++++--------------------------------------------
 help.c                 |  2 +-
 pager.c                |  4 ++--
 setup.c                | 13 +++++++++--
 t/helper/test-config.c |  2 +-
 t/t1308-config-set.sh  |  4 +++-
 t/t7006-pager.sh       | 11 ++++++++++
 11 files changed, 70 insertions(+), 74 deletions(-)


base-commit: 8d1b10321b20bd2a73a5b561cfc3cf2e8051b70b
Published-As: https://github.com/dscho/git/releases/tag/alias-early-config-v2
Fetch-It-Via: git fetch https://github.com/dscho/git alias-early-config-v2

Interdiff vs v1:
 diff --git a/alias.c b/alias.c
 index c1b87154944..b7c4a4f0217 100644
 --- a/alias.c
 +++ b/alias.c
 @@ -16,13 +16,13 @@ static int config_alias_cb(const char *key, const char *value, void *d)
  	return 0;
  }
  
 -char *alias_lookup(const char *alias, struct strbuf *worktree_dir)
 +char *alias_lookup(const char *alias, struct strbuf *cdup_dir)
  {
  	struct config_alias_data data = { STRBUF_INIT, NULL };
  
  	strbuf_addf(&data.key, "alias.%s", alias);
  	if (git_config_key_is_valid(data.key.buf))
 -		read_early_config(config_alias_cb, &data, worktree_dir);
 +		read_early_config(config_alias_cb, &data, cdup_dir);
  	strbuf_release(&data.key);
  
  	return data.v;
 diff --git a/cache.h b/cache.h
 index 77ce8e8c80b..65f2e5bf04c 100644
 --- a/cache.h
 +++ b/cache.h
 @@ -530,7 +530,7 @@ extern void setup_work_tree(void);
   * appended to gitdir. The return value is either NULL if no repository was
   * found, or pointing to the path inside gitdir's buffer.
   */
 -extern const char *discover_git_directory(struct strbuf *gitdir, struct strbuf *worktree_dir);
 +extern const char *discover_git_directory(struct strbuf *gitdir, struct strbuf *cdup_dir);
  extern const char *setup_git_directory_gently(int *);
  extern const char *setup_git_directory(void);
  extern char *prefix_path(const char *prefix, int len, const char *path);
 @@ -1914,7 +1914,7 @@ extern int git_config_from_blob_sha1(config_fn_t fn, const char *name,
  extern void git_config_push_parameter(const char *text);
  extern int git_config_from_parameters(config_fn_t fn, void *data);
  extern void read_early_config(config_fn_t cb, void *data,
 -			      struct strbuf *worktree_dir);
 +			      struct strbuf *cdup_dir);
  extern void git_config(config_fn_t fn, void *);
  extern int git_config_with_options(config_fn_t fn, void *,
  				   struct git_config_source *config_source,
 @@ -2189,7 +2189,7 @@ extern int ws_blank_line(const char *line, int len, unsigned ws_rule);
  /* ls-files */
  void overlay_tree_on_cache(const char *tree_name, const char *prefix);
  
 -char *alias_lookup(const char *alias, struct strbuf *worktree_dir);
 +char *alias_lookup(const char *alias, struct strbuf *cdup_dir);
  int split_cmdline(char *cmdline, const char ***argv);
  /* Takes a negative value returned by split_cmdline */
  const char *split_cmdline_strerror(int cmdline_errno);
 diff --git a/config.c b/config.c
 index 3d78c11fc00..5aec6e4c87c 100644
 --- a/config.c
 +++ b/config.c
 @@ -1651,7 +1651,7 @@ static void configset_iter(struct config_set *cs, config_fn_t fn, void *data)
  	}
  }
  
 -void read_early_config(config_fn_t cb, void *data, struct strbuf *worktree_dir)
 +void read_early_config(config_fn_t cb, void *data, struct strbuf *cdup_dir)
  {
  	struct config_options opts = {0};
  	struct strbuf buf = STRBUF_INIT;
 @@ -1668,7 +1668,7 @@ void read_early_config(config_fn_t cb, void *data, struct strbuf *worktree_dir)
  	 * notably, the current working directory is still the same after the
  	 * call).
  	 */
 -	else if (discover_git_directory(&buf, worktree_dir))
 +	else if (discover_git_directory(&buf, cdup_dir))
  		opts.git_dir = buf.buf;
  
  	git_config_with_options(cb, data, NULL, &opts);
 diff --git a/git.c b/git.c
 index c82cd455948..6511595d467 100644
 --- a/git.c
 +++ b/git.c
 @@ -201,7 +201,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
  
  static int handle_alias(int *argcp, const char ***argv)
  {
 -	struct strbuf worktree_dir = STRBUF_INIT;
 +	struct strbuf cdup_dir = STRBUF_INIT;
  	int envchanged = 0, ret = 0, saved_errno = errno;
  	int count, option_count;
  	const char **new_argv;
 @@ -209,12 +209,12 @@ static int handle_alias(int *argcp, const char ***argv)
  	char *alias_string;
  
  	alias_command = (*argv)[0];
 -	alias_string = alias_lookup(alias_command, &worktree_dir);
 +	alias_string = alias_lookup(alias_command, &cdup_dir);
  	if (alias_string) {
  		if (alias_string[0] == '!') {
  			struct child_process child = CHILD_PROCESS_INIT;
  
 -			if (worktree_dir.len)
 +			if (cdup_dir.len)
  				setup_git_directory();
  
  			commit_pager_choice();
 @@ -224,14 +224,14 @@ static int handle_alias(int *argcp, const char ***argv)
  			argv_array_pushv(&child.args, (*argv) + 1);
  
  			ret = run_command(&child);
 -			strbuf_release(&worktree_dir);
 +			strbuf_release(&cdup_dir);
  			if (ret >= 0)   /* normal exit */
  				exit(ret);
  
  			die_errno("While expanding alias '%s': '%s'",
  			    alias_command, alias_string + 1);
  		}
 -		strbuf_release(&worktree_dir);
 +		strbuf_release(&cdup_dir);
  		count = split_cmdline(alias_string, &new_argv);
  		if (count < 0)
  			die("Bad alias.%s string: %s", alias_command,
 diff --git a/setup.c b/setup.c
 index 771822fd0ca..3f6fc1577b7 100644
 --- a/setup.c
 +++ b/setup.c
 @@ -946,10 +946,10 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
  }
  
  const char *discover_git_directory(struct strbuf *gitdir,
 -				   struct strbuf *worktree_dir)
 +				   struct strbuf *cdup_dir)
  {
  	struct strbuf dir = STRBUF_INIT, err = STRBUF_INIT;
 -	size_t gitdir_offset = gitdir->len, cwd_len, worktree_dir_offset;
 +	size_t gitdir_offset = gitdir->len, cwd_len, cdup_dir_offset;
  	struct repository_format candidate;
  
  	if (strbuf_getcwd(&dir))
 @@ -974,9 +974,9 @@ const char *discover_git_directory(struct strbuf *gitdir,
  		strbuf_insert(gitdir, gitdir_offset, dir.buf, dir.len);
  	}
  
 -	if (worktree_dir) {
 -		worktree_dir_offset = worktree_dir->len;
 -		strbuf_addbuf(worktree_dir, &dir);
 +	if (cdup_dir) {
 +		cdup_dir_offset = cdup_dir->len;
 +		strbuf_addbuf(cdup_dir, &dir);
  	}
  
  	strbuf_reset(&dir);
 @@ -989,8 +989,8 @@ const char *discover_git_directory(struct strbuf *gitdir,
  			gitdir->buf + gitdir_offset, err.buf);
  		strbuf_release(&err);
  		strbuf_setlen(gitdir, gitdir_offset);
 -		if (worktree_dir)
 -			strbuf_setlen(worktree_dir, worktree_dir_offset);
 +		if (cdup_dir)
 +			strbuf_setlen(cdup_dir, cdup_dir_offset);
  		return NULL;
  	}
  
-- 
2.13.0.windows.1.460.g13f583bedb5

