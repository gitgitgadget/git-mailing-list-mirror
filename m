Received: from aib29agh124.zrh1.oracleemaildelivery.com (aib29agh124.zrh1.oracleemaildelivery.com [192.29.178.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CBE19259E
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 21:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733263106; cv=none; b=CnQihzBQpvmC71tjYKLlNaSTILMCw+/IzNyvbj30rDfvXx2Npfqn1gcaFfEuoTt6l3p2jPmh8Ei3nvSZJdy9yCA9wO3iD1GeJIK8fsYbu3uR3QAXpjvf121SqjLBVwR31bVuYYz/HdCYcehmeQB9wrkAYOxQBMq47dkaYFbvc8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733263106; c=relaxed/simple;
	bh=PwLmB3w/IOvV0PdqyS0iZPx8mrrHXslTG2YUb2pytA0=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=hHsSQOQVKb0BUmM9tY/8qzl3/sMSWMP2GEwjJjcNa7VidgdpMVp8ftHuWmnU0TeBT6lM7/iL6ohH2RHL0xj7DFxxxhM9gSZnkhfg9RxcYWJeDoa3v38QmDjwwM78qXjzDwAxwJq+YQVhrJlBfWb9/P0zYREaKPEkuRPtBub+OFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=SIuSKaIn; arc=none smtp.client-ip=192.29.178.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="SIuSKaIn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=yJp1fsfLBheuVdkDCxyC9owzPuorta2XcJ1D5wDF/qY=;
 b=SIuSKaInimTRkBhi1/ucmPqeuBkjsz3haTN/eBCcqiw3QlGUHXzTW2kcAXaXAGvqOFmSKha+VbGn
   OFhPQ+8MCVYwvUcZ0h8eBtLtApPrcdIMchxhS73InC4DpSxDFK99jIN6uk5nAflENaWICjADY6Tz
   A3AIBC7THsYaiCYJXJjHnXNQnb4SaGPAoecS/hKi4n1lnEqY0fxUoSQR9rJrDFJV0adlTVqm3Gvk
   riwJrYa0TDA2Gmg5XiKKwYAcrlOYTOAnCM9tsi855GgRiG6AHfoLXTjkMAH7jVfk1oBQTUvqJN/i
   4SznyKSC9x2+Xz5MZBmhgNvRZxaYm5m1rqF1pQ==
Received: by omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241107 64bit (built Nov  7
 2024))
 with ESMTPS id <0SNX00C0WUD39AF0@omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Tue, 03 Dec 2024 21:58:15 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,	karthik.188@gmail.com,
	Taylor Blau <me@ttaylorr.com>,	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [RFC PATCH v1 1/2] fetch set_head: add warn-if-not-$branch option
Date: Tue,  3 Dec 2024 22:56:47 +0100
Message-id: <20241203215713.135068-2-bence@ferdinandy.com>
In-reply-to: <20241203215713.135068-1-bence@ferdinandy.com>
References: <xmqqiks7oprx.fsf@gitster.g>
 <20241203215713.135068-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAFqDQYZm1jFPCZW4D1Fmo9zRzjP+gpQNTqhKjfCq3HsU0+faZzMQLQkVEsEkPva
 9litAjVwA0PDvpxXpARVDFf+FhVB+PGHqivSIFTNtjeT2NUDb0P/FbzrHK/dYO/T
 hyzx1Tza+FHqL0JKwtX0TpJ+oGw2aCQFvu594mo3vWKjVdund16SR3xUl6ibSdIU
 wSBYaUZpcgj2IKUvSTtz0rTGzvOtoah5rcZEGn9aKSxVHgD4EgQV9bPzARRQD27g
 KlpFHCrZODJvbW/oGho9vMXMsxQ3gJTNYNHFtz7mNJ8VCMvGRkqBo5+/5WOeU9cg
 /ERjdyCHpnyanePcvonVgTm4fKPv9Dd6Dhq9LeWRNS4Hytdyt1TV4JDzpBVb2bz5
 qhTlb0DTgkRTtQo6tOVlmb1h53KfwogBXBKlmPnK+RYiPjANg/xhENtL/rni+11F
 zjmxeUGxVmexONDlSBsjBu0M1dFhzMiuSLa7/r2hVUw2wHDFec2nJhE=

Currently if we want to have a remote/HEAD locally that is different
from the one on the remote, but we still want to get a warning if remote
changes HEAD, our only option is to have an indiscriminate warning with
"follow_remote_head" set to "warn". Add a new option
"warn-if-not-$branch", where $branch is a branch name we do not wish to
get a warning about. If the remote HEAD is $branch do not warn,
otherwise, behave as "warn".

E.g. let's assume, that our remote origin has HEAD
set to "master", but locally we have "git remote set-head origin seen".
Setting 'remote.origin.followRemoteHEAD = "warn"' will always print
a warning, even though the remote has not changed HEAD from "master".
Setting 'remote.origin.followRemoteHEAD = "warn-if-not-master" will
squelch the warning message, unless the remote changes HEAD from
"master". Note, that should the remote change HEAD to "seen" (which we
have locally), there will still be no warning.

Improve the advice message in report_set_head to also include silencing
the warning message with "warn-if-not-$branch".

Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
---
 builtin/fetch.c  | 26 ++++++++++++++++++-------
 remote.c         |  5 +++++
 remote.h         |  6 ++++--
 t/t5510-fetch.sh | 49 ++++++++++++++++++++++++++++++++++++++++++++++--
 4 files changed, 75 insertions(+), 11 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 88c5c5d781..fd7f3694cc 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1579,6 +1579,15 @@ static const char *strip_refshead(const char *name){
 	return name;
 }
 
+static void set_head_advice_msg(const char *remote, const char *head_name) {
+
+	printf("Run 'git remote set-head %s %s' to follow the change, or\n"
+		"'git config set remote.%s.warn-if-not-%s' to disable this warning\n"
+		"until the remote changes HEAD again.\n",
+		remote, head_name, remote, head_name);
+
+}
+
 static void report_set_head(const char *remote, const char *head_name,
 			struct strbuf *buf_prev, int updateres) {
 	struct strbuf buf_prefix = STRBUF_INIT;
@@ -1590,20 +1599,19 @@ static void report_set_head(const char *remote, const char *head_name,
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
 
-static int set_head(const struct ref *remote_refs, int follow_remote_head)
+static int set_head(const struct ref *remote_refs, int follow_remote_head,
+		const char *no_warn_branch)
 {
 	int result = 0, create_only, is_bare, was_detached;
 	struct strbuf b_head = STRBUF_INIT, b_remote_head = STRBUF_INIT,
@@ -1660,7 +1668,10 @@ static int set_head(const struct ref *remote_refs, int follow_remote_head)
 		result = 1;
 		goto cleanup;
 	}
-	if (follow_remote_head == FOLLOW_REMOTE_WARN && verbosity >= 0)
+	if ((follow_remote_head == FOLLOW_REMOTE_WARN ||
+		(follow_remote_head == FOLLOW_REMOTE_WARN_IF_NOT_BRANCH &&
+		strcmp(no_warn_branch, head_name))
+		) && verbosity >= 0)
 		report_set_head(remote, head_name, &b_local_head, was_detached);
 
 cleanup:
@@ -1889,7 +1900,8 @@ static int do_fetch(struct transport *transport,
 				  "you need to specify exactly one branch with the --set-upstream option"));
 		}
 	}
