Received: from aib29agh127.zrh1.oracleemaildelivery.com (aib29agh127.zrh1.oracleemaildelivery.com [192.29.178.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CBF1E521
	for <git@vger.kernel.org>; Sun, 26 Jan 2025 22:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737929381; cv=none; b=B2Pkpff0RP4F28hnM3BSmrOKoV/EogPBJX4WFzJtjtaQ2ZhmaabOiGYtJaxsXv42xrYvWk7p5M99sT7mpCJZDH7Uvaa1tNQpA4Liup9iivUdt4CnyX0sLGmPnrVn+AnejASfpmxf5wG12rEyCV3TpghGGh+h6FWNoAuSJHB/8ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737929381; c=relaxed/simple;
	bh=EJWovt9lmm9fK/kcujJdzUR2C5L+PHPva/m56w3/uu0=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=QLlUb1pmOYACbPy0F7ICFRmDUtGshcW7HsbhMy6+QHki6hI9Mp0KZQ/duroZ8DE+RJU/vIYcQ+vuszZqV0WwqjOXUfNqRMBFuxPOHSd7hY2w7ZUI497D27hLIIFgqIOt5jOrMf8f/tzEa6oYd1FtXSw1YaAZIouumyl6xSRW9JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=mpuZOR6k; arc=none smtp.client-ip=192.29.178.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="mpuZOR6k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=wpXB9FcIRvnEGo0uLz9YWwlx3Spv3U4R9yrCbVkyPJg=;
 b=mpuZOR6k6A7PaVQEMQEkGODZW9+zc9JP4aHupLgpGTeSxBTm8okDfd7KWzakMaEVQAO/ciPaKpVq
   1qt6yuCelLRBDI8rO1nMcBa0s3FiTAsS8d8k/N2/BaSHeUKblZeSAgOkN+u+2SnzJfsLMWL2Hk0g
   f6dJIglPLdGVfLMYtKqgtiZi+Ezm1vfK1olEXrwF86UOzgCDFYTc+gDMJVsM57OJbwq3obtcCGDi
   BqRBQJ6sq624foYfcwxZy8uSRo0yYtvawnU4GG0ibhxYsySPraEVO8NAgHDY0AKXxriX0fUe0LhV
   rzK7rdbWyoBAK4DZQ+sB5vDYTItsHVcFTaKihg==
Received: by omta-ad1-fd3-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241107 64bit (built Nov  7
 2024))
 with ESMTPS id <0SQP00EFBUNJSQ90@omta-ad1-fd3-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Sun, 26 Jan 2025 22:04:31 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: Christian Hesse <mail@eworm.de>,	Christian Hesse <list@eworm.de>,
	"Patrick Steinhardt" <ps@pks.im>,	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v2 1/2] fetch set_head: refactor to use remote directly
Date: Sun, 26 Jan 2025 23:02:10 +0100
Message-id: <20250126220403.289742-1-bence@ferdinandy.com>
In-reply-to: <Z5Mrk02wMdABtrVZ@pks.im>
References: <Z5Mrk02wMdABtrVZ@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAGxQJE2mvPvJYyGsn82nZBi6C+00/KI80E9EqRXX2QbGz3gT1lVU9+HX+sJCJZI
 0MPjyFvpW1LwzYkg+DT5peaSWGuN9XSExqU3q63PprS9qAkIOvvuL4CJTX0KFm1d
 yLh7eYt8GixHeH5WvcOgGjp0SRGmCPg5886wbcXk2B4p3v02YNBGrcsh4EDEm4EA
 HrznAyMl8Vkx8+aW3wY//vKVRhNqoS0PoCdgsooqRLIS8D5TdSZex+76U5kPNfcs
 dmkqR8X7GCSDhMwA6TVa+HsyJMB3hc1QwmXsZWfW/n96i53YjActQYa7ljG9KTVO
 dI+FGsOugeY4jXEwY4DE4M5NB19ae3iTTGSViHkVzcvJZyacsiGhS/nf88Veorat
 neDpfGTSu4fV+35aZKIrwaHtUV1oj4ZVfsPNgv/Qn5Y0Dn1Vxg/YgW9awdMWLntF
 yC4IY0vQCvkFEv2hqPHhO0BYnsevOp/66Rir8XoIAji+u/fwMQtNZg1o

As a preparatory step to use even more properties from the remote
struct, refactor set_head to take the entire struct as a parameter,
instead of the necessary bits. This also allows consolidating the use of
gtransport->remote in set_head, making the access of the remote's
properties consistent in the function.

Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
---

Notes:
    v2: - new patch

 builtin/fetch.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index fe2b26c74a..3167b055d1 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1617,13 +1617,13 @@ static void report_set_head(const char *remote, const char *head_name,
 	strbuf_release(&buf_prefix);
 }
 
-static int set_head(const struct ref *remote_refs, int follow_remote_head,
-		const char *no_warn_branch)
+static int set_head(const struct ref *remote_refs, struct remote *remote)
 {
 	int result = 0, create_only, is_bare, was_detached;
 	struct strbuf b_head = STRBUF_INIT, b_remote_head = STRBUF_INIT,
 		      b_local_head = STRBUF_INIT;
-	const char *remote = gtransport->remote->name;
+	int follow_remote_head = remote->follow_remote_head;
+	const char *no_warn_branch = remote->no_warn_branch;
 	char *head_name = NULL;
 	struct ref *ref, *matches;
 	struct ref *fetch_map = NULL, **fetch_map_tail = &fetch_map;
@@ -1661,8 +1661,8 @@ static int set_head(const struct ref *remote_refs, int follow_remote_head,
 		strbuf_addstr(&b_head, "HEAD");
 		strbuf_addf(&b_remote_head, "refs/heads/%s", head_name);
 	} else {
-		strbuf_addf(&b_head, "refs/remotes/%s/HEAD", remote);
-		strbuf_addf(&b_remote_head, "refs/remotes/%s/%s", remote, head_name);
+		strbuf_addf(&b_head, "refs/remotes/%s/HEAD", remote->name);
+		strbuf_addf(&b_remote_head, "refs/remotes/%s/%s", remote->name, head_name);
 	}
 		/* make sure it's valid */
 	if (!is_bare && !refs_ref_exists(refs, b_remote_head.buf)) {
@@ -1678,7 +1678,7 @@ static int set_head(const struct ref *remote_refs, int follow_remote_head,
 	if (verbosity >= 0 &&
 		follow_remote_head == FOLLOW_REMOTE_WARN &&
 		(!no_warn_branch || strcmp(no_warn_branch, head_name)))
-		report_set_head(remote, head_name, &b_local_head, was_detached);
+		report_set_head(remote->name, head_name, &b_local_head, was_detached);
 
 cleanup:
 	free(head_name);
@@ -1924,8 +1924,7 @@ static int do_fetch(struct transport *transport,
 				  "you need to specify exactly one branch with the --set-upstream option"));
 		}
 	}
-	if (set_head(remote_refs, transport->remote->follow_remote_head,
-		transport->remote->no_warn_branch))
+	if (set_head(remote_refs, transport->remote))
 		;
 		/*
 		 * Way too many cases where this can go wrong
-- 
2.48.1.93.g276f59c085

