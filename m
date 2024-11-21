Received: from aib29agh124.zrh1.oracleemaildelivery.com (aib29agh124.zrh1.oracleemaildelivery.com [192.29.178.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDF31DE2A2
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 23:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732230704; cv=none; b=vEIot+R5MjdEQLL6KbQSs2BSrVCziNaMOzPMdwSLIe4u81nxEx4cZqo1OoMoC/DemsD7yLKekRAyTBpyp4nqrCfdEqXCXxKhP92WknxXE27aaPKY33eTvzdOAWBqo847q6SJln/7DkPbbjsAC78cRazis7h519GqJi3Qu4SwUr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732230704; c=relaxed/simple;
	bh=8KIRx34Kovi4YW2u5fF9cqecJ5hOHpOrcsFQb3zpMH4=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=hjVnFDP2ZOT0sObPO/EbrMJr97ax+RagWUB4fSnHj8qG6nevaw/wiFGbq+EVNY5vhkxIG9vihXv/KwgOX4kUWSHhQ5i9Vmse7kSqR+kIlAjCf5a8darmVRR1odIJjNVUpX82J8riEP5rhN9U/zsV0ULGFxcNoDxgDHKnwgKZjEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=mGzcZwJ/; arc=none smtp.client-ip=192.29.178.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="mGzcZwJ/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=VoNhh8wvks9Fsv+NjGeKZB9kscmngV7XaUEtfyMKeRE=;
 b=mGzcZwJ/s4tLMltXOVOXwQQqLoIyH52P3EH96vKGWF1udoRAo9I1dlvPMowhf1e0ZCbZXz/AqucA
   5DIofSjhv6dTWzfEKzQVXdzpbuUwMiul13Vb0okpL4qIv2XeyuRH1SQ6GR/k4JkHtlozzAKYJ1Nz
   1jT78e9oZ2RYCnMLicZv/WAgAv8MaXcbvBTWr4xy3OhJMbi9CK4EA8PTUa1V7dK/Z1F4C3P+9+Za
   +7YTzPpDjQq7C9MaLDA24T+zXfe7HujvAcic55+6DOI/0kKaDYJ7JVSBDwvUU2OM/DnXNiT8TzMp
   g0Mh84vGs0bXBQafYgn8D/XJS0SbkQSehK9Itg==
Received: by omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241024 64bit (built Oct 24
 2024))
 with ESMTPS id <0SNB000XFPRFC850@omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Thu, 21 Nov 2024 23:11:39 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,	karthik.188@gmail.com,
	Taylor Blau <me@ttaylorr.com>,	Patrick Steinhardt <ps@pks.im>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v14 10/10] fetch set_head: handle mirrored bare repositories
Date: Thu, 21 Nov 2024 23:55:10 +0100
Message-id: <20241121225757.3877852-11-bence@ferdinandy.com>
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
 AAHhvjVTsuHmBCPUrQOL6MO+xdHx7LLWLQsTikv1tJ+ekdKIG5aMsXK/QPMYOoHV
 0/XbNXs+MVi+NbzsHfl9xHWW56COkth9Cg0LNFE00AitstW+YhUcZh+cU9+2c1GG
 9CzO8y3zk1n5t5mchb69LwEWmn0fWRWhvUwb2i5XzVzmU5yEwoI2mD1394ZEywxV
 OTZe3QEuiSMCqYvMsKmhndm8UaDbX5EQOUp8ZzcFYN3VCi11fS7aZUApJfQXhPtL
 v4mq0RGpB8BjH9/Kdd2BLxdjEFgN/Mbxt+5gG6G50ZkL8+Zn+I+3MrlvJXsuPetu
 8EIg6oOxrrKGrhfcxpOoeFX1mPGCYyD1tsqKuETu4QZMaYC1QEHFk2dy6RiE8aGd
 h0jbM3XU60Eqz5RwcEyBZ1sf19GQoyQeTUMc1AVlBlW3dsRna24SFzVlllDfztjW
 Y/ccg/RFo8GJ59HiC/XiSkRhowNDo1EvQAr0HyG0KbZs4yp+mxYhC7DJ

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

 builtin/fetch.c   | 16 +++++++++++-----
 t/t5505-remote.sh | 10 ++++++++++
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index b569c87f97..5103793191 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1585,7 +1585,7 @@ static const char *strip_refshead(const char *name){
 
 static int set_head(const struct ref *remote_refs)
 {
-	int result = 0;
+	int result = 0, is_bare;
 	struct strbuf b_head = STRBUF_INIT, b_remote_head = STRBUF_INIT;
 	const char *remote = gtransport->remote->name;
 	char *head_name = NULL;
@@ -1617,15 +1617,21 @@ static int set_head(const struct ref *remote_refs)
 
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
index 01d2601174..b4f1ae5fb1 100755
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