-	if (set_head(remote_refs, transport->remote->follow_remote_head))
+	if (set_head(remote_refs, transport->remote->follow_remote_head,
+		transport->remote->no_warn_branch))
 		;
 		/*
 		 * Way too many cases where this can go wrong
diff --git a/remote.c b/remote.c
index 0b18840d43..f0e1b1b76a 100644
--- a/remote.c
+++ b/remote.c
@@ -515,6 +515,7 @@ static int handle_config(const char *key, const char *value,
 		return parse_transport_option(key, value,
 					      &remote->server_options);
 	} else if (!strcmp(subkey, "followremotehead")) {
+		const char *no_warn_branch;
 		if (!strcmp(value, "never"))
 			remote->follow_remote_head = FOLLOW_REMOTE_NEVER;
 		else if (!strcmp(value, "create"))
@@ -523,6 +524,10 @@ static int handle_config(const char *key, const char *value,
 			remote->follow_remote_head = FOLLOW_REMOTE_WARN;
 		else if (!strcmp(value, "always"))
 			remote->follow_remote_head = FOLLOW_REMOTE_ALWAYS;
+		else if (skip_prefix(value, "warn-if-not-", &no_warn_branch)) {
+			remote->follow_remote_head = FOLLOW_REMOTE_WARN_IF_NOT_BRANCH;
+			remote->no_warn_branch = no_warn_branch;
+		}
 	}
 	return 0;
 }
diff --git a/remote.h b/remote.h
index 184b35653d..75be3977ba 100644
--- a/remote.h
+++ b/remote.h
@@ -62,8 +62,9 @@ struct remote_state *remote_state_new(void);
 	enum follow_remote_head_settings {
 		FOLLOW_REMOTE_NEVER = -1,
 		FOLLOW_REMOTE_CREATE = 0,
-		FOLLOW_REMOTE_WARN = 1,
-		FOLLOW_REMOTE_ALWAYS = 2,
+		FOLLOW_REMOTE_WARN_IF_NOT_BRANCH = 1,
+		FOLLOW_REMOTE_WARN = 2,
+		FOLLOW_REMOTE_ALWAYS = 3,
 	};
 
 struct remote {
@@ -116,6 +117,7 @@ struct remote {
 	struct string_list server_options;
 
 	enum follow_remote_head_settings follow_remote_head;
+	const char *no_warn_branch;
 };
 
 /**
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 2467027d34..be0c60be2c 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -124,7 +124,9 @@ test_expect_success "fetch test followRemoteHEAD warn no change" '
 		git fetch >output &&
 		echo "${SQ}HEAD${SQ} at ${SQ}origin${SQ} is ${SQ}main${SQ}," \
 			"but we have ${SQ}other${SQ} locally." >expect &&
-		echo "Run ${SQ}git remote set-head origin main${SQ} to follow the change." >>expect &&
+		echo "Run ${SQ}git remote set-head origin main${SQ} to follow the change, or" >>expect &&
+		echo "${SQ}git config set remote.origin.warn-if-not-main${SQ} to disable this warning" >>expect &&
+		echo "until the remote changes HEAD again." >>expect &&
 		test_cmp expect output &&
 		head=$(git rev-parse refs/remotes/origin/HEAD) &&
 		branch=$(git rev-parse refs/remotes/origin/other) &&
@@ -161,7 +163,9 @@ test_expect_success "fetch test followRemoteHEAD warn detached" '
 		echo "${SQ}HEAD${SQ} at ${SQ}origin${SQ} is ${SQ}main${SQ}," \
 			"but we have a detached HEAD pointing to" \
 			"${SQ}${HEAD}${SQ} locally." >expect &&
-		echo "Run ${SQ}git remote set-head origin main${SQ} to follow the change." >>expect &&
+		echo "Run ${SQ}git remote set-head origin main${SQ} to follow the change, or" >>expect &&
+		echo "${SQ}git config set remote.origin.warn-if-not-main${SQ} to disable this warning" >>expect &&
+		echo "until the remote changes HEAD again." >>expect &&
 		test_cmp expect output
 	)
 '
@@ -184,6 +188,47 @@ test_expect_success "fetch test followRemoteHEAD warn quiet" '
 	)
 '
 
+test_expect_success "fetch test followRemoteHEAD warn-if-not-branch branch is same" '
+	test_when_finished "git config unset remote.origin.followRemoteHEAD" &&
+	(
+		cd "$D" &&
+		cd two &&
+		git rev-parse --verify refs/remotes/origin/other &&
+		git remote set-head origin other &&
+		git rev-parse --verify refs/remotes/origin/HEAD &&
+		git rev-parse --verify refs/remotes/origin/main &&
+		git config set remote.origin.followRemoteHEAD "warn-if-not-main" &&
+		output=$(git fetch) &&
+		test "z" = "z$output" &&
+		head=$(git rev-parse refs/remotes/origin/HEAD) &&
+		branch=$(git rev-parse refs/remotes/origin/other) &&
+		test "z$head" = "z$branch"
+	)
+'
+
+test_expect_success "fetch test followRemoteHEAD warn-if-not-branch branch is different" '
+	test_when_finished "git config unset remote.origin.followRemoteHEAD" &&
+	(
+		cd "$D" &&
+		cd two &&
+		git rev-parse --verify refs/remotes/origin/other &&
+		git remote set-head origin other &&
+		git rev-parse --verify refs/remotes/origin/HEAD &&
+		git rev-parse --verify refs/remotes/origin/main &&
+		git config set remote.origin.followRemoteHEAD "warn-if-not-some/different-branch" &&
+		git fetch >output &&
+		echo "${SQ}HEAD${SQ} at ${SQ}origin${SQ} is ${SQ}main${SQ}," \
+			"but we have ${SQ}other${SQ} locally." >expect &&
+		echo "Run ${SQ}git remote set-head origin main${SQ} to follow the change, or" >>expect &&
+		echo "${SQ}git config set remote.origin.warn-if-not-main${SQ} to disable this warning" >>expect &&
+		echo "until the remote changes HEAD again." >>expect &&
+		test_cmp expect output &&
+		head=$(git rev-parse refs/remotes/origin/HEAD) &&
+		branch=$(git rev-parse refs/remotes/origin/other) &&
+		test "z$head" = "z$branch"
+	)
+'
+
 test_expect_success "fetch test followRemoteHEAD always" '
 	test_when_finished "git config unset remote.origin.followRemoteHEAD" &&
 	(
-- 
2.47.1.297.g6455f89743

