Received: from aib29agh122.zrh1.oracleemaildelivery.com (aib29agh122.zrh1.oracleemaildelivery.com [192.29.178.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA761F9AB2
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 13:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729518352; cv=none; b=OpmbXc9D/I6oyndK20LZmXLVogHqsvulKUwTb9P3ldZfmwYVGgJ3Z3uZN4GuQee+ISe5Q8QouvdkSV+6mIq2icuGD5Y3V12I1uZC+pOokppeoRoPlIzT07uEnAR8xRpkMgpoH/7wh8YUkdt3iOgzb8Qj7E/or2n/7u49PHKyN1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729518352; c=relaxed/simple;
	bh=lp7fF5+d5LzfqWCGd6PTBxjksVZr8SltDIrDd4tEgZ0=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=M69+uTgmEGouNFM6/QDL33S8Ly06CBrxvSmkaIKHq0CiKoFR4Wba7K2yl/8zgcx9j9wENXeFT2zFQLe/hcRxmdWWLWnqcZArIx+APgW24bQNrL9V+eD5cvvvv9D4Nt6oM2RydYfikRS2+C9XeLjcrKrOZivI8Z/K/jLULgSrbgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=Jgm2HWWD; arc=none smtp.client-ip=192.29.178.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="Jgm2HWWD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=neWDksbzDyGpoVMAyqnIKkl2j9TLrgqDawrfTTnWsaM=;
 b=Jgm2HWWDH+IdNtbsahAeS7hAbtV7XmF9KSfllSii8dprXsgs802fWooeMZTFz9pcBGYoWOejR6Hg
   VlHG7J2ima7xyf1VzQdbePltAC/hxZc+w90k0WUVAGpcufXwZVMDNxNFs75GW74LBn99uknKAlWz
   JeQduyC+mW604PHBd3RDjWA1Qi4SWNnLRcpuffoE8lZFC3Tz5jUHPe76GtHMRgW0PfmgkCmVNCVq
   Ue+zV8OmmS/9P2iqW1kqPxuM0kFaQPm0JP3/gdIr7W/8MraXCoa/QxNXrRwiae54SRQyVLAW4WUN
   9H4r5nnADUNFBOkB3LYz8DiWuBfFNZDggJt8Eg==
Received: by omta-ad1-fd1-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SLP00L7SKW0LE80@omta-ad1-fd1-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Mon, 21 Oct 2024 13:45:36 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?F=C5=91v=C3=A1rosi=20V=C3=ADzm=C5=B1vek=20Zrt=2E?=
 <noreply@vizmuvek.hu>,	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v10 7/8] fetch: set remote/HEAD if it does not exist
Date: Mon, 21 Oct 2024 15:37:04 +0200
Message-id: <20241021134354.705636-8-bence@ferdinandy.com>
In-reply-to: <20241021134354.705636-1-bence@ferdinandy.com>
References: <1088915169.629942.1729445083543@FVRT-HAMMYAS-P.vizmuvek.hu>
 <20241021134354.705636-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAE6BqyhgBdw3psBAgzOYdkbpZ8nb9aOMlGbkvEbMCP+FYXYH0Z2PsjfZFybAL2p
 F4KXeXYr4sKQKCoxQPXaMxcVOAjEy3L+QKXW9DTo1OmS+DpturXxgPrNpQkZ2/nK
 hnv9ZDh1QRDb0r/FVMhDxJsjIcvnumyOsyHUkZ8EGFheiBtxd7Tjhr3HaIYhc5dw
 h4oYiVO9kVwVY489Ilra62EnFnHKd5EiNahWQ17S5zwUS2o0uKIHH4/HmvgTREMA
 dOZbD/7VzKFCMQF/Tq0uRfpGiaqQBmzRFYBT4grjvZ5iomnQ1JdIOO8oyjiDhaBM
 OTfD4hUCHoUBdmoa2uV/LfvEt+glKk3WdE+ryCLza4/RXwBr4Vkm32r76FwaI2RS
 rWo8zFl2n1gNcXa6Sk+VyMCydu8Gd3Vu06rREecfyZ4KJlvFo44atXxg1tr8wVMM
 BG7I2ijUtf7C3KNrxGIRnZkXcHx21RLsvBxUtLggb/aukkalFZ9Ob+93

If the user has remote/HEAD set already and it looks like it has changed
on the server, then print a message, otherwise set it if we can.
Silently pass if the user already has the same remote/HEAD set as
reported by the server or if we encounter any errors along the way.

Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
---

Notes:
    v3: - does not rely on remote set-head anymore so it only authenticates
        once
        - uses the new REF_CREATE_ONLY to atomically check if the ref exists
          and only write it if it doesn't
        - in all other cases the maximum it does is print a warning
    
    v4: - instead of the discarded REF_CREATE_ONLY, it uses the existing,
          but updated transaction api to request a silent create only
        - it now uses the atomic before_target to determine reporting
        - refactored for legibility
    
    v5: - instead of printing a not too useful message, it now fails
          silently, this in line with the objective to only set up
          remote/HEAD automatically if the right thing is trivial, for
          everything else there is remote set-head
        - fixed all failing tests
        - added two new tests, one for checking if remote/HEAD is set to the
          correct one, and one to test that we do not override remote/HEAD
          if it has changed on the server from what we have locally
    
    v6: - fixed style issues and unintended extra empty line
        - updated function call with bool to int from previous patch's
          change
        - removed calls to error(...) inherited from builtin/remote.c so we
          actually fail silently
        - set the test for remote set-head --auto to the correct value here,
          which was previously erronously set in the remote set-head patch
    
    v7: - no change
    
    v8: - changed logmsg in call to refs_update_symref from "remote
          set-head" to "fetch"
    
    v9: - follow through with refs_update_symref_extended
        - fix test errors uncovered by the new patch
    
    v10: no change

 builtin/fetch.c                  |  82 +++++++++++
 t/t4207-log-decoration-colors.sh |   3 +-
 t/t5505-remote.sh                |  21 ++-
 t/t5510-fetch.sh                 | 229 ++++++++++++++++---------------
 t/t5512-ls-remote.sh             |   2 +
 t/t5514-fetch-multiple.sh        |  17 ++-
 t/t5516-fetch-push.sh            |   3 +-
 t/t5527-fetch-odd-refs.sh        |   3 +-
 t/t7900-maintenance.sh           |   3 +-
 t/t9210-scalar.sh                |   5 +-
 t/t9211-scalar-clone.sh          |   6 +-
 t/t9902-completion.sh            |  65 +++++++++
 12 files changed, 315 insertions(+), 124 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index d9027e4dc9..31edc67447 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1578,6 +1578,80 @@ static int backfill_tags(struct display_state *display_state,
 	return retcode;
 }
 
+static void report_set_head(const char *remote, const char *head_name,
+			struct strbuf *buf_prev) {
+	struct strbuf buf_prefix = STRBUF_INIT;
+	const char *prev_head = NULL;
+
+	strbuf_addf(&buf_prefix, "refs/remotes/%s/", remote);
+	skip_prefix(buf_prev->buf, buf_prefix.buf, &prev_head);
+
+	if (prev_head && strcmp(prev_head, head_name)) {
+		printf("'HEAD' at '%s' has changed from '%s' to '%s'\n",
+			remote, prev_head, head_name);
+		printf("Run 'git remote set-head %s %s' to follow the change.\n",
+			remote, head_name);
+	}
+}
+
+static const char *strip_refshead(const char *name){
+	skip_prefix(name, "refs/heads/", &name);
+	return name;
+}
+
+static int set_head(const struct ref *remote_refs)
+{
+	int result = 0;
+	struct strbuf b_head = STRBUF_INIT, b_remote_head = STRBUF_INIT,
+		b_local_head = STRBUF_INIT;
+	const char *remote = gtransport->remote->name;
+	char *head_name = NULL;
+	struct ref *ref, *matches;
+	struct ref *fetch_map = NULL, **fetch_map_tail = &fetch_map;
+	struct refspec_item refspec = {
+		.force = 0,
+		.pattern = 1,
+		.src = (char *) "refs/heads/*",
+		.dst = (char *) "refs/heads/*",
+	};
+	struct string_list heads = STRING_LIST_INIT_DUP;
+	struct ref_store *refs = get_main_ref_store(the_repository);
+
+	get_fetch_map(remote_refs, &refspec, &fetch_map_tail, 0);
+	matches = guess_remote_head(find_ref_by_name(remote_refs, "HEAD"),
+				    fetch_map, 1);
+	for (ref = matches; ref; ref = ref->next) {
+		string_list_append(&heads, strip_refshead(ref->name));
+	}
+
+
+	if (!heads.nr)
+		result = 1;
+	else if (heads.nr > 1)
+		result = 1;
+	else
+		head_name = xstrdup(heads.items[0].string);
+	if (head_name) {
+		strbuf_addf(&b_head, "refs/remotes/%s/HEAD", remote);
+		strbuf_addf(&b_remote_head, "refs/remotes/%s/%s", remote, head_name);
+		/* make sure it's valid */
+		if (!refs_ref_exists(refs, b_remote_head.buf))
+			result = 1;
+		else if (refs_update_symref_extended(refs, b_head.buf, b_remote_head.buf,
+					"fetch", &b_local_head, 1))
+			result = 1;
+		else
+			report_set_head(remote, head_name, &b_local_head);
+
+		free(head_name);
+	}
+
+	strbuf_release(&b_head);
+	strbuf_release(&b_local_head);
+	strbuf_release(&b_remote_head);
+	return result;
+}
+
 static int do_fetch(struct transport *transport,
 		    struct refspec *rs,
 		    const struct fetch_config *config)
@@ -1647,6 +1721,8 @@ static int do_fetch(struct transport *transport,
 				    "refs/tags/");
 	}
 
