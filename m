Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43778496D2A
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 12:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791461264; cv=none; b=IuolLWhpLJyZxQ5Wxql2FUGBZbVhonGi1qeQ6id/wrk1jvHNmL2OK+6KRzm18gzYalyks5yzTwuuUeCQiJcaEILgL08atX4Q4e5HyLYl/TdgGI5BGRjDEYn2B8zSCR2oYmSRvdAU/Yp9XVgtQPXU7ac+bUeYA6p2n7LcJyKV6rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791461264; c=relaxed/simple;
	bh=A8/IZMZDe9zwoSuV66UbhceKjgs6kufga0Da1DHwaiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CBElhA/ywSZSDqxkuEyQq/zfQmnHzXzDo9Urv1ns7XZED8ZR9VVvmt1b2kGry0kycz8W9x3xgW791TRBM834ZUJ8/rqQhrg+o0QpdPuZjRgg5bo184xGY7mNgKY4nNtTcrkPxMH0/slXGAbe0djV29Hc4tX3iywpaBtiX1WLzi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=BMmDa06B; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="BMmDa06B"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1791461253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XQ9VmF9P5fb3JGQ2PYfIfMx0r1ir4y/Qo1pCyhtK77Y=;
	b=BMmDa06BK1ajEPWsWiiHcHv3wNcrPidz4T26bTLoUiTpGaPaTtcbHl9pXE6DQoSqZ86ZrR
	9rXZn8gkBbiMDcJl0kaYHZpzxP5OylX74J9e1iM/yMQ/CGGXensxFSYbiqJKlbHRCnOKoS
	7R44uWJeylHZtD10DZnZ32Pb3UQofjS2NhNnxllv8Kxtcwh+vBMXM+WnTZn3ZXhrZDFjI1
	7ZabdLIbK/g+U9UTvSLgm7b4XS3QIID57S84oaBTCQezPHqTJLFyEBt8Xtp/yQXmZnRUfm
	rlNtItoLVQMeceL5btX8+1csxQV0s1BvrNpXb962i5jjhFcQzP61wncLZb4dMw==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: [RFC PATCH 5/6] unpack-trees: teach check_ok_to_remove() precious
Date: Thu,  8 Oct 2026 14:07:01 +0200
Message-ID: <ae61067e7b835a6dd65f9047a19bb93f3f82f746.1791460418.git.mroik@delayed.space>
In-Reply-To: <cover.1791460418.git.mroik@delayed.space>
References: <cover.1791460418.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3018; i=mroik@delayed.space; h=from:subject:message-id; bh=A8/IZMZDe9zwoSuV66UbhceKjgs6kufga0Da1DHwaiA=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBqx4didFKGami8W91FUcsE0ttPNIFQQ5QHJMkmP NTAoChJHtWJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCaseHYgAKCRBIeX6hnBm+ 0RnRD/wOd12LEfb0dTzsHwXv6fzo6QwFbvQ2rEQ6sttgqB89A+SrLghbSaiil/IzTgJ0cLp/ctL Dl6XZvgrTQEUwznz2hOfUS+N8LpuLK3/ifw809ZO/n+7XhNVgFHJE5hPw40ohU8upfaBjDtE6LM oeCgQbCktxOZRQwyxqMIiLHSgxIwGseEWKNykU3ykvsPcUZHQRKkLsR0DB5CXUx7xzQhvMx6NTG Uu54xtjyXwLCg/SLhDE5PbvAMJbelApx22VQcsKeO/x6zkR9my4SndttwB0I6tX/r7aSz4a0955 U37mhkXyfwKHGKhtk/g8ipS5MlLBYJJtH3m1dDm5F0HMUm1lICyNPs011oZMy5PiATfVIT13A+k paEogdy6MmjkZm/CS7VVV5U+Fy7pz9EhXTl8C34ykW1q9Jzp2V4yc8Gm9YVUY7M+QvFSucfwJ23 m6vyuMJxxTXq/wWf1WITrO5dm15lQDQu+IzPfFDBwrss0YAgeweibKPegtt+MWXfMcnf03XrFJR 1h2YaHu1dxgb2Ae0cD1xAa7QlCfdYRb5MKQovbkKcTpDFA09JQ1e+eDfJOSgRASUSYjUalIOEIi C2qkG8jnUnOEExfWUoDb5/lI/WWHPlqYHD6f4EKcWTccnKGAPFSo/69Wc7jse65Ehbf3VXB+vUN jg5JvRinL
 g4ZTDQ==
