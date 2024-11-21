Received: from aib29agh125.zrh1.oracleemaildelivery.com (aib29agh125.zrh1.oracleemaildelivery.com [192.29.178.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1371DE2AE
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 23:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732230706; cv=none; b=OZ1IlDWdwalKy2vbTnirPYj+ItfWXXf0TmEZW9/L8+xIjOTsK/oaY/ZbvryU1EXcKJt3QmFsv8D6d3DoQpowxoqAnEs6L38byC63k3v7FY5qQiNhCsIHiZ+aYXmtTPrmUl+UX6YO+7+uW5cEvxf5VPHS2b9ubLZM7JWcmlqFSLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732230706; c=relaxed/simple;
	bh=87BF776qhHE6uomvGQz+myh0U/RqfJJt33naXoypY8s=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=da4KcXTeciyrJ5RuJZsuXbTVho/AMfziz9XFsSa8z20YHCw91tBwJKysug1Lmjfj6jEWogAPUe5uQ9SoYO/1UW5aIvjKuLLUUCfzGaXTxriKLXwqO2PrGktvElKyZw8ahjVGI5xjXb0dNskzvzp2zpoKwFtXhlZUflsoiCS1R0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=jTy3Vg7A; arc=none smtp.client-ip=192.29.178.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="jTy3Vg7A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=f8oMCU/J3Hqzlk0qjGxckVq3T8ry0OR2rVNDOl+m+04=;
 b=jTy3Vg7AqjojSutDxU8IPwSLkz73+29c+bLiN5NPXjMal/CbIcyxQtbs+rY4ET/ZkdfSd0KjYfqy
   SJxiopY0dEd64fvUiPVaayO+Pjv2RgWErkIi5pwtZgac83SuanVIs+uXLukjt1RW1GkKPodqpEOJ
   KglOo/MBciDg/kzGon00nq+qs+xpXbitdiBCAQvtOq2d7D0PItYogtSDhyO87vvO644cYwSrdqsv
   E2+yKL163S8E4TH4pnuVCwgyFTODSrvCb93wXPuuZQZB5XA5pkNH+4jojANmAfowqyL93lBrG7rB
   bEMWv9SC/kAmtLuuqVO0wlFbVw0r0E1v0uTMdw==
Received: by omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241024 64bit (built Oct 24
 2024))
 with ESMTPS id <0SNB00JEXPRIK0A0@omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Thu, 21 Nov 2024 23:11:42 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,	karthik.188@gmail.com,
	Taylor Blau <me@ttaylorr.com>,	Patrick Steinhardt <ps@pks.im>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v14 09/10] fetch: set remote/HEAD if it does not exist
Date: Thu, 21 Nov 2024 23:55:09 +0100
Message-id: <20241121225757.3877852-10-bence@ferdinandy.com>
In-reply-to: <20241121225757.3877852-1-bence@ferdinandy.com>
References: <20241118151755.756265-1-bence@ferdinandy.com>
 <20241121225757.3877852-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAHd84Hzpuqkwcc35CxQIH07TVs1gyHKWGJbWSYW9PUVbdWjPAD9MsAm+uD4T00S
 KKfP9LBszRWf7ki3EBIhvM6foe85HPzO9kvCxEs6cw0Re8/g5ChBoDLax5m/2zCa
 XmgD8MM2y2B3+oJMsHI2cSnzdXUAetCTKJh+ZfnN0RnkW8KFi6mY0adMQCvD6Rb/
 046qmB7K1LSvrfd6Jar3xBSMV1ytIAbBAcFGAnNB4JPFrf/7pVHgDL4DUTJ0am3w
 gOfxAoBZ8RXOmA1Mcj5xBjbxLKysFBYBQ7E1vP7hYfgMEkQ+mqamPE7DwDczqncG
 iRTdFm6/ErXy3bpWMAXrUg9RtM9mv9TeM/8ivyS3G3dWmRbjtF0JCdanCGPShV8O
 24AClDgeuXHqLWkeqBbTnJCpU5ug4JWJkC2axj8XxYY7n8VXazl5eCuqEo9fpSsJ
 DVjaCgHSK3RYXcAOsdR7PeAdy6pmYkpw5FlxJHpKR96LkYVlLFbkKQg=

When cloning a repository remote/HEAD is created, but when the user
creates a repository with git init, and later adds a remote, remote/HEAD
is only created if the user explicitly runs a variant of "remote
set-head". Attempt to set remote/HEAD during fetch, if the user does not
have it already set. Silently ignore any errors.

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
    
    v11: fixed some memory leaks
    
    v12: no change
    
    v13: - fix printed information if the local HEAD is detached
         - remove accidental formatting noise in a test
    
    v14: remove report_set_head_auto: as discussed, any noise should only be
    created with an opt out, and the configuration for this will be added in
    a later patch

 builtin/fetch.c                  | 68 ++++++++++++++++++++++++++++++++
 t/t4207-log-decoration-colors.sh |  3 +-
 t/t5505-remote.sh                | 21 +++++++---
 t/t5510-fetch.sh                 | 24 +++++++++++
 t/t5512-ls-remote.sh             |  2 +
 t/t5514-fetch-multiple.sh        | 17 +++++++-
 t/t5516-fetch-push.sh            |  3 +-
 t/t5527-fetch-odd-refs.sh        |  3 +-
 t/t7900-maintenance.sh           |  3 +-
 t/t9210-scalar.sh                |  5 ++-
 t/t9211-scalar-clone.sh          |  6 +--
 t/t9902-completion.sh            | 65 ++++++++++++++++++++++++++++++
 12 files changed, 203 insertions(+), 17 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 18eff4e5fa..b569c87f97 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1578,6 +1578,66 @@ static int backfill_tags(struct display_state *display_state,
 	return retcode;
 }
 
