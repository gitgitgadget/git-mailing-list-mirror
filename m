Received: from aib29agh127.zrh1.oracleemaildelivery.com (aib29agh127.zrh1.oracleemaildelivery.com [192.29.178.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5F114EC55
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 19:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729626582; cv=none; b=mEcDY1mSvkq1R/S120lb01YdZmmYjKY65teusrnLVgPzDiWnN5vdAtgDU2LPjNK+2Vs6p/ReMdDK4pzV4ZfxO47eJM5UqF5ooTFUb+n6Rv0eBvS0yJM2vThvCrYrpMpzUv0v7ci7VZVe3zXL+xHS5vvY0UHY9Huv3inqTit2uJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729626582; c=relaxed/simple;
	bh=62nUaqLuKaLvEusuDq03kdMcUfc5DztYA0B/UsxdMEc=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=EdCjOE/oR2zxB7bVyBqfDZGt4a2KSFejrix8nTCAyfGIsEiZk4UANrBPwzaqU0UWCg995qu+UIY7Oh6c6zSTemq4A7nliRCWqBRegUOK7exPnLSpkynVdFWETuDC+H92rdqO0AD8LXd2rxvLI612j9wHq7Mgb9p6TaksAJkRLW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=byKZ7h6+; arc=none smtp.client-ip=192.29.178.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="byKZ7h6+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=jkHHDIjYSynWLR1suICL9Xob1GMrY4FOJ+j0wiXOUR8=;
 b=byKZ7h6+ZCIxW7SdGwvKObTKlnRl6eg4TDGNUkk7p4pOqUINxW+6YrzMPtMuPtYr4TMu8qV/iCjP
   KtRs7JMcTCMg5eDjH6WkYGYmrVaSg0xJhUMkSkNlS2l5jm4Ci6Uj/pgBxiqilfCmJOoZZw9m1qHH
   lTN1F9jWqdgH1/z02kNa2xOcI7BP9A2ysixVnUZ9RmyBYCxCYxSzbALEHDAbAF1dKld74FZlmNMb
   LddHdRjlCDMii1oWko2KaNecA9+CPCba09mvpgtTQMq2UunUQj9IqSK2XQSaIWnAq1szfi7a2HdU
   HLH78FAU20cJK3bGMYFHbNEvnIyWVAYofqcqqg==
Received: by omta-ad1-fd3-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SLR006PTWELGZ90@omta-ad1-fd3-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Tue, 22 Oct 2024 19:49:33 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,	karthik.188@gmail.com,
	Taylor Blau <me@ttaylorr.com>,	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v11 8/8] fetch set_head: handle mirrored bare repositories
Date: Tue, 22 Oct 2024 21:45:45 +0200
Message-id: <20241022194710.3743691-9-bence@ferdinandy.com>
In-reply-to: <20241022194710.3743691-1-bence@ferdinandy.com>
References: <43d44c82-b93d-4ac9-a5ac-ae5f70982cfd@ferdinandy.com>
 <20241022194710.3743691-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAGHA9QqAs6nny66Lrx6h0046xxLuoR2vVLgBl9cs5sCtwXDGDNe9lEtO3nRGarE
 jTONO6aB3lLZZxuthdXFFUcv6ZVsrs5ix59nFnWqRy460uFLfcKQGX54r4wyVXJ7
 nP6pxSe5jhvYFgcViXA/4YpQLIdVu3IVqiGLNI+DkqcbVBr5hiFDP3HUDmLXf/o8
 216fQOuCO1+OOZ2uqJ8XZ72EUHaM8j79AK/OyJMEgHrh8W4MDQYrx/VSpPOOTBcX
 dgFWzRQ6Jk0GyHvPmW5RswTLVuVRSjvCBR+ZtcAA7EW3S5waRyXUbCjQfgcd3a+o
 tq5we9ZfNfuaq5mQdAqtlnslmoim/AIrSW1jKwV8fW34lekM5SzULn4RFEjcdufD
 Ce1v4nBPiMjLXtszHiB8mfCKo6a4zp9fPM3PnCK5I9waWo9IgLLGbZd3svRgZ01d
 Z7irHc2mTXQx7Bln+GEBdlu68qKroLH7sU+zQRGmOTwztnGb1gxwtG0=

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

 builtin/fetch.c   | 16 ++++++++++++----
 t/t5505-remote.sh | 10 ++++++++++
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index cadfd2407a..8af3efd6ac 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1633,14 +1633,22 @@ static int set_head(const struct ref *remote_refs)
 	else
 		head_name = xstrdup(heads.items[0].string);
 	if (head_name) {
-		strbuf_addf(&b_head, "refs/remotes/%s/HEAD", remote);
-		strbuf_addf(&b_remote_head, "refs/remotes/%s/%s", remote, head_name);
+		int is_bare = is_bare_repository();
+		if (is_bare) {
+			strbuf_addstr(&b_head, "HEAD");
+			strbuf_addf(&b_remote_head, "refs/heads/%s", head_name);
+		} else {
+			strbuf_addf(&b_head, "refs/remotes/%s/HEAD", remote);
+			strbuf_addf(&b_remote_head, "refs/remotes/%s/%s", remote, head_name);
+		}
 		/* make sure it's valid */
-		if (!refs_ref_exists(refs, b_remote_head.buf))
+		if (!is_bare && !refs_ref_exists(refs, b_remote_head.buf)) {
 			result = 1;
+		}
 		else if (refs_update_symref_extended(refs, b_head.buf, b_remote_head.buf,
-					"fetch", &b_local_head, 1))
+					"fetch", &b_local_head, !is_bare)) {
 			result = 1;
+		}
 		else
 			report_set_head(remote, head_name, &b_local_head);
 
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 4990d00209..dfa78f3e8d 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -545,6 +545,16 @@ test_expect_success 'add --mirror && prune' '
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
2.47.0.94.gb64850d498

