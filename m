Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7172F290A
	for <git@vger.kernel.org>; Wed, 24 Dec 2025 17:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766595816; cv=none; b=acYonRX5Mihr5Q+bQCHROXdRq/S893m3+S77w+0SwTm75WhJ4Wlnd2jAIS+SHxtvHkGwq3iDtF5CAtNpMK8pvMQ6YmxO1q6VlPbXVAkzfLrYrzpomlIebFSdSclrLCtJghaB6uJGKsf3HMF4NEJSxjcLGGtHIrwI1sWkQy+/iBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766595816; c=relaxed/simple;
	bh=2K9wO268HzdGjBcZHaGxEemOWzfS4tNPBAn61Zg6VR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IUqta7b9UUNIrEWW8u/VXbFPgN5T0HwMiWrS2mHFCO3uy4vSIFyw0LzUOdEsbBGlCetuM0uyS3g8go/9oHVVdIPRffZhgKvYV3Wu+Hr/Yyh3Nws6JnrEA/M66enZ1Om1ZIpjOk6Q9z4ujwvgaaE193YfeUEkErX9cgpXWwAj/y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=tWObGqt3; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="tWObGqt3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1766595809; x=1767200609; i=l.s.r@web.de;
	bh=UoSq2YQkGRljHq0VjNvC4hvpr55YHk5xDu9avMCXtZQ=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=tWObGqt36i6UeHQkmYM4FEv39x+jIOH/tM4kFHFC7CoG/ZzKeG+lBSgCaoVEVzyi
	 RgWBXH4YYrJplTytp8s5XEXrDcf18tmYyaWPV6cy+9vgG0huGd3vB2vuJqt10zpnI
	 BS5cJiPzfed4NYUQNX1h5dJucgUi0o9mbbn2bqt+Lw/EL5u5K076eu0sVKBnlZz8x
	 hfcu3vHisGY8HA0hFEAGqL4oBl2NKUBImVnx6tSS5WINVITsWgwYBGG59JRwpwunw
	 9h3UTfbII8Sxc2ZPMV38/D6/vEcy+tyBR0fi1Q1eCV0zGvEF6EOCQ936rlSCE61Wn
	 6fHoh7WLhX2Sf77rlA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from Mini-von-Rene.speedport.ip ([79.203.30.2]) by smtp.web.de
 (mrweb005 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1N14pS-1vxR8N1poA-013ogj; Wed, 24 Dec 2025 18:03:29 +0100
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Cc: Rene Scharfe <l.s.r@web.de>
Subject: [PATCH 11/14] shallow: use commit_stack
Date: Wed, 24 Dec 2025 18:03:24 +0100
Message-ID: <20251224170327.68049-12-l.s.r@web.de>
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
X-Provags-ID: V03:K1:QiSINOP3YWTozf5cQxhwjWL8BhWR1Zi+A1cJqq7z0KpQekiPLrN
 NhhelhWQVTtTd7lYE0l+MdQN9uICURZgZxLQNm49ZkfmHSpVqCeH3CQWvVsmDysIcp5Su2y
 TqG4zwH2eqauwK0RbZotePq+mifqfq6yr0x5ZecnGvvuxsqM1qfYser4fUWHVhztPEwvGiu
 B6JihbR0AqA5PwA637lYQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:e7nXf5kErbA=;7wu9k+pQIm+ecomxESzxwUDrc5b
 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

From: Rene Scharfe <l.s.r@web.de>

Replace a commit array implementation with commit_stack.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 shallow.c | 44 +++++++++++++++++---------------------------
 shallow.h |  4 ++--
 2 files changed, 19 insertions(+), 29 deletions(-)

diff --git a/shallow.c b/shallow.c
index 186e9178f3..c870efcefc 100644
=2D-- a/shallow.c
+++ b/shallow.c
@@ -471,6 +471,7 @@ void prepare_shallow_info(struct shallow_info *info, s=
truct oid_array *sa)
 {
 	trace_printf_key(&trace_shallow, "shallow: prepare_shallow_info\n");
 	memset(info, 0, sizeof(*info));
+	commit_stack_init(&info->commits);
 	info->shallow =3D sa;
 	if (!sa)
 		return;
@@ -503,6 +504,7 @@ void clear_shallow_info(struct shallow_info *info)
 	free(info->shallow_ref);
 	free(info->ours);
 	free(info->theirs);
+	commit_stack_clear(&info->commits);
 }
=20
 /* Step 4, remove non-existent ones in "theirs" after getting the pack */
@@ -733,19 +735,13 @@ void assign_shallow_commits_to_refs(struct shallow_i=
nfo *info,
 	free(shallow);
 }
=20
-struct commit_array {
-	struct commit **commits;
-	size_t nr, alloc;
-};
-
 static int add_ref(const struct reference *ref, void *cb_data)
 {
-	struct commit_array *ca =3D cb_data;
-	ALLOC_GROW(ca->commits, ca->nr + 1, ca->alloc);
-	ca->commits[ca->nr] =3D lookup_commit_reference_gently(the_repository,
-							     ref->oid, 1);
-	if (ca->commits[ca->nr])
-		ca->nr++;
+	struct commit_stack *cs =3D cb_data;
+	struct commit *commit =3D lookup_commit_reference_gently(the_repository,
+							       ref->oid, 1);
+	if (commit)
+		commit_stack_push(cs, commit);
 	return 0;
 }
=20
@@ -770,7 +766,7 @@ static void post_assign_shallow(struct shallow_info *i=
nfo,
 	uint32_t **bitmap;
 	size_t dst, i, j;
 	size_t bitmap_nr =3D DIV_ROUND_UP(info->ref->nr, 32);
-	struct commit_array ca;
+	struct commit_stack cs =3D COMMIT_STACK_INIT;
=20
 	trace_printf_key(&trace_shallow, "shallow: post_assign_shallow\n");
 	if (ref_status)
@@ -793,9 +789,8 @@ static void post_assign_shallow(struct shallow_info *i=
nfo,
 	}
 	info->nr_theirs =3D dst;
=20
-	memset(&ca, 0, sizeof(ca));
-	refs_head_ref(get_main_ref_store(the_repository), add_ref, &ca);
-	refs_for_each_ref(get_main_ref_store(the_repository), add_ref, &ca);
+	refs_head_ref(get_main_ref_store(the_repository), add_ref, &cs);
+	refs_for_each_ref(get_main_ref_store(the_repository), add_ref, &cs);
=20
 	/* Remove unreachable shallow commits from "ours" */
 	for (i =3D dst =3D 0; i < info->nr_ours; i++) {
@@ -808,7 +803,7 @@ static void post_assign_shallow(struct shallow_info *i=
nfo,
 		for (j =3D 0; j < bitmap_nr; j++)
 			if (bitmap[0][j]) {
 				/* Step 7, reachability test at commit level */
-				int ret =3D repo_in_merge_bases_many(the_repository, c, ca.nr, ca.com=
mits, 1);
+				int ret =3D repo_in_merge_bases_many(the_repository, c, cs.nr, cs.ite=
ms, 1);
 				if (ret < 0)
 					exit(128);
 				if (!ret) {
@@ -820,7 +815,7 @@ static void post_assign_shallow(struct shallow_info *i=
nfo,
 	}
 	info->nr_ours =3D dst;
=20
-	free(ca.commits);
+	commit_stack_clear(&cs);
 }
=20
 /* (Delayed) step 7, reachability test at commit level */
@@ -830,22 +825,17 @@ int delayed_reachability_test(struct shallow_info *s=
i, int c)
 		struct commit *commit =3D lookup_commit(the_repository,
 						      &si->shallow->oid[c]);
=20
-		if (!si->commits) {
-			struct commit_array ca;
-
-			memset(&ca, 0, sizeof(ca));
+		if (!si->commits.nr) {
 			refs_head_ref(get_main_ref_store(the_repository),
-				      add_ref, &ca);
+				      add_ref, &si->commits);
 			refs_for_each_ref(get_main_ref_store(the_repository),
-					  add_ref, &ca);
-			si->commits =3D ca.commits;
-			si->nr_commits =3D ca.nr;
+					  add_ref, &si->commits);
 		}
=20
 		si->reachable[c] =3D repo_in_merge_bases_many(the_repository,
 							    commit,
-							    si->nr_commits,
-							    si->commits,
+							    si->commits.nr,
+							    si->commits.items,
 							    1);
 		if (si->reachable[c] < 0)
 			exit(128);
diff --git a/shallow.h b/shallow.h
index ad591bd139..1c0787de1d 100644
=2D-- a/shallow.h
+++ b/shallow.h
@@ -1,6 +1,7 @@
 #ifndef SHALLOW_H
 #define SHALLOW_H
=20
+#include "commit.h"
 #include "lockfile.h"
 #include "object.h"
 #include "repository.h"
@@ -69,8 +70,7 @@ struct shallow_info {
 	int *need_reachability_test;
 	int *reachable;
 	int *shallow_ref;
-	struct commit **commits;
-	size_t nr_commits;
+	struct commit_stack commits;
 };
=20
 void prepare_shallow_info(struct shallow_info *, struct oid_array *);
=2D-=20
2.52.0

