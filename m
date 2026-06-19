Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28E034167B
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 09:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.230.60.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781862516; cv=none; b=mDBwZjxeua7Dvtixa1/DdJGb+d9fOMmYTeSHBwZGmNfeAIdfJsk8aE6UQA0X9hFB5Uby9c9Qj7aXLpr1Y3e9oHjXDVhewEc0aliaGdben0NbLDEL/j4YtgUozVEaqf4qc+euS8qpw+XxVAgR+JWwumqeNrKOe3rVNea8kCpL7ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781862516; c=relaxed/simple;
	bh=MQcSmJckR7CiLW1o7y3ZWlCkORAFz9/1K9alKAlYKBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J3hFlDJFe5cmszLFG3GXaGyYdNQazngLMb9SJljZ7PMmq50BKcMngNTid3wnj1pjofpl01vdmEQWbTpnY7W2meCVUr3E6nmB7vwiE0QV0LEWSV+XuHMajHUKy+g1yFMm7Ke5MnE44Iytokm6+AeETtDyM/jowXskVlAzgE1/A50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us; spf=pass smtp.mailfrom=lfurio.us; dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b=VycSJe1L; arc=none smtp.client-ip=157.230.60.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b="VycSJe1L"
Received: by mail.normalmode.org (Postfix) with ESMTPSA id 943E86051C;
	Fri, 19 Jun 2026 09:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1781862512; bh=MQcSmJckR7CiLW1o7y3ZWlCkORAFz9/1K9alKAlYKBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VycSJe1Lz4TfHrpOIoapNuuL9IwOQDvvBuPsidTrdeSQKL9ODy0YXfWrlmF5N8DLb
	 2mrxQLbnqZNVZc82wBEyP9atAyJkelqcWHAfhx5sFuzsRkN9Hs40bi9qdoJaqndnvV
	 UFhTWwrju6uBubPqstqbviFyMqYuq2h5Lyg3wnpo=
From: Matt Hunter <m@lfurio.us>
To: git@vger.kernel.org
Cc: Bence Ferdinandy <bence@ferdinandy.com>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 7/8] fetch: add configuration variable fetch.followRemoteHEAD
Date: Fri, 19 Jun 2026 05:44:26 -0400
Message-ID: <20260619094751.2996804-8-m@lfurio.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619094751.2996804-1-m@lfurio.us>
References: <20260612055947.1499497-1-m@lfurio.us>
 <20260619094751.2996804-1-m@lfurio.us>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'fetch.followRemoteHEAD' is added as a generic setting used by all
remotes for which 'remote.<name>.followRemoteHEAD' is undefined.  If
both variables are undefined, a builtin default of "create" is in
effect, matching the previous behavior.

As mentioned in the previous patch, 'fetch.followRemoteHEAD' supports
all of the values that its 'remote' counterpart does _except_
warn-if-not-$branch, due to its tighter coupling to individual remote
repositories.

This setting interacts with the do_fetch mechanism in the same way as
the previous does, but there are opportunities for improved
user-experience discussed in [1].  See the included NEEDSWORK comment as
well.

Documentation and advice messages for both of the followRemoteHEAD
variables are reworded to better capture the relationship between the
two.

The added tests assert feature parity between the two followRemoteHEAD
variables, as well as the fact that 'remote.<name>.followRemoteHEAD'
always supersedes this new configurable default.

[1]: https://lore.kernel.org/git/xmqqh5n213bw.fsf@gitster.g/

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Matt Hunter <m@lfurio.us>
---
 Documentation/config/fetch.adoc  |  19 ++++++
 Documentation/config/remote.adoc |  21 +++----
 builtin/fetch.c                  |  41 ++++++++++--
 t/t5510-fetch.sh                 | 105 +++++++++++++++++++++++++++++++
 4 files changed, 169 insertions(+), 17 deletions(-)

