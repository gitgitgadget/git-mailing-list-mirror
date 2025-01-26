Received: from aib29agh122.zrh1.oracleemaildelivery.com (aib29agh122.zrh1.oracleemaildelivery.com [192.29.178.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852A65684
	for <git@vger.kernel.org>; Sun, 26 Jan 2025 22:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737929077; cv=none; b=oOMZ1AsiMm4gxouupNb2T0nYhy49IRq3Dhac9eQ2CT8GMU964b8pYMqpMRXrNjIVDQkhK4kG0dSr96d3oKJy0KYZv28iAeHJuv7eBkonnX2pxPqBtTfXzGg3MSRmfW200cySN+XkKXKAu9zNRN7JUyZoQ+g+XQbclMOhkzZVbXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737929077; c=relaxed/simple;
	bh=886ZzNsTY/qF/ruBfi6ihoGznKKoWwX3sYKOrw2ujSM=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=gUyHk86CXv17BUbQakAmJXQj0db3Z6l5SAxtXJ2MemNagda/EgzkHMdEGalK3yxUaL12U/6QJQhI85pr2xAXO/xIgaU8n9C5WH1zBaUGUepEXKaW4NAXg7oKeTNh14oi7r2dzEAWAknaH4zZBKdPlaFyHVdtW0286a2VoO/9XL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=lCqqwvWJ; arc=none smtp.client-ip=192.29.178.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="lCqqwvWJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=/SMi4sC4ZONTlkHDKMXWbWahG6fPgtMRqJx6UBv/E24=;
 b=lCqqwvWJ90BwiaOOOoj92hN+kW///kAKVL09W7vpFty9kqFgXqOvC9bOevi8cdet8GPFeUAXwsry
   mVtYzcYMxOSC4yppg0baahEVYsNQRkgTYEaTpKasVUQ6dB0NFNIWqyGrA55yK5vrgxcH1kIPWVBp
   W4jxZ/MEooQKXTeWiNFRrD6dZDihkuQIkyPucLOOvX2u2ifI5tWeytxW18etVHA1spCXWpzhPQbw
   ZtVvoSuOyvKj/8rTh2BGsGpPt2XBOCs5hVMJSCSW9LGT/ToldsnV3FIbueGsxrt6hBvr1TSoBEnv
   Mdv5MiCXjQcBYl5RcnPOrZLB/4ejHj9RxTKHiQ==
Received: by omta-ad1-fd1-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241107 64bit (built Nov  7
 2024))
 with ESMTPS id <0SQP00M36UNKN710@omta-ad1-fd1-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Sun, 26 Jan 2025 22:04:32 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: Christian Hesse <mail@eworm.de>,	Christian Hesse <list@eworm.de>,
	"Patrick Steinhardt" <ps@pks.im>,	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v2 2/2] fetch set_head: fix non-mirror remotes in bare
 repositories
Date: Sun, 26 Jan 2025 23:02:11 +0100
Message-id: <20250126220403.289742-2-bence@ferdinandy.com>
In-reply-to: <20250126220403.289742-1-bence@ferdinandy.com>
References: <Z5Mrk02wMdABtrVZ@pks.im>
 <20250126220403.289742-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAGcIlV6XF6lzTI15503/qHCpMsBJuI0q7tH2id5Ehse+WP8PX2zQcVqEXV4R5VT
 Wh2L0e2NI5+03SoyerI7Dkhykyw5jkZzJBFln2dQRLIyCAawNbpd67PnNMcSRQLe
 0fM4LmFo8iPkrYnIF+gk0SjJJRH96sohQHWSVPb7WvfWGkZ128sZ8RfhBFLYpz/s
 b4NQMAwBPBoznrepasf257DtbLw9e91D1a7VkxUm+WjKVJTcz6gS13Xs9gtqKQ59
 PDHMxl72PnxRbe38YWcxc1kr0rqAC36ZOXrcePh4LBuRYBpsaDL+uQbddqs8A0cC
 IQVxyIHwaPPtFvD4HowAfOKxwsZGpHQ/vDmhgbhjErmYPx1m6Vw4tqd2XQoOxYvB
 3V08YO8Q4bBSsnJE0eKo28dgiaREmhG5qFy+LXfGgH6HHdiBFaLh2kGLQPBuay6R
 ywP8E8pS+wqR+KzRuBlNDMrUUnuNiiQwiYhta/PvrmsMeB8ypp/wtUc=

