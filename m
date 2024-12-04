Received: from aib29agh125.zrh1.oracleemaildelivery.com (aib29agh125.zrh1.oracleemaildelivery.com [192.29.178.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DD94D9FB
	for <git@vger.kernel.org>; Wed,  4 Dec 2024 10:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733308882; cv=none; b=uQkYJ5TweKSMIpddSKtn9rP0B3ooGMZrblnuS7ktZHWXXApNTMlOjFERGKLK1zbooiVz4izVzLmT2l1lrzoPDV4EPYQ8hIQx01hKBMBESRfeH7x9dPlXbaqSj7EBY+v6ybZsFr5GMvQLtlbNSbvVLhh+3sileRn4tLRPSDPvX4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733308882; c=relaxed/simple;
	bh=+Fx/atOKGw//dk8Qj0sNPFhEAX8Mmm+gjmFF79DkN3U=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=FZJO0Qnpo2Ppiwy+4SYn2pQfiCN3cjT6bnxxOOrU4fGktc1v/OjwEV5v1611JzersX8he24909mKH/1wJCo2kHJ1awhA/tBB6empkUTQPuZQNZwAU1qlz9q+lcgkOda09M1ZwjUafA2u7zkIwo52sd+blguGzv+hxQ8QwCnj/g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=BK/elUMc; arc=none smtp.client-ip=192.29.178.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="BK/elUMc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=hs7HS9x6QBl/yYFKykicezVXHC/yyJ/IKX7KvsASagU=;
 b=BK/elUMcqLotgApX6FZ2yctBZFKjV79+DZdpOfvF5mEhsahcypB0tFJAlVALBX29nvd3fw6deVE/
   IxQ8OxW/f1FqqbD9cbvEFkNApq0zMQZpTBSjHzjUnXk3KD+1aMuDq9IPEU9arB/frQ02CNRYe8uW
   gemJbL8E6Ggj+LHh2EsudaRmI+t98T7s9BKokeDum0UFuuIcBlNc5f7SJ6Rmw6F5GbrJX201E6Ks
   ulXEEYZBUfcmS3EXyq4hnVuShuOFTgwW1C0scZy+7iQL2qZXC/LphHeFsFdWQYNdcRjyhvch8/Tp
   5X+FUoig9wdAFLIiHALatT39lOc8/RXnwBqt9g==
Received: by omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241107 64bit (built Nov  7
 2024))
 with ESMTPS id <0SNY00JVVTOO9P70@omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Wed, 04 Dec 2024 10:41:12 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,	karthik.188@gmail.com,
	Taylor Blau <me@ttaylorr.com>,	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v2 1/3] fetch set_head: move warn advice into advise_if_enabled
Date: Wed,  4 Dec 2024 11:39:24 +0100
Message-id: <20241204104003.514905-1-bence@ferdinandy.com>
In-reply-to: <20241203215713.135068-1-bence@ferdinandy.com>
References: <20241203215713.135068-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAEMu0/xzORhNdSQ6MwQ6xLQXVfKVXNKCD9mucJxevfKRyuSNM3DpXTHkIrWEyQ0
 kPNSkGx0FcuJyH8u0ZmSAmap5I2wfo6U/zR7tbx+2svWhyOagGAAaswsHbQsIMnh
 Gf4XT+yaQe3hokm0pttCMZC7YXoANtX+9sTgvicaplY7f2aL/AiJAb8i53Vh41Ff
 2QysbiAsA38anT5yPaSy8WZRQSmKdtinXO+oyP2G8xPrGzUTtqD3Lv6CTiZPGuks
 dLOb6LMPP5KKBXLnchMtcceXIIxBNG6OCS/5czcaFtbpAny3UFOsv6IFIFKG49TM
 qESZ4vRxSR6Rm/dF1RRI7fi29a4Zo8tE1vhKW6xE1p9Xb4ReVikh4hgIsRjAkRmZ
 3muAaRd/mx6i721woDKAUVi0FZX/1Fw0y6Zqm9JVTib8eW73jmVWgzTpfM76JZXC
 3exDWB/Y1iuLhs2+2apXxeZ9BXOswgrZlo3VjYylvdQUwKJ4rcyCj2kG

Advice about what to do when getting a warning is typed out explicitly
twice and is printed as regular output. The output is also tested for.
Extract the advice message into a single place and use a wrapper
function, so if later the advice is made more chatty the signature only
needs to be changed in once place. Remove the testing for the advice
output in the tests.

Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
---

