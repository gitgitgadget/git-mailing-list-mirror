Received: from aib29agh125.zrh1.oracleemaildelivery.com (aib29agh125.zrh1.oracleemaildelivery.com [192.29.178.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DD3157469
	for <git@vger.kernel.org>; Sun, 12 Jan 2025 16:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736700716; cv=none; b=TxAjY7JxNjcbPIb5Lbza4lcXkqyzQjn0VeMxV3Hn9E1rkxv6OMdoINDAaIwXN550NZIYUMrp+c7ENFEwdaqzxW1Cki2aY6JCJFoF/KeEVVLLchFY6cXk3XLEIxZ6DutnX01UCoP5SWNuqP1t1wqcHIarhwKHtjiHLlEThoO1wp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736700716; c=relaxed/simple;
	bh=QpUKR3tY/2ZmCtqXo8y7/PVGH54cQQn4wjUiHbdSo/o=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=sS6xYBNUOhHDB70/7GFLQ6I2a+reucVjwVZqWRV2mchrq+tKiJEmWQVU1CAumM/4gpR/aPj2YB3iNfma1wT4H6yyxe18Ax9nfFJuM/udbRpUNPE+vxeGLdG1s7RvKahc//gATzP/EkYiF/rDD8WfqPVHWqa5J4KLHZi4XGDy6d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=mGbl0dIY; arc=none smtp.client-ip=192.29.178.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="mGbl0dIY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=Xtl/VL58QbfSY5JnFZwd9u3MhUQKerglmoScV0xl9+4=;
 b=mGbl0dIYN1MKNFmlPALY1Op0mW+WTHCX0Wd5u20/EE4V0qzCHLEOgI9jY1dhn4AW3vfNiRkcVf7E
   EPnt8aUj8D5Fd58j40P9bMSMZZZkX3a1IFwDJuXQ64CsqKxxOzkXmOEGwspYSvp3TXlLpebXWJGG
   HSBTBMoyMOjebFqR4OG4xRb92RCktyY1m0SeWfIneQTOa78UqnhWhSk7VG96trBrwDckWNyJq63U
   3b/NRSrFszZHkSPYzcUdGjrkOD4grQ3+ESW5qdY1xLiAj+QTfE72g/GP6m4Paol6fA0xUbsOQD6a
   mRTvA3zvoT/nhrXSpc9Ryb+s4HvTzNZrnmUfpg==
Received: by omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241107 64bit (built Nov  7
 2024))
 with ESMTPS id <0SPZ00028IUBF210@omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Sun, 12 Jan 2025 16:51:47 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: Christian Hesse <mail@eworm.de>,	"Christian Hesse" <list@eworm.de>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH] fetch set_head: fix non-mirror remotes in bare repositories
Date: Sun, 12 Jan 2025 17:51:22 +0100
Message-id: <20250112165125.130400-1-bence@ferdinandy.com>
In-reply-to: <20250111202628.0e5894e4@leda.eworm.net>
References: <20250111202628.0e5894e4@leda.eworm.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAFtwRKOns+Xrfavafhn3a2SLgglv8kgn/6JQPe1cXoRt8hKjTVfxJ1eHKE/wVeo
 /XQiDPwBgwPfo2c9mcK9yqqRtN58PmN63Y3U7zoL0HbxJdbp0aFb/G2/sTjfS7ZS
 l/MN9+3pI7k+dWQaZHogtX5aJRlsYSZBruG5XpnkE7IN9+ciNcKVP+Hcb4r2rZVA
 FESCL0yu8kYUQ5SKDTfgN7k5hH9LSMQQQUcdoXA+uRRZbvf+h1wfZ2j5TSdfmFRT
 pHll0hWPbCkp5hrp8VIrDPPYTHuLMf7x3mbmFkctGAx0CsC44reW28aLpY7GC839
 0CYzD2fy5lQL2MAq9olsjlyEo/CJ1Kn2vvjObLJ0R0i6ksXtP2IaGayrQCo0hjDs
 V4ZJU06Sxq4HGJKcKWM0FzeHLn8ORNDTX22TQmeT2RTx7FXStj8pi0TdvAK8e3Y4
 rjqpDEBRm8E6npfUSZe9VHKMODjIO7XMVpRyBSbwHVMQJukz0y57QAxR