+	strvec_push(&transport_ls_refs_options.ref_prefixes, "HEAD");
+
 	if (must_list_refs) {
 		trace2_region_enter("fetch", "remote_refs", the_repository);
 		remote_refs = transport_get_remote_refs(transport,
@@ -1791,6 +1867,12 @@ static int do_fetch(struct transport *transport,
 				  "you need to specify exactly one branch with the --set-upstream option"));
 		}
 	}
+	if (set_head(remote_refs))
+		;
+		/*
+		 * Way too many cases where this can go wrong
+		 * so let's just fail silently for now.
+		 */
 
 cleanup:
 	if (retcode) {
diff --git a/t/t4207-log-decoration-colors.sh b/t/t4207-log-decoration-colors.sh
index 73ea9e5155..d55d22cb2f 100755
--- a/t/t4207-log-decoration-colors.sh
+++ b/t/t4207-log-decoration-colors.sh
@@ -59,7 +59,8 @@ ${c_reset}${c_tag}tag: ${c_reset}${c_tag}v1.0${c_reset}${c_commit}, \
 ${c_reset}${c_tag}tag: ${c_reset}${c_tag}B${c_reset}${c_commit})${c_reset} B
 ${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}\
 ${c_tag}tag: ${c_reset}${c_tag}A1${c_reset}${c_commit}, \
-${c_reset}${c_remoteBranch}other/main${c_reset}${c_commit})${c_reset} A1
+${c_reset}${c_remoteBranch}other/main${c_reset}${c_commit}, \
+${c_reset}${c_remoteBranch}other/HEAD${c_reset}${c_commit})${c_reset} A1
 	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}\
 ${c_stash}refs/stash${c_reset}${c_commit})${c_reset} On main: Changes to A.t
 	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}\
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 0ea86d51a4..4990d00209 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -74,7 +74,7 @@ test_expect_success 'add another remote' '
 		cd test &&
 		git remote add -f second ../two &&
 		tokens_match "origin second" "$(git remote)" &&
-		check_tracking_branch second main side another &&
+		check_tracking_branch second main side another HEAD &&
 		git for-each-ref "--format=%(refname)" refs/remotes |
 		sed -e "/^refs\/remotes\/origin\//d" \
 		    -e "/^refs\/remotes\/second\//d" >actual &&
@@ -476,7 +476,7 @@ test_expect_success 'set-head --auto has no problem w/multiple HEADs' '
 		cd test &&
 		git fetch two "refs/heads/*:refs/remotes/two/*" &&
 		git remote set-head --auto two >output 2>&1 &&
-		echo "${SQ}two/HEAD${SQ} is now created and points to ${SQ}main${SQ}" >expect &&
+		echo "${SQ}two/HEAD${SQ} is unchanged and points to ${SQ}main${SQ}" >expect &&
 		test_cmp expect output
 	)
 '
@@ -764,8 +764,10 @@ test_expect_success 'reject --no-no-tags' '
 '
 
 cat >one/expect <<\EOF
+  apis/HEAD -> apis/main
   apis/main
   apis/side
+  drosophila/HEAD -> drosophila/main
   drosophila/another
   drosophila/main
   drosophila/side
@@ -783,11 +785,14 @@ test_expect_success 'update' '
 '
 
 cat >one/expect <<\EOF
+  drosophila/HEAD -> drosophila/main
   drosophila/another
   drosophila/main
   drosophila/side
+  manduca/HEAD -> manduca/main
   manduca/main
   manduca/side
+  megaloprepus/HEAD -> megaloprepus/main
   megaloprepus/main
   megaloprepus/side
 EOF
