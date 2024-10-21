Received: from aib29agh124.zrh1.oracleemaildelivery.com (aib29agh124.zrh1.oracleemaildelivery.com [192.29.178.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920E81F1314
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 13:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729518320; cv=none; b=OACnChEgbUpKuPR++StrICkzP4QO98Ste7Op4FLhJwp1dxtf8Tiy3r45qYPO2oWsO4mm6g5GtCsbCrB6lwumEtXsR/QwRVAhvOosOFvzIwGfuiNS1pMekeU68D5Iw5LK//Ei7OEuhMW6n4WtZrIezvnKFO3W4orFU5I3eS84Kuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729518320; c=relaxed/simple;
	bh=2meiCrhcdb+jcn29Hl3NBk2fuEzCXLlilrR4tp7nsBw=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=KVMmw1vYqS8Jp700/hJUe1BndGj8Imjn0wEgLeuTFt5+aiaNKSMdDxoeq0C2KQjwluYu0L8eoWcMJD/xY1z6RachT0OUCmBmJnrkOeTGFva318Ud5CsI05wtYXk94jqqMjCAfDPqUndNJDwA11bwHRortZdIWLgTCHAoJRpjblA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=Dz4QJUU5; arc=none smtp.client-ip=192.29.178.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="Dz4QJUU5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=TMeHOq3xERla8KoTBFeNMUqYGsj1U7M4Cyzt/XMYiiY=;
 b=Dz4QJUU5JZS8cx+a5211ryHztVbuhTVWM1dET3LV5bF33zEmH/LzbgCVxSKQLCtriho/9bCCq/Bm
   cyPJaC4VjH1nRNsxRNEvW/JAec4r7wsPlrl8tYqvWpx8ROURxusgtq9wQRhl8GAi2MFyy8h36ewI
   28ffzdjFP6/J/vmMO84p6af397BjTDx8SkL/13Jp29l4QU+TEijgpDrNcTA1PUmFdBib3NPDcnGW
   aN+O/UEahmkTuMFzcXmdPJNc1jIq8Ao1r3f5jML/3OUx/3SJphMCcULfWpQbDB4r9xrgtdIqs2aC
   GXwTeoAtwMmyXJccpbxU8R3tsxhdYMrtIO5HKQ==
Received: by omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SLP00KU7KVH3U20@omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Mon, 21 Oct 2024 13:45:17 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?F=C5=91v=C3=A1rosi=20V=C3=ADzm=C5=B1vek=20Zrt=2E?=
 <noreply@vizmuvek.hu>,	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v10 8/8] fetch set_head: handle mirrored bare repositories
Date: Mon, 21 Oct 2024 15:37:05 +0200
Message-id: <20241021134354.705636-9-bence@ferdinandy.com>
In-reply-to: <20241021134354.705636-1-bence@ferdinandy.com>
References: <1088915169.629942.1729445083543@FVRT-HAMMYAS-P.vizmuvek.hu>
 <20241021134354.705636-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAGKQKp0eSHkB/MBfNPQLYFnMiOGBdGLhzF7U4/j75BiK9nU/kpGSfTnKXbeOE3M
 ++x4+j0FghhrTN7ScZ0q+hHho01Zki0BZtScGv0CXmXNU3GeKNhfOgXjDcpdd0/r
 FgGG2+UessggaQQ7MYo6D+AMC+Ug+PRmDto30SbAXDaZGE5I6TPlmVg2bbg5sQRG
 umNum5YgcgECNXKvpAEW6NUUkAVTLIa9r3IBUjMAE+C7L5HP6eTC7qJvxY69UZkZ
 VnQk91lzw3NtYwUpqseD/jsEl3qGmk8K5aBl///kB4fflCUrUqouWXrGDurAYN6p
 7/qigOwYr1ZaiUSTvV1DqMI2cMVr1aSbtl5yZ3n2FPoPWryT1pgf0bwGomuPPzsE
 auKoxH2XHj9Zb1NbHwv55rpqekGf6WgJAoJ9MESvMk5Cu+LhYnSmMLcAcvthJ40m
 sHJrunrSXD05C0ib+jDP0R0vjEvjruMMzKOI10zuntU1mzk1d5nNfc0=

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

 builtin/fetch.c   | 16 ++++++++++++----
 t/t5505-remote.sh | 10 ++++++++++
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 31edc67447..249556c9c6 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1632,14 +1632,22 @@ static int set_head(const struct ref *remote_refs)
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
2.47.0.94.g8861098b6d