Notes:
    v2: new patch, with the refactor moved out from the following one

 advice.c         |  1 +
 advice.h         |  1 +
 builtin/fetch.c  | 17 +++++++++++++----
 t/t5510-fetch.sh |  2 --
 4 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/advice.c b/advice.c
index 6b879d805c..66461fdce9 100644
--- a/advice.c
+++ b/advice.c
@@ -53,6 +53,7 @@ static struct {
 	[ADVICE_COMMIT_BEFORE_MERGE]			= { "commitBeforeMerge" },
 	[ADVICE_DETACHED_HEAD]				= { "detachedHead" },
 	[ADVICE_DIVERGING]				= { "diverging" },
+	[ADVICE_FETCH_SET_HEAD_WARN]			= { "fetchRemoteHEADWarn" },
 	[ADVICE_FETCH_SHOW_FORCED_UPDATES]		= { "fetchShowForcedUpdates" },
 	[ADVICE_FORCE_DELETE_BRANCH]			= { "forceDeleteBranch" },
 	[ADVICE_GRAFT_FILE_DEPRECATED]			= { "graftFileDeprecated" },
diff --git a/advice.h b/advice.h
index d7466bc0ef..cf2284ec43 100644
--- a/advice.h
+++ b/advice.h
@@ -20,6 +20,7 @@ enum advice_type {
 	ADVICE_COMMIT_BEFORE_MERGE,
 	ADVICE_DETACHED_HEAD,
 	ADVICE_DIVERGING,
+	ADVICE_FETCH_SET_HEAD_WARN,
 	ADVICE_FETCH_SHOW_FORCED_UPDATES,
 	ADVICE_FORCE_DELETE_BRANCH,
 	ADVICE_GRAFT_FILE_DEPRECATED,
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 62769d1686..087beb4c92 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1579,6 +1579,17 @@ static const char *strip_refshead(const char *name){
 	return name;
 }
 
+static void set_head_advice_msg(const char *remote, const char *head_name)
+{
+	const char message_advice_set_head[] =
+	N_("Run 'git remote set-head %s %s' to follow the change, or set\n"
+	   "'remote.%s.followRemoteHEAD' configuration option to a different value\n"
+	   "if you do not want to see this message.");
+
+	advise_if_enabled(ADVICE_FETCH_SET_HEAD_WARN, _(message_advice_set_head),
+			remote, head_name, remote);
+}
+
 static void report_set_head(const char *remote, const char *head_name,
 			struct strbuf *buf_prev, int updateres) {
 	struct strbuf buf_prefix = STRBUF_INIT;
@@ -1590,15 +1601,13 @@ static void report_set_head(const char *remote, const char *head_name,
 	if (prev_head && strcmp(prev_head, head_name)) {
 		printf("'HEAD' at '%s' is '%s', but we have '%s' locally.\n",
 			remote, head_name, prev_head);
-		printf("Run 'git remote set-head %s %s' to follow the change.\n",
-			remote, head_name);
+		set_head_advice_msg(remote, head_name);
 	}
 	else if (updateres && buf_prev->len) {
 		printf("'HEAD' at '%s' is '%s', "
 			"but we have a detached HEAD pointing to '%s' locally.\n",
 			remote, head_name, buf_prev->buf);
-		printf("Run 'git remote set-head %s %s' to follow the change.\n",
-			remote, head_name);
+		set_head_advice_msg(remote, head_name);
 	}
 	strbuf_release(&buf_prefix);
 }
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index ccb74428bc..5d7ee1b550 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -123,7 +123,6 @@ test_expect_success "fetch test followRemoteHEAD warn no change" '
 		git fetch >output &&
 		echo "${SQ}HEAD${SQ} at ${SQ}origin${SQ} is ${SQ}main${SQ}," \
 			"but we have ${SQ}other${SQ} locally." >expect &&
-		echo "Run ${SQ}git remote set-head origin main${SQ} to follow the change." >>expect &&
 		test_cmp expect output &&
 		head=$(git rev-parse refs/remotes/origin/HEAD) &&
 		branch=$(git rev-parse refs/remotes/origin/other) &&
@@ -160,7 +159,6 @@ test_expect_success "fetch test followRemoteHEAD warn detached" '
 		echo "${SQ}HEAD${SQ} at ${SQ}origin${SQ} is ${SQ}main${SQ}," \
 			"but we have a detached HEAD pointing to" \
 			"${SQ}${HEAD}${SQ} locally." >expect &&
-		echo "Run ${SQ}git remote set-head origin main${SQ} to follow the change." >>expect &&
 		test_cmp expect output
 	)
 '
-- 
2.47.1.398.g18e7475ebe