diff --git a/Documentation/config/fetch.adoc b/Documentation/config/fetch.adoc
index 04ac90912d3a..00435e9a16d9 100644
--- a/Documentation/config/fetch.adoc
+++ b/Documentation/config/fetch.adoc
@@ -126,3 +126,22 @@ the new bundle URI.
 The creation token values are chosen by the provider serving the specific
 bundle URI. If you modify the URI at `fetch.bundleURI`, then be sure to
 remove the value for the `fetch.bundleCreationToken` value before fetching.
+
+`fetch.followRemoteHEAD`::
+	When fetching using a default refspec, this setting determines how to handle
+	differences between a fetched remote's `HEAD` and the local
+	`remotes/<name>/HEAD` symbolic-ref.  Its value is one of
++
+--
+`create`;;
+	Create `remotes/<name>/HEAD` if a ref exists on the remote, but not locally.
+	An existing symbolic-ref will not be touched.  This is the default value.
+`warn`;;
+	Display a warning if the remote advertises a different `HEAD` than what is
+	set locally.  Behaves like "create" if the local symbolic-ref doesn't exist.
+`always`;;
+	Silently update `remotes/<name>/HEAD` whenever the remote advertises a new
+	value.
+`never`;;
+	Never create or modify the `remotes/<name>/HEAD` symbolic-ref.
+--
diff --git a/Documentation/config/remote.adoc b/Documentation/config/remote.adoc
index eb9c8a3c4884..04724bc51628 100644
--- a/Documentation/config/remote.adoc
+++ b/Documentation/config/remote.adoc
@@ -157,15 +157,12 @@ Blank values signal to ignore all previous values, allowing a reset of
 the list from broader config scenarios.
 
 remote.<name>.followRemoteHEAD::
-	How linkgit:git-fetch[1] should handle updates to `remotes/<name>/HEAD`
-	when fetching using the configured refspecs of a remote.
-	The default value is "create", which will create `remotes/<name>/HEAD`
-	if it exists on the remote, but not locally; this will not touch an
-	already existing local reference. Setting it to "warn" will print
-	a message if the remote has a different value than the local one;
-	in case there is no local reference, it behaves like "create".
-	A variant on "warn" is "warn-if-not-$branch", which behaves like
-	"warn", but if `HEAD` on the remote is `$branch` it will be silent.
-	Setting it to "always" will silently update `remotes/<name>/HEAD` to
-	the value on the remote.  Finally, setting it to "never" will never
-	change or create the local reference.
+	When fetching this remote using its default refspec, this setting determines
+	how to handle differences between the remote's `HEAD` and the local
+	`remotes/<name>/HEAD` symbolic-ref.  Overrides the value of
+	`fetch.followRemoteHEAD`.  See `fetch.followRemoteHEAD` for a description of
+	accepted values.
++
+In addition to the values supported by `fetch.followRemoteHEAD`, this setting
+may also take on the value "warn-if-not-`$branch`", which behaves like "warn",
+but ignores the warning if the remote's `HEAD` is `remotes/<name>/$branch`.
diff --git a/builtin/fetch.c b/builtin/fetch.c
index ad63ca943c33..3c8210d1776f 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -103,6 +103,7 @@ static struct string_list negotiation_include = STRING_LIST_INIT_NODUP;
 
 struct fetch_config {
 	enum display_format display_format;
+	enum follow_remote_head_settings follow_remote_head;
 	int all;
 	int prune;
 	int prune_tags;
@@ -174,6 +175,22 @@ static int git_fetch_config(const char *k, const char *v,
 		return 0;
 	}
 
+	if (!strcmp(k, "fetch.followremotehead")) {
+		if (!v)
+			return config_error_nonbool(k);
+		else if (!strcmp(v, "never"))
+			fetch_config->follow_remote_head = FOLLOW_REMOTE_NEVER;
+		else if (!strcmp(v, "create"))
+			fetch_config->follow_remote_head = FOLLOW_REMOTE_CREATE;
+		else if (!strcmp(v, "warn"))
+			fetch_config->follow_remote_head = FOLLOW_REMOTE_WARN;
+		else if (!strcmp(v, "always"))
+			fetch_config->follow_remote_head = FOLLOW_REMOTE_ALWAYS;
+		else
+			warning(_("unrecognized fetch.followRemoteHEAD value '%s' ignored"), v);
+		return 0;
+	}
+
 	return git_default_config(k, v, ctx, cb);
 }
 