+static const char *strip_refshead(const char *name){
+	skip_prefix(name, "refs/heads/", &name);
+	return name;
+}
+
+static int set_head(const struct ref *remote_refs)
+{
+	int result = 0;
+	struct strbuf b_head = STRBUF_INIT, b_remote_head = STRBUF_INIT;
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
+
+	if (!head_name)
+		goto cleanup;
+	strbuf_addf(&b_head, "refs/remotes/%s/HEAD", remote);
+	strbuf_addf(&b_remote_head, "refs/remotes/%s/%s", remote, head_name);
+		/* make sure it's valid */
+	if (!refs_ref_exists(refs, b_remote_head.buf)) {
+		result = 1;
+		goto cleanup;
+	}
+	if (refs_update_symref_extended(refs, b_head.buf, b_remote_head.buf,
+					"fetch", NULL, 1))
+		result = 1;
+
+cleanup:
+	free(head_name);
+	free_refs(fetch_map);
+	free_refs(matches);
+	string_list_clear(&heads, 0);
+	strbuf_release(&b_head);
+	strbuf_release(&b_remote_head);
+	return result;
+}
+
 static int do_fetch(struct transport *transport,
 		    struct refspec *rs,
 		    const struct fetch_config *config)
@@ -1647,6 +1707,8 @@ static int do_fetch(struct transport *transport,
 				    "refs/tags/");
 	}
 
+	strvec_push(&transport_ls_refs_options.ref_prefixes, "HEAD");
+
 	if (must_list_refs) {
 		trace2_region_enter("fetch", "remote_refs", the_repository);
 		remote_refs = transport_get_remote_refs(transport,
@@ -1791,6 +1853,12 @@ static int do_fetch(struct transport *transport,
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
index e6acff4afe..01d2601174 100755
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
@@ -500,7 +500,7 @@ test_expect_success 'set-head --auto has no problem w/multiple HEADs' '
 		cd test &&
 		git fetch two "refs/heads/*:refs/remotes/two/*" &&
 		git remote set-head --auto two >output 2>&1 &&
-		echo "${SQ}two/HEAD${SQ} is now created and points to ${SQ}main${SQ}" >expect &&
+		echo "${SQ}two/HEAD${SQ} is unchanged and points to ${SQ}main${SQ}" >expect &&
 		test_cmp expect output
 	)
 '
@@ -788,8 +788,10 @@ test_expect_success 'reject --no-no-tags' '
 '
 
 cat >one/expect <<\EOF
+  apis/HEAD -> apis/main
   apis/main
   apis/side
+  drosophila/HEAD -> drosophila/main
   drosophila/another
   drosophila/main
   drosophila/side
@@ -807,11 +809,14 @@ test_expect_success 'update' '
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
@@ -819,7 +824,7 @@ EOF
 test_expect_success 'update with arguments' '
 	(
 		cd one &&
-		for b in $(git branch -r)
+		for b in $(git branch -r | grep -v HEAD)
 		do
 		git branch -r -d $b || exit 1
 		done &&
@@ -851,10 +856,13 @@ test_expect_success 'update --prune' '
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
@@ -862,7 +870,7 @@ EOF
 test_expect_success 'update default' '
 	(
 		cd one &&
-		for b in $(git branch -r)
+		for b in $(git branch -r | grep -v HEAD)
 		do
 		git branch -r -d $b || exit 1
 		done &&
@@ -874,6 +882,7 @@ test_expect_success 'update default' '
 '
 
 cat >one/expect <<\EOF
+  drosophila/HEAD -> drosophila/main
   drosophila/another
   drosophila/main
   drosophila/side
@@ -882,7 +891,7 @@ EOF
 test_expect_success 'update default (overridden, with funny whitespace)' '
 	(
 		cd one &&
-		for b in $(git branch -r)
+		for b in $(git branch -r | grep -v HEAD)
 		do
 		git branch -r -d $b || exit 1
 		done &&
@@ -896,7 +905,7 @@ test_expect_success 'update default (overridden, with funny whitespace)' '
 test_expect_success 'update (with remotes.default defined)' '
 	(
 		cd one &&
-		for b in $(git branch -r)
+		for b in $(git branch -r | grep -v HEAD)
 		do
 		git branch -r -d $b || exit 1
 		done &&
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 0890b9f61c..87698341f5 100755
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
index c224c8450c..edb85b7145 100755
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
2.47.0.298.g52a96ec17b

