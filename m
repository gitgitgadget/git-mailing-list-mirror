Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDE4520A17
	for <e@80x24.org>; Thu, 19 Jan 2017 21:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752488AbdASVf3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 16:35:29 -0500
Received: from mout.gmx.net ([212.227.15.18]:60767 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751866AbdASVf1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 16:35:27 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MWC9x-1d15Za0TCT-00XM1g; Thu, 19
 Jan 2017 22:20:03 +0100
Date:   Thu, 19 Jan 2017 22:20:02 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Andrew Arnott <Andrew.Arnott@microsoft.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 2/2] Be more careful when determining whether a remote
 was configured
In-Reply-To: <cover.1484860744.git.johannes.schindelin@gmx.de>
Message-ID: <1605031b76025f4bd0e485705c34a25557bb75a1.1484860744.git.johannes.schindelin@gmx.de>
References: <cover.1484687919.git.johannes.schindelin@gmx.de> <cover.1484860744.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:DaljzWkWp1anY6/+NN611xa2kpluGuOdWSBC5DdrbZjgQtjtcXv
 KsRz2JPb+IgheInflE6FD2Pr/OOb3dOwcXHynm3xa4MrNx/KyvsCYf9q81Z2W6ygdtKM1pF
 m33EpRh8i4KPBY/fbiIcvzqg0YS5XnmuPkBkPWR7HNIeBhVLgJ+3lG2EoFyv4RwwNHYOKoD
 LXVtiTIv+itZWp66vJARw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7r22s0zIwYo=:XEFNpF74k9cLdSd8qsZP7Q
 20BCy/EkjMIqNe41SwpY1E6CqMQsj/r0nabik6FQVGD11fpHnYnjZ0gJCSYH0C0EoyB1zYqyM
 4jYIgsm+olsB4cZUHwirl5HKLkbKCLPxAfUKLH7Xw0UVftyc9g+tpBiNqTQ8oh4MVn7kckJYm
 ieMt6BoV/PD+qJkheMiilkmZKuIZD0Wk2BALz7XbRzrBwBfqGL6tgcvGrZFh/sN+StU9atF3T
 6NZ1xyfhGE4lBqd+pFwLex7rChMLj4y0GHcn5MMToEmMVkanOTlFHaunrntsfwbbZ44KCictS
 3DpEqKSL4OAic6Yl6xEjyp1g9KI56rt2CU/t1mFkFHpfyZ2+/8fykTPKBeC/fsEkoBvll/weB
 GlMSPvCBwKZtLcKGuz87cafrP5/brcDh9vkpfGtBQzBINdAOvFiOSvCV3PqjZxAdfhD9y7EHX
 iMOhrr89Bw7hMmGgoyLfrtNjLscuZ6xTTW5E6W4xVFzrSHNVpUSgZcDi3UDFXsU9tKYO00pL1
 J9uKY4vxrTnoLcKTlah2bERrxabjmFV2RrT2FTU+3ZilVJBNqhwNZptI1suJdMFefd9668Fa0
 m4/SuuBkh/W+qODDlxg3Bd3HyDdT5hB8WcplKGHdPzNRjuDZsymL/DVSguhnENNnNSkPAdr2+
 7ew4u/ri7ep38s8NRhCWZh5zpkVbtEjalLPzjMrnY6EH9VrjoHDATTp3GHo2XMh3QYNk2qLwo
 dbATwuAL3wg8IgOaijQ6RPOkk6BDLP0U1CO4rA+hrqs0PyfbuhlAth0G8qkJyykW/CjETiyzX
 Kb0NIWP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One of the really nice features of the ~/.gitconfig file is that users
can override defaults by their own preferred settings for all of their
repositories.

One such default that some users like to override is whether the
"origin" remote gets auto-pruned or not. The user would simply call

	git config --global remote.origin.prune true

and from now on all "origin" remotes would be pruned automatically when
fetching into the local repository.

There is just one catch: now Git thinks that the "origin" remote is
configured, even if the repository config has no [remote "origin"]
section at all, as it does not realize that the "prune" setting was
configured globally and that there really is no "origin" remote
configured in this repository.

That is a problem e.g. when renaming a remote to a new name, when Git
may be fooled into thinking that there is already a remote of that new
name.

Let's fix this by paying more attention to *where* the remote settings
came from: if they are configured in the local repository config, we
must not overwrite them. If they were configured elsewhere, we cannot
overwrite them to begin with, as we only write the repository config.

There is only one caller of remote_is_configured() (in `git fetch`) that
may want to take remotes into account even if they were configured
outside the repository config; all other callers essentially try to
prevent the Git command from overwriting settings in the repository
config.

To accommodate that fact, the remote_is_configured() function now
requires a parameter that states whether the caller is interested in all
remotes, or only in those that were configured in the repository config.

Many thanks to Jeff King whose tireless review helped with settling for
nothing less than the current strategy.

This fixes https://github.com/git-for-windows/git/issues/888

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/fetch.c   |  2 +-
 builtin/remote.c  | 14 +++++++-------
 remote.c          | 12 ++++++++++--
 remote.h          |  4 ++--
 t/t5505-remote.sh |  2 +-
 5 files changed, 21 insertions(+), 13 deletions(-)

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
index ad6c5424ed..8524135de4 100644
--- a/remote.c
+++ b/remote.c
@@ -255,6 +255,7 @@ static void read_remotes_file(struct remote *remote)
 
 	if (!f)
 		return;
+	remote->configured_in_repo = 1;
 	remote->origin = REMOTE_REMOTES;
 	while (strbuf_getline(&buf, f) != EOF) {
 		const char *v;
@@ -289,6 +290,7 @@ static void read_branches_file(struct remote *remote)
 		return;
 	}
 
+	remote->configured_in_repo = 1;
 	remote->origin = REMOTE_BRANCHES;
 
 	/*
@@ -371,6 +373,8 @@ static int handle_config(const char *key, const char *value, void *cb)
 	}
 	remote = make_remote(name, namelen);
 	remote->origin = REMOTE_CONFIG;
+	if (current_config_scope() == CONFIG_SCOPE_REPO)
+		remote->configured_in_repo = 1;
 	if (!strcmp(subkey, "mirror"))
 		remote->mirror = git_config_bool(key, value);
 	else if (!strcmp(subkey, "skipdefaultupdate"))
@@ -714,9 +718,13 @@ struct remote *pushremote_get(const char *name)
 	return remote_get_1(name, pushremote_for_branch);
 }
 
-int remote_is_configured(struct remote *remote)
+int remote_is_configured(struct remote *remote, int in_repo)
 {
-	return remote && remote->origin;
+	if (!remote)
+		return 0;
+	if (in_repo)
+		return remote->configured_in_repo;
+	return !!remote->origin;
 }
 
 int for_each_remote(each_remote_fn fn, void *priv)
diff --git a/remote.h b/remote.h
index 924881169d..a5bbbe0ef9 100644
--- a/remote.h
+++ b/remote.h
@@ -15,7 +15,7 @@ struct remote {
 	struct hashmap_entry ent;  /* must be first */
 
 	const char *name;
-	int origin;
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
index 2c03f44c85..ba46e86de0 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -764,7 +764,7 @@ test_expect_success 'rename a remote with name prefix of other remote' '
 	)
 '
 
-test_expect_failure 'rename succeeds with existing remote.<target>.prune' '
+test_expect_success 'rename succeeds with existing remote.<target>.prune' '
 	git clone one four.four &&
 	test_when_finished git config --global --unset remote.upstream.prune &&
 	git config --global remote.upstream.prune true &&
-- 
2.11.0.windows.3