X-Developer-Key: i=mroik@delayed.space; a=openpgp; fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -----

"git switch" and "git checkout" only clobber local changes when these
paths are marked as excluded. With the introduction of precious files we
want to make sure that the underlying machinery understands the
difference between a trashable and a precious file (which are both
excluded/ignored).

Teach check_ok_to_remove() to only target trashable files for clobbering
instead of targeting excluded files.

Signed-off-by: Mirko Faina <mroik@delayed.space>
---
  This is missing some tests for clobbering, but I wasn't sure where to place
  them.

 dir.c          | 19 ++++++++++++++++++-
 dir.h          |  4 ++++
 unpack-trees.c |  7 ++++---
 3 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/dir.c b/dir.c
index 9aba1716a6..ffc1818533 100644
--- a/dir.c
+++ b/dir.c
@@ -1861,7 +1861,24 @@ struct path_pattern *last_matching_pattern(struct dir_struct *dir,
 
 /*
  * Loads the exclude lists for the directory containing pathname, then
- * scans all exclude lists to determine whether pathname is excluded.
+ * scans all exclude lists to determine whether pathname is trashable.
+ * Returns 1 if true, otherwise 0.
+ */
+int is_trashable(struct dir_struct *dir, struct index_state *istate,
+		const char *pathname, int *dtype_p)
+{
+	struct path_pattern *pattern =
+		last_matching_pattern(dir, istate, pathname, dtype_p);
+	if (pattern)
+		return pattern->flags &
+		       (PATTERN_FLAG_NEGATIVE | PATTERN_FLAG_PRECIOUS) ? 0 : 1;
+	return 0;
+}
+
+/*
+ * Loads the exclude lists for the directory containing pathname, then
+ * scans all exclude lists to determine whether pathname is excluded (both
+ * trashable and precious).
  * Returns 1 if true, otherwise 0.
  */
 int is_excluded(struct dir_struct *dir, struct index_state *istate,
diff --git a/dir.h b/dir.h
index a6977149b8..5424036e4e 100644
--- a/dir.h
+++ b/dir.h
@@ -442,6 +442,10 @@ struct path_pattern *last_matching_pattern(struct dir_struct *dir,
 					   struct index_state *istate,
 					   const char *name, int *dtype);
 
+int is_trashable(struct dir_struct *dir,
+		struct index_state *istate,
+		const char *name, int *dtype);
+
 int is_excluded(struct dir_struct *dir,
 		struct index_state *istate,
 		const char *name, int *dtype);
diff --git a/unpack-trees.c b/unpack-trees.c
index 1802809ad3..632fefd260 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -2434,11 +2434,12 @@ static int check_ok_to_remove(const char *name, int len, int dtype,
 	if (repo_ignore_case(the_repository) && icase_exists(o, name, len, st))
 		return 0;
 
+	/* Check if trashable */
 	if (o->internal.dir &&
-	    is_excluded(o->internal.dir, o->src_index, name, &dtype))
+	    is_trashable(o->internal.dir, o->src_index, name, &dtype))
 		/*
-		 * ce->name is explicitly excluded, so it is Ok to
-		 * overwrite it.
+		 * ce->name is explicitly marked as trashable,
+		 * so it is Ok to overwrite it.
 		 */
 		return 0;
 	if (S_ISDIR(st->st_mode)) {
-- 
2.56.0