In b1b713f722 (fetch set_head: handle mirrored bare repositories,
2024-11-22) it was implicitly assumed that all remotes will be mirrors
in a bare repository, thus fetching a non-mirrored remote could lead to
HEAD pointing to a non-existent reference. Make sure we only overwrite
HEAD if we are in a bare repository and fetching from a mirror.
Otherwise, proceed as normally, and create
refs/remotes/<nonmirrorremote>/HEAD instead.

Reported-by: Christian Hesse <list@eworm.de>
Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
---

Notes:
    v2: - fixed too many parameters to set_head
        - cleaned up the style of tests

 builtin/fetch.c   | 10 +++++-----
 t/t5505-remote.sh | 10 ++++++++++
 t/t5510-fetch.sh  | 17 +++++++++++++++++
 3 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 3167b055d1..1c740d5aac 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1619,7 +1619,7 @@ static void report_set_head(const char *remote, const char *head_name,
 
 static int set_head(const struct ref *remote_refs, struct remote *remote)
 {
-	int result = 0, create_only, is_bare, was_detached;
+	int result = 0, create_only, baremirror, was_detached;
 	struct strbuf b_head = STRBUF_INIT, b_remote_head = STRBUF_INIT,
 		      b_local_head = STRBUF_INIT;
 	int follow_remote_head = remote->follow_remote_head;
@@ -1655,9 +1655,9 @@ static int set_head(const struct ref *remote_refs, struct remote *remote)
 
 	if (!head_name)
 		goto cleanup;
-	is_bare = is_bare_repository();
-	create_only = follow_remote_head == FOLLOW_REMOTE_ALWAYS ? 0 : !is_bare;
-	if (is_bare) {
+	baremirror = is_bare_repository() && remote->mirror;
+	create_only = follow_remote_head == FOLLOW_REMOTE_ALWAYS ? 0 : !baremirror;
+	if (baremirror) {
 		strbuf_addstr(&b_head, "HEAD");
 		strbuf_addf(&b_remote_head, "refs/heads/%s", head_name);
 	} else {
@@ -1665,7 +1665,7 @@ static int set_head(const struct ref *remote_refs, struct remote *remote)
 		strbuf_addf(&b_remote_head, "refs/remotes/%s/%s", remote->name, head_name);
 	}
 		/* make sure it's valid */
-	if (!is_bare && !refs_ref_exists(refs, b_remote_head.buf)) {
+	if (!baremirror && !refs_ref_exists(refs, b_remote_head.buf)) {
 		result = 1;
 		goto cleanup;
 	}
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 519f7973e3..66e373f71d 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -589,6 +589,16 @@ test_expect_success 'add --mirror setting HEAD' '
 	)
 '
 
+test_expect_success 'non-mirror fetch does not interfere with mirror' '
+	test_when_finished rm -rf headnotmain &&
+	(
+		git init --bare -b notmain headnotmain &&
+		cd headnotmain &&
+		git remote add -f other ../two &&
+		test "$(git symbolic-ref HEAD)" = "refs/heads/notmain"
+	)
+'
+
 test_expect_success 'add --mirror=fetch' '
 	mkdir mirror-fetch &&
 	git init -b main mirror-fetch/parent &&
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 2d9587059f..c9d7b46c87 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -84,6 +84,23 @@ test_expect_success "fetch test remote HEAD" '
 	branch=$(git rev-parse refs/remotes/origin/main) &&
 	test "z$head" = "z$branch"'
 
+test_expect_success "fetch test remote HEAD in bare repository" '
+	test_when_finished rm -rf barerepo &&
+	(
+		cd "$D" &&
+		git init --bare barerepo &&
+		cd barerepo &&
+		git remote add upstream ../two &&
+		git fetch upstream &&
+		git rev-parse --verify refs/remotes/upstream/HEAD &&
+		git rev-parse --verify refs/remotes/upstream/main &&
+		head=$(git rev-parse refs/remotes/upstream/HEAD) &&
+		branch=$(git rev-parse refs/remotes/upstream/main) &&
+		test "z$head" = "z$branch"
+	)
+'
+
+
 test_expect_success "fetch test remote HEAD change" '
 	cd "$D" &&
 	cd two &&
-- 
2.48.1.93.g276f59c085