@@ -1698,11 +1715,13 @@ static const char *strip_refshead(const char *name){
 static void set_head_advice_msg(const char *remote, const char *head_name)
 {
 	const char message_advice_set_head[] =
-	N_("Run 'git remote set-head %s %s' to follow the change, or set\n"
-	   "'remote.%s.followRemoteHEAD' configuration option to a different value\n"
-	   "if you do not want to see this message. Specifically running\n"
-	   "'git config set remote.%s.followRemoteHEAD warn-if-not-%s'\n"
-	   "will disable the warning until the remote changes HEAD to something else.");
+	N_("Run 'git remote set-head %s %s' to follow the change, or modify\n"
+	   "either of the 'remote.%s.followRemoteHEAD' or 'fetch.followRemoteHEAD'\n"
+	   "configuration variables to handle the situation differently.\n\n"
+
+	   "Using this specific setting\n\n"
+	   "    git config set remote.%s.followRemoteHEAD warn-if-not-%s\n\n"
+	   "will suppress the warning until the remote changes HEAD to something else.");
 
 	advise_if_enabled(ADVICE_FETCH_SET_HEAD_WARN, _(message_advice_set_head),
 			remote, head_name, remote, remote, head_name);
@@ -1918,8 +1937,19 @@ static int do_fetch(struct transport *transport,
 			goto cleanup;
 	}
 
+	/*
+	 * NEEDSWORK: By the time this function executes, we have already parsed
+	 * all such followRemoteHEAD values from the external configuration,
+	 * potentially emitting warning messages for bogus values.  Ideally, if
+	 * this fetch ends up not needing to consult these values, then git would
+	 * not ever output a value warning. (eg: when pulling from a URL directly -
+	 * rather than a configured remote, or when a remote's followRemoteHEAD
+	 * overrides the fallback fetch setting)
+	 */
 	if (transport->remote->follow_remote_head)
 		follow_remote_head = transport->remote->follow_remote_head;
+	else if (config->follow_remote_head)
+		follow_remote_head = config->follow_remote_head;
 	else
 		follow_remote_head = BUILTIN_FOLLOW_REMOTE_HEAD_DFLT;
 
@@ -2478,6 +2508,7 @@ int cmd_fetch(int argc,
 {
 	struct fetch_config config = {
 		.display_format = DISPLAY_FORMAT_FULL,
+		.follow_remote_head = FOLLOW_REMOTE_UNCONFIGURED,
 		.prune = -1,
 		.prune_tags = -1,
 		.show_forced_updates = 1,
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 43190630e714..6f0ae1bdd798 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -140,6 +140,16 @@ test_expect_success "fetch test remote HEAD change" '
 	)
 '
 
+test_expect_success "fetch test default followRemoteHEAD never" '
+	git -C two update-ref --no-deref -d refs/remotes/origin/HEAD &&
+	test_config -C two fetch.followRemoteHEAD "never" &&
+	GIT_TRACE_PACKET=$PWD/trace.out git -C two fetch &&
+	# Confirm that we do not even ask for HEAD when we are
+	# not going to act on it.
+	test_grep ! "ref-prefix HEAD" trace.out &&
+	test_must_fail git -C two rev-parse --verify refs/remotes/origin/HEAD
+'
+
 test_expect_success "fetch test followRemoteHEAD never" '
 	git -C two update-ref --no-deref -d refs/remotes/origin/HEAD &&
 	test_config -C two remote.origin.followRemoteHEAD "never" &&
@@ -150,6 +160,21 @@ test_expect_success "fetch test followRemoteHEAD never" '
 	test_must_fail git -C two rev-parse --verify refs/remotes/origin/HEAD
 '
 
+test_expect_success "fetch test default followRemoteHEAD warn no change" '
+	git -C two rev-parse --verify refs/remotes/origin/other &&
+	git -C two remote set-head origin other &&
+	git -C two rev-parse --verify refs/remotes/origin/HEAD &&
+	git -C two rev-parse --verify refs/remotes/origin/main &&
+	test_config -C two fetch.followRemoteHEAD "warn" &&
+	git -C two fetch >output &&
+	echo "${SQ}HEAD${SQ} at ${SQ}origin${SQ} is ${SQ}main${SQ}," \
+		"but we have ${SQ}other${SQ} locally." >expect &&
+	test_cmp expect output &&
+	head=$(git -C two rev-parse refs/remotes/origin/HEAD) &&
+	branch=$(git -C two rev-parse refs/remotes/origin/other) &&
+	test "z$head" = "z$branch"
+'
+
 test_expect_success "fetch test followRemoteHEAD warn no change" '
 	git -C two rev-parse --verify refs/remotes/origin/other &&
 	git -C two remote set-head origin other &&
@@ -165,6 +190,17 @@ test_expect_success "fetch test followRemoteHEAD warn no change" '
 	test "z$head" = "z$branch"
 '
 
+test_expect_success "fetch test default followRemoteHEAD warn create" '
+	git -C two update-ref --no-deref -d refs/remotes/origin/HEAD &&
+	test_config -C two fetch.followRemoteHEAD "warn" &&
+	git -C two rev-parse --verify refs/remotes/origin/main &&
+	output=$(git -C two fetch) &&
+	test "z" = "z$output" &&
+	head=$(git -C two rev-parse refs/remotes/origin/HEAD) &&
+	branch=$(git -C two rev-parse refs/remotes/origin/main) &&
+	test "z$head" = "z$branch"
+'
+
 test_expect_success "fetch test followRemoteHEAD warn create" '
 	git -C two update-ref --no-deref -d refs/remotes/origin/HEAD &&
 	test_config -C two remote.origin.followRemoteHEAD "warn" &&
@@ -176,6 +212,18 @@ test_expect_success "fetch test followRemoteHEAD warn create" '
 	test "z$head" = "z$branch"
 '
 
+test_expect_success "fetch test default followRemoteHEAD warn detached" '
+	git -C two update-ref --no-deref -d refs/remotes/origin/HEAD &&
+	git -C two update-ref refs/remotes/origin/HEAD HEAD &&
+	HEAD=$(git -C two log --pretty="%H") &&
+	test_config -C two fetch.followRemoteHEAD "warn" &&
+	git -C two fetch >output &&
+	echo "${SQ}HEAD${SQ} at ${SQ}origin${SQ} is ${SQ}main${SQ}," \
+		"but we have a detached HEAD pointing to" \
+		"${SQ}${HEAD}${SQ} locally." >expect &&
+	test_cmp expect output
+'
+
 test_expect_success "fetch test followRemoteHEAD warn detached" '
 	git -C two update-ref --no-deref -d refs/remotes/origin/HEAD &&
 	git -C two update-ref refs/remotes/origin/HEAD HEAD &&
@@ -188,6 +236,19 @@ test_expect_success "fetch test followRemoteHEAD warn detached" '
 	test_cmp expect output
 '
 
+test_expect_success "fetch test default followRemoteHEAD warn quiet" '
+	git -C two rev-parse --verify refs/remotes/origin/other &&
+	git -C two remote set-head origin other &&
+	git -C two rev-parse --verify refs/remotes/origin/HEAD &&
+	git -C two rev-parse --verify refs/remotes/origin/main &&
+	test_config -C two fetch.followRemoteHEAD "warn" &&
+	output=$(git -C two fetch --quiet) &&
+	test "z" = "z$output" &&
+	head=$(git -C two rev-parse refs/remotes/origin/HEAD) &&
+	branch=$(git -C two rev-parse refs/remotes/origin/other) &&
+	test "z$head" = "z$branch"
+'
+
 test_expect_success "fetch test followRemoteHEAD warn quiet" '
 	git -C two rev-parse --verify refs/remotes/origin/other &&
 	git -C two remote set-head origin other &&
@@ -229,6 +290,18 @@ test_expect_success "fetch test followRemoteHEAD warn-if-not-branch branch is di
 	test "z$head" = "z$branch"
 '
 
+test_expect_success "fetch test default followRemoteHEAD always" '
+	git -C two rev-parse --verify refs/remotes/origin/other &&
+	git -C two remote set-head origin other &&
+	git -C two rev-parse --verify refs/remotes/origin/HEAD &&
+	git -C two rev-parse --verify refs/remotes/origin/main &&
+	test_config -C two fetch.followRemoteHEAD "always" &&
+	git -C two fetch &&
+	head=$(git -C two rev-parse refs/remotes/origin/HEAD) &&
+	branch=$(git -C two rev-parse refs/remotes/origin/main) &&
+	test "z$head" = "z$branch"
+'
+
 test_expect_success "fetch test followRemoteHEAD always" '
 	git -C two rev-parse --verify refs/remotes/origin/other &&
 	git -C two remote set-head origin other &&
@@ -241,6 +314,28 @@ test_expect_success "fetch test followRemoteHEAD always" '
 	test "z$head" = "z$branch"
 '
 
+test_expect_success 'per-remote followRemoteHEAD takes priority over fetch default' '
+	git -C two rev-parse --verify refs/remotes/origin/other &&
+	git -C two remote set-head origin other &&
+	git -C two rev-parse --verify refs/remotes/origin/HEAD &&
+	git -C two rev-parse --verify refs/remotes/origin/main &&
+	test_config -C two fetch.followRemoteHEAD "never" &&
+	test_config -C two remote.origin.followRemoteHEAD "always" &&
+	git -C two fetch &&
+	head=$(git -C two rev-parse refs/remotes/origin/HEAD) &&
+	branch=$(git -C two rev-parse refs/remotes/origin/main) &&
+	test "z$head" = "z$branch"
+'
+
+test_expect_success 'default followRemoteHEAD does not kick in with refspecs' '
+	git -C two remote set-head origin other &&
+	test_config -C two fetch.followRemoteHEAD always &&
+	git -C two fetch origin refs/heads/main:refs/remotes/origin/main &&
+	echo refs/remotes/origin/other >expect &&
+	git -C two symbolic-ref refs/remotes/origin/HEAD >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'followRemoteHEAD does not kick in with refspecs' '
 	git -C two remote set-head origin other &&
 	test_config -C two remote.origin.followRemoteHEAD always &&
@@ -250,6 +345,16 @@ test_expect_success 'followRemoteHEAD does not kick in with refspecs' '
 	test_cmp expect actual
 '
 
+test_expect_success 'default followRemoteHEAD create does not overwrite dangling symref' '
+	test_when_finished "git -C two remote remove custom-head" &&
+	git -C two remote add -m does-not-exist custom-head ../one &&
+	test_config -C two fetch.followRemoteHEAD create &&
+	git -C two fetch custom-head &&
+	echo refs/remotes/custom-head/does-not-exist >expect &&
+	git -C two symbolic-ref refs/remotes/custom-head/HEAD >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'followRemoteHEAD create does not overwrite dangling symref' '
 	test_when_finished "git -C two remote remove custom-head" &&
 	git -C two remote add -m does-not-exist custom-head ../one &&
-- 
2.54.0

