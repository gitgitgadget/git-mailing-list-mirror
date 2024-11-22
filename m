Received: from aib29agh125.zrh1.oracleemaildelivery.com (aib29agh125.zrh1.oracleemaildelivery.com [192.29.178.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F781DE4D4
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 12:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732278798; cv=none; b=mzgJSHqI7qlCaORETyxnb7e4VzA+ykjHxDK8nIlaimA3xjh+t+RFvjFJ68vZL/+GM3t04Px3moqfhcivOlsE64ZPMi5S/d5SlJvGTVdqapJbvokChfiqgOEUt5PMpcckIACFeyVldFbcoBI89fj/158xB93502WYv9aVWGc8+IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732278798; c=relaxed/simple;
	bh=NIzhe3GNwxA6+Bz0XXmvfKxtHdtoegtDw0FbPtrgPxs=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=MUPUVd+0OZZHDOagp067NNjipbP2QQrfccrSp4LKvyyWb7LPHFPbhabGNF6HX9FsNi+oQczbIV3ukX20wAyJgroXUxQfo+Ao4UzAGu1MBnR2oMIRSKEkYKXgTqUKD4l3A3oyz7K3RF1JA+BxVBkZGruGR8wJeHt/nchd8ghlzl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=P9fU15Sp; arc=none smtp.client-ip=192.29.178.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="P9fU15Sp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=XcUBfQlZoeLA6U4LwXNxK1hrg8YgLlKQa5XU+x1Ub8A=;
 b=P9fU15Spd9oLYrK0CETpeMiVQwZiBFTyptofouDxuenPwswFvEaLwemxjXMTh0CBQITZh+2QNftY
   bwuLXzQ0sD0ggnbYEDOwZN9nEC7AhoRj9d3nDTQAe6+iVHC7VEkQ0kmrH8gzjCvufGi/SdEtKtzw
   pd9Akncu1ysMbt0l2Vka6gyql2Ah7dfynO/G8Suy8w8WGZepaPILQmYLTHbXU488R/PP4HxDY7u5
   Vd5A+R2FhnMbcsDV5tXBHOckwUE9cgoCSb5dr6sJaKTGjEfDQrGnK1zL8xqV3Iu+/jcKIWYa+vGQ
   /kHhOK7ouLVw6uar5Bzq5+ayGybfOFDAgW5gRw==
Received: by omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241024 64bit (built Oct 24
 2024))
 with ESMTPS id <0SNC00FQYQVFVB90@omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Fri, 22 Nov 2024 12:33:15 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,	karthik.188@gmail.com,
	Taylor Blau <me@ttaylorr.com>,	Patrick Steinhardt <ps@pks.im>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v15 10/10] fetch set_head: handle mirrored bare repositories
Date: Fri, 22 Nov 2024 13:28:51 +0100
Message-id: <20241122123138.66960-11-bence@ferdinandy.com>
In-reply-to: <20241122123138.66960-1-bence@ferdinandy.com>
References: <20241121225757.3877852-1-bence@ferdinandy.com>
 <20241122123138.66960-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAG/BPE2Gx8pkLvG8hopB4zX7FvKjrqK44Vl5GFUxSCbTi05zQ93/fmccNGAJtv9
 Ul6VMUbN6v80/W7C6h5nX+CTQkZJwKy9KOWZK3z2POyo1gmkj1TWhvpDr45n8J9E
 Fz8Lo1Z+0bNu20pt5kR6Yirqg5uyqnnM0GQKIf3iiRvTkDj/dePP5ToPVX07zqwD
 Oun5K74/46SvsJ/pj4TtUr5072ANTtfc+w15zhqVEP3YF5ElTr82Vmm10yzMIz9Q
 Z5mgSfdqApiaq6pPsMTxNdC28GtOdWapz7n3c9lMEEADO+tRZfmgfvFZT7LsFZcD
 4ePhGv2mM0eQKv3uxC/w6ompfdNwo8zf0WpFXfEIhtv961LAkuYSMTOMmclNVhfa
 mBsW5wdUYmOHr8xhdGbZKirQZh6GiGf+78UXZBYPF+hLesi8yVIaNgZ045T5tESV
 Fh+XsZOMYaBqDlfToBMTfZv8d7UtLO+MAR/7WwJzmy2kdUAnL6tvl0zG

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
    state:
        * last review: none
    
    v10: - new patch
         - handles the issue discovered in
           https://lore.kernel.org/git/D4ZAELFWJMKN.S88LJ6YK31LZ@ferdinandy.com/T/
    
    v11: no change
    
    v12: no change
    
    v13: properly print the previous head if it was detached
    
    v14: no change
    
    v15: no change

 builtin/fetch.c   | 16 +++++++++++-----
 t/t5505-remote.sh | 10 ++++++++++
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index bbfaf50b63..2f416cf867 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1581,7 +1581,7 @@ static const char *strip_refshead(const char *name){
 
 static int set_head(const struct ref *remote_refs)
 {
-	int result = 0;
+	int result = 0, is_bare;
 	struct strbuf b_head = STRBUF_INIT, b_remote_head = STRBUF_INIT;
 	const char *remote = gtransport->remote->name;
 	char *head_name = NULL;
@@ -1613,15 +1613,21 @@ static int set_head(const struct ref *remote_refs)
 
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
 	if (refs_update_symref_extended(refs, b_head.buf, b_remote_head.buf,
-					"fetch", NULL, 1))
+					"fetch", NULL, !is_bare))
 		result = 1;
 
 cleanup:
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index afa261409f..2600add82a 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -569,6 +569,16 @@ test_expect_success 'add --mirror && prune' '
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
2.47.0.298.g52a96ec17b

