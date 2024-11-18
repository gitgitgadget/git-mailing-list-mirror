Received: from aib29agh125.zrh1.oracleemaildelivery.com (aib29agh125.zrh1.oracleemaildelivery.com [192.29.178.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE141C07DF
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 15:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731944060; cv=none; b=eCwanSWKfy2G+UNDv9P1cF0e2YawOoSKBVVxvACD7r8+tip7DLve9BKxL5q0RAhM5ZewhaWghUvnXN+ZVOAK7RQbGemPN46CQJSr2DyWVeWUqK5qVwEo5c8MhgeZ2VHqmJaRYn/7jE8TQpQzyGEXE1AuPY1GoK2w8UU53qq63Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731944060; c=relaxed/simple;
	bh=34i6a0wFYiP3VntotxD2y2EIdCSA560vMZCvcL1ApOA=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=stkAEW3LqDNiyg9DkBY0hQurt4hdhCHUllyKQXN+46RfeTO34/69iMWiaq6WihpSTqHNg5qJryTd1iv5n0LQ2ZGF6rnukc69C047KE2N3mQc6x9HG1bR9zyFkchNdcLxTweW2lYdhrp+g/UV6Wbj/utwZIOmoP0088WOYP7RSJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=H7ylirjm; arc=none smtp.client-ip=192.29.178.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="H7ylirjm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=H6AoqALrrS/HLJhP5E7r5gdA7EVrU6kjL0m4rD80aSM=;
 b=H7ylirjmDs8qf3Gdxb2rO6qYsOh8vE6t9k1MJF8KsfP6foJX6um1HvqguwX+JH5nLjfpL7GpQokc
   XHa2SELoQdd2XzYKMdeGyQO1Y976ydSL3V5nT2+ka/XmTHHCSHzabhcd+9NWHLmRkd4XunpI3JF9
   aCsMtoS4D0eW0Lqk9CPisal0FpEBlUw9VQp5TtTN3yJOTbHAir/XItLayBBBIS2Z4+Rzd1/KhqWb
   K8qxM4ccrbh9oU4giUpHPSzgXTi+bVSn1ZfbVPqY4I5subqVyxltX1n7xgmEOr4VpncYv8LGUVVK
   Dlrqpm0HpwVgg8QzfdkoodfEcOfcWBSC9GLa7Q==
Received: by omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241024 64bit (built Oct 24
 2024))
 with ESMTPS id <0SN500N2KKL3TF90@omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Mon, 18 Nov 2024 15:34:15 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,	karthik.188@gmail.com,
	Taylor Blau <me@ttaylorr.com>,	Patrick Steinhardt <ps@pks.im>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v13 9/9] fetch set_head: handle mirrored bare repositories
Date: Mon, 18 Nov 2024 16:09:28 +0100
Message-id: <20241118151755.756265-10-bence@ferdinandy.com>
In-reply-to: <20241118151755.756265-1-bence@ferdinandy.com>
References: <20241023153736.257733-1-bence@ferdinandy.com>
 <20241118151755.756265-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAEjJVsesN8odlnllSlE9F69lhtyb5Bp7GBDuxpwuovrMAl2gXGbuBYsm/tBvUoX
 4RKyQoY5ZHffuuMilFkeAyU7Qptmb/ZoUqnopGF4fWUfpoyaLPjI9ZHXwU+BZBQN
 4fSnQrKXEjCaurj41JnE/TdgNcSv7sANyocWuRto/6555ZWBriMNqhM5z6u5IGQj
 cMptpebEi20kTvqGyLt45dkYFGwREZdliv8gauh3akhyTbuEKmRMqayCOD7rf/ul
 Jtf1+y0HplbVpK6QvB/tEf3A1US7QlGnvD5WU+fkWUpojxyJGtECVbLFroo5Q/QO
 qEKiwkMVltpDsk9mUQRg4vNrPDPLDhTDh28qjInGSuvVEqGj7hOKGa1O1SxP8mqq
 zRDUjPu9NN4ad54KWg8mlOACaxzkF7LIGNDl9QEf+px2kVC8vst30GX2t32wr8Vk
 RKOeStFjsQQBKzy5ThVUKmy2Bj7bFwnZqmSquePaIP4vJdJVhgpiigz0

