Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AE827B516
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 12:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758543853; cv=none; b=BRl2lsD9rl1MegFWNVxFRIUJsaJX8F+ob4ESR/xOW+KAH3EHvixyjkii2jRWSlrv7+JtNFIzNRhpwkmv1DDri2MSRpdgn05qoQp/+hqCsTVfpqBXxpBpkVmbY9CpuHU3cvKcvolje/VyYi4HjKvmvEnBSVrQet6lLPwXCR5nWGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758543853; c=relaxed/simple;
	bh=EaOhlm9c6kmR0ARoys+cvucGq6UlDfnWhOkRN3BD2Xw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IS1IBrX1HgC0L9LKYElqXvKjZ3WdLs+8oBtMcyJ8djUjURhsiTewrz5J0n9XbtPCWheQ4NcgM65J+txRgFUMGlm+jI8gwBrT0LzTtBN4dNgIbLaR2z981hM393R3n+WvTPD9/ubiiJmWtqIp8vOGKnH3BpbUKAfqBs2/QKWhBBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=3wh4On8n; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="3wh4On8n"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1758543846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xfzePm4eLD80d199GOb6aLnBa66c1sk1zOhX0SgsQz0=;
	b=3wh4On8nwXmol6tG722hLWx0e11CASH77tAwvy7p7ztCwMf5SEcUFXAt0zt+04NbVRj/SW
	IXJKahp6ZhqO/yK8IzreSpVSE2iKDx3beJAvKc834+MN79htmvQzsNUOPUoLagvfav62Tc
	i4v1KP/pPVXlVtaLw8OBuQhOp7ZM0Zs=
From: Toon Claes <toon@iotcl.com>
To: peff@peff.net,
	git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH 4/4] refs: do not clobber dangling symrefs
Date: Mon, 22 Sep 2025 14:23:32 +0200
Message-ID: <20250922122332.584428-1-toon@iotcl.com>
In-Reply-To: <20250819192934.GD1059295@coredump.intra.peff.net>
References: <20250819192934.GD1059295@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Peff,

At $DAYJOB we hit into an edge-case where this patch breaks our expectancies.

We use `update FOO_HEAD 000...000 000..000` to delete a symref, if that symref
is dangling (otherwise the old oid would have resolved to something). I've
attached a patch that would allow this (on top of your patches). Do you think it
makes sense to allow this scenario?

--
Cheers,
Toon


--- >8 ---
Subject: [PATCH] refs: allow deleting dangling symrefs by updating to zero oid

In 450fc2bace (refs: do not clobber dangling symrefs, 2025-08-19) we
changed how dangling symrefs are dealt with. This guards us from
creating a symref, while it already exists.

But this breaks behavior when you want to delete such dangling symref.
When you're aware your symref is dangling, you know the old oid resolves
to the null oid, and thus you can pass that together with the null oid
the new oid to delete the symref. Thus when the new oid is the null oid,
continue the ref update as before the change mentioned earlier.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 refs/files-backend.c    | 2 +-
 refs/reftable-backend.c | 2 +-
 t/t1400-update-ref.sh   | 9 +++++++++
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 1b3bf26add..5e46d3a110 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2537,7 +2537,7 @@ static enum ref_transaction_error check_old_oid(struct ref_update *update,
 		 * that case to preserve the dangling symref.
 		 */
 		if ((update->flags & REF_NO_DEREF) && referent->len &&
-		    is_null_oid(oid)) {
+		    is_null_oid(oid) && !is_null_oid(&update->new_oid)) {
 			strbuf_addf(err, "cannot lock ref '%s': "
 				    "dangling symref already exists",
 				    ref_update_original_update_refname(update));
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 9e889da2ff..ed505f6054 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1294,7 +1294,7 @@ static enum ref_transaction_error prepare_single_update(struct reftable_ref_stor
 			 */
 			if ((u->flags & REF_NO_DEREF) &&
 			    referent->len &&
-			    is_null_oid(&u->old_oid)) {
+			    is_null_oid(&u->old_oid) && !is_null_oid(&u->new_oid)) {
 				strbuf_addf(err, _("cannot lock ref '%s': "
 					    "dangling symref already exists"),
 					    ref_update_original_update_refname(u));
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index b7415ec9d5..85cd9da0af 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -2389,4 +2389,13 @@ test_expect_success 'dangling symref overwritten without old oid' '
 	test_must_fail git rev-parse --verify refs/heads/does-not-exist
 '

+test_expect_success 'dangling symref delete with old oid zero' '
+	test_when_finished "git update-ref -d refs/heads/dangling" &&
+	git symbolic-ref refs/heads/dangling refs/heads/does-not-exist &&
+	echo "update refs/heads/dangling $Z $Z" >stdin &&
+	git update-ref --no-deref --stdin <stdin &&
+	test_must_fail git rev-parse --verify refs/heads/dangling &&
+	test_must_fail git rev-parse --verify refs/heads/does-not-exist
+'
+
 test_done
--
2.51.0