In b1b713f722 (fetch set_head: handle mirrored bare repositories,
2024-11-22) it was implicitly assumed that all remotes will be mirrors
in a bare repository, thus fetching a non-mirrored remote could lead to
HEAD pointing to a non-existent reference. Make sure we only overwrite
HEAD if we are in a bare repository and fetching from a mirror.
Otherwise, proceed as normally, and create
refs/remotes/<nonmirrorremote>/HEAD instead.

Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
Reported-by: Christian Hesse <list@eworm.de>
---
 builtin/fetch.c   | 15 ++++++++-------
 t/t5505-remote.sh | 10 ++++++++++
 t/t5510-fetch.sh  | 13 +++++++++++++
 3 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index fe2b26c74a..625d45be8b 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1618,9 +1618,9 @@ static void report_set_head(const char *remote, const char *head_name,
 }
 
 static int set_head(const struct ref *remote_refs, int follow_remote_head,
-		const char *no_warn_branch)
+		const char *no_warn_branch, int mirror)
 {
-	int result = 0, create_only, is_bare, was_detached;
+	int result = 0, create_only, baremirror, was_detached;
 	struct strbuf b_head = STRBUF_INIT, b_remote_head = STRBUF_INIT,
 		      b_local_head = STRBUF_INIT;
 	const char *remote = gtransport->remote->name;
@@ -1655,9 +1655,9 @@ static int set_head(const struct ref *remote_refs, int follow_remote_head,
 
 	if (!head_name)
 		goto cleanup;
-	is_bare = is_bare_repository();
-	create_only = follow_remote_head == FOLLOW_REMOTE_ALWAYS ? 0 : !is_bare;
-	if (is_bare) {
+	baremirror = is_bare_repository() && mirror;
+	create_only = follow_remote_head == FOLLOW_REMOTE_ALWAYS ? 0 : !baremirror;
+	if (baremirror) {
 		strbuf_addstr(&b_head, "HEAD");
 		strbuf_addf(&b_remote_head, "refs/heads/%s", head_name);
 	} else {
@@ -1665,7 +1665,7 @@ static int set_head(const struct ref *remote_refs, int follow_remote_head,
 		strbuf_addf(&b_remote_head, "refs/remotes/%s/%s", remote, head_name);
 	}
 		/* make sure it's valid */
-	if (!is_bare && !refs_ref_exists(refs, b_remote_head.buf)) {
+	if (!baremirror && !refs_ref_exists(refs, b_remote_head.buf)) {
 		result = 1;
 		goto cleanup;
 	}
@@ -1925,7 +1925,8 @@ static int do_fetch(struct transport *transport,
 		}
 	}
 	if (set_head(remote_refs, transport->remote->follow_remote_head,
-		transport->remote->no_warn_branch))
+		transport->remote->no_warn_branch,
+		transport->remote->mirror))
 		;
 		/*
 		 * Way too many cases where this can go wrong
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 519f7973e3..c75cfe968f 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -589,6 +589,16 @@ test_expect_success 'add --mirror setting HEAD' '
 	)
 '
 
+test_expect_success 'non-mirror fetch does not interfere with mirror' '
+	mkdir headnotmain &&
+	(
+		cd headnotmain &&
+		git init --bare -b notmain &&
+		git remote add -f other ../two &&
+		test "$(git symbolic-ref HEAD)" = "refs/heads/notmain"
+	)
+'
+
 test_expect_success 'add --mirror=fetch' '
 	mkdir mirror-fetch &&
 	git init -b main mirror-fetch/parent &&
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 2d9587059f..cfa63ae086 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -84,6 +84,19 @@ test_expect_success "fetch test remote HEAD" '
 	branch=$(git rev-parse refs/remotes/origin/main) &&
 	test "z$head" = "z$branch"'
 
+test_expect_success "fetch test remote HEAD in bare repository" '
+	cd "$D" &&
+	git init --bare barerepo &&
+	cd barerepo &&
+	git remote add upstream ../two &&
+	git fetch upstream &&
+	git rev-parse --verify refs/remotes/upstream/HEAD &&
+	git rev-parse --verify refs/remotes/upstream/main &&
+	head=$(git rev-parse refs/remotes/upstream/HEAD) &&
+	branch=$(git rev-parse refs/remotes/upstream/main) &&
+	test "z$head" = "z$branch"'
+
+
 test_expect_success "fetch test remote HEAD change" '
 	cd "$D" &&
 	cd two &&

base-commit: fbe8d3079d4a96aeb4e4529cc93cc0043b759a05
-- 
2.48.0.1.g32c193c8ca