When adding a remote to bare repository with "git remote add --mirror",
running fetch will fail to update HEAD to the remote's HEAD, since it
does not know how to handle bare repositories. On the other hand HEAD
already has content, since "git init --bare" has already set HEAD to
whatever is the default branch set for the user. Unless this - by chance
- is the same as the remote's HEAD, HEAD will be pointing to a bad
symref. Teach set_head to handle bare repositories, by overwriting HEAD
so it mirrors the remote's HEAD.

Note, that in this case overriding the local HEAD reference is
necessary, since HEAD will exist before fetch can be run, but this
should not be an issue, since the whole purpose of --mirror is to be an
exact mirror of the remote, so following any changes to HEAD makes
sense.

Also note, that although "git remote set-head" also fails when trying to
update the remote's locally tracked HEAD in a mirrored bare repository,
the usage of the command does not make much sense after this patch:
fetch will update the remote HEAD correctly, and setting it manually to
something else is antithetical to the concept of mirroring.

Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
---

Notes:
    v10: - new patch
         - handles the issue discovered in
           https://lore.kernel.org/git/D4ZAELFWJMKN.S88LJ6YK31LZ@ferdinandy.com/T/
    
    v11: no change
    
    v12: no change
    
    v13: properly print the previous head if it was detached

 builtin/fetch.c   | 16 +++++++++++-----
 t/t5505-remote.sh | 10 ++++++++++
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 3d70cd1add..5e37b9c00f 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1608,7 +1608,7 @@ static const char *strip_refshead(const char *name){
 
 static int set_head(const struct ref *remote_refs)
 {
-	int result = 0, updateres;
+	int result = 0, updateres, is_bare;
 	struct strbuf b_head = STRBUF_INIT, b_remote_head = STRBUF_INIT,
 		b_local_head = STRBUF_INIT;
 	const char *remote = gtransport->remote->name;
@@ -1641,15 +1641,21 @@ static int set_head(const struct ref *remote_refs)
 
 	if (!head_name)
 		goto cleanup;
-	strbuf_addf(&b_head, "refs/remotes/%s/HEAD", remote);
-	strbuf_addf(&b_remote_head, "refs/remotes/%s/%s", remote, head_name);
+	is_bare = is_bare_repository();
+	if (is_bare) {
+		strbuf_addstr(&b_head, "HEAD");
+		strbuf_addf(&b_remote_head, "refs/heads/%s", head_name);
+	} else {
+		strbuf_addf(&b_head, "refs/remotes/%s/HEAD", remote);
+		strbuf_addf(&b_remote_head, "refs/remotes/%s/%s", remote, head_name);
+	}
 		/* make sure it's valid */
-	if (!refs_ref_exists(refs, b_remote_head.buf)) {
+	if (!is_bare && !refs_ref_exists(refs, b_remote_head.buf)) {
 		result = 1;
 		goto cleanup;
 	}
 	updateres = refs_update_symref_extended(refs, b_head.buf, b_remote_head.buf,
-					"fetch", &b_local_head, 1);
+					"fetch", &b_local_head, !is_bare);
 	if (updateres == -1) {
 		result = 1;
 		goto cleanup;
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 660310239c..4cc5df2e61 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -557,6 +557,16 @@ test_expect_success 'add --mirror && prune' '
 	)
 '
 
+test_expect_success 'add --mirror setting HEAD' '
+	mkdir headmirror &&
+	(
+		cd headmirror &&
+		git init --bare -b notmain &&
+		git remote add --mirror -f origin ../one &&
+		test "$(git symbolic-ref HEAD)" = "refs/heads/main"
+	)
+'
+
 test_expect_success 'add --mirror=fetch' '
 	mkdir mirror-fetch &&
 	git init -b main mirror-fetch/parent &&
-- 
2.47.0.296.gda1ecfef29.dirty

