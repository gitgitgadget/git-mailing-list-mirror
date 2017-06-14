Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB2AB20401
	for <e@80x24.org>; Wed, 14 Jun 2017 11:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752025AbdFNLfq (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 07:35:46 -0400
Received: from mout.gmx.net ([212.227.17.21]:60405 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751874AbdFNLfo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 07:35:44 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M1SLt-1depFt0QDx-00tUOD; Wed, 14
 Jun 2017 13:35:24 +0200
Date:   Wed, 14 Jun 2017 13:35:22 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v4 0/6] Avoid problem where git_dir is set after alias
 expansion
Message-ID: <cover.1497440104.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ZNtuMRPSe07DC/pnNC979WEaphKzZohUNaaKEYFNdigeHpBIq4h
 7ABJCQ6nzb7hJAdyWqqimqFHrec1C63qaj3jrBi6E3cgxZL3IXoOoKl2tA7jQhDJhzT+7Gu
 G366xMiLQNl+PwLKQ+t10dErRG6rt/RKHCNjlvzIdv3MeOwvb3fJaCUE5IFec7nTr4H6Tm4
 aK8OT//Y9zrxiHOLMI90Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LvoRVJl1cMM=:QAPVzmJKB/n6c3L2AVfbVY
 VW9KKsafbd/boUEN95K56Boc7hBT94AeCZFpqyMeIcaoB8KfzV4HvqlZWLNKZZ2e/DS9/nvs4
 NQGM3TIEQf5o9h5RJ9WLlAUpcM/Mcska6V82uoZsbUesqxGDbGXDTajzzMS1gU3hVqCjY4KMX
 6DttQBnhHwqYJInD48217h0PmpG5rffZiN7ur/ar6h9isnuSyqkbonJekSc2K0RzUICI+wZjD
 EFK1Rky3Mon1lYA/nccqb6D7HY72YnQ0sFUqfCIdj74ESwMo2g3cyKIuYDlMsUU6l2ZNNSeYe
 6Onc/GqTcD7aKt3M7uWWOp+kbR7YwOFKS+LUF+1wisf5mNHTkFQqgDYnWH0TtiFfGM/LfWh3C
 Vzo/bOeLx+OM/Ru67r8OuaGDwEy/gta8brpWfvt9L7YeYkGcm24loYLKo9cU1OJs/hbcBzQG2
 kecugGXEPEEleRtw/BDdU7+E2h7lup/mzXPt9mLT28lWnpJsTPNyU1KA4chClehYZyQ9q0aMT
 Bj6FlUmSOCBuKALrfpU+KOwEnP9fetgKA3uEI7UxHriomjnobnSczoMrc692icjo5Mz7YYZ/r
 XYbF4poynekSSzVrwq3fRlo5ne6SuFYJOrboKyAlS3lthawLDBl1OKqhsXTPTMZJGNYzlLunE
 a6ayj0XUdjuuKDWsoTMWqzYrOus267wyJ3XjM7DGQxe/Dd98Zag96NMk124V+OrbPfG21FeA/
 H08BWPu1AzW5+qKj2R9MF8rs22vs4y+kL2ZIGhHtgSDxL5fH27kegx+Lzqu6yaB4lLLeFVIoJ
 zSDz1aT
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

In short, the rules (what is the expected current working directory after
expanding an alias and before actually running it) are a bit complicated.

This patch series does *not* address the problem identified by Brandon
Williams where the early config machinery fails to look into the
*commondir* in worktrees added by `git worktree add`. My hope is that
Brandon is okay with applying this patch series before his config patch
series.

Changes since v3:

- avoided the strbuf in alias_lookup() by using skip_prefix() and !strcmp()
  instead.

- fixed tyop ("read" instead of "reading", causing Junio to stumble) in the
  commit message of 6/6.


Johannes Schindelin (6):
  discover_git_directory(): avoid setting invalid git_dir
  config: report correct line number upon error
  help: use early config when autocorrecting aliases
  t1308: relax the test verifying that empty alias values are disallowed
  t7006: demonstrate a problem with aliases in subdirectories
  Use the early config machinery to expand aliases

 alias.c                | 29 +++++++++++++++++++-------
 config.c               |  3 ++-
 git.c                  | 55 ++++----------------------------------------------
 help.c                 |  2 +-
 setup.c                |  1 +
 t/t1300-repo-config.sh |  6 ++++++
 t/t1308-config-set.sh  |  4 +++-
 t/t7006-pager.sh       | 11 ++++++++++
 8 files changed, 50 insertions(+), 61 deletions(-)


base-commit: 02a2850ad58eff6de70eb2dc5f96345c463857ac
Published-As: https://github.com/dscho/git/releases/tag/alias-early-config-v4
Fetch-It-Via: git fetch https://github.com/dscho/git alias-early-config-v4

Interdiff vs v3:
 diff --git a/alias.c b/alias.c
 index 6bdc9363037..5df052ae4c4 100644
 --- a/alias.c
 +++ b/alias.c
 @@ -2,15 +2,16 @@
  
  struct config_alias_data
  {
 -	struct strbuf key;
 +	const char *alias;
  	char *v;
  };
  
  static int config_alias_cb(const char *key, const char *value, void *d)
  {
  	struct config_alias_data *data = d;
 +	const char *p;
  
 -	if (!strcmp(key, data->key.buf))
 +	if (skip_prefix(key, "alias.", &p) && !strcmp(p, data->alias))
  		return git_config_string((const char **)&data->v, key, value);
  
  	return 0;
 @@ -18,12 +19,9 @@ static int config_alias_cb(const char *key, const char *value, void *d)
  
  char *alias_lookup(const char *alias)
  {
 -	struct config_alias_data data = { STRBUF_INIT, NULL };
 +	struct config_alias_data data = { alias, NULL };
  
 -	strbuf_addf(&data.key, "alias.%s", alias);
 -	if (git_config_key_is_valid(data.key.buf))
 -		read_early_config(config_alias_cb, &data);
 -	strbuf_release(&data.key);
 +	read_early_config(config_alias_cb, &data);
  
  	return data.v;
  }
-- 
2.13.1.windows.1.1.ga36e14b3aaa

