Received: from aib29agh124.zrh1.oracleemaildelivery.com (aib29agh124.zrh1.oracleemaildelivery.com [192.29.178.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3702D3A1DA
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 15:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729697959; cv=none; b=MrbHZKxQISi32gsCsPk+g/CZp0JX13jn0LbGCEMPIt7ndHuc31Ei9SRHIunp670gAlPUGPWjvj6kPDPajR0P+ScSYcQbHygbd6QMe+zEM2KLJr+BetbEhW0V/qqHPi1niiSg/WiH7kPE4OnaJ2l5LfZykmv698BQd2ce/CZh5JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729697959; c=relaxed/simple;
	bh=yeC2FXIQlL4rBtr2deS3g0SljuVWg91AIF7sL4GQ2OU=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=ghuM9ZVu7mqSSVInEwNMnk/fG26uEbWX7QCrxLiRudDlQ8dECly3nbG7kfnvJfHrI152V8XXV+uOLYdCxdJP8zA38t/Do5dSY5u2+zGC78tPnfOg8G00RFgNXbRTQZoEtBGuhm37eoPankadOZjKQ556a8+/emmLspsmwbVYjmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=mvGMSSHG; arc=none smtp.client-ip=192.29.178.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="mvGMSSHG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=X/YnNRd6RpjVyvnwyV12/1EhS9oQAqYPcvJ78ufZ3Yo=;
 b=mvGMSSHG4HyECaAsxWWI5mPA6vDmlCjwKMDIol7dOLClVeGWjql8QxWKuyuVJ6M7Q6pYJY4HkTrb
   J1Xl/2UgXvxzRUiGMOve6er+TSAaB5PPIhU5DVhwGY8Dt4nMke82mMVnr7elx9cLLzvuKaaFMvuw
   YZFVkY99B5AUMvwRD76mPlazSWyD8S4GmlIo0q+yndbZJdXqo4+aihx0QaIHE6X3OHRH3jjox8Gt
   GbRNAUhRK5luDOTNK+UFxif5lv92lmY0EKa+3KAdwotudPrTaKF02o8xQxmaXcnud/s4Onr+HMDB
   HOAc5QXT05ZJyNcIDjOmI7+0L5EE2b+xqU5lXQ==
Received: by omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SLT00OTMFHG2130@omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Wed, 23 Oct 2024 15:39:16 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,	karthik.188@gmail.com,
	Taylor Blau <me@ttaylorr.com>,	Bence Ferdinandy <bence@ferdinandy.com>,
	ferdinandy.bence@ttk.elte.hu
Subject: [PATCH v12 8/8] fetch set_head: handle mirrored bare repositories
Date: Wed, 23 Oct 2024 17:36:42 +0200
Message-id: <20241023153736.257733-9-bence@ferdinandy.com>
In-reply-to: <20241023153736.257733-1-bence@ferdinandy.com>
References: <20241022194710.3743691-1-bence@ferdinandy.com>
 <20241023153736.257733-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAHxVhgT40vmMneorwtbNskryHhsUvCLZftk3h6pVCWanQNRX98yPKGZOrF/i73v
 sB6q645GudB+v8GRwsycy1+XggPHZWY/6Keh3C7GXNF/5JE5FlZLftIEV9HOvK4V
 wT3V1shnSLDuKHfI+MQVueJXvLCvRWVLDPGvsttoYFOAmDlka1tAxnm0q2RDRja4
 eNfG1UvK/pyNPXhULo9J5ECt2GDwij4Xzy3vxnEz7Wg0GyxwSBY5OdT6ua75E+y6
 +1gLgRBA5zm4SNL5WoXXghM/mr2+m86qOjxeDsLSGjuGeyze30i8bp3GPMO6J5DD
 BHuWiM9tcQw4EZmS94g0gU+DeubE2+QlCE0/CJkvYFN2T8/zrwIuEHO2cQuHTmDU
 5XVd78NLFQXF1RJaVEDXbvV1Eo7TdEDcaDA2B5mWGFThc8MPgJSZPRZtHrgROKAL
 DsB5tmiPfNdUYP3R4cpeWqMoJkL3cTntSCX4xpjiCcWpHpxwctTxWJ0=

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
2.47.0.94.g1247fb88fd.dirty

