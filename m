Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1AA2E8B84
	for <git@vger.kernel.org>; Wed, 24 Dec 2025 17:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766595814; cv=none; b=PscSRwGvoUpscs3U4UACesn6qvXBwQsOzJmQ8sn4TTA+saBAVd0DONYVnIDtcqXMpK3jeE3w/OUh+RxeaBWTG+e1PzutVZx1xQy2aFgrR5je54c3/p48zh3oQOsYQao7Ee9nthtGg8kgXNUj6x4e/+4K/P3GPm4BT+WauUNtpp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766595814; c=relaxed/simple;
	bh=F62nHEpt2GSxySkQUOZpYvhmzGq9hmk7ngvqpynGlw4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pBibv+zlEka+1ryc78Xz+YWheJVPSH3Me+j1nZ9FOZM62RM/ooiaOl70u/wLKMtapRzzdwfdZhDm74+KWq6CA2fN9PbPnCFD2L8U0kc67EBIibe5SnHC5z7avbApVINiV7EI2XhqhxbyVAuqG4DQfPmfMghMnCkoA24uaYx7VX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=LvX65TJk; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="LvX65TJk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1766595809; x=1767200609; i=l.s.r@web.de;
	bh=S6v8KiHaTV0ysupi5rGRAlHcRjiuH3KdYHSBH6LVP0o=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LvX65TJkiVfQImYBOlm1FUVqlsQbHQhKWpOZsvRZsaTGimRTsHMtRmPm5q/VN/i9
	 OZUWssvZMTCmXzpO6BP5hA/ZuRfYHxqafod9eqxEm0phWE7DgH721eVnHe4nCFGTg
	 QPSj7TvR/d/fI3pZ2uz7oDzSWlKhw4O+u8vnwpBcWq69ImyOPUkpO/AvhUQ3urx+U
	 yjgLrCSEnQcTKvOSe/3MNUAH7UNRCaOFQrK5wrnX6vTvKVHxt8mcsq4LtmZ8A76zR
	 SSWSIIXWLttSDgEXaMEofBUyqwpFOSaaC4N+1edUKz89c6M5gl7p7uVWYm7EilmNl
	 4WE5HMBr8Z6e4CTVMg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from Mini-von-Rene.speedport.ip ([79.203.30.2]) by smtp.web.de
 (mrweb005 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MKuOP-1vDt7N3iFJ-00K4Q2 for <git@vger.kernel.org>; Wed, 24 Dec 2025 18:03:28
 +0100
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH 05/14] remote: use commit_stack for local_commits
Date: Wed, 24 Dec 2025 18:03:18 +0100
Message-ID: <20251224170327.68049-6-l.s.r@web.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224170327.68049-1-l.s.r@web.de>
References: <20251224170327.68049-1-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6Bi7heCuVBNST1qvsQ0NbSxTRNurPBhr69n2YYoQxHyMu6YOmCK
 aCZ5+OcCdMWx0ob2pSTWII/NaEcJnACz3QQL80tiuRDn7at8wBOoKSxzmUF/4vEyh+Cxz1c
 zccGFyoOpiB7Sy820p2g+zss7ddt/GUCIl7QKfzfHp1nxkqlw2e2JBhSPYqCrTVsavqpHzn
 uTFEjQWwSZgcaCAlpl0hA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bfCuV8IrNok=;OICc3fAWXLRk6gL4WhVsafAXQry
 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
 lZyMchh1MXUrKh0bA=

Replace a commit array implementation with commit_stack.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 remote.c | 39 ++++++---------------------------------
 1 file changed, 6 insertions(+), 33 deletions(-)

diff --git a/remote.c b/remote.c
index 59b3715120..af888e3f20 100644
=2D-- a/remote.c
+++ b/remote.c
@@ -2544,36 +2544,9 @@ static int remote_tracking(struct remote *remote, c=
onst char *refname,
 	return 0;
 }
=20
-/*
- * The struct "reflog_commit_array" and related helper functions
- * are used for collecting commits into an array during reflog
- * traversals in "check_and_collect_until()".
- */
-struct reflog_commit_array {
-	struct commit **item;
-	size_t nr, alloc;
-};
-
-#define REFLOG_COMMIT_ARRAY_INIT { 0 }
-
-/* Append a commit to the array. */
-static void append_commit(struct reflog_commit_array *arr,
-			  struct commit *commit)
-{
-	ALLOC_GROW(arr->item, arr->nr + 1, arr->alloc);
-	arr->item[arr->nr++] =3D commit;
-}
-
-/* Free and reset the array. */
-static void free_commit_array(struct reflog_commit_array *arr)
-{
-	FREE_AND_NULL(arr->item);
-	arr->nr =3D arr->alloc =3D 0;
-}
-
 struct check_and_collect_until_cb_data {
 	struct commit *remote_commit;
-	struct reflog_commit_array *local_commits;
+	struct commit_stack *local_commits;
 	timestamp_t remote_reflog_timestamp;
 };
=20
@@ -2605,7 +2578,7 @@ static int check_and_collect_until(const char *refna=
me UNUSED,
 		return 1;
=20
 	if ((commit =3D lookup_commit_reference(the_repository, n_oid)))
-		append_commit(cb->local_commits, commit);
+		commit_stack_push(cb->local_commits, commit);
=20
 	/*
 	 * If the reflog entry timestamp is older than the remote ref's
@@ -2633,7 +2606,7 @@ static int is_reachable_in_reflog(const char *local,=
 const struct ref *remote)
 	struct commit *commit;
 	struct commit **chunk;
 	struct check_and_collect_until_cb_data cb;
-	struct reflog_commit_array arr =3D REFLOG_COMMIT_ARRAY_INIT;
+	struct commit_stack arr =3D COMMIT_STACK_INIT;
 	size_t size =3D 0;
 	int ret =3D 0;
=20
@@ -2664,8 +2637,8 @@ static int is_reachable_in_reflog(const char *local,=
 const struct ref *remote)
 	 * Check if the remote commit is reachable from any
 	 * of the commits in the collected array, in batches.
 	 */
-	for (chunk =3D arr.item; chunk < arr.item + arr.nr; chunk +=3D size) {
-		size =3D arr.item + arr.nr - chunk;
+	for (chunk =3D arr.items; chunk < arr.items + arr.nr; chunk +=3D size) {
+		size =3D arr.items + arr.nr - chunk;
 		if (MERGE_BASES_BATCH_SIZE < size)
 			size =3D MERGE_BASES_BATCH_SIZE;
=20
@@ -2674,7 +2647,7 @@ static int is_reachable_in_reflog(const char *local,=
 const struct ref *remote)
 	}
=20
 cleanup_return:
-	free_commit_array(&arr);
+	commit_stack_clear(&arr);
 	return ret;
 }
=20
=2D-=20
2.52.0

