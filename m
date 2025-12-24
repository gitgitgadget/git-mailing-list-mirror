Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03E82F5311
	for <git@vger.kernel.org>; Wed, 24 Dec 2025 17:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766595816; cv=none; b=p1jKccHOsrWWQlsDtL1QvxNn3ZBIPBz9p4niNEEj3kSW6cOve4Ank11HN8r7HUedj/+PRhVnDMTTI3HOt8hojfZ9XguF8DubZHXC/OrhzAWdlyBLwf89nTrkIYShM+4uz14GSBSIEBq+UZfUddJIz5jQ+/DN4MJaTs9yy6G4KCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766595816; c=relaxed/simple;
	bh=xFEn0AXWN1fk92R5uqZqYmYrqrXfETLRoCfOXgrvmp8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MWdLfPVCFFT5CJwIMWE9W6S57aFt/eKxWl/Q7+dpkOF20zp8TQOpZssk6D/MsQlkBbqMcYDtzcr1Y9qti62bp4A82jCyGT3FE8VSFkE0bCutf0xxfykN9phsI7cY+ZDFUCC6XZ5Buk6UrtTx1VFRVgHNzJWJl5+FbYlvPnwGLUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=X9DVkSvK; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="X9DVkSvK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1766595809; x=1767200609; i=l.s.r@web.de;
	bh=7pk/ZUhbwXIJyfoXoktqxH0FBW376W3fdVHVfQWCWb8=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=X9DVkSvKEgMiLS6bWFEGDXWUVTjbjyccrbrXj99f1Yfl8Tyl89aCvxBTrrKVewmW
	 0eN4osfCZ90E6HamFQtyxFrnkUoeHOPI/0WqdqNE2VZbs0u0i/YfL9vZ5J0nr7tiz
	 FKLSY5NdZVdvBOYIZXaestZH9yGM5oo77UPdsHiVtjeJruU1e8MinyqRf0oHuS8WL
	 CvYnKpAEajGSeF4zSMVT58QHAbyHx9XGxYOiuyJG6uwp3VTZ22H+ZsUERa1uZ8JUK
	 m0bzB+N/qAEtXMvEozW04NVkir/eKMZ6sGB+JA7ih8TUhS+ACi3UX0bScwQLwdwUX
	 zLlePCSK+8WkZVAnFw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from Mini-von-Rene.speedport.ip ([79.203.30.2]) by smtp.web.de
 (mrweb005 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MeUXg-1w6gYn0H5A-00ZWnn for <git@vger.kernel.org>; Wed, 24 Dec 2025 18:03:29
 +0100
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH 07/14] remote: use commit_stack for src_commits
Date: Wed, 24 Dec 2025 18:03:20 +0100
Message-ID: <20251224170327.68049-8-l.s.r@web.de>
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
X-Provags-ID: V03:K1:bYxtYzmTHxnkmkGN2AiuP2gnr9C3N8GSr1ouAhoSAXZMA5v6BHy
 09VnVmMI1oD9XWfDmE7E2Nt5UFrUHl6FhHyVPGTn9NaR33h2wakUCoUIZWUR/pII9qsYHPY
 cNk9kyrzq3oMfkeNKN1BVjXRWkyOELR4/qON67llryOhXRNAndczW4WZjEx+zIeO/0EtyCR
 ff8Yy1uDXd1iOhkW5VGOg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Q5U3LhlKvoA=;BO1nmxz5QQL16dzOuAwEUQHHKkE
 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
 wS0KuhlVrgtLizDS0=

Use commit_stack instead of open-coding it.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 remote.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/remote.c b/remote.c
index ffea887c70..b756ff6f15 100644
=2D-- a/remote.c
+++ b/remote.c
@@ -1443,9 +1443,7 @@ static void add_missing_tags(struct ref *src, struct=
 ref **dst, struct ref ***ds
 	if (sent_tips.nr) {
 		const int reachable_flag =3D 1;
 		struct commit_list *found_commits;
-		struct commit **src_commits;
-		size_t nr_src_commits =3D 0, alloc_src_commits =3D 16;
-		ALLOC_ARRAY(src_commits, alloc_src_commits);
+		struct commit_stack src_commits =3D COMMIT_STACK_INIT;
=20
 		for_each_string_list_item(item, &src_tag) {
 			struct ref *ref =3D item->util;
@@ -1460,13 +1458,13 @@ static void add_missing_tags(struct ref *src, stru=
ct ref **dst, struct ref ***ds
 				/* not pushing a commit, which is not an error */
 				continue;
=20
-			ALLOC_GROW(src_commits, nr_src_commits + 1, alloc_src_commits);
-			src_commits[nr_src_commits++] =3D commit;
+			commit_stack_push(&src_commits, commit);
 		}
=20
 		found_commits =3D get_reachable_subset(sent_tips.items,
 						     sent_tips.nr,
-						     src_commits, nr_src_commits,
+						     src_commits.items,
+						     src_commits.nr,
 						     reachable_flag);
=20
 		for_each_string_list_item(item, &src_tag) {
@@ -1496,8 +1494,9 @@ static void add_missing_tags(struct ref *src, struct=
 ref **dst, struct ref ***ds
 			dst_ref->peer_ref =3D copy_ref(ref);
 		}
=20
-		clear_commit_marks_many(nr_src_commits, src_commits, reachable_flag);
-		free(src_commits);
+		clear_commit_marks_many(src_commits.nr, src_commits.items,
+					reachable_flag);
+		commit_stack_clear(&src_commits);
 		free_commit_list(found_commits);
 	}
=20
=2D-=20
2.52.0