@@ -795,7 +800,7 @@ EOF
 test_expect_success 'update with arguments' '
 	(
 		cd one &&
-		for b in $(git branch -r)
+		for b in $(git branch -r | grep -v HEAD)
 		do
 		git branch -r -d $b || exit 1
 		done &&
@@ -827,10 +832,13 @@ test_expect_success 'update --prune' '
 '
 
 cat >one/expect <<-\EOF
+  apis/HEAD -> apis/main
   apis/main
   apis/side
+  manduca/HEAD -> manduca/main
   manduca/main
   manduca/side
+  megaloprepus/HEAD -> megaloprepus/main
   megaloprepus/main
   megaloprepus/side
 EOF
@@ -838,7 +846,7 @@ EOF
 test_expect_success 'update default' '
 	(
 		cd one &&
-		for b in $(git branch -r)
+		for b in $(git branch -r | grep -v HEAD)
 		do
 		git branch -r -d $b || exit 1
 		done &&
@@ -850,6 +858,7 @@ test_expect_success 'update default' '
 '
 
 cat >one/expect <<\EOF
+  drosophila/HEAD -> drosophila/main
   drosophila/another
   drosophila/main
   drosophila/side
@@ -858,7 +867,7 @@ EOF
 test_expect_success 'update default (overridden, with funny whitespace)' '
 	(
 		cd one &&
-		for b in $(git branch -r)
+		for b in $(git branch -r | grep -v HEAD)
 		do
 		git branch -r -d $b || exit 1
 		done &&
@@ -872,7 +881,7 @@ test_expect_success 'update default (overridden, with funny whitespace)' '
 test_expect_success 'update (with remotes.default defined)' '
 	(
 		cd one &&
-		for b in $(git branch -r)
+		for b in $(git branch -r | grep -v HEAD)
 		do
 		git branch -r -d $b || exit 1
 		done &&
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 0890b9f61c..dfc8d748ba 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -75,6 +75,30 @@ test_expect_success "fetch test for-merge" '
 	cut -f -2 .git/FETCH_HEAD >actual &&
 	test_cmp expected actual'
 
+test_expect_success "fetch test remote HEAD" '
+	cd "$D" &&
+	cd two &&
+	git fetch &&
+	git rev-parse --verify refs/remotes/origin/HEAD &&
+	git rev-parse --verify refs/remotes/origin/main &&
+	head=$(git rev-parse refs/remotes/origin/HEAD) &&
+	branch=$(git rev-parse refs/remotes/origin/main) &&
+	test "z$head" = "z$branch"'
+
+test_expect_success "fetch test remote HEAD change" '
+	cd "$D" &&
+	cd two &&
+	git switch -c other &&
+	git push -u origin other &&
+	git rev-parse --verify refs/remotes/origin/HEAD &&
+	git rev-parse --verify refs/remotes/origin/main &&
+	git rev-parse --verify refs/remotes/origin/other &&
+	git remote set-head origin other &&
+	git fetch &&
+	head=$(git rev-parse refs/remotes/origin/HEAD) &&
+	branch=$(git rev-parse refs/remotes/origin/other) &&
+	test "z$head" = "z$branch"'
+
 test_expect_success 'fetch --prune on its own works as expected' '
 	cd "$D" &&
 	git clone . prune &&
@@ -478,7 +502,6 @@ test_expect_success 'unbundle 1' '
 	test_must_fail git fetch "$D/bundle1" main:main
 '
 
-
 test_expect_success 'bundle 1 has only 3 files ' '
 	cd "$D" &&
 	test_bundle_object_count bundle1 3
@@ -819,7 +842,7 @@ test_expect_success 'fetch from multiple configured URLs in single remote' '
 
 # configured prune tests
 
-set_config_tristate () {
+set_config_tristate() {
 	# var=$1 val=$2
 	case "$2" in
 	unset)
@@ -833,12 +856,12 @@ set_config_tristate () {
 	esac
 }
 
-test_configured_prune () {
+test_configured_prune() {
 	test_configured_prune_type "$@" "name"
 	test_configured_prune_type "$@" "link"
 }
 
-test_configured_prune_type () {
+test_configured_prune_type() {
 	fetch_prune=$1
 	remote_origin_prune=$2
 	fetch_prune_tags=$3
@@ -848,8 +871,7 @@ test_configured_prune_type () {
 	cmdline=$7
 	mode=$8
 
-	if test -z "$cmdline_setup"
-	then
+	if test -z "$cmdline_setup"; then
 		test_expect_success 'setup cmdline_setup variable for subsequent test' '
 			remote_url="file://$(git -C one config remote.origin.url)" &&
 			remote_fetch="$(git -C one config remote.origin.fetch)" &&
@@ -857,12 +879,10 @@ test_configured_prune_type () {
 		'
 	fi
 
-	if test "$mode" = 'link'
-	then
+	if test "$mode" = 'link'; then
 		new_cmdline=""
 
-		if test "$cmdline" = ""
-		then
+		if test "$cmdline" = ""; then
 			new_cmdline=$cmdline_setup
 		else
 			new_cmdline=$(perl -e '
@@ -873,10 +893,8 @@ test_configured_prune_type () {
 		fi
 
 		if test "$fetch_prune_tags" = 'true' ||
-		   test "$remote_origin_prune_tags" = 'true'
-		then
-			if ! printf '%s' "$cmdline\n" | grep -q refs/remotes/origin/
-			then
+			test "$remote_origin_prune_tags" = 'true'; then
+			if ! printf '%s' "$cmdline\n" | grep -q refs/remotes/origin/; then
 				new_cmdline="$new_cmdline refs/tags/*:refs/tags/*"
 			fi
 		fi
@@ -946,100 +964,100 @@ test_configured_prune_type () {
 # $7 git-fetch $cmdline:
 #
 #                     $1    $2    $3    $4    $5     $6     $7
-test_configured_prune unset unset unset unset kept   kept   ""
-test_configured_prune unset unset unset unset kept   kept   "--no-prune"
-test_configured_prune unset unset unset unset pruned kept   "--prune"
-test_configured_prune unset unset unset unset kept   pruned \
+test_configured_prune unset unset unset unset kept kept ""
+test_configured_prune unset unset unset unset kept kept "--no-prune"
+test_configured_prune unset unset unset unset pruned kept "--prune"
+test_configured_prune unset unset unset unset kept pruned \
 	"--prune origin refs/tags/*:refs/tags/*"
 test_configured_prune unset unset unset unset pruned pruned \
 	"--prune origin refs/tags/*:refs/tags/* +refs/heads/*:refs/remotes/origin/*"
 
-test_configured_prune false unset unset unset kept   kept   ""
-test_configured_prune false unset unset unset kept   kept   "--no-prune"
-test_configured_prune false unset unset unset pruned kept   "--prune"
+test_configured_prune false unset unset unset kept kept ""
+test_configured_prune false unset unset unset kept kept "--no-prune"
+test_configured_prune false unset unset unset pruned kept "--prune"
 
-test_configured_prune true  unset unset unset pruned kept   ""
-test_configured_prune true  unset unset unset pruned kept   "--prune"
-test_configured_prune true  unset unset unset kept   kept   "--no-prune"
+test_configured_prune true unset unset unset pruned kept ""
+test_configured_prune true unset unset unset pruned kept "--prune"
+test_configured_prune true unset unset unset kept kept "--no-prune"
 
-test_configured_prune unset false unset unset kept   kept   ""
-test_configured_prune unset false unset unset kept   kept   "--no-prune"
-test_configured_prune unset false unset unset pruned kept   "--prune"
+test_configured_prune unset false unset unset kept kept ""
+test_configured_prune unset false unset unset kept kept "--no-prune"
+test_configured_prune unset false unset unset pruned kept "--prune"
 
-test_configured_prune false false unset unset kept   kept   ""
-test_configured_prune false false unset unset kept   kept   "--no-prune"
-test_configured_prune false false unset unset pruned kept   "--prune"
-test_configured_prune false false unset unset kept   pruned \
+test_configured_prune false false unset unset kept kept ""
+test_configured_prune false false unset unset kept kept "--no-prune"
+test_configured_prune false false unset unset pruned kept "--prune"
+test_configured_prune false false unset unset kept pruned \
 	"--prune origin refs/tags/*:refs/tags/*"
 test_configured_prune false false unset unset pruned pruned \
 	"--prune origin refs/tags/*:refs/tags/* +refs/heads/*:refs/remotes/origin/*"
 
-test_configured_prune true  false unset unset kept   kept   ""
-test_configured_prune true  false unset unset pruned kept   "--prune"
-test_configured_prune true  false unset unset kept   kept   "--no-prune"
+test_configured_prune true false unset unset kept kept ""
+test_configured_prune true false unset unset pruned kept "--prune"
+test_configured_prune true false unset unset kept kept "--no-prune"
 
-test_configured_prune unset true  unset unset pruned kept   ""
-test_configured_prune unset true  unset unset kept   kept   "--no-prune"
-test_configured_prune unset true  unset unset pruned kept   "--prune"
+test_configured_prune unset true unset unset pruned kept ""
+test_configured_prune unset true unset unset kept kept "--no-prune"
+test_configured_prune unset true unset unset pruned kept "--prune"
 
-test_configured_prune false true  unset unset pruned kept   ""
-test_configured_prune false true  unset unset kept   kept   "--no-prune"
-test_configured_prune false true  unset unset pruned kept   "--prune"
+test_configured_prune false true unset unset pruned kept ""
+test_configured_prune false true unset unset kept kept "--no-prune"
+test_configured_prune false true unset unset pruned kept "--prune"
 
-test_configured_prune true  true  unset unset pruned kept   ""
-test_configured_prune true  true  unset unset pruned kept   "--prune"
-test_configured_prune true  true  unset unset kept   kept   "--no-prune"
-test_configured_prune true  true  unset unset kept   pruned \
+test_configured_prune true true unset unset pruned kept ""
+test_configured_prune true true unset unset pruned kept "--prune"
+test_configured_prune true true unset unset kept kept "--no-prune"
+test_configured_prune true true unset unset kept pruned \
 	"--prune origin refs/tags/*:refs/tags/*"
-test_configured_prune true  true  unset unset pruned pruned \
+test_configured_prune true true unset unset pruned pruned \
 	"--prune origin refs/tags/*:refs/tags/* +refs/heads/*:refs/remotes/origin/*"
 
 # --prune-tags on its own does nothing, needs --prune as well, same
 # for fetch.pruneTags without fetch.prune
-test_configured_prune unset unset unset unset kept kept     "--prune-tags"
-test_configured_prune unset unset true unset  kept kept     ""
-test_configured_prune unset unset unset true  kept kept     ""
+test_configured_prune unset unset unset unset kept kept "--prune-tags"
+test_configured_prune unset unset true unset kept kept ""
+test_configured_prune unset unset unset true kept kept ""
 
 # These will prune the tags
 test_configured_prune unset unset unset unset pruned pruned "--prune --prune-tags"
-test_configured_prune true  unset true  unset pruned pruned ""
-test_configured_prune unset true  unset true  pruned pruned ""
+test_configured_prune true unset true unset pruned pruned ""
+test_configured_prune unset true unset true pruned pruned ""
 
 # remote.<name>.pruneTags overrides fetch.pruneTags, just like
 # remote.<name>.prune overrides fetch.prune if set.
-test_configured_prune true  unset true unset pruned pruned  ""
-test_configured_prune false true  false true  pruned pruned ""
-test_configured_prune true  false true  false kept   kept   ""
+test_configured_prune true unset true unset pruned pruned ""
+test_configured_prune false true false true pruned pruned ""
+test_configured_prune true false true false kept kept ""
 
 # When --prune-tags is supplied it's ignored if an explicit refspec is
 # given, same for the configuration options.
 test_configured_prune unset unset unset unset pruned kept \
 	"--prune --prune-tags origin +refs/heads/*:refs/remotes/origin/*"
-test_configured_prune unset unset true  unset pruned kept \
+test_configured_prune unset unset true unset pruned kept \
 	"--prune origin +refs/heads/*:refs/remotes/origin/*"
-test_configured_prune unset unset unset true pruned  kept \
+test_configured_prune unset unset unset true pruned kept \
 	"--prune origin +refs/heads/*:refs/remotes/origin/*"
 
 # Pruning that also takes place if a file:// url replaces a named
 # remote. However, because there's no implicit
 # +refs/heads/*:refs/remotes/origin/* refspec and supplying it on the
 # command-line negates --prune-tags, the branches will not be pruned.
-test_configured_prune_type unset unset unset unset kept   kept   "origin --prune-tags" "name"
-test_configured_prune_type unset unset unset unset kept   kept   "origin --prune-tags" "link"
+test_configured_prune_type unset unset unset unset kept kept "origin --prune-tags" "name"
+test_configured_prune_type unset unset unset unset kept kept "origin --prune-tags" "link"
 test_configured_prune_type unset unset unset unset pruned pruned "origin --prune --prune-tags" "name"
-test_configured_prune_type unset unset unset unset kept   pruned "origin --prune --prune-tags" "link"
+test_configured_prune_type unset unset unset unset kept pruned "origin --prune --prune-tags" "link"
 test_configured_prune_type unset unset unset unset pruned pruned "--prune --prune-tags origin" "name"
-test_configured_prune_type unset unset unset unset kept   pruned "--prune --prune-tags origin" "link"
-test_configured_prune_type unset unset true  unset pruned pruned "--prune origin" "name"
-test_configured_prune_type unset unset true  unset kept   pruned "--prune origin" "link"
-test_configured_prune_type unset unset unset true  pruned pruned "--prune origin" "name"
-test_configured_prune_type unset unset unset true  kept   pruned "--prune origin" "link"
-test_configured_prune_type true  unset true  unset pruned pruned "origin" "name"
-test_configured_prune_type true  unset true  unset kept   pruned "origin" "link"
-test_configured_prune_type unset  true true  unset pruned pruned "origin" "name"
-test_configured_prune_type unset  true true  unset kept   pruned "origin" "link"
-test_configured_prune_type unset  true unset true  pruned pruned "origin" "name"
-test_configured_prune_type unset  true unset true  kept   pruned "origin" "link"
+test_configured_prune_type unset unset unset unset kept pruned "--prune --prune-tags origin" "link"
+test_configured_prune_type unset unset true unset pruned pruned "--prune origin" "name"
+test_configured_prune_type unset unset true unset kept pruned "--prune origin" "link"
+test_configured_prune_type unset unset unset true pruned pruned "--prune origin" "name"
+test_configured_prune_type unset unset unset true kept pruned "--prune origin" "link"
+test_configured_prune_type true unset true unset pruned pruned "origin" "name"
+test_configured_prune_type true unset true unset kept pruned "origin" "link"
+test_configured_prune_type unset true true unset pruned pruned "origin" "name"
+test_configured_prune_type unset true true unset kept pruned "origin" "link"
+test_configured_prune_type unset true unset true pruned pruned "origin" "name"
+test_configured_prune_type unset true unset true kept pruned "origin" "link"
 
 # When all remote.origin.fetch settings are deleted a --prune
 # --prune-tags still implicitly supplies refs/tags/*:refs/tags/* so
@@ -1137,8 +1155,7 @@ test_expect_success 'fetching with auto-gc does not lock up' '
 	)
 '
 
-for section in fetch transfer
-do
+for section in fetch transfer; do
 	test_expect_success "$section.hideRefs affects connectivity check" '
 		GIT_TRACE="$PWD"/trace git -c $section.hideRefs=refs -c \
 			$section.hideRefs="!refs/tags/" fetch &&
@@ -1157,21 +1174,23 @@ test_expect_success 'prepare source branch' '
 	test 3 -le $(wc -l <actual)
 '
 
-validate_store_type () {
+validate_store_type() {
 	git -C dest count-objects -v >actual &&
-	case "$store_type" in
-	packed)
-		grep "^count: 0$" actual ;;
-	loose)
-		grep "^packs: 0$" actual ;;
-	esac || {
+		case "$store_type" in
+		packed)
+			grep "^count: 0$" actual
+			;;
+		loose)
+			grep "^packs: 0$" actual
+			;;
+		esac || {
 		echo "store_type is $store_type"
 		cat actual
 		false
 	}
 }
 
-test_unpack_limit () {
+test_unpack_limit() {
 	store_type=$1
 
 	case "$store_type" in
@@ -1192,43 +1211,39 @@ test_unpack_limit () {
 test_unpack_limit packed
 test_unpack_limit loose
 
-setup_negotiation_tip () {
+setup_negotiation_tip() {
 	SERVER="$1"
 	URL="$2"
 	USE_PROTOCOL_V2="$3"
 
 	rm -rf "$SERVER" client trace &&
-	git init -b main "$SERVER" &&
-	test_commit -C "$SERVER" alpha_1 &&
-	test_commit -C "$SERVER" alpha_2 &&
-	git -C "$SERVER" checkout --orphan beta &&
-	test_commit -C "$SERVER" beta_1 &&
-	test_commit -C "$SERVER" beta_2 &&
-
-	git clone "$URL" client &&
-
-	if test "$USE_PROTOCOL_V2" -eq 1
-	then
-		git -C "$SERVER" config protocol.version 2 &&
-		git -C client config protocol.version 2
-	fi &&
-
-	test_commit -C "$SERVER" beta_s &&
-	git -C "$SERVER" checkout main &&
-	test_commit -C "$SERVER" alpha_s &&
-	git -C "$SERVER" tag -d alpha_1 alpha_2 beta_1 beta_2
+		git init -b main "$SERVER" &&
+		test_commit -C "$SERVER" alpha_1 &&
+		test_commit -C "$SERVER" alpha_2 &&
+		git -C "$SERVER" checkout --orphan beta &&
+		test_commit -C "$SERVER" beta_1 &&
+		test_commit -C "$SERVER" beta_2 &&
+		git clone "$URL" client &&
+		if test "$USE_PROTOCOL_V2" -eq 1; then
+			git -C "$SERVER" config protocol.version 2 &&
+				git -C client config protocol.version 2
+		fi &&
+		test_commit -C "$SERVER" beta_s &&
+		git -C "$SERVER" checkout main &&
+		test_commit -C "$SERVER" alpha_s &&
+		git -C "$SERVER" tag -d alpha_1 alpha_2 beta_1 beta_2
 }
 
-check_negotiation_tip () {
+check_negotiation_tip() {
 	# Ensure that {alpha,beta}_1 are sent as "have", but not {alpha_beta}_2
 	ALPHA_1=$(git -C client rev-parse alpha_1) &&
-	grep "fetch> have $ALPHA_1" trace &&
-	BETA_1=$(git -C client rev-parse beta_1) &&
-	grep "fetch> have $BETA_1" trace &&
-	ALPHA_2=$(git -C client rev-parse alpha_2) &&
-	! grep "fetch> have $ALPHA_2" trace &&
-	BETA_2=$(git -C client rev-parse beta_2) &&
-	! grep "fetch> have $BETA_2" trace
+		grep "fetch> have $ALPHA_1" trace &&
+		BETA_1=$(git -C client rev-parse beta_1) &&
+		grep "fetch> have $BETA_1" trace &&
+		ALPHA_2=$(git -C client rev-parse alpha_2) &&
+		! grep "fetch> have $ALPHA_2" trace &&
+		BETA_2=$(git -C client rev-parse beta_2) &&
+		! grep "fetch> have $BETA_2" trace
 }
 
 test_expect_success '--negotiation-tip limits "have" lines sent' '
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 64b3491e4e..1b3865e154 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -293,6 +293,8 @@ test_expect_success 'ls-remote with filtered symref (refname)' '
 	cat >expect <<-EOF &&
 	ref: refs/heads/main	HEAD
 	$rev	HEAD
+	ref: refs/remotes/origin/main	refs/remotes/origin/HEAD
+	$rev	refs/remotes/origin/HEAD
 	EOF
 	git ls-remote --symref . HEAD >actual &&
 	test_cmp expect actual
diff --git a/t/t5514-fetch-multiple.sh b/t/t5514-fetch-multiple.sh
index 579872c258..e3482b27b2 100755
--- a/t/t5514-fetch-multiple.sh
+++ b/t/t5514-fetch-multiple.sh
@@ -45,14 +45,17 @@ test_expect_success setup '
 '
 
 cat > test/expect << EOF
+  one/HEAD -> one/main
   one/main
   one/side
   origin/HEAD -> origin/main
   origin/main
   origin/side
+  three/HEAD -> three/main
   three/another
   three/main
   three/side
+  two/HEAD -> two/main
   two/another
   two/main
   two/side
@@ -97,6 +100,7 @@ cat > expect << EOF
   origin/HEAD -> origin/main
   origin/main
   origin/side
+  three/HEAD -> three/main
   three/another
   three/main
   three/side
@@ -112,8 +116,10 @@ test_expect_success 'git fetch --multiple (but only one remote)' '
 '
 
 cat > expect << EOF
+  one/HEAD -> one/main
   one/main
   one/side
+  two/HEAD -> two/main
   two/another
   two/main
   two/side
@@ -141,7 +147,7 @@ test_expect_success 'git fetch --multiple (bad remote names)' '
 
 test_expect_success 'git fetch --all (skipFetchAll)' '
 	(cd test4 &&
-	 for b in $(git branch -r)
+	 for b in $(git branch -r | grep -v HEAD)
 	 do
 		git branch -r -d $b || exit 1
 	 done &&
@@ -153,11 +159,14 @@ test_expect_success 'git fetch --all (skipFetchAll)' '
 '
 
 cat > expect << EOF
+  one/HEAD -> one/main
   one/main
   one/side
+  three/HEAD -> three/main
   three/another
   three/main
   three/side
+  two/HEAD -> two/main
   two/another
   two/main
   two/side
@@ -165,7 +174,7 @@ EOF
 
 test_expect_success 'git fetch --multiple (ignoring skipFetchAll)' '
 	(cd test4 &&
-	 for b in $(git branch -r)
+	 for b in $(git branch -r | grep -v HEAD)
 	 do
 		git branch -r -d $b || exit 1
 	 done &&
@@ -221,14 +230,17 @@ test_expect_success 'git fetch --multiple --jobs=0 picks a default' '
 
 create_fetch_all_expect () {
 	cat >expect <<-\EOF
+	  one/HEAD -> one/main
 	  one/main
 	  one/side
 	  origin/HEAD -> origin/main
 	  origin/main
 	  origin/side
+	  three/HEAD -> three/main
 	  three/another
 	  three/main
 	  three/side
+	  two/HEAD -> two/main
 	  two/another
 	  two/main
 	  two/side
@@ -265,6 +277,7 @@ test_expect_success 'git fetch (fetch all remotes with fetch.all = true)' '
 
 create_fetch_one_expect () {
 	cat >expect <<-\EOF
+	  one/HEAD -> one/main
 	  one/main
 	  one/side
 	  origin/HEAD -> origin/main
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 331778bd42..5a051aa0c7 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1395,7 +1395,8 @@ test_expect_success 'fetch follows tags by default' '
 		git tag -m "annotated" tag &&
 		git for-each-ref >tmp1 &&
 		sed -n "p; s|refs/heads/main$|refs/remotes/origin/main|p" tmp1 |
-		sort -k 3 >../expect
+		sed -n "p; s|refs/heads/main$|refs/remotes/origin/HEAD|p"  |
+		sort -k 4 >../expect
 	) &&
 	test_when_finished "rm -rf dst" &&
 	git init dst &&
diff --git a/t/t5527-fetch-odd-refs.sh b/t/t5527-fetch-odd-refs.sh
index 98ece27c6a..d3996af6ee 100755
--- a/t/t5527-fetch-odd-refs.sh
+++ b/t/t5527-fetch-odd-refs.sh
@@ -52,7 +52,8 @@ test_expect_success LONG_REF 'fetch handles extremely long refname' '
 	long
 	main
 	EOF
-	git for-each-ref --format="%(subject)" refs/remotes/long >actual &&
+	git for-each-ref --format="%(subject)" refs/remotes/long \
+		--exclude=refs/remotes/long/HEAD >actual &&
 	test_cmp expect actual
 '
 
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index a66d0e089d..88331d1ceb 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -329,7 +329,8 @@ test_expect_success 'incremental-repack task' '
 
 	# Delete refs that have not been repacked in these packs.
 	git for-each-ref --format="delete %(refname)" \
-		refs/prefetch refs/tags refs/remotes >refs &&
+		refs/prefetch refs/tags refs/remotes \
+		--exclude=refs/remotes/*/HEAD >refs &&
 	git update-ref --stdin <refs &&
 
 	# Replace the object directory with this pack layout.
diff --git a/t/t9210-scalar.sh b/t/t9210-scalar.sh
index a30b2c9f70..2237844550 100755
--- a/t/t9210-scalar.sh
+++ b/t/t9210-scalar.sh
@@ -151,7 +151,8 @@ test_expect_success 'scalar clone' '
 			"$(pwd)" &&
 
 		git for-each-ref --format="%(refname)" refs/remotes/origin/ >actual &&
-		echo "refs/remotes/origin/parallel" >expect &&
+		echo "refs/remotes/origin/HEAD" >>expect &&
+		echo "refs/remotes/origin/parallel" >>expect &&
 		test_cmp expect actual &&
 
 		test_path_is_missing 1/2 &&
@@ -220,7 +221,7 @@ test_expect_success 'scalar reconfigure --all with includeIf.onbranch' '
 	done
 '
 
- test_expect_success 'scalar reconfigure --all with detached HEADs' '
+test_expect_success 'scalar reconfigure --all with detached HEADs' '
 	repos="two three four" &&
 	for num in $repos
 	do
diff --git a/t/t9211-scalar-clone.sh b/t/t9211-scalar-clone.sh
index c16ea67c1d..d9cb6b9a3e 100755
--- a/t/t9211-scalar-clone.sh
+++ b/t/t9211-scalar-clone.sh
@@ -32,7 +32,7 @@ test_expect_success 'set up repository to clone' '
 	)
 '
 
-cleanup_clone () {
+cleanup_clone() {
 	rm -rf "$1"
 }
 
@@ -128,7 +128,7 @@ test_expect_success '--single-branch clones HEAD only' '
 	(
 		cd $enlistment/src &&
 		git for-each-ref refs/remotes/origin >out &&
-		test_line_count = 1 out &&
+		test_line_count = 2 out &&
 		grep "refs/remotes/origin/base" out
 	) &&
 
@@ -142,7 +142,7 @@ test_expect_success '--no-single-branch clones all branches' '
 	(
 		cd $enlistment/src &&
 		git for-each-ref refs/remotes/origin >out &&
-		test_line_count = 2 out &&
+		test_line_count = 3 out &&
 		grep "refs/remotes/origin/base" out &&
 		grep "refs/remotes/origin/parallel" out
 	) &&
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index cc6aa9f0cd..b663c4609e 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -658,6 +658,7 @@ test_expect_success '__git_refs - simple' '
 	HEAD
 	main
 	matching-branch
+	other/HEAD
 	other/branch-in-other
 	other/main-in-other
 	matching-tag
@@ -673,6 +674,7 @@ test_expect_success '__git_refs - full refs' '
 	cat >expected <<-EOF &&
 	refs/heads/main
 	refs/heads/matching-branch
+	refs/remotes/other/HEAD
 	refs/remotes/other/branch-in-other
 	refs/remotes/other/main-in-other
 	refs/tags/matching-tag
@@ -729,6 +731,7 @@ test_expect_success '__git_refs - remote on local file system - full refs' '
 test_expect_success '__git_refs - configured remote' '
 	cat >expected <<-EOF &&
 	HEAD
+	HEAD
 	branch-in-other
 	main-in-other
 	EOF
@@ -756,6 +759,7 @@ test_expect_success '__git_refs - configured remote - full refs' '
 test_expect_success '__git_refs - configured remote - repo given on the command line' '
 	cat >expected <<-EOF &&
 	HEAD
+	HEAD
 	branch-in-other
 	main-in-other
 	EOF
@@ -787,6 +791,7 @@ test_expect_success '__git_refs - configured remote - full refs - repo given on
 test_expect_success '__git_refs - configured remote - remote name matches a directory' '
 	cat >expected <<-EOF &&
 	HEAD
+	HEAD
 	branch-in-other
 	main-in-other
 	EOF
@@ -875,12 +880,14 @@ test_expect_success '__git_refs - unique remote branches for git checkout DWIMer
 	HEAD
 	main
 	matching-branch
+	other/HEAD
 	other/ambiguous
 	other/branch-in-other
 	other/main-in-other
 	remote/ambiguous
 	remote/branch-in-remote
 	matching-tag
+	HEAD
 	branch-in-other
 	branch-in-remote
 	main-in-other
@@ -904,6 +911,7 @@ test_expect_success '__git_refs - after --opt=' '
 	HEAD
 	main
 	matching-branch
+	other/HEAD
 	other/branch-in-other
 	other/main-in-other
 	matching-tag
@@ -919,6 +927,7 @@ test_expect_success '__git_refs - after --opt= - full refs' '
 	cat >expected <<-EOF &&
 	refs/heads/main
 	refs/heads/matching-branch
+	refs/remotes/other/HEAD
 	refs/remotes/other/branch-in-other
 	refs/remotes/other/main-in-other
 	refs/tags/matching-tag
@@ -935,6 +944,7 @@ test_expect_success '__git refs - excluding refs' '
 	^HEAD
 	^main
 	^matching-branch
+	^other/HEAD
 	^other/branch-in-other
 	^other/main-in-other
 	^matching-tag
@@ -950,6 +960,7 @@ test_expect_success '__git refs - excluding full refs' '
 	cat >expected <<-EOF &&
 	^refs/heads/main
 	^refs/heads/matching-branch
+	^refs/remotes/other/HEAD
 	^refs/remotes/other/branch-in-other
 	^refs/remotes/other/main-in-other
 	^refs/tags/matching-tag
@@ -975,6 +986,7 @@ test_expect_success '__git_refs - do not filter refs unless told so' '
 	main
 	matching-branch
 	matching/branch
+	other/HEAD
 	other/branch-in-other
 	other/main-in-other
 	other/matching/branch-in-other
@@ -1095,6 +1107,7 @@ test_expect_success '__git_complete_refs - simple' '
 	HEAD Z
 	main Z
 	matching-branch Z
+	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
 	matching-tag Z
@@ -1123,6 +1136,7 @@ test_expect_success '__git_complete_refs - matching' '
 test_expect_success '__git_complete_refs - remote' '
 	sed -e "s/Z$//" >expected <<-EOF &&
 	HEAD Z
+	HEAD Z
 	branch-in-other Z
 	main-in-other Z
 	EOF
@@ -1139,9 +1153,11 @@ test_expect_success '__git_complete_refs - track' '
 	HEAD Z
 	main Z
 	matching-branch Z
+	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
 	matching-tag Z
+	HEAD Z
 	branch-in-other Z
 	main-in-other Z
 	EOF
@@ -1184,6 +1200,7 @@ test_expect_success '__git_complete_refs - suffix' '
 	HEAD.
 	main.
 	matching-branch.
+	other/HEAD.
 	other/branch-in-other.
 	other/main-in-other.
 	matching-tag.
@@ -1199,6 +1216,7 @@ test_expect_success '__git_complete_refs - suffix' '
 test_expect_success '__git_complete_fetch_refspecs - simple' '
 	sed -e "s/Z$//" >expected <<-EOF &&
 	HEAD:HEAD Z
+	HEAD:HEAD Z
 	branch-in-other:branch-in-other Z
 	main-in-other:main-in-other Z
 	EOF
@@ -1225,6 +1243,7 @@ test_expect_success '__git_complete_fetch_refspecs - matching' '
 test_expect_success '__git_complete_fetch_refspecs - prefix' '
 	sed -e "s/Z$//" >expected <<-EOF &&
 	+HEAD:HEAD Z
+	+HEAD:HEAD Z
 	+branch-in-other:branch-in-other Z
 	+main-in-other:main-in-other Z
 	EOF
@@ -1289,6 +1308,7 @@ test_expect_success '__git_complete_worktree_paths with -C' '
 
 test_expect_success 'git switch - with no options, complete local branches and unique remote branch names for DWIM logic' '
 	test_completion "git switch " <<-\EOF
+	HEAD Z
 	branch-in-other Z
 	main Z
 	main-in-other Z
@@ -1435,11 +1455,13 @@ test_expect_success 'git-bisect - existing view subcommand is recognized and ena
 test_expect_success 'git checkout - completes refs and unique remote branches for DWIM' '
 	test_completion "git checkout " <<-\EOF
 	HEAD Z
+	HEAD Z
 	branch-in-other Z
 	main Z
 	main-in-other Z
 	matching-branch Z
 	matching-tag Z
+	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
 	EOF
@@ -1461,6 +1483,7 @@ test_expect_success 'git switch - with GIT_COMPLETION_CHECKOUT_NO_GUESS=1, compl
 
 test_expect_success 'git switch - --guess overrides GIT_COMPLETION_CHECKOUT_NO_GUESS=1, complete local branches and unique remote names for DWIM logic' '
 	GIT_COMPLETION_CHECKOUT_NO_GUESS=1 test_completion "git switch --guess " <<-\EOF
+	HEAD Z
 	branch-in-other Z
 	main Z
 	main-in-other Z
@@ -1470,6 +1493,7 @@ test_expect_success 'git switch - --guess overrides GIT_COMPLETION_CHECKOUT_NO_G
 
 test_expect_success 'git switch - a later --guess overrides previous --no-guess, complete local and remote unique branches for DWIM' '
 	test_completion "git switch --no-guess --guess " <<-\EOF
+	HEAD Z
 	branch-in-other Z
 	main Z
 	main-in-other Z
@@ -1490,6 +1514,7 @@ test_expect_success 'git checkout - with GIT_COMPLETION_NO_GUESS=1 only complete
 	main Z
 	matching-branch Z
 	matching-tag Z
+	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
 	EOF
@@ -1498,11 +1523,13 @@ test_expect_success 'git checkout - with GIT_COMPLETION_NO_GUESS=1 only complete
 test_expect_success 'git checkout - --guess overrides GIT_COMPLETION_NO_GUESS=1, complete refs and unique remote branches for DWIM' '
 	GIT_COMPLETION_CHECKOUT_NO_GUESS=1 test_completion "git checkout --guess " <<-\EOF
 	HEAD Z
+	HEAD Z
 	branch-in-other Z
 	main Z
 	main-in-other Z
 	matching-branch Z
 	matching-tag Z
+	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
 	EOF
@@ -1514,6 +1541,7 @@ test_expect_success 'git checkout - with --no-guess, only completes refs' '
 	main Z
 	matching-branch Z
 	matching-tag Z
+	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
 	EOF
@@ -1522,11 +1550,13 @@ test_expect_success 'git checkout - with --no-guess, only completes refs' '
 test_expect_success 'git checkout - a later --guess overrides previous --no-guess, complete refs and unique remote branches for DWIM' '
 	test_completion "git checkout --no-guess --guess " <<-\EOF
 	HEAD Z
+	HEAD Z
 	branch-in-other Z
 	main Z
 	main-in-other Z
 	matching-branch Z
 	matching-tag Z
+	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
 	EOF
@@ -1538,6 +1568,7 @@ test_expect_success 'git checkout - a later --no-guess overrides previous --gues
 	main Z
 	matching-branch Z
 	matching-tag Z
+	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
 	EOF
@@ -1550,6 +1581,7 @@ test_expect_success 'git checkout - with checkout.guess = false, only completes
 	main Z
 	matching-branch Z
 	matching-tag Z
+	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
 	EOF
@@ -1559,11 +1591,13 @@ test_expect_success 'git checkout - with checkout.guess = true, completes refs a
 	test_config checkout.guess true &&
 	test_completion "git checkout " <<-\EOF
 	HEAD Z
+	HEAD Z
 	branch-in-other Z
 	main Z
 	main-in-other Z
 	matching-branch Z
 	matching-tag Z
+	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
 	EOF
@@ -1573,11 +1607,13 @@ test_expect_success 'git checkout - a later --guess overrides previous checkout.
 	test_config checkout.guess false &&
 	test_completion "git checkout --guess " <<-\EOF
 	HEAD Z
+	HEAD Z
 	branch-in-other Z
 	main Z
 	main-in-other Z
 	matching-branch Z
 	matching-tag Z
+	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
 	EOF
@@ -1590,6 +1626,7 @@ test_expect_success 'git checkout - a later --no-guess overrides previous checko
 	main Z
 	matching-branch Z
 	matching-tag Z
+	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
 	EOF
@@ -1601,6 +1638,7 @@ test_expect_success 'git switch - with --detach, complete all references' '
 	main Z
 	matching-branch Z
 	matching-tag Z
+	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
 	EOF
@@ -1612,6 +1650,7 @@ test_expect_success 'git checkout - with --detach, complete only references' '
 	main Z
 	matching-branch Z
 	matching-tag Z
+	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
 	EOF
@@ -1783,6 +1822,7 @@ test_expect_success 'git switch - with -d, complete all references' '
 	main Z
 	matching-branch Z
 	matching-tag Z
+	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
 	EOF
@@ -1794,6 +1834,7 @@ test_expect_success 'git checkout - with -d, complete only references' '
 	main Z
 	matching-branch Z
 	matching-tag Z
+	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
 	EOF
@@ -1801,10 +1842,12 @@ test_expect_success 'git checkout - with -d, complete only references' '
 
 test_expect_success 'git switch - with --track, complete only remote branches' '
 	test_completion "git switch --track " <<-\EOF &&
+	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
 	EOF
 	test_completion "git switch -t " <<-\EOF
+	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
 	EOF
@@ -1812,10 +1855,12 @@ test_expect_success 'git switch - with --track, complete only remote branches' '
 
 test_expect_success 'git checkout - with --track, complete only remote branches' '
 	test_completion "git checkout --track " <<-\EOF &&
+	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
 	EOF
 	test_completion "git checkout -t " <<-\EOF
+	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
 	EOF
@@ -1834,6 +1879,7 @@ test_expect_success 'git checkout - with --no-track, complete only local referen
 	main Z
 	matching-branch Z
 	matching-tag Z
+	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
 	EOF
@@ -1845,6 +1891,7 @@ test_expect_success 'git switch - with -c, complete all references' '
 	main Z
 	matching-branch Z
 	matching-tag Z
+	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
 	EOF
@@ -1856,6 +1903,7 @@ test_expect_success 'git switch - with -C, complete all references' '
 	main Z
 	matching-branch Z
 	matching-tag Z
+	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
 	EOF
@@ -1867,6 +1915,7 @@ test_expect_success 'git switch - with -c and --track, complete all references'
 	main Z
 	matching-branch Z
 	matching-tag Z
+	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
 	EOF
@@ -1878,6 +1927,7 @@ test_expect_success 'git switch - with -C and --track, complete all references'
 	main Z
 	matching-branch Z
 	matching-tag Z
+	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
 	EOF
@@ -1889,6 +1939,7 @@ test_expect_success 'git switch - with -c and --no-track, complete all reference
 	main Z
 	matching-branch Z
 	matching-tag Z
+	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
 	EOF
@@ -1900,6 +1951,7 @@ test_expect_success 'git switch - with -C and --no-track, complete all reference
 	main Z
 	matching-branch Z
 	matching-tag Z
+	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
 	EOF
@@ -1911,6 +1963,7 @@ test_expect_success 'git checkout - with -b, complete all references' '
 	main Z
 	matching-branch Z
 	matching-tag Z
+	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
 	EOF
@@ -1922,6 +1975,7 @@ test_expect_success 'git checkout - with -B, complete all references' '
 	main Z
 	matching-branch Z
 	matching-tag Z
+	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
 	EOF
@@ -1933,6 +1987,7 @@ test_expect_success 'git checkout - with -b and --track, complete all references
 	main Z
 	matching-branch Z
 	matching-tag Z
+	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
 	EOF
@@ -1944,6 +1999,7 @@ test_expect_success 'git checkout - with -B and --track, complete all references
 	main Z
 	matching-branch Z
 	matching-tag Z
+	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
 	EOF
@@ -1955,6 +2011,7 @@ test_expect_success 'git checkout - with -b and --no-track, complete all referen
 	main Z
 	matching-branch Z
 	matching-tag Z
+	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
 	EOF
@@ -1966,6 +2023,7 @@ test_expect_success 'git checkout - with -B and --no-track, complete all referen
 	main Z
 	matching-branch Z
 	matching-tag Z
+	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
 	EOF
@@ -1973,6 +2031,7 @@ test_expect_success 'git checkout - with -B and --no-track, complete all referen
 
 test_expect_success 'git switch - for -c, complete local branches and unique remote branches' '
 	test_completion "git switch -c " <<-\EOF
+	HEAD Z
 	branch-in-other Z
 	main Z
 	main-in-other Z
@@ -1982,6 +2041,7 @@ test_expect_success 'git switch - for -c, complete local branches and unique rem
 
 test_expect_success 'git switch - for -C, complete local branches and unique remote branches' '
 	test_completion "git switch -C " <<-\EOF
+	HEAD Z
 	branch-in-other Z
 	main Z
 	main-in-other Z
@@ -2019,6 +2079,7 @@ test_expect_success 'git switch - for -C with --no-track, complete local branche
 
 test_expect_success 'git checkout - for -b, complete local branches and unique remote branches' '
 	test_completion "git checkout -b " <<-\EOF
+	HEAD Z
 	branch-in-other Z
 	main Z
 	main-in-other Z
@@ -2028,6 +2089,7 @@ test_expect_success 'git checkout - for -b, complete local branches and unique r
 
 test_expect_success 'git checkout - for -B, complete local branches and unique remote branches' '
 	test_completion "git checkout -B " <<-\EOF
+	HEAD Z
 	branch-in-other Z
 	main Z
 	main-in-other Z
@@ -2065,6 +2127,7 @@ test_expect_success 'git checkout - for -B with --no-track, complete local branc
 
 test_expect_success 'git switch - with --orphan completes local branch names and unique remote branch names' '
 	test_completion "git switch --orphan " <<-\EOF
+	HEAD Z
 	branch-in-other Z
 	main Z
 	main-in-other Z
@@ -2080,6 +2143,7 @@ test_expect_success 'git switch - --orphan with branch already provided complete
 
 test_expect_success 'git checkout - with --orphan completes local branch names and unique remote branch names' '
 	test_completion "git checkout --orphan " <<-\EOF
+	HEAD Z
 	branch-in-other Z
 	main Z
 	main-in-other Z
@@ -2093,6 +2157,7 @@ test_expect_success 'git checkout - --orphan with branch already provided comple
 	main Z
 	matching-branch Z
 	matching-tag Z
+	other/HEAD Z
 	other/branch-in-other Z
 	other/main-in-other Z
 	EOF
-- 
2.47.0.94.g8861098b6d


