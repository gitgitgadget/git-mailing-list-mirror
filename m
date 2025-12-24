Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18D22F0C7E
	for <git@vger.kernel.org>; Wed, 24 Dec 2025 17:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766595817; cv=none; b=X6cY/xCs0MgN/xb0FtcfYsdxxF0iVHH4VqyHM9VJhhbHZB/QmGlIUJmWjHdlAKIYy2+GJP6aUC9pkDjfr8wsdciGVr41mTW7KTEisWMoFm1Fg8dRzZMG45mmk1fSi6DlD5x7adnqIsPHmcrJA8S7Zbh8s4oD41ZHXmD7OPKaHZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766595817; c=relaxed/simple;
	bh=b01w8oLJ+joEsUqB7i+KBPxh3OVSei+TCMMIRS1j/as=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HqVCA4g2JSZgPTFeHo7XCNuH1mvp5lfrZDvja5TVdBq63BcMUVsR4C3f2tNzN3jfvEG81AX5lfQ9GdD4sKl9B+Vr6HDXeJI/8m0Evl2ORpl2kvd1K/Fz1JLCQr6JSubFC654wUFfR/N5jUHvR8M6hPEWBvUtrMy1zsPrVPd/C0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=hvSfuocQ; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="hvSfuocQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1766595809; x=1767200609; i=l.s.r@web.de;
	bh=5oMjJ4VRQM8O06KvJm8J7iHqNcKnQlmizmBL4LaNCBs=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hvSfuocQs3mbXAxM8f/TA5cxS1e4ZZY+Dxb9SSwto4MEukgudHmqTVhEeNNTy51Y
	 5prxVBHcC51OuZG6gMsLHOB4GZ0Lr4DG2SCf1U7zaVlCsAf18KpbIJSn4zmxU/zlE
	 Dfc2pHPWU22SGCTqLWCy2KHZ4XpFGo2LcP3lWkmslO+6dAxYQCm8wOdVjovzVRK3O
	 DLYY1aFcQaA8o9nfmlxTwn3oX2qqPWx7UzY5cYGksPM9wMTH1sAR0SIm7TOBMnvHL
	 lIM+JXMIB15HB+bU5kX9UJrJ/3e6sbMdRqoLXlGL5ERWnn+TkzByF+u7R4XuMWvYs
	 HlOzBrorPni0CYNfsA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from Mini-von-Rene.speedport.ip ([79.203.30.2]) by smtp.web.de
 (mrweb005 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MtPre-1vnUz845zK-00txKn for <git@vger.kernel.org>; Wed, 24 Dec 2025 18:03:29
 +0100
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH 06/14] remote: use commit_stack for sent_tips
Date: Wed, 24 Dec 2025 18:03:19 +0100
Message-ID: <20251224170327.68049-7-l.s.r@web.de>
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
X-Provags-ID: V03:K1:HaVjgwQQ/Wk+nFPvmJXL36uDYCuiw61x0rtzT2jkWm2QW5Ot11a
 SVVrLDcb6vy46BTPL/ud9LCwSN6rT/Dz2YEYsl1kGqtr585H26Lt2ZozSTbX/xU1hzrdNrw
 QTkgYgLMKtSc7i5736qNL3O1xFR2USASXiBDCaABsP4utaCtvy/8NMQtrEWDtPuprEso6c0
 Z0HLmKNZtKzewEXNFWtgQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:n6ALfgsjsvc=;P4z7llF56/Xbpyb/K7AfnsXC06R
 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
 zW9JNtY4IHnJHupQzOU9zwZZuQOLa8EyAzXVKd

Call commit_stack functions instead of effectively open-coding them.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 remote.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/remote.c b/remote.c
index af888e3f20..ffea887c70 100644
=2D-- a/remote.c
+++ b/remote.c
@@ -1381,12 +1381,7 @@ static struct ref **tail_ref(struct ref **head)
 	return tail;
 }
=20
-struct tips {
-	struct commit **tip;
-	size_t nr, alloc;
-};
-
-static void add_to_tips(struct tips *tips, const struct object_id *oid)
+static void add_to_tips(struct commit_stack *tips, const struct object_id=
 *oid)
 {
 	struct commit *commit;
=20
@@ -1396,8 +1391,7 @@ static void add_to_tips(struct tips *tips, const str=
uct object_id *oid)
 	if (!commit || (commit->object.flags & TMP_MARK))
 		return;
 	commit->object.flags |=3D TMP_MARK;
-	ALLOC_GROW(tips->tip, tips->nr + 1, tips->alloc);
-	tips->tip[tips->nr++] =3D commit;
+	commit_stack_push(tips, commit);
 }
=20
 static void add_missing_tags(struct ref *src, struct ref **dst, struct re=
f ***dst_tail)
@@ -1406,13 +1400,12 @@ static void add_missing_tags(struct ref *src, stru=
ct ref **dst, struct ref ***ds
 	struct string_list src_tag =3D STRING_LIST_INIT_NODUP;
 	struct string_list_item *item;
 	struct ref *ref;
-	struct tips sent_tips;
+	struct commit_stack sent_tips =3D COMMIT_STACK_INIT;
=20
 	/*
 	 * Collect everything we know they would have at the end of
 	 * this push, and collect all tags they have.
 	 */
-	memset(&sent_tips, 0, sizeof(sent_tips));
 	for (ref =3D *dst; ref; ref =3D ref->next) {
 		if (ref->peer_ref &&
 		    !is_null_oid(&ref->peer_ref->new_oid))
@@ -1422,7 +1415,7 @@ static void add_missing_tags(struct ref *src, struct=
 ref **dst, struct ref ***ds
 		if (starts_with(ref->name, "refs/tags/"))
 			string_list_append(&dst_tag, ref->name);
 	}
-	clear_commit_marks_many(sent_tips.nr, sent_tips.tip, TMP_MARK);
+	clear_commit_marks_many(sent_tips.nr, sent_tips.items, TMP_MARK);
=20
 	string_list_sort(&dst_tag);
=20
@@ -1471,7 +1464,8 @@ static void add_missing_tags(struct ref *src, struct=
 ref **dst, struct ref ***ds
 			src_commits[nr_src_commits++] =3D commit;
 		}
=20
-		found_commits =3D get_reachable_subset(sent_tips.tip, sent_tips.nr,
+		found_commits =3D get_reachable_subset(sent_tips.items,
+						     sent_tips.nr,
 						     src_commits, nr_src_commits,
 						     reachable_flag);
=20
@@ -1508,7 +1502,7 @@ static void add_missing_tags(struct ref *src, struct=
 ref **dst, struct ref ***ds
 	}
=20
 	string_list_clear(&src_tag, 0);
-	free(sent_tips.tip);
+	commit_stack_clear(&sent_tips);
 }
=20
 struct ref *find_ref_by_name(const struct ref *list, const char *name)
=2D-=20
2.52.0

