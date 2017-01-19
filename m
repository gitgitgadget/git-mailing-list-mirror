Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7EA720A17
	for <e@80x24.org>; Thu, 19 Jan 2017 21:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751737AbdASV2J (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 16:28:09 -0500
Received: from mout.gmx.net ([212.227.15.18]:55597 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751510AbdASV2I (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 16:28:08 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LgqQQ-1cA5qn1Au6-00oBcw; Thu, 19
 Jan 2017 22:19:55 +0100
Date:   Thu, 19 Jan 2017 22:19:52 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Andrew Arnott <Andrew.Arnott@microsoft.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 0/2] Fix remote_is_configured()
In-Reply-To: <cover.1484687919.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1484860744.git.johannes.schindelin@gmx.de>
References: <cover.1484687919.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:JnOfu61/bJe5JQEFWahsq8H+mjdti9Oi2QLnbvDOkI3CFICbjd7
 UVYiHXTFbkDyEsAU5i298FOEwUWn4Pxgb+ZjWUcEnKlzAJYTnEusBmCP51sESYSFk6LQKcN
 w6gLudC1QMVPU/xZYrQKfNL9HA9pJIF5CAedbndeuO1fRQL+7juWZvipM9YMh/fj6a1aJfC
 3k4IRAlb9Wn/Qtwx5x2hg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9CoEj7PNYgY=:EZxJV5WDhwgdWZnS3aMwpU
 AbHYZbU6chqrhxRHHw6yzxXGJ3z5oieaYRokrYA7rwYmbod9JdAGylWsCrJzxBMyJhfpenSny
 qk0Mep5+IfPjk0YIkMdZwmH6hrkt/poW0716MChP3jy1sZo5zLI3EzTpEtawNK0fisQ5xpbXH
 6ohiqIv8lCJWOzr92HGuzW4yLNSXTfh6/X52rOMT9Zc+BWAe5YDCoQhH3b3P0cZBNB/rZN3Hk
 ZOU94YaL8b2tp4Gmu6ga9SU0+T1k+Z/0J6Z8Lw5D1cTUFHk9YnHKEBxUYQkV+0RLplpNQ0AXp
 clmREF+70klDcC4Niv3HeaN90gUMZK5cQ/m3YiNnDqaaxvz9qywW3UrfUHi+MzNUPbjuNbWkx
 hKu0yPJ+LdzWFJw1aRBuEyqsnoAw0D4m/QP0fUebR4+/mLXRm/s1wMgehnQUQPnljElIZsD5B
 352VQl6bloeBrzW8k8aPFL2h+v8D4Rm54HkZ3HvpCR2rWSr40Ghin6B/DDSfirbDsYFG3Jt38
 VcqsiZ16CjNhd+ayhqDMrkFMoBC/XIsz/rmMi9mpUotHy2MwsYYlUZ85zAJNAj6fi/V2hQE94
 ZrJ1UdLEYNjafPl7iq6C4YDpYthF68wVfOP1Pb0CqyWs8Jl2hdD8N64TYTXQJOdz5J/adWUpm
 ijkMT+AzJ/rk/Hn5UELVxJOMsXXh/3SLwIEufLmq/f3Oj4UNkz3gl2D+Bfs3kNdcvPp/TkJ3E
 Tf8b4n+kLq7gR258wpPJEqmH6TKO09q3D2DMKBCgfL1YOJu409NxQAYIPiWTUrKHBD3BSostY
 L/3cNmG
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A surprising behavior triggered the bug report in
https://github.com/git-for-windows/git/issues/888: the mere existence of
the config setting "remote.origin.prune" (in this instance, configured
via ~/.gitconfig so that it applies to all repositories) fooled `git
remote rename <source> <target>` into believing that the <target> remote
is already there.

This patch pair demonstrates the problem, and then fixes it (along with
potential similar problems, such as setting an HTTP proxy for remotes of
a given name via ~/.gitconfig).

Changes since v1:

 - overhauled the strategy to fix the problem: instead of looking at the
   config key to determine whether it configures a remote or not, we now
   look at the config_source: if the remote setting was configured in
   .git/config, `git remote <command>` must not overwrite it. If it was
   configured elsewhere, `git remote` cannot overwrite any setting, as
   it only touches .git/config.


Johannes Schindelin (2):
  remote rename: demonstrate a bogus "remote exists" bug
  Be more careful when determining whether a remote was configured

 builtin/fetch.c   |  2 +-
 builtin/remote.c  | 14 +++++++-------
 remote.c          | 12 ++++++++++--
 remote.h          |  4 ++--
 t/t5505-remote.sh |  7 +++++++
 5 files changed, 27 insertions(+), 12 deletions(-)


base-commit: ffac48d093d4b518a0cc0e8bf1b7cb53e0c3d7a2
Published-As: https://github.com/dscho/git/releases/tag/rename-remote-v2
Fetch-It-Via: git fetch https://github.com/dscho/git rename-remote-v2

Interdiff vs v1:

 diff --git a/builtin/fetch.c b/builtin/fetch.c
 index f1570e3464..b5ad09d046 100644
 --- a/builtin/fetch.c
 +++ b/builtin/fetch.c
 @@ -1177,7 +1177,7 @@ static int add_remote_or_group(const char *name, struct string_list *list)
  	git_config(get_remote_group, &g);
  	if (list->nr == prev_nr) {
  		struct remote *remote = remote_get(name);
 -		if (!remote_is_configured(remote))
 +		if (!remote_is_configured(remote, 0))
  			return 0;
  		string_list_append(list, remote->name);
  	}
 diff --git a/builtin/remote.c b/builtin/remote.c
 index e52cf3925b..5339ed6ad1 100644
 --- a/builtin/remote.c
 +++ b/builtin/remote.c
 @@ -186,7 +186,7 @@ static int add(int argc, const char **argv)
  	url = argv[1];
  
  	remote = remote_get(name);
 -	if (remote_is_configured(remote))
 +	if (remote_is_configured(remote, 1))
  		die(_("remote %s already exists."), name);
  
  	strbuf_addf(&buf2, "refs/heads/test:refs/remotes/%s/test", name);
 @@ -618,14 +618,14 @@ static int mv(int argc, const char **argv)
  	rename.remote_branches = &remote_branches;
  
  	oldremote = remote_get(rename.old);
 -	if (!remote_is_configured(oldremote))
 +	if (!remote_is_configured(oldremote, 1))
  		die(_("No such remote: %s"), rename.old);
  
  	if (!strcmp(rename.old, rename.new) && oldremote->origin != REMOTE_CONFIG)
  		return migrate_file(oldremote);
  
  	newremote = remote_get(rename.new);
 -	if (remote_is_configured(newremote))
 +	if (remote_is_configured(newremote, 1))
  		die(_("remote %s already exists."), rename.new);
  
  	strbuf_addf(&buf, "refs/heads/test:refs/remotes/%s/test", rename.new);
 @@ -753,7 +753,7 @@ static int rm(int argc, const char **argv)
  		usage_with_options(builtin_remote_rm_usage, options);
  
  	remote = remote_get(argv[1]);
 -	if (!remote_is_configured(remote))
 +	if (!remote_is_configured(remote, 1))
  		die(_("No such remote: %s"), argv[1]);
  
  	known_remotes.to_delete = remote;
 @@ -1415,7 +1415,7 @@ static int set_remote_branches(const char *remotename, const char **branches,
  	strbuf_addf(&key, "remote.%s.fetch", remotename);
  
  	remote = remote_get(remotename);
 -	if (!remote_is_configured(remote))
 +	if (!remote_is_configured(remote, 1))
  		die(_("No such remote '%s'"), remotename);
  
  	if (!add_mode && remove_all_fetch_refspecs(remotename, key.buf)) {
 @@ -1469,7 +1469,7 @@ static int get_url(int argc, const char **argv)
  	remotename = argv[0];
  
  	remote = remote_get(remotename);
 -	if (!remote_is_configured(remote))
 +	if (!remote_is_configured(remote, 1))
  		die(_("No such remote '%s'"), remotename);
  
  	url_nr = 0;
 @@ -1537,7 +1537,7 @@ static int set_url(int argc, const char **argv)
  		oldurl = newurl;
  
  	remote = remote_get(remotename);
 -	if (!remote_is_configured(remote))
 +	if (!remote_is_configured(remote, 1))
  		die(_("No such remote '%s'"), remotename);
  
  	if (push_mode) {
 diff --git a/remote.c b/remote.c
 index 298f2f93fa..8524135de4 100644
 --- a/remote.c
 +++ b/remote.c
 @@ -255,7 +255,7 @@ static void read_remotes_file(struct remote *remote)
  
  	if (!f)
  		return;
 -	remote->configured = 1;
 +	remote->configured_in_repo = 1;
  	remote->origin = REMOTE_REMOTES;
  	while (strbuf_getline(&buf, f) != EOF) {
  		const char *v;
 @@ -290,7 +290,7 @@ static void read_branches_file(struct remote *remote)
  		return;
  	}
  
 -	remote->configured = 1;
 +	remote->configured_in_repo = 1;
  	remote->origin = REMOTE_BRANCHES;
  
  	/*
 @@ -373,6 +373,8 @@ static int handle_config(const char *key, const char *value, void *cb)
  	}
  	remote = make_remote(name, namelen);
  	remote->origin = REMOTE_CONFIG;
 +	if (current_config_scope() == CONFIG_SCOPE_REPO)
 +		remote->configured_in_repo = 1;
  	if (!strcmp(subkey, "mirror"))
  		remote->mirror = git_config_bool(key, value);
  	else if (!strcmp(subkey, "skipdefaultupdate"))
 @@ -386,25 +388,21 @@ static int handle_config(const char *key, const char *value, void *cb)
  		if (git_config_string(&v, key, value))
  			return -1;
  		add_url(remote, v);
 -		remote->configured = 1;
  	} else if (!strcmp(subkey, "pushurl")) {
  		const char *v;
  		if (git_config_string(&v, key, value))
  			return -1;
  		add_pushurl(remote, v);
 -		remote->configured = 1;
  	} else if (!strcmp(subkey, "push")) {
  		const char *v;
  		if (git_config_string(&v, key, value))
  			return -1;
  		add_push_refspec(remote, v);
 -		remote->configured = 1;
  	} else if (!strcmp(subkey, "fetch")) {
  		const char *v;
  		if (git_config_string(&v, key, value))
  			return -1;
  		add_fetch_refspec(remote, v);
 -		remote->configured = 1;
  	} else if (!strcmp(subkey, "receivepack")) {
  		const char *v;
  		if (git_config_string(&v, key, value))
 @@ -433,7 +431,6 @@ static int handle_config(const char *key, const char *value, void *cb)
  		return git_config_string((const char **)&remote->http_proxy_authmethod,
  					 key, value);
  	} else if (!strcmp(subkey, "vcs")) {
 -		remote->configured = 1;
  		return git_config_string(&remote->foreign_vcs, key, value);
  	}
  	return 0;
 @@ -721,9 +718,13 @@ struct remote *pushremote_get(const char *name)
  	return remote_get_1(name, pushremote_for_branch);
  }
  
 -int remote_is_configured(struct remote *remote)
 +int remote_is_configured(struct remote *remote, int in_repo)
  {
 -	return remote && remote->configured;
 +	if (!remote)
 +		return 0;
 +	if (in_repo)
 +		return remote->configured_in_repo;
 +	return !!remote->origin;
  }
  
  int for_each_remote(each_remote_fn fn, void *priv)
 diff --git a/remote.h b/remote.h
 index 7e6c8067bb..a5bbbe0ef9 100644
 --- a/remote.h
 +++ b/remote.h
 @@ -15,7 +15,7 @@ struct remote {
  	struct hashmap_entry ent;  /* must be first */
  
  	const char *name;
 -	int origin, configured;
 +	int origin, configured_in_repo;
  
  	const char *foreign_vcs;
  
 @@ -60,7 +60,7 @@ struct remote {
  
  struct remote *remote_get(const char *name);
  struct remote *pushremote_get(const char *name);
 -int remote_is_configured(struct remote *remote);
 +int remote_is_configured(struct remote *remote, int in_repo);
  
  typedef int each_remote_fn(struct remote *remote, void *priv);
  int for_each_remote(each_remote_fn fn, void *priv);
 diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
 index 09c9823002..ba46e86de0 100755
 --- a/t/t5505-remote.sh
 +++ b/t/t5505-remote.sh
 @@ -766,11 +766,9 @@ test_expect_success 'rename a remote with name prefix of other remote' '
  
  test_expect_success 'rename succeeds with existing remote.<target>.prune' '
  	git clone one four.four &&
 -	(
 -		cd four.four &&
 -		git config remote.upstream.prune true &&
 -		git remote rename origin upstream
 -	)
 +	test_when_finished git config --global --unset remote.upstream.prune &&
 +	git config --global remote.upstream.prune true &&
 +	git -C four.four remote rename origin upstream
  '
  
  cat >remotes_origin <<EOF

-- 
2.11.0.windows.3

