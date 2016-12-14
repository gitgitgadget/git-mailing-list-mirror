Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A69D51FF40
	for <e@80x24.org>; Wed, 14 Dec 2016 22:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935045AbcLNWkV (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 17:40:21 -0500
Received: from mail-pg0-f46.google.com ([74.125.83.46]:33589 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934725AbcLNWkT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 17:40:19 -0500
Received: by mail-pg0-f46.google.com with SMTP id 3so12529244pgd.0
        for <git@vger.kernel.org>; Wed, 14 Dec 2016 14:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6iYMkrgrlyjQ03kH7/nMhk2ZF5fRy5DVPKp4uFtG7OQ=;
        b=E+mJdsH+cqvhQRzKZhA9czLKbhFQCrSwhXG7fVVtZnEHOtYzY2j/fcxIPdpXK2E/Tm
         /9phZSargKCvKLllOqVJzv48g5END8byXIaeiAUkLfUujZlZjOh+e2uMzqN26O6o2nnk
         BeU2jEtRe0h6zY5GLOJtVSgMamPR7YSSqGK4kgaAo44UeB+zLywes5c1iVa/dYaSE1FC
         7dWcvsy9mp7Adu0nT8Z1tJ2WzlF+7m1pS15T2DyDfYrME85tEUdLfVaWhSFOrwT1U5Dz
         vFyBtOs3UunKnPts7vwxstSUc+wWYmZzkKvy6n25LYRIo348HEaJikAg1PgfDv2y6woi
         C05w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6iYMkrgrlyjQ03kH7/nMhk2ZF5fRy5DVPKp4uFtG7OQ=;
        b=NgJWNxnE6dLnKdwKmku9GOAErr96pkCJo5B0sLCFyhO2FtxGJU56MIYlyr0Bu+oowA
         hQnLTGPVKjrFW/FoBkm4xfZB+TY1P0Je0lpY37M0P82Y00ZSx4jZcnIjZP2SaV5E+zw1
         3u4bMnlnewh4TLt33CocGUbQAuB1ghHw8zFd2A9eHarxydSzCAEGHScZM72HVKFzZc8/
         ITZpmXCvuI55krW4U9nhRLb9YTchEf2ThbGI0t9ijy7NNkRcqJ5Qs4uWz5eP+dPp8iE6
         y016hwSEgf63B8653QwO7CyaUwj0im7dMT8NNhx5GHfPlaV2UX06AmyE4pzDV7NKfrUI
         Mh0w==
X-Gm-Message-State: AKaTC00pl61v0ThZhk7/QGYVu6Jw1eOg3wwzFh1SjY1laY/pRKwAUtxH7GypPNNhynnjSK/L
X-Received: by 10.84.133.69 with SMTP id 63mr211830717plf.15.1481755218317;
        Wed, 14 Dec 2016 14:40:18 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id 72sm89600973pfw.37.2016.12.14.14.40.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Dec 2016 14:40:17 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, gitster@pobox.com,
        peff@peff.net, sbeller@google.com, bburky@bburky.com,
        jrnieder@gmail.com
Subject: [PATCH v10 3/6] transport: add protocol policy config option
Date:   Wed, 14 Dec 2016 14:39:52 -0800
Message-Id: <1481755195-174539-4-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481755195-174539-1-git-send-email-bmwill@google.com>
References: <1481679637-133137-1-git-send-email-bmwill@google.com>
 <1481755195-174539-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously the `GIT_ALLOW_PROTOCOL` environment variable was used to
specify a whitelist of protocols to be used in clone/fetch/push
commands.  This patch introduces new configuration options for more
fine-grained control for allowing/disallowing protocols.  This also has
the added benefit of allowing easier construction of a protocol
whitelist on systems where setting an environment variable is
non-trivial.

Now users can specify a policy to be used for each type of protocol via
the 'protocol.<name>.allow' config option.  A default policy for all
unconfigured protocols can be set with the 'protocol.allow' config
option.  If no user configured default is made git will allow known-safe
protocols (http, https, git, ssh, file), disallow known-dangerous
protocols (ext), and have a default policy of `user` for all other
protocols.

The supported policies are `always`, `never`, and `user`.  The `user`
policy can be used to configure a protocol to be usable when explicitly
used by a user, while disallowing it for commands which run
clone/fetch/push commands without direct user intervention (e.g.
recursive initialization of submodules).  Commands which can potentially
clone/fetch/push from untrusted repositories without user intervention
can export `GIT_PROTOCOL_FROM_USER` with a value of '0' to prevent
protocols configured to the `user` policy from being used.

Fix remote-ext tests to use the new config to allow the ext
protocol to be tested.

Based on a patch by Jeff King <peff@peff.net>

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 Documentation/config.txt         |  46 ++++++++++++++
 Documentation/git.txt            |  38 +++++-------
 git-submodule.sh                 |  12 ++--
 t/lib-proto-disable.sh           | 130 +++++++++++++++++++++++++++++++++++++--
 t/t5509-fetch-push-namespaces.sh |   1 +
 t/t5802-connect-helper.sh        |   1 +
 transport.c                      |  75 +++++++++++++++++++++-
 7 files changed, 264 insertions(+), 39 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 8153336..50d3d06 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2260,6 +2260,52 @@ pretty.<name>::
 	Note that an alias with the same name as a built-in format
 	will be silently ignored.
 
+protocol.allow::
+	If set, provide a user defined default policy for all protocols which
+	don't explicitly have a policy (`protocol.<name>.allow`).  By default,
+	if unset, known-safe protocols (http, https, git, ssh, file) have a
+	default policy of `always`, known-dangerous protocols (ext) have a
+	default policy of `never`, and all other protocols have a default
+	policy of `user`.  Supported policies:
++
+--
+
+* `always` - protocol is always able to be used.
+
+* `never` - protocol is never able to be used.
+
+* `user` - protocol is only able to be used when `GIT_PROTOCOL_FROM_USER` is
+  either unset or has a value of 1.  This policy should be used when you want a
+  protocol to be directly usable by the user but don't want it used by commands which
+  execute clone/fetch/push commands without user input, e.g. recursive
+  submodule initialization.
+
+--
+
+protocol.<name>.allow::
+	Set a policy to be used by protocol `<name>` with clone/fetch/push
+	commands. See `protocol.allow` above for the available policies.
++
+The protocol names currently used by git are:
++
+--
+  - `file`: any local file-based path (including `file://` URLs,
+    or local paths)
+
+  - `git`: the anonymous git protocol over a direct TCP
+    connection (or proxy, if configured)
+
+  - `ssh`: git over ssh (including `host:path` syntax,
+    `ssh://`, etc).
+
+  - `http`: git over http, both "smart http" and "dumb http".
+    Note that this does _not_ include `https`; if you want to configure
+    both, you must do so individually.
+
+  - any external helpers are named by their protocol (e.g., use
+    `hg` to allow the `git-remote-hg` helper)
+--
+
 pull.ff::
 	By default, Git does not create an extra merge commit when merging
 	a commit that is a descendant of the current commit. Instead, the
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 923aa49..d9fb937 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -1129,30 +1129,20 @@ of clones and fetches.
 	cloning a repository to make a backup).
 
 `GIT_ALLOW_PROTOCOL`::
-	If set, provide a colon-separated list of protocols which are
-	allowed to be used with fetch/push/clone. This is useful to
-	restrict recursive submodule initialization from an untrusted
-	repository. Any protocol not mentioned will be disallowed (i.e.,
-	this is a whitelist, not a blacklist). If the variable is not
-	set at all, all protocols are enabled.  The protocol names
-	currently used by git are:
-
-	  - `file`: any local file-based path (including `file://` URLs,
-	    or local paths)
-
-	  - `git`: the anonymous git protocol over a direct TCP
-	    connection (or proxy, if configured)
-
-	  - `ssh`: git over ssh (including `host:path` syntax,
-	    `ssh://`, etc).
-
-	  - `http`: git over http, both "smart http" and "dumb http".
-	    Note that this does _not_ include `https`; if you want both,
-	    you should specify both as `http:https`.
-
-	  - any external helpers are named by their protocol (e.g., use
-	    `hg` to allow the `git-remote-hg` helper)
-
+	If set to a colon-separated list of protocols, behave as if
+	`protocol.allow` is set to `never`, and each of the listed
+	protocols has `protocol.<name>.allow` set to `always`
+	(overriding any existing configuration). In other words, any
+	protocol not mentioned will be disallowed (i.e., this is a
+	whitelist, not a blacklist). See the description of
+	`protocol.allow` in linkgit:git-config[1] for more details.
+
+`GIT_PROTOCOL_FROM_USER`::
+	Set to 0 to prevent protocols used by fetch/push/clone which are
+	configured to the `user` state.  This is useful to restrict recursive
+	submodule initialization from an untrusted repository or for programs
+	which feed potentially-untrusted URLS to git commands.  See
+	linkgit:git-config[1] for more details.
 
 Discussion[[Discussion]]
 ------------------------
diff --git a/git-submodule.sh b/git-submodule.sh
index 78fdac9..fc44076 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -22,14 +22,10 @@ require_work_tree
 wt_prefix=$(git rev-parse --show-prefix)
 cd_to_toplevel
 
-# Restrict ourselves to a vanilla subset of protocols; the URLs
-# we get are under control of a remote repository, and we do not
-# want them kicking off arbitrary git-remote-* programs.
-#
-# If the user has already specified a set of allowed protocols,
-# we assume they know what they're doing and use that instead.
-: ${GIT_ALLOW_PROTOCOL=file:git:http:https:ssh}
-export GIT_ALLOW_PROTOCOL
+# Tell the rest of git that any URLs we get don't come
+# directly from the user, so it can apply policy as appropriate.
+GIT_PROTOCOL_FROM_USER=0
+export GIT_PROTOCOL_FROM_USER
 
 command=
 branch=
diff --git a/t/lib-proto-disable.sh b/t/lib-proto-disable.sh
index be88e9a..02f49cb 100644
--- a/t/lib-proto-disable.sh
+++ b/t/lib-proto-disable.sh
@@ -1,10 +1,7 @@
 # Test routines for checking protocol disabling.
 
-# test cloning a particular protocol
-#   $1 - description of the protocol
-#   $2 - machine-readable name of the protocol
-#   $3 - the URL to try cloning
-test_proto () {
+# Test clone/fetch/push with GIT_ALLOW_PROTOCOL whitelist
+test_whitelist () {
 	desc=$1
 	proto=$2
 	url=$3
@@ -62,6 +59,129 @@ test_proto () {
 			test_must_fail git clone --bare "$url" tmp.git
 		)
 	'
+
+	test_expect_success "clone $desc (env var has precedence)" '
+		rm -rf tmp.git &&
+		(
+			GIT_ALLOW_PROTOCOL=none &&
+			export GIT_ALLOW_PROTOCOL &&
+			test_must_fail git -c protocol.allow=always clone --bare "$url" tmp.git &&
+			test_must_fail git -c protocol.$proto.allow=always clone --bare "$url" tmp.git
+		)
+	'
+}
+
+test_config () {
+	desc=$1
+	proto=$2
+	url=$3
+
+	# Test clone/fetch/push with protocol.<type>.allow config
+	test_expect_success "clone $desc (enabled with config)" '
+		rm -rf tmp.git &&
+		git -c protocol.$proto.allow=always clone --bare "$url" tmp.git
+	'
+
+	test_expect_success "fetch $desc (enabled)" '
+		git -C tmp.git -c protocol.$proto.allow=always fetch
+	'
+
+	test_expect_success "push $desc (enabled)" '
+		git -C tmp.git -c protocol.$proto.allow=always  push origin HEAD:pushed
+	'
+
+	test_expect_success "push $desc (disabled)" '
+		test_must_fail git -C tmp.git -c protocol.$proto.allow=never push origin HEAD:pushed
+	'
+
+	test_expect_success "fetch $desc (disabled)" '
+		test_must_fail git -C tmp.git -c protocol.$proto.allow=never fetch
+	'
+
+	test_expect_success "clone $desc (disabled)" '
+		rm -rf tmp.git &&
+		test_must_fail git -c protocol.$proto.allow=never clone --bare "$url" tmp.git
+	'
+
+	# Test clone/fetch/push with protocol.user.allow and its env var
+	test_expect_success "clone $desc (enabled)" '
+		rm -rf tmp.git &&
+		git -c protocol.$proto.allow=user clone --bare "$url" tmp.git
+	'
+
+	test_expect_success "fetch $desc (enabled)" '
+		git -C tmp.git -c protocol.$proto.allow=user fetch
+	'
+
+	test_expect_success "push $desc (enabled)" '
+		git -C tmp.git -c protocol.$proto.allow=user push origin HEAD:pushed
+	'
+
+	test_expect_success "push $desc (disabled)" '
+		(
+			cd tmp.git &&
+			GIT_PROTOCOL_FROM_USER=0 &&
+			export GIT_PROTOCOL_FROM_USER &&
+			test_must_fail git -c protocol.$proto.allow=user push origin HEAD:pushed
+		)
+	'
+
+	test_expect_success "fetch $desc (disabled)" '
+		(
+			cd tmp.git &&
+			GIT_PROTOCOL_FROM_USER=0 &&
+			export GIT_PROTOCOL_FROM_USER &&
+			test_must_fail git -c protocol.$proto.allow=user fetch
+		)
+	'
+
+	test_expect_success "clone $desc (disabled)" '
+		rm -rf tmp.git &&
+		(
+			GIT_PROTOCOL_FROM_USER=0 &&
+			export GIT_PROTOCOL_FROM_USER &&
+			test_must_fail git -c protocol.$proto.allow=user clone --bare "$url" tmp.git
+		)
+	'
+
+	# Test clone/fetch/push with protocol.allow user defined default
+	test_expect_success "clone $desc (enabled)" '
+		rm -rf tmp.git &&
+		git config --global protocol.allow always &&
+		git clone --bare "$url" tmp.git
+	'
+
+	test_expect_success "fetch $desc (enabled)" '
+		git -C tmp.git fetch
+	'
+
+	test_expect_success "push $desc (enabled)" '
+		git -C tmp.git push origin HEAD:pushed
+	'
+
+	test_expect_success "push $desc (disabled)" '
+		git config --global protocol.allow never &&
+		test_must_fail git -C tmp.git push origin HEAD:pushed
+	'
+
+	test_expect_success "fetch $desc (disabled)" '
+		test_must_fail git -C tmp.git fetch
+	'
+
+	test_expect_success "clone $desc (disabled)" '
+		rm -rf tmp.git &&
+		test_must_fail git clone --bare "$url" tmp.git
+	'
+}
+
+# test cloning a particular protocol
+#   $1 - description of the protocol
+#   $2 - machine-readable name of the protocol
+#   $3 - the URL to try cloning
+test_proto () {
+	test_whitelist "$@"
+
+	test_config "$@"
 }
 
 # set up an ssh wrapper that will access $host/$repo in the
diff --git a/t/t5509-fetch-push-namespaces.sh b/t/t5509-fetch-push-namespaces.sh
index bc44ac3..75c570a 100755
--- a/t/t5509-fetch-push-namespaces.sh
+++ b/t/t5509-fetch-push-namespaces.sh
@@ -4,6 +4,7 @@ test_description='fetch/push involving ref namespaces'
 . ./test-lib.sh
 
 test_expect_success setup '
+	git config --global protocol.ext.allow user &&
 	test_tick &&
 	git init original &&
 	(
diff --git a/t/t5802-connect-helper.sh b/t/t5802-connect-helper.sh
index b7a7f9d..c6c2661 100755
--- a/t/t5802-connect-helper.sh
+++ b/t/t5802-connect-helper.sh
@@ -4,6 +4,7 @@ test_description='ext::cmd remote "connect" helper'
 . ./test-lib.sh
 
 test_expect_success setup '
+	git config --global protocol.ext.allow user &&
 	test_tick &&
 	git commit --allow-empty -m initial &&
 	test_tick &&
diff --git a/transport.c b/transport.c
index dff929e..fbd799d 100644
--- a/transport.c
+++ b/transport.c
@@ -617,10 +617,81 @@ static const struct string_list *protocol_whitelist(void)
 	return enabled ? &allowed : NULL;
 }
 
+enum protocol_allow_config {
+	PROTOCOL_ALLOW_NEVER = 0,
+	PROTOCOL_ALLOW_USER_ONLY,
+	PROTOCOL_ALLOW_ALWAYS
+};
+
+static enum protocol_allow_config parse_protocol_config(const char *key,
+							const char *value)
+{
+	if (!strcasecmp(value, "always"))
+		return PROTOCOL_ALLOW_ALWAYS;
+	else if (!strcasecmp(value, "never"))
+		return PROTOCOL_ALLOW_NEVER;
+	else if (!strcasecmp(value, "user"))
+		return PROTOCOL_ALLOW_USER_ONLY;
+
+	die("unknown value for config '%s': %s", key, value);
+}
+
+static enum protocol_allow_config get_protocol_config(const char *type)
+{
+	char *key = xstrfmt("protocol.%s.allow", type);
+	char *value;
+
+	/* first check the per-protocol config */
+	if (!git_config_get_string(key, &value)) {
+		enum protocol_allow_config ret =
+			parse_protocol_config(key, value);
+		free(key);
+		free(value);
+		return ret;
+	}
+	free(key);
+
+	/* if defined, fallback to user-defined default for unknown protocols */
+	if (!git_config_get_string("protocol.allow", &value)) {
+		enum protocol_allow_config ret =
+			parse_protocol_config("protocol.allow", value);
+		free(value);
+		return ret;
+	}
+
+	/* fallback to built-in defaults */
+	/* known safe */
+	if (!strcmp(type, "http") ||
+	    !strcmp(type, "https") ||
+	    !strcmp(type, "git") ||
+	    !strcmp(type, "ssh") ||
+	    !strcmp(type, "file"))
+		return PROTOCOL_ALLOW_ALWAYS;
+
+	/* known scary; err on the side of caution */
+	if (!strcmp(type, "ext"))
+		return PROTOCOL_ALLOW_NEVER;
+
+	/* unknown; by default let them be used only directly by the user */
+	return PROTOCOL_ALLOW_USER_ONLY;
+}
+
 int is_transport_allowed(const char *type)
 {
-	const struct string_list *allowed = protocol_whitelist();
-	return !allowed || string_list_has_string(allowed, type);
+	const struct string_list *whitelist = protocol_whitelist();
+	if (whitelist)
+		return string_list_has_string(whitelist, type);
+
+	switch (get_protocol_config(type)) {
+	case PROTOCOL_ALLOW_ALWAYS:
+		return 1;
+	case PROTOCOL_ALLOW_NEVER:
+		return 0;
+	case PROTOCOL_ALLOW_USER_ONLY:
+		return git_env_bool("GIT_PROTOCOL_FROM_USER", 1);
+	}
+
+	die("BUG: invalid protocol_allow_config type");
 }
 
 void transport_check_allowed(const char *type)
-- 
2.8.0.rc3.226.g39d4020

